// Atari GX2 main board: the 68EC020 (TG68K in 68020 mode), its memory map and I/O, from MAME 0.289 atarigx2.cpp
// (main_map, latch_w, mo_command_w, the input ports, init_spclords / init_motofren). Structure from the Primal
// Rage core's cpu_bus.sv (MiSTer-devel/Arcade-PrimalRage_MiSTer, Nortido, GPL-3), the GT board's map being a
// close relative.
//
//   000000-07FFFF program ROM (SDRAM)          C80000-C80FFF RAM (C80F00-C80FFF: POLYLSB on Space Lords)
//   CA0000-CA0FFF XGA protection               D00000-D0000F ADC0809 (channel = A3..A1, byte lane 15:8)
//   D20000-D20FFF EEPROM 2816 (lane 15:8)      D40000-D40FFF palette            D70000-D7FFFF video RAM
//   D78000-D78FFF RLE object RAM               D7A200 MO command (low word)     D80000-D9FFFF EEPROM unlock
//   E06000 JSA command (byte, lane 15:8)       E08000 latch                      E0C000 VBLANK IRQ ack
//   E80000 P1_P2   E82000 SERVICE (both halves)   E82004 SPECIAL   E86000 JSA response (lane 15:8)
//   FF8000-FFFFFF work RAM
//   IRQ 4: VBLANK (until acked); IRQ 5: the JSA's response (sound_to_main_ready)
//
// The board's 32-bit bus: TG68K splits a long access into two 16-bit cycles; MAME sees one. The XGA and POLYLSB
// windows answer differently to a long than to two words (atarixga.cpp), so there the two halves are joined: the
// first half of a long (TG68K's longword) is held, and the access goes to gx2_xga as one 32-bit cycle.
//
// Every RAM is block RAM except the program ROM; all are cleared (MAME's power-on zeros) while cpu_reset is held
// after a reset, which the top level keeps up until the clear is done.
//
// Program ROM reads go through a 16 KB direct-mapped word cache (8K words, tag A18..A14): a hit takes three CPU clocks,
// a miss the SDRAM's ~8. The real 68EC020 has its own instruction cache and a 32-bit bus; TG68K fetches every word.

module gx2_main (
	input  logic        clk_cpu,          // clk_sys / 2
	input  logic        reset,            // everything
	input  logic        cpu_reset,        // the CPU only (download, prescan)
	output logic        clear_done,

	input  logic        sel95,            // Space Lords board (136095-0072 + POLYLSB); else Moto Frenzy (136094-0072)
	input  logic [4:0]  cpu_rate,         // the CPU's pace: at most cpu_rate / 16 steps a clock; 16 or more: unpaced

	// program ROM in the SDRAM (toggle request)
	output logic [24:1] sdram_addr,
	output logic        sdram_req,
	input  logic        sdram_ack,
	input  logic [15:0] sdram_dout,

	// video RAM, palette, object RAM (block RAMs in gx2_video / rle_objects, 1-clock reads)
	output logic [15:1] vram_addr,
	output logic [15:0] vram_din,
	output logic [1:0]  vram_we,
	input  logic [15:0] vram_dout,
	output logic [11:1] pal_addr,
	output logic [15:0] pal_din,
	output logic [1:0]  pal_we,
	input  logic [15:0] pal_dout,
	output logic [11:1] oram_addr,
	output logic [15:0] oram_din,
	output logic [1:0]  oram_we,
	input  logic [15:0] oram_dout,

	output logic [2:0]  mo_control,
	output logic [15:0] mo_command,
	output logic        snd_reset,        // latch D4 (/SNDRES) low

	// JSA (levels from clk_sys, read directly; toggles to it)
	output logic        cmd_tgl,
	output logic [7:0]  cmd_data,
	output logic        rsp_rd_tgl,
	input  logic [7:0]  rsp_data,
	input  logic        main_to_sound_ready,
	input  logic        sound_to_main_ready,

	input  logic        vblank,
	input  logic [31:0] p1p2,             // active low, MAME's P1_P2
	input  logic        test_n,           // SERVICE bit 6 (self test switch, active low)
	input  logic [63:0] analog,           // ADC0809 channels 0..7, [8n+7:8n]

	// EEPROM NVRAM port (clk_nv)
	input  logic        clk_nv,
	input  logic [10:0] nv_addr,
	input  logic [7:0]  nv_din,
	input  logic        nv_we,
	output logic [7:0]  nv_q,
	output logic        nv_wr_toggle = 1'b0,

	// debug
	output logic [31:0] dbg_pc
);

	// ------------------------------------------------------------------ CPU
	wire [31:0] cpu_addr;
	logic [15:0] cpu_din;
	wire [15:0] cpu_dout;
	wire        nwr, nuds, nlds, longword;
	wire [1:0]  busstate;
	logic       cpu_ready;
	logic [2:0] ipl;

	wire cpu_rd = (busstate == 2'b00) || (busstate == 2'b10);
	wire cpu_wr = (busstate == 2'b11);
	wire cpu_uds = ~nuds;
	wire cpu_lds = ~nlds;

	TG68KdotC_Kernel u_cpu (
		.clk(clk_cpu),
		.nReset(~(reset | cpu_reset)),
		.clkena_in(cpu_ready),             // low for the whole access, its first clock too
		.data_in(cpu_din),
		.IPL(ipl),
		.IPL_autovector(1'b1),
		.berr(1'b0),
		.CPU(2'b11),                       // 68020
		.addr_out(cpu_addr),
		.data_write(cpu_dout),
		.nWr(nwr),
		.nUDS(nuds),
		.nLDS(nlds),
		.busstate(busstate),
		.longword(longword),
		.nResetOut(), .FC(), .clr_berr(), .skipFetch(), .regin_out(), .CACR_out(), .D_CACHE_out(), .VBR_out()
	);
	assign dbg_pc = cpu_addr;

	// ------------------------------------------------------------------ decode (byte addresses, 24-bit bus)
	wire [23:0] a = cpu_addr[23:0];
	wire is_rom     = (a < 24'h080000);
	wire is_c8ram   = (a[23:12] == 12'hC80);
	wire is_poly    = sel95 && (a[23:8] == 16'hC80F);
	wire is_xga     = (a[23:12] == 12'hCA0);
	wire is_adc     = (a[23:4]  == 20'hD0000);
	wire is_eeprom  = (a[23:12] == 12'hD20);
	wire is_pal     = (a[23:12] == 12'hD40);
	wire is_vidram  = (a[23:16] == 8'hD7);
	wire is_oram    = (a[23:12] == 12'hD78);
	wire is_unlock  = (a[23:17] == 7'b1101_100);            // D80000-D9FFFF
	wire [23:0] al  = {a[23:2], 2'b00};                     // the long word's address
	wire is_cmd     = (al == 24'hE06000);
	wire is_latch   = (al == 24'hE08000);
	wire is_vack    = (al == 24'hE0C000);
	wire is_p1p2    = (al == 24'hE80000);
	wire is_service = (al == 24'hE82000);
	wire is_special = (al == 24'hE82004);
	wire is_rsp     = (al == 24'hE86000);
	wire is_wram    = (a[23:15] == 9'b1111_1111_1);         // FF8000-FFFFFF
	wire is_prot    = is_xga || is_poly;
	wire is_bram    = (is_c8ram && !is_poly) || is_eeprom || is_pal || is_vidram || is_wram;

	// ------------------------------------------------------------------ RAMs local to the bus
	// work RAM 32 KB and C80000 RAM 4 KB, byte lanes
	logic [15:1] clr_addr;
	logic        clearing;
	wire  [13:0] wram_idx = clearing ? clr_addr[14:1] : a[14:1];
	wire  [10:0] c8_idx   = clearing ? clr_addr[11:1] : a[11:1];
	logic        acc_wr;                       // the write strobe of the access (one clock)
	wire  [1:0]  wram_we = clearing ? 2'b11 : (acc_wr && is_wram) ? {cpu_uds, cpu_lds} : 2'b00;
	wire  [1:0]  c8_we   = clearing ? 2'b11 : (acc_wr && is_c8ram && !is_poly) ? {cpu_uds, cpu_lds} : 2'b00;
	wire  [15:0] ram_wd  = clearing ? 16'h0000 : cpu_dout;

	(* ramstyle = "M10K" *) logic [7:0] wram_h [0:16383];
	(* ramstyle = "M10K" *) logic [7:0] wram_l [0:16383];
	(* ramstyle = "M10K" *) logic [7:0] c8_h [0:2047];
	(* ramstyle = "M10K" *) logic [7:0] c8_l [0:2047];
	logic [7:0] wram_qh, wram_ql, c8_qh, c8_ql;
	always_ff @(posedge clk_cpu) if (wram_we[1]) wram_h[wram_idx] <= ram_wd[15:8];
	always_ff @(posedge clk_cpu) if (wram_we[0]) wram_l[wram_idx] <= ram_wd[7:0];
	always_ff @(posedge clk_cpu) wram_qh <= wram_h[wram_idx];
	always_ff @(posedge clk_cpu) wram_ql <= wram_l[wram_idx];
	always_ff @(posedge clk_cpu) if (c8_we[1]) c8_h[c8_idx] <= ram_wd[15:8];
	always_ff @(posedge clk_cpu) if (c8_we[0]) c8_l[c8_idx] <= ram_wd[7:0];
	always_ff @(posedge clk_cpu) c8_qh <= c8_h[c8_idx];
	always_ff @(posedge clk_cpu) c8_ql <= c8_l[c8_idx];

	// EEPROM 2816 on lane 15:8 (eeprom_parallel_28xx, lock_after_write): stored inverted on both ports, so the
	// block RAM's power-up zeros read as an erased part (0xFF) when no .nvm is loaded
	logic       ee_unlocked;
	wire        we_eeprom = acc_wr && is_eeprom && cpu_uds && ee_unlocked;
	logic [7:0] eeprom_q_inv, nv_q_inv;
	tdp_ram #(.AW(11), .DW(8)) u_eeprom (
		.clk_a(clk_cpu), .addr_a(a[11:1]), .din_a(~cpu_dout[15:8]), .we_a(we_eeprom), .q_a(eeprom_q_inv),
		.clk_b(clk_nv),  .addr_b(nv_addr), .din_b(~nv_din),         .we_b(nv_we),     .q_b(nv_q_inv)
	);
	assign nv_q = ~nv_q_inv;
	always_ff @(posedge clk_cpu) if (we_eeprom) nv_wr_toggle <= ~nv_wr_toggle;

	// video RAMs: the clear writes zeros everywhere
	assign vram_addr = clearing ? clr_addr[15:1] : a[15:1];
	assign vram_din  = clearing ? 16'h0000 : cpu_dout;
	assign vram_we   = clearing ? 2'b11 : (acc_wr && is_vidram && !is_oram) ? {cpu_uds, cpu_lds} : 2'b00;
	assign pal_addr  = clearing ? clr_addr[11:1] : a[11:1];
	assign pal_din   = clearing ? 16'h0000 : cpu_dout;
	assign pal_we    = clearing ? 2'b11 : (acc_wr && is_pal) ? {cpu_uds, cpu_lds} : 2'b00;
	assign oram_addr = clearing ? clr_addr[11:1] : a[11:1];
	assign oram_din  = clearing ? 16'h0000 : cpu_dout;
	assign oram_we   = clearing ? 2'b11 : (acc_wr && is_oram) ? {cpu_uds, cpu_lds} : 2'b00;

	// power-on clear: 32K words (the video RAM's; the smaller RAMs see their low bits, cleared more than once)
	always_ff @(posedge clk_cpu) begin
		if (reset) begin
			clearing   <= 1'b1;
			clear_done <= 1'b0;
			clr_addr   <= 15'd0;
		end else if (clearing) begin
			clr_addr <= clr_addr + 15'd1;
			if (&clr_addr) begin
				clearing   <= 1'b0;
				clear_done <= 1'b1;
			end
		end
	end

	// ------------------------------------------------------------------ ADC0809 (adc0808.cpp)
	// a read returns the result register and starts a conversion of channel A3..A1: one ADC clock to READY, one
	// more to RUNNING (EOC low, SAR sampled), 64 to the end (EOC high, SAR sampled again). ADC clock =
	// 14.318181 MHz / 16 = 48 clk_cpu.
	localparam [11:0] ADC_CLK = 12'd48;
	logic [7:0]  adc_sar;
	logic        adc_eoc;
	logic [1:0]  adc_state;   // 0 idle, 1 start, 2 ready, 3 running
	logic [11:0] adc_cnt;
	logic [2:0]  adc_ch;
	wire  [7:0]  adc_in = analog[8*adc_ch +: 8];

	// ------------------------------------------------------------------ the access sequencer
	localparam [2:0] ST_IDLE = 3'd0, ST_SDRAM = 3'd1, ST_BRAM = 3'd2, ST_PROT = 3'd3, ST_DONE = 3'd4, ST_CACHE = 3'd5;

	// ROM cache: data and {valid, tag}, read with the address of the access (valid the clock after)
	(* ramstyle = "M10K" *) logic [15:0] rc_data [0:8191];
	(* ramstyle = "M10K" *) logic [5:0]  rc_tag  [0:8191];
	logic [15:0] rc_q;
	logic [5:0]  rc_tq;
	logic        rc_we;
	logic [12:0] rc_waddr;
	logic [15:0] rc_wd;
	logic [5:0]  rc_wt;
	wire  [12:0] rc_raddr = a[13:1];
	always_ff @(posedge clk_cpu) if (rc_we) rc_data[rc_waddr] <= rc_wd;
	always_ff @(posedge clk_cpu) if (rc_we) rc_tag[rc_waddr]  <= rc_wt;
	always_ff @(posedge clk_cpu) rc_q  <= rc_data[rc_raddr];
	always_ff @(posedge clk_cpu) rc_tq <= rc_tag[rc_raddr];
	wire rc_hit = rc_tq == {1'b1, a[18:14]};
	logic [2:0]  state;
	logic        req_r;
	logic [15:0] rd_q;           // read data latched for ST_DONE

	// the joined 32-bit protection access
	logic        lw_pend;        // first half of a long write held
	logic [15:0] lw_hi;
	logic        lr_pend;        // second half of a long read ready
	logic [15:0] lr_lo;
	logic [23:0] lr_addr;
	logic        prot_acc, prot_we;
	logic [3:0]  prot_be;
	logic [31:0] prot_wd;
	wire  [31:0] prot_rd;
	wire         prot_ready, prot_busy;

	gx2_xga u_xga (
		.clk(clk_cpu), .reset(reset), .sel95(sel95),
		.acc(prot_acc), .poly(is_poly), .addr(a[11:2]), .we(prot_we), .be(prot_be),
		.wdata(prot_wd), .rdata(prot_rd), .ready(prot_ready), .busy(prot_busy)
	);

	// latch: upper byte (D13-D11 MO control), lower byte (D4 /SNDRES); MAME's 6502 runs until the latch is written
	logic [15:0] latch;
	assign mo_control = latch[13:11];
	assign snd_reset  = ~latch[4];

	logic irq4;
	logic vblank_d;
	always_comb begin
		if (sound_to_main_ready) ipl = 3'b010;       // ~5
		else if (irq4)           ipl = 3'b011;       // ~4
		else                     ipl = 3'b111;
	end

	wire [15:0] service = {8'hFF, vblank, test_n, ~main_to_sound_ready, ~sound_to_main_ready, adc_eoc, 3'b111};

	// single-clock register reads
	logic [15:0] io_q;
	always_comb begin
		io_q = 16'h0000;                              // MAME's unmapped value
		if (is_p1p2)         io_q = a[1] ? p1p2[15:0] : p1p2[31:16];
		else if (is_service) io_q = service;
		else if (is_special) io_q = 16'hFFFF;
		else if (is_adc)     io_q = {adc_sar, 8'h00};
		else if (is_rsp)     io_q = {rsp_data, 8'h00};
	end

	// the pace: a bucket of sixteenths of a step, filled by cpu_rate a clock (to almost two steps) and emptied by each step
	// the CPU takes (go: a whole step in it). A ROM, block RAM or protection access starts at once and fills the bucket
	// while it waits, so only steps quicker than the pace are held (TG68K's internal steps, the cache's hits); the access
	// completes, and a single-clock register is accessed, only with go, so none is repeated nor are its side effects (the
	// comm's toggles, the joined longs) taken twice.
	logic [4:0] credit;
	wire        go = cpu_rate[4] || credit[4];
	wire  [5:0] credit_n = {1'b0, credit} - (cpu_ready ? 6'd16 : 6'd0) + {2'b00, cpu_rate[3:0]};
	always_ff @(posedge clk_cpu) begin
		if (reset || cpu_rate[4]) credit <= 5'd16;
		else credit <= credit_n[5] ? 5'd31 : credit_n[4:0];
	end

	always_comb begin
		case (state)
			ST_DONE: cpu_ready = go;
			ST_IDLE: cpu_ready = !(cpu_rd || cpu_wr) ? go :
			                     (is_rom || is_bram || is_prot) ? 1'b0 : go;
			default: cpu_ready = 1'b0;
		endcase
		cpu_din = (state == ST_DONE) ? rd_q : io_q;
	end

	assign sdram_req  = req_r;
	assign acc_wr     = (state == ST_IDLE) && cpu_wr && !clearing;

	// the clear empties the cache (the image may have changed)
	always_comb begin
		rc_we    = clearing || (state == ST_SDRAM && sdram_ack == req_r);
		rc_waddr = clearing ? clr_addr[13:1] : a[13:1];
		rc_wd    = sdram_dout;
		rc_wt    = clearing ? 6'd0 : {1'b1, a[18:14]};
	end

	always_ff @(posedge clk_cpu) begin
		prot_acc <= 1'b0;

		if (reset) begin
			state       <= ST_IDLE;
			req_r       <= sdram_ack;
			latch       <= 16'h0010;
			mo_command  <= 16'h0000;
			irq4        <= 1'b0;
			vblank_d    <= 1'b0;
			cmd_tgl     <= 1'b0;
			rsp_rd_tgl  <= 1'b0;
			ee_unlocked <= 1'b0;
			lw_pend     <= 1'b0;
			lr_pend     <= 1'b0;
			adc_state   <= 2'd0;
			adc_eoc     <= 1'b1;
			adc_sar     <= 8'hFF;
		end else begin
			vblank_d <= vblank;
			if (vblank && !vblank_d) irq4 <= 1'b1;

			// ADC
			if (adc_state != 2'd0) begin
				if (adc_cnt != 12'd0) adc_cnt <= adc_cnt - 12'd1;
				else case (adc_state)
					2'd1: begin adc_state <= 2'd2; adc_cnt <= ADC_CLK - 12'd1; end
					2'd2: begin adc_state <= 2'd3; adc_cnt <= 12'd64 * ADC_CLK - 12'd1; adc_eoc <= 1'b0; adc_sar <= adc_in; end
					default: begin adc_state <= 2'd0; adc_eoc <= 1'b1; adc_sar <= adc_in; end
				endcase
			end

			case (state)
				ST_IDLE: if ((cpu_rd || cpu_wr) && !clearing && (go || is_rom || is_bram || is_prot)) begin
					if (is_rom) begin
						if (cpu_rd)
							state <= ST_CACHE;             // the cache's read of this address is valid next clock
						else
							state <= ST_DONE;              // writes to ROM are ignored
					end else if (is_bram) begin
						state <= ST_BRAM;
					end else if (is_prot) begin
						if (cpu_wr) begin
							if (longword && !a[1]) begin
								lw_pend <= 1'b1;
								lw_hi   <= cpu_dout;
								state   <= ST_DONE;
							end else begin
								prot_acc <= 1'b1;
								prot_we  <= 1'b1;
								prot_be  <= lw_pend ? 4'b1111 : a[1] ? {2'b00, cpu_uds, cpu_lds} : {cpu_uds, cpu_lds, 2'b00};
								prot_wd  <= lw_pend ? {lw_hi, cpu_dout} : {cpu_dout, cpu_dout};
								lw_pend  <= 1'b0;
								state    <= ST_PROT;
							end
						end else begin
							if (lr_pend && a == lr_addr) begin
								lr_pend <= 1'b0;
								rd_q    <= lr_lo;
								state   <= ST_DONE;
							end else begin
								prot_acc <= 1'b1;
								prot_we  <= 1'b0;
								prot_be  <= (longword && !a[1]) ? 4'b1111 : a[1] ? {2'b00, cpu_uds, cpu_lds} : {cpu_uds, cpu_lds, 2'b00};
								lr_pend  <= longword && !a[1];
								lr_addr  <= a + 24'd2;
								state    <= ST_PROT;
							end
						end
					end else begin
						// single-clock registers (cpu_ready was high this clock: the access completes now)
						if (cpu_wr) begin
							if (is_latch && !a[1]) begin
								if (cpu_uds) latch[15:8] <= cpu_dout[15:8];
								if (cpu_lds) latch[7:0]  <= cpu_dout[7:0];
							end
							if (is_vack) irq4 <= 1'b0;
							if (is_cmd && cpu_uds) begin
								cmd_data <= cpu_dout[15:8];
								cmd_tgl  <= ~cmd_tgl;
							end
							if (is_unlock) ee_unlocked <= 1'b1;
						end else begin
							if (is_rsp) rsp_rd_tgl <= ~rsp_rd_tgl;
							if (is_adc) begin
								adc_ch    <= a[3:1];
								adc_state <= 2'd1;
								adc_cnt   <= ADC_CLK - 12'd1;
							end
						end
					end
				end
				ST_CACHE: begin
					if (rc_hit) begin
						rd_q  <= rc_q;
						state <= ST_DONE;
					end else begin
						sdram_addr <= {5'b0, a[19:1]};
						req_r      <= ~req_r;
						state      <= ST_SDRAM;
					end
				end
				ST_SDRAM: if (sdram_ack == req_r) begin
					rd_q  <= sdram_dout;
					state <= ST_DONE;
				end
				ST_BRAM: begin
					// the block RAMs' registered reads of this address are valid now
					if (is_wram)        rd_q <= {wram_qh, wram_ql};
					else if (is_c8ram)  rd_q <= {c8_qh, c8_ql};
					else if (is_eeprom) rd_q <= ee_unlocked ? 16'h0000 : {~eeprom_q_inv, 8'h00};   // unlocked (/OE high): unmapped
					else if (is_pal)    rd_q <= pal_dout;
					else if (is_oram)   rd_q <= oram_dout;
					else                rd_q <= vram_dout;
					// side effects of the writes (the data went in with acc_wr)
					if (cpu_wr && is_vidram && !is_oram && a[15:1] == 15'h5101) begin   // D7A202: mo_command_w
						if (cpu_uds) mo_command[15:8] <= cpu_dout[15:8];
						if (cpu_lds) mo_command[7:0]  <= cpu_dout[7:0];
					end
					if (cpu_wr && is_eeprom && cpu_uds && ee_unlocked) ee_unlocked <= 1'b0;   // lock_after_write
					state <= ST_DONE;
				end
				ST_PROT: if (prot_ready) begin
					rd_q  <= a[1] ? prot_rd[15:0] : prot_rd[31:16];
					lr_lo <= prot_rd[15:0];
					state <= ST_DONE;
				end
				ST_DONE: if (go) state <= ST_IDLE;
				default: state <= ST_IDLE;
			endcase
		end
	end

endmodule
