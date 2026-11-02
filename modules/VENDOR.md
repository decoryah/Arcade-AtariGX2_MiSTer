# Vendored modules

Third-party HDL cores copied into the tree -- no submodules, so the build is self-contained and reproducible.
Each keeps its own LICENSE alongside (or in its source headers).

| module | upstream | via | licence |
|---|---|---|---|
| cpu-tg68k (68EC020) | TG68K.C (Tobias Gubener) | the three VHDL files of the Primal Rage core (MiSTer-devel/Arcade-PrimalRage_MiSTer `rtl/tg68k`, commit 6d60dac), which add the CACR data-cache bit (`D_CACHE_out`) to the owner's gaelco3d-mister copy; `gen/tg68k.v` is GHDL's Verilog of the kernel (`tools/gen_vhdl_cores.sh`), built by Quartus and Verilator, generics at their defaults (all "switchable", as the Primal Rage core instantiates them) | LGPL-3.0 |
| cpu-t65 (6502) | T65 (Daniel Wallner, MikeJ, Wolfgang Scherr and others) | the four VHDL files of the Atari System 1 core (MiSTer-devel/Arcade-Atari-system1_MiSTer `rtl/lib/T65`, commit 4fc5ed8); `gen/t65.v` is GHDL's Verilog, its signal `break` renamed `break_s` (a SystemVerilog keyword) | BSD-style (source headers) |
| jt51 (YM2151) | https://github.com/jotego/jt51 (Jose Tejada) | the 22 `hdl/jt51*.v` files, copied unchanged from the owner's `silvmil-mister/mister/modules/jt51` on 2026-10-30; a write is held until `cen_p1`, as the owner's other cores do (`../rtl/gx2_jsa.sv`) | GPL-3.0 |
| jt6295 (OKI M6295) | https://github.com/jotego/jt6295 (Jose Tejada) | the 8 files `hdl/jt6295*.v`, copied unchanged from `silvmil-mister/mister/modules/jt6295` on 2026-10-30 | GPL-3.0 |
| crt_adjust (CRT Adjust: H-Size, H-Position, V-Shift) | https://github.com/rmonic79/MiSTer-CRT-Adjust (Umberto Parisi, rmonic79) | `rtl/crt_adjust.sv` at commit c682de9, copied from the owner's `slapshot-mister/mister/modules/crt_adjust` (the Metro core's copy, with its two changes marked `METRO`); the glue is `../rtl/gx2_crtadj.sv` (the owner's supduck-mister `sd_crtadj.sv`) | GPL-3.0-or-later |

To update one: re-copy from upstream at the new commit and record it here.
