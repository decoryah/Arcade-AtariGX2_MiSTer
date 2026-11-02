// Atari GX2 playfield / alphanumerics renderer, palette and mixer.
//
// Reference: MAME 0.289 atarigx2_v.cpp (get_alpha_tile_info, get_playfield_tile_info, atarigx2_playfield_scan,
// scanline_update, screen_update), atarigx2.cpp (pflayout / pftoplayout, blend_gfx, IRGB_1555 palette of 2048).
// Structure from the Primal Rage core's atarigt_video.sv (MiSTer-devel/Arcade-PrimalRage_MiSTer, Nortido, GPL-3):
// the GT board has the same tilemap engine (scroll table in alpha RAM, 128 x 64 playfield of 8 x 8 6 bpp tiles,
// 64 x 32 alpha map), the same raster and the same RLE objects. GX2 drops the GT colour RAM / MRAM mixer for a
// plain 2048-entry IRGB_1555 palette and MAME's three-layer rule:
//   playfield (priority (colour bank >> 2) & 7 for the whole line), then an object pixel wherever it is
//   non-zero and its priority >= the playfield's, then the alpha layer (pen 0 transparent unless the tile's
//   opaque bit 15 is set: TILE_FORCE_LAYER0).
//
// Two related clocks: clk = clk_sys (85.909 MHz) runs timing, the renderer, the line buffers, the mixer and
// port B of the VRAM / palette; clk_cpu = clk_sys/2 (phase aligned) runs the CPU ports (1-clock reads).
//
// Pixel pipeline: the pixel sampled at ce_pix edge k (line-buffer and frame-buffer reads) is picked at k+1
// (palette address registered; the palette's port B answers a clock later) and leaves r/g/b at k+2; blank and
// sync are delayed three ce_pix to match.

module gx2_video (
	input               clk,
	input               clk_cpu,
	input               reset,

	input        [10:0] pf_base,       // MAME m_playfield_base: Space Lords 0x000, Moto Frenzy 0x400

	output              ce_pix,
	output              hblank,
	output              vblank,
	output              hsync,
	output              vsync,
	output       [8:0]  hcnt,
	output       [8:0]  vcnt,
	output              vblank_rise,

	// CPU port to VRAM (D70000-D7FFFF, 32K x 16, byte lanes)
	input        [15:1] vram_addr,
	input        [15:0] vram_din,
	input        [1:0]  vram_we,
	output       [15:0] vram_dout,

	// CPU port to the palette (D40000-D40FFF, 2K x 16)
	input        [11:1] pal_addr,
	input        [15:0] pal_din,
	input        [1:0]  pal_we,
	output       [15:0] pal_dout,

	// tile / alpha ROM port (sdram toggle protocol)
	output       [24:1] rom_addr,
	output              rom_req,
	input               rom_ack,
	input        [15:0] rom_dout,

	// MO frame buffer read (rle_objects, 1 cycle read latency)
	output       [8:0]  fb_rd_x,
	output       [7:0]  fb_rd_y,
	input        [15:0] fb_rd_data,

	output       [7:0]  r,
	output       [7:0]  g,
	output       [7:0]  b
);

	// ------------------------------------------------------------------
	// Video timing: 456 x 262 at 7.159 MHz, visible 336 x 240 (MAME set_raw)
	// ------------------------------------------------------------------
	localparam H_VIS  = 336;
	localparam H_FP   = 8;
	localparam H_SYNC = 40;
	localparam H_TOT  = 456;

	localparam V_VIS  = 240;
	localparam V_FP   = 1;
	localparam V_SYNC = 3;
	localparam V_TOT  = 262;

	reg [3:0] pix_div;
	assign ce_pix = (pix_div == 4'd11);

	always @(posedge clk) begin
		if (reset) pix_div <= 4'd0;
		else       pix_div <= (pix_div == 4'd11) ? 4'd0 : pix_div + 4'd1;
	end

	reg [8:0] hcnt_raw, vcnt_raw;
	wire line_end = (hcnt_raw == H_TOT-1);

	always @(posedge clk) begin
		if (reset) begin
			hcnt_raw <= 9'd0;
			vcnt_raw <= 9'd0;
		end else if (ce_pix) begin
			if (line_end) begin
				hcnt_raw <= 9'd0;
				vcnt_raw <= (vcnt_raw == V_TOT-1) ? 9'd0 : vcnt_raw + 9'd1;
			end else begin
				hcnt_raw <= hcnt_raw + 9'd1;
			end
		end
	end

	wire hblank_raw = (hcnt_raw >= H_VIS);
	wire vblank_raw = (vcnt_raw >= V_VIS);
	wire hsync_raw  =  (hcnt_raw >= H_VIS+H_FP) && (hcnt_raw < H_VIS+H_FP+H_SYNC);    // active high
	wire vsync_raw  =  (vcnt_raw >= V_VIS+V_FP) && (vcnt_raw < V_VIS+V_FP+V_SYNC);

	reg vblank_d;
	always @(posedge clk) begin
		if (reset) vblank_d <= 1'b0;
		else if (ce_pix) vblank_d <= vblank_raw;
	end
	assign vblank_rise = ce_pix & vblank_raw & ~vblank_d;

	assign hcnt = hcnt_raw;
	assign vcnt = vcnt_raw;

	reg [2:0] hblank_s, vblank_s, hsync_s, vsync_s;
	always @(posedge clk) begin
		if (ce_pix) begin
			hblank_s <= {hblank_s[1:0], hblank_raw};
			vblank_s <= {vblank_s[1:0], vblank_raw};
			hsync_s  <= {hsync_s[1:0],  hsync_raw};
			vsync_s  <= {vsync_s[1:0],  vsync_raw};
		end
	end

	assign hblank = hblank_s[2];
	assign vblank = vblank_s[2];
	assign hsync  = hsync_s[2];
	assign vsync  = vsync_s[2];

	// ------------------------------------------------------------------
	// VRAM: 32K x 16, port A CPU (byte enables), port B renderer (read only).
	// Each byte lane is a real true dual-port M10K (tdp_ram): Quartus 17
	// duplicates an inferred array that has two readers.
	// ------------------------------------------------------------------
	reg  [15:1] vram2_addr_c;
	wire [7:0]  vram_lo_qa, vram_hi_qa, vram_lo_qb, vram_hi_qb;

	tdp_ram #(.AW(15), .DW(8)) u_vram_lo (
		.clk_a(clk_cpu), .clk_b(clk),
		.addr_a(vram_addr), .din_a(vram_din[7:0]), .we_a(vram_we[0]), .q_a(vram_lo_qa),
		.addr_b(vram2_addr_c), .din_b(8'h00), .we_b(1'b0), .q_b(vram_lo_qb)
	);
	tdp_ram #(.AW(15), .DW(8)) u_vram_hi (
		.clk_a(clk_cpu), .clk_b(clk),
		.addr_a(vram_addr), .din_a(vram_din[15:8]), .we_a(vram_we[1]), .q_a(vram_hi_qa),
		.addr_b(vram2_addr_c), .din_b(8'h00), .we_b(1'b0), .q_b(vram_hi_qb)
	);

	assign vram_dout = {vram_hi_qa, vram_lo_qa};
	wire [15:0] vram2_dout = {vram_hi_qb, vram_lo_qb};

	// ------------------------------------------------------------------
	// Palette: 2048 x 16 IRGB_1555, port A CPU, port B mixer
	// ------------------------------------------------------------------
	reg  [10:0] pal2_addr_c;
	wire [7:0]  pal_lo_qa, pal_hi_qa, pal_lo_qb, pal_hi_qb;

	tdp_ram #(.AW(11), .DW(8)) u_pal_lo (
		.clk_a(clk_cpu), .clk_b(clk),
		.addr_a(pal_addr), .din_a(pal_din[7:0]), .we_a(pal_we[0]), .q_a(pal_lo_qa),
		.addr_b(pal2_addr_c), .din_b(8'h00), .we_b(1'b0), .q_b(pal_lo_qb)
	);
	tdp_ram #(.AW(11), .DW(8)) u_pal_hi (
		.clk_a(clk_cpu), .clk_b(clk),
		.addr_a(pal_addr), .din_a(pal_din[15:8]), .we_a(pal_we[1]), .q_a(pal_hi_qa),
		.addr_b(pal2_addr_c), .din_b(8'h00), .we_b(1'b0), .q_b(pal_hi_qb)
	);

	assign pal_dout = {pal_hi_qa, pal_lo_qa};
	wire [15:0] pal2_dout = {pal_hi_qb, pal_lo_qb};

	// ------------------------------------------------------------------
	// Line buffers, two of each ping-ponged per line:
	//   pf: the 11-bit palette index
	//   an: {drawn, 8-bit palette index} (drawn = pen != 0 or the tile's opaque bit)
	// ------------------------------------------------------------------
	(* ramstyle = "M10K" *) reg [10:0] pf_buf0 [0:335];
	(* ramstyle = "M10K" *) reg [10:0] pf_buf1 [0:335];
	(* ramstyle = "M10K" *) reg [8:0]  an_buf0 [0:335];
	(* ramstyle = "M10K" *) reg [8:0]  an_buf1 [0:335];

	reg       disp_sel;      // buffer the mixer displays
	reg       fsm_wr_sel;    // buffer the renderer fills
	reg [2:0] pri_line0, pri_line1; // playfield priority of the line in each buffer

	// ------------------------------------------------------------------
	// Playfield scroll state (persists across lines until updated)
	// ------------------------------------------------------------------
	reg [9:0] xscroll;
	reg [8:0] yscroll;
	reg [3:0] tile_bank;
	reg [4:0] color_bank;

	// ------------------------------------------------------------------
	// Renderer: fills the line buffer for target_line, two lines ahead
	// ------------------------------------------------------------------
	localparam S_IDLE          = 5'd0;
	localparam S_SCROLL_XADDR  = 5'd1;
	localparam S_SCROLL_XWAIT  = 5'd2;
	localparam S_SCROLL_YADDR  = 5'd3;
	localparam S_SCROLL_YWAIT  = 5'd4;
	localparam S_PF_MAPADDR    = 5'd5;
	localparam S_PF_MAPWAIT    = 5'd6;
	localparam S_PF_ROM0_WAIT  = 5'd7;
	localparam S_PF_ROM1_WAIT  = 5'd8;
	localparam S_PF_ROM2_WAIT  = 5'd9;
	localparam S_PF_WRITE      = 5'd10;
	localparam S_PF_NEXT       = 5'd11;
	localparam S_AN_MAPADDR    = 5'd12;
	localparam S_AN_MAPWAIT    = 5'd13;
	localparam S_AN_ROM0_WAIT  = 5'd14;
	localparam S_AN_ROM1_WAIT  = 5'd15;
	localparam S_AN_WRITE      = 5'd16;
	localparam S_AN_NEXT       = 5'd17;
	localparam S_DONE          = 5'd18;
	localparam S_PF_ROM0_SET   = 5'd19;
	localparam S_AN_ROM0_SET   = 5'd20;

	reg [4:0] state;
	reg [8:0] target_line;
	reg [5:0] pf_col;   // 0..42
	reg [5:0] an_col;   // 0..41

	// VRAM word bases (byte address - 0xD70000) / 2
	localparam PF_MAP_WBASE   = 15'h1000;   // D72000 playfield
	localparam ALPHA_WBASE    = 15'h3000;   // D76000 alpha (and the scroll table)
	// SDRAM word bases (the MRA image layout, tools/gx2_rom.py): the three playfield thirds (planes 0-1, 2-3,
	// 4-5) at a fixed 0x80000-byte stride (a smaller set is mirrored to fill it: MAME's code % elements) and
	// the alphanumerics
	localparam PF_R0_WBASE    = 24'h0C0000;
	localparam PF_R1_WBASE    = 24'h100000;
	localparam PF_R2_WBASE    = 24'h140000;
	localparam AN_ROM_WBASE   = 24'h180000;

	// scroll table addresses for target_line: offset = ((y & ~7) << 3) + 48 + 2 * (y & 7)
	wire [8:0]  grp           = {target_line[8:3], 3'b000};
	wire [12:0] scroll_x_off  = {grp, 3'b000} + 13'd48 + {8'b0, target_line[2:0], 1'b0};
	wire [12:0] scroll_y_off  = scroll_x_off + 13'd1;
	wire        scroll_in_rng = (scroll_x_off < 13'h800);

	reg [15:0] scroll_x_word;

	wire [8:0] pf_ysum = target_line + yscroll;    // mod 512
	wire [5:0] pf_row  = pf_ysum[8:3];
	wire [2:0] pf_r    = pf_ysum[2:0];

	wire [7:0]  pf_colsum  = {1'b0, xscroll[9:3]} + {2'b0, pf_col};
	wire [6:0]  pf_col_eff = pf_colsum[6:0];
	// atarigx2_playfield_scan: bank = 1 - col / 64; bank * 4096 + row * 64 + col % 64
	wire [12:0] pf_map_idx = {~pf_col_eff[6], pf_row[5:0], pf_col_eff[5:0]};

	wire [5:0]  an_row_raw = target_line[8:3];
	wire [5:0]  an_row     = (an_row_raw > 6'd31) ? 6'd31 : an_row_raw;
	wire [11:0] an_map_idx = {an_row[5:0], an_col[5:0]};

	reg [15:0] pf_tile_word, an_tile_word;
	wire [11:0] pf_code   = pf_tile_word[11:0];
	wire [2:0]  pf_colour = pf_tile_word[14:12];
	wire        pf_flip   = pf_tile_word[15];
	wire [15:0] pf_T      = {tile_bank, pf_code};

	wire [11:0] an_code   = an_tile_word[11:0];
	wire [3:0]  an_colour = an_tile_word[15:12];
	wire        an_opaque = an_tile_word[15];

	// a third holds 2 planes, 16 bytes = 8 words a tile, one word per row; the tile code (16 bits) wraps at
	// 0x40000 words (the 0x80000-byte stride)
	wire [17:0] pf_rom_off   = {pf_T[14:0], pf_r};
	wire [23:0] pf_rom0_addr = PF_R0_WBASE + {6'b0, pf_rom_off};
	wire [23:0] pf_rom1_addr = PF_R1_WBASE + {6'b0, pf_rom_off};
	wire [23:0] pf_rom2_addr = PF_R2_WBASE + {6'b0, pf_rom_off};

	// gfx_8x8x4_packed_msb: 32 bytes a tile, 4 bytes a row
	wire [23:0] an_rom0_addr = AN_ROM_WBASE + {8'b0, an_code, 4'b0000} + {19'b0, target_line[2:0], 1'b0};
	wire [23:0] an_rom1_addr = an_rom0_addr + 24'd1;

	reg [7:0] pf_r0h, pf_r0l, pf_r1h, pf_r1l, pf_r2h, pf_r2l;
	reg [7:0] an_b0, an_b1, an_b2, an_b3;

	reg [24:1] rom_addr_r;
	reg        rom_req_r;
	assign rom_addr = rom_addr_r;
	assign rom_req  = rom_req_r;
	wire       rom_done = (rom_ack == rom_req_r);

	always @(*) begin
		case (state)
			S_SCROLL_XADDR: vram2_addr_c = ALPHA_WBASE + {2'b0, scroll_x_off};
			S_SCROLL_YADDR: vram2_addr_c = ALPHA_WBASE + {2'b0, scroll_y_off};
			S_PF_MAPADDR:   vram2_addr_c = PF_MAP_WBASE + {2'b0, pf_map_idx};
			S_AN_MAPADDR:   vram2_addr_c = ALPHA_WBASE + {3'b0, an_map_idx};
			default:        vram2_addr_c = 15'h0000;
		endcase
	end

	// pflayout (planes 0-3 from thirds 0 and 1, bits 3..0) blended with pftoplayout (thirds 2's two planes,
	// bits 5..4): the same pixel assembly as the GT board's
	function automatic [5:0] pf_pixel_bits;
		input [7:0] r0h, r0l, r1h, r1l, r2h, r2l;
		input [2:0] idx;
		reg   half;
		reg [1:0] j;
		reg [7:0] nib_byte;
		reg [7:0] bit_byte;
		begin
			half = idx[2];
			j    = idx[1:0];
			nib_byte = (j[1] == 1'b0) ? (half ? r1l : r1h) : (half ? r0l : r0h);
			bit_byte = half ? r2l : r2h;
			pf_pixel_bits = { bit_byte[4+j], bit_byte[j],
			                  (j[0] ? nib_byte[3:0] : nib_byte[7:4]) };
		end
	endfunction

	function automatic [3:0] an_pixel_bits;
		input [7:0] b0, b1, b2, b3;
		input [2:0] idx;
		begin
			case (idx)
				3'd0: an_pixel_bits = b0[7:4];
				3'd1: an_pixel_bits = b0[3:0];
				3'd2: an_pixel_bits = b1[7:4];
				3'd3: an_pixel_bits = b1[3:0];
				3'd4: an_pixel_bits = b2[7:4];
				3'd5: an_pixel_bits = b2[3:0];
				3'd6: an_pixel_bits = b3[7:4];
				default: an_pixel_bits = b3[3:0];
			endcase
		end
	endfunction

	reg [2:0]  wk;
	reg [2:0]  src_idx;
	reg [5:0]  pix6;
	reg [3:0]  pix4;
	reg [10:0] pf_val;
	reg signed [10:0] wx;

	always @(posedge clk) begin
		if (reset) begin
			state       <= S_IDLE;
			rom_req_r   <= 1'b0;
			disp_sel    <= 1'b0;
			fsm_wr_sel  <= 1'b1;
			xscroll     <= 10'd0;
			yscroll     <= 9'd0;
			tile_bank   <= 4'd0;
			color_bank  <= 5'd0;
			target_line <= 9'd0;
			pf_col      <= 6'd0;
			an_col      <= 6'd0;
			wk          <= 3'd0;
		end else if (ce_pix && line_end && (state == S_DONE || state == S_IDLE || rom_done)) begin
			// a new pass at every line boundary, never abandoning an outstanding ROM request
			disp_sel    <= ~disp_sel;
			fsm_wr_sel  <= disp_sel;
			// lines 0 and 1 are rendered during lines 260 and 261 (their scroll entries carry the frame's)
			target_line <= (vcnt_raw >= 9'd260) ? vcnt_raw - 9'd260 : vcnt_raw + 9'd2;
			pf_col      <= 6'd0;
			state       <= S_SCROLL_XADDR;
		end else begin
			case (state)
				S_IDLE: ;

				S_SCROLL_XADDR: state <= scroll_in_rng ? S_SCROLL_XWAIT : S_PF_MAPADDR;
				S_SCROLL_XWAIT: begin
					scroll_x_word <= vram2_dout;
					state <= S_SCROLL_YADDR;
				end
				S_SCROLL_YADDR: state <= S_SCROLL_YWAIT;
				S_SCROLL_YWAIT: begin
					if (scroll_x_word[15]) begin
						xscroll    <= scroll_x_word[14:5];
						color_bank <= scroll_x_word[4:0];
					end
					if (vram2_dout[15]) begin
						yscroll   <= (vram2_dout[14:6] - target_line[8:0]) & 9'h1ff;
						tile_bank <= vram2_dout[3:0];
					end
					state <= S_PF_MAPADDR;
				end

				S_PF_MAPADDR: begin
					// the line's playfield priority: (colour bank >> 2) & 7, settled by now
					if (fsm_wr_sel) pri_line1 <= color_bank[4:2];
					else            pri_line0 <= color_bank[4:2];
					state <= S_PF_MAPWAIT;
				end
				S_PF_MAPWAIT: begin
					pf_tile_word <= vram2_dout;
					state <= S_PF_ROM0_SET;
				end
				S_PF_ROM0_SET: begin
					rom_addr_r <= pf_rom0_addr;
					rom_req_r  <= ~rom_req_r;
					state <= S_PF_ROM0_WAIT;
				end
				S_PF_ROM0_WAIT: if (rom_done) begin
					pf_r0h <= rom_dout[15:8];
					pf_r0l <= rom_dout[7:0];
					rom_addr_r <= pf_rom1_addr;
					rom_req_r  <= ~rom_req_r;
					state <= S_PF_ROM1_WAIT;
				end
				S_PF_ROM1_WAIT: if (rom_done) begin
					pf_r1h <= rom_dout[15:8];
					pf_r1l <= rom_dout[7:0];
					rom_addr_r <= pf_rom2_addr;
					rom_req_r  <= ~rom_req_r;
					state <= S_PF_ROM2_WAIT;
				end
				S_PF_ROM2_WAIT: if (rom_done) begin
					pf_r2h <= rom_dout[15:8];
					pf_r2l <= rom_dout[7:0];
					state <= S_PF_WRITE;
				end
				// verilator lint_off BLKSEQ
				S_PF_WRITE: begin
					src_idx = pf_flip ? (3'd7 - wk) : wk;
					pix6 = pf_pixel_bits(pf_r0h, pf_r0l, pf_r1h, pf_r1l, pf_r2h, pf_r2l, src_idx);
					// colour = (pf_base >> 5) + ((bank << 3) & 0x18) + tile colour; pen = colour * 32 + pix6
					// (granularity 32: a 6-bit pen overlaps into the next colour, as MAME's)
					pf_val = pf_base + {1'b0, color_bank[1:0], 8'b0} + {3'b0, pf_colour, 5'b0} + {5'b0, pix6};
					wx = $signed({2'b0, pf_col, 3'b000}) + $signed({8'b0, wk}) - $signed({8'b0, xscroll[2:0]});
					if (wx >= 0 && wx < 336) begin
						if (fsm_wr_sel) pf_buf1[wx[8:0]] <= pf_val;
						else            pf_buf0[wx[8:0]] <= pf_val;
					end
					if (wk == 3'd7) begin
						wk    <= 3'd0;
						state <= S_PF_NEXT;
					end else wk <= wk + 3'd1;
				end
				// verilator lint_on BLKSEQ
				S_PF_NEXT: begin
					if (pf_col == 6'd42) begin
						an_col <= 6'd0;
						state  <= S_AN_MAPADDR;
					end else begin
						pf_col <= pf_col + 6'd1;
						state  <= S_PF_MAPADDR;
					end
				end

				S_AN_MAPADDR: state <= S_AN_MAPWAIT;
				S_AN_MAPWAIT: begin
					an_tile_word <= vram2_dout;
					state <= S_AN_ROM0_SET;
				end
				S_AN_ROM0_SET: begin
					rom_addr_r <= an_rom0_addr;
					rom_req_r  <= ~rom_req_r;
					state <= S_AN_ROM0_WAIT;
				end
				S_AN_ROM0_WAIT: if (rom_done) begin
					an_b0 <= rom_dout[15:8];
					an_b1 <= rom_dout[7:0];
					rom_addr_r <= an_rom1_addr;
					rom_req_r  <= ~rom_req_r;
					state <= S_AN_ROM1_WAIT;
				end
				S_AN_ROM1_WAIT: if (rom_done) begin
					an_b2 <= rom_dout[15:8];
					an_b3 <= rom_dout[7:0];
					state <= S_AN_WRITE;
				end
				// verilator lint_off BLKSEQ
				S_AN_WRITE: begin
					pix4 = an_pixel_bits(an_b0, an_b1, an_b2, an_b3, wk);
					if (fsm_wr_sel) an_buf1[{an_col, 3'b000} + {6'b0, wk}] <= {an_opaque | (pix4 != 4'd0), an_colour, pix4};
					else            an_buf0[{an_col, 3'b000} + {6'b0, wk}] <= {an_opaque | (pix4 != 4'd0), an_colour, pix4};
					if (wk == 3'd7) begin
						wk    <= 3'd0;
						state <= S_AN_NEXT;
					end else wk <= wk + 3'd1;
				end
				// verilator lint_on BLKSEQ
				S_AN_NEXT: begin
					if (an_col == 6'd41) state <= S_DONE;
					else begin
						an_col <= an_col + 6'd1;
						state  <= S_AN_MAPADDR;
					end
				end

				S_DONE: ;

				default: state <= S_IDLE;
			endcase
		end
	end

	// ------------------------------------------------------------------
	// Mixer: line-buffer read, select + layer pick, palette read, expand
	// ------------------------------------------------------------------
	reg [8:0] fb_rd_x_r;
	reg [7:0] fb_rd_y_r;
	assign fb_rd_x = fb_rd_x_r;
	assign fb_rd_y = fb_rd_y_r;

	reg [8:0] disp_rd_idx_r;

	// stage 1: one plain read per buffer (Quartus infers M10K only for `q <= mem[addr]` alone)
	reg [10:0] pf_buf0_q, pf_buf1_q;
	reg [8:0]  an_buf0_q, an_buf1_q;
	reg        disp_sel_d1;
	reg        de_d1;

	always @(posedge clk) pf_buf0_q <= pf_buf0[disp_rd_idx_r];
	always @(posedge clk) pf_buf1_q <= pf_buf1[disp_rd_idx_r];
	always @(posedge clk) an_buf0_q <= an_buf0[disp_rd_idx_r];
	always @(posedge clk) an_buf1_q <= an_buf1[disp_rd_idx_r];

	always @(posedge clk) begin
		if (ce_pix) begin
			fb_rd_x_r     <= hcnt_raw;
			fb_rd_y_r     <= vcnt_raw[7:0];
			disp_rd_idx_r <= hblank_raw ? 9'd0 : hcnt_raw;
			disp_sel_d1   <= disp_sel;
			de_d1         <= ~hblank_raw & ~vblank_raw;
		end
	end

	// stage 2: buffer select and the layer pick (screen_update)
	wire [10:0] pf_s = disp_sel_d1 ? pf_buf1_q : pf_buf0_q;
	wire [8:0]  an_s = disp_sel_d1 ? an_buf1_q : an_buf0_q;
	wire [2:0]  pri  = disp_sel_d1 ? pri_line1 : pri_line0;
	wire        mo_wins = (fb_rd_data != 16'h0000) && (fb_rd_data[15:12] >= {1'b0, pri});

	reg de_s2;
	always @(posedge clk) begin
		if (ce_pix) begin
			pal2_addr_c <= an_s[8] ? {3'b000, an_s[7:0]} : mo_wins ? fb_rd_data[10:0] : pf_s;
			de_s2 <= de_d1;
		end
	end

	// stage 3: the palette's port B reads pal2_addr_c (registered, valid the next clock)
	// stage 4: IRGB_1555 -> 8 bits a channel, MAME's IRRRRRGGGGGBBBBB_decoder: pal6bit({5 bits, I})
	wire       ib = pal2_dout[15];
	wire [5:0] r6 = {pal2_dout[14:10], ib};
	wire [5:0] g6 = {pal2_dout[9:5],   ib};
	wire [5:0] b6 = {pal2_dout[4:0],   ib};

	reg [7:0] r_r, g_r, b_r;
	always @(posedge clk) begin
		if (ce_pix) begin
			if (!de_s2) begin
				r_r <= 8'h00; g_r <= 8'h00; b_r <= 8'h00;
			end else begin
				r_r <= {r6, r6[5:4]};
				g_r <= {g6, g6[5:4]};
				b_r <= {b6, b6[5:4]};
			end
		end
	end

	assign r = r_r;
	assign g = g_r;
	assign b = b_r;

endmodule
