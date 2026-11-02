#!/usr/bin/env python3
"""Compares the bench's frames with MAME's (both 336 x 240 PPM) and writes a side-by-side PNG: MAME | core | differences.

    cmp_frame.py <mame.ppm> <core.ppm> [out.png]
    cmp_frame.py <mame_dir> <core_dir> [out_dir]      every frame number both have
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pngio


def read_ppm(path):
    data = open(path, 'rb').read()
    parts = data.split(b'\n', 3)
    w, h = map(int, parts[1].split())
    return w, h, parts[3]


def compare(a_path, b_path, out=None):
    w, h, a = read_ppm(a_path)
    w2, h2, b = read_ppm(b_path)
    assert (w, h) == (w2, h2), ((w, h), (w2, h2))
    diff = 0
    rows = []
    for y in range(h):
        row = bytearray()
        row += a[y * w * 3:(y + 1) * w * 3]
        row += b[y * w * 3:(y + 1) * w * 3]
        for x in range(w):
            i = (y * w + x) * 3
            same = a[i:i + 3] == b[i:i + 3]
            diff += not same
            row += b'\x00\x00\x00' if same else b'\xff\x00\xff'
        rows.append(bytes(row))
    if out:
        pngio.write(out, w * 3, h, b''.join(rows))
    return diff


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    a, b = argv[1], argv[2]
    if os.path.isdir(a):
        out = argv[3] if len(argv) > 3 else None
        if out:
            os.makedirs(out, exist_ok=True)
        common = sorted(set(f for f in os.listdir(a) if f.endswith('.ppm')) & set(f for f in os.listdir(b) if f.endswith('.ppm')))
        for f in common:
            d = compare(os.path.join(a, f), os.path.join(b, f), out and os.path.join(out, f.replace('.ppm', '.png')))
            print('%s: %d pixels differ' % (f, d))
        return 0
    d = compare(a, b, argv[3] if len(argv) > 3 else None)
    print('%d pixels differ' % d)
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
