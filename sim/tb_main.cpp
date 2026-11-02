// Whole-machine bench driver (sim/tb_top.sv): loads an image (tools/gx2_rom.py), runs the machine, writes frames.
//
//   Vtb_top <image.rom> <game 0|1> <frames> <outdir> [+play] [+pc] [+wdt] [+vlog=f] [+rate=n] [+test=f] [+hold=bit:a-b ...]
//     frames: "a,b,c" or "first-last/step" (frames counted at VBLANK, the first one 0)
//     +play: six coins from frame 300, start at 450 and 800 (as tools/lua/gx2_capture.lua's SCHEDULE=play)
//     +test=f: the test switch (OSD Service Mode) on from frame f (0: from power-on)
//     +hold=bit:a-b: pad 1's joystick bit held over frames a..b (0 right, 1 left, 2 down, 3 up, 4.. B1..B6, 10 Start,
//            11 Coin; Moto Frenzy's AUX1..3 are 6..8); may be given more than once
//     +pc:   print the 68EC020's address every 10 frames
//     +wdt:  the sound watchdog's timing (SERVICE and response reads after each heartbeat, tb_top.sv)
//     +vlog=f: the frame pacing from frame f: MO control changes, RLE draw times, video writes by line (tb_top.sv;
//            tools/lua/gx2_vlog.lua logs MAME's)
//     +rate=n: the CPU paced to n / 16 steps a clock (gx2_main's cpu_rate; 16, the default: unpaced)
#include "Vtb_top.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <set>
#include <string>
#include <sys/stat.h>
#include <vector>

static std::vector<uint16_t> sdram;          // the image's first 0x330000 bytes, as 16-bit words (even byte high)
static std::vector<uint64_t> ddr;            // qwords 0x06000000 .. 0x06A00000
static const uint32_t DDR_BASE = 0x06000000, DDR_SIZE = 0x00A00000;

extern "C" int sdram_rd(int waddr) {
	uint32_t a = (uint32_t)waddr;
	return a < sdram.size() ? sdram[a] : 0;
}
extern "C" long long ddr_rd(int qaddr) {
	uint32_t q = (uint32_t)qaddr - DDR_BASE;
	return q < DDR_SIZE ? (long long)ddr[q] : 0;
}
extern "C" void ddr_wr(int qaddr, long long data, int be) {
	uint32_t q = (uint32_t)qaddr - DDR_BASE;
	if (q >= DDR_SIZE) return;
	uint64_t v = ddr[q];
	for (int i = 0; i < 8; i++)
		if (be >> i & 1) v = (v & ~(0xFFull << 8 * i)) | ((uint64_t)data & (0xFFull << 8 * i));
	ddr[q] = v;
}

static std::set<int> parse_frames(const char *s, int &last) {
	std::set<int> out;
	last = 0;
	std::string str(s);
	size_t p = 0;
	while (p <= str.size()) {
		size_t c = str.find(',', p);
		std::string part = str.substr(p, c == std::string::npos ? std::string::npos : c - p);
		int a, b, st;
		if (sscanf(part.c_str(), "%d-%d/%d", &a, &b, &st) == 3) {
			for (int f = a; f <= b; f += st) out.insert(f);
			if (b > last) last = b;
		} else if (!part.empty()) {
			int f = atoi(part.c_str());
			out.insert(f);
			if (f > last) last = f;
		}
		if (c == std::string::npos) break;
		p = c + 1;
	}
	return out;
}

int main(int argc, char **argv) {
	if (argc < 5) {
		fprintf(stderr, "usage: Vtb_top <image.rom> <game> <frames> <outdir> [+play] [+pc] [+wdt] [+vlog=f] [+rate=n] "
		                "[+test=f] [+hold=bit:a-b ...]\n");
		return 2;
	}
	Verilated::commandArgs(argc, argv);
	bool play = false, showpc = false;
	int test_from = -1;
	struct Hold { int bit, a, b; };
	std::vector<Hold> holds;
	for (int i = 5; i < argc; i++) {
		if (!strcmp(argv[i], "+play")) play = true;
		if (!strcmp(argv[i], "+pc")) showpc = true;
		if (!strncmp(argv[i], "+test=", 6)) test_from = atoi(argv[i] + 6);
		Hold h;
		if (sscanf(argv[i], "+hold=%d:%d-%d", &h.bit, &h.a, &h.b) == 3) holds.push_back(h);
	}
	FILE *f = fopen(argv[1], "rb");
	if (!f) { perror(argv[1]); return 1; }
	std::vector<uint8_t> img;
	{
		uint8_t buf[65536];
		size_t n;
		while ((n = fread(buf, 1, sizeof buf, f)) > 0) img.insert(img.end(), buf, buf + n);
		fclose(f);
	}
	const size_t SND = 0x320000, RLE = 0x330000;
	sdram.assign(0x400000, 0);
	for (size_t i = 0; i + 1 < SND; i += 2) sdram[i / 2] = (uint16_t)(img[i] << 8 | img[i + 1]);
	ddr.assign(DDR_SIZE, 0);
	for (size_t i = RLE; i < img.size(); i++) {
		size_t o = i - RLE;
		ddr[o / 8] |= (uint64_t)img[i] << (8 * (o % 8));
	}
	int game = atoi(argv[2]);
	int last;
	std::set<int> want = parse_frames(argv[3], last);
	std::string outdir = argv[4];
	mkdir(outdir.c_str(), 0755);

	Vtb_top *top = new Vtb_top;
	top->game = game;
	top->rle_words = (uint32_t)((img.size() - RLE) / 2);
	top->joy0 = 0; top->joy1 = 0; top->test = test_from == 0;
	top->reset = 1;
	top->clk_sys = 0; top->clk_cpu = 0;

	uint64_t cyc = 0;
	auto tick = [&]() {          // one clk_sys period; clk_cpu rises on every other clk_sys rise
		top->clk_sys = 1;
		if ((cyc & 1) == 0) top->clk_cpu = 1;
		top->eval();
		top->clk_sys = 0;
		if ((cyc & 1) == 1) top->clk_cpu = 0;
		top->eval();
		cyc++;
	};

	// the 6502 ROM through the JSA's load port, under reset
	for (int i = 0; i < 0x10000; i++) {
		top->rom_we = 1; top->rom_addr = i; top->rom_data = img[SND + i];
		tick();
	}
	top->rom_we = 0;
	for (int i = 0; i < 64; i++) tick();
	top->reset = 0;
	for (int i = 0; i < 4; i++) tick();
	top->prescan_go = 1; tick(); top->prescan_go = 0;
	uint64_t t0 = cyc;
	while (!top->prescan_done) tick();
	printf("prescan: %llu clocks\n", (unsigned long long)(cyc - t0));

	std::vector<uint8_t> fb(336 * 240 * 3);
	int frame = 0, x = 0, y = 0;
	bool vb_d = true, hb_d = true;
	while (frame <= last) {
		tick();
		if (top->ce_pix) {
			if (!top->vblank && vb_d) y = 0;
			if (!top->hblank && !top->vblank) {
				if (x < 336 && y < 240) {
					uint8_t *p = &fb[(y * 336 + x) * 3];
					p[0] = top->r; p[1] = top->g; p[2] = top->b;
				}
				x++;
			}
			if (top->hblank && !hb_d) { x = 0; if (!top->vblank) y++; }
			hb_d = top->hblank;
			if (top->vblank && !vb_d) {
				if (want.count(frame)) {
					char name[512];
					snprintf(name, sizeof name, "%s/%05d.ppm", outdir.c_str(), frame);
					FILE *o = fopen(name, "wb");
					fprintf(o, "P6\n336 240\n255\n");
					fwrite(fb.data(), 1, fb.size(), o);
					fclose(o);
				}
				if (showpc && frame % 10 == 0) printf("frame %d pc %06X\n", frame, top->dbg_pc & 0xFFFFFF);
				fflush(stdout);
				frame++;
				uint32_t j = 0;
				if (play) {
					const int c = frame - 300;
					const bool coin = c >= 0 && c < 120 && (c % 20) < 8;
					const bool start = (frame >= 450 && frame < 460) || (frame >= 800 && frame < 810);
					j = (coin ? (1u << 11) : 0) | (start ? (1u << 10) : 0);
				}
				for (const Hold &h : holds)
					if (frame >= h.a && frame <= h.b) j |= 1u << h.bit;
				top->joy0 = j;
				if (test_from >= 0 && frame >= test_from) top->test = 1;
			}
			vb_d = top->vblank;
		}
	}
	printf("done: %d frames, %llu clocks\n", frame, (unsigned long long)cyc);
	top->final();
	delete top;
	return 0;
}
