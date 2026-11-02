# Where the RTL comes from

| file | origin | changes |
|---|---|---|
| `rle_objects.sv` | Primal Rage core (MiSTer-devel/Arcade-PrimalRage_MiSTer, Nortido, GPL-3), `rtl/rle_objects.sv` at 6d60dac: MAME's `atarirle.cpp` (ROM and frame buffers in DDR3) | the GX2 modesc: `colmask` / `palbase` inputs, the VRAM-target bit only on T-MEK, the ROM length an input (`rom_words`), MAME 0.289's unmasked palette base (`BPP_MASK` = 0) |
| `tdp_ram.sv`, `rom_ddr_replay.sv`, `nvram_hps.sv` | Primal Rage core, unchanged | |
| `sdram.sv` | Primal Rage core (Sorgelig's controller) | a fourth port |
| `gx2_loader.sv` | Primal Rage core's `rom_loader` and `ddr_arbiter` (in its top level) | the GX2 image layout, the 6502's block RAM, no debug block, no CAGE master |
| `gx2_video.sv` | Primal Rage core's `atarigt_video.sv` (timing, scroll table, tile fetch, line buffers) | GX2's palette (2048 x IRGB_1555) and three-layer mixer, tile colour rule, alpha opaque bit, active-high syncs |
| `gx2_main.sv` | Primal Rage core's `cpu_bus.sv` (TG68K hookup, ADC model) | GX2's memory map, block RAMs, the 32-bit joining of protection accesses, MAME's ADC0808 timing, the 2816's lock |
| `gx2_xga.sv` | new, from MAME 0.289 `atarixga.cpp` | |
| `gx2_jsa.sv` | new, from MAME 0.289 `atarijsa.cpp` / `atariscom.cpp`; the 6502 strobes as the Atari System 1 core's `AUDIO.vhd` | |
| `gx2_inputs.sv` | new | |
| `gx2_crtadj.sv` | the owner's supduck-mister `rtl/sd_crtadj.sv` | the module name |
