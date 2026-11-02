// The JSA IIIs alone (rtl/gx2_jsa.sv) replaying the main CPU's side of the sound comm logged from MAME
// (tools/lua/gx2_sndlog.lua): commands, response reads, /SNDRES and coin 1 at MAME's machine times, the latches'
// handshake kept (a command waits while the last one is unread, up to 2 ms; a response read waits for the response, up
// to 0.2 ms). The OKIs' sample bytes come from the image as AtariGX2.sv's SDRAM port gives them (a one-clock ack some
// clocks after the request). Writes the board's output as a 48 kHz stereo WAV, for tools/cmp_audio.py against MAME's
// -wavwrite.
//
//   tb_jsa <image.rom> <sndlog> <out.wav> <seconds> [<trace from s> <cycles>]
//     trace: the 6502's bus (address, R/W, data) on each of its cycles from that time, to stdout
// The first time a command stays unread for 1 ms (the 6502 missed its NMI), the last 3000 of the 6502's cycles go to
// stdout with T65's interrupt state.
#include "Vgx2_jsa.h"
#include "Vgx2_jsa___024root.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>
#include <vector>

struct Ev { double t; char k; int v; };

static void put16(FILE *f, uint16_t v) { fputc(v & 0xff, f); fputc(v >> 8, f); }
static void put32(FILE *f, uint32_t v) { put16(f, v & 0xffff); put16(f, v >> 16); }

int main(int argc, char **argv) {
	if (argc < 5) { fprintf(stderr, "tb_jsa <image.rom> <sndlog> <out.wav> <seconds>\n"); return 1; }
	Verilated::commandArgs(argc, argv);

	std::vector<uint8_t> img;
	{
		FILE *f = fopen(argv[1], "rb");
		if (!f) { perror(argv[1]); return 1; }
		fseek(f, 0, SEEK_END); img.resize(ftell(f)); fseek(f, 0, SEEK_SET);
		if (fread(img.data(), 1, img.size(), f) != img.size()) { fprintf(stderr, "short read\n"); return 1; }
		fclose(f);
	}
	std::vector<Ev> ev;
	{
		FILE *f = fopen(argv[2], "r");
		if (!f) { perror(argv[2]); return 1; }
		char line[128];
		while (fgets(line, sizeof line, f)) {
			for (char *p = line; *p; p++) if (*p == ',') *p = '.';   // Lua writes the locale's decimal comma
			Ev e{0, 0, 0};
			char k;
			unsigned v = 0;
			int n = sscanf(line, "%lf %c %x", &e.t, &k, &v);
			if (n < 2) continue;
			e.k = k; e.v = (int)v;
			ev.push_back(e);
		}
		fclose(f);
	}
	const double F = 24.0 * 3579545.0;          // clk_sys
	const double seconds = atof(argv[4]);
	const double trace_t = argc > 6 ? atof(argv[5]) : -1;
	long trace_n = argc > 6 ? atol(argv[6]) : 0;

	Vgx2_jsa *m = new Vgx2_jsa;
	auto tick = [&]() { m->clk = 0; m->eval(); m->clk = 1; m->eval(); };

	m->rst = 1;
	for (int a = 0; a < 0x10000; a++) {
		m->rom_we = 1; m->rom_addr = a; m->rom_data = img[0x320000 + a];
		tick();
	}
	m->rom_we = 0;
	for (int i = 0; i < 100; i++) tick();
	m->rst = 0;

	std::vector<int16_t> wav;
	uint64_t c = 0;
	const uint64_t end = (uint64_t)(seconds * F);
	double next_s = 0;
	const double per = F / 48000.0;
	size_t ei = 0;
	bool cmd_t = false, rsp_t = false;
	int pcm_wait = 0;
	uint32_t pcm_a = 0;
	unsigned waited_c = 0, waited_r = 0, forced_c = 0, forced_r = 0;

	struct Cy { uint64_t c; uint16_t a, pc; uint8_t d, ir, mc; bool r, nmi_n, act, nmic, irqc, irq_n; };
	const long RING = 3000;
	std::vector<Cy> ring(RING);
	long rn = 0;
	uint64_t ready_since = 0;
	bool dumped = false;

	while (c < end) {
		if (ei < ev.size()) {
			const Ev &e = ev[ei];
			const double tc = e.t * F;
			if ((double)c >= tc) {
				bool go = true;
				if (e.k == 'C' && m->main_to_sound_ready) {
					go = (double)c > tc + 0.002 * F;
					if (go) forced_c++; else if ((double)c < tc + 1) waited_c++;
				} else if (e.k == 'R' && !m->sound_to_main_ready) {
					go = (double)c > tc + 0.0002 * F;
					if (go) forced_r++; else if ((double)c < tc + 1) waited_r++;
				}
				if (go) {
					switch (e.k) {
						case 'C': m->cmd_data = e.v; cmd_t = !cmd_t; m->cmd_tgl = cmd_t; break;
						case 'R': rsp_t = !rsp_t; m->rsp_rd_tgl = rsp_t; break;
						case 'L': m->snd_reset = !e.v; break;
						case 'K': m->coin1 = e.v; break;
					}
					ei++;
				}
			}
		}

		// the SDRAM port: an ack (one clock) ten clocks after the request
		m->pcm_ack = 0;
		if (pcm_wait > 0) {
			if (--pcm_wait == 0) { m->pcm_q = img[0x080000 + pcm_a]; m->pcm_ack = 1; }
		} else if (m->pcm_req) {
			pcm_a = m->pcm_addr; pcm_wait = 10;
		}

		const bool cen = m->rootp->gx2_jsa__DOT__cen_cpu;
		const unsigned ta = m->rootp->gx2_jsa__DOT__A24 & 0xffff;
		const bool trw = m->rootp->gx2_jsa__DOT__rw_n;
		const unsigned tdi = m->rootp->gx2_jsa__DOT__cpu_di, tdo = m->rootp->gx2_jsa__DOT__cpu_do;
		if (cen) {
			auto *r = m->rootp;
			Cy &y = ring[rn++ % RING];
			y.c = c; y.a = ta; y.r = trw; y.d = trw ? tdi : tdo;
			y.pc = r->gx2_jsa__DOT__u_cpu__DOT__pc; y.ir = r->gx2_jsa__DOT__u_cpu__DOT__ir;
			y.mc = r->gx2_jsa__DOT__u_cpu__DOT__mcycle;
			y.nmi_n = !m->main_to_sound_ready; y.act = r->gx2_jsa__DOT__u_cpu__DOT__nmiact;
			y.nmic = r->gx2_jsa__DOT__u_cpu__DOT__nmicycle; y.irqc = r->gx2_jsa__DOT__u_cpu__DOT__irqcycle;
			y.irq_n = r->gx2_jsa__DOT__irq_n;
		}
		if (!m->main_to_sound_ready) ready_since = c;
		else if (!dumped && c - ready_since > 0.001 * F) {
			dumped = true;
			fprintf(stderr, "command unread since %.6f s (the 6502 missed the NMI)\n", ready_since / F);
			printf("# time addr R/W data | PC IR mcycle | NMI_n nmiact nmicycle irqcycle IRQ_n\n");
			for (long k = rn > RING ? rn - RING : 0; k < rn; k++) {
				const Cy &y = ring[k % RING];
				printf("%.6f %04X %c %02X | %04X %02X %d | %d %d %d %d %d%s\n", y.c / F, y.a, y.r ? 'R' : 'W', y.d,
				       y.pc, y.ir, y.mc, y.nmi_n, y.act, y.nmic, y.irqc, y.irq_n,
				       y.c >= ready_since && y.c < ready_since + 48 ? "  <- command" : "");
			}
		}
		tick();
		c++;
		if (cen && trace_n > 0 && trace_t >= 0 && (double)c >= trace_t * F) {
			printf("%.6f %04X %c %02X\n", c / F, ta, trw ? 'R' : 'W', trw ? tdi : tdo);
			trace_n--;
		}
		if ((double)c >= next_s) {
			wav.push_back((int16_t)m->out_l);
			wav.push_back((int16_t)m->out_r);
			next_s += per;
		}
		if ((c & ((1u << 27) - 1)) == 0) { fprintf(stderr, "%.1f s\r", c / F); fflush(stderr); }
	}
	fprintf(stderr, "%.1f s simulated, %zu of %zu events; commands waited %u forced %u, response reads waited %u forced %u\n",
	        c / F, ei, ev.size(), waited_c, forced_c, waited_r, forced_r);

	FILE *f = fopen(argv[3], "wb");
	if (!f) { perror(argv[3]); return 1; }
	const uint32_t bytes = (uint32_t)(wav.size() * 2);
	fwrite("RIFF", 1, 4, f); put32(f, 36 + bytes); fwrite("WAVEfmt ", 1, 8, f);
	put32(f, 16); put16(f, 1); put16(f, 2); put32(f, 48000); put32(f, 48000 * 4); put16(f, 4); put16(f, 16);
	fwrite("data", 1, 4, f); put32(f, bytes);
	fwrite(wav.data(), 2, wav.size(), f);
	fclose(f);
	delete m;
	return 0;
}
