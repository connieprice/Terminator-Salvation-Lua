core:module("CoreSoundPlayHead")
core:require_module("CoreClass")
if not SoundPlayHead then
	SoundPlayHead = CoreClass.class()
end
local l_0_0 = 0
local l_0_1 = 1
local l_0_2 = 2
local l_0_3 = 3
local l_0_4 = 4
local l_0_5 = 5
local l_0_6 = 6
local l_0_7 = 7
local l_0_8 = 8
ENGINE_PLAY_SPEED = 1
SoundPlayHead.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	-- upvalues: l_0_0
	l_1_0._soundbank_name = l_1_1
	l_1_0._sound_name = l_1_2
	l_1_0._bar_offset = l_1_3
	l_1_0._time_ctrl = l_1_4
	l_1_0._master_volume = l_1_5
	l_1_0._master_changed = false
	l_1_0._state = l_0_0
	l_1_0._sound_object = l_1_0._time_ctrl:new_soundobject(l_1_1, l_1_2, l_1_6)
end

SoundPlayHead.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	-- upvalues: l_0_0 , l_0_1 , l_0_5 , l_0_4 , l_0_2 , l_0_3 , l_0_6 , l_0_7 , l_0_8
	if l_2_0._state == l_0_0 then
		do return end
	end
	if l_2_0._state == l_0_1 then
		l_2_0._start_time = l_2_0._time_ctrl:time()
		l_2_0._master_changed = false
		if l_2_0._fade == 0 then
			l_2_0._sound_object:set_control("gain_abs", l_2_0._master_volume)
			l_2_0._sound_object:play("offset", ENGINE_PLAY_SPEED * l_2_0._start_pos)
			l_2_0._state = l_0_5
		else
			l_2_0._fade_complete_time = l_2_0._start_time + l_2_0._fade
			l_2_0._sound_object:set_control_ramp("gain_abs", 0, l_2_0._master_volume, l_2_0._fade)
			l_2_0._sound_object:play("offset", ENGINE_PLAY_SPEED * l_2_0._start_pos)
			l_2_0._state = l_0_4
		end
	else
		if l_2_0._state == l_0_2 then
			local l_2_4 = l_2_0._time_ctrl:time() - l_2_0._start_time
			l_2_0._sound_object:play("running_offset", ENGINE_PLAY_SPEED * (l_2_0._start_pos + l_2_4))
			l_2_0._sound_object:set_control("gain_abs", 0)
			l_2_0._start_fade_time = l_2_0._start_time + l_2_0._wait
			l_2_0._state = l_0_3
		end
	else
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_2_0._state == l_0_3 and l_2_0._start_fade_time < l_2_3 then
			l_2_0._fade_complete_time = l_2_3 + l_2_0._fade
			l_2_0._sound_object:set_control_ramp("gain_abs", 0, l_2_0._master_volume, l_2_0._fade)
			l_2_0._master_changed = false
			l_2_0._state = l_0_4
		end
	end
	do return end
	if l_2_0._state == l_0_4 then
		local l_2_5 = l_2_0._fade_complete_time - l_2_3
		if l_2_5 <= 0 then
			l_2_0._state = l_0_5
		elseif l_2_0._master_changed then
			local l_2_6 = l_2_0._sound_object:get_control("gain_abs")
			l_2_0._sound_object:set_control_ramp("gain_abs", l_2_6, l_2_0._master_volume, math.max(l_2_5, l_2_2))
			l_2_0._master_changed = false
		end
	else
		if l_2_0._state == l_0_5 and l_2_0._master_changed then
			local l_2_7 = l_2_0._sound_object:get_control("gain_abs")
			l_2_0._sound_object:set_control_ramp("gain_abs", l_2_7, l_2_0._master_volume, l_2_2)
			l_2_0._master_changed = false
		end
	end
	do return end
	if l_2_0._state == l_0_6 then
		if l_2_0._start_fade_time < l_2_3 then
			l_2_0._fade_complete_time = l_2_3 + l_2_0._fade
			local l_2_8 = l_2_0._sound_object:get_control("gain_abs")
			l_2_0._sound_object:set_control_ramp("gain_abs", l_2_8, 0, l_2_0._fade)
			l_2_0._state = l_0_7
		elseif l_2_0._master_changed then
			local l_2_9 = l_2_0._sound_object:get_control("gain_abs")
			l_2_0._sound_object:set_control_ramp("gain_abs", l_2_9, l_2_0._master_volume, l_2_2)
			l_2_0._master_changed = false
		end
	else
		if l_2_0._state == l_0_7 then
			local l_2_10 = l_2_0._fade_complete_time - l_2_3
		if l_2_10 <= -0.25 then
			end
			l_2_0._sound_object:stop()
			l_2_0._sound_object = nil
			l_2_0._state = l_0_8
		end
	else
		if l_2_0._state == l_0_8 then
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 214 214 
end

SoundPlayHead.play = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5)
	-- upvalues: l_0_0 , l_0_1
	if l_3_0._state == l_0_0 then
		l_3_0._start_pos = l_3_1
		l_3_0._stop_pos = l_3_2
		l_3_0._start_time = l_3_0._time_ctrl:time()
		l_3_0._wait = 0
		l_3_0._fade = l_3_3
		l_3_0._new_section = l_3_4
		l_3_0._section_change_pos = l_3_5
		l_3_0._state = l_0_1
	else
		error("Can only play a fresh SoundPlayHead")
	end
end

SoundPlayHead.play_synchronized = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	-- upvalues: l_0_0 , l_0_2
	if l_4_0._state == l_0_0 then
		l_4_0._start_pos = l_4_1
		l_4_0._stop_pos = l_4_2
		l_4_0._start_time = l_4_3
		l_4_0._wait = l_4_4
		l_4_0._fade = math.max(l_4_5, 0.01)
		l_4_0._new_section = l_4_6
		l_4_0._section_change_pos = l_4_7
		if l_4_0._time_ctrl:time() < l_4_0:get_stop_time() then
			l_4_0._state = l_0_2
		else
			l_4_0._state = l_0_0
		end
	else
		error("Can only play a fresh SoundPlayHead")
	end
end

SoundPlayHead.continue_playing = function(l_5_0, l_5_1, l_5_2, l_5_3)
	-- upvalues: l_0_0 , l_0_2 , l_0_1 , l_0_3 , l_0_4 , l_0_5 , l_0_6 , l_0_7 , l_0_8
	if l_5_0._state == l_0_0 then
		l_5_0._stop_pos = l_5_1
		l_5_0._new_section = l_5_2
		l_5_0._section_change_pos = l_5_3
		assert(l_5_0._start_pos)
		assert(l_5_0._start_time)
		assert(l_5_0._wait)
		assert(l_5_0._fade)
		if l_5_0._time_ctrl:time() < l_5_0:get_stop_time() then
			l_5_0._state = l_0_2
		else
			l_5_0._state = l_0_0
		end
	else
		if l_5_0._state == l_0_1 or l_5_0._state == l_0_2 or l_5_0._state == l_0_3 or l_5_0._state == l_0_4 or l_5_0._state == l_0_5 then
			l_5_0._stop_pos = l_5_1
			l_5_0._new_section = l_5_2
			l_5_0._section_change_pos = l_5_3
		end
	else
		if l_5_0._state == l_0_6 or l_5_0._state == l_0_7 or l_5_0._state == l_0_8 then
			error("'SoundPlayHead:set_new_stop_pos' in wrong state (" .. l_5_0._state .. "), contact core team.")
		end
	end
end

SoundPlayHead.set_fadeout = function(l_6_0, l_6_1, l_6_2)
	-- upvalues: l_0_0 , l_0_8 , l_0_1 , l_0_2 , l_0_3 , l_0_4 , l_0_6 , l_0_5 , l_0_7
	if l_6_0._state == l_0_0 then
		l_6_0._state = l_0_8
	else
		if l_6_0._state == l_0_1 then
			l_6_0._state = l_0_8
		end
	else
		if l_6_0._state == l_0_2 then
			l_6_0._state = l_0_8
		end
	else
		if l_6_0._state == l_0_3 then
			l_6_0._state = l_0_8
		end
	else
		if l_6_0._state == l_0_4 then
			l_6_0._start_fade_time = l_6_0:get_stop_time() + l_6_1
			l_6_0._fade = math.max(l_6_2, 0.01)
			l_6_0._state = l_0_6
		end
	else
		if l_6_0._state == l_0_5 then
			l_6_0._start_fade_time = l_6_0:get_stop_time() + l_6_1
			l_6_0._fade = math.max(l_6_2, 0.01)
			l_6_0._state = l_0_6
		end
	else
		if l_6_0._state == l_0_6 then
			l_6_0._start_fade_time = math.min(l_6_0._start_fade_time, l_6_0:get_stop_time() + l_6_1)
			l_6_0._fade = math.max(math.min(l_6_0._fade, l_6_2), 0.01)
		end
	else
		if l_6_0._state == l_0_7 then
			do return end
		end
	end
	if l_6_0._state == l_0_8 then
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 95 
end

SoundPlayHead.stop_now = function(l_7_0)
	-- upvalues: l_0_0 , l_0_8 , l_0_1 , l_0_2 , l_0_3 , l_0_4 , l_0_5 , l_0_6 , l_0_7
	if l_7_0._state == l_0_0 then
		l_7_0._state = l_0_8
	else
		if l_7_0._state == l_0_1 then
			l_7_0._state = l_0_8
		end
	else
		if l_7_0._state == l_0_2 then
			l_7_0._state = l_0_8
		end
	else
		if l_7_0._state == l_0_3 then
			l_7_0._state = l_0_8
		end
	else
		if l_7_0._state == l_0_4 then
			l_7_0:_stop_now()
		end
	else
		if l_7_0._state == l_0_5 then
			l_7_0:_stop_now()
		end
	else
		if l_7_0._state == l_0_6 then
			l_7_0:_stop_now()
		end
	else
		if l_7_0._state == l_0_7 then
			l_7_0:_stop_now()
		end
	else
		if l_7_0._state == l_0_8 then
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 61 61 
end

SoundPlayHead._stop_now = function(l_8_0)
	-- upvalues: l_0_7
	l_8_0._fade = 0.01
	l_8_0._fade_complete_time = l_8_0._time_ctrl:time() + l_8_0._fade
	local l_8_1 = l_8_0._sound_object:get_control("gain_abs")
	l_8_0._sound_object:set_control_ramp("gain_abs", l_8_1, 0, l_8_0._fade)
	l_8_0._state = l_0_7
end

SoundPlayHead.get_section_info = function(l_9_0)
	local l_9_1 = l_9_0._time_ctrl:time() - l_9_0._start_time - (l_9_0._section_change_pos - l_9_0._start_pos)
	return l_9_0._new_section, l_9_1
end

SoundPlayHead.get_timing_info = function(l_10_0)
	local l_10_1 = {}
	l_10_1.start_pos = l_10_0._start_pos
	l_10_1.start_time = l_10_0._start_time
	l_10_1.bar_offset = l_10_0._bar_offset
	return l_10_1
end

SoundPlayHead.get_stop_time = function(l_11_0)
	return l_11_0._start_time + (l_11_0._stop_pos - l_11_0._start_pos)
end

SoundPlayHead.is_stopped = function(l_12_0)
	-- upvalues: l_0_8
	return l_12_0._state == l_0_8
end

SoundPlayHead.set_master_volume = function(l_13_0, l_13_1)
	l_13_0._master_volume = l_13_1
	l_13_0._master_changed = true
end


