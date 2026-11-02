#!/usr/bin/env python3
"""The Atari GX2 sets of MAME 0.289 (src/mame/atari/atarigx2.cpp, tools/paths.py MAME_SRC) and the core's ROM image.

The ROM_START tables are read from the driver; every file is found in the merged romset by its CRC (a merged zip keeps a
clone's files in the parent's zip, some under the clone's folder).

Image (MRA index 0; rtl/gx2_loader.sv):
    0x000000  68EC020 program, 512 KB (ROM_LOAD32_BYTE, big-endian as the CPU sees it)
    0x080000  OKI 1 samples, 512 KB          0x100000  OKI 2 samples, 512 KB
    0x180000  playfield third 0 (planes 0-1) 0x200000  third 1 (planes 2-3)  0x280000  third 2 (planes 4-5)
              each 512 KB: a smaller third is repeated to fill it (MAME's tile code % elements)
    0x300000  alphanumerics, 128 KB          0x320000  JSA 6502 program, 64 KB
    0x330000  RLE object ROM (ROM_REGION16_BE: ROM_LOAD16_BYTE pairs, the even file the high byte)
MRA index 1, one byte: the board (0 Space Lords: modesc_0x400, XGA 136095-0072; 1 Moto Frenzy: modesc_0x200, 136094-0072).

    gx2_rom.py list                     the sets
    gx2_rom.py image <set> <out.rom>    write a set's image
"""
import os
import re
import sys
import zipfile
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import paths

THIRD = 0x80000
LAYOUT = {'maincpu': 0x000000, 'jsa:oki1': 0x080000, 'jsa:oki2': 0x100000, 'tiles': 0x180000,
          'chars': 0x300000, 'jsa:cpu': 0x320000, 'rle': 0x330000}
SIZES = {'maincpu': 0x80000, 'jsa:oki1': 0x80000, 'jsa:oki2': 0x80000, 'chars': 0x20000, 'jsa:cpu': 0x10000}

# the games the core plays (MAME's working ones), board byte by machine config
BOARD = {'atarigx2_0x400': 0, 'atarigx2_0x200': 1}


def driver_src():
    return open(paths.MAME_SRC, encoding='utf-8').read()


def games():
    """[(set, parent or None, machine, init, title, year, flags)] in the driver's order."""
    out = []
    for m in re.finditer(r'^GAME\(\s*(\d+)\s*,\s*(\w+)\s*,\s*(\w+)\s*,\s*(\w+)\s*,\s*(\w+)\s*,\s*\w+\s*,\s*(\w+)\s*,\s*\w+\s*,'
                         r'\s*"([^"]*)"\s*,\s*"([^"]*)"\s*,\s*([^)]*)\)', driver_src(), re.M):
        year, name, parent, machine, inp, init, maker, title, flags = m.groups()
        out.append((name, None if parent == '0' else parent, machine, init, title, int(year), flags))
    return out


def supported():
    return [g for g in games() if 'MACHINE_NOT_WORKING' not in g[6] and g[2] in BOARD]


def rom_table(name):
    """{region: (size, [(kind, file, offset, length, crc or None)])} from ROM_START(name)."""
    src = driver_src()
    blk = re.search(r'ROM_START\(\s*%s\s*\)(.*?)ROM_END' % name, src, re.S).group(1)
    regions, cur = {}, None
    for line in blk.splitlines():
        line = line.split('//')[0]
        m = re.match(r'\s*ROM_REGION(?:16_BE)?\(\s*(0x[0-9a-fA-F]+)\s*,\s*"([^"]+)"', line)
        if m:
            cur = m.group(2)
            regions[cur] = (int(m.group(1), 16), [])
            continue
        m = re.match(r'\s*(ROM_LOAD\w*)\(\s*"([^"]+)"\s*,\s*(0x[0-9a-fA-F]+)\s*,\s*(0x[0-9a-fA-F]+)\s*,\s*(?:BAD_DUMP\s*)?(?:CRC\((\w+)\))?', line)
        if m and cur:
            kind, f, off, ln, crc = m.groups()
            regions[cur][1].append((kind, f, int(off, 16), int(ln, 16), crc and crc.lower()))
            continue
        m = re.match(r'\s*ROM_FILL\(\s*(0x[0-9a-fA-F]+)\s*,\s*(0x[0-9a-fA-F]+)\s*,\s*(0x[0-9a-fA-F]+)', line)
        if m and cur:
            regions[cur][1].append(('ROM_FILL', None, int(m.group(1), 16), int(m.group(2), 16), int(m.group(3), 16)))
    return regions


def zip_files(name):
    """CRC -> bytes over the set's zip and its parent's."""
    parent = {g[0]: g[1] for g in games()}.get(name)
    files = {}
    for z in [n for n in (parent, name) if n]:
        path = os.path.join(paths.ROMS, z + '.zip')
        if not os.path.exists(path):
            continue                                      # a merged romset: the clone's files are in the parent's zip
        with zipfile.ZipFile(path) as zf:
            for info in zf.infolist():
                if info.is_dir():
                    continue
                data = zf.read(info)
                files['%08x' % (zlib.crc32(data) & 0xffffffff)] = data
    return files


def region_bytes(name):
    files = zip_files(name)
    out = {}
    for reg, (size, loads) in rom_table(name).items():
        buf = bytearray(size)
        for kind, f, off, ln, crc in loads:
            if kind == 'ROM_FILL':
                buf[off:off + ln] = bytes([crc]) * ln
                continue
            if crc is None:
                continue                                  # NO_DUMP
            data = files[crc]
            assert len(data) == ln, (f, len(data), ln)
            if kind == 'ROM_LOAD':
                buf[off:off + ln] = data
            elif kind == 'ROM_LOAD16_BYTE':
                buf[off:off + 2 * ln:2] = data
            elif kind == 'ROM_LOAD32_BYTE':
                buf[off:off + 4 * ln:4] = data
            else:
                raise ValueError(kind)
        out[reg] = bytes(buf)
    return out


def image(name):
    r = region_bytes(name)
    rle = r['rle']
    img = bytearray(LAYOUT['rle'] + len(rle))
    for reg in ('maincpu', 'jsa:oki1', 'jsa:oki2', 'chars', 'jsa:cpu'):
        assert len(r[reg]) == SIZES[reg], (reg, len(r[reg]))
        img[LAYOUT[reg]:LAYOUT[reg] + SIZES[reg]] = r[reg]
    tiles = r['tiles']
    t = len(tiles) // 3
    assert t * 3 == len(tiles) and THIRD % t == 0
    for i in range(3):
        third = tiles[i * t:(i + 1) * t]
        img[LAYOUT['tiles'] + i * THIRD:LAYOUT['tiles'] + (i + 1) * THIRD] = third * (THIRD // t)
    img[LAYOUT['rle']:] = rle
    return bytes(img)


def board(name):
    machine = {g[0]: g[2] for g in games()}[name]
    return BOARD[machine]


if __name__ == '__main__':
    if len(sys.argv) >= 2 and sys.argv[1] == 'list':
        for g in games():
            print('%-12s %-10s %-16s %s%s' % (g[0], g[1] or '-', g[2], g[4], '' if g in supported() else '  (not supported)'))
    elif len(sys.argv) == 4 and sys.argv[1] == 'image':
        data = image(sys.argv[2])
        open(sys.argv[3], 'wb').write(data)
        print('%s: %d bytes, board %d' % (sys.argv[3], len(data), board(sys.argv[2])))
    else:
        print(__doc__)
        sys.exit(2)
