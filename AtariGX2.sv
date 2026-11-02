//============================================================================
//  Atari GX2 (MAME atari/atarigx2.cpp: Space Lords, Moto Frenzy) for MiSTer
//
//  This program is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the Free
//  Software Foundation; either version 3 of the License, or (at your option)
//  any later version.
//
//  The board: 68EC020 14.318 MHz (TG68K), JSA IIIs sound (6502, YM2151, 2 x OKI6295), playfield + alpha tilemaps,
//  Atari's RLE motion objects, XGA protection, ADC0809, EEPROM 2816. The platform layer (DDR3 fast load and replay,
//  RLE renderer, SDRAM controller) comes from the Primal Rage core (MiSTer-devel/Arcade-PrimalRage_MiSTer, Atari GT,
//  Nortido, GPL-3); the 6502 sound wiring from the Atari System 1 core; OSD layout, Scale and CRT Adjust as the
//  owner's other cores.
//============================================================================

module emu
(
	`include "sys/emu_ports.vh"
);

assign ADC_BUS  = 'Z;
assign USER_OUT = '1;
assign {UART_RTS, UART_TXD, UART_DTR} = 0;
assign {SD_SCK, SD_MOSI, SD_CS} = 'Z;

assign VGA_F1 = 0;
assign VGA_SCALER  = 0;
assign VGA_DISABLE = 0;
assign HDMI_FREEZE = 0;
assign HDMI_BLACKOUT = 0;
assign HDMI_BOB_DEINT = 0;

assign AUDIO_S   = 1;
assign AUDIO_MIX = 0;

assign LED_DISK  = 0;
assign LED_POWER = 0;
assign BUTTONS   = 0;

//////////////////////////////////////////////////////////////////

wire [127:0] status;
wire   [1:0] buttons;
wire         forced_scandoubler;
wire         direct_video;
wire  [21:0] gamma_bus;

// Aspect ratio and Scale (the owner's menu order; video_scale_int's SCALE counts 0 Normal, 1 V-Integer,
// 2 Narrower HV-Integer, 3 HV-Integer+, 4 HV-Integer)
reg   [2:0] scale_sel;
always @* case (status[34:32])
	3'd1:    scale_sel = 3'd1;
	3'd2:    scale_sel = 3'd4;
	3'd3:    scale_sel = 3'd2;
	3'd4:    scale_sel = 3'd3;
	default: scale_sel = 3'd0;
endcase
wire  [1:0] ar     = status[122:121];
wire        fs_int = (ar == 2'd1) && (scale_sel != 3'd0) && (HDMI_WIDTH != 12'd0) && (HDMI_HEIGHT != 12'd0);
reg  [11:0] arx, ary;
always @(posedge clk_sys) begin
	arx <= fs_int ? HDMI_WIDTH  : (!ar) ? 12'd4 : {10'd0, ar - 2'd1};
	ary <= fs_int ? HDMI_HEIGHT : (!ar) ? 12'd3 : 12'd0;
end

`include "build_id.v"
localparam CONF_STR = {
	"A.ATARIGX2;;",
	"-;",
	"O[122:121],Aspect ratio,Original,Full Screen,[ARC1],[ARC2];",
	"O[34:32],Scale,Normal,V-Integer,HV-Integer,Narrower HV-Integer,HV-Integer+;",
	"O[5:3],Scandoubler Fx,None,HQ2x,CRT 25%,CRT 50%,CRT 75%;",
	"P1,CRT Adjust;",
	"P1O[101],CRT Adjust,Off,On;",
	"H3P1O[100:96],H-Size,0,+1,+2,+3,+4,+5,+6,+7,+8,+9,+10,+11,+12,+13,+14,+15,-16,-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1;",
	"H3P1O[85:79],H-Position,0,+1,+2,+3,+4,+5,+6,+7,+8,+9,+10,+11,+12,+13,+14,+15,+16,+17,+18,+19,+20,+21,+22,+23,+24,+25,+26,+27,+28,+29,+30,+31,+32,+33,+34,+35,+36,+37,+38,+39,+40,+41,+42,+43,+44,+45,+46,+47,+48,-48,-47,-46,-45,-44,-43,-42,-41,-40,-39,-38,-37,-36,-35,-34,-33,-32,-31,-30,-29,-28,-27,-26,-25,-24,-23,-22,-21,-20,-19,-18,-17,-16,-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1;",
	"H3P1O[78:74],V-Shift,0,+1,+2,+3,+4,+5,+6,+7,+8,+9,+10,+11,+12,+13,+14,+15,+16,+17,+18,+19,+20,+21,+22,+23,-8,-7,-6,-5,-4,-3,-2,-1;",
	"P2,Controls;",
	"H1P2O[16:14],Flight Stick,Auto,D-Pad,Left Stick,Right Stick,Mouse (P1);",
	"H1P2O[17],Stick Y,Normal,Inverted;",
	"H1P2O[18],Throttle,Buttons,Buttons + Right Stick Y;",
	"H1P2O[19],Swap Players,No,Yes;",
	"H2P2O[23:21],Steering,Auto,D-Pad,Left Stick,Right Stick,Paddle,Spinner,Mouse;",
	"H2P2O[26:24],Throttle,Button,Button (ramp),Left Stick Up,Right Stick Up,Right Stick Down,D-Pad Up;",
	"H2P2O[28:27],Steering Range,Full (MAME),75%,50%;",
	"H2P2O[29],Steering,Normal,Inverted;",
	"P2-;",
	"P2O[31:30],D-Pad Speed,MAME,Slow,Fast,Instant;",
	"P2O[41:40],D-Pad Release,Return to Centre,Snap to Centre,Hold;",
	"P2O[37:36],Stick Dead Zone,None,6%,12%,18%;",
	"P2O[39:38],Stick Sensitivity,100%,75%,125%,150%;",
	"-;",
	"O[43:42],CPU Speed,Auto,Full,Paced;",
	"O[11],Service Mode,Off,On;",
	"O[9:8],Volume,Normal,-6 dB,-12 dB,-18 dB;",
	"O[12],Autosave NVRAM,Off,On;",
	"T[13],Save NVRAM;",
	"-;",
	"R0,Reset;",
	"J1,B1,B2,B3,B4,B5,B6,Start,Coin;",
	"jn,A,B,X,Y,R,L,Start,Select;",
	"V,v",`BUILD_DATE
};

///////////////////////   CLOCKS   ///////////////////////////////

wire clk_sys;      // 85.909 MHz = 6 x 14.318181 MHz: video (12 a dot), JSA (24 a YM clock), SDRAM, DDR3
wire clk_cpu;      // 42.955 MHz, phase aligned: the 68EC020 and its bus
wire pll_locked;

pll pll
(
	.refclk(CLK_50M),
	.rst(0),
	.outclk_0(clk_sys),
	.outclk_1(clk_cpu),
	.locked(pll_locked),
	.reconfig_to_pll(64'd0),
	.reconfig_from_pll()
);

///////////////////////   HPS   //////////////////////////////////

localparam [7:0] NVRAM_INDEX = 8'd4;

wire [31:0] joystick_0, joystick_1;
wire [15:0] joystick_l_analog_0, joystick_r_analog_0, joystick_l_analog_1, joystick_r_analog_1;
wire  [7:0] paddle_0;
wire  [8:0] spinner_0;
wire [24:0] ps2_mouse;

wire        ioctl_download;
wire [15:0] ioctl_index;
wire        ioctl_wr;
wire [26:0] ioctl_addr;
wire  [7:0] ioctl_dout;
wire        ioctl_wait;

wire        nv_upload_req;
wire [10:0] nv_addr;
wire  [7:0] nv_din;
wire        nv_we;
wire  [7:0] nv_q;
wire        nv_wr_toggle;

reg  [7:0]  board = 8'd0;      // MRA index 1: 0 Space Lords, 1 Moto Frenzy
wire        game = board[0];

// the 68EC020's pace (gx2_main's cpu_rate). Full: TG68K unpaced, with the ROM cache ~1.7x MAME's 68EC020 in Moto Frenzy's
// VBLANK interrupt and ~2.5x in CPU-bound loops. Moto Frenzy's sound watchdog (6DC8: every ~35 frames it sends 07 and
// needs the reply to the heartbeat 03, sent at the start of that interrupt, to be in by then) fails at that speed: the
// game resets the sound board every 6 s. Paced: the interrupt's path takes longer than the JSA's reply (~90 us) as on
// the board, whose wait states MAME (78 us there) does not model either. Auto: Paced for Moto Frenzy (~80 % idle in
// MAME), Full for Space Lords (~90 % busy in MAME; its watchdog runs ms after the heartbeat).
localparam [4:0] RATE_PACED = 5'd2;
wire  [4:0] cpu_rate = (status[43:42] == 2'd2 || (status[43:42] == 2'd0 && game)) ? RATE_PACED : 5'd16;

hps_io #(.CONF_STR(CONF_STR)) hps_io
(
	.clk_sys(clk_sys),
	.HPS_BUS(HPS_BUS),
	.EXT_BUS(),
	.gamma_bus(gamma_bus),
	.forced_scandoubler(forced_scandoubler),
	.direct_video(direct_video),

	.buttons(buttons),
	.status(status),
	// H1 Space Lords controls, H2 Moto Frenzy controls, H3 the CRT Adjust values while it is Off
	.status_menumask({12'd0, ~status[101], ~game, game, 1'b0}),

	.joystick_0(joystick_0),
	.joystick_1(joystick_1),
	.joystick_l_analog_0(joystick_l_analog_0),
	.joystick_r_analog_0(joystick_r_analog_0),
	.joystick_l_analog_1(joystick_l_analog_1),
	.joystick_r_analog_1(joystick_r_analog_1),
	.paddle_0(paddle_0),
	.spinner_0(spinner_0),
	.ps2_mouse(ps2_mouse),

	.ioctl_download(ioctl_download),
	.ioctl_index(ioctl_index),
	.ioctl_wr(ioctl_wr),
	.ioctl_addr(ioctl_addr),
	.ioctl_dout(ioctl_dout),
	.ioctl_wait(ioctl_wait),

	.ioctl_upload(),
	.ioctl_upload_req(nv_upload_req),
	.ioctl_upload_index(NVRAM_INDEX),
	.ioctl_din(nv_q),
	.ioctl_rd()
);

always @(posedge clk_sys)
	if (ioctl_download && ioctl_index[7:0] == 8'd1 && ioctl_wr && ioctl_addr == 27'd0)
		board <= ioctl_dout;

///////////////////////   RESETS   ///////////////////////////////

wire rom_download;                                     // index 0, the fast-load replay included
wire nvram_download = ioctl_download & (ioctl_index[7:0] == NVRAM_INDEX);
wire reset = RESET | status[0] | buttons[1] | ~pll_locked | nvram_download;

reg rom_download_d;
always @(posedge clk_sys) rom_download_d <= rom_download;
wire prescan_start = rom_download_d & ~rom_download;
wire prescan_done;
wire clear_done;
wire cpu_hold = reset | rom_download | ~prescan_done;

reg reset_cpu_m, reset_cpu, hold_cpu_m, hold_cpu;
always @(posedge clk_cpu) begin
	{reset_cpu, reset_cpu_m} <= {reset_cpu_m, reset | rom_download};
	{hold_cpu,  hold_cpu_m}  <= {hold_cpu_m,  cpu_hold};
end

assign LED_USER = rom_download | ~prescan_done;

///////////////////////   LOADER   ///////////////////////////////

wire        ld_download;
wire [15:0] ld_index;
wire        ld_wr;
wire [26:0] ld_addr;
wire  [7:0] ld_dout;
wire        ld_wait;
wire        ld_ddr_pending;

wire [28:0] stg_ddr_addr;
wire        stg_ddr_rd;
wire [63:0] stg_ddr_dout;
wire        stg_ddr_dout_ready;
wire        stg_ddr_busy;

rom_ddr_replay rom_ddr_replay
(
	.clk(clk_sys),
	.reset(~pll_locked),
	.ioctl_download(ioctl_download),
	.ioctl_index(ioctl_index),
	.ioctl_wr(ioctl_wr),
	.ioctl_addr(ioctl_addr),
	.ioctl_dout(ioctl_dout),
	.ioctl_wait(ioctl_wait),
	.ld_download(ld_download),
	.ld_index(ld_index),
	.ld_wr(ld_wr),
	.ld_addr(ld_addr),
	.ld_dout(ld_dout),
	.ld_wait(ld_wait),
	.ld_ddr_pending(ld_ddr_pending),
	.rom_download(rom_download),
	.ddr_addr(stg_ddr_addr),
	.ddr_rd(stg_ddr_rd),
	.ddr_dout(stg_ddr_dout),
	.ddr_dout_ready(stg_ddr_dout_ready),
	.ddr_busy(stg_ddr_busy)
);

wire [24:1] ld_sdram_addr;
wire [15:0] ld_sdram_din;
wire        ld_sdram_req, ld_sdram_ack;
wire        snd_rom_we;
wire [15:0] snd_rom_addr;
wire  [7:0] snd_rom_data;
wire [28:0] ld_ddr_addr;
wire [63:0] ld_ddr_din;
wire        ld_ddr_we, ld_ddr_busy;
wire [24:0] rle_words;

gx2_loader gx2_loader
(
	.clk(clk_sys),
	.reset(~pll_locked),
	.ioctl_download(ld_download),
	.ioctl_index(ld_index),
	.ioctl_wr(ld_wr),
	.ioctl_addr(ld_addr),
	.ioctl_dout(ld_dout),
	.ioctl_wait(ld_wait),
	.sdram_addr(ld_sdram_addr),
	.sdram_din(ld_sdram_din),
	.sdram_req(ld_sdram_req),
	.sdram_ack(ld_sdram_ack),
	.snd_rom_we(snd_rom_we),
	.snd_rom_addr(snd_rom_addr),
	.snd_rom_data(snd_rom_data),
	.ddr_addr(ld_ddr_addr),
	.ddr_din(ld_ddr_din),
	.ddr_we(ld_ddr_we),
	.ddr_busy(ld_ddr_busy),
	.ddr_pending(ld_ddr_pending),
	.rle_words(rle_words)
);

///////////////////////   DDR3   /////////////////////////////////

wire [28:0] rle_ddr_addr;
wire        rle_ddr_rd, rle_ddr_wr;
wire  [7:0] rle_ddr_burstcnt;
wire [63:0] rle_ddr_din;
wire  [7:0] rle_ddr_be;
wire [63:0] rle_ddr_dout;
wire        rle_ddr_dout_ready, rle_ddr_busy;

gx2_ddrarb gx2_ddrarb
(
	.clk(clk_sys),
	.reset(~pll_locked),
	.loader_sel(rom_download | ld_ddr_pending),
	.loader_addr(ld_ddr_addr),
	.loader_din(ld_ddr_din),
	.loader_we(ld_ddr_we),
	.loader_busy(ld_ddr_busy),
	.rle_addr(rle_ddr_addr),
	.rle_rd(rle_ddr_rd),
	.rle_wr(rle_ddr_wr),
	.rle_burstcnt(rle_ddr_burstcnt),
	.rle_din(rle_ddr_din),
	.rle_be(rle_ddr_be),
	.rle_dout(rle_ddr_dout),
	.rle_dout_ready(rle_ddr_dout_ready),
	.rle_busy(rle_ddr_busy),
	.stg_addr(stg_ddr_addr),
	.stg_rd(stg_ddr_rd),
	.stg_dout(stg_ddr_dout),
	.stg_dout_ready(stg_ddr_dout_ready),
	.stg_busy(stg_ddr_busy),
	.DDRAM_CLK(DDRAM_CLK),
	.DDRAM_BUSY(DDRAM_BUSY),
	.DDRAM_BURSTCNT(DDRAM_BURSTCNT),
	.DDRAM_ADDR(DDRAM_ADDR),
	.DDRAM_DOUT(DDRAM_DOUT),
	.DDRAM_DOUT_READY(DDRAM_DOUT_READY),
	.DDRAM_RD(DDRAM_RD),
	.DDRAM_DIN(DDRAM_DIN),
	.DDRAM_BE(DDRAM_BE),
	.DDRAM_WE(DDRAM_WE)
);

///////////////////////   SDRAM   ////////////////////////////////

// port 0 the OKI samples, 1 the 68EC020's program, 2 the tiles, 3 the loader
wire [24:1] cpu_sdram_addr;
wire        cpu_sdram_req, cpu_sdram_ack;
wire [15:0] sdram_dout0, sdram_dout1, sdram_dout2;
wire [24:1] video_rom_addr;
wire        video_rom_req, video_rom_ack;

wire        pcm_req;
wire [19:0] pcm_addr;
reg         pcm_ack;
reg   [7:0] pcm_q;
reg         snd_req = 1'b0;
wire        snd_ack;
reg         snd_busy = 1'b0;
reg  [24:1] snd_addr;
always @(posedge clk_sys) begin
	pcm_ack <= 1'b0;
	if (!snd_busy && pcm_req && !pcm_ack) begin
		snd_addr <= 24'(({4'b0, pcm_addr} + 24'h080000) >> 1);   // OKI1 at 0x080000, OKI2 at 0x100000 (the image)
		snd_req  <= ~snd_req;
		snd_busy <= 1'b1;
	end else if (snd_busy && snd_ack == snd_req) begin
		pcm_q    <= pcm_addr[0] ? sdram_dout0[7:0] : sdram_dout0[15:8];
		pcm_ack  <= 1'b1;
		snd_busy <= 1'b0;
	end
end

sdram sdram
(
	.SDRAM_DQ(SDRAM_DQ),
	.SDRAM_A(SDRAM_A),
	.SDRAM_DQML(SDRAM_DQML),
	.SDRAM_DQMH(SDRAM_DQMH),
	.SDRAM_BA(SDRAM_BA),
	.SDRAM_nCS(SDRAM_nCS),
	.SDRAM_nWE(SDRAM_nWE),
	.SDRAM_nRAS(SDRAM_nRAS),
	.SDRAM_nCAS(SDRAM_nCAS),
	.SDRAM_CLK(SDRAM_CLK),
	.SDRAM_CKE(SDRAM_CKE),

	.init(~pll_locked),
	.clk(clk_sys),

	.addr0(snd_addr), .wrl0(1'b0), .wrh0(1'b0), .din0(16'd0), .dout0(sdram_dout0), .req0(snd_req), .ack0(snd_ack),
	.addr1(cpu_sdram_addr), .wrl1(1'b0), .wrh1(1'b0), .din1(16'd0), .dout1(sdram_dout1), .req1(cpu_sdram_req), .ack1(cpu_sdram_ack),
	.addr2(video_rom_addr), .wrl2(1'b0), .wrh2(1'b0), .din2(16'd0), .dout2(sdram_dout2), .req2(video_rom_req), .ack2(video_rom_ack),
	.addr3(ld_sdram_addr), .wrl3(1'b1), .wrh3(1'b1), .din3(ld_sdram_din), .dout3(), .req3(ld_sdram_req), .ack3(ld_sdram_ack)
);

// the CPU's port runs on clk_cpu: its request toggle and the data cross from / to clk_sys (related clocks, as the
// Primal Rage core's): the toggle is only compared, the data is stable once ack has toggled
wire [15:0] cpu_sdram_dout = sdram_dout1;

///////////////////////   NVRAM   ////////////////////////////////

nvram_hps #(.INDEX(NVRAM_INDEX)) nvram_hps
(
	.clk(clk_sys),
	.ioctl_download(ioctl_download),
	.ioctl_index(ioctl_index),
	.ioctl_wr(ioctl_wr),
	.ioctl_addr(ioctl_addr),
	.ioctl_dout(ioctl_dout),
	.wr_toggle(nv_wr_toggle),
	.autosave(status[12]),
	.save_req(status[13]),
	.nv_addr(nv_addr),
	.nv_din(nv_din),
	.nv_we(nv_we),
	.upload_req(nv_upload_req)
);

///////////////////////   MAIN BOARD   ///////////////////////////

wire [15:1] vram_addr;
wire [15:0] vram_din, vram_dout;
wire  [1:0] vram_we;
wire [11:1] pal_addr;
wire [15:0] pal_din, pal_dout;
wire  [1:0] pal_we;
wire [11:1] oram_addr;
wire [15:0] oram_din, oram_dout;
wire  [1:0] oram_we;
wire  [2:0] mo_control;
wire [15:0] mo_command;
wire        snd_reset;
wire        cmd_tgl, rsp_rd_tgl;
wire  [7:0] cmd_data, rsp_data;
wire        main_to_sound_ready, sound_to_main_ready;
wire        vblank, hblank, vsync, hsync, vblank_rise, ce_pix;
wire  [8:0] hcnt, vcnt;
wire [31:0] p1p2;
wire [63:0] analog;
wire        coin1, coin2;

gx2_main gx2_main
(
	.clk_cpu(clk_cpu),
	.reset(reset_cpu),
	.cpu_reset(hold_cpu),
	.clear_done(clear_done),
	.sel95(~game),
	.cpu_rate(cpu_rate),

	.sdram_addr(cpu_sdram_addr),
	.sdram_req(cpu_sdram_req),
	.sdram_ack(cpu_sdram_ack),
	.sdram_dout(cpu_sdram_dout),

	.vram_addr(vram_addr), .vram_din(vram_din), .vram_we(vram_we), .vram_dout(vram_dout),
	.pal_addr(pal_addr), .pal_din(pal_din), .pal_we(pal_we), .pal_dout(pal_dout),
	.oram_addr(oram_addr), .oram_din(oram_din), .oram_we(oram_we), .oram_dout(oram_dout),

	.mo_control(mo_control),
	.mo_command(mo_command),
	.snd_reset(snd_reset),

	.cmd_tgl(cmd_tgl), .cmd_data(cmd_data), .rsp_rd_tgl(rsp_rd_tgl), .rsp_data(rsp_data),
	.main_to_sound_ready(main_to_sound_ready), .sound_to_main_ready(sound_to_main_ready),

	.vblank(vblank),
	.p1p2(p1p2),
	.test_n(~status[11]),
	.analog(analog),

	.clk_nv(clk_sys),
	.nv_addr(nv_addr), .nv_din(nv_din), .nv_we(nv_we), .nv_q(nv_q), .nv_wr_toggle(nv_wr_toggle),

	.dbg_pc()
);

///////////////////////   SOUND   ////////////////////////////////

wire signed [15:0] snd_l, snd_r;

gx2_jsa gx2_jsa
(
	.clk(clk_sys),
	.rst(reset | rom_download),
	.snd_reset(snd_reset),
	.cmd_tgl(cmd_tgl), .cmd_data(cmd_data), .rsp_rd_tgl(rsp_rd_tgl), .rsp_data(rsp_data),
	.main_to_sound_ready(main_to_sound_ready), .sound_to_main_ready(sound_to_main_ready),
	.coin1(coin1), .coin2(coin2), .service1(1'b0), .tilt(1'b0),
	.rom_we(snd_rom_we), .rom_addr(snd_rom_addr), .rom_data(snd_rom_data),
	.pcm_req(pcm_req), .pcm_addr(pcm_addr), .pcm_ack(pcm_ack), .pcm_q(pcm_q),
	.out_l(snd_l), .out_r(snd_r)
);

reg signed [15:0] aud_l, aud_r;
always @(posedge clk_sys) begin
	aud_l <= snd_l >>> status[9:8];
	aud_r <= snd_r >>> status[9:8];
end
assign AUDIO_L = aud_l;
assign AUDIO_R = aud_r;

///////////////////////   VIDEO   ////////////////////////////////

wire  [8:0] fb_rd_x;
wire  [7:0] fb_rd_y;
wire [15:0] fb_rd_data;
wire  [7:0] vid_r, vid_g, vid_b;

gx2_video gx2_video
(
	.clk(clk_sys),
	.clk_cpu(clk_cpu),
	.reset(~pll_locked),        // the raster keeps running through resets and downloads (the loading screen)
	.pf_base(game ? 11'h400 : 11'h000),

	.ce_pix(ce_pix), .hblank(hblank), .vblank(vblank), .hsync(hsync), .vsync(vsync),
	.hcnt(hcnt), .vcnt(vcnt), .vblank_rise(vblank_rise),

	.vram_addr(vram_addr), .vram_din(vram_din), .vram_we(vram_we), .vram_dout(vram_dout),
	.pal_addr(pal_addr), .pal_din(pal_din), .pal_we(pal_we), .pal_dout(pal_dout),

	.rom_addr(video_rom_addr), .rom_req(video_rom_req), .rom_ack(video_rom_ack), .rom_dout(sdram_dout2),

	.fb_rd_x(fb_rd_x), .fb_rd_y(fb_rd_y), .fb_rd_data(fb_rd_data),

	.r(vid_r), .g(vid_g), .b(vid_b)
);

wire [7:0] mo_next_line = (vcnt >= 9'd261) ? 8'd0 : vcnt[7:0] + 8'd1;

rle_objects #(.ROM_WORDS(32'd4194304)) rle_objects
(
	.clk(clk_sys),
	.clk_cpu(clk_cpu),
	.reset(~pll_locked | rom_download),

	.hblank(hblank),
	.vblank(vblank),
	.next_line(mo_next_line),

	.control(mo_control),
	.mo_command(mo_command),
	.vblank_rise(vblank_rise),
	.tmek(1'b0),
	.colmask(game ? 16'h01F0 : 16'h03F0),
	.palbase(game ? 16'h0200 : 16'h0400),
	.rom_words(rle_words),

	.oram_addr(oram_addr), .oram_din(oram_din), .oram_dout(oram_dout), .oram_we(oram_we),

	.fb_rd_x(fb_rd_x), .fb_rd_y(fb_rd_y), .fb_rd_tm(), .fb_rd_data(fb_rd_data), .fb_rd_frame(mo_control[2]),

	.ddr_addr(rle_ddr_addr), .ddr_rd(rle_ddr_rd), .ddr_we(rle_ddr_wr), .ddr_burstcnt(rle_ddr_burstcnt),
	.ddr_din(rle_ddr_din), .ddr_be(rle_ddr_be), .ddr_dout(rle_ddr_dout), .ddr_dout_ready(rle_ddr_dout_ready),
	.ddr_busy(rle_ddr_busy),

	.prescan_start(prescan_start),
	.prescan_done(prescan_done)
);

///////////////////////   INPUTS   ///////////////////////////////

gx2_inputs gx2_inputs
(
	.clk(clk_sys),
	.frame(vblank_rise),
	.game(game),
	.joy0(joystick_0), .joy1(joystick_1),
	.ana_l0(joystick_l_analog_0), .ana_r0(joystick_r_analog_0),
	.ana_l1(joystick_l_analog_1), .ana_r1(joystick_r_analog_1),
	.paddle0(paddle_0), .spinner0(spinner_0), .mouse(ps2_mouse),
	.sl_src(status[16:14]), .sl_inv_y(status[17]), .sl_thr_axis(status[18]), .sl_swap(status[19]),
	.mf_steer(status[23:21]), .mf_thr(status[26:24]), .mf_sens(status[28:27]), .mf_inv(status[29]),
	.dpad_speed(status[31:30]), .dpad_rel(status[41:40]), .deadzone(status[37:36]), .sens(status[39:38]),
	.p1p2(p1p2), .analog(analog), .coin1(coin1), .coin2(coin2)
);

///////////////////////   VIDEO OUT   ////////////////////////////

// CRT Adjust (H-Size, H-Position, V-Shift) through rmonic79's line buffer; off while the scandoubler is in use
wire        crt_sd = (|status[5:3]) | forced_scandoubler;
wire        crt_on = status[101] & ~crt_sd;
wire        ca_ce, ca_hblank, ca_vblank, ca_hs, ca_vs, ca_de_osd;
wire [23:0] vid_rgb;
gx2_crtadj #(.VTOTAL(262), .HTOTAL(456)) u_crtadj
(
	.clk(clk_sys), .i_on(crt_on), .i_hsize_f(status[100:96]), .i_hpos_f(status[85:79]), .i_vshift_f(status[78:74]), .i_pdot(5'd12),
	.i_ce(ce_pix), .i_hblank(hblank), .i_vblank(vblank), .i_hs(hsync), .i_vs(vsync), .i_rgb({vid_r, vid_g, vid_b}),
	.o_ce(ca_ce), .o_hblank(ca_hblank), .o_vblank(ca_vblank), .o_hs(ca_hs), .o_vs(ca_vs), .o_rgb(vid_rgb), .o_de_osd(ca_de_osd)
);

wire vga_de_mix;
arcade_video #(.WIDTH(336), .DW(24)) arcade_video
(
	.*,
	.clk_video(clk_sys),
	.ce_pix(ca_ce),
	.RGB_in(vid_rgb),
	.HBlank(ca_hblank),
	.VBlank(ca_vblank),
	.HSync(ca_hs),
	.VSync(ca_vs),
	.fx(status[5:3]),
	.VGA_DE(vga_de_mix)
);

video_freak video_freak
(
	.CLK_VIDEO(CLK_VIDEO),
	.CE_PIXEL(CE_PIXEL),
	.VGA_VS(VGA_VS),
	.HDMI_WIDTH(HDMI_WIDTH),
	.HDMI_HEIGHT(HDMI_HEIGHT),
	.VGA_DE(VGA_DE),
	.VIDEO_ARX(VIDEO_ARX),
	.VIDEO_ARY(VIDEO_ARY),
	.VGA_DE_IN(crt_on ? ca_de_osd : vga_de_mix),
	.ARX(arx),
	.ARY(ary),
	.CROP_SIZE(12'd0),
	.CROP_OFF(5'd0),
	.SCALE(scale_sel)
);

endmodule
