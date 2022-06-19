UnitRumble = UnitRumble or class()
function UnitRumble.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._state = nil
	A0_0._loop_cnt = 0
	A0_0._rumble_time = nil
	A0_0._exit_state_time = nil
	A0_0._playing = false
end
function UnitRumble.play(A0_2)
	A0_2._playing = true
	A0_2:_enter_state(A0_2._rumble_start_state)
end
function UnitRumble.stop(A0_3)
	local L1_4
	A0_3._playing = false
end
function UnitRumble.is_playing(A0_5)
	local L1_6
	L1_6 = A0_5._playing
	return L1_6
end
function UnitRumble._enter_state(A0_7, A1_8)
	A0_7._state = A0_7._rumble_states[A1_8]
	A0_7._loop_cnt = 0
	A0_7._rumble_time = Application:time()
end
function UnitRumble.update(A0_9, A1_10, A2_11, A3_12)
	local L4_13, L5_14, L6_15, L7_16, L8_17
	L4_13 = A0_9._playing
	if L4_13 then
		L4_13 = A0_9._state
		L4_13 = L4_13.loop
		L4_13 = L4_13 or 1
		L5_14 = A0_9._state
		L5_14 = L5_14.loop_delay_min
		L5_14 = L5_14 or 0
		L6_15 = A0_9._state
		L6_15 = L6_15.loop_delay_max
		L6_15 = L6_15 or 0
		L7_16 = A0_9._state
		L7_16 = L7_16.exit_delay_min
		L7_16 = L7_16 or 0
		L8_17 = A0_9._state
		L8_17 = L8_17.exit_delay_max
		L8_17 = L8_17 or 0
		if L4_13 > A0_9._loop_cnt and Application:time() >= A0_9._rumble_time then
			managers.rumble:play_preset(A0_9._state.effect, A0_9._unit:get_object(A0_9._rumble_object):position())
			A0_9._loop_cnt = A0_9._loop_cnt + 1
			if L4_13 > A0_9._loop_cnt then
				A0_9._rumble_time = Application:time() + (L5_14 + math.random() * (L6_15 - L5_14))
			else
				A0_9._exit_state_time = Application:time() + (L7_16 + math.random() * (L8_17 - L7_16))
			end
		elseif L4_13 <= A0_9._loop_cnt and Application:time() >= A0_9._exit_state_time then
			A0_9:_enter_state(A0_9._state.exit_to)
		end
	end
end
