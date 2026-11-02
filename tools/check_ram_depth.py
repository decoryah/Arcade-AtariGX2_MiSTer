#!/usr/bin/env python3
"""Check the RAMs Quartus actually built against the depths the RTL declares (from the owner's ohmygod-mister/mister/tools/check_ram_depth.py).

    check_ram_depth.py <AtariGX2.fit.rpt> [--list]

A simulator evaluates an array exactly as declared; Quartus 17 does not always (a two-dimensional unpacked array was once built half as deep,
invisible in every bench and broken on the board).  Run this on every fit report; it exits 1 if a listed memory is shallower than its
minimum, or is missing.
"""
import re
import sys

# (instance name fragment, minimum words, minimum width)
EXPECT = [
    # the 68EC020's board (gx2_main.sv): work RAM 32 KB, C80000 RAM 4 KB, the ROM cache, the EEPROM, the XGA's key RAM / POLYLSB
    ("gx2_main:gx2_main|altsyncram:wram_h", 16384, 8),
    ("gx2_main:gx2_main|altsyncram:wram_l", 16384, 8),
    ("gx2_main:gx2_main|altsyncram:c8_h", 2048, 8),
    ("gx2_main:gx2_main|altsyncram:c8_l", 2048, 8),
    ("gx2_main:gx2_main|altsyncram:rc_data", 8192, 16),
    ("gx2_main:gx2_main|altsyncram:rc_tag", 8192, 6),
    ("gx2_main:gx2_main|tdp_ram:u_eeprom", 2048, 8),
    ("gx2_xga:u_xga|altsyncram:kram_h", 2048, 8),
    ("gx2_xga:u_xga|altsyncram:kram_l", 2048, 8),
    ("gx2_xga:u_xga|altsyncram:pram", 64, 32),
    # video (gx2_video.sv): video RAM 64 KB, palette 2048 x 16, the line buffers
    ("gx2_video:gx2_video|tdp_ram:u_vram_hi", 32768, 8),
    ("gx2_video:gx2_video|tdp_ram:u_vram_lo", 32768, 8),
    ("gx2_video:gx2_video|tdp_ram:u_pal_hi", 2048, 8),
    ("gx2_video:gx2_video|tdp_ram:u_pal_lo", 2048, 8),
    ("gx2_video:gx2_video|altsyncram:pf_buf0", 336, 11),
    ("gx2_video:gx2_video|altsyncram:an_buf0", 336, 9),
    # the RLE objects' RAM (2K x 16) and line buffers
    ("rle_objects:rle_objects|tdp_ram:oram_hi", 2048, 8),
    ("rle_objects:rle_objects|tdp_ram:oram_lo", 2048, 8),
    ("rle_objects:rle_objects|altsyncram:snap_mem", 2048, 16),
    ("rle_objects:rle_objects|altsyncram:rd0_lane0", 84, 16),
    # the JSA IIIs: the 6502's ROM (64 KB) and RAM (8 KB)
    ("gx2_jsa:gx2_jsa|altsyncram:rom", 65536, 8),
    ("gx2_jsa:gx2_jsa|altsyncram:ram", 8192, 8),
]


def main():
    path = sys.argv[1]
    ram = []
    for line in open(path, errors="replace"):
        if "|ALTSYNCRAM" not in line or not line.startswith(";"):
            continue
        f = [c.strip() for c in line.split(";")]
        # ; name ; type ; mode ; clocks ; words ; width ; words ; width ; ...
        try:
            ram.append((f[1], int(f[5]), int(f[6])))
        except (IndexError, ValueError):
            continue
    if "--list" in sys.argv:
        for n, w, b in ram:
            print("%6d x %-3d %s" % (w, b, n))
    bad = 0
    for frag, wmin, bmin in EXPECT:
        hits = [(n, w, b) for n, w, b in ram if frag in n]
        if not hits:
            print("MISSING  %-52s (expected >= %d x %d)" % (frag, wmin, bmin))
            bad += 1
            continue
        for n, w, b in hits:
            # a wide RAM may be split into several blocks side by side; only depth matters here
            ok = w >= wmin
            if not ok:
                bad += 1
            print("%s  %-52s %6d x %-3d (>= %d)" % ("ok     " if ok else "TOO SHALLOW", frag, w, b, wmin))
    print("%d problem(s)" % bad)
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
