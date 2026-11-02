#!/usr/bin/env python3
"""Runs MAME 0.289 headless on a GX2 set with tools/lua/gx2_capture.lua: frames (PPM) and RAMs, optionally the protection log.

    capture.py <set> <frames> [outdir] [--play] [--hold N:a-b ...] [--service a[-b]] [--prot] [--seed N]

  <frames>   e.g. 300  or  150,300,600  or  30-1800/30 (first-last/step)
  outdir     default work/cap/<set>
  --play     six coins from 300, start at 450 and 800
  --hold N:a-b  hold MAME's input N over frames a..b (e.g. AUX1:700-2400); N=v:a-b sets an analog input to the port
                value v (e.g. "P1 AD Stick X=0x00:850-1000"); may be given more than once
  --service a[-b]  the board's test switch (Service Mode) on from frame a (and off again after b)
Each run starts from MAME's defaults: the set's cfg is removed first (it would keep the test switch on).
  --prot     log every access to CA0000-CA0FFF, C80F00-C80FFF, D00000-D0000F (prot.log: frame R/W address data mask pc)
(After the owner's supduck-mister tools/capture.py.)
"""
import os
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import paths


def main(argv):
    opts, args = {}, []
    i = 1
    while i < len(argv):
        a = argv[i]
        if a == '--hold':
            opts[a] = opts[a] + ';' + argv[i + 1] if a in opts else argv[i + 1]
            i += 2
            continue
        if a in ('--seed', '--service'):
            opts[a] = argv[i + 1]
            i += 2
            continue
        if a.startswith('--'):
            opts[a] = True
        else:
            args.append(a)
        i += 1
    if len(args) < 2:
        print(__doc__)
        return 2
    setname, frames = args[0], args[1]
    out = os.path.abspath(args[2]) if len(args) > 2 else os.path.join(paths.WORK, 'cap', setname)
    os.makedirs(out, exist_ok=True)
    for sub in ('cfg', 'nvram'):
        os.makedirs(os.path.join(paths.WORK, sub), exist_ok=True)
    last = max(int(x) for part in frames.split(',') for x in
               ((part.split('-')[1].split('/')[0],) if '-' in part else (part,)))
    env = dict(os.environ, DUMPDIR=out, DUMPFRAMES=frames, LASTFRAME=str(last),
               SCHEDULE='play' if '--play' in opts else 'none', SEED=opts.get('--seed', '1'))
    if '--hold' in opts:
        env['HOLD'] = opts['--hold']
    if '--service' in opts:
        env['SERVICE'] = opts['--service']
    cfg = os.path.join(paths.WORK, 'cfg', setname + '.cfg')
    if os.path.exists(cfg):
        os.remove(cfg)
    if '--prot' in opts:
        env['PROTLOG'] = os.path.join(out, 'prot.log')
    cmd = [paths.MAME, setname, '-rompath', paths.ROMS, '-cfg_directory', os.path.join(paths.WORK, 'cfg'),
           '-nvram_directory', os.path.join(paths.WORK, 'nvram'), '-video', 'none', '-sound', 'none', '-nothrottle',
           '-skip_gameinfo', '-autoboot_script', os.path.join(paths.LUA, 'gx2_capture.lua'),
           '-seconds_to_run', str(last // 59 + 30)]
    r = subprocess.run(cmd, env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
    for line in r.stdout.splitlines():
        if 'REDUMP' not in line and ('rror' in line or 'cannot' in line):
            print(line)
    n = sum(1 for f in os.listdir(out) if f.endswith('.ppm'))
    print('%s: %d frames in %s (MAME exit %d)' % (setname, n, out, r.returncode))
    return 0 if n else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv))
