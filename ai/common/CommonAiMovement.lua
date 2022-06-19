require("ai/common/CommonAiLogicSwitch")
require("ai/common/MovementPathUtilities")
require("shared/RandomTraversal")
CommonAiMovement = CommonAiMovement or class()
function CommonAiMovement.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._movement = L2_2
	L2_2 = A1_1._movement
	L2_2._move_in_cluster = nil
	L2_2 = A1_1._movement
	L2_2._last_move_time = 0
	L2_2 = A1_1._movement
	L2_2._next_move_time = 0
	L2_2 = A1_1._movement
	L2_2._current_go_to = nil
	L2_2 = A1_1._movement
	L2_2._order_go_to = nil
	L2_2 = A1_1._movement
	L2_2._cluster_points_visited = {}
	L2_2 = A1_1._movement
	L2_2._retry_path = false
	L2_2 = A1_1._movement
	L2_2._ai_waypoint_path = nil
end
function CommonAiMovement.logic_common_movement_idle(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	local L8_11
	L8_11 = A2_5.ai_data
	L8_11 = L8_11(A2_5)
	if A0_3:_evaluate_go_to(L8_11) then
		return 0, true
	end
	if L8_11._behavior.use_covers and L8_11._cover.cover_info and L8_11._cover.go_to and L8_11:new_path_requested() and not L8_11.input.in_target_cover and not L8_11.input.entering_target_cover then
		L8_11._movement._order_go_to = L8_11._cover.go_to
		return 0, true
	end
	if L8_11._behavior.move_in_cluster then
		return 1, true
	end
	L8_11:set_new_path(nil)
	L8_11.output.move_speed = 1
	L8_11.output.allowed_to_strafe = false
	if L8_11._behavior.use_covers then
		L8_11.output.target_cover_info = L8_11._cover.cover_info
	else
		L8_11.output.target_cover_info = nil
	end
	return nil
end
function CommonAiMovement.logic_common_movement_go_to_enter(A0_12, A1_13, A2_14, A3_15)
	local L4_16
	L4_16 = A2_14.ai_data
	L4_16 = L4_16(A2_14)
	L4_16._movement._current_go_to = L4_16._behavior.go_to or L4_16._movement._order_go_to
	A0_12:_update_path(A2_14, L4_16)
end
function CommonAiMovement.logic_common_movement_go_to(A0_17, A1_18, A2_19, A3_20, A4_21, A5_22, A6_23, A7_24)
	local L8_25, L9_26, L10_27
	L9_26 = A2_19
	L8_25 = A2_19.ai_data
	L8_25 = L8_25(L9_26)
	L10_27 = A0_17
	L9_26 = A0_17._evaluate_go_to
	L9_26 = L9_26(L10_27, L8_25)
	if L9_26 then
		L9_26 = L8_25._movement
		L10_27 = L8_25._behavior
		L10_27 = L10_27.go_to
		L9_26._current_go_to = L10_27
		L10_27 = A0_17
		L9_26 = A0_17._update_path
		L9_26(L10_27, A2_19, L8_25)
	end
	L10_27 = A0_17
	L9_26 = A0_17._movement_ordered_go_to
	L9_26 = L9_26(L10_27, L8_25)
	if L9_26 then
		L9_26 = L8_25._behavior
		L9_26 = L9_26.move_in_cluster
		if L9_26 == "hunt" then
			L10_27 = A0_17
			L9_26 = A0_17._has_fire_target
			L9_26 = L9_26(L10_27, L8_25)
			if L9_26 then
				L10_27 = A0_17
				L9_26 = A0_17._can_fight_from_position
				L9_26 = L9_26(L10_27, A2_19, A0_17:_current_go_to_position(L8_25))
				if not L9_26 then
					L10_27 = L8_25
					L9_26 = L8_25.set_new_path
					L9_26(L10_27, nil)
					L9_26 = 0
					return L9_26
				end
			end
		end
	end
	L10_27 = A0_17
	L9_26 = A0_17._behavior_ordered_go_to
	L9_26 = L9_26(L10_27, L8_25)
	if not L9_26 then
		L10_27 = A0_17
		L9_26 = A0_17._movement_ordered_go_to
		L9_26 = L9_26(L10_27, L8_25)
		if not L9_26 then
			L9_26 = 0
			return L9_26
		end
	end
	L9_26 = L8_25._movement
	L9_26 = L9_26._current_go_to
	if not L9_26 then
		L10_27 = 0
		return L10_27
	end
	L10_27 = L8_25.current_path_completed
	L10_27 = L10_27(L8_25)
	if L10_27 then
		L10_27 = A0_17._completed_go_to
		L10_27(A0_17, L8_25)
		L10_27 = 0
		return L10_27
	end
	L10_27 = L8_25.new_path_requested
	L10_27 = L10_27(L8_25)
	if L10_27 then
		L10_27 = A0_17._update_path
		L10_27(A0_17, A2_19, L8_25)
	end
	L10_27 = L8_25._movement
	L10_27 = L10_27._retry_path
	if not L10_27 then
		L10_27 = L8_25.path
		L10_27 = L10_27(L8_25)
		if not L10_27 then
			L10_27 = 0
			return L10_27
		end
	end
	L10_27 = L8_25._behavior
	L10_27 = L10_27.use_covers
	if L10_27 then
		L10_27 = L8_25.output
		L10_27.target_cover_info = L8_25._cover.cover_info
	end
	L10_27 = L8_25._movement
	L10_27._last_move_time = A1_18
	L10_27 = L8_25._behavior
	L10_27 = L10_27.go_to_speed
	if L10_27 then
		if L8_25.SPEEDS then
			L10_27 = L8_25.SPEEDS[L10_27]
			assert(L10_27)
		end
	else
		L10_27 = 1
	end
	L8_25.output.move_speed = L10_27
	L8_25.output.allowed_to_strafe = L8_25._behavior.move_in_cluster == "hunt" or L8_25._behavior.move_in_cluster == "hide"
end
function CommonAiMovement.logic_common_movement_go_to_exit(A0_28, A1_29, A2_30, A3_31)
	A2_30:ai_data()._movement._current_go_to = nil
	A2_30:ai_data()._movement._order_go_to = nil
	if A2_30:ai_data()._movement._ai_waypoint_path then
		A2_30:ai_data()._movement._ai_waypoint_path:remove()
		A2_30:ai_data()._movement._ai_waypoint_path = nil
	end
	A2_30:ai_data():set_waypoints(nil)
end
function CommonAiMovement._ordered_to_cover(A0_32, A1_33)
	local L2_34, L3_35
	L2_34 = A1_33._cover
	L2_34 = L2_34.go_to
	if L2_34 then
		L2_34 = A1_33._movement
		L2_34 = L2_34._current_go_to
		L3_35 = A1_33._cover
		L3_35 = L3_35.go_to
		L2_34 = L2_34 == L3_35
	end
	return L2_34
end
function CommonAiMovement._behavior_ordered_go_to(A0_36, A1_37)
	return A1_37._behavior.go_to
end
function CommonAiMovement._movement_ordered_go_to(A0_38, A1_39)
	local L2_40, L3_41
	L2_40 = A1_39._movement
	L2_40 = L2_40._current_go_to
	L3_41 = A1_39._movement
	L3_41 = L3_41._order_go_to
	L2_40 = L2_40 == L3_41
	return L2_40
end
function CommonAiMovement.logic_common_movement_in_cluster_enter(A0_42, A1_43, A2_44, A3_45)
	local L4_46
	L4_46 = A2_44.ai_data
	L4_46 = L4_46(A2_44)
	if L4_46._behavior.move_in_cluster ~= L4_46._movement._move_in_cluster then
		A0_42:_clear_cluster(L4_46)
		L4_46._movement._next_move_time = A1_43
		L4_46._movement._move_in_cluster = L4_46._behavior.move_in_cluster
	else
		L4_46._movement._next_move_time = L4_46._movement._last_move_time
		if L4_46._behavior.move_in_cluster == "patrol" then
			L4_46._movement._next_move_time = L4_46._movement._next_move_time + math.random(L4_46.PATROL_MOVE_TIMERS[1], L4_46.PATROL_MOVE_TIMERS[2])
			if not L4_46.output.can_not_find_path then
				L4_46:request_scan()
			end
		elseif L4_46._behavior.move_in_cluster == "hunt" then
			L4_46._movement._next_move_time = L4_46._movement._next_move_time + math.random(L4_46.AGGRESIVE_MOVE_TIMERS[1], L4_46.AGGRESIVE_MOVE_TIMERS[2])
		end
	end
end
function CommonAiMovement.logic_common_movement_in_cluster(A0_47, A1_48, A2_49, A3_50, A4_51, A5_52, A6_53, A7_54)
	local L8_55, L9_56
	L9_56 = A2_49
	L8_55 = A2_49.ai_data
	L8_55 = L8_55(L9_56)
	L9_56 = A0_47._evaluate_go_to
	L9_56 = L9_56(A0_47, L8_55)
	if L9_56 then
		L9_56 = 1
		return L9_56, true
	end
	L9_56 = L8_55._behavior
	L9_56 = L9_56.move_in_cluster
	if L9_56 then
		L9_56 = L8_55._behavior
		L9_56 = L9_56.move_in_cluster
	elseif L9_56 ~= L8_55._movement._move_in_cluster then
		L9_56 = 0
		return L9_56, true
	end
	L9_56 = L8_55._behavior
	L9_56 = L9_56.move_in_cluster
	if L9_56 == "hunt" then
		L9_56 = L8_55._behavior
		L9_56 = L9_56.search_for
		if L9_56 then
			L9_56 = A0_47._can_fight_from_position
			L9_56 = L9_56(A0_47, A2_49)
			if not L9_56 then
				L9_56 = L8_55._behavior
				L9_56 = L9_56.use_covers
				if not L9_56 then
					L9_56 = L8_55._movement
					L9_56._next_move_time = A1_48
				end
			end
		end
	end
	L9_56 = nil
	if A1_48 >= L8_55._movement._next_move_time then
		if L8_55._behavior.move_in_cluster == "patrol" then
			if L8_55:is_scan_requested() then
				L8_55:cancel_scan_request()
			end
			if not L8_55:is_scanning() then
				L9_56 = {
					A0_47:_good_random_cluster_point(A2_49)
				}
			end
		elseif L8_55._behavior.move_in_cluster == "hunt" then
			if A0_47:_good_hunt_cluster_point(A2_49) then
				L9_56 = A0_47:_good_hunt_cluster_point(A2_49).position
			end
		elseif L8_55._behavior.move_in_cluster == "hide" then
			if A0_47:_good_hide_cluster_point(A2_49) then
				L9_56 = A0_47:_good_hide_cluster_point(A2_49).position
			end
		else
			assert(false, "Unknown move: '" .. L8_55._behavior.move_in_cluster .. "'")
		end
	end
	if L9_56 then
		L8_55._movement._order_go_to = L9_56
		return 1, true
	end
	if L8_55._behavior.use_covers and L8_55._cover.cover_info and L8_55._cover.go_to and L8_55:new_path_requested() then
		L8_55._movement._order_go_to = L8_55._cover.go_to
		return 1, true
	end
	L8_55:set_new_path(nil)
	L8_55.output.move_speed = 1
	L8_55.output.allowed_to_strafe = false
	if L8_55._behavior.use_covers and L8_55._cover then
		L8_55.output.target_cover_info = L8_55._cover.cover_info
	else
		L8_55.output.target_cover_info = nil
	end
	return nil
end
function CommonAiMovement.logic_common_movement_in_cluster_exit(A0_57, A1_58, A2_59, A3_60)
	if A2_59:ai_data().is_scan_requested and A2_59:ai_data():is_scan_requested() then
		A2_59:ai_data():cancel_scan_request()
	end
end
function CommonAiMovement._evaluate_go_to(A0_61, A1_62)
	local L2_63, L3_64
	L2_63 = A1_62._behavior
	L2_63 = L2_63.go_to
	if L2_63 then
		L2_63 = A1_62._behavior
		L2_63 = L2_63.go_to
		L3_64 = A1_62._movement
		L3_64 = L3_64.last_completed_position
		if L2_63 ~= L3_64 then
			L2_63 = A1_62._behavior
			L2_63 = L2_63.go_to
			L3_64 = A1_62._movement
			L3_64 = L3_64._current_go_to
			if L2_63 ~= L3_64 then
				L2_63 = true
				return L2_63
			end
		end
	else
		L2_63 = A1_62._movement
		L2_63.last_completed_position = nil
	end
	L2_63 = false
	return L2_63
end
function CommonAiMovement._completed_go_to(A0_65, A1_66)
	local L3_67
	L3_67 = A1_66._movement
	L3_67.last_completed_position = A1_66._behavior.go_to
end
function CommonAiMovement._clear_cluster(A0_68, A1_69)
	A1_69._movement._cluster_points_visited = {}
end
function CommonAiMovement._good_hunt_cluster_point(A0_70, A1_71)
	if A1_71:ai_data().hunt_and_hide then
		return A0_70:_good_hunt_hide_cluster_point(A1_71)
	end
	return A0_70:_random_hunt_cluster_point(A1_71)
end
function CommonAiMovement._good_hide_cluster_point(A0_72, A1_73)
	local L2_74, L3_75, L4_76
	L3_75 = A1_73
	L2_74 = A1_73.ai_data
	L2_74 = L2_74(L3_75)
	L3_75 = L2_74._behavior
	L3_75 = L3_75.hide_from
	if not L3_75 then
		L3_75 = nil
		return L3_75
	end
	L3_75 = nil
	L4_76 = L2_74._behavior
	L4_76 = L4_76.area_cluster
	L4_76 = #L4_76
	for _FORV_9_ = 1, L4_76 do
		if not L3_75 or A0_72:_hide_count(A1_73, L2_74._behavior.area_cluster[RandomTraversal:new(L4_76):next_index()].position) > L3_75.blocks then
			L3_75 = {
				point_data = L2_74._behavior.area_cluster[RandomTraversal:new(L4_76):next_index()],
				blocks = A0_72:_hide_count(A1_73, L2_74._behavior.area_cluster[RandomTraversal:new(L4_76):next_index()].position)
			}
		end
	end
	if L3_75 then
		return L3_75.point_data
	end
	return nil
end
function CommonAiMovement._good_random_cluster_point(A0_77, A1_78)
	local L2_79, L3_80, L4_81
	L3_80 = A1_78
	L2_79 = A1_78.ai_data
	L2_79 = L2_79(L3_80)
	L4_81 = A1_78
	L3_80 = A1_78.position
	L3_80 = L3_80(L4_81)
	L4_81 = L2_79._behavior
	L4_81 = L4_81.area_cluster
	L4_81 = #L4_81
	for _FORV_10_ = 1, L4_81 do
		if mvector3.distance(L2_79._behavior.area_cluster[RandomTraversal:new(L4_81):current_index()].position, L3_80) > 100 and NavigationGraphUtilities.ai_check_can_move_there(A1_78, L2_79._behavior.area_cluster[RandomTraversal:new(L4_81):current_index()].position) then
			return L2_79._behavior.area_cluster[RandomTraversal:new(L4_81):current_index()]
		end
		RandomTraversal:new(L4_81):next_index()
	end
	return _FOR_.area_cluster[RandomTraversal:new(L4_81):current_index()]
end
function CommonAiMovement._good_hunt_hide_cluster_point(A0_82, A1_83)
	local L2_84, L3_85, L4_86, L5_87
	L3_85 = A1_83
	L2_84 = A1_83.ai_data
	L2_84 = L2_84(L3_85)
	L3_85 = L2_84._behavior
	L3_85 = L3_85.hide_from
	if not L3_85 then
		L3_85 = nil
		return L3_85
	end
	L3_85, L4_86 = nil, nil
	L5_87 = assert
	L5_87(A1_83)
	L5_87 = A1_83.position
	L5_87 = L5_87(A1_83)
	for 