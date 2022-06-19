if not SoundHolder then
	SoundHolder = class()
end
SoundHolder.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._sound_bank = nil
	l_1_0._sound_instance = nil
	l_1_0._start_time = nil
	l_1_0._needs_to_sync = false
	l_1_0._next_sync_check = 0
	l_1_0._next_prime_time = 0
	l_1_0._cnt = 0
	l_1_0._platform = SystemInfo:platform()
end

SoundHolder.play_sound = function(l_2_0, l_2_1, l_2_2)
	l_2_0._sound_bank = l_2_1
	if not l_2_2 then
		l_2_2 = 0
	end
	l_2_0._sound_instance = l_2_0._sound_bank:play("offset", l_2_2)
	l_2_0._start_time = Application:time() - l_2_2
	l_2_0._next_sync_check = Application:time() + tweak_data.rail.SOUND_DELAY_BETWEEN_RESYNC
	if tweak_data.rail.SOUND_DEBUG_RESYNC then
		local l_2_3 = Draw:brush()
		l_2_3:set_screen(true)
		l_2_3:set_persistance(0.3)
		l_2_3:set_color(Color(0.5, 0.6, 0, 0.6))
		l_2_3:sphere(Vector3(0.3, 0.3, 0), 0.3)
	end
end

SoundHolder.set_prime_sound = function(l_3_0, l_3_1)
	l_3_0._next_sound_object = l_3_1
end

SoundHolder.debug_syncing = function(l_4_0, l_4_1)
	local l_4_2 = Draw:brush()
	l_4_2:set_screen(true)
	if tweak_data.rail.SOUND_DESYNC_THRESHOLD < l_4_1 then
		l_4_2:set_color(Color(0.4, 0, 0, 1))
	else
		l_4_2:set_color(Color(0.4, 0, 1, 0))
	end
	l_4_2:sphere(Vector3(0, 0, 0), 0.5 * l_4_1)
end

SoundHolder.test_in_sync = function(l_5_0, l_5_1, l_5_2)
	if managers.synced_sound:time_scaled() then
		l_5_0._cnt = 0
		return 
	end
	if l_5_0._sound_instance:is_playing() then
		local l_5_3, l_5_4 = l_5_0._sound_instance:offset()
		local l_5_5 = l_5_1 - l_5_0._start_time
		local l_5_6 = l_5_4 - l_5_5
		if tweak_data.rail.SOUND_DESYNC_THRESHOLD < math.abs(l_5_6) then
			l_5_0._cnt = l_5_0._cnt + 1
			if tweak_data.rail.SOUND_DESYNC_FRAMES <= l_5_0._cnt and l_5_0._next_sync_check <= l_5_1 then
				l_5_0._sound_instance = l_5_0._sound_bank:play("crossfade_with", l_5_0._sound_instance, "crossfade_time", 0.5, "offset", l_5_4 - l_5_6)
				l_5_0._next_sync_check = l_5_1 + tweak_data.rail.SOUND_DELAY_BETWEEN_RESYNC
				l_5_0._cnt = 0
			if tweak_data.rail.SOUND_DEBUG_RESYNC then
				end
				local l_5_7 = Draw:brush()
				l_5_7:set_screen(true)
				l_5_7:set_persistance(0.3)
				l_5_7:set_color(Color(0.2, 1, 0, 0))
				l_5_7:triangle(Vector3(0, 0.8, 0), Vector3(0.7, -0.8, 0), Vector3(-0.7, -0.8, 0), 0.5 * l_5_6)
			end
		else
			l_5_0._cnt = 0
		end
	if tweak_data.rail.SOUND_DEBUG_RESYNC then
		end
		l_5_0:debug_syncing(math.abs(l_5_6))
	end
end

SoundHolder.update = function(l_6_0, l_6_1, l_6_2, l_6_3)
	if l_6_0._platform == "WIN32" then
		l_6_0:test_in_sync(l_6_2, l_6_3)
	end
	if l_6_0._next_prime_time < l_6_2 and l_6_0._next_sound_object then
		l_6_0._next_sound_object:prime()
		l_6_0._next_prime_time = l_6_2 + 2
	end
	if Application:paused() then
		if not l_6_0._needs_to_sync and alive(l_6_0._sound_instance) then
			l_6_0._sound_instance:stop()
			l_6_0._needs_to_sync = true
			l_6_0._game_time = l_6_2
		end
		if l_6_0._kill_time then
			Application:debug("Kill Time: (paused)", l_6_0._sound_instance)
			l_6_0:stop_sound()
			l_6_0._unit:set_slot(0)
		end
	elseif l_6_0._needs_to_sync then
		l_6_0._sound_instance = l_6_0._sound_bank:play("running_offset", l_6_0._game_time - l_6_0._start_time)
		l_6_0._needs_to_sync = false
	else
		if not alive(l_6_0._sound_instance) then
			l_6_0:stop_sound()
			l_6_0._unit:set_slot(0)
		end
	end
	if l_6_0._kill_time and l_6_0._kill_time + 0.1 <= l_6_2 then
		l_6_0:stop_sound()
		l_6_0._kill_time = nil
	end
end

SoundHolder.stop_sound = function(l_7_0)
	if alive(l_7_0._sound_instance) then
		l_7_0._sound_instance:set_control("gain_abs", 0)
		l_7_0._sound_instance:stop()
	end
	if l_7_0.volume_set then
		managers.volume:deactivate_set(l_7_0.volume_set)
		Application:debug("Dectivating volumeset:", l_7_0.volume_set)
	end
	l_7_0._sound_instance = nil
end

SoundHolder.destroy = function(l_8_0)
	l_8_0:stop_sound()
	l_8_0._sound_bank = nil
end

SoundHolder.cross_fade = function(l_9_0, l_9_1, l_9_2, l_9_3)
	if alive(l_9_0._sound_instance) then
		l_9_0._sound_instance:set_control_ramp("gain_abs", l_9_2, l_9_3, l_9_1)
	end
end

SoundHolder.kill_later = function(l_10_0, l_10_1)
	l_10_0._kill_time = Application:time() + l_10_1
end

SoundHolder.get_sound = function(l_11_0)
	return l_11_0._sound_instance
end

SoundHolder.activate_volume_set = function(l_12_0, l_12_1)
	l_12_0.volume_set = managers.volume:activate_set(l_12_1)
	Application:debug("Activating volumeset:", l_12_1, "id=", l_12_0.volume_set)
end


