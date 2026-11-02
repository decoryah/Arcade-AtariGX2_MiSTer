-- MAME 0.289 autoboot script: Moto Frenzy's main loop work per pass in its idle loop (131CE: tst.b FFCCE5): the
-- frame, the time from the last heartbeat 03 (the VBLANK interrupt) to the flag seen set, and the work until the loop
-- reads it again (us). BLOG the log, F0 / F1 its frames; the play schedule
local out = io.open(os.getenv("BLOG"), "w")
local f0, f1 = tonumber(os.getenv("F0") or "0"), tonumber(os.getenv("F1") or "900")
local cpu = manager.machine.devices[":maincpu"]
local sp = cpu.spaces["program"]
local screen = manager.machine.screens[":screen"]
local function now() return manager.machine.time:as_double() end
local hb, start = 0, nil
gx2_b_taps = {}
gx2_b_taps[1] = sp:install_write_tap(0xe06000, 0xe06003, "cmd", function(offset, data, mask)
	if (mask & 0xff000000) ~= 0 and ((data >> 24) & 0xff) == 3 then hb = now() end
end)
gx2_b_taps[2] = sp:install_read_tap(0xffcce4, 0xffcce7, "idle", function(offset, data, mask)
	local pc = cpu.state["PC"].value; if pc < 0x131ce or pc > 0x131d6 then return end
	local f = screen:frame_number()
	if start then
		if f >= f0 and f <= f1 then out:write(string.format("%d %.0f %.0f\n", f, (start - hb) * 1e6, (now() - start) * 1e6)) end
		start = nil
	end
	if ((data >> 16) & 0xff) ~= 0 then start = now() end
end)
local function field(name)
	for _, p in pairs(manager.machine.ioport.ports) do for _, fl in pairs(p.fields) do if fl.name == name then return fl end end end
end
gx2_b_sub = emu.add_machine_frame_notifier(function()
	local frame = screen:frame_number()
	local c = frame - 300
	field("Coin 1"):set_value((c >= 0 and c < 120 and (c % 20) < 8) and 1 or 0)
	field("1 Player Start"):set_value(((frame >= 450 and frame < 460) or (frame >= 800 and frame < 810)) and 1 or 0)
	if frame > f1 then out:close(); manager.machine:exit() end
end)
