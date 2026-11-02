// Atari GX2 XGA protection FPGAs, from MAME 0.289 atarixga.cpp (Morten Shearman Kirkegaard, Samuel Neves,
// Peter Wilhelmsen):
//   136094-0072 (Moto Frenzy)  sel95 = 0
//   136095-0072 (Space Lords)  sel95 = 1, plus the POLYLSB registers at C80F00-C80FFF
//
// The port is the 68EC020's 32-bit bus as MAME sees it: one access per long word with its byte lanes
// (ACCESSING_BITS_16_31 = be[3] | be[2], ACCESSING_BITS_0_15 = be[1] | be[0]). gx2_main.sv joins TG68K's two 16-bit
// cycles of a long access into one of these. MAME's log of both games (tools/capture.py --prot): the XGA window
// only ever sees 16-bit accesses; POLYLSB byte writes, byte reads and (the boot test) long reads.
//
// decipher(): powers2(k, x) is the LFSR lfsr1 stepped from a seed, and lfsr1 is linear, so the XOR of the
// powers2 terms is lfsr1^n applied once to the XOR of the seeds: n clocks. The "identical twins" check
// (lfsr2 from a fixed start, compared with the ciphertext) runs alongside. The result is computed when the
// ciphertext is written (MAME: on the read for 136094; the key comes from the same address either way) and
// busy holds a read until it is ready (~130 clocks at most).

module gx2_xga (
	input             clk,
	input             reset,
	input             sel95,

	input             acc,        // one 32-bit access (a clock pulse)
	input             poly,       // 1: the POLYLSB window (C80F00), 0: the XGA window (CA0000)
	input      [11:2] addr,       // long word address within the 4 KB window
	input             we,
	input      [3:0]  be,         // byte lanes of the 32-bit bus (3 = bits 31:24)
	input      [31:0] wdata,
	output reg [31:0] rdata,      // valid with ready
	output reg        ready,      // pulses when rdata is valid (reads) or the write is taken
	output            busy
);

	// ------------------------------------------------------------------
	// tables
	// ------------------------------------------------------------------
	function automatic [6:0] kmap94(input [6:0] k);
		case (k)
			7'h00: kmap94=7'h6B; 7'h01: kmap94=7'h11; 7'h02: kmap94=7'h1B; 7'h03: kmap94=7'h19;
			7'h04: kmap94=7'h4B; 7'h05: kmap94=7'h50; 7'h06: kmap94=7'h17; 7'h07: kmap94=7'h09;
			7'h08: kmap94=7'h5D; 7'h09: kmap94=7'h69; 7'h0A: kmap94=7'h43; 7'h0B: kmap94=7'h33;
			7'h0C: kmap94=7'h0F; 7'h0D: kmap94=7'h0C; 7'h0E: kmap94=7'h28; 7'h0F: kmap94=7'h3F;
			7'h10: kmap94=7'h00; 7'h11: kmap94=7'h20; 7'h12: kmap94=7'h15; 7'h13: kmap94=7'h3C;
			7'h14: kmap94=7'h57; 7'h15: kmap94=7'h38; 7'h16: kmap94=7'h00; 7'h17: kmap94=7'h07;
			7'h18: kmap94=7'h49; 7'h19: kmap94=7'h25; 7'h1A: kmap94=7'h61; 7'h1B: kmap94=7'h2F;
			7'h1C: kmap94=7'h2B; 7'h1D: kmap94=7'h4E; 7'h1E: kmap94=7'h64; 7'h1F: kmap94=7'h00;
			7'h20: kmap94=7'h45; 7'h21: kmap94=7'h41; 7'h22: kmap94=7'h6D; 7'h23: kmap94=7'h52;
			7'h24: kmap94=7'h31; 7'h25: kmap94=7'h66; 7'h26: kmap94=7'h22; 7'h27: kmap94=7'h59;
			7'h28: kmap94=7'h00; 7'h29: kmap94=7'h70; 7'h2A: kmap94=7'h6F; 7'h2B: kmap94=7'h5B;
			7'h2C: kmap94=7'h46; 7'h2D: kmap94=7'h6E; 7'h2E: kmap94=7'h67; 7'h2F: kmap94=7'h5A;
			7'h30: kmap94=7'h26; 7'h31: kmap94=7'h30; 7'h32: kmap94=7'h2C; 7'h33: kmap94=7'h65;
			7'h34: kmap94=7'h21; 7'h35: kmap94=7'h3D; 7'h36: kmap94=7'h58; 7'h37: kmap94=7'h00;
			7'h38: kmap94=7'h5E; 7'h39: kmap94=7'h44; 7'h3A: kmap94=7'h0D; 7'h3B: kmap94=7'h40;
			7'h3C: kmap94=7'h6C; 7'h3D: kmap94=7'h1C; 7'h3E: kmap94=7'h51; 7'h3F: kmap94=7'h0A;
			7'h40: kmap94=7'h35; 7'h41: kmap94=7'h2A; 7'h42: kmap94=7'h13; 7'h43: kmap94=7'h4D;
			7'h44: kmap94=7'h63; 7'h45: kmap94=7'h00; 7'h46: kmap94=7'h00; 7'h47: kmap94=7'h3A;
			7'h48: kmap94=7'h00; 7'h49: kmap94=7'h48; 7'h4A: kmap94=7'h54; 7'h4B: kmap94=7'h24;
			7'h4C: kmap94=7'h60; 7'h4D: kmap94=7'h1E; 7'h4E: kmap94=7'h2E; 7'h4F: kmap94=7'h01;
			7'h50: kmap94=7'h56; 7'h51: kmap94=7'h03; 7'h52: kmap94=7'h37; 7'h53: kmap94=7'h00;
			7'h54: kmap94=7'h04; 7'h55: kmap94=7'h00; 7'h56: kmap94=7'h05; 7'h57: kmap94=7'h06;
			7'h58: kmap94=7'h00; 7'h59: kmap94=7'h55; 7'h5A: kmap94=7'h1F; 7'h5B: kmap94=7'h02;
			7'h5C: kmap94=7'h36; 7'h5D: kmap94=7'h14; 7'h5E: kmap94=7'h00; 7'h5F: kmap94=7'h3B;
			7'h60: kmap94=7'h5F; 7'h61: kmap94=7'h0E; 7'h62: kmap94=7'h1D; 7'h63: kmap94=7'h0B;
			7'h64: kmap94=7'h27; 7'h65: kmap94=7'h2D; 7'h66: kmap94=7'h3E; 7'h67: kmap94=7'h00;
			7'h68: kmap94=7'h00; 7'h69: kmap94=7'h5C; 7'h6A: kmap94=7'h47; 7'h6B: kmap94=7'h68;
			7'h6C: kmap94=7'h42; 7'h6D: kmap94=7'h53; 7'h6E: kmap94=7'h32; 7'h6F: kmap94=7'h23;
			7'h70: kmap94=7'h4A; 7'h71: kmap94=7'h62; 7'h72: kmap94=7'h4F; 7'h73: kmap94=7'h00;
			7'h74: kmap94=7'h00; 7'h75: kmap94=7'h16; 7'h76: kmap94=7'h39; 7'h77: kmap94=7'h08;
			7'h78: kmap94=7'h6A; 7'h79: kmap94=7'h34; 7'h7A: kmap94=7'h10; 7'h7B: kmap94=7'h29;
			7'h7C: kmap94=7'h12; 7'h7D: kmap94=7'h1A; 7'h7E: kmap94=7'h4C; default: kmap94=7'h18;
		endcase
	endfunction

	function automatic [6:0] kmap95(input [6:0] k);
		case (k)
			7'h00: kmap95=7'h00; 7'h01: kmap95=7'h3C; 7'h02: kmap95=7'h0D; 7'h03: kmap95=7'h0B;
			7'h04: kmap95=7'h5E; 7'h05: kmap95=7'h09; 7'h06: kmap95=7'h2A; 7'h07: kmap95=7'h31;
			7'h08: kmap95=7'h00; 7'h09: kmap95=7'h56; 7'h0A: kmap95=7'h11; 7'h0B: kmap95=7'h4D;
			7'h0C: kmap95=7'h14; 7'h0D: kmap95=7'h34; 7'h0E: kmap95=7'h3A; 7'h0F: kmap95=7'h44;
			7'h10: kmap95=7'h24; 7'h11: kmap95=7'h41; 7'h12: kmap95=7'h51; 7'h13: kmap95=7'h28;
			7'h14: kmap95=7'h1E; 7'h15: kmap95=7'h2F; 7'h16: kmap95=7'h68; 7'h17: kmap95=7'h00;
			7'h18: kmap95=7'h5C; 7'h19: kmap95=7'h49; 7'h1A: kmap95=7'h18; 7'h1B: kmap95=7'h04;
			7'h1C: kmap95=7'h37; 7'h1D: kmap95=7'h00; 7'h1E: kmap95=7'h07; 7'h1F: kmap95=7'h6B;
			7'h20: kmap95=7'h58; 7'h21: kmap95=7'h46; 7'h22: kmap95=7'h0F; 7'h23: kmap95=7'h60;
			7'h24: kmap95=7'h4B; 7'h25: kmap95=7'h6D; 7'h26: kmap95=7'h53; 7'h27: kmap95=7'h20;
			7'h28: kmap95=7'h00; 7'h29: kmap95=7'h70; 7'h2A: kmap95=7'h62; 7'h2B: kmap95=7'h6F;
			7'h2C: kmap95=7'h59; 7'h2D: kmap95=7'h61; 7'h2E: kmap95=7'h6E; 7'h2F: kmap95=7'h54;
			7'h30: kmap95=7'h4A; 7'h31: kmap95=7'h19; 7'h32: kmap95=7'h38; 7'h33: kmap95=7'h6C;
			7'h34: kmap95=7'h42; 7'h35: kmap95=7'h52; 7'h36: kmap95=7'h1F; 7'h37: kmap95=7'h01;
			7'h38: kmap95=7'h57; 7'h39: kmap95=7'h12; 7'h3A: kmap95=7'h15; 7'h3B: kmap95=7'h45;
			7'h3C: kmap95=7'h3D; 7'h3D: kmap95=7'h0E; 7'h3E: kmap95=7'h5F; 7'h3F: kmap95=7'h32;
			7'h40: kmap95=7'h4F; 7'h41: kmap95=7'h36; 7'h42: kmap95=7'h00; 7'h43: kmap95=7'h2C;
			7'h44: kmap95=7'h06; 7'h45: kmap95=7'h00; 7'h46: kmap95=7'h26; 7'h47: kmap95=7'h6A;
			7'h48: kmap95=7'h64; 7'h49: kmap95=7'h5B; 7'h4A: kmap95=7'h48; 7'h4B: kmap95=7'h22;
			7'h4C: kmap95=7'h17; 7'h4D: kmap95=7'h3F; 7'h4E: kmap95=7'h1B; 7'h4F: kmap95=7'h03;
			7'h50: kmap95=7'h66; 7'h51: kmap95=7'h1D; 7'h52: kmap95=7'h2E; 7'h53: kmap95=7'h00;
			7'h54: kmap95=7'h67; 7'h55: kmap95=7'h00; 7'h56: kmap95=7'h00; 7'h57: kmap95=7'h00;
			7'h58: kmap95=7'h65; 7'h59: kmap95=7'h23; 7'h5A: kmap95=7'h40; 7'h5B: kmap95=7'h1C;
			7'h5C: kmap95=7'h50; 7'h5D: kmap95=7'h2D; 7'h5E: kmap95=7'h00; 7'h5F: kmap95=7'h27;
			7'h60: kmap95=7'h13; 7'h61: kmap95=7'h16; 7'h62: kmap95=7'h3E; 7'h63: kmap95=7'h33;
			7'h64: kmap95=7'h1A; 7'h65: kmap95=7'h39; 7'h66: kmap95=7'h43; 7'h67: kmap95=7'h02;
			7'h68: kmap95=7'h00; 7'h69: kmap95=7'h63; 7'h6A: kmap95=7'h5A; 7'h6B: kmap95=7'h55;
			7'h6C: kmap95=7'h47; 7'h6D: kmap95=7'h10; 7'h6E: kmap95=7'h4C; 7'h6F: kmap95=7'h21;
			7'h70: kmap95=7'h5D; 7'h71: kmap95=7'h05; 7'h72: kmap95=7'h00; 7'h73: kmap95=7'h08;
			7'h74: kmap95=7'h25; 7'h75: kmap95=7'h29; 7'h76: kmap95=7'h30; 7'h77: kmap95=7'h69;
			7'h78: kmap95=7'h00; 7'h79: kmap95=7'h4E; 7'h7A: kmap95=7'h35; 7'h7B: kmap95=7'h3B;
			7'h7C: kmap95=7'h00; 7'h7D: kmap95=7'h0C; 7'h7E: kmap95=7'h0A; default: kmap95=7'h2B;
		endcase
	endfunction

	// 136094-0072 powers2 seeds L[0..15], L[16] = L[4] ^ L[5]
	function automatic [15:0] l94(input [4:0] i);
		case (i)
			5'd0:  l94 = 16'h5E85; 5'd1:  l94 = 16'hBD0B; 5'd2:  l94 = 16'h2493; 5'd3:  l94 = 16'h17A3;
			5'd4:  l94 = 16'h2F47; 5'd5:  l94 = 16'h0005; 5'd6:  l94 = 16'h000B; 5'd7:  l94 = 16'h0017;
			5'd8:  l94 = 16'h002F; 5'd9:  l94 = 16'h005E; 5'd10: l94 = 16'h00BD; 5'd11: l94 = 16'h017A;
			5'd12: l94 = 16'h02F4; 5'd13: l94 = 16'h05E8; 5'd14: l94 = 16'h0BD0; 5'd15: l94 = 16'h17A1;
			default: l94 = 16'h2F47 ^ 16'h0005;
		endcase
	endfunction

	reg [7:0] poly_lsb;

	function automatic [15:0] lfsr1(input s95, input [7:0] pl, input [15:0] x);
		lfsr1 = {x[14:0], s95 ? ^(x & (16'hC100 | {8'h00, pl})) : ^(x & 16'h8016)};
	endfunction
	function automatic [15:0] lfsr2(input s95, input [7:0] pl, input [15:0] x);
		lfsr2 = {s95 ? ^(x & (16'h8201 | {7'h00, pl, 1'b0})) : ^(x & 16'h002D), x[15:1]};
	endfunction

	function automatic [4:0] ctz16(input [15:0] x);  // only for a power of two; 0 -> 16
		integer i;
		ctz16 = 5'd16;
		for (i = 15; i >= 0; i = i - 1)
			if (x[i]) ctz16 = i[4:0];
	endfunction

	// ------------------------------------------------------------------
	// key RAM: MAME's 16-bit m_ram keeps only its low byte in use (decipher takes a uint8_t key). Stored as
	// 2048 long words of two bytes, kram_h = m_ram[offset << 1] (the high half of a long), kram_l =
	// m_ram[(offset << 1) + 1]: a long write fills both in one clock.
	// ------------------------------------------------------------------
	(* ramstyle = "M10K" *) reg [7:0] kram_h [0:2047];
	(* ramstyle = "M10K" *) reg [7:0] kram_l [0:2047];
	reg  [10:0] kram_waddr;
	reg  [7:0]  kram_wh, kram_wl;
	reg         kram_weh, kram_wel;
	reg  [11:0] kram_raddr;
	reg  [7:0]  kram_qh, kram_ql;
	reg         kram_rsel;
	always @(posedge clk) if (kram_weh) kram_h[kram_waddr] <= kram_wh;
	always @(posedge clk) if (kram_wel) kram_l[kram_waddr] <= kram_wl;
	always @(posedge clk) kram_qh <= kram_h[kram_raddr[11:1]];
	always @(posedge clk) kram_ql <= kram_l[kram_raddr[11:1]];
	always @(posedge clk) kram_rsel <= kram_raddr[0];
	wire [7:0] kram_q = kram_rsel ? kram_ql : kram_qh;

	// POLYLSB registers (136095): 64 x 32, MAME m_update
	(* ramstyle = "M10K" *) reg [31:0] pram [0:63];
	reg  [5:0]  pram_addr;
	reg  [31:0] pram_wdata;
	reg         pram_we;
	reg  [31:0] pram_q;
	always @(posedge clk) if (pram_we) pram[pram_addr] <= pram_wdata;
	always @(posedge clk) pram_q <= pram[pram_addr];
	reg  [5:0]  upd_addr;

`ifdef SIMULATION
	initial begin
		for (int i = 0; i < 2048; i++) begin kram_h[i] = 8'h00; kram_l[i] = 8'h00; end
		for (int i = 0; i < 64; i++) pram[i] = 32'h0;
	end
`endif

	// ------------------------------------------------------------------
	// state
	// ------------------------------------------------------------------
	localparam M_RESET = 2'd0, M_SETKEY = 2'd1, M_DECIPHER = 2'd2, M_OTHER = 2'd3;  // 136094 / 136095 modes
	reg [1:0]  mode;          // 136095's PROCESS and RESULT both map to M_OTHER (no difference to the bus)
	reg [15:0] m_address;     // 136094: address of the last ciphertext write
	reg [15:0] ctext;
	reg [15:0] reply;         // the deciphered word (136095 m_reply; 136094 the plaintext for m_address)

	wire acc_hi = be[3] | be[2];
	wire acc_lo = be[1] | be[0];

	// byte address of the access within the window: offset << 2, + 2 when the low half is accessed
	wire [12:0] baddr = {addr, acc_lo, 1'b0};

	// key offsets (atarixga.cpp)
	function automatic [11:0] koff94(input [12:0] a);
		koff94 = {2'b00, a[10], a[9], a[5] ^ 1'b1, a[7], a[6], a[1] ^ 1'b1, a[3] ^ 1'b1, a[8], a[2], a[4] ^ 1'b1};
	endfunction
	function automatic [11:0] koff95(input [12:0] a);
		koff95 = {a[12], a[11], a[10], a[9], a[6] ^ 1'b1, a[3], a[5] ^ 1'b1, a[4] ^ 1'b1, a[1], a[7], a[2] ^ 1'b1, a[8] ^ 1'b1};
	endfunction

	// ------------------------------------------------------------------
	// decipher engine
	// ------------------------------------------------------------------
	localparam E_IDLE = 2'd0, E_KEY = 2'd1, E_RUN = 2'd2;
	reg [1:0]  est;
	reg [15:0] e_c, e_p, e_x;
	reg [6:0]  e_n1, e_n2;
	reg        e_match, e_pow2;
	reg        e_start;
	reg [11:0] e_koff;

	assign busy = (est != E_IDLE) | e_start;

	wire [6:0] kidx = kram_q[7] ? (kram_q[6:0] ^ 7'h28) : kram_q[6:0];   // k ^= 0xA8 for k >= 0x80
	wire [6:0] k    = sel95 ? kmap95(kidx) : kmap94(kidx);

	// the XOR of the seeds of every set bit of the ciphertext
	reg [15:0] seed;
	always @(*) begin
		seed = 16'h0;
		if (!sel95) begin
			if ((e_c & (e_c - 16'd1)) == 16'h0)
				seed = l94(ctz16(e_c));
			else
				for (int i = 0; i < 16; i++)
					if (e_c[i]) seed = seed ^ l94((i < 5) ? i[4:0] : i[4:0] + 5'd1);
		end else begin
			if (e_c == 16'h0)
				seed = 16'h0001;                                     // powers2(k, 16): 1 << 0, k + 13 steps
			else if (e_c == 16'h8000)
				seed = 16'h8000;                                     // powers2(k, 15): k + 13 steps
			else if ((e_c & (e_c - 16'd1)) == 16'h0)
				seed = lfsr1(1'b1, poly_lsb, e_c);                   // k + 14 steps = one more, first
			else
				seed = lfsr1(1'b1, poly_lsb, e_c & 16'h7FFF) ^ (e_c[15] ? 16'h0001 : 16'h0000);
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			est <= E_IDLE;
		end else begin
			case (est)
				E_IDLE: if (e_start) est <= E_KEY;          // kram_raddr set with e_start
				E_KEY: begin
					// kram_q valid: k known
					e_pow2  <= ((e_c & (e_c - 16'd1)) == 16'h0);
					e_p     <= seed;
					e_x     <= sel95 ? 16'hC000 : 16'h8010;
					e_n1    <= sel95 ? k + 7'd13 : k;
					e_n2    <= sel95 ? k + 7'd13 : k + 7'd3;
					e_match <= 1'b0;
					est     <= E_RUN;
				end
				E_RUN: begin
					if (e_n1 != 7'd0) begin
						e_p  <= lfsr1(sel95, poly_lsb, e_p);
						e_n1 <= e_n1 - 7'd1;
					end
					if (e_n2 != 7'd0) begin
						if (e_x == e_c) e_match <= 1'b1;
						e_x  <= lfsr2(sel95, poly_lsb, e_x);
						e_n2 <= e_n2 - 7'd1;
					end
					if (e_n1 == 7'd0 && e_n2 == 7'd0) begin
						if (!e_pow2 && e_match)
							reply <= (e_p == 16'd1) ? 16'h0000 : lfsr2(sel95, poly_lsb, e_p);
						else
							reply <= e_p;
						est <= E_IDLE;
					end
				end
				default: est <= E_IDLE;
			endcase
		end
	end

	// ------------------------------------------------------------------
	// bus side
	// ------------------------------------------------------------------
	reg  [1:0] rd_poly;      // POLYLSB read: pram_q valid after two clocks
	reg        rd_poly_hi;
	reg        rd_pending;   // a read waiting for the engine
	reg        rd_hi;
	reg        key_dirty;    // the key RAM changed since the plaintext was computed (136094 reads recompute)

	wire [11:0] lw = {addr, 2'b00};   // offset << 2

	always @(posedge clk) begin
		kram_weh <= 1'b0;
		kram_wel <= 1'b0;
		pram_we  <= 1'b0;
		e_start  <= 1'b0;
		ready    <= 1'b0;

		if (reset) begin
			mode       <= sel95 ? M_SETKEY : M_RESET;   // 136095: m_mode{} = FPGA_SETKEY; 136094: device_reset
			m_address  <= 16'h0;
			ctext      <= 16'h0;
			poly_lsb   <= 8'h00;
			upd_addr   <= 6'd0;
			rd_poly    <= 2'd0;
			rd_pending <= 1'b0;
			key_dirty  <= 1'b0;
		end else if (rd_poly != 2'd0) begin
			rd_poly <= rd_poly - 2'd1;
			if (rd_poly == 2'd1) begin
				// polylsb_read: the stored long; reading the last-written one picks the polynomial
				if (pram_addr == upd_addr)
					poly_lsb <= rd_poly_hi ? pram_q[23:16] : pram_q[7:0];
				rdata <= pram_q;
				ready <= 1'b1;
			end
		end else if (rd_pending) begin
			if (!busy) begin
				rd_pending <= 1'b0;
				rdata      <= rd_hi ? {reply, 16'h0} : {16'h0, reply};
				ready      <= 1'b1;
			end
		end else if (acc && poly) begin
			pram_addr <= addr[7:2];
			if (we) begin
				// polylsb_write keeps the whole data bus: the lanes not written are 0 (MAME's data for a narrower write)
				upd_addr   <= addr[7:2];
				pram_wdata <= wdata & {{8{be[3]}}, {8{be[2]}}, {8{be[1]}}, {8{be[0]}}};
				pram_we    <= 1'b1;
				ready      <= 1'b1;
			end else begin
				rd_poly    <= 2'd2;
				rd_poly_hi <= acc_hi;
			end
		end else if (acc && we) begin
			ready <= 1'b1;
			if (mode == M_SETKEY) begin
				kram_waddr <= {1'b0, addr};
				kram_wh    <= wdata[23:16];
				kram_wl    <= wdata[7:0];
				kram_weh   <= acc_hi;
				kram_wel   <= acc_lo;
				key_dirty  <= 1'b1;
			end else if (mode == M_DECIPHER) begin
				// the low half wins in a long write; 136094 keeps address and ciphertext for the read,
				// 136095 deciphers into m_reply: either way the engine starts now with this address's key
				ctext      <= acc_lo ? wdata[15:0] : wdata[31:16];
				e_c        <= acc_lo ? wdata[15:0] : wdata[31:16];
				m_address  <= {3'b000, baddr};
				kram_raddr <= sel95 ? koff95(baddr) : koff94(baddr);
				e_start    <= 1'b1;
				key_dirty  <= 1'b0;
			end
		end else if (acc && !we) begin
			if (!sel95) begin
				// 136094-0072: the mode switches on the long-word offset, then a DECIPHER-mode read 0x400 above
				// the last ciphertext's address returns its plaintext (in the high half when that is accessed)
				case (lw)
					12'hFC0: mode <= M_RESET;
					12'h010: mode <= M_SETKEY;
					12'h020: mode <= M_DECIPHER;
					default: ;
				endcase
				if (lw != 12'hFC0 && lw != 12'h010 && (mode == M_DECIPHER || lw == 12'h020) &&
				    (baddr - 13'h400) == m_address[12:0]) begin
					rd_pending <= 1'b1;
					rd_hi      <= acc_hi;
					if (key_dirty) begin
						e_c        <= ctext;
						kram_raddr <= koff94(m_address[12:0]);
						e_start    <= 1'b1;
						key_dirty  <= 1'b0;
					end
				end else begin
					rdata <= 32'h0;
					ready <= 1'b1;
				end
			end else begin
				// 136095-0072: the mode switches on the half-word address
				rdata <= 32'h0;
				case (baddr[11:0])
					12'h020: begin mode <= M_SETKEY;   ready <= 1'b1; end
					12'h042: begin mode <= M_DECIPHER; ready <= 1'b1; end
					12'hC00: begin mode <= M_OTHER; rdata <= 32'hFFFFFFFF; ready <= 1'b1; end
					12'hFC0: begin mode <= M_OTHER; rd_pending <= 1'b1; rd_hi <= 1'b1; end
					default: ready <= 1'b1;
				endcase
			end
		end
	end

endmodule
