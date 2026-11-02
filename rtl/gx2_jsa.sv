// Atari JSA IIIs sound board, from MAME 0.289 atarijsa.cpp (atari_jsa_iii_device / atari_jsa_iiis_device) and
// atariscom.cpp (the sound-comm latches). The 6502 wiring follows the Atari System 1 core's AUDIO.vhd
// (MiSTer-devel/Arcade-Atari-system1_MiSTer, d18c7db, GPL-3): T65 with a clock enable, accesses strobed on it.
//
//   6502 (T65) 1.79 MHz, 8 KB RAM, 64 KB ROM (block RAM, loaded with the image), 4 KB bank at 3000 (the first 16 KB)
//   YM2151 (jt51) 3.58 MHz, its IRQ and a 249.7 Hz timer on the 6502's IRQ; the main CPU's command on its NMI
//   2 x OKI6295 (jt6295) 1.19 MHz, pin 7 from WRIO bit 3; samples from the SDRAM, banked as MAME's oki1lo/hi, oki2lo/hi
//
//   0000-1FFF RAM   2000-27FF YM2151   2800-2FFF I/O (A9, A2..A1, A0 decoded; the rest mirror)   3000-3FFF bank   4000-FFFF ROM
//   read:  2800/1 OKI1/OKI2 status  2802 command (clears the NMI)  2804 RDIO  2806 IRQ ack
//   write: 2800/1 overall volume  2806 IRQ ack  2A00/1 OKI1/OKI2  2A02 response  2A04 WRIO  2A06 MIX
//
// Outputs as MAME's routes: left = YM left * 0.60 + OKI1 * 0.75, right = YM right * 0.60 + OKI2 * 0.75, with the gains
// of update_all_volumes(): YM * MIX[3:1] / 7, OKI * (MIX[0] ? 1 : 0.5) * CT1, both * overall / 127.
`default_nettype none
module gx2_jsa (
	input  wire        clk,              // clk_sys, 85.909 MHz (24 x 3.579545 MHz)
	input  wire        rst,              // core reset
	input  wire        snd_reset,        // the main board's /SNDRES (latch bit 4 low): holds the 6502 in reset

	// main CPU side (clk_cpu = clk / 2, phase aligned): toggles cross, levels are read directly
	input  wire        cmd_tgl,          // toggles on every write of main_command
	input  wire [7:0]  cmd_data,
	input  wire        rsp_rd_tgl,       // toggles on every read of main_response
	output reg  [7:0]  rsp_data,
	output reg         main_to_sound_ready,   // SERVICE bit 5 (/AUDFULL, inverted by the reader)
	output reg         sound_to_main_ready,   // SERVICE bit 4 (/AUDIRQ) and the main CPU's IRQ 5

	input  wire        coin1, coin2, service1, tilt,   // active high

	// 6502 program load (from the loader)
	input  wire        rom_we,
	input  wire [15:0] rom_addr,
	input  wire [7:0]  rom_data,

	// OKI sample bytes from the SDRAM: level request until ack (byte address in the 0x100000-byte sound area:
	// OKI1 at 0x00000, OKI2 at 0x80000)
	output reg         pcm_req,
	output reg  [19:0] pcm_addr,
	input  wire        pcm_ack,
	input  wire [7:0]  pcm_q,

	output reg  signed [15:0] out_l,
	output reg  signed [15:0] out_r
);
	// ------------------------------------------------------------------ clock enables
	reg [5:0] div48;
	reg [4:0] div24;
	reg [6:0] div72;
	reg       ym_half;
	wire cen_cpu = (div48 == 6'd47);
	wire cen_ym  = (div24 == 5'd23);
	wire cen_ym_p1 = cen_ym & ym_half;
	wire cen_oki = (div72 == 7'd71);
	always @(posedge clk) begin
		div48 <= cen_cpu ? 6'd0 : div48 + 6'd1;
		div24 <= cen_ym  ? 5'd0 : div24 + 5'd1;
		div72 <= cen_oki ? 7'd0 : div72 + 7'd1;
		if (cen_ym) ym_half <= ~ym_half;
	end

	// timed interrupt: JSA_MASTER_CLOCK / 4 / 16 / 16 / 14 = 249.7 Hz = 14336 YM clocks
	reg [13:0] tdiv;
	reg        timed_int;
	wire       tick = cen_ym && tdiv == 14'd14335;
	always @(posedge clk) begin
		if (rst) tdiv <= 14'd0;
		else if (cen_ym) tdiv <= (tdiv == 14'd14335) ? 14'd0 : tdiv + 14'd1;
	end

	// ------------------------------------------------------------------ 6502
	wire [23:0] A24;
	wire [15:0] A = A24[15:0];
	wire [7:0]  cpu_do;
	reg  [7:0]  cpu_di;
	wire        rw_n;
	wire        ym_irq_n;
	wire        irq_n = ~(timed_int | ~ym_irq_n);
	wire        nmi_n;

	// the reset changes only on the enable: T65's own reset synchroniser (the one part of it on the full clock) then
	// settles long before the next enable, which keeps AtariGX2.sdc's multicycle over the CPU true
	reg         cpu_res_n;
	always @(posedge clk) if (cen_cpu) cpu_res_n <= ~(rst | snd_reset);

	T65 u_cpu (
		.Mode(2'b00), .BCD_en(1'b1), .Res_n(cpu_res_n), .Clk(clk), .Enable(cen_cpu),
		.A(A24), .DI(cpu_di), .DO(cpu_do), .Rdy(1'b1), .Abort_n(1'b1), .IRQ_n(irq_n), .NMI_n(nmi_n), .SO_n(1'b1),
		.R_W_n(rw_n), .Sync(), .EF(), .MF(), .XF(), .ML_n(), .VP_n(), .VDA(), .VPA(), .NMI_ack()
	);

	// strobes on the enable, as the System 1 core's /RD02, /WR02: the address and data are the cycle's own
	wire rd = cen_cpu & rw_n;
	wire wr = cen_cpu & ~rw_n;

	wire sel_ram  = A[15:13] == 3'b000;           // 0000-1FFF
	wire sel_ym   = A[15:11] == 5'b00100;         // 2000-27FF
	wire sel_io   = A[15:11] == 5'b00101;         // 2800-2FFF
	wire sel_bank = A[15:12] == 4'h3;             // 3000-3FFF
	wire io_w     = A[9];                         // 2A00 group: the write registers
	wire [1:0] io_r = A[2:1];

	// NMI: MAME's 6502 takes one for every command written after the last was read (atari_sound_comm asserts the line on
	// each write, a pending NMI on every assert after a clear). T65 sees an edge only between two of its samples (one an
	// enable, frozen through a branch's offset fetch and through reset), and the main CPU can write the next command within
	// one 6502 cycle of the read: the line went high and low again unseen, the 6502 never read that command and the comm
	// stalled until the game reset the board (the first release's music cutting out). So the line is held high for two
	// samples after each read of 2802 and after reset: a command written meanwhile gets its edge ~1 us late.
	reg  [1:0] nmi_hold;
	always @(posedge clk) begin
		if (rst || !cpu_res_n || (rd && sel_io && !io_w && io_r == 2'd1)) nmi_hold <= 2'd2;
		else if (cen_cpu && nmi_hold != 2'd0) nmi_hold <= nmi_hold - 2'd1;
	end
	assign nmi_n = ~main_to_sound_ready | (nmi_hold != 2'd0);

	// ------------------------------------------------------------------ memories
	(* ramstyle = "M10K" *) reg [7:0] ram [0:8191];
	(* ramstyle = "M10K" *) reg [7:0] rom [0:65535];
	reg [7:0] ram_q, rom_q;
	reg [1:0] cpu_bank;
	wire [15:0] rom_raddr = sel_bank ? {2'b00, cpu_bank, A[11:0]} : A;
	always @(posedge clk) if (wr && sel_ram) ram[A[12:0]] <= cpu_do;
	always @(posedge clk) ram_q <= ram[A[12:0]];
	always @(posedge clk) if (rom_we) rom[rom_addr] <= rom_data;
	always @(posedge clk) rom_q <= rom[rom_raddr];

	// ------------------------------------------------------------------ registers
	reg  [7:0] wrio, mix, ovol;
	reg        cmd_tgl_d, rsp_rd_tgl_d;
	reg  [7:0] cmd_q;               // m_main_to_sound_data
	reg        oki1_wr, oki2_wr;
	reg  [7:0] wdat;
	reg        oki_rst;

	// YM2151 writes are held until cen_p1 (jt51 takes a write only with it; as the owner's other cores)
	reg        ym_pend, ym_a0;
	reg  [7:0] ym_d;
	reg        ym_rst_n;

	always @(posedge clk) begin
		oki1_wr <= 1'b0;
		oki2_wr <= 1'b0;
		oki_rst <= 1'b0;
		if (cen_ym_p1) ym_pend <= 1'b0;

		cmd_tgl_d    <= cmd_tgl;
		rsp_rd_tgl_d <= rsp_rd_tgl;

		if (rst) begin
			main_to_sound_ready <= 1'b0;
			sound_to_main_ready <= 1'b0;
			timed_int <= 1'b0;
			cpu_bank  <= 2'd0;
			wrio      <= 8'h00;
			mix       <= 8'h00;
			ovol      <= 8'd127;
			ym_pend   <= 1'b0;
			ym_rst_n  <= 1'b1;
			rsp_data  <= 8'h00;
			cmd_q     <= 8'h00;
		end else begin
			if (tick) timed_int <= 1'b1;

			// the main CPU's side of the latches
			if (cmd_tgl != cmd_tgl_d) begin
				cmd_q <= cmd_data;
				main_to_sound_ready <= 1'b1;
			end
			if (rsp_rd_tgl != rsp_rd_tgl_d)
				sound_to_main_ready <= 1'b0;

			if (rd && sel_io && !io_w) begin
				if (io_r == 2'd1) main_to_sound_ready <= 1'b0;   // 2802 sound_command_r
				if (io_r == 2'd3) timed_int <= 1'b0;             // 2806 sound_irq_ack_r
			end

			if (wr && sel_ym) begin
				ym_pend <= 1'b1; ym_a0 <= A[0]; ym_d <= cpu_do;
			end

			if (wr && sel_io) begin
				wdat <= cpu_do;
				if (!io_w) begin
					if (io_r == 2'd0) ovol <= cpu_do;            // 2800/1 overall_volume_w
					if (io_r == 2'd3) timed_int <= 1'b0;         // 2806 sound_irq_ack_w
				end else begin
					case (io_r)
						2'd0: if (A[0]) oki2_wr <= 1'b1; else oki1_wr <= 1'b1;   // 2A00/1
						2'd1: begin                                              // 2A02 sound_response_w
							rsp_data <= cpu_do;
							sound_to_main_ready <= 1'b1;
						end
						2'd2: begin                                              // 2A04 wrio_w
							wrio     <= cpu_do;
							cpu_bank <= cpu_do[7:6];
							ym_rst_n <= cpu_do[0];
							if (!cpu_do[2]) oki_rst <= 1'b1;
						end
						2'd3: mix <= cpu_do;                                     // 2A06 mix_w
					endcase
				end
			end
		end
	end

	// ------------------------------------------------------------------ YM2151
	wire [7:0]  ym_dout;
	wire        ym_ct1;
	wire signed [15:0] ym_l, ym_r;
	jt51 u_ym (
		.rst(rst | ~ym_rst_n), .clk(clk), .cen(cen_ym), .cen_p1(cen_ym_p1),
		.cs_n(!(ym_pend && cen_ym_p1)), .wr_n(1'b0), .a0(ym_a0), .din(ym_d), .dout(ym_dout),
		.ct1(ym_ct1), .ct2(), .irq_n(ym_irq_n),
		.sample(), .left(), .right(), .xleft(ym_l), .xright(ym_r)
	);

	// ------------------------------------------------------------------ OKI6295 x 2
	// banks: OKI1 {MIX bit 4, WRIO bit 1}, OKI2 MIX bits 7:6; entries 0/1 -> 0x00000, 2 -> 0x20000, 3 -> 0x40000 for
	// the chip's 0x00000-0x1FFFF; 0x20000-0x3FFFF is always 0x60000
	wire [1:0] bank1 = {mix[4], wrio[1]};
	wire [1:0] bank2 = mix[7:6];
	function automatic [18:0] okimap(input [1:0] bank, input [17:0] a);
		if (a[17])            okimap = {2'b11, a[16:0]};
		else if (bank == 2'd2) okimap = {2'b01, a[16:0]};
		else if (bank == 2'd3) okimap = {2'b10, a[16:0]};
		else                   okimap = {2'b00, a[16:0]};
	endfunction

	wire [7:0]  oki1_dout, oki2_dout;
	wire [17:0] oki1_a, oki2_a;
	reg  [7:0]  oki1_rd, oki2_rd;
	wire        oki1_ok, oki2_ok;
	wire signed [13:0] oki1_snd, oki2_snd;

	jt6295 #(.INTERPOL(0)) u_oki1 (
		.rst(rst | oki_rst), .clk(clk), .cen(cen_oki), .ss(wrio[3]),
		.wrn(~oki1_wr), .din(wdat), .dout(oki1_dout),
		.rom_addr(oki1_a), .rom_data(oki1_rd), .rom_ok(oki1_ok),
		.sound(oki1_snd), .sample()
	);
	jt6295 #(.INTERPOL(0)) u_oki2 (
		.rst(rst | oki_rst), .clk(clk), .cen(cen_oki), .ss(wrio[3]),
		.wrn(~oki2_wr), .din(wdat), .dout(oki2_dout),
		.rom_addr(oki2_a), .rom_data(oki2_rd), .rom_ok(oki2_ok),
		.sound(oki2_snd), .sample()
	);

	// sample bytes: each chip's byte is fetched whenever its (banked) address changes and held; one request at a time
	reg  [19:0] have1_a, have2_a;
	reg         have1, have2, srv2;
	wire [19:0] want1 = {1'b0, okimap(bank1, oki1_a)};
	wire [19:0] want2 = {1'b1, okimap(bank2, oki2_a)};
	assign oki1_ok = have1 && have1_a == want1;
	assign oki2_ok = have2 && have2_a == want2;
	always @(posedge clk) begin
		if (rst) begin
			pcm_req <= 1'b0; have1 <= 1'b0; have2 <= 1'b0;
		end else if (pcm_req) begin
			if (pcm_ack) begin
				pcm_req <= 1'b0;
				if (srv2) begin oki2_rd <= pcm_q; have2_a <= pcm_addr; have2 <= 1'b1; end
				else      begin oki1_rd <= pcm_q; have1_a <= pcm_addr; have1 <= 1'b1; end
			end
		end else if (!oki1_ok) begin
			pcm_addr <= want1; srv2 <= 1'b0; pcm_req <= 1'b1;
		end else if (!oki2_ok) begin
			pcm_addr <= want2; srv2 <= 1'b1; pcm_req <= 1'b1;
		end
	end

	// ------------------------------------------------------------------ the 6502's data input
	// RDIO: 01 coin R (COIN2), 02 coin L (COIN1), 04 tilt, 08 service, 10/80 self test (MAME's double inversion leaves
	// them 0 either way), 20 output buffer full (sound_to_main_ready), 40 input buffer full (active low)
	wire [7:0] rdio = {1'b0, ~main_to_sound_ready, sound_to_main_ready, 1'b0, service1, tilt, coin1, coin2};
	always @(*) begin
		cpu_di = 8'hFF;
		if (sel_ram)                 cpu_di = ram_q;
		else if (sel_ym)             cpu_di = A[0] ? ym_dout : 8'hFF;
		else if (sel_io && !io_w) begin
			case (io_r)
				2'd0: cpu_di = A[0] ? oki2_dout : oki1_dout;
				2'd1: cpu_di = cmd_q;
				2'd2: cpu_di = rdio;
				2'd3: cpu_di = 8'h00;
			endcase
		end
		else if (A[15:12] >= 4'h3)   cpu_di = rom_q;
	end

	// ------------------------------------------------------------------ mixer
	// q12 gains: YM 0.60 * (MIX[3:1] / 7), OKI 0.75 * (MIX[0] ? 1 : 0.5) * CT1, overall data / 127
	function automatic [11:0] ymgain(input [2:0] v);
		case (v)
			3'd0: ymgain = 12'd0;    3'd1: ymgain = 12'd351;  3'd2: ymgain = 12'd702;  3'd3: ymgain = 12'd1053;
			3'd4: ymgain = 12'd1404; 3'd5: ymgain = 12'd1755; 3'd6: ymgain = 12'd2107; default: ymgain = 12'd2458;
		endcase
	endfunction
	wire [11:0] g_ym  = ymgain(mix[3:1]);
	wire [11:0] g_oki = !ym_ct1 ? 12'd0 : mix[0] ? 12'd3072 : 12'd1536;
	reg  [13:0] g_all;                         // 4096 * ovol / 127 ~ ovol * 32.25 (127 -> 4095)
	always @(posedge clk) g_all <= {1'b0, ovol, 5'b0} + {8'b0, ovol[7:2]};

	// OKI: jt6295's 14-bit sum, << 4 for the YM's 16-bit scale (a full-scale 12-bit voice = 1.0 in MAME's stream)
	reg signed [31:0] mix_l, mix_r;
	reg signed [31:0] fin_l, fin_r;
	always @(posedge clk) begin
		mix_l <= (ym_l * $signed({1'b0, g_ym})) + (($signed({oki1_snd, 4'b0})) * $signed({1'b0, g_oki}));
		mix_r <= (ym_r * $signed({1'b0, g_ym})) + (($signed({oki2_snd, 4'b0})) * $signed({1'b0, g_oki}));
		fin_l <= (mix_l >>> 12) * $signed({1'b0, g_all});
		fin_r <= (mix_r >>> 12) * $signed({1'b0, g_all});
		out_l <= sat16(fin_l >>> 12);
		out_r <= sat16(fin_r >>> 12);
	end

	function automatic signed [15:0] sat16(input signed [31:0] v);
		if (v > 32767)       sat16 = 16'sd32767;
		else if (v < -32768) sat16 = 16'sh8000;
		else                 sat16 = v[15:0];
	endfunction

endmodule
`default_nettype wire
