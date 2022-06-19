if not UnitRumble then
	UnitRumble = class()
end
UnitRumble.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._state = nil
	l_1_0._loop_cnt = 0
	l_1_0._rumble_time = nil
	l_1_0._exit_state_time = nil
	l_1_0._playing = false
end

UnitRumble.play = function(l_2_0)
	l_2_0._playing = true
	l_2_0:_enter_state(l_2_0._rumble_start_state)
end

UnitRumble.stop = function(l_3_0)
	l_3_0._playing = false
end

UnitRumble.is_playing = function(l_4_0)
	return l_4_0._playing
end

UnitRumble._enter_state = function(l_5_0, l_5_1)
	l_5_0._state = l_5_0._rumble_states[l_5_1]
	l_5_0._loop_cnt = 0
	l_5_0._rumble_time = Application:time()
end

UnitRumble.update = function(l_6_0, l_6_1, l_6_2, l_6_3)
	if not l_6_0._state.loop then
		local l_6_4, l_6_9, l_6_14, l_6_15, l_6_18, l_6_20, l_6_26, l_6_31, l_6_35, l_6_41, l_6_42 = not l_6_0._playing or 1
	end
	do
		local l_6_5, l_6_10, l_6_16, l_6_19, l_6_21, l_6_27, l_6_32, l_6_36, l_6_43 = , l_6_0._state.loop_delay_min or 0
	do
		end
		local l_6_6, l_6_11, l_6_17, l_6_22, l_6_28, l_6_33, l_6_37, l_6_44 = , l_6_0._state.loop_delay_max or 0
	do
		end
		local l_6_7, l_6_12, l_6_23, l_6_29, l_6_34, l_6_38, l_6_45 = , l_6_0._state.exit_delay_min or 0
	do
		end
		local l_6_8, l_6_13, l_6_24, l_6_30, l_6_39, l_6_46 = , l_6_0._state.exit_delay_max or 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_6_0._loop_cnt < l_6_8 and l_6_0._rumble_time <= Application:time() then
		managers.rumble:play_preset(l_6_0._state.effect, l_6_0._unit:get_object(l_6_0._rumble_object):position())
		l_6_0._loop_cnt = l_6_0._loop_cnt + 1
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		do
			if l_6_0._loop_cnt < l_6_8 then
				local l_6_25 = nil
				l_6_0._rumble_time = Application:time() + (l_6_13 + math.random() * (l_6_24 - l_6_13))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			local l_6_40 = nil
			l_6_0._exit_state_time = Application:time() + (l_6_30 + math.random() * (l_6_39 - l_6_30))
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_6_40 <= l_6_0._loop_cnt and l_6_0._exit_state_time <= Application:time() then
		l_6_0:_enter_state(l_6_0._state.exit_to)
	end
end


