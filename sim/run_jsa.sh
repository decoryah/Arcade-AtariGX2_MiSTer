#!/bin/bash
# Builds the JSA IIIs bench (sim/tb_jsa.cpp, sim/tb_jsa.vlt; Verilator 5, WSL: ~/tools/oss-cad-suite) in ~/build_gx2_jsa
# (BUILD=<dir>: elsewhere) and runs it.
#   sim/run_jsa.sh <image.rom> <sndlog> <out.wav> <seconds> [<trace from s> <cycles>]   (REBUILD=1: rebuild)
set -e
export PATH=~/tools/oss-cad-suite/bin:$PATH
R=$(cd "$(dirname "$0")/.." && pwd)
B=${BUILD:-~/build_gx2_jsa}
mkdir -p $B
if [ ! -x $B/obj/Vgx2_jsa ] || [ -n "$REBUILD" ]; then
  verilator --cc --exe --build -j 8 -O3 --x-assign fast --x-initial fast --noassert \
    -Wno-fatal -Wno-lint -Wno-style -Wno-MULTIDRIVEN -Wno-BLKANDNBLK -Wno-UNOPTFLAT -Wno-COMBDLY -Wno-PINMISSING \
    -DSIMULATION --top-module gx2_jsa -Mdir $B/obj $R/sim/tb_jsa.vlt \
    $R/rtl/gx2_jsa.sv $R/modules/cpu-t65/gen/t65.v $R/modules/jt51/hdl/*.v $R/modules/jt6295/hdl/*.v \
    $R/sim/tb_jsa.cpp -o Vgx2_jsa > $B/build.log 2>&1 || { tail -40 $B/build.log; exit 1; }
fi
$B/obj/Vgx2_jsa "$@"
