-- MAME 0.289 autoboot script: the frame pacing, as sim/tb_top.sv's +vlog logs the core's. "vid <frame> ctl <line>
-- <bits>" each change of the MO control bits (2 frame, 1 erase, 0 /MOGO: MAME draws the objects at once on the rising
-- edge of bit 0), "vid <frame> w <region> <n> <v0> <v1>" the frame's word writes to a region and the lines of the first
-- and last: pf the playfield (D72000), al the alphanumerics (D76000) but sc their per-line scroll entries (words 48-63
-- of each 64), mo the RLE object RAM (D78000), pal the palette (D40000)
--   VLOG the log, F0 / F1 its frames
-- (0.289's screen has no vpos(): the line is worked out from time_until_pos(0, 0), as screen_device::vpos does.)
local out = io.open(os.getenv("VLOG"), "w")
local f0, f1 = tonumber(os.getenv("F0") or "1500"), tonumber(os.getenv("F1") or "1700")
local sp = manager.machine.devices[":maincpu"].spaces["program"]
local screen = manager.machine.screens[":screen"]
local scan = screen.scan_period
local function vpos() return (262 - math.ceil(screen:time_until_pos(0, 0) / scan - 0.5)) % 262 end
local ctl = -1
local names = {"pf", "al", "sc", "mo", "pal"}
local w_f, w = -1, {}
local function flush(f)
	if f ~= w_f then
		if w_f >= f0 then
			for i, nm in ipairs(names) do
				local r = w[i]
				if r then out:write(string.format("vid %d w %s %d %d %d\n", w_f, nm, r.n, r.v0, r.v1)) end
			end
		end
		w_f, w = f, {}
	end
end
local function wr(i, mask)
	local f = screen:frame_number()
	flush(f)
	if f < f0 then return end
	local n = ((mask & 0xffff0000) ~= 0 and 1 or 0) + ((mask & 0xffff) ~= 0 and 1 or 0)
	local v = vpos()
	local r = w[i]
	if not r then r = {n = 0, v0 = v}; w[i] = r end
	r.n = r.n + n
	r.v1 = v
end
gx2_v_taps = {}
gx2_v_taps[1] = sp:install_write_tap(0xe08000, 0xe08003, "latch", function(offset, data, mask)
	local f = screen:frame_number()
	if (mask & 0xff000000) ~= 0 then
		local bits = (data >> 27) & 7
		if bits ~= ctl and f >= f0 then
			out:write(string.format("vid %d ctl %d %d%d%d\n", f, vpos(), (bits >> 2) & 1, (bits >> 1) & 1, bits & 1))
		end
		ctl = bits
	end
end)
gx2_v_taps[2] = sp:install_write_tap(0xd72000, 0xd75fff, "pf", function(offset, data, mask) wr(1, mask) end)
gx2_v_taps[3] = sp:install_write_tap(0xd76000, 0xd76fff, "al", function(offset, data, mask)
	wr(((offset - 0xd76000) & 0x7f) >= 0x60 and 3 or 2, mask)
end)
gx2_v_taps[4] = sp:install_write_tap(0xd78000, 0xd78fff, "mo", function(offset, data, mask) wr(4, mask) end)
gx2_v_taps[5] = sp:install_write_tap(0xd40000, 0xd40fff, "pal", function(offset, data, mask) wr(5, mask) end)
gx2_v_sub = emu.add_machine_frame_notifier(function()
	local f = screen:frame_number()
	flush(f)
	if f > f1 then out:close(); manager.machine:exit() end
end)
