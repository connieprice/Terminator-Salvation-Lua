CommonAiBehavior = CommonAiBehavior or class()
function CommonAiBehavior.init_data(A0_0, A1_1)
	local L2_2, L3_3
	L2_2 = {}
	A1_1._behavior = L2_2
	L2_2 = A1_1._behavior
	L2_2.go_to = nil
	L2_2 = A1_1._behavior
	L2_2.allowed_to_fire = false
	L2_2 = A1_1._behavior
	L2_2.move_in_cluster = nil
	L2_2 = A1_1._behavior
	L2_2.hide_from = nil
	L2_2 = A1_1._behavior
	L2_2.search_for = nil
	L2_2 = A1_1._behavior
	L3_3 = {}
	L2_2.area_cluster = L3_3
	L2_2 = A1_1._behavior
	L2_2.use_covers = false
	L2_2 = A1_1._behavior
	L2_2._hide_until_time = 0
	L2_2 = A1_1._behavior
	L3_3 = {}
	L3_3.damage = 0
	L3_3.threat = nil
	L2_2._most_dangerous_threat = L3_3
end
function CommonAiBehavior._set_standard_eyes(A0_4, A1_5, A2_6)
	A2_6.current_unit_eyes = A2_6.UNIT_EYES.STANDARD
	IntelUtilities.ai_update_eyes(A1_5)
end
function CommonAiBehavior._set_patrol_eyes(A0_7, A1_8, A2_9)
	A2_9.current_unit_eyes = A2_9.UNIT_EYES.PATROL or A2_9.UNIT_EYES.STANDARD
	IntelUtilities.ai_update_eyes(A1_8)
end
function CommonAiBehavior.logic_common_behavior_startup(A0_10, A1_11, A2_12, A3_13, A4_14, A5_15, A6_16, A7_17)
	local L8_18
	L8_18 = A2_12.ai_data
	L8_18 = L8_18(A2_12)
	if L8_18.startup_mode == "patrol" then
		A0_10:_set_patrol_eyes(A2_12, L8_18)
	elseif L8_18.startup_mode == "combat" then
		A0_10:_set_standard_eyes(A2_12, L8_18)
		L8_18._behavior.forced_aggressive_mode = true
	end
	return 0, true
end
function CommonAiBehavior.logic_common_behavior_go_to_navigation_target(A0_19, A1_20, A2_21, A3_22, A4_23, A5_24, A6_25, A7_26)
	local L8_27
	L8_27 = A2_21.ai_data
	L8_27 = L8_27(A2_21)
	if not L8_27._behavior.navigation_target then
		return 0, true
	end
	if A0_19:_navigation_target_completed(L8_27) then
		L8_27._behavior._last_completed_navigation_target = L8_27._behavior.navigation_target
		return 0, true
	end
	L8_27._behavior.allowed_to_fire = false
	if L8_27._behavior.navigation_target_options.threat_mode == "ignore" then
		L8_27._behavior.allowed_to_target = false
	else
		L8_27._behavior.allowed_to_target = true
	end
	if L8_27._behavior.navigation_target_options.threat_mode == "fire at" then
		L8_27._behavior.allowed_to_fire = true
	elseif L8_27._behavior.navigation_target_options.threat_mode == "look at" then
		L8_27._behavior.allowed_to_fire = false
	elseif L8_27._behavior.navigation_target_options.threat_mode == "attack resume" then
		if L8_27._targeting.currently_targeted_threat then
			return 1, true
		end
	elseif L8_27._behavior.navigation_target_options.threat_mode == "attack" and L8_27._targeting.currently_targeted_threat then
		L8_27._behavior._last_completed_navigation_target = L8_27._behavior.navigation_target
		return 1, true
	end
	if L8_27._targeting.currently_targeted_threat then
		L8_27.output.look_at_position = L8_27._targeting.currently_targeted_threat:last_known_position() or A2_21:position() + 10000 * L8_27._targeting.currently_targeted_threat:last_known_direction()
		L8_27.output.attack_mode = true
	else
		L8_27.output.look_at_position = nil
		L8_27.output.attack_mode = false
	end
	L8_27._behavior.go_to = L8_27._behavior.navigation_target
	L8_27._behavior.go_to_speed = L8_27._behavior.navigation_target_options.speed
	L8_27._behavior.move_in_cluster = nil
	L8_27._behavior.hide_from = nil
	L8_27._behavior.search_for = nil
	L8_27._behavior.use_covers = L8_27._behavior.navigation_target_options.use_covers
	return nil
end
function CommonAiBehavior.logic_common_behavior_go_to_navigation_target_exit(A0_28, A1_29, A2_30, A3_31)
	A2_30:ai_data()._behavior.go_to_speed = nil
end
function CommonAiBehavior.logic_common_behavior_idle(A0_32, A1_33, A2_34, A3_35, A4_36, A5_37, A6_38, A7_39)
	local L8_40
	L8_40 = A2_34.ai_data
	L8_40 = L8_40(A2_34)
	if A0_32:_has_navigation_target(L8_40) then
		return 1
	end
	if A0_32:_has_threat(L8_40) or A0_32:_forced_aggressive_behavior(L8_40, A1_33) then
		return 0, true
	end
	if A0_32:_evaluate_hide_from_threat(L8_40) then
		return 2, true
	end
	if L8_40._sensory_data.current_buffered_event and L8_40._sensory_data.current_buffered_event ~= L8_40._sensory_data.last_handled_buffered_event and not A0_32:_ignore_threats(L8_40) and mvector3.distance(A2_34:position(), L8_40._sensory_data.current_event_last_known_position) < 4000 then
		L8_40._behavior.forced_aggressive_mode = true
		return 0, true
	end
	if L8_40.startup_mode == "patrol" then
		return 3
	end
	L8_40._behavior.go_to = nil
	L8_40._behavior.allowed_to_fire = false
	L8_40._behavior.move_in_cluster = nil
	L8_40._behavior.hide_from = nil
	L8_40._behavior.search_for = nil
	L8_40._behavior.area_cluster = {}
	L8_40._behavior.use_covers = A0_32:_use_covers(L8_40)
	L8_40._behavior.allowed_to_target = false
	L8_40.output.attack_mode = false
	L8_40.output.look_at_position = nil
	return nil
end
function CommonAiBehavior.logic_common_behavior_patrol_enter(A0_41, A1_42, A2_43, A3_44)
	local L4_45
	L4_45 = A2_43.ai_data
	L4_45 = L4_45(A2_43)
	A0_41:_set_patrol_eyes(A2_43, L4_45)
	L4_45.output.unaware = true
end
function CommonAiBehavior.logic_common_behavior_patrol(A0_46, A1_47, A2_48, A3_49, A4_50, A5_51, A6_52, A7_53)
	local L8_54
	L8_54 = A2_48.ai_data
	L8_54 = L8_54(A2_48)
	if A0_46:_has_navigation_target(L8_54) then
		return 1
	end
	if A0_46:_has_threat(L8_54) or A0_46:_forced_aggressive_behavior(L8_54, A1_47) then
		return 0, true
	end
	if A0_46:_evaluate_hide_from_threat(L8_54) then
		return 2, true
	end
	if L8_54._sensory_data.current_buffered_event and L8_54._sensory_data.current_buffered_event ~= L8_54._sensory_data.last_handled_buffered_event and not A0_46:_ignore_threats(L8_54) and mvector3.distance(A2_48:position(), L8_54._sensory_data.current_event_last_known_position) < 4000 then
		L8_54._behavior.forced_aggressive_mode = true
		return 0, true
	end
	A0_46:_setup_area_move_data(L8_54, "patrol")
	L8_54._behavior.go_to = nil
	L8_54._behavior.allowed_to_fire = false
	L8_54._behavior.hide_from = nil
	L8_54._behavior.search_for = nil
	L8_54._behavior.use_covers = A0_46:_use_covers(L8_54)
	L8_54._behavior.allowed_to_target = false
	L8_54.output.attack_mode = false
	L8_54.output.look_at_position = nil
	return nil
end
function CommonAiBehavior.logic_common_behavior_patrol_exit(A0_55, A1_56, A2_57, A3_58)
	local L4_59
	L4_59 = A2_57.ai_data
	L4_59 = L4_59(A2_57)
	A0_55:_set_standard_eyes(A2_57, L4_59)
	L4_59.output.unaware = false
end
function CommonAiBehavior._forced_aggressive_behavior(A0_60, A1_61, A2_62)
	local L3_63, L4_64
	L3_63 = A1_61._behavior
	L3_63 = L3_63.forced_aggressive_mode
	if not L3_63 then
		L3_63 = A1_61._behavior
		L3_63 = L3_63.forced_aggressive_start_time
		if L3_63 then
			L3_63 = A1_61._behavior
			L3_63 = L3_63.forced_aggressive_start_time
			L3_63 = A2_62 - L3_63
			L4_64 = tweak_data
			L4_64 = L4_64.ai
			L4_64 = L4_64.machines
			L4_64 = L4_64.flyer
			L4_64 = L4_64.FORCED_AGGRESIVE_TIME
			L3_63 = L3_63 < L4_64
		end
	end
	return L3_63
end
function CommonAiBehavior.logic_common_behavior_aggressive(A0_65, A1_66, A2_67, A3_68, A4_69, A5_70, A6_71, A7_72)
	local L8_73
	L8_73 = A2_67.ai_data
	L8_73 = L8_73(A2_67)
	if L8_73._behavior.forced_aggressive_mode then
		L8_73._behavior.forced_aggressive_start_time = A1_66
		L8_73._behavior.forced_aggressive_mode = false
	end
	if A0_65:_has_navigation_target(L8_73) and A0_65:_force_navigation_target(L8_73) then
		return 1
	end
	if not A0_65:_forced_aggressive_behavior(L8_73, A1_66) then
		if not A0_65:_has_threat(L8_73) then
			if A0_65:_has_navigation_target(L8_73) then
				return 1
			end
			return 0
		end
		if A0_65:_evaluate_hide_from_threat(L8_73) then
			return 2, true
		end
	end
	if L8_73.hunt_and_hide then
		L8_73._behavior.hide_from = {}
		if A0_65:_has_threat(L8_73) then
			for 