SoundHolder = SoundHolder or class()
function SoundHolder.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._sound_bank = nil
	A0_0._sound_instance = nil
	A0_0._start_time = nil
	A0_0._needs_to_sync = false
	A0_0._next_sync_check = 0
	A0_0._next_prime_time = 0
	A0_0._cnt = 0
	A0_0._platform = SystemInfo:platform()
end
function SoundHolder.play_sound(A0_2, A1_3, A2_4)
	A0_2._sound_bank = A1_3
	A2_4 = A2_4 or 0
	A0_2._sound_instance = A0_2._sound_bank:play("offset", A2_4)
	A0_2._start_time = Application:time() - A2_4
	A0_2._next_sync_check = Application:time() + tweak_data.rail.SOUND_DELAY_BETWEEN_RESYNC
	if tweak_data.rail.SOUND_DEBUG_RESYNC then
		Draw:brush():set_screen(true)
		Draw:brush():set_persistance(0.3)
		Draw:brush():set_color(Color(0.5, 0.6, 0, 0.6))
		Draw:brush():sphere(Vector3(0.3, 0.3, 0), 0.3)
	end
end
function SoundHolder.set_prime_sound(A0_5, A1_6)
	A0_5._next_sound_object = A1_6
end
function SoundHolder.debug_syncing(A0_7, A1_8)
	Draw:brush():set_screen(true)
	if A1_8 > tweak_data.rail.SOUND_DESYNC_THRESHOLD then
		Draw:brush():set_color(Color(0.4, 0, 0, 1))
	else
		Draw:brush():set_color(Color(0.4, 0, 1, 0))
	end
	Draw:brush():sphere(Vector3(0, 0, 0), 0.5 * A1_8)
end
function SoundHolder.test_in_sync(A0_9, A1_10, A2_11)
	local L3_12, L4_13, L5_14, L6_15
	L3_12 = managers
	L3_12 = L3_12.synced_sound
	L4_13 = L3_12
	L3_12 = L3_12.time_scaled
	L3_12 = L3_12(L4_13)
	if L3_12 then
		A0_9._cnt = 0
		return
	end
	L3_12 = A0_9._sound_instance
	L4_13 = L3_12
	L3_12 = L3_12.is_playing
	L3_12 = L3_12(L4_13)
	if L3_12 then
		L3_12 = A0_9._sound_instance
		L4_13 = L3_12
		L3_12 = L3_12.offset
		L4_13 = L3_12(L4_13)
		L5_14 = A0_9._start_time
		L5_14 = A1_10 - L5_14
		L6_15 = L4_13 - L5_14
		if math.abs(L6_15) > tweak_data.rail.SOUND_DESYNC_THRESHOLD then
			A0_9._cnt = A0_9._cnt + 1
			if A0_9._cnt >= tweak_data.rail.SOUND_DESYNC_FRAMES and A1_10 >= A0_9._next_sync_check then
				A0_9._sound_instance = A0_9._sound_bank:play("crossfade_with", A0_9._sound_instance, "crossfade_time", 0.5, "offset", L4_13 - L6_15)
				A0_9._next_sync_check = A1_10 + tweak_data.rail.SOUND_DELAY_BETWEEN_RESYNC
				A0_9._cnt = 0
				if tweak_data.rail.SOUND_DEBUG_RESYNC then
					Draw:brush():set_screen(true)
					Draw:brush():set_persistance(0.3)
					Draw:brush():set_color(Color(0.2, 1, 0, 0))
					Draw:brush():triangle(Vector3(0, 0.8, 0), Vector3(0.7, -0.8, 0), Vector3(-0.7, -0.8, 0), 0.5 * L6_15)
				end
			end
		else
			A0_9._cnt = 0
		end
		if tweak_data.rail.SOUND_DEBUG_RESYNC then
			A0_9:debug_syncing(math.abs(L6_15))
		end
	end
end
function SoundHolder.update(A0_16, A1_17, A2_18, A3_19)
	if A0_16._platform == "WIN32" then
		A0_16:test_in_sync(A2_18, A3_19)
	end
	if A2_18 > A0_16._next_prime_time and A0_16._next_sound_object then
		A0_16._next_sound_object:prime()
		A0_16._next_prime_time = A2_18 + 2
	end
	if Application:paused() then
		if not A0_16._needs_to_sync and alive(A0_16._sound_instance) then
			A0_16._sound_instance:stop()
			A0_16._needs_to_sync = true
			A0_16._game_time = A2_18
		end
		if A0_16._kill_time then
			Application:debug("Kill Time: (paused)", A0_16._sound_instance)
			A0_16:stop_sound()
			A0_16._unit:set_slot(0)
		end
	elseif A0_16._needs_to_sync then
		A0_16._sound_instance = A0_16._sound_bank:play("running_offset", A0_16._game_time - A0_16._start_time)
		A0_16._needs_to_sync = false
	elseif not alive(A0_16._sound_instance) then
		A0_16:stop_sound()
		A0_16._unit:set_slot(0)
	end
	if A0_16._kill_time and A2_18 >= A0_16._kill_time + 0.1 then
		A0_16:stop_sound()
		A0_16._kill_time = nil
	end
end
function SoundHolder.stop_sound(A0_20)
	if alive(A0_20._sound_instance) then
		A0_20._sound_instance:set_control("gain_abs", 0)
		A0_20._sound_instance:stop()
	end
	if A0_20.volume_set then
		managers.volume:deactivate_set(A0_20.volume_set)
		Application:debug("Dectivating volumeset:", A0_20.volume_set)
	end
	A0_20._sound_instance = nil
end
function SoundHolder.destroy(A0_21)
	A0_21:stop_sound()
	A0_21._sound_bank = nil
end
function SoundHolder.cross_fade(A0_22, A1_23, A2_24, A3_25)
	if alive(A0_22._sound_instance) then
		A0_22._sound_instance:set_control_ramp("gain_abs", A2_24, A3_25, A1_23)
	end
end
function SoundHolder.kill_later(A0_26, A1_27)
	A0_26._kill_time = Application:time() + A1_27
end
function SoundHolder.get_sound(A0_28)
	local L1_29
	L1_29 = A0_28._sound_instance
	return L1_29
end
function SoundHolder.activate_volume_set(A0_30, A1_31)
	A0_30.volume_set = managers.volume:activate_set(A1_31)
	Application:debug("Activating volumeset:", A1_31, "id=", A0_30.volume_set)
end
