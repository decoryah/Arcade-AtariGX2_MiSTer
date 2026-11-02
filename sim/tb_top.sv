// Whole-machine bench: the core's modules as AtariGX2.sv wires them (no MiSTer framework), the SDRAM and the DDR3 as
// behavioural models served by tb_main.cpp (DPI), the image preloaded (the loader is bypassed: the SDRAM part of the
// image, the 6502's ROM through the JSA's load port, the RLE ROM in the DDR3 model).
`default_nettype none
module tb_top (
	input  wire        clk_sys,
	input  wire        clk_cpu,
	input  wire        reset,           // everything (held while tb_main.cpp loads the 6502 ROM)
	input  wire        game,            // 0 Space Lords, 1 Moto Frenzy
	input  wire [24:0] rle_words,
	input  wire        prescan_go,      // pulse: start the RLE prescan (the end of a download)

	input  wire        rom_we,
	input  wire [15:0] rom_addr,
	input  wire [7:0]  rom_data,

	input  wire [31:0] joy0, joy1,
	input  wire        test,

	output wire        ce_pix, hblank, vblank, hsync, vsync,
	output wire [7:0]  r, g, b,
	output wire signed [15:0] snd_l, snd_r,
	output wire        prescan_done,
	output wire [31:0] dbg_pc
);
	import "DPI-C" function int  sdram_rd(input int waddr);
	import "DPI-C" function longint ddr_rd(input int qaddr);
	import "DPI-C" function void ddr_wr(input int qaddr, input longint data, input int be);

	// ------------------------------------------------------------------ SDRAM model: four toggle ports, fixed latency
	wire [24:1] a0, a1, a2;
	wire        q0, q1, q2;
	reg         k0 = 0, k1 = 0, k2 = 0;
	reg  [15:0] d0, d1, d2;
	reg  [3:0]  lat0, lat1, lat2;
	always @(posedge clk_sys) begin
		if (q0 != k0) begin lat0 <= lat0 + 1; if (lat0 == 4'd7) begin d0 <= sdram_rd({8'd0, a0}) [15:0]; k0 <= q0; lat0 <= 0; end end
		if (q1 != k1) begin lat1 <= lat1 + 1; if (lat1 == 4'd7) begin d1 <= sdram_rd({8'd0, a1}) [15:0]; k1 <= q1; lat1 <= 0; end end
		if (q2 != k2) begin lat2 <= lat2 + 1; if (lat2 == 4'd7) begin d2 <= sdram_rd({8'd0, a2}) [15:0]; k2 <= q2; lat2 <= 0; end end
	end

	// ------------------------------------------------------------------ DDR3 model: Avalon, bursts, a few clocks of latency
	wire [28:0] ddr_addr;
	wire        ddr_rd_w, ddr_we_w;
	wire [7:0]  ddr_burst;
	wire [63:0] ddr_din;
	wire [7:0]  ddr_be;
	reg  [63:0] ddr_dout;
	reg         ddr_ready;
	reg  [7:0]  ddr_left;
	reg  [28:0] ddr_raddr;
	reg  [3:0]  ddr_wait;
	wire        ddr_busy = (ddr_left != 0);
	always @(posedge clk_sys) begin
		ddr_ready <= 1'b0;
		if (!ddr_busy && ddr_we_w)
			ddr_wr({3'd0, ddr_addr}, ddr_din, {24'd0, ddr_be});
		else if (!ddr_busy && ddr_rd_w) begin
			ddr_left  <= ddr_burst;
			ddr_raddr <= ddr_addr;
			ddr_wait  <= 4'd6;
		end else if (ddr_busy) begin
			if (ddr_wait != 0) ddr_wait <= ddr_wait - 1;
			else begin
				ddr_dout  <= ddr_rd({3'd0, ddr_raddr});
				ddr_ready <= 1'b1;
				ddr_raddr <= ddr_raddr + 1;
				ddr_left  <= ddr_left - 1;
			end
		end
	end

	// ------------------------------------------------------------------ the core (as AtariGX2.sv)
	wire [15:1] vram_addr;  wire [15:0] vram_din, vram_dout;  wire [1:0] vram_we;
	wire [11:1] pal_addr;   wire [15:0] pal_din, pal_dout;    wire [1:0] pal_we;
	wire [11:1] oram_addr;  wire [15:0] oram_din, oram_dout;  wire [1:0] oram_we;
	wire [2:0]  mo_control; wire [15:0] mo_command;
	wire        snd_reset, cmd_tgl, rsp_rd_tgl, main_to_sound_ready, sound_to_main_ready;
	wire [7:0]  cmd_data, rsp_data;
	wire [8:0]  hcnt, vcnt;
	wire        vblank_rise;
	wire [31:0] p1p2;
	wire [63:0] analog;
	wire        coin1, coin2;
	wire        clear_done;

	reg reset_cpu = 1, hold_cpu = 1;
	always @(posedge clk_cpu) begin
		reset_cpu <= reset;
		hold_cpu  <= reset | ~prescan_done;
	end

	// the CPU's pace (gx2_main's cpu_rate), +rate=n: n / 16 steps a clock at most; 16 (the default): unpaced
	reg [4:0] cpu_rate = 5'd16;
	initial begin
		integer r;
		if ($value$plusargs("rate=%d", r)) cpu_rate = r[4:0];
	end

	gx2_main u_main (
		.clk_cpu(clk_cpu), .reset(reset_cpu), .cpu_reset(hold_cpu), .clear_done(clear_done), .sel95(~game), .cpu_rate(cpu_rate),
		.sdram_addr(a1), .sdram_req(q1), .sdram_ack(k1), .sdram_dout(d1),
		.vram_addr(vram_addr), .vram_din(vram_din), .vram_we(vram_we), .vram_dout(vram_dout),
		.pal_addr(pal_addr), .pal_din(pal_din), .pal_we(pal_we), .pal_dout(pal_dout),
		.oram_addr(oram_addr), .oram_din(oram_din), .oram_we(oram_we), .oram_dout(oram_dout),
		.mo_control(mo_control), .mo_command(mo_command), .snd_reset(snd_reset),
		.cmd_tgl(cmd_tgl), .cmd_data(cmd_data), .rsp_rd_tgl(rsp_rd_tgl), .rsp_data(rsp_data),
		.main_to_sound_ready(main_to_sound_ready), .sound_to_main_ready(sound_to_main_ready),
		.vblank(vblank), .p1p2(p1p2), .test_n(~test), .analog(analog),
		.clk_nv(clk_sys), .nv_addr(11'd0), .nv_din(8'd0), .nv_we(1'b0), .nv_q(), .nv_wr_toggle(),
		.dbg_pc(dbg_pc)
	);

	wire        pcm_req;
	wire [19:0] pcm_addr;
	reg         pcm_ack;
	reg  [7:0]  pcm_q;
	reg         sbusy = 0;
	reg  [24:1] sa;
	reg         sq = 0;
	assign a0 = sa;
	assign q0 = sq;
	always @(posedge clk_sys) begin
		pcm_ack <= 1'b0;
		if (!sbusy && pcm_req && !pcm_ack) begin
			sa <= 24'(({4'b0, pcm_addr} + 24'h080000) >> 1); sq <= ~sq; sbusy <= 1'b1;
		end else if (sbusy && k0 == sq) begin
			pcm_q <= pcm_addr[0] ? d0[7:0] : d0[15:8]; pcm_ack <= 1'b1; sbusy <= 1'b0;
		end
	end

	gx2_jsa u_jsa (
		.clk(clk_sys), .rst(reset), .snd_reset(snd_reset),
		.cmd_tgl(cmd_tgl), .cmd_data(cmd_data), .rsp_rd_tgl(rsp_rd_tgl), .rsp_data(rsp_data),
		.main_to_sound_ready(main_to_sound_ready), .sound_to_main_ready(sound_to_main_ready),
		.coin1(coin1), .coin2(coin2), .service1(1'b0), .tilt(1'b0),
		.rom_we(rom_we), .rom_addr(rom_addr), .rom_data(rom_data),
		.pcm_req(pcm_req), .pcm_addr(pcm_addr), .pcm_ack(pcm_ack), .pcm_q(pcm_q),
		.out_l(snd_l), .out_r(snd_r)
	);

	wire [8:0]  fb_rd_x;
	wire [7:0]  fb_rd_y;
	wire [15:0] fb_rd_data;

	gx2_video u_video (
		.clk(clk_sys), .clk_cpu(clk_cpu), .reset(1'b0), .pf_base(game ? 11'h400 : 11'h000),
		.ce_pix(ce_pix), .hblank(hblank), .vblank(vblank), .hsync(hsync), .vsync(vsync),
		.hcnt(hcnt), .vcnt(vcnt), .vblank_rise(vblank_rise),
		.vram_addr(vram_addr), .vram_din(vram_din), .vram_we(vram_we), .vram_dout(vram_dout),
		.pal_addr(pal_addr), .pal_din(pal_din), .pal_we(pal_we), .pal_dout(pal_dout),
		.rom_addr(a2), .rom_req(q2), .rom_ack(k2), .rom_dout(d2),
		.fb_rd_x(fb_rd_x), .fb_rd_y(fb_rd_y), .fb_rd_data(fb_rd_data),
		.r(r), .g(g), .b(b)
	);

	wire [7:0] mo_next_line = (vcnt >= 9'd261) ? 8'd0 : vcnt[7:0] + 8'd1;

	rle_objects #(.ROM_WORDS(32'd4194304)) u_rle (
		.clk(clk_sys), .clk_cpu(clk_cpu), .reset(reset),
		.hblank(hblank), .vblank(vblank), .next_line(mo_next_line),
		.control(mo_control), .mo_command(mo_command), .vblank_rise(vblank_rise),
		.tmek(1'b0), .colmask(game ? 16'h01F0 : 16'h03F0), .palbase(game ? 16'h0200 : 16'h0400), .rom_words(rle_words),
		.oram_addr(oram_addr), .oram_din(oram_din), .oram_dout(oram_dout), .oram_we(oram_we),
		.fb_rd_x(fb_rd_x), .fb_rd_y(fb_rd_y), .fb_rd_tm(), .fb_rd_data(fb_rd_data), .fb_rd_frame(mo_control[2]),
		.ddr_addr(ddr_addr), .ddr_rd(ddr_rd_w), .ddr_we(ddr_we_w), .ddr_burstcnt(ddr_burst),
		.ddr_din(ddr_din), .ddr_be(ddr_be), .ddr_dout(ddr_dout), .ddr_dout_ready(ddr_ready), .ddr_busy(ddr_busy),
		.prescan_start(prescan_go), .prescan_done(prescan_done)
	);

	gx2_inputs u_in (
		.clk(clk_sys), .frame(vblank_rise), .game(game),
		.joy0(joy0), .joy1(joy1), .ana_l0(16'd0), .ana_r0(16'd0), .ana_l1(16'd0), .ana_r1(16'd0),
		.paddle0(8'd128), .spinner0(9'd0), .mouse(25'd0),
		.sl_src(3'd1), .sl_inv_y(1'b0), .sl_thr_axis(1'b0), .sl_swap(1'b0),
		.mf_steer(3'd1), .mf_thr(3'd0), .mf_sens(2'd0), .mf_inv(1'b0),
		.dpad_speed(2'd0), .dpad_rel(2'd0), .deadzone(2'd0), .sens(2'd0),
		.p1p2(p1p2), .analog(analog), .coin1(coin1), .coin2(coin2)
	);

	// the main CPU's side of the sound comm, as tools/lua/gx2_sndlog.lua logs it in MAME: commands and /SNDRES by frame
	integer snd_frame = 0;
	reg     snd_reset_d = 1'b0, cmd_tgl_d = 1'b0;
	always @(posedge clk_sys) begin
		if (vblank_rise) snd_frame <= snd_frame + 1;
		snd_reset_d <= snd_reset;
		cmd_tgl_d   <= cmd_tgl;
		if (snd_reset != snd_reset_d) $display("snd frame %0d L %0d", snd_frame, !snd_reset);
		if (cmd_tgl != cmd_tgl_d)     $display("snd frame %0d C %02X", snd_frame, cmd_data);
	end

	// the sound watchdog's timing (+wdt): each SERVICE read (bit 5: the command latch empty) and response read within
	// 2 ms of the heartbeat's command 03, in us after it, as work/tmp/wdt.lua logs MAME's
	integer hb_cyc = 0;
	reg     wdt = 1'b0;
	initial wdt = $test$plusargs("wdt");
	always @(posedge clk_sys) begin
		hb_cyc <= (cmd_tgl != cmd_tgl_d && cmd_data == 8'h03) ? 0 : hb_cyc + 1;
	end
	always @(posedge clk_cpu) if (wdt && u_main.state == 3'd0 && u_main.cpu_rd && hb_cyc < 171818) begin
		if (u_main.is_service) $display("snd frame %0d S %0d %.1f", snd_frame, !main_to_sound_ready, hb_cyc / 85.909);
		if (u_main.is_rsp)     $display("snd frame %0d R %02X %.1f", snd_frame, rsp_data, hb_cyc / 85.909);
	end

	// the frame pacing (+vlog=f, from frame f), as tools/lua/gx2_vlog.lua logs MAME's: "vid <frame> ctl <v> <bits>" each
	// change of the MO control bits (2 frame, 1 erase, 0 /MOGO) at line v, "vid <frame> draw <v0> <v1>" each RLE draw
	// (the renderer busy from line v0 to v1 of that frame, v1 + 262 n if it ran n frames on), "vid <frame> w <region> <n>
	// <v0> <v1>" the frame's word writes to a region and the lines of the first and last: pf the playfield (D72000), al
	// the alphanumerics (D76000) but sc their per-line scroll entries (words 48-63 of each 64), mo the RLE object RAM
	// (D78000), pal the palette (D40000)
	integer vlog = -1;
	initial if (!$value$plusargs("vlog=%d", vlog)) vlog = -1;
	reg [2:0] ctl_d = 3'd0;
	reg       draw_d = 1'b0;
	integer   draw_f = 0, draw_v = 0;
	always @(posedge clk_sys) if (vlog >= 0 && snd_frame >= vlog) begin
		ctl_d  <= mo_control;
		draw_d <= u_rle.state != 0;
		if (mo_control != ctl_d) $display("vid %0d ctl %0d %b", snd_frame, vcnt, mo_control);
		if ((u_rle.state != 0) && !draw_d) begin draw_f <= snd_frame; draw_v <= vcnt; end
		if ((u_rle.state == 0) && draw_d) $display("vid %0d draw %0d %0d", draw_f, draw_v, vcnt + 262 * (snd_frame - draw_f));
	end
	// "vid <frame> stale <fields> <of> <objects>" each draw: the object fields (words 0-4) the draw used that differ from
	// the object RAM as it began (MAME draws at once on /MOGO: what the RAM held then; rle_objects' snap_mem copy), of
	// all it read, and the objects with one or more
	logic [15:0] mo_cur [0:2047], mo_snap [0:2047];
	integer st_n = 0, st_all = 0, st_obj = 0;
	reg     st_this = 1'b0;
	always @(posedge clk_cpu) begin
		if (oram_we[1]) mo_cur[oram_addr][15:8] <= oram_din[15:8];
		if (oram_we[0]) mo_cur[oram_addr][7:0]  <= oram_din[7:0];
	end
	wire st_diff = u_rle.snap_q != mo_snap[{u_rle.objnum_cnt, u_rle.field_idx}];
	always @(posedge clk_sys) if (vlog >= 0 && snd_frame >= vlog) begin
		if (u_rle.state == 19) for (int i = 0; i < 2048; i++) mo_snap[i] <= mo_cur[i];   // S_DRAW_ERASE
		if (u_rle.state == 26) begin                                                       // S_DRAW_FIELD_GOT
			st_all  <= st_all + 1;
			st_n    <= st_n + (st_diff ? 1 : 0);
			st_this <= (u_rle.field_idx == 3'd0) ? st_diff : (st_this || st_diff);
			if (u_rle.field_idx == 3'd4 && (st_this || st_diff)) st_obj <= st_obj + 1;
		end
		if ((u_rle.state == 0) && draw_d) begin
			$display("vid %0d stale %0d %0d %0d", draw_f, st_n, st_all, st_obj);
			st_n <= 0; st_all <= 0; st_obj <= 0;
		end
	end
	integer w_f = 0;
	integer w_n [0:4], w_v0 [0:4], w_v1 [0:4];
	initial for (int i = 0; i < 5; i++) w_n[i] = 0;
	wire [2:0] w_reg = (vram_we != 0 && vram_addr[15:13] != 3'd0 && vram_addr[15:12] < 4'h6) ? 3'd0 :
	                   (vram_we != 0 && vram_addr[15:12] == 4'h6 && vram_addr[6:1] <  6'd48) ? 3'd1 :
	                   (vram_we != 0 && vram_addr[15:12] == 4'h6) ? 3'd2 :
	                   (oram_we != 0) ? 3'd3 : (pal_we != 0) ? 3'd4 : 3'd7;
	always @(posedge clk_cpu) if (vlog >= 0 && snd_frame >= vlog) begin
		if (snd_frame != w_f) begin
			for (int i = 0; i < 5; i++) begin
				if (w_n[i] != 0) $display("vid %0d w %s %0d %0d %0d", w_f, i == 0 ? "pf" : i == 1 ? "al" : i == 2 ? "sc" : i == 3 ? "mo" : "pal",
				                          w_n[i], w_v0[i], w_v1[i]);
				w_n[i] <= 0;
			end
			w_f <= snd_frame;
		end else if (w_reg != 3'd7) begin
			if (w_n[w_reg] == 0) w_v0[w_reg] <= vcnt;
			w_v1[w_reg] <= vcnt;
			w_n[w_reg]  <= w_n[w_reg] + 1;
		end
	end
endmodule
`default_nettype wire
