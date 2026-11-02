-- MAME 0.289 autoboot script: Moto Frenzy's sound watchdog (6DC8) each frame: its state (FF82CA: 0 waits for the
-- board's FF after a reset, 3 counts down, 2 sends 07, 1 checks the reply), timer FF82C8, 07's reply FF82CC, the
-- heartbeat's no-reply count FF803C and the comm block FF8040-49. WLOG the log, LASTFRAME; the play schedule
local out = io.open(os.getenv("WLOG"), "w")
local last = tonumber(os.getenv("LASTFRAME") or "1000")
local sp = manager.machine.devices[":maincpu"].spaces["program"]
local screen = manager.machine.screens[":screen"]
local function field(name)
	for _, p in pairs(manager.machine.ioport.ports) do for _, fl in pairs(p.fields) do if fl.name == name then return fl end end end
end
gx2_wd_sub = emu.add_machine_frame_notifier(function()
	local frame = screen:frame_number()
	local c = frame - 300
	field("Coin 1"):set_value((c >= 0 and c < 120 and (c % 20) < 8) and 1 or 0)
	field("1 Player Start"):set_value(((frame >= 450 and frame < 460) or (frame >= 800 and frame < 810)) and 1 or 0)
	local b = {}
	for i = 0, 9 do b[#b + 1] = string.format("%02X", sp:read_u8(0xff8040 + i)) end
	out:write(string.format("%d st %d t %d r07 %02X nr %d blk %s\n", frame, sp:read_i16(0xff82ca), sp:read_i16(0xff82c8),
		sp:read_u8(0xff82cc), sp:read_u8(0xff803c), table.concat(b, " ")))
	if frame >= last then out:close(); manager.machine:exit() end
end)
