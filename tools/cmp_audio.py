#!/usr/bin/env python3
"""Compares the JSA bench's sound (sim/tb_jsa.cpp) with MAME's -wavwrite of the same run (tools/lua/gx2_sndlog.lua):
the loudness of each channel in 20 ms windows, each file scaled by its own loudest windows. Prints the envelopes'
correlation, the windows where one plays and the other is silent (a dropout), and writes a PNG: per channel MAME's
envelope above the bench's, dropouts marked red.

    cmp_audio.py <mame.wav> <bench.wav> [out.png] [--from s] [--to s]
"""
import array
import math
import os
import sys
import wave

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pngio

WIN = 0.020


def envelopes(path):
    w = wave.open(path, 'rb')
    ch, sw, rate, n = w.getnchannels(), w.getsampwidth(), w.getframerate(), w.getnframes()
    assert sw == 2 and ch == 2, (path, ch, sw)
    data = array.array('h')
    data.frombytes(w.readframes(n))
    w.close()
    if sys.byteorder == 'big':
        data.byteswap()
    step = int(rate * WIN)
    env = ([], [])
    for c in range(2):
        s = data[c::2]
        for i in range(0, len(s) - step + 1, step):
            seg = s[i:i + step]
            env[c].append(math.sqrt(sum(v * v for v in seg) / step))
    return env


def scaled(e):
    top = sorted(e)[int(len(e) * 0.98)] or 1.0
    return [min(v / top, 1.5) for v in e]


def corr(a, b):
    n = min(len(a), len(b))
    if n < 2:
        return 0.0
    ma, mb = sum(a[:n]) / n, sum(b[:n]) / n
    sa = math.sqrt(sum((x - ma) ** 2 for x in a[:n]))
    sb = math.sqrt(sum((y - mb) ** 2 for y in b[:n]))
    if sa == 0 or sb == 0:
        return 0.0
    return sum((a[i] - ma) * (b[i] - mb) for i in range(n)) / (sa * sb)


def main(argv):
    args, opts = [], {}
    i = 0
    while i < len(argv):
        if argv[i] in ('--from', '--to'):
            opts[argv[i]] = float(argv[i + 1]); i += 2
        else:
            args.append(argv[i]); i += 1
    if len(args) < 2:
        print(__doc__); return 1
    em, eb = envelopes(args[0]), envelopes(args[1])
    a = int(opts.get('--from', 0) / WIN)
    b = int(opts.get('--to', 1e9) / WIN)
    rows = []
    for c, name in ((0, 'left'), (1, 'right')):
        n = min(len(em[c]), len(eb[c]), b) - a
        m = scaled(em[c][a:a + n])
        s = scaled(eb[c][a:a + n])
        drop = [k for k in range(n) if m[k] > 0.15 and s[k] < 0.25 * m[k]]
        extra = [k for k in range(n) if s[k] > 0.15 and m[k] < 0.25 * s[k]]
        print('%-5s %5.1f s: envelope correlation %.3f; bench silent where MAME plays: %d windows%s; '
              'bench plays where MAME is silent: %d windows%s' % (
                  name, n * WIN, corr(m, s), len(drop),
                  (' (' + ', '.join('%.2f s' % ((a + k) * WIN) for k in drop[:12]) + (' ...' if len(drop) > 12 else '') + ')') if drop else '',
                  len(extra),
                  (' (' + ', '.join('%.2f s' % ((a + k) * WIN) for k in extra[:12]) + (' ...' if len(extra) > 12 else '') + ')') if extra else ''))
        rows.append((m, s, set(drop)))
    if len(args) > 2:
        n = min(len(r[0]) for r in rows)
        H = 60
        W = n
        img = bytearray(W * (H * 4 + 6) * 3)
        def put(x, y, rgb):
            o = (y * W + x) * 3
            img[o:o + 3] = bytes(rgb)
        for c, (m, s, drop) in enumerate(rows):
            for k, (trace, col) in enumerate(((m, (80, 160, 255)), (s, (120, 220, 120)))):
                y0 = (c * 2 + k) * H + (2 if c else 0) + (H - 1)
                for x in range(n):
                    h = int(min(trace[x], 1.0) * (H - 2))
                    for y in range(h):
                        put(x, y0 - y, (230, 60, 60) if (k == 1 and x in drop) else col)
        pngio.write(args[2], W, H * 4 + 6, img)
        print('wrote', args[2])
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
