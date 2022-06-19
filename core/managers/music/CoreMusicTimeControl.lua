core:module("CoreMusicTimeControl")
core:require_module("CoreClass")
MAX_STREAMING = 3
if not MusicTimeControl then
	MusicTimeControl = CoreClass.class()
end
MusicTimeControl.init = function(l_1_0)
	l_1_0._wall_clock = TimerManager:wall()
	l_1_0._last = l_1_0._wall_clock:time()
	l_1_0._pitch = 1
	l_1_0._offset = 0
	l_1_0._soundobjects = {}
	local l_1_1 = setmetatable
	local l_1_2 = l_1_0._soundobjects
	local l_1_3 = {}
	l_1_3.__mode = "kv"
	l_1_1(l_1_2, l_1_3)
end

MusicTimeControl.time = function(l_2_0)
	local l_2_1 = l_2_0._wall_clock:time()
	l_2_0._offset = l_2_0._offset + (l_2_1 - l_2_0._last) * (1 - l_2_0._pitch)
	l_2_0._last = l_2_1
	if not l_2_0._pause_time then
		return l_2_1 - l_2_0._offset
	end
end

MusicTimeControl.set_pitch = function(l_3_0, l_3_1)
	local l_3_6, l_3_7 = nil
	l_3_0:time()
	local l_3_5 = math.max
	l_3_5 = l_3_5(math.min(l_3_1, 2), 0)
	l_3_0._pitch = l_3_5
	l_3_5 = l_3_0._pause_time
	if l_3_5 == nil then
		l_3_5 = pairs
		l_3_5 = l_3_5(l_3_0._soundobjects)
		for i_0,i_1 in l_3_5 do
			i_1:set_control("pitch_abs", l_3_0._pitch)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

MusicTimeControl.pitch = function(l_4_0, l_4_1)
	return l_4_0._pitch
end

MusicTimeControl.pause = function(l_5_0)
	local l_5_4, l_5_5, l_5_6, l_5_7 = nil
	l_5_0._pause_time = l_5_0:time()
	for i_0,i_1 in pairs(l_5_0._soundobjects) do
		i_1:pause()
	end
end

MusicTimeControl.resume = function(l_6_0)
	local l_6_5, l_6_6, l_6_7, l_6_8 = nil
	local l_6_1 = l_6_0._wall_clock:time()
	l_6_0._offset = l_6_1 - l_6_0._pause_time
	l_6_0._last = l_6_1
	l_6_0._pause_time = nil
	for i_0,i_1 in pairs(l_6_0._soundobjects) do
		i_1:unpause()
	end
end

MusicTimeControl.is_paused = function(l_7_0)
	return l_7_0._pause_time ~= nil
end

MusicTimeControl.new_soundobject = function(l_8_0, l_8_1, l_8_2, l_8_3)
	local l_8_12, l_8_13, l_8_14, l_8_15 = nil
	local l_8_4 = PrioSoundObject:new(l_8_1, l_8_2)
	if l_8_0._pitch ~= 1 then
		l_8_4:set_control("pitch_abs", l_8_0._pitch)
	end
	if l_8_3 then
		local l_8_5 = l_8_0:_nowstreaming()
		while MAX_STREAMING <= #l_8_5 do
			l_8_4:_suppress()
		else
			local l_8_6 = l_8_0:_nowstreaming()
			while MAX_STREAMING <= #l_8_6 do
			end
			local l_8_7 = 10
			local l_8_8 = nil
			for i_0,i_1 in ipairs(l_8_6) do
				if i_1:_gain() < l_8_7 then
					l_8_7 = i_1:_gain()
					l_8_8 = i_1
				end
			end
			l_8_8:_suppress()
			l_8_6 = l_8_0:_nowstreaming()
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		l_8_6 = l_8_0._soundobjects
		l_8_6[l_8_4] = l_8_4
		return l_8_4
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

MusicTimeControl._nowstreaming = function(l_9_0)
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10 = nil
	local l_9_1 = {}
	for i_0,i_1 in pairs(l_9_0._soundobjects) do
		if i_1:_isstreaming() then
			table.insert(l_9_1, i_1)
		end
	end
	return l_9_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not PrioSoundObject then
	PrioSoundObject = CoreClass.class()
end
PrioSoundObject.init = function(l_10_0, l_10_1, l_10_2)
	l_10_0._soundobject = Sound:make_bank(l_10_1, l_10_2)
	assert(l_10_0._soundobject, string.format("Could not create sound object '%s'/'%s'", l_10_1, l_10_2))
end

PrioSoundObject._isstreaming = function(l_11_0)
	if l_11_0._soundobject then
		if l_11_0._soundobject:is_playing() then
			return true
		else
			return false
		end
	else
		return false
	end
end

PrioSoundObject._gain = function(l_12_0)
	local l_12_1, l_12_2 = l_12_0._soundobject:get_control, l_12_0._soundobject
	local l_12_3 = "gain_abs"
	return l_12_1(l_12_2, l_12_3)
end

PrioSoundObject._suppress = function(l_13_0)
	if l_13_0._soundobject then
		l_13_0._soundobject:stop()
		l_13_0._soundobject = nil
	end
end

PrioSoundObject.play = function(l_14_0, ...)
	if l_14_0._soundobject then
		l_14_0._soundobject:play(...)
	end
end

PrioSoundObject.set_control = function(l_15_0, ...)
	if l_15_0._soundobject then
		l_15_0._soundobject:set_control(...)
	end
end

PrioSoundObject.set_control_ramp = function(l_16_0, ...)
	if l_16_0._soundobject then
		l_16_0._soundobject:set_control_ramp(...)
	end
end

PrioSoundObject.get_control = function(l_17_0, ...)
	if l_17_0._soundobject then
		local l_17_2 = l_17_0._soundobject:get_control
		local l_17_3 = l_17_0._soundobject
		return l_17_2(l_17_3, ...)
	else
		return 1
	end
end

PrioSoundObject.stop = function(l_18_0, ...)
	if l_18_0._soundobject then
		l_18_0._soundobject:stop(...)
		l_18_0._soundobject = nil
	end
end

PrioSoundObject.pause = function(l_19_0, ...)
	if l_19_0._soundobject then
		l_19_0._soundobject:pause(...)
	end
end

PrioSoundObject.unpause = function(l_20_0, ...)
	if l_20_0._soundobject then
		l_20_0._soundobject:unpause(...)
	end
end


