// Atari GX2 inputs: MAME 0.289 atarigx2.cpp's INPUT_PORTS (P1_P2, the ADC0809's A2D0..7) and the JSA's coins, from
// the MiSTer joysticks, analog sticks, paddle, spinner and mouse, with the OSD's choice of source per control.
//
// Space Lords (game 0): two flight yokes (AD_STICK X/Y, 0x10..0xF0, centre 0x80); MAME's channels:
//   A2D1 P1 Y, A2D4 P1 X, A2D2 P2 X, A2D3 P2 Y. Buttons: P1 Laser, Nuke, Throttle forward, Throttle reverse, Rear view,
//   Start (Hyperspace); P2 Laser, Nuke, Start (Cloak).
// Moto Frenzy (game 1): A2D1 handlebar (AD_STICK_X 0x00..0xFF, sensitivity 50, reversed), A2D2 throttle (PEDAL, reversed).
//   MAME's sensitivity does not narrow the range (ioport.cpp: an absolute stick's value is divided by it before it is
//   applied, the keys' clamp too): a stick and the keys both reach 0x00 and 0xFF; the keys move 10 * 50 % = 5 a frame.
//   Buttons: Start / Fire (B1 or Start), the throttle as a button (B2), AUX1..3 (B3..B5): the operator's buttons, which
//   drive the test menu (AUX1 / AUX2 select, AUX3 does it); the game itself ignores them (docs/status.md).
//
// Every analog axis is a signed position -127..127 (0 = centre) before it is scaled into the port's range:
//   d-pad      the axis moves while held and returns while released (MAME's keydelta per frame; OSD speed; on release
//              it returns at the same speed as MAME, snaps to the centre, or stays)
//   sticks     the MiSTer left / right analog stick, dead zone and sensitivity from the OSD
//   mouse      relative motion accumulated into the position
//   paddle     absolute (paddle_0), spinner relative (spinner_0)
//   auto       the last one used: the left stick once it is pushed past a third, the d-pad once it is pressed (a stick
//              that drifts or a pad that reports an idle axis off centre does not take the control from the d-pad)
//
// joystick_N bits: 0 right, 1 left, 2 down, 3 up, 4.. B1..B6, 10 Start, 11 Coin (CONF_STR J1 order)
`default_nettype none
module gx2_inputs (
	input  wire        clk,
	input  wire        frame,              // one pulse a frame (VBLANK)
	input  wire        game,               // 0 Space Lords, 1 Moto Frenzy

	input  wire [31:0] joy0, joy1,
	input  wire [15:0] ana_l0, ana_r0, ana_l1, ana_r1,   // [7:0] X, [15:8] Y, signed
	input  wire [7:0]  paddle0,
	input  wire [8:0]  spinner0,
	input  wire [24:0] mouse,

	// OSD
	input  wire [2:0]  sl_src,             // Space Lords yoke: 0 auto, 1 d-pad, 2 left stick, 3 right stick, 4 mouse (P1)
	input  wire        sl_inv_y,
	input  wire        sl_thr_axis,        // P1 throttle from the right stick's Y (and its buttons still work)
	input  wire        sl_swap,            // P1 <-> P2 pads
	input  wire [2:0]  mf_steer,           // Moto Frenzy steering: 0 auto, 1 d-pad, 2 left, 3 right, 4 paddle, 5 spinner, 6 mouse
	input  wire [2:0]  mf_thr,             // throttle: 0 button (B2), 1 button ramp, 2 left stick up, 3 right stick up,
	                                       //           4 right stick down, 5 d-pad up
	input  wire [1:0]  mf_sens,            // steering range: 0 full (MAME), 1 75 %, 2 50 %
	input  wire        mf_inv,
	input  wire [1:0]  dpad_speed,         // 0 MAME, 1 slow, 2 fast, 3 instant
	input  wire [1:0]  dpad_rel,           // the d-pad axis when let go: 0 returns (MAME), 1 snaps to the centre, 2/3 stays
	input  wire [1:0]  deadzone,           // 0, 8, 16, 24 (of 127)
	input  wire [1:0]  sens,               // stick sensitivity: 0 100 %, 1 75 %, 2 125 %, 3 150 %

	output reg  [31:0] p1p2,               // active low
	output reg  [63:0] analog,             // A2D0..7
	output wire        coin1, coin2
);
	// the pads after Swap Players, registered (a stage of its own: the swap's mux ahead of the stick arithmetic missed
	// 85.9 MHz by 0.35 ns)
	reg  [31:0] j0, j1;
	reg  [15:0] l0, r0, l1, r1;
	wire        swp = sl_swap && !game;
	always @(posedge clk) begin
		j0 <= swp ? joy1 : joy0;
		j1 <= swp ? joy0 : joy1;
		l0 <= swp ? ana_l1 : ana_l0;
		r0 <= swp ? ana_r1 : ana_r0;
		l1 <= swp ? ana_l0 : ana_l1;
		r1 <= swp ? ana_r0 : ana_r1;
	end

	assign coin1 = joy0[11];
	assign coin2 = joy1[11];

	// ------------------------------------------------------------------ helpers
	function automatic signed [8:0] clamp127(input signed [10:0] v);
		if (v > 127)       clamp127 = 9'sd127;
		else if (v < -127) clamp127 = -9'sd127;
		else               clamp127 = v[8:0];
	endfunction

	// a stick axis after the dead zone and the sensitivity
	function automatic signed [8:0] stick(input [7:0] raw, input [1:0] dz, input [1:0] sn);
		reg signed [8:0]  v;
		reg [7:0]         mag;
		reg signed [10:0] s;
		v   = (raw == 8'h80) ? -9'sd127 : {raw[7], raw};
		mag = v[8] ? -v[7:0] : v[7:0];
		if (mag < {1'b0, dz, 3'b000}) v = 9'sd0;
		case (sn)
			2'd0: s = v;
			2'd1: s = (v * 3) >>> 2;
			2'd2: s = (v * 5) >>> 2;
			default: s = (v * 3) >>> 1;
		endcase
		stick = clamp127(s);
	endfunction

	// a deliberate push of a stick axis (past 40 of 127)
	function automatic pushed(input [7:0] raw);
		reg [7:0] mag;
		mag = raw[7] ? -raw : raw;
		pushed = mag > 8'd40;
	endfunction

	// Auto's source per pad: 1 the left stick, 0 the d-pad, whichever was used last. The stick takes over when a push
	// starts (an edge), so one that sits off centre for good hands the control back to the d-pad after one press.
	reg  auto_l0 = 1'b0, auto_l1 = 1'b0;
	reg  push_l0_d = 1'b0, push_l1_d = 1'b0;
	wire push_l0 = pushed(l0[7:0]) || pushed(l0[15:8]);
	wire push_l1 = pushed(l1[7:0]) || pushed(l1[15:8]);
	always @(posedge clk) begin
		push_l0_d <= push_l0;
		push_l1_d <= push_l1;
		if (|j0[3:0])                    auto_l0 <= 1'b0;
		else if (push_l0 && !push_l0_d)  auto_l0 <= 1'b1;
		if (|j1[3:0])                    auto_l1 <= 1'b0;
		else if (push_l1 && !push_l1_d)  auto_l1 <= 1'b1;
	end

	// the d-pad's per-frame step: MAME's keydelta 10 at sensitivity 100 in Space Lords' 0x10..0xF0 port is 11 of 127;
	// Moto Frenzy's handlebar at sensitivity 50 moves 5 of its 0x00..0xFF a frame, 5 of 127 at the full range
	reg [7:0] step;
	always @(posedge clk)
		case (dpad_speed)
			2'd0:    step <= game ? 8'd5  : 8'd11;     // MAME
			2'd1:    step <= game ? 8'd3  : 8'd5;      // slow
			2'd2:    step <= game ? 8'd12 : 8'd24;     // fast
			default: step <= 8'd127;                   // instant
		endcase

	function automatic signed [8:0] ramp(input signed [8:0] pos, input plus, input minus, input [7:0] st, input [1:0] rel);
		reg signed [10:0] n;
		if (plus && !minus)        n = pos + $signed({3'b0, st});
		else if (minus && !plus)   n = pos - $signed({3'b0, st});
		else if (rel[1])           n = pos;
		else if (rel[0])           n = 0;
		else if (pos > $signed({1'b0, st}))  n = pos - $signed({3'b0, st});
		else if (pos < -$signed({1'b0, st})) n = pos + $signed({3'b0, st});
		else                       n = 0;
		ramp = clamp127(n);
	endfunction

	// ------------------------------------------------------------------ d-pad, mouse, spinner positions
	reg signed [8:0] dp_x0, dp_y0, dp_x1, dp_y1;    // d-pad axes (Space Lords P1/P2; Moto Frenzy uses dp_x0)
	reg signed [8:0] ms_x, ms_y;                    // mouse
	reg signed [8:0] sp_x;                          // spinner
	reg signed [8:0] thr_r;                         // Moto Frenzy throttle ramp 0..127
	reg              mouse_t, spin_t;

	always @(posedge clk) begin
		if (frame) begin
			dp_x0 <= ramp(dp_x0, j0[0], j0[1], step, dpad_rel);
			dp_y0 <= ramp(dp_y0, j0[2], j0[3], step, dpad_rel);
			dp_x1 <= ramp(dp_x1, j1[0], j1[1], step, dpad_rel);
			dp_y1 <= ramp(dp_y1, j1[2], j1[3], step, dpad_rel);
			// MAME's pedal keydelta 16 of 255: 8 of 127 a frame up while held, back down when released
			if (joy0[5])  thr_r <= (thr_r > 9'sd119) ? 9'sd127 : thr_r + 9'sd8;
			else          thr_r <= (thr_r < 9'sd8)   ? 9'sd0   : thr_r - 9'sd8;
		end
		mouse_t <= mouse[24];
		if (mouse[24] != mouse_t) begin
			ms_x <= clamp127(ms_x + $signed({{3{mouse[4]}}, mouse[15:8]}));
			ms_y <= clamp127(ms_y - $signed({{3{mouse[5]}}, mouse[23:16]}));
		end
		spin_t <= spinner0[8];
		if (spinner0[8] != spin_t)
			sp_x <= clamp127(sp_x + $signed({{3{spinner0[7]}}, spinner0[7:0]}));
	end

	// ------------------------------------------------------------------ Space Lords yokes
	function automatic signed [8:0] pick(input [2:0] src, input signed [8:0] dp, input [7:0] lraw, input [7:0] rraw,
	                                     input signed [8:0] ms, input [1:0] dz, input [1:0] sn, input use_l);
		case (src)
			3'd1: pick = dp;
			3'd2: pick = stick(lraw, dz, sn);
			3'd3: pick = stick(rraw, dz, sn);
			3'd4: pick = ms;
			default: pick = use_l ? stick(lraw, dz, sn) : dp;
		endcase
	endfunction

	// two stages (85.9 MHz): the positions are registered here, scaled into the ports below
	wire [2:0] src1 = (sl_src == 3'd4) ? 3'd0 : sl_src;   // the mouse is P1's only
	reg signed [8:0] sl_x0, sl_y0, sl_x1, sl_y1;
	always @(posedge clk) begin
		sl_x0 <= pick(sl_src, dp_x0, l0[7:0],  r0[7:0],  ms_x, deadzone, sens, auto_l0);
		sl_y0 <= pick(sl_src, dp_y0, l0[15:8], r0[15:8], ms_y, deadzone, sens, auto_l0);
		sl_x1 <= pick(src1,   dp_x1, l1[7:0],  r1[7:0],  ms_x, deadzone, sens, auto_l1);
		sl_y1 <= pick(src1,   dp_y1, l1[15:8], r1[15:8], ms_y, deadzone, sens, auto_l1);
	end

	// 0x80 + v * 0x70 / 127 (MINMAX 0x10, 0xF0); Y as the stick gives it (down = larger), optionally inverted
	function automatic [7:0] yoke(input signed [8:0] v);
		reg signed [17:0] p;
		reg signed [9:0]  q;
		p = v * 18'sd113;               // 0x70 / 127 * 128
		q = 10'sd128 + (p >>> 7);
		yoke = (q < 10'sd16) ? 8'h10 : (q > 10'sd240) ? 8'hF0 : q[7:0];
	endfunction

	// the right stick's Y as the throttle: forward / reverse buttons when pushed past half
	reg signed [8:0] thr_axis;
	always @(posedge clk) thr_axis <= stick(r0[15:8], deadzone, 2'd0);
	wire thr_fwd = j0[6] | (sl_thr_axis && thr_axis < -9'sd64);
	wire thr_rev = j0[7] | (sl_thr_axis && thr_axis >  9'sd64);

	// ------------------------------------------------------------------ Moto Frenzy
	reg signed [8:0] mf_x;
	always @(posedge clk) begin
		case (mf_steer)
			3'd1: mf_x <= dp_x0;
			3'd2: mf_x <= stick(ana_l0[7:0], deadzone, sens);
			3'd3: mf_x <= stick(ana_r0[7:0], deadzone, sens);
			3'd4: mf_x <= $signed({1'b0, paddle0}) - 9'sd128;
			3'd5: mf_x <= sp_x;
			3'd6: mf_x <= ms_x;
			default: mf_x <= auto_l0 ? stick(l0[7:0], deadzone, sens) : dp_x0;   // (no swap in Moto Frenzy: l0 = ana_l0)
		endcase
	end

	// steering: 0x80 - x * range (PORT_REVERSE), the full range reaching 0x00 / 0xFF as MAME's (x * 128 / 127, rounded);
	// in three registered stages (the product, the offset, the clamp: one stage missed 85.9 MHz by 0.23 ns)
	reg signed [17:0] steer_p;
	reg signed [10:0] steer_q;
	reg        [7:0]  steer_v;
	always @(posedge clk) begin
		case (mf_sens)
			2'd1:    steer_p <= (mf_inv ? -mf_x : mf_x) * 18'sd97;    // 75 %
			2'd2:    steer_p <= (mf_inv ? -mf_x : mf_x) * 18'sd65;    // 50 %
			default: steer_p <= (mf_inv ? -mf_x : mf_x) * 18'sd129;   // full (MAME)
		endcase
		steer_q <= 11'sd128 - ((steer_p + 18'sd64) >>> 7);
		steer_v <= (steer_q < 0) ? 8'h00 : (steer_q > 11'sd255) ? 8'hFF : steer_q[7:0];
	end

	// throttle amount 0 (released) .. 127 (full), PEDAL reversed: the port reads 0xFF released
	reg [7:0] thr;
	always @(posedge clk) begin
		case (mf_thr)
			3'd0: thr <= joy0[5] ? 8'd127 : 8'd0;
			3'd1: thr <= thr_r[7:0];
			3'd2: thr <= (stick(ana_l0[15:8], deadzone, 2'd0) < 0) ? -stick(ana_l0[15:8], deadzone, 2'd0) : 8'd0;
			3'd3: thr <= (stick(ana_r0[15:8], deadzone, 2'd0) < 0) ? -stick(ana_r0[15:8], deadzone, 2'd0) : 8'd0;
			3'd4: thr <= (stick(ana_r0[15:8], deadzone, 2'd0) > 0) ?  stick(ana_r0[15:8], deadzone, 2'd0) : 8'd0;
			default: thr <= joy0[3] ? 8'd127 : 8'd0;
		endcase
	end
	wire [7:0] pedal = 8'hFF - {thr[6:0], thr[6]};   // 0..127 -> 0..255, reversed

	// ------------------------------------------------------------------ ports
	always @(posedge clk) begin
		if (!game) begin
			// MAME's bits, active low
			p1p2[31] <= 1'b1;
			p1p2[30] <= ~j0[8];                  // P1 Button 5: rear view
			p1p2[29] <= 1'b1;
			p1p2[28] <= 1'b1;
			p1p2[27] <= ~thr_fwd;                // P1 Button 3: throttle forward
			p1p2[26] <= ~j0[4];                  // P1 Button 1: laser
			p1p2[25] <= ~j0[5];                  // P1 Button 2: nuke
			p1p2[24] <= ~j1[10];                 // Start 2 (co-pilot: cloak)
			p1p2[23:16] <= 8'hFF;
			p1p2[15] <= 1'b1;
			p1p2[14] <= 1'b1;
			p1p2[13] <= 1'b1;
			p1p2[12] <= 1'b1;
			p1p2[11] <= ~thr_rev;                // P1 Button 4: throttle reverse
			p1p2[10] <= ~j1[4];                  // P2 Button 1: laser
			p1p2[9]  <= ~j1[5];                  // P2 Button 2: nuke
			p1p2[8]  <= ~j0[10];                 // Start 1 (pilot: hyperspace)
			p1p2[7:0] <= 8'hFF;
			analog <= {8'hFF, 8'hFF, 8'hFF,
			           yoke(sl_x0),                                   // A2D4 P1 X
			           yoke(sl_inv_y ? -sl_y1 : sl_y1),               // A2D3 P2 Y
			           yoke(sl_x1),                                   // A2D2 P2 X
			           yoke(sl_inv_y ? -sl_y0 : sl_y0),               // A2D1 P1 Y
			           8'hFF};
		end else begin
			p1p2[31:28] <= 4'hF;
			p1p2[27] <= ~j0[6];                  // AUX1 (Button 3): test menu select
			p1p2[26] <= ~j0[7];                  // AUX2 (Button 4): test menu select
			p1p2[25] <= ~j0[8];                  // AUX3 (Button 5): test menu do it / exit
			p1p2[24] <= ~(j0[10] | j0[4]);       // Start / Fire (Start or Button 1)
			p1p2[23:0] <= 24'hFFFFFF;
			analog <= {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF,
			           pedal,                                         // A2D2 throttle
			           steer_v,                                       // A2D1 handlebar
			           8'hFF};
		end
	end

endmodule
`default_nettype wire
