if not BikerAiMove then
	BikerAiMove = class()
end
BikerAiMove.init_data = function(l_1_0, l_1_1)
	l_1_1._move = {}
	l_1_1._move.allowed_to_fire = false
	l_1_1._move.target_from_behind = true
	l_1_1._move.range_offset = 300
end

BikerAiMove.logic_biker_move_init = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	return 0
end

BikerAiMove.logic_biker_move_passive = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	local l_3_8 = l_3_2:ai_data()
	if l_3_8.input.target_range and l_3_8.input.forced_target_units then
		return 0
	end
	return nil
end

BikerAiMove.logic_biker_move_to_target_range = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	local l_4_9 = (l_4_0:_closest_target(l_4_2, l_4_8.input.forced_target_units))
	local l_4_10 = nil
	if l_4_9 then
		l_4_10 = l_4_0:_get_pursuit_speed(l_4_2, l_4_9, l_4_8)
	end
	l_4_8.output.closest_target = l_4_9
	l_4_8.output.speed = l_4_10
	return nil
end

BikerAiMove._closest_target = function(l_5_0, l_5_1, l_5_2)
	local l_5_8, l_5_9, l_5_10, l_5_11, l_5_12, l_5_13, l_5_14, l_5_15 = nil
	local l_5_3 = (l_5_1:ai_data())
	local l_5_4 = nil
	for i_0,i_1 in pairs(l_5_2) do
		if alive(i_1) then
			if not l_5_4 then
				l_5_4 = i_1
			end
		else
			if i_1:position() - l_5_1:position():length() < l_5_4:position() - l_5_1:position():length() then
				l_5_4 = i_1
			end
		end
	end
	return l_5_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

BikerAiMove._get_pursuit_speed = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4, l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
	l_6_4 = l_6_1:position():with_z(0)
	l_6_5 = l_6_2:position():with_z(0)
	l_6_6 = l_6_5 - l_6_4
	l_6_7 = l_6_6:length()
	l_6_8 = l_6_2:rotation():y():normalized()
	l_6_9 = l_6_2:base():get_speed_vector()
	l_6_10 = l_6_8:dot(l_6_9) * l_6_8:length()
	if l_6_3._combat.current_attack_type == 1 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_3._combat.current_attack_type == 2 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_3._combat.current_attack_type == 3 or l_6_3._combat.current_attack_type == 4 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_6_3._combat.current_attack_type ~= 5 or l_6_3._move.target_from_behind then
		if l_6_3.input.target_range - l_6_3._move.range_offset < l_6_7 then
			do return end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Overwrote pending register.

	elseif not l_6_0:_is_behind_target_vehicle(l_6_1, l_6_2) then
		if l_6_3.input.target_range - l_6_3._move.range_offset < l_6_7 then
			do return end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		return l_6_14
		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 160 
end

BikerAiMove._is_behind_target_vehicle = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_2:rotation():y()
	local l_7_4 = l_7_2:position() - l_7_1:position()
	local l_7_5 = l_7_3:dot(l_7_4)
	return l_7_5 >= 0
end


