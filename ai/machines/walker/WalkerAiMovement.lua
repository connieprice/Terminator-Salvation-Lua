WalkerAiMovement = WalkerAiMovement or class(CommonAiMovement)
function WalkerAiMovement.init_data(A0_0, A1_1)
	CommonAiMovement.init_data(A0_0, A1_1)
	A1_1.output.moving_to_execute_target = nil
end
function WalkerAiMovement.logic_walker_movement_idle_enter(A0_2, ...)
	local L2_4, L3_5, L4_6
	L2_4 = CommonAiMovement
	L2_4 = L2_4.logic_common_movement_idle_enter
	if L2_4 then
		L2_4 = CommonAiMovement
		L3_5 = L2_4
		L2_4 = L2_4.logic_common_movement_idle_enter
		L4_6 = ...
		return L2_4(L3_5, L4_6)
	end
end
function WalkerAiMovement.logic_walker_movement_idle_exit(A0_7, ...)
	local L2_9, L3_10, L4_11
	L2_9 = CommonAiMovement
	L2_9 = L2_9.logic_common_movement_idle_enter
	if L2_9 then
		L2_9 = CommonAiMovement
		L3_10 = L2_9
		L2_9 = L2_9.logic_common_movement_idle_exit
		L4_11 = ...
		return L2_9(L3_10, L4_11)
	end
end
function WalkerAiMovement.logic_walker_movement_idle(A0_12, A1_13, A2_14, A3_15, A4_16, A5_17, A6_18, A7_19)
	local L8_20
	L8_20 = A2_14.ai_data
	L8_20 = L8_20(A2_14)
	if A0_12:_can_execute(A2_14, L8_20, A1_13) then
		return 5, true
	end
	return CommonAiMovement.logic_common_movement_idle(A0_12, A1_13, A2_14, A3_15, A4_16, A5_17, A6_18, A7_19)
end
function WalkerAiMovement.logic_walker_movement_in_cluster_enter(A0_21, ...)
	local L2_23, L3_24, L4_25
	L2_23 = CommonAiMovement
	L2_23 = L2_23.logic_common_movement_in_cluster_enter
	if L2_23 then
		L2_23 = CommonAiMovement
		L3_24 = L2_23
		L2_23 = L2_23.logic_common_movement_in_cluster_enter
		L4_25 = ...
		return L2_23(L3_24, L4_25)
	end
end
function WalkerAiMovement.logic_walker_movement_in_cluster_exit(A0_26, ...)
	local L2_28, L3_29, L4_30
	L2_28 = CommonAiMovement
	L2_28 = L2_28.logic_common_movement_in_cluster_enter
	if L2_28 then
		L2_28 = CommonAiMovement
		L3_29 = L2_28
		L2_28 = L2_28.logic_common_movement_in_cluster_exit
		L4_30 = ...
		return L2_28(L3_29, L4_30)
	end
end
function WalkerAiMovement.logic_walker_movement_in_cluster(A0_31, A1_32, A2_33, A3_34, A4_35, A5_36, A6_37, A7_38)
	local L8_39
	L8_39 = A2_33.ai_data
	L8_39 = L8_39(A2_33)
	if A0_31:_can_execute(A2_33, L8_39, A1_32) then
		return 5, true
	end
	return CommonAiMovement.logic_common_movement_in_cluster(A0_31, A1_32, A2_33, A3_34, A4_35, A5_36, A6_37, A7_38)
end
function WalkerAiMovement.logic_walker_movement_go_to_enter(A0_40, ...)
	local L2_42, L3_43, L4_44
	L2_42 = CommonAiMovement
	L2_42 = L2_42.logic_common_movement_go_to_enter
	if L2_42 then
		L2_42 = CommonAiMovement
		L3_43 = L2_42
		L2_42 = L2_42.logic_common_movement_go_to_enter
		L4_44 = ...
		return L2_42(L3_43, L4_44)
	end
end
function WalkerAiMovement.logic_walker_movement_go_to_exit(A0_45, ...)
	local L2_47, L3_48, L4_49
	L2_47 = CommonAiMovement
	L2_47 = L2_47.logic_common_movement_go_to_enter
	if L2_47 then
		L2_47 = CommonAiMovement
		L3_48 = L2_47
		L2_47 = L2_47.logic_common_movement_go_to_exit
		L4_49 = ...
		return L2_47(L3_48, L4_49)
	end
end
function WalkerAiMovement.logic_walker_movement_go_to(A0_50, A1_51, A2_52, A3_53, A4_54, A5_55, A6_56, A7_57)
	local L8_58
	L8_58 = A2_52.ai_data
	L8_58 = L8_58(A2_52)
	if A0_50:_can_execute(A2_52, L8_58, A1_51) then
		return 5, true
	end
	return CommonAiMovement.logic_common_movement_go_to(A0_50, A1_51, A2_52, A3_53, A4_54, A5_55, A6_56, A7_57)
end
function WalkerAiMovement._can_execute(A0_59, A1_60, A2_61, A3_62)
	local L4_63
	L4_63 = A2_61._behavior
	L4_63 = L4_63.allowed_to_execute
	if L4_63 then
		L4_63 = A0_59._execution_status
		L4_63 = L4_63(A0_59, A1_60, A2_61, nil)
		if L4_63.possible then
			if not A2_61._behavior._execution_possible_start_time then
				A2_61._behavior._execution_possible_start_time = A3_62
			end
			if A3_62 - A2_61._behavior._execution_possible_start_time > WalkerTweakData.EXECUTION_MIN_TIME then
				A2_61._behavior._execution_possible_start_time = nil
				L4_63.path = NavigationGraphUtilities.ai_shortest_path(A1_60, L4_63.go_to_position)
				if L4_63.path then
					A0_59:_set_execution_info(A2_61, L4_63)
					return true
				end
				L4_63.possible = false
			end
		else
			A2_61._behavior._execution_possible_start_time = nil
		end
	end
	L4_63 = false
	return L4_63
end
function WalkerAiMovement._execution_status(A0_64, A1_65, A2_66, A3_67)
	local L4_68
	L4_68 = {}
	L4_68.possible = false
	L4_68.update = false
	A0_64:_calculate_execution_status(A1_65, A2_66, L4_68)
	if not L4_68.possible then
		return L4_68
	end
	if not A3_67 then
		L4_68.update = true
	elseif A2_66:new_path_requested() and not A2_66:current_path_completed() then
		L4_68.update = true
	elseif A3_67.threat:unit() ~= L4_68.threat:unit() then
		L4_68.update = true
	elseif mvector3.distance(L4_68.go_to_position, A3_67.go_to_position) > WalkerTweakData.EXECUTION_UPDATE_PATH_DISTANCE and not A2_66.input.is_executing then
		L4_68.update = true
	end
	if L4_68.update and L4_68.possible then
		A0_64:_calculate_execution_path(A1_65, L4_68)
	end
	return L4_68
end
function WalkerAiMovement._calculate_execution_status(A0_69, A1_70, A2_71, A3_72, A4_73)
	local L5_74, L6_75, L7_76, L8_77, L9_78
	L5_74 = A2_71.output
	L5_74 = L5_74.currently_targeted_threat
	if not L5_74 then
		return A3_72
	end
	L7_76 = A0_69
	L6_75 = A0_69._is_executable_threat
	L8_77 = L5_74
	L6_75 = L6_75(L7_76, L8_77)
	if not L6_75 then
		A3_72.possible = false
		return A3_72
	end
	A3_72.threat = L5_74
	L7_76 = A1_70
	L6_75 = A1_70.position
	L6_75 = L6_75(L7_76)
	L8_77 = L5_74
	L7_76 = L5_74.unit
	L7_76 = L7_76(L8_77)
	L8_77 = L7_76
	L7_76 = L7_76.position
	L7_76 = L7_76(L8_77)
	L8_77 = mvector3
	L8_77 = L8_77.distance
	L9_78 = L7_76
	L8_77 = L8_77(L9_78, L6_75)
	L9_78 = WalkerTweakData
	L9_78 = L9_78.EXECUTION_ATTACKER_TO_TARGET_DISTANCE
	if L8_77 > L9_78 then
		A3_72.possible = false
		return A3_72
	end
	L9_78 = TableAlgorithms
	L9_78 = L9_78.is_empty
	L9_78 = L9_78(A2_71._behavior.area_cluster)
	if not L9_78 then
		L9_78 = A0_69._closest_cluster_position
		L9_78 = L9_78(A0_69, L6_75, A2_71._behavior.area_cluster)
		if mvector3.distance(L9_78, L7_76) > WalkerTweakData.EXECUTION_MAX_CLUSTER_DISTANCE then
			A3_72.possible = false
			return A3_72
		end
	end
	L9_78 = A0_69._targeted_threat_has_close_friends
	L9_78 = L9_78(A0_69, L5_74, A2_71._threat_tracking._threats)
	if L9_78 then
		A3_72.possible = false
		return A3_72
	end
	L9_78 = A0_69._grab_over_cover_position_and_rotation
	A3_72.grab_over_cover_rotation, L9_78 = A0_69, L9_78(A0_69, L5_74)
	A3_72.grab_over_cover_position = L9_78
	L9_78 = A3_72.grab_over_cover_position
	if L9_78 then
		L9_78 = A3_72.grab_over_cover_position
		A3_72.go_to_position = L9_78
		L9_78 = A3_72.grab_over_cover_rotation
		A3_72.go_to_rotation = L9_78
	else
		L9_78 = A0_69._grab_behind_cover_position
		L9_78 = L9_78(A0_69, L5_74)
		A3_72.go_to_position = L9_78
	end
	A3_72.possible = true
	return A3_72
end
function WalkerAiMovement._calculate_execution_path(A0_79, A1_80, A2_81)
	local L3_82, L4_83, L5_84
	L3_82 = NavigationGraphUtilities
	L3_82 = L3_82.ai_shortest_path
	L4_83 = A1_80
	L5_84 = A2_81.go_to_position
	L3_82 = L3_82(L4_83, L5_84, true)
	if not L3_82 then
		A2_81.possible = false
		return A2_81
	end
	L4_83 = #L3_82
	L4_83 = L3_82[L4_83]
	L5_84 = mvector3
	L5_84 = L5_84.distance
	L5_84 = L5_84(L4_83, A2_81.go_to_position)
	if L5_84 > WalkerTweakData.EXECUTION_MAX_DESTINATION_OFFSET then
		L5_84 = false
		return L5_84
	end
	L5_84 = A1_80.position
	L5_84 = L5_84(A1_80)
	if MovementPathUtilities.path_length(L5_84, L3_82) > WalkerTweakData.EXECUTION_MAX_TRAVEL_LENGTH then
		A2_81.possible = false
	end
	return A2_81
end
function WalkerAiMovement._closest_cluster_position(A0_85, A1_86, A2_87)
	local L3_88
	for 