-- MAME 0.289 autoboot script: Space Lords' main loop work between its waits at 1A024 (until bit 0 of FFAE5A clears):
-- the frame and the work's length (us). BLOG the log, F0 / F1 its frames; coins and start as the play schedule
local out = io.open(os.getenv("BLOG"), "w")
local f0, f1 = tonumber(os.getenv("F0") or "0"), tonumber(os.getenv("F1") or "900")
local cpu = manager.machine.devices[":maincpu"]
local sp = cpu.spaces["program"]
local screen = manager.machine.screens[":screen"]
local function now() return manager.machine.time:as_double() end
local start = nil
gx2_b_taps = {}
gx2_b_taps[1] = sp:install_read_tap(0xffae58, 0xffae5b, "idle", function(offset, data, mask)
	local pc = cpu.state["PC"].value
	if pc < 0x1a024 or pc > 0x1a02e then return end
	local f = screen:frame_number()
	if start then
		if f >= f0 and f <= f1 then out:write(string.format("%d %.0f\n", f, (now() - start) * 1e6)) end
		start = nil
	end
	if (data & 1) == 0 then start = now() end
end)
local function field(name)
	for _, p in pairs(manager.machine.ioport.ports) do for _, fl in pairs(p.fields) do if fl.name == name then return fl end end end
end
gx2_b_sub = emu.add_machine_frame_notifier(function()
	local frame = screen:frame_number()
	local c = frame - 300
	local coin, start1 = field("Coin 1"), field("1 Player Start")
	if coin then coin:set_value((c >= 0 and c < 120 and (c % 20) < 8) and 1 or 0) end
	if start1 then start1:set_value(((frame >= 450 and frame < 460) or (frame >= 800 and frame < 810)) and 1 or 0) end
	if frame > f1 then out:close(); manager.machine:exit() end
end)
