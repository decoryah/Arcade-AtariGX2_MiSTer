-- MAME 0.289 autoboot script: the timing of the main CPU's sound watchdog against the heartbeat, in us after each frame's
-- heartbeat command 03: "<frame> C <cmd> <us>" commands, "<frame> R <reply> <us>" reply reads, "<frame> W <bit 5> ptr
-- <8046> <us>" each read of SERVICE (E82001; bit 5: the command latch empty) from PCLO..PCHI, the send-with-reply
-- routine's test (Moto Frenzy 0x1510-0x1520, Space Lords 0x20C0-0x20D0; 8046 is Moto Frenzy's reply pointer)
--   TLOG the log, F0 / F1 its frames; coins from 300, start at 450 and 800 (as gx2_sndlog.lua's SCHEDULE=play)
local out = io.open(os.getenv("TLOG"), "w")
local f0, f1 = tonumber(os.getenv("F0") or "560"), tonumber(os.getenv("F1") or "900")
local cpu = manager.machine.devices[":maincpu"]
local sp = cpu.spaces["program"]
local screen = manager.machine.screens[":screen"]
local function now() return manager.machine.time:as_double() end
local hb = 0
local function on() local f = screen:frame_number(); return f >= f0 and f <= f1, f end
gx2_t_taps = {}
gx2_t_taps[1] = sp:install_write_tap(0xe06000, 0xe06003, "cmd", function(offset, data, mask)
	local ok, f = on()
	if ok and (mask & 0xff000000) ~= 0 then
		local d = (data >> 24) & 0xff
		if d == 3 then hb = now() end
		out:write(string.format("%d C %02X %.1f\n", f, d, (now() - hb) * 1e6))
	end
end)
gx2_t_taps[2] = sp:install_read_tap(0xe86000, 0xe86003, "rsp", function(offset, data, mask)
	local ok, f = on()
	if ok and (mask & 0xff000000) ~= 0 then out:write(string.format("%d R %02X %.1f\n", f, (data >> 24) & 0xff, (now() - hb) * 1e6)) end
end)
gx2_t_taps[3] = sp:install_read_tap(0xe82000, 0xe82003, "svc", function(offset, data, mask)
	local ok, f = on()
	if ok and cpu.state["PC"].value >= tonumber(os.getenv("PCLO")) and cpu.state["PC"].value <= tonumber(os.getenv("PCHI")) then
		out:write(string.format("%d W %X ptr %08X %.1f\n", f, (data >> 5) & 1, sp:read_u32(0xff8046), (now() - hb) * 1e6))
	end
end)
local function field(name)
	for _, p in pairs(manager.machine.ioport.ports) do for _, fl in pairs(p.fields) do if fl.name == name then return fl end end end
end
gx2_t_sub = emu.add_machine_frame_notifier(function()
	local frame = screen:frame_number()
	local c = frame - 300
	local coin, start1 = field("Coin 1"), field("1 Player Start")
	if coin then coin:set_value((c >= 0 and c < 120 and (c % 20) < 8) and 1 or 0) end
	if start1 then start1:set_value(((frame >= 450 and frame < 460) or (frame >= 800 and frame < 810)) and 1 or 0) end
	if frame > f1 then out:close(); manager.machine:exit() end
end)
