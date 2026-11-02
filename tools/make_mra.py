#!/usr/bin/env python3
"""Writes the core's MRAs from MAME 0.289's ROM_START tables (tools/gx2_rom.py) and checks each: the image tools/mra_build.py
assembles from the .mra and the romset must be byte-identical to gx2_rom.py's.  (After the owner's supduck-mister make_mra.py.)

    make_mra.py [outdir]          default mra/ (parents), mra/_alternatives/_<game>/ (clones)

No DIP switches: the GX2 board has none (every setting is in the EEPROM, changed in the game's test menu: Service Mode in
the OSD). Index 1 is the board byte, index 4 the EEPROM (NVRAM).
"""
import os
import sys
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import paths
import gx2_rom as R

# The buttons each game reads (CONF_STR J1: B1..B6, Start, Coin; '-' = not used by the game).
BUTTONS = {
    0: ('Laser,Nuke,Throttle Fwd,Throttle Rev,Rear View,-,Start,Coin', 'A,B,X,Y,R,L,Start,Select'),
    1: ('Fire,Throttle,AUX1 (Service Menu),AUX2 (Service Menu),AUX3 (Service Menu),-,Start,Coin',
        'A,B,X,Y,R,L,Start,Select'),   # AUX1..3 drive the test menu; the game ignores them
}
# Main_MiSTer's Define Buttons page centres "Press: <name>" with (30 - (strlen(name) + 7)) / 2 in unsigned arithmetic
# (menu.cpp): a name of 24 characters or more wraps that to ~2^31 spaces strcat'ed into a 256-byte buffer and the menu
# hangs (hardware test, "AUX1 (Service Menu only)"). 23 is the longest safe name.
BUTTON_NAME_MAX = 23
for _names, _ in BUTTONS.values():
    assert all(len(n) <= BUTTON_NAME_MAX for n in _names.split(',')), _names
PLAYERS = {0: 2, 1: 1}
GAME_NAME = {0: 'Space Lords', 1: 'Moto Frenzy'}


def crc_of(files, crc):
    assert crc in files, crc
    return crc


def rom_lines(name):
    files = R.zip_files(name)
    tab = R.rom_table(name)
    L = []

    def part(f, crc, extra=''):
        L.append('        <part name="%s" crc="%s"%s/>' % (f, crc_of(files, crc), extra))

    # maincpu: ROM_LOAD32_BYTE, byte k of every long from the file at offset k
    L.append('        <!-- 0x000000 maincpu: the 68EC020 program, ROM_LOAD32_BYTE -->')
    L.append('        <interleave output="32">')
    for kind, f, off, ln, crc in tab['maincpu'][1]:
        m = ['0', '0', '0', '0']
        m[3 - off] = '1'
        L.append('            <part name="%s" crc="%s" map="%s"/>' % (f, crc_of(files, crc), ''.join(m)))
    L.append('        </interleave>')
    for reg, label in (('jsa:oki1', '0x080000 OKI 1 samples'), ('jsa:oki2', '0x100000 OKI 2 samples')):
        (kind, f, off, ln, crc), = tab[reg][1]
        L.append('        <!-- %s -->' % label)
        part(f, crc)
    size, loads = tab['tiles']
    third = size // 3
    L.append('        <!-- 0x180000 playfield: three thirds of 512 KB, a smaller one repeated (MAME: code %% elements) -->')
    for i in range(3):
        rng = [x for x in loads if x[2] // third == i]
        for kind, f, off, ln, crc in rng:
            assert ln == third, (f, ln, third)
            if kind == 'ROM_FILL':
                L.append('        <part repeat="0x%X">%02X</part>' % (R.THIRD, crc))
            else:
                for _ in range(R.THIRD // third):
                    part(f, crc)
    (kind, f, off, ln, crc), = tab['chars'][1]
    L.append('        <!-- 0x300000 alphanumerics -->')
    part(f, crc)
    (kind, f, off, ln, crc), = tab['jsa:cpu'][1]
    L.append('        <!-- 0x320000 JSA IIIs 6502 program -->')
    part(f, crc)
    L.append('        <!-- 0x330000 RLE object ROM, ROM_LOAD16_BYTE pairs (the even file the high byte) -->')
    loads = tab['rle'][1]
    for i in range(0, len(loads), 2):
        (k0, f0, o0, l0, c0), (k1, f1, o1, l1, c1) = loads[i], loads[i + 1]
        assert o0 % 2 == 0 and o1 == o0 + 1
        L.append('        <interleave output="16">')
        L.append('            <part name="%s" crc="%s" map="01"/>' % (f0, crc_of(files, c0)))
        L.append('            <part name="%s" crc="%s" map="10"/>' % (f1, crc_of(files, c1)))
        L.append('        </interleave>')
    return L


def mra_text(g):
    name, parent, machine, init, title, year, flags = g
    b = R.board(name)
    zips = '%s.zip|%s.zip' % (name, parent) if parent else '%s.zip' % name
    out = ['<misterromdescription>',
           '    <name>%s</name>' % title,
           '    <setname>%s</setname>' % name,
           '    <mameversion>0289</mameversion>',
           '    <year>%d</year>' % year,
           '    <manufacturer>Atari Games</manufacturer>',
           '    <players>%d</players>' % PLAYERS[b],
           '    <joystick>8-way</joystick>',
           '    <rotation>horizontal</rotation>',
           '    <rbf>atarigx2</rbf>',
           '    <platform>Atari GX2</platform>',
           '',
           '    <!--',
           '      Image for the Atari GX2 core (rtl/gx2_loader.sv, tools/gx2_rom.py):',
           '        0x000000 68EC020 program   0x080000 OKI 1   0x100000 OKI 2   0x180000 playfield thirds (3 x 512 KB)',
           '        0x300000 alphanumerics     0x320000 6502    0x330000 RLE objects',
           '      Index 1: the board (0 Space Lords: modesc 0x400 + XGA 136095-0072; 1 Moto Frenzy: modesc 0x200 + 136094-0072).',
           '      No DIP switches: the board keeps its settings in the EEPROM (index 4); change them in the game\'s test menu',
           '      (OSD: Service Mode).',
           '      Made by tools/make_mra.py from MAME 0.289 (src/mame/atari/atarigx2.cpp); parts are found by name and CRC.',
           '    -->',
           '',
           '    <rom index="1">',
           '        <part>%02X</part>' % b,
           '    </rom>',
           '',
           # address=: fast load -- a recent Main_MiSTer copies the image into the DDR3 there and the core replays it
           '    <rom index="0" zip="%s" md5="None" address="0x38000000">' % zips]
    out += rom_lines(name)
    names, default = BUTTONS[b]
    out += ['    </rom>', '',
            '    <nvram index="4" size="2048"/>', '',
            '    <buttons names="%s" default="%s"/>' % (names, default),
            '</misterromdescription>', '']
    return '\n'.join(out)


def main(argv):
    import mra_build
    outdir = argv[1] if len(argv) > 1 else os.path.join(paths.REPO, 'mra')
    ok_all = True
    for g in R.supported():
        name, parent = g[0], g[1]
        d = outdir if not parent else os.path.join(outdir, '_alternatives', '_' + GAME_NAME[R.board(name)])
        os.makedirs(d, exist_ok=True)
        path = os.path.join(d, g[4] + '.mra')
        text = mra_text(g)
        open(path, 'w', encoding='utf-8', newline='\n').write(text)
        zipp = '|'.join(p for p in (os.path.join(paths.ROMS, name + '.zip'),
                                    parent and os.path.join(paths.ROMS, parent + '.zip')) if p and os.path.exists(p))
        md5 = mra_build.mister_md5(path, zipp)
        text = text.replace('md5="None"', 'md5="%s"' % md5, 1)
        open(path, 'w', encoding='utf-8', newline='\n').write(text)
        img, md5_check = mra_build.build(path, zipp)
        ok = img == R.image(name) and md5_check == md5
        ok_all &= ok
        print('%-60s %s, MiSTer md5 %s' % (os.path.relpath(path, outdir), 'image identical' if ok else 'IMAGE DIFFERS', md5))
    return 0 if ok_all else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv))
