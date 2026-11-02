#!/bin/bash
# Builds the whole-machine bench (Verilator 5, WSL: ~/tools/oss-cad-suite) in ~/build_gx2 and runs it.
#   sim/run.sh <image.rom> <game 0|1> <frames> <outdir> [+play] [+pc] [+wdt] [+vlog=f] [+rate=n] [+test=f] [+hold=bit:a-b ...]
#   THREADS=n: a Verilator --threads build (in ~/build_gx2_tn); BUILD=<dir>: elsewhere; REBUILD=1: rebuild
set -e
export PATH=~/tools/oss-cad-suite/bin:$PATH
R=$(cd "$(dirname "$0")/.." && pwd)
B=${BUILD:-~/build_gx2${THREADS:+_t$THREADS}}
mkdir -p $B
if [ ! -x $B/obj/Vtb_top ] || [ -n "$REBUILD" ]; then
  verilator --cc --exe --build -j 8 -O3 ${THREADS:+--threads $THREADS} --x-assign fast --x-initial fast --noassert \
    -Wno-fatal -Wno-lint -Wno-style -Wno-MULTIDRIVEN -Wno-BLKANDNBLK -Wno-UNOPTFLAT -Wno-COMBDLY -Wno-PINMISSING \
    -DSIMULATION --top-module tb_top -Mdir $B/obj \
    $R/sim/tb_top.sv $R/rtl/gx2_main.sv $R/rtl/gx2_xga.sv $R/rtl/gx2_video.sv $R/rtl/gx2_jsa.sv $R/rtl/gx2_inputs.sv \
    $R/rtl/rle_objects.sv $R/rtl/tdp_ram.sv \
    $R/modules/cpu-tg68k/gen/tg68k.v $R/modules/cpu-t65/gen/t65.v $R/modules/jt51/hdl/*.v $R/modules/jt6295/hdl/*.v \
    $R/sim/tb_main.cpp -o Vtb_top > $B/build.log 2>&1 || { tail -40 $B/build.log; exit 1; }
fi
mkdir -p "$4"
$B/obj/Vtb_top "$@"
