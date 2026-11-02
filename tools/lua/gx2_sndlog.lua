-- MAME 0.289 autoboot script: logs the main CPU's side of the JSA IIIs' sound comm for sim/tb_jsa (tools/sndlog.py),
-- with the machine time of each access, while MAME's -wavwrite records the sound:
--   SNDLOG     the log file: "<seconds> C <byte>" command (E06000), "<seconds> R" response read (E86000),
--              "<seconds> L <0|1>" the latch's /SNDRES (D20 of E08000, written with bits 16-23), "<seconds> K <0|1>" coin 1
--   SCHEDULE   "play": six coins from 300, start at 450 and 800 (as gx2_capture.lua)
--   LASTFRAME  exit after this frame
local logname = os.getenv("SNDLOG") or "snd.log"
local schedule = os.getenv("SCHEDULE") or "none"
local last = tonumber(os.getenv("LASTFRAME") or "600")

local cpu = manager.machine.devices[":maincpu"]
local space = cpu.spaces["program"]
local screen = manager.machine.screens[":screen"]
local log = io.open(logname, "w")
local function now() return manager.machine.time:as_double() end

gx2_snd_taps = {}
gx2_snd_taps[1] = space:install_write_tap(0xe06000, 0xe06003, "sndcmd", function(offset, data, mask)
	if (mask & 0xff000000) ~= 0 then log:write(string.format("%.9f C %02X\n", now(), (data >> 24) & 0xff)) end
end)
gx2_snd_taps[2] = space:install_read_tap(0xe86000, 0xe86003, "sndrsp", function(offset, data, mask)
	if (mask & 0xff000000) ~= 0 then log:write(string.format("%.9f R\n", now())) end
end)
gx2_snd_taps[3] = space:install_write_tap(0xe08000, 0xe08003, "latch", function(offset, data, mask)
	if (mask & 0x00ff0000) ~= 0 then log:write(string.format("%.9f L %d\n", now(), (data >> 20) & 1)) end
end)

local function field(name)
	for _, p in pairs(manager.machine.ioport.ports) do
		for _, fl in pairs(p.fields) do if fl.name == name then return fl end end
	end
	return nil
end
local coin_on = false
local function press(name, on)
	local fl = field(name)
	if fl then fl:set_value(on and 1 or 0) end
	if name == "Coin 1" and on ~= coin_on then
		coin_on = on
		log:write(string.format("%.9f K %d\n", now(), on and 1 or 0))
	end
end

gx2_snd_sub = emu.add_machine_frame_notifier(function()
	local frame = screen:frame_number()
	if schedule == "play" then
		local c = frame - 300
		press("Coin 1", c >= 0 and c < 120 and (c % 20) < 8)
		press("1 Player Start", (frame >= 450 and frame < 460) or (frame >= 800 and frame < 810))
	end
	if frame >= last then
		log:close()
		manager.machine:exit()
	end
end)
