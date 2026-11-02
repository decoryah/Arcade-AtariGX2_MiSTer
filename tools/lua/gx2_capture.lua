-- MAME 0.289 autoboot script for the Atari GX2 sets (tools/capture.py):
--   DUMPDIR     output folder
--   DUMPFRAMES  frames to save, "a,b,c" or "first-last/step": <frame>.ppm (MAME's pixels, 336 x 240) and <frame>.ram
--               (palette D40000 4 KB, video RAM D70000 64 KB, MO RAM, C80000 4 KB, work RAM FF8000 32 KB)
--   PROTLOG     if set: every access to CA0000-CA0FFF / C80F00-C80FFF / D00000-D0000F with its mask, to this file
--   SCHEDULE    "play": six coins from 300, start at 450 and 800, then the buttons and the analog ports at random (SEED)
--   LASTFRAME   exit after this frame
--   HOLD, SERVICE  see below
local outdir = os.getenv("DUMPDIR") or "."
local spec = os.getenv("DUMPFRAMES") or ""
local protlog = os.getenv("PROTLOG")
local schedule = os.getenv("SCHEDULE") or "none"
local seed = tonumber(os.getenv("SEED") or "1")
local last = tonumber(os.getenv("LASTFRAME") or "0")

local want = {}
for part in string.gmatch(spec, "[^,]+") do
	local a, b, s = string.match(part, "^(%d+)-(%d+)/(%d+)$")
	if a then
		for f = tonumber(a), tonumber(b), tonumber(s) do want[f] = true; if f > last then last = f end end
	else
		local f = tonumber(part); want[f] = true; if f > last then last = f end
	end
end

local cpu = manager.machine.devices[":maincpu"]
local space = cpu.spaces["program"]
local screen = manager.machine.screens[":screen"]
local plog = nil
gx2_taps = {}

if protlog then
	plog = io.open(protlog, "w")
	local function tap(name, lo, hi)
		gx2_taps[#gx2_taps + 1] = space:install_read_tap(lo, hi, name .. "r", function(offset, data, mask)
			plog:write(string.format("%d R %06X %08X %08X %06X\n", screen:frame_number(), offset, data, mask, cpu.state["CURPC"].value))
		end)
		gx2_taps[#gx2_taps + 1] = space:install_write_tap(lo, hi, name .. "w", function(offset, data, mask)
			plog:write(string.format("%d W %06X %08X %08X %06X\n", screen:frame_number(), offset, data, mask, cpu.state["CURPC"].value))
		end)
	end
	tap("xga", 0xca0000, 0xca0fff)
	tap("poly", 0xc80f00, 0xc80fff)
	tap("adc", 0xd00000, 0xd0000f)
end

local function dump_ram(f, lo, hi)
	for a = lo, hi, 4 do
		local v = space:read_u32(a)
		f:write(string.char((v >> 24) & 0xff, (v >> 16) & 0xff, (v >> 8) & 0xff, v & 0xff))
	end
end

local function save(frame)
	local w, h = screen.width, screen.height
	local px = screen:pixels()
	local name = string.format("%s/%05d.ppm", outdir, math.floor(frame))
	local f, err = io.open(name, "wb")
	if not f then print("cannot write " .. name .. ": " .. tostring(err)); return end
	f:write(string.format("P6\n%d %d\n255\n", w, h))
	local t = {}
	for i = 0, w * h - 1 do
		local b, g, r = string.byte(px, i * 4 + 1, i * 4 + 3)
		t[#t + 1] = string.char(r, g, b)
		if #t == 4096 then f:write(table.concat(t)); t = {} end
	end
	f:write(table.concat(t))
	f:close()
	f = io.open(string.format("%s/%05d.ram", outdir, math.floor(frame)), "wb")
	dump_ram(f, 0xd40000, 0xd40fff)
	dump_ram(f, 0xd70000, 0xd7ffff)
	dump_ram(f, 0xc80000, 0xc80fff)
	dump_ram(f, 0xff8000, 0xffffff)
	f:close()
end

-- inputs by MAME's field name, in any port (the coins are in the JSA's port)
local function field(name)
	for _, p in pairs(manager.machine.ioport.ports) do
		for _, fl in pairs(p.fields) do if fl.name == name then return fl end end
	end
	return nil
end

math.randomseed(seed)
local function press(name, on)
	local fl = field(name)
	if fl then fl:set_value(on and 1 or 0) else print("no input " .. name) end
end

-- HOLD="name:first-last": hold an input over those frames (e.g. "AUX1:700-2400");
-- HOLD="name=value:first-last" sets an analog input to a port value instead (e.g. "P1 AD Stick X=0x00:850-1000");
-- several separated by ';' (the same input may appear more than once)
local holds = {}
for h in string.gmatch(os.getenv("HOLD") or "", "[^;]+") do
	local name, a, b = string.match(h, "^(.-):(%d+)-(%d+)$")
	local n, v = string.match(name, "^(.-)=(%w+)$")
	holds[#holds + 1] = {name = n or name, a = tonumber(a), b = tonumber(b), val = n and tonumber(v)}
end
local function hold_analog(name, val)
	local fl = field(name)
	if not fl then print("no input " .. name); return end
	if val then fl:set_value(val) else fl:clear_value() end
end

-- SERVICE="a" or "a-b": the board's test switch (PORT_SERVICE, a DIP-style field) on from frame a (off again after b);
-- MAME's cfg would keep it for the next run's power-on (where Moto Frenzy runs its power-on screen tests first):
-- capture.py removes the set's cfg
local svc_a, svc_b = string.match(os.getenv("SERVICE") or "", "^(%d+)-?(%d*)$")
svc_a = tonumber(svc_a); svc_b = tonumber(svc_b)
local function service_set(on)
	local fl = field("Service Mode")
	if fl then fl.user_value = on and 0 or fl.defvalue else print("no input Service Mode") end
end

gx2_sub = emu.add_machine_frame_notifier(function()
	local frame = screen:frame_number()
	if schedule == "play" then
		-- six coins (Moto Frenzy's default is 3 a credit), then start
		local c = frame - 300
		press("Coin 1", c >= 0 and c < 120 and (c % 20) < 8)
		press("1 Player Start", (frame >= 450 and frame < 460) or (frame >= 800 and frame < 810))
	end
	if svc_a and frame >= svc_a then service_set(true); svc_a = nil end
	if svc_b and frame > svc_b then service_set(false); svc_b = nil end
	local on, val = {}, {}
	for _, h in ipairs(holds) do
		local in_range = frame >= h.a and frame <= h.b
		on[h.name] = on[h.name] or in_range
		if h.val and in_range then val[h.name] = h.val end
	end
	for _, h in ipairs(holds) do
		if h.val then hold_analog(h.name, val[h.name]) else press(h.name, on[h.name]) end
	end
	if want[frame] then save(frame) end
	if last > 0 and frame >= last then
		if plog then plog:close(); plog = nil end
		manager.machine:exit()
	end
end)
