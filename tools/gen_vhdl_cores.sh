#!/bin/bash
# Regenerates the Verilog of the two VHDL CPU cores with GHDL (WSL, ~/tools/oss-cad-suite).
# Quartus and Verilator both build the generated files; the VHDL stays as the source of record.
#   modules/cpu-tg68k/gen/tg68k.v  TG68KdotC_Kernel (68EC020 main CPU)
#   modules/cpu-t65/gen/t65.v      T65 (JSA IIIs 6502)
set -e
cd "$(dirname "$0")/.."
export PATH=~/tools/oss-cad-suite/bin:$PATH
W=$(mktemp -d)

mkdir -p modules/cpu-tg68k/gen modules/cpu-t65/gen
( cd $W && ghdl -a --std=08 -fsynopsys -frelaxed "$OLDPWD"/modules/cpu-tg68k/TG68K_Pack.vhd \
      "$OLDPWD"/modules/cpu-tg68k/TG68K_ALU.vhd "$OLDPWD"/modules/cpu-tg68k/TG68KdotC_Kernel.vhd \
  && ghdl synth --std=08 -fsynopsys -frelaxed --latches --out=verilog TG68KdotC_Kernel ) > modules/cpu-tg68k/gen/tg68k.v
rm -rf $W/*
( cd $W && ghdl -a --std=08 -fsynopsys -frelaxed "$OLDPWD"/modules/cpu-t65/T65_Pack.vhd \
      "$OLDPWD"/modules/cpu-t65/T65_ALU.vhd "$OLDPWD"/modules/cpu-t65/T65_MCode.vhd "$OLDPWD"/modules/cpu-t65/T65.vhd \
  && ghdl synth --std=08 -fsynopsys -frelaxed --latches --out=verilog T65 ) > modules/cpu-t65/gen/t65.v
# T65 has a signal named Break, a SystemVerilog keyword (Verilator reads .v as SystemVerilog)
sed -i 's/break/break_s/g' modules/cpu-t65/gen/t65.v
rm -rf $W
wc -l modules/cpu-tg68k/gen/tg68k.v modules/cpu-t65/gen/t65.v
