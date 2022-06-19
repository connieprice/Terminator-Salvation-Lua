if not CommonAiBehavior then
	CommonAiBehavior = class()
end
CommonAiBehavior.init_data = function(l_1_0, l_1_1)
	l_1_1._behavior = {}
	l_1_1._behavior.go_to = nil
	l_1_1._behavior.allowed_to_fire = false
	l_1_1._behavior.move_in_cluster = nil
	l_1_1._behavior.hide_from = nil
	l_1_1._behavior.search_for = nil
	l_1_1._behavior.area_cluster = {}
	l_1_1._behavior.use_covers = false
	l_1_1._behavior._hide_until_time = 0
	local l_1_2 = l_1_1._behavior
	local l_1_3 = {}
	l_1_3.damage = 0
	l_1_3.threat = nil
	l_1_2._most_dangerous_threat = l_1_3
end

CommonAiBehavior._set_standard_eyes = function(l_2_0, l_2_1, l_2_2)
	l_2_2.current_unit_eyes = l_2_2.UNIT_EYES.STANDARD
	IntelUtilities.ai_update_eyes(l_2_1)
end

CommonAiBehavior._set_patrol_eyes = function(l_3_0, l_3_1, l_3_2)
	if not l_3_2.UNIT_EYES.PATROL then
		l_3_2.current_unit_eyes = l_3_2.UNIT_EYES.STANDARD
	end
	IntelUtilities.ai_update_eyes(l_3_1)
end

CommonAiBehavior.logic_common_behavior_startup = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	if l_4_8.startup_mode == "patrol" then
		l_4_0:_set_patrol_eyes(l_4_2, l_4_8)
	elseif l_4_8.startup_mode == "combat" then
		l_4_0:_set_standard_eyes(l_4_2, l_4_8)
		l_4_8._behavior.forced_aggressive_mode = true
	end
	return 0, true
end

CommonAiBehavior.logic_common_behavior_go_to_navigation_target = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5, l_5_6, l_5_7)
	local l_5_8 = l_5_2:ai_data()
	if not l_5_8._behavior.navigation_target then
		return 0, true
	end
	if l_5_0:_navigation_target_completed(l_5_8) then
		l_5_8._behavior._last_completed_navigation_target = l_5_8._behavior.navigation_target
		return 0, true
	end
	l_5_8._behavior.allowed_to_fire = false
	local l_5_9 = nil
	local l_5_10 = l_5_8._behavior.navigation_target_options.threat_mode
	if l_5_10 == "ignore" then
		l_5_9 = nil
		l_5_8._behavior.allowed_to_target = false
	else
		l_5_9 = l_5_8._targeting.currently_targeted_threat
		l_5_8._behavior.allowed_to_target = true
	end
	if l_5_10 == "fire at" then
		l_5_8._behavior.allowed_to_fire = true
	elseif l_5_10 == "look at" then
		l_5_8._behavior.allowed_to_fire = false
	elseif l_5_10 == "attack resume" and l_5_9 then
		return 1, true
	end
	do return end
	if l_5_10 == "attack" and l_5_9 then
		l_5_8._behavior._last_completed_navigation_target = l_5_8._behavior.navigation_target
		return 1, true
	end
	if l_5_9 then
		if not l_5_9:last_known_position() then
			l_5_8.output.look_at_position = l_5_2:position() + 10000 * l_5_9:last_known_direction()
		end
		l_5_8.output.attack_mode = true
	else
		l_5_8.output.look_at_position = nil
		l_5_8.output.attack_mode = false
	end
	l_5_8._behavior.go_to = l_5_8._behavior.navigation_target
	l_5_8._behavior.go_to_speed = l_5_8._behavior.navigation_target_options.speed
	l_5_8._behavior.move_in_cluster = nil
	l_5_8._behavior.hide_from = nil
	l_5_8._behavior.search_for = nil
	l_5_8._behavior.use_covers = l_5_8._behavior.navigation_target_options.use_covers
	return nil
end

CommonAiBehavior.logic_common_behavior_go_to_navigation_target_exit = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = l_6_2:ai_data()
	l_6_4._behavior.go_to_speed = nil
end

CommonAiBehavior.logic_common_behavior_idle = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5, l_7_6, l_7_7)
	local l_7_8 = l_7_2:ai_data()
	if l_7_0:_has_navigation_target(l_7_8) then
		return 1
	end
	if l_7_0:_has_threat(l_7_8) or l_7_0:_forced_aggressive_behavior(l_7_8, l_7_1) then
		return 0, true
	end
	if l_7_0:_evaluate_hide_from_threat(l_7_8) then
		return 2, true
	end
	if l_7_8._sensory_data.current_buffered_event and l_7_8._sensory_data.current_buffered_event ~= l_7_8._sensory_data.last_handled_buffered_event and not l_7_0:_ignore_threats(l_7_8) and mvector3.distance(l_7_2:position(), l_7_8._sensory_data.current_event_last_known_position) < 4000 then
		l_7_8._behavior.forced_aggressive_mode = true
		return 0, true
	end
	if l_7_8.startup_mode == "patrol" then
		return 3
	end
	l_7_8._behavior.go_to = nil
	l_7_8._behavior.allowed_to_fire = false
	l_7_8._behavior.move_in_cluster = nil
	l_7_8._behavior.hide_from = nil
	l_7_8._behavior.search_for = nil
	l_7_8._behavior.area_cluster = {}
	l_7_8._behavior.use_covers = l_7_0:_use_covers(l_7_8)
	l_7_8._behavior.allowed_to_target = false
	l_7_8.output.attack_mode = false
	l_7_8.output.look_at_position = nil
	return nil
end

CommonAiBehavior.logic_common_behavior_patrol_enter = function(l_8_0, l_8_1, l_8_2, l_8_3)
	local l_8_4 = l_8_2:ai_data()
	l_8_0:_set_patrol_eyes(l_8_2, l_8_4)
	l_8_4.output.unaware = true
end

CommonAiBehavior.logic_common_behavior_patrol = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, l_9_5, l_9_6, l_9_7)
	local l_9_8 = l_9_2:ai_data()
	if l_9_0:_has_navigation_target(l_9_8) then
		return 1
	end
	if l_9_0:_has_threat(l_9_8) or l_9_0:_forced_aggressive_behavior(l_9_8, l_9_1) then
		return 0, true
	end
	if l_9_0:_evaluate_hide_from_threat(l_9_8) then
		return 2, true
	end
	if l_9_8._sensory_data.current_buffered_event and l_9_8._sensory_data.current_buffered_event ~= l_9_8._sensory_data.last_handled_buffered_event and not l_9_0:_ignore_threats(l_9_8) and mvector3.distance(l_9_2:position(), l_9_8._sensory_data.current_event_last_known_position) < 4000 then
		l_9_8._behavior.forced_aggressive_mode = true
		return 0, true
	end
	l_9_0:_setup_area_move_data(l_9_8, "patrol")
	l_9_8._behavior.go_to = nil
	l_9_8._behavior.allowed_to_fire = false
	l_9_8._behavior.hide_from = nil
	l_9_8._behavior.search_for = nil
	l_9_8._behavior.use_covers = l_9_0:_use_covers(l_9_8)
	l_9_8._behavior.allowed_to_target = false
	l_9_8.output.attack_mode = false
	l_9_8.output.look_at_position = nil
	return nil
end

CommonAiBehavior.logic_common_behavior_patrol_exit = function(l_10_0, l_10_1, l_10_2, l_10_3)
	local l_10_4 = l_10_2:ai_data()
	l_10_0:_set_standard_eyes(l_10_2, l_10_4)
	l_10_4.output.unaware = false
end

CommonAiBehavior._forced_aggressive_behavior = function(l_11_0, l_11_1, l_11_2)
	return l_11_1._behavior.forced_aggressive_mode or not l_11_1._behavior.forced_aggressive_start_time or l_11_2 - l_11_1._behavior.forced_aggressive_start_time < tweak_data.ai.machines.flyer.FORCED_AGGRESIVE_TIME
end

CommonAiBehavior.logic_common_behavior_aggressive = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4, l_12_5, l_12_6, l_12_7)
	local l_12_13, l_12_14, l_12_15, l_12_16, l_12_17, l_12_18, l_12_19, l_12_20, l_12_21, l_12_22 = nil
	local l_12_8 = l_12_2:ai_data()
	if l_12_8._behavior.forced_aggressive_mode then
		l_12_8._behavior.forced_aggressive_start_time = l_12_1
		l_12_8._behavior.forced_aggressive_mode = false
	end
	if l_12_0:_has_navigation_target(l_12_8) and l_12_0:_force_navigation_target(l_12_8) then
		return 1
	end
	if not l_12_0:_forced_aggressive_behavior(l_12_8, l_12_1) then
		if not l_12_0:_has_threat(l_12_8) then
			if l_12_0:_has_navigation_target(l_12_8) then
				return 1
			end
			return 0
		end
	if l_12_0:_evaluate_hide_from_threat(l_12_8) then
		end
		return 2, true
	end
	local l_12_9 = nil
	if l_12_0:_has_threat(l_12_8) then
		l_12_9 = l_12_8._targeting.currently_targeted_threat
	end
	if l_12_8.hunt_and_hide then
		l_12_8._behavior.hide_from = {}
	if l_12_0:_has_threat(l_12_8) then
		end
		for i_0,i_1 in pairs(l_12_8._threat_tracking._threats) do
			if i_1:damage() > 0 and i_1:last_known_position() and i_1 ~= l_12_9 then
				table.insert(l_12_8._behavior.hide_from, i_1:last_known_position())
			end
		end
	end
	if l_12_9 then
		if not l_12_9:last_known_position() then
			l_12_8.output.look_at_position = l_12_2:position() + 10000 * l_12_9:last_known_direction()
	else
		end
	end
	l_12_8.output.look_at_position = nil
	l_12_8._behavior.allowed_to_target = not l_12_0:_ignore_threats(l_12_8)
	l_12_8._behavior.allowed_to_fire = l_12_0:_fight_threats(l_12_8)
	l_12_0:_setup_area_move_data(l_12_8, "hunt")
	l_12_8._behavior.go_to = nil
	if l_12_9 and l_12_9:unit_line_of_sight() and l_12_9:unit_line_of_fire() then
		l_12_8._behavior.search_for = nil
	else
		l_12_8._behavior.search_for = l_12_9
	end
	l_12_8._behavior.use_covers = l_12_0:_use_covers(l_12_8)
	l_12_8.output.attack_mode = true
	return nil
end

CommonAiBehavior._has_threat = function(l_13_0, l_13_1)
	if not l_13_0:_ignore_threats(l_13_1) then
		local l_13_2 = l_13_1._targeting.currently_targeted_threat
	else
		return false
	end
end

CommonAiBehavior.logic_common_behavior_aggressive_exit = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_4 = l_14_2:ai_data()
	l_14_4._behavior.hide_from = nil
end

CommonAiBehavior.logic_common_behavior_defensive_enter = function(l_15_0, l_15_1, l_15_2, l_15_3)
	local l_15_4 = l_15_2:ai_data()
	l_15_4._behavior._hide_until_time = l_15_1 + math.random(l_15_4.HIDE_TIMERS[1], l_15_4.HIDE_TIMERS[2])
	l_15_4.output.defensive = true
end

CommonAiBehavior.logic_common_behavior_defensive = function(l_16_0, l_16_1, l_16_2, l_16_3, l_16_4, l_16_5, l_16_6, l_16_7)
	local l_16_12, l_16_13, l_16_14, l_16_15, l_16_16, l_16_17, l_16_18, l_16_19 = nil
	local l_16_8 = l_16_2:ai_data()
	if l_16_0:_has_navigation_target(l_16_8) and l_16_0:_force_navigation_target(l_16_8) then
		return 1
	end
	l_16_8._behavior.hide_from = {}
	if l_16_0:_has_threat(l_16_8) then
		for i_0,i_1 in pairs(l_16_8._threat_tracking._threats) do
			if i_1:damage() > 0 and i_1:last_known_position() then
				table.insert(l_16_8._behavior.hide_from, i_1:last_known_position())
			end
		end
	end
	if #l_16_8._behavior.hide_from == 0 or l_16_8._behavior._hide_until_time < l_16_1 then
		return 0
	end
	l_16_0:_evaluate_hide_from_threat(l_16_8)
	if not l_16_8._targeting.currently_targeted_threat then
		local l_16_20, l_16_21, l_16_22, l_16_23, l_16_24, l_16_25, l_16_26, l_16_27, l_16_28, l_16_29 = l_16_0:_get_most_dangerous_threat(l_16_8)
	end
	l_16_8._behavior.go_to = nil
	l_16_8._behavior.search_for = nil
	l_16_8._behavior.allowed_to_fire = l_16_0:_fight_threats(l_16_8)
	l_16_0:_setup_area_move_data(l_16_8, "hide")
	l_16_8._behavior.use_covers = l_16_0:_use_covers(l_16_8)
	l_16_8.output.attack_mode = true
	l_16_8._behavior.allowed_to_target = true
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_16_20:last_known_position() then
		l_16_8.output.look_at_position = l_16_2:position() + 10000 * l_16_20:last_known_direction()
	end
	return nil
end

CommonAiBehavior.logic_common_behavior_defensive_exit = function(l_17_0, l_17_1, l_17_2, l_17_3)
	local l_17_4 = l_17_2:ai_data()
	l_17_4.output.defensive = false
	l_17_4._behavior.hide_from = nil
end

CommonAiBehavior._has_navigation_target = function(l_18_0, l_18_1)
	if l_18_1._behavior.navigation_target then
		if #l_18_1._behavior.navigation_target > 0 then
			local l_18_2 = not l_18_0:_navigation_target_completed(l_18_1)
		end
	else
		return false
	end
end

CommonAiBehavior._navigation_target_completed = function(l_19_0, l_19_1)
	local l_19_2 = l_19_1._behavior.navigation_target
	local l_19_3 = l_19_2
	return l_19_1._movement.last_completed_position == l_19_3
end

CommonAiBehavior._force_navigation_target = function(l_20_0, l_20_1)
	if not l_20_1._behavior.navigation_target_options then
		return false
	end
	local l_20_2 = l_20_1._behavior.navigation_target_options.threat_mode
	return l_20_2 ~= "attack resume" and l_20_2 ~= "attack"
end

CommonAiBehavior._setup_area_move_data = function(l_21_0, l_21_1, l_21_2)
	if l_21_1._behavior.arrive_orders and l_21_1._behavior.area_cluster and #l_21_1._behavior.area_cluster > 0 then
		l_21_1._behavior.move_in_cluster = l_21_2
		l_21_1._behavior.area_cluster = l_21_1._behavior.area_cluster
	else
		l_21_1._behavior.move_in_cluster = nil
		l_21_1._behavior.area_cluster = {}
	end
end

CommonAiBehavior._get_highest_priority_threat = function(l_22_0, l_22_1)
	local l_22_2, l_22_5, l_22_6, l_22_7, l_22_8 = nil
	for i_0,i_1 in pairs(l_22_1._threat_tracking._threats) do
		if not l_22_2 or l_22_2:primary_target_priority() < i_1:primary_target_priority() then
			l_22_2 = i_1
		end
	end
	return l_22_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiBehavior._get_most_dangerous_threat = function(l_23_0, l_23_1)
	local l_23_2, l_23_5, l_23_6, l_23_7, l_23_8, l_23_9, l_23_10, l_23_11, l_23_12 = nil
	for i_0,i_1 in pairs(l_23_1._threat_tracking._threats) do
		if i_1:damage() > 0 and i_1:last_known_position() and (not l_23_2 or l_23_2:damage() < i_1:damage()) then
			l_23_2 = i_1
		end
	end
	return l_23_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiBehavior._evaluate_hide_from_threat = function(l_24_0, l_24_1)
	if l_24_0:_ignore_threats(l_24_1) then
		return false
	end
	local l_24_2 = l_24_0:_get_most_dangerous_threat(l_24_1)
	if l_24_2 then
		local l_24_3 = l_24_1._behavior._most_dangerous_threat.damage
		l_24_1._behavior._most_dangerous_threat.damage = l_24_2:damage()
		l_24_1._behavior._most_dangerous_threat.threat = l_24_2
		if l_24_3 < l_24_2:damage() then
			return true
		end
	else
		l_24_1._behavior._most_dangerous_threat.damage = 0
		l_24_1._behavior._most_dangerous_threat.threat = nil
	end
	return false
end

CommonAiBehavior._ignore_threats = function(l_25_0, l_25_1)
	local l_25_2 = l_25_1._behavior.arrive_orders
	if not l_25_2 then
		return false
	end
	return l_25_2.threat_mode == "ignore"
end

CommonAiBehavior._fight_threats = function(l_26_0, l_26_1)
	local l_26_2 = l_26_1._behavior.arrive_orders
	if not l_26_2 then
		return true
	end
	return l_26_2.threat_mode == "attack"
end

CommonAiBehavior._use_covers = function(l_27_0, l_27_1)
	if not l_27_1.use_covers then
		return false
	end
	local l_27_2 = l_27_1._behavior.arrive_orders
	if not l_27_2 then
		return true
	end
	return l_27_2.use_covers
end


