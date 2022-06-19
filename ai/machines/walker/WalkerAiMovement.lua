if not WalkerAiMovement then
	WalkerAiMovement = class(CommonAiMovement)
end
WalkerAiMovement.init_data = function(l_1_0, l_1_1)
	CommonAiMovement.init_data(l_1_0, l_1_1)
	l_1_1.output.moving_to_execute_target = nil
end

WalkerAiMovement.logic_walker_movement_idle_enter = function(l_2_0, ...)
	if CommonAiMovement.logic_common_movement_idle_enter then
		local l_2_2 = CommonAiMovement:logic_common_movement_idle_enter
		local l_2_3 = CommonAiMovement
		return l_2_2(l_2_3, ...)
	end
end

WalkerAiMovement.logic_walker_movement_idle_exit = function(l_3_0, ...)
	if CommonAiMovement.logic_common_movement_idle_enter then
		local l_3_2 = CommonAiMovement:logic_common_movement_idle_exit
		local l_3_3 = CommonAiMovement
		return l_3_2(l_3_3, ...)
	end
end

WalkerAiMovement.logic_walker_movement_idle = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	if l_4_0:_can_execute(l_4_2, l_4_8, l_4_1) then
		return 5, true
	end
	local l_4_9 = CommonAiMovement.logic_common_movement_idle
	local l_4_10 = l_4_0
	local l_4_11 = l_4_1
	local l_4_12 = l_4_2
	local l_4_13 = l_4_3
	local l_4_14 = l_4_4
	local l_4_15 = l_4_5
	local l_4_16 = l_4_6
	local l_4_17 = l_4_7
	return l_4_9(l_4_10, l_4_11, l_4_12, l_4_13, l_4_14, l_4_15, l_4_16, l_4_17)
end

WalkerAiMovement.logic_walker_movement_in_cluster_enter = function(l_5_0, ...)
	if CommonAiMovement.logic_common_movement_in_cluster_enter then
		local l_5_2 = CommonAiMovement:logic_common_movement_in_cluster_enter
		local l_5_3 = CommonAiMovement
		return l_5_2(l_5_3, ...)
	end
end

WalkerAiMovement.logic_walker_movement_in_cluster_exit = function(l_6_0, ...)
	if CommonAiMovement.logic_common_movement_in_cluster_enter then
		local l_6_2 = CommonAiMovement:logic_common_movement_in_cluster_exit
		local l_6_3 = CommonAiMovement
		return l_6_2(l_6_3, ...)
	end
end

WalkerAiMovement.logic_walker_movement_in_cluster = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5, l_7_6, l_7_7)
	local l_7_8 = l_7_2:ai_data()
	if l_7_0:_can_execute(l_7_2, l_7_8, l_7_1) then
		return 5, true
	end
	local l_7_9 = CommonAiMovement.logic_common_movement_in_cluster
	local l_7_10 = l_7_0
	local l_7_11 = l_7_1
	local l_7_12 = l_7_2
	local l_7_13 = l_7_3
	local l_7_14 = l_7_4
	local l_7_15 = l_7_5
	local l_7_16 = l_7_6
	local l_7_17 = l_7_7
	return l_7_9(l_7_10, l_7_11, l_7_12, l_7_13, l_7_14, l_7_15, l_7_16, l_7_17)
end

WalkerAiMovement.logic_walker_movement_go_to_enter = function(l_8_0, ...)
	if CommonAiMovement.logic_common_movement_go_to_enter then
		local l_8_2 = CommonAiMovement:logic_common_movement_go_to_enter
		local l_8_3 = CommonAiMovement
		return l_8_2(l_8_3, ...)
	end
end

WalkerAiMovement.logic_walker_movement_go_to_exit = function(l_9_0, ...)
	if CommonAiMovement.logic_common_movement_go_to_enter then
		local l_9_2 = CommonAiMovement:logic_common_movement_go_to_exit
		local l_9_3 = CommonAiMovement
		return l_9_2(l_9_3, ...)
	end
end

WalkerAiMovement.logic_walker_movement_go_to = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5, l_10_6, l_10_7)
	local l_10_8 = l_10_2:ai_data()
	if l_10_0:_can_execute(l_10_2, l_10_8, l_10_1) then
		return 5, true
	end
	local l_10_9 = CommonAiMovement.logic_common_movement_go_to
	local l_10_10 = l_10_0
	local l_10_11 = l_10_1
	local l_10_12 = l_10_2
	local l_10_13 = l_10_3
	local l_10_14 = l_10_4
	local l_10_15 = l_10_5
	local l_10_16 = l_10_6
	local l_10_17 = l_10_7
	return l_10_9(l_10_10, l_10_11, l_10_12, l_10_13, l_10_14, l_10_15, l_10_16, l_10_17)
end

WalkerAiMovement._can_execute = function(l_11_0, l_11_1, l_11_2, l_11_3)
	if l_11_2._behavior.allowed_to_execute then
		local l_11_4 = l_11_0:_execution_status(l_11_1, l_11_2, nil)
		if l_11_4.possible then
			if not l_11_2._behavior._execution_possible_start_time then
				l_11_2._behavior._execution_possible_start_time = l_11_3
			end
		if WalkerTweakData.EXECUTION_MIN_TIME < l_11_3 - l_11_2._behavior._execution_possible_start_time then
			end
			l_11_2._behavior._execution_possible_start_time = nil
			l_11_4.path = NavigationGraphUtilities.ai_shortest_path(l_11_1, l_11_4.go_to_position)
			if l_11_4.path then
				l_11_0:_set_execution_info(l_11_2, l_11_4)
				return true
			end
			l_11_4.possible = false
		end
	else
		l_11_2._behavior._execution_possible_start_time = nil
	end
	return false
end

WalkerAiMovement._execution_status = function(l_12_0, l_12_1, l_12_2, l_12_3)
	local l_12_4 = {}
	l_12_4.possible = false
	l_12_4.update = false
	l_12_0:_calculate_execution_status(l_12_1, l_12_2, l_12_4)
	if not l_12_4.possible then
		return l_12_4
	end
	if not l_12_3 then
		l_12_4.update = true
	else
		if l_12_2:new_path_requested() and not l_12_2:current_path_completed() then
			l_12_4.update = true
		end
	else
		if l_12_3.threat:unit() ~= l_12_4.threat:unit() then
			l_12_4.update = true
		end
	else
		local l_12_8 = nil
	if WalkerTweakData.EXECUTION_UPDATE_PATH_DISTANCE < mvector3.distance(l_12_4.go_to_position, l_12_3.go_to_position) then
		end
	if not l_12_2.input.is_executing then
		end
		l_12_4.update = true
	end
	if l_12_4.update and l_12_4.possible then
		l_12_0:_calculate_execution_path(l_12_1, l_12_4)
	end
	return l_12_4
end

WalkerAiMovement._calculate_execution_status = function(l_13_0, l_13_1, l_13_2, l_13_3, l_13_4)
	local l_13_5 = l_13_2.output.currently_targeted_threat
	if not l_13_5 then
		return l_13_3
	end
	if not l_13_0:_is_executable_threat(l_13_5) then
		l_13_3.possible = false
		return l_13_3
	end
	l_13_3.threat = l_13_5
	local l_13_6 = l_13_1:position()
	local l_13_7 = l_13_5:unit():position()
	local l_13_8 = mvector3.distance(l_13_7, l_13_6)
	if WalkerTweakData.EXECUTION_ATTACKER_TO_TARGET_DISTANCE < l_13_8 then
		l_13_3.possible = false
		return l_13_3
	end
	if not TableAlgorithms.is_empty(l_13_2._behavior.area_cluster) then
		local l_13_9 = l_13_0:_closest_cluster_position(l_13_6, l_13_2._behavior.area_cluster)
	if WalkerTweakData.EXECUTION_MAX_CLUSTER_DISTANCE < mvector3.distance(l_13_9, l_13_7) then
		end
		l_13_3.possible = false
		return l_13_3
	end
	if l_13_0:_targeted_threat_has_close_friends(l_13_5, l_13_2._threat_tracking._threats) then
		l_13_3.possible = false
		return l_13_3
	end
	local l_13_10 = l_13_0:_grab_over_cover_position_and_rotation(l_13_5)
	l_13_3.grab_over_cover_rotation = l_13_0
	l_13_3.grab_over_cover_position = l_13_10
	l_13_10 = l_13_3.grab_over_cover_position
	if l_13_10 then
		l_13_10 = l_13_3.grab_over_cover_position
		l_13_3.go_to_position = l_13_10
		l_13_10 = l_13_3.grab_over_cover_rotation
		l_13_3.go_to_rotation = l_13_10
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_13_3.go_to_position = l_13_10
	end
	l_13_3.possible = true
	return l_13_3
end

WalkerAiMovement._calculate_execution_path = function(l_14_0, l_14_1, l_14_2)
	local l_14_3 = NavigationGraphUtilities.ai_shortest_path(l_14_1, l_14_2.go_to_position, true)
	if not l_14_3 then
		l_14_2.possible = false
		return l_14_2
	end
	local l_14_4 = l_14_3[#l_14_3]
	if WalkerTweakData.EXECUTION_MAX_DESTINATION_OFFSET < mvector3.distance(l_14_4, l_14_2.go_to_position) then
		return false
	end
	local l_14_5 = l_14_1:position()
	if WalkerTweakData.EXECUTION_MAX_TRAVEL_LENGTH < MovementPathUtilities.path_length(l_14_5, l_14_3) then
		l_14_2.possible = false
	end
	return l_14_2
end

WalkerAiMovement._closest_cluster_position = function(l_15_0, l_15_1, l_15_2)
	local l_15_3, l_15_4, l_15_6, l_15_7, l_15_8, l_15_9, l_15_10, l_15_11 = nil, nil
	for i_0,i_1 in pairs(l_15_2) do
		if not l_15_4 or mvector3.distance(l_15_1, i_1.position) < l_15_3 then
			l_15_4 = i_1.position
			l_15_3 = mvector3.distance(l_15_1, i_1.position)
		end
	end
	return l_15_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WalkerAiMovement._targeted_threat_has_close_friends = function(l_16_0, l_16_1, l_16_2)
	local l_16_9, l_16_10, l_16_11, l_16_12, l_16_13, l_16_14 = nil
	local l_16_3 = l_16_1:unit()
	local l_16_4 = l_16_3:position()
	local l_16_5 = 0
	for i_0,i_1 in pairs(l_16_2) do
		if alive(i_1:unit()) and not i_1:unit() == l_16_3 and mvector3.distance(i_1:last_known_position(), l_16_4) < WalkerTweakData.EXECUTION_TARGET_TO_FRIENDS_DISTANCE then
			l_16_5 = l_16_5 + 1
		if l_16_5 == WalkerTweakData.EXECUTION_TARGET_TO_FRIENDS_NUMBER_OF_FRIENDS then
			end
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WalkerAiMovement._is_executable_threat = function(l_17_0, l_17_1)
	local l_17_2 = l_17_1:unit()
	if not alive(l_17_2) then
		return false
	end
	local l_17_3 = l_17_2:player_data()
	if not l_17_3 or not l_17_3.in_cover or l_17_3.cover_outer_position or l_17_3.revive_when_fully_damaged then
		return false
	end
	local l_17_4 = l_17_2:damage()
	if l_17_4 and not l_17_4:can_die() then
		return false
	end
	local l_17_5 = l_17_2:damage()
	if not l_17_5 or not l_17_5:can_die() then
		return false
	end
	return true
end

WalkerAiMovement._grab_over_cover_position_and_rotation = function(l_18_0, l_18_1)
	local l_18_2 = l_18_1:unit()
	local l_18_3 = l_18_2:position()
	local l_18_4 = l_18_2:player_data()
	if not l_18_4.can_move_over_cover then
		return nil, nil
	end
	local l_18_5 = l_18_4.cover_normal
	local l_18_6 = managers.slot:get_mask("statics")
	local l_18_7 = l_18_3 - l_18_5 * WalkerTweakData.EXECUTION_MAX_DEPTH
	local l_18_8 = l_18_7 + math.UP * WalkerTweakData.EXECUTION_MAX_HEIGHT_DIFFERENCE
	local l_18_9 = l_18_7 - math.UP * WalkerTweakData.EXECUTION_MAX_HEIGHT_DIFFERENCE
	local l_18_10 = World:raycast("ray", l_18_7, l_18_9, "slot_mask", l_18_6)
	if not l_18_10 then
		return nil, nil
	end
	if WalkerTweakData.EXECUTION_MAX_HEIGHT_DIFFERENCE < math.abs(l_18_3.z - l_18_10.position.z) then
		return nil, nil
	end
	return l_18_10.position, Rotation(l_18_5, math.UP)
end

WalkerAiMovement._grab_behind_cover_position = function(l_19_0, l_19_1)
	local l_19_2 = l_19_1:unit()
	return l_19_2:position() + l_19_2:player_data().cover_normal * WalkerTweakData.EXECUTION_BEHIND_COVER_DISTANCE
end

WalkerAiMovement.logic_walker_movement_execution_enter = function(l_20_0, l_20_1, l_20_2, l_20_3)
	local l_20_4 = l_20_2:ai_data()
	l_20_4._behavior._execution_start_time = l_20_1
end

WalkerAiMovement.logic_walker_movement_execution = function(l_21_0, l_21_1, l_21_2, l_21_3, l_21_4, l_21_5, l_21_6, l_21_7)
	local l_21_8 = l_21_2:ai_data()
	if not l_21_8.input.is_executing then
		if not l_21_8._behavior.allowed_to_execute or l_21_8.input.abort_execution then
			return 0, true
		end
		local l_21_9 = l_21_0:_execution_status(l_21_2, l_21_8, l_21_8._behavior._last_execution_status)
		if not l_21_9.possible then
			return 0, true
		end
		if l_21_9.update then
			l_21_0:_set_execution_info(l_21_8, l_21_9)
		end
	if WalkerTweakData.EXECUTION_TIMEOUT < l_21_1 - l_21_8._behavior._execution_start_time then
		end
		return 0, true
	end
	l_21_8._behavior.move_in_cluster = nil
	l_21_8._behavior.hide_from = nil
	l_21_8._behavior.search_for = nil
	return nil
end

WalkerAiMovement.logic_walker_movement_execution_exit = function(l_22_0, l_22_1, l_22_2, l_22_3)
	ai_data._behavior._execution_start_time = nil
end

WalkerAiMovement._set_execution_info = function(l_23_0, l_23_1, l_23_2)
	local l_23_3 = l_23_2.threat:unit()
	l_23_1.output.moving_to_execute_target = l_23_3
	l_23_1.output.moving_to_execute_position = l_23_2.go_to_position
	l_23_1.output.moving_to_execute_rotation = l_23_2.go_to_rotation
	l_23_1._behavior._last_execution_status = l_23_2
	l_23_1:set_new_path(l_23_2.path)
	local l_23_4 = {}
	l_23_4.position = l_23_2.go_to_position
	l_23_4.rotation = l_23_2.go_to_rotation
	l_23_4.id = 1
	local l_23_5, l_23_6 = l_23_1:set_waypoints, l_23_1
	do
		local l_23_7 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_23_5(l_23_6, l_23_7)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

WalkerAiMovement.logic_walker_movement_execution_exit = function(l_24_0, l_24_1, l_24_2, l_24_3)
	local l_24_4 = l_24_2:ai_data()
	l_24_4.output.moving_to_execute_target = nil
end


