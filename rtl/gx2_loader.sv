// ROM loader: the MRA's index-0 byte stream (the image of tools/gx2_rom.py) into the SDRAM, the 6502's block RAM and
// the DDR3. From the Primal Rage core's rom_loader (MiSTer-devel/Arcade-PrimalRage_MiSTer, Nortido, GPL-3), without
// its debug block: every byte goes into a 256-entry FIFO (ioctl_wait from 32 entries on: the HPS sends a few bytes
// after wait rises), drained into one engine per destination.
//
//   stream 0x000000-0x31FFFF  SDRAM, byte address = stream address (program, OKI1, OKI2, playfield thirds, alpha)
//   stream 0x320000-0x32FFFF  the JSA's 6502 ROM (block RAM)
//   stream 0x330000-...       RLE object ROM -> DDR3 byte 0x30000000 (rle_objects ROM_WORD_BASE), 8 bytes a write
//
// rle_words is the object ROM's length in words, from the stream's length.

module gx2_loader
(
	input             clk,
	input             reset,

	input             ioctl_download,
	input      [15:0] ioctl_index,
	input             ioctl_wr,
	input      [26:0] ioctl_addr,
	input       [7:0] ioctl_dout,
	output            ioctl_wait,

	output reg [24:1] sdram_addr,
	output reg [15:0] sdram_din,
	output reg        sdram_req,
	input             sdram_ack,

	output reg        snd_rom_we,
	output reg [15:0] snd_rom_addr,
	output reg  [7:0] snd_rom_data,

	output reg [28:0] ddr_addr,
	output reg [63:0] ddr_din,
	output reg        ddr_we,
	input             ddr_busy,
	output            ddr_pending,

	output reg [24:0] rle_words
);

localparam [26:0] SND_ROM  = 27'h320000;
localparam [26:0] RLE_ROM  = 27'h330000;

wire download = ioctl_download & (ioctl_index[7:0] == 8'd0);

localparam FIFO_DEPTH = 256;
reg [34:0] fifo_mem [0:FIFO_DEPTH-1];   // {ioctl_addr, ioctl_dout}
reg  [7:0] fifo_wptr, fifo_rptr;
reg  [8:0] fifo_count;
wire fifo_full  = (fifo_count == FIFO_DEPTH);
wire fifo_empty = (fifo_count == 0);
assign ioctl_wait = (fifo_count >= 9'd32);

reg pend_sdram, pend_ddr;
assign ddr_pending = pend_ddr;

reg        pop_pending;
reg [26:0] pop_addr_r;
reg  [7:0] pop_data_r;

wire do_push  = download & ioctl_wr & ~fifo_full;
wire do_issue = ~fifo_empty & ~pend_sdram & ~pend_ddr & ~pop_pending;

reg        hi_valid;
reg  [7:0] hi_byte;
reg [55:0] ddr_acc;

reg download_d;
always @(posedge clk) download_d <= download;
wire download_start = download & ~download_d;

always @(posedge clk) begin
	snd_rom_we <= 1'b0;

	if (reset) begin
		sdram_req   <= 1'b0;
		ddr_we      <= 1'b0;
		pend_sdram  <= 1'b0;
		pend_ddr    <= 1'b0;
		hi_valid    <= 1'b0;
		fifo_wptr   <= 8'd0;
		fifo_rptr   <= 8'd0;
		fifo_count  <= 9'd0;
		pop_pending <= 1'b0;
		rle_words   <= 25'd0;
	end else begin
		if (pend_sdram && (sdram_ack == sdram_req))
			pend_sdram <= 1'b0;

		if (pend_ddr && !ddr_busy) begin
			ddr_we   <= 1'b0;
			pend_ddr <= 1'b0;
		end

		if (do_push) begin
			fifo_mem[fifo_wptr] <= {ioctl_addr, ioctl_dout};
			fifo_wptr <= fifo_wptr + 8'd1;
		end
		fifo_count <= fifo_count + (do_push ? 9'd1 : 9'd0) - (do_issue ? 9'd1 : 9'd0);

		if (pop_pending) begin
			pop_pending <= 1'b0;
			if (pop_addr_r < SND_ROM) begin
				if (!pop_addr_r[0]) begin
					hi_byte  <= pop_data_r;
					hi_valid <= 1'b1;
				end else begin
					sdram_din  <= {hi_byte, pop_data_r};      // the even byte is the high half (68000 order)
					sdram_addr <= pop_addr_r[24:1];
					sdram_req  <= ~sdram_req;
					pend_sdram <= 1'b1;
					hi_valid   <= 1'b0;
				end
			end else if (pop_addr_r < RLE_ROM) begin
				snd_rom_addr <= pop_addr_r[15:0];
				snd_rom_data <= pop_data_r;
				snd_rom_we   <= 1'b1;
			end else begin
				ddr_acc[8*pop_addr_r[2:0] +: 8] <= pop_data_r;
				if (pop_addr_r[2:0] == 3'd7) begin
					ddr_addr <= 29'h06000000 + 29'((pop_addr_r - RLE_ROM) >> 3);
					ddr_din  <= {pop_data_r, ddr_acc[55:0]};
					ddr_we   <= 1'b1;
					pend_ddr <= 1'b1;
				end
				rle_words <= 25'((pop_addr_r - RLE_ROM + 27'd1) >> 1);
			end
		end else if (do_issue) begin
			fifo_rptr   <= fifo_rptr + 8'd1;
			pop_addr_r  <= fifo_mem[fifo_rptr][34:8];
			pop_data_r  <= fifo_mem[fifo_rptr][7:0];
			pop_pending <= 1'b1;
		end

		// a fresh download starts from an empty FIFO
		if (download_start) begin
			fifo_wptr   <= 8'd0;
			fifo_rptr   <= 8'd0;
			fifo_count  <= 9'd0;
			pop_pending <= 1'b0;
			hi_valid    <= 1'b0;
		end
	end
end

endmodule


// ---------------------------------------------------------------------
// DDR3 arbiter: rle_objects > the fast-load replay (staging read) > the loader. The bus changes owner only when the
// current owner has no burst in flight. From the Primal Rage core's ddr_arbiter, without the CAGE master.
// ---------------------------------------------------------------------
module gx2_ddrarb
(
	input clk,
	input reset,

	input        loader_sel,
	input [28:0] loader_addr,
	input [63:0] loader_din,
	input        loader_we,
	output       loader_busy,

	input [28:0] rle_addr,
	input        rle_rd,
	input        rle_wr,
	input  [7:0] rle_burstcnt,
	input [63:0] rle_din,
	input  [7:0] rle_be,
	output [63:0] rle_dout,
	output        rle_dout_ready,
	output        rle_busy,

	input [28:0] stg_addr,
	input        stg_rd,
	output [63:0] stg_dout,
	output        stg_dout_ready,
	output        stg_busy,

	output        DDRAM_CLK,
	input         DDRAM_BUSY,
	output  [7:0] DDRAM_BURSTCNT,
	output [28:0] DDRAM_ADDR,
	input  [63:0] DDRAM_DOUT,
	input         DDRAM_DOUT_READY,
	output        DDRAM_RD,
	output [63:0] DDRAM_DIN,
	output  [7:0] DDRAM_BE,
	output        DDRAM_WE
);

assign DDRAM_CLK = clk;

reg [7:0] rle_words_left;
reg       stg_active;
wire rle_active = (rle_words_left != 0);

wire grant_rle    = rle_active | (~stg_active & (rle_rd | rle_wr));
wire grant_stg    = ~grant_rle & (stg_active | stg_rd);
wire grant_loader = ~grant_rle & ~grant_stg & loader_sel;

wire rle_rd_acc = grant_rle & rle_rd & ~rle_active & ~DDRAM_BUSY;
wire stg_rd_acc = grant_stg & stg_rd & ~stg_active & ~DDRAM_BUSY;

always @(posedge clk) begin
	if (reset) begin
		rle_words_left <= 0;
		stg_active     <= 0;
	end else begin
		if (rle_rd_acc) rle_words_left <= rle_burstcnt;
		else if (DDRAM_DOUT_READY && rle_active) rle_words_left <= rle_words_left - 1'd1;

		if (stg_rd_acc) stg_active <= 1;
		else if (DDRAM_DOUT_READY && stg_active) stg_active <= 0;
	end
end

wire is_write = grant_rle ? rle_wr : grant_stg ? 1'b0 : loader_we;

assign DDRAM_ADDR     = grant_rle ? rle_addr : grant_stg ? stg_addr : loader_addr;
assign DDRAM_DIN      = grant_rle ? rle_din : loader_din;
assign DDRAM_WE       = is_write;
assign DDRAM_RD       = grant_rle ? rle_rd : grant_stg ? stg_rd : 1'b0;
assign DDRAM_BURSTCNT = is_write ? 8'd1 : (grant_rle ? rle_burstcnt : 8'd1);
assign DDRAM_BE       = is_write ? (grant_rle ? rle_be : 8'hff) : 8'hff;

assign loader_busy    = DDRAM_BUSY | ~grant_loader;
assign rle_busy       = DDRAM_BUSY | ~grant_rle;
assign stg_busy       = DDRAM_BUSY | ~grant_stg;

assign rle_dout       = DDRAM_DOUT;
assign rle_dout_ready = DDRAM_DOUT_READY & rle_active;
assign stg_dout       = DDRAM_DOUT;
assign stg_dout_ready = DDRAM_DOUT_READY & stg_active;

endmodule
