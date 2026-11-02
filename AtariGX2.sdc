derive_pll_clocks
derive_clock_uncertainty

# clk_sys (85.909 MHz) and clk_cpu (clk_sys / 2) come from one PLL, phase aligned: their crossings (the CPU's block RAMs'
# second ports, the SDRAM request toggle, the JSA latches) are timed as ordinary related-clock paths, as in the Primal
# Rage core.

# ==============================================================================
# The JSA IIIs (rtl/gx2_jsa.sv) steps on clock enables of clk_sys. A multicycle is set only where every register of
# the destination advances on the enable alone (checked line by line in the source, as the owner's Fighter's History
# core does): over a module that also has full-clock registers it lets the fitter stretch real one-clock paths while
# the timing report stays green, and the sound then breaks a different way on each build. The first release had
# blanket multicycles over jt51 and both jt6295s, and its music cut out and came back on a DE10-Nano.
# Single-cycle on purpose: jt51_mmr, jt51_reg / jt51_kon, jt51_timers, jt51_lfo (the write port, the timers' load
# edge, the LFO's write latch run on every clock) and the owner's jt6295 (its write strobe, BUSY timing and start /
# stop bookkeeping run on every clock).
# ==============================================================================
# jt51 (YM2151): enable every 24 clocks (3.579545 MHz). jt51_pg, jt51_eg and jt51_op (with jt51_phrom, jt51_exprom
# and their jt51_sh delay lines) clock only under if (cen); what feeds them changes only on an enable or on the write
# cycle (cs_n is low only with cen_p1, itself an enable). Anchored on the destination, 12 of the 24 clocks. The first
# build without any missed 85.9 MHz by 3.6 ns, jt51_lfo -> jt51_pg.
set_multicycle_path -setup -end 12 -to [get_registers {emu|gx2_jsa|u_ym|u_pg|*}]
set_multicycle_path -hold  -end 11 -to [get_registers {emu|gx2_jsa|u_ym|u_pg|*}]
set_multicycle_path -setup -end 12 -to [get_registers {emu|gx2_jsa|u_ym|u_eg|*}]
set_multicycle_path -hold  -end 11 -to [get_registers {emu|gx2_jsa|u_ym|u_eg|*}]
set_multicycle_path -setup -end 12 -to [get_registers {emu|gx2_jsa|u_ym|u_op|*}]
set_multicycle_path -hold  -end 11 -to [get_registers {emu|gx2_jsa|u_ym|u_op|*}]

# T65 (6502): every register under if Enable (every 48 clocks) apart from its two-stage reset synchroniser, whose
# input gx2_jsa.sv changes only on the enable (so the synchroniser settles 46 clocks before the next one). Paths
# inside the CPU only; its bus (A, DI, R_W_n, the strobes) is board logic, single-cycle.
set_multicycle_path -setup -end 2 -from [get_registers {emu|gx2_jsa|u_cpu|*}] -to [get_registers {emu|gx2_jsa|u_cpu|*}]
set_multicycle_path -hold  -end 1 -from [get_registers {emu|gx2_jsa|u_cpu|*}] -to [get_registers {emu|gx2_jsa|u_cpu|*}]
