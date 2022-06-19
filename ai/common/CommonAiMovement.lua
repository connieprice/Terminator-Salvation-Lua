require("ai/common/CommonAiLogicSwitch")
require("ai/common/MovementPathUtilities")
require("shared/RandomTraversal")
if not CommonAiMovement then
	CommonAiMovement = class()
end
CommonAiMovement.init_data = function(l_1_0, l_1_1)
	l_1_1._movement = {}
	l_1_1._movement._move_in_cluster = nil
	l_1_1._movement._last_move_time = 0
	l_1_1._movement._next_move_time = 0
	l_1_1._movement._current_go_to = nil
	l_1_1._movement._order_go_to = nil
	l_1_1._movement._cluster_points_visited = {}
	l_1_1._movement._retry_path = false
	l_1_1._movement._ai_waypoint_path = nil
end

CommonAiMovement.logic_common_movement_idle = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = l_2_2:ai_data()
	if l_2_0:_evaluate_go_to(l_2_8) then
		return 0, true
	end
	if l_2_8._behavior.use_covers and l_2_8._cover.cover_info and l_2_8._cover.go_to and l_2_8:new_path_requested() and not l_2_8.input.in_target_cover and not l_2_8.input.entering_target_cover then
		l_2_8._movement._order_go_to = l_2_8._cover.go_to
		return 0, true
	end
	if l_2_8._behavior.move_in_cluster then
		return 1, true
	end
	l_2_8:set_new_path(nil)
	l_2_8.output.move_speed = 1
	l_2_8.output.allowed_to_strafe = false
	if l_2_8._behavior.use_covers then
		l_2_8.output.target_cover_info = l_2_8._cover.cover_info
	else
		l_2_8.output.target_cover_info = nil
	end
	return nil
end

CommonAiMovement.logic_common_movement_go_to_enter = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_2:ai_data()
	if not l_3_4._behavior.go_to then
		l_3_4._movement._current_go_to = l_3_4._movement._order_go_to
	end
	l_3_0:_update_path(l_3_2, l_3_4)
end

CommonAiMovement.logic_common_movement_go_to = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	if l_4_0:_evaluate_go_to(l_4_8) then
		l_4_8._movement._current_go_to = l_4_8._behavior.go_to
		l_4_0:_update_path(l_4_2, l_4_8)
	end
	if l_4_0:_movement_ordered_go_to(l_4_8) and l_4_8._behavior.move_in_cluster == "hunt" and l_4_0:_has_fire_target(l_4_8) and not l_4_0:_can_fight_from_position(l_4_2, l_4_0:_current_go_to_position(l_4_8)) then
		l_4_8:set_new_path(nil)
		return 0
	end
	if not l_4_0:_behavior_ordered_go_to(l_4_8) and not l_4_0:_movement_ordered_go_to(l_4_8) then
		return 0
	end
	local l_4_9 = l_4_8._movement._current_go_to
	if not l_4_9 then
		return 0
	end
	if l_4_8:current_path_completed() then
		l_4_0:_completed_go_to(l_4_8)
		return 0
	end
	if l_4_8:new_path_requested() then
		l_4_0:_update_path(l_4_2, l_4_8)
	end
	if not l_4_8._movement._retry_path and not l_4_8:path() then
		return 0
	end
	if l_4_8._behavior.use_covers then
		l_4_8.output.target_cover_info = l_4_8._cover.cover_info
	end
	l_4_8._movement._last_move_time = l_4_1
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_4_8._behavior.go_to_speed and l_4_8.SPEEDS then
		local l_4_10 = l_4_8.SPEEDS[l_4_8._behavior.go_to_speed]
		assert(l_4_10)
	end
	do return end
	do
		local l_4_11, l_4_12 = 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_4_8.output.move_speed = l_4_11
	local l_4_13 = nil
	l_4_8.output.allowed_to_strafe = l_4_8._behavior.move_in_cluster == "hunt" or l_4_8._behavior.move_in_cluster == "hide"
end

CommonAiMovement.logic_common_movement_go_to_exit = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_4 = l_5_2:ai_data()
	l_5_4._movement._current_go_to = nil
	l_5_4._movement._order_go_to = nil
	if l_5_4._movement._ai_waypoint_path then
		l_5_4._movement._ai_waypoint_path:remove()
		l_5_4._movement._ai_waypoint_path = nil
	end
	l_5_4:set_waypoints(nil)
end

CommonAiMovement._ordered_to_cover = function(l_6_0, l_6_1)
	return not l_6_1._cover.go_to or l_6_1._movement._current_go_to == l_6_1._cover.go_to
end

CommonAiMovement._behavior_ordered_go_to = function(l_7_0, l_7_1)
	return l_7_1._behavior.go_to
end

CommonAiMovement._movement_ordered_go_to = function(l_8_0, l_8_1)
	return l_8_1._movement._current_go_to == l_8_1._movement._order_go_to
end

CommonAiMovement.logic_common_movement_in_cluster_enter = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = l_9_2:ai_data()
	if l_9_4._behavior.move_in_cluster ~= l_9_4._movement._move_in_cluster then
		l_9_0:_clear_cluster(l_9_4)
		l_9_4._movement._next_move_time = l_9_1
		l_9_4._movement._move_in_cluster = l_9_4._behavior.move_in_cluster
	else
		l_9_4._movement._next_move_time = l_9_4._movement._last_move_time
		if l_9_4._behavior.move_in_cluster == "patrol" then
			local l_9_5 = math.random(l_9_4.PATROL_MOVE_TIMERS[1], l_9_4.PATROL_MOVE_TIMERS[2])
			l_9_4._movement._next_move_time = l_9_4._movement._next_move_time + l_9_5
		if not l_9_4.output.can_not_find_path then
			end
			l_9_4:request_scan()
		end
	else
		if l_9_4._behavior.move_in_cluster == "hunt" then
			local l_9_6 = math.random(l_9_4.AGGRESIVE_MOVE_TIMERS[1], l_9_4.AGGRESIVE_MOVE_TIMERS[2])
			l_9_4._movement._next_move_time = l_9_4._movement._next_move_time + l_9_6
		end
	end
end

CommonAiMovement.logic_common_movement_in_cluster = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5, l_10_6, l_10_7)
	local l_10_8 = l_10_2:ai_data()
	if l_10_0:_evaluate_go_to(l_10_8) then
		return 1, true
	end
	if not l_10_8._behavior.move_in_cluster or l_10_8._behavior.move_in_cluster ~= l_10_8._movement._move_in_cluster then
		return 0, true
	end
	if l_10_8._behavior.move_in_cluster == "hunt" and l_10_8._behavior.search_for and not l_10_0:_can_fight_from_position(l_10_2) and not l_10_8._behavior.use_covers then
		l_10_8._movement._next_move_time = l_10_1
	end
	local l_10_9 = nil
	if l_10_8._movement._next_move_time <= l_10_1 then
		if l_10_8._behavior.move_in_cluster == "patrol" then
			if l_10_8:is_scan_requested() then
				l_10_8:cancel_scan_request()
			end
		if not l_10_8:is_scanning() then
			end
			local l_10_10 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		if l_10_8._behavior.move_in_cluster == "hunt" then
			local l_10_11 = l_10_0:_good_hunt_cluster_point()
			 -- DECOMPILER ERROR: Overwrote pending register.

		if l_10_11 then
			end
		end
	else
		if l_10_8._behavior.move_in_cluster == "hide" then
			local l_10_12 = l_10_0:_good_hide_cluster_point(l_10_2)
			 -- DECOMPILER ERROR: Overwrote pending register.

		if l_10_12 then
			end
		end
	else
		assert(false, "Unknown move: '" .. l_10_8._behavior.move_in_cluster .. "'")
	end
	if l_10_9 then
		l_10_8._movement._order_go_to = l_10_9
		return 1, true
	end
	if l_10_8._behavior.use_covers and l_10_8._cover.cover_info and l_10_8._cover.go_to and l_10_8:new_path_requested() then
		l_10_8._movement._order_go_to = l_10_8._cover.go_to
		return 1, true
	end
	l_10_8:set_new_path(nil)
	l_10_8.output.move_speed = 1
	l_10_8.output.allowed_to_strafe = false
	if l_10_8._behavior.use_covers and l_10_8._cover then
		l_10_8.output.target_cover_info = l_10_8._cover.cover_info
	else
		l_10_8.output.target_cover_info = nil
	end
	return nil
end

CommonAiMovement.logic_common_movement_in_cluster_exit = function(l_11_0, l_11_1, l_11_2, l_11_3)
	local l_11_4 = l_11_2:ai_data()
	if l_11_4.is_scan_requested and l_11_4:is_scan_requested() then
		l_11_4:cancel_scan_request()
	end
end

CommonAiMovement._evaluate_go_to = function(l_12_0, l_12_1)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_12_1._behavior.go_to and l_12_1._behavior.go_to ~= l_12_1._movement.last_completed_position and l_12_1._behavior.go_to ~= l_12_1._movement._current_go_to then
		return true
	end
	return false
end

CommonAiMovement._completed_go_to = function(l_13_0, l_13_1)
	l_13_1._movement.last_completed_position = l_13_1._behavior.go_to
end

CommonAiMovement._clear_cluster = function(l_14_0, l_14_1)
	l_14_1._movement._cluster_points_visited = {}
end

CommonAiMovement._good_hunt_cluster_point = function(l_15_0, l_15_1)
	local l_15_2 = l_15_1:ai_data()
	if l_15_2.hunt_and_hide then
		local l_15_3, l_15_4 = l_15_0:_good_hunt_hide_cluster_point, l_15_0
		local l_15_5 = l_15_1
		return l_15_3(l_15_4, l_15_5)
	end
	local l_15_6, l_15_7 = l_15_0:_random_hunt_cluster_point, l_15_0
	local l_15_8 = l_15_1
	return l_15_6(l_15_7, l_15_8)
end

CommonAiMovement._good_hide_cluster_point = function(l_16_0, l_16_1)
	local l_16_2 = l_16_1:ai_data()
	if not l_16_2._behavior.hide_from then
		return nil
	end
	local l_16_3 = nil
	local l_16_4 = #l_16_2._behavior.area_cluster
	local l_16_5 = RandomTraversal:new(l_16_4)
	for l_16_9 = 1, l_16_4 do
		local l_16_10 = l_16_5:next_index()
		local l_16_11 = l_16_2._behavior.area_cluster[l_16_10]
		local l_16_12 = l_16_0:_hide_count(l_16_1, l_16_11.position)
		if not l_16_3 or l_16_3.blocks < l_16_12 then
			local l_16_13 = {}
			l_16_13.point_data = l_16_11
			l_16_13.blocks = l_16_12
			l_16_3 = l_16_13
		end
	end
	if l_16_3 then
		return l_16_3.point_data
	end
	return nil
end

CommonAiMovement._good_random_cluster_point = function(l_17_0, l_17_1)
	local l_17_2 = l_17_1:ai_data()
	local l_17_3 = l_17_1:position()
	local l_17_4 = #l_17_2._behavior.area_cluster
	local l_17_5 = (RandomTraversal:new(l_17_4))
	local l_17_6 = nil
	for l_17_10 = 1, l_17_4 do
		local l_17_11 = l_17_5:current_index()
		local l_17_12 = l_17_2._behavior.area_cluster[l_17_11]
		if mvector3.distance(l_17_12.position, l_17_3) > 100 and NavigationGraphUtilities.ai_check_can_move_there(l_17_1, l_17_12.position) then
			return l_17_12
		end
		l_17_5:next_index()
	end
	return l_17_2._behavior.area_cluster[l_17_5:current_index()]
end

CommonAiMovement._good_hunt_hide_cluster_point = function(l_18_0, l_18_1)
	local l_18_9, l_18_10, l_18_11, l_18_12, l_18_13, l_18_14 = nil
	local l_18_2 = l_18_1:ai_data()
	if not l_18_2._behavior.hide_from then
		return nil
	end
	local l_18_3, l_18_4 = nil, nil
	assert(l_18_1)
	local l_18_5 = l_18_1:position()
	for i_0,i_1 in pairs(l_18_2._behavior.area_cluster) do
		if l_18_0:_can_fight_from_position(l_18_1, i_1.position) and (not l_18_3 or l_18_3.blocks < l_18_0:_hide_count(l_18_1, i_1.position) or l_18_3.blocks ~= l_18_0:_hide_count(l_18_1, i_1.position) or mvector3.distance(i_1.position, l_18_5) < 100) then
			l_18_3 = {point_data = l_18_16, blocks = l_18_0:_hide_count(l_18_1, i_1.position)}
		end
	end
	if l_18_3 then
		return l_18_3.point_data
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiMovement._random_hunt_cluster_point = function(l_19_0, l_19_1)
	local l_19_2 = l_19_1:ai_data()
	assert(l_19_1)
	local l_19_3 = l_19_1:position()
	local l_19_4 = #l_19_2._behavior.area_cluster
	local l_19_5 = RandomTraversal:new(l_19_4)
	for l_19_9 = 1, l_19_4 do
		local l_19_10 = l_19_5:next_index()
		local l_19_11 = l_19_2._behavior.area_cluster[l_19_10]
		if mvector3.distance(l_19_11.position, l_19_3) > 100 and l_19_0:_can_fight_from_position(l_19_1, l_19_11.position) and NavigationGraphUtilities.ai_check_can_move_there(l_19_1, l_19_11.position) then
			return l_19_11
		end
	end
	return l_19_2._behavior.area_cluster[l_19_5:current_index()]
end

CommonAiMovement._hide_count = function(l_20_0, l_20_1, l_20_2)
	local l_20_10, l_20_11 = nil
	local l_20_3 = l_20_1:ai_data()
	local l_20_4 = Vector3(0, 0, 120)
	local l_20_5 = managers.slot:get_mask("visibility_blockers")
	local l_20_6 = 0
	for i_0,i_1 in pairs(l_20_3._behavior.hide_from) do
		if l_20_1:raycast("ray", l_20_2 + l_20_4, i_1 + l_20_4, "slot_mask", l_20_5) then
			l_20_6 = l_20_6 + 1
		end
	end
	return l_20_6
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiMovement._has_fire_target = function(l_21_0, l_21_1)
	if l_21_1._targeting.currently_targeted_threat and alive(l_21_1._targeting.currently_targeted_threat:unit()) then
		return l_21_1.output.allowed_to_fire
	end
end

CommonAiMovement._can_fight_from_position = function(l_22_0, l_22_1, l_22_2)
	local l_22_3 = l_22_1:ai_data()
	if not l_22_2 and l_22_3.output.allowed_to_fire then
		return true
	end
	if l_22_3._targeting.currently_targeted_threat and alive(l_22_3._targeting.currently_targeted_threat:unit()) and IntelUtilities.ai_is_target_visible(l_22_1, l_22_3._targeting.currently_targeted_threat:unit(), l_22_2) and IntelUtilities.ai_have_target_line_of_fire(l_22_1, l_22_3._targeting.currently_targeted_threat:unit(), l_22_2) then
		return true
	end
	if l_22_3._behavior.search_for and l_22_3._behavior.search_for:last_seen_position() then
		local l_22_4 = l_22_3._behavior.search_for:last_seen_position() + math.UP * 120
		local l_22_5 = IntelUtilities.ai_have_position_line_of_fire
		local l_22_6 = l_22_1
		local l_22_7 = l_22_4
		local l_22_8 = l_22_2
		local l_22_9 = 200
		return l_22_5(l_22_6, l_22_7, l_22_8, l_22_9)
	end
	return false
end

CommonAiMovement._update_path = function(l_23_0, l_23_1, l_23_2)
	assert(l_23_1)
	assert(l_23_2)
	local l_23_3 = nil
	if type(l_23_2._movement._current_go_to) == "table" then
		local l_23_4 = nil
		if not l_23_2._movement._ai_waypoint_path then
			l_23_2._movement._ai_waypoint_path = managers.update_scheduler:add_function(NavigationGraphUtilities.ai_waypoint_path, "nav_util_ai_waypoint_path")
		end
		l_23_3 = l_23_2._movement._ai_waypoint_path:update(l_23_1, l_23_2._movement._current_go_to, l_23_2.input.loop_waypoints)
		l_23_2:set_waypoints(l_23_2._movement._current_go_to)
		l_23_2:set_new_path(l_23_3, l_23_2.input.loop_waypoints)
		l_23_2._movement._retry_path = not l_23_4
		if l_23_4 then
			l_23_2._movement._ai_waypoint_path:remove()
			l_23_2._movement._ai_waypoint_path = nil
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_23_3 = l_23_4.ai_shortest_path(l_23_1, l_23_2._movement._current_go_to)
		l_23_2:set_new_path(l_23_3)
		l_23_2._movement._retry_path = false
	end
	local l_23_5 = l_23_2.output
	l_23_5.can_not_find_path = l_23_3 == nil
end

CommonAiMovement._current_go_to_position = function(l_24_0, l_24_1)
	local l_24_2 = l_24_1._movement._current_go_to
	if l_24_2 and type(l_24_2) == "table" then
		local l_24_3 = #l_24_2
		local l_24_4 = assert
		l_24_4(l_24_3 > 0)
		l_24_4 = l_24_2[l_24_3]
		return l_24_4.position
	else
		return l_24_2
	end
end


