if not CommonAiCombat then
	CommonAiCombat = class()
end
CommonAiCombat.init_data = function(l_1_0, l_1_1)
	l_1_1._combat = {}
	l_1_1.output.secondary_weapon_firing_target = nil
	l_1_1.output.secondary_weapon_firing_target_position = nil
	l_1_1.output.secondary_weapon_allowed_to_fire = nil
	l_1_1._combat._select_firing_targets = CommonAiCombat._standard_select_firing_targets
end

CommonAiCombat.logic_common_combat_passive_enter = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = l_2_2:ai_data()
	l_2_4.output.detected_threat = false
end

CommonAiCombat.logic_common_combat_passive = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	local l_3_8 = l_3_2:ai_data()
	if l_3_0:_has_threat(l_3_8) then
		l_3_8.output.detected_threat = true
		return 0
	end
	l_3_8.output.allowed_to_fire = false
	l_3_8.output.firing_target = nil
	l_3_8.output.firing_target_position = nil
	l_3_8.output.currently_targeted_threat = nil
	l_3_0:_check_hide_in_cover(l_3_8, false)
	return nil, true
end

CommonAiCombat.logic_common_combat_alerted = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	if not l_4_0:_has_threat(l_4_8) then
		return 0
	end
	if l_4_8._behavior.allowed_to_fire and l_4_0:_direct_fire_possible(l_4_8) then
		return 1
	end
	if l_4_8._behavior.allowed_to_fire then
		l_4_8._combat._select_firing_targets(l_4_2, l_4_8, l_4_1, false)
	else
		local l_4_9 = l_4_8.output
		l_4_9.firing_target = nil
		l_4_9.firing_target_position = nil
		l_4_9.allowed_to_fire = false
		l_4_9.secondary_weapon_firing_target = nil
		l_4_9.secondary_weapon_firing_target_position = nil
		l_4_9.secondary_weapon_allowed_to_fire = false
	end
	l_4_8.output.currently_targeted_threat = l_4_8._targeting.currently_targeted_threat
	local l_4_10 = l_4_8.output.firing_target
	if alive(l_4_10) and l_4_10:ai_data() and l_4_10:ai_data().output.unaware then
		ai_data_output.allowed_to_fire = false
	end
	l_4_0:_check_hide_in_cover(l_4_8, false)
	return nil, true
end

CommonAiCombat._standard_select_firing_targets = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_4 = l_5_1.output
	local l_5_5 = l_5_1._targeting.currently_targeted_threat
	if not l_5_3 then
		local l_5_6 = l_5_5:last_seen_position()
		local l_5_7 = false
		if l_5_6 and l_5_1._targeting.current_secondary_threats and #l_5_1._targeting.current_secondary_threats > 0 then
			l_5_7 = IntelUtilities:within_eye_fov(l_5_1.current_unit_eyes[1], l_5_6)
		end
		if l_5_7 then
			local l_5_8 = l_5_1._targeting.current_secondary_threats[1]
			if l_5_8:unit_line_of_fire() then
				l_5_4.firing_target = l_5_8:unit()
				l_5_4.firing_target_position = nil
				l_5_4.allowed_to_fire = true
			else
				local l_5_9 = CommonAiCombat._threat_firing_position(l_5_0:position(), l_5_8)
				l_5_4.firing_target = nil
				l_5_4.firing_target_position = l_5_9
				l_5_4.allowed_to_fire = IntelUtilities.ai_have_position_line_of_fire(l_5_0, l_5_9, nil, 200)
			end
		else
			local l_5_10 = CommonAiCombat._threat_firing_position(l_5_0:position(), l_5_5)
		if l_5_10 then
			end
			l_5_4.firing_target = nil
			l_5_4.firing_target_position = l_5_10
			l_5_4.allowed_to_fire = IntelUtilities.ai_have_position_line_of_fire(l_5_0, l_5_10, nil, 200)
		end
	else
		l_5_4.firing_target = l_5_5:unit()
		l_5_4.firing_target_position = nil
		l_5_4.allowed_to_fire = true
	end
end

CommonAiCombat._threat_firing_position = function(l_6_0, l_6_1)
	local l_6_2 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_1:last_seen_position() then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_1:last_known_position() then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_6_2
end

CommonAiCombat.logic_common_combat_fighting = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5, l_7_6, l_7_7)
	local l_7_8 = l_7_2:ai_data()
	if not l_7_8._behavior.allowed_to_fire then
		return 0
	end
	if not l_7_0:_has_threat(l_7_8) then
		return 0
	end
	if not l_7_0:_direct_fire_possible(l_7_8) then
		return 0
	end
	l_7_8._combat._select_firing_targets(l_7_2, l_7_8, l_7_1, true)
	l_7_8.output.currently_targeted_threat = l_7_8._targeting.currently_targeted_threat
	local l_7_9 = l_7_8.output.firing_target
	if alive(l_7_9) and l_7_9:ai_data() and l_7_9:ai_data().output.unaware then
		l_7_8.output.allowed_to_fire = false
	end
	l_7_0:_check_hide_in_cover(l_7_8, true)
	return nil, true
end

CommonAiCombat._direct_fire_possible = function(l_8_0, l_8_1)
	if l_8_1._targeting.currently_targeted_threat:unit_line_of_sight() then
		return l_8_1._targeting.currently_targeted_threat:unit_line_of_fire()
	end
end

CommonAiCombat._check_hide_in_cover = function(l_9_0, l_9_1, l_9_2)
	if not l_9_1._behavior.use_covers then
		l_9_1.output.hide_in_cover = false
		l_9_1._combat.hide_in_cover_time = nil
		l_9_1._combat.time_until_hide_in_cover = nil
		return 
	end
	if l_9_1._movement._current_go_to then
		l_9_1.output.hide_in_cover = true
		return 
	end
	if l_9_1._behavior.arrive_orders and l_9_1._behavior.arrive_orders.threat_mode == "ignore" then
		l_9_1.output.hide_in_cover = true
		return 
	end
	local l_9_3 = l_9_1.output.currently_targeted_threat
	if l_9_1.input.time_since_incoming_fire > 5 and l_9_3 and alive(l_9_3:unit()) and l_9_3:unit():ai_data() and l_9_3:unit():ai_data().output.unaware then
		l_9_1.output.hide_in_cover = true
		return 
	end
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_9_1.output.hide_in_cover and l_9_1.input.time_since_incoming_fire > 0 then
		if not l_9_1._combat.hide_in_cover_time then
			local l_9_4 = iff(l_9_2, tweak_data.ai.humans.ai_player.TIME_HIDING_IN_COVER_AFTER_FIRED_ON_WITH_TARGET, tweak_data.ai.humans.ai_player.TIME_HIDING_IN_COVER_AFTER_FIRED_ON_WITHOUT_TARGET)
			l_9_1._combat.hide_in_cover_time = math.rand(l_9_4[1], l_9_4[2])
		end
	if l_9_1._combat.hide_in_cover_time < l_9_1.input.time_since_incoming_fire then
		end
		l_9_1.output.hide_in_cover = false
		l_9_1._combat.hide_in_cover_time = nil
	end
	do return end
	if l_9_1.input.time_under_incoming_fire > 0 then
		if not l_9_1._combat.time_until_hide_in_cover then
			local l_9_5 = iff
			local l_9_6 = l_9_2
			local l_9_7 = tweak_data.ai.humans.ai_player.TIME_UNTIL_HIDING_IN_COVER_WHEN_FIRED_ON
			local l_9_8 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_9_6.time_until_hide_in_cover < l_9_5.time_under_incoming_fire then
		end
	end
	 -- WARNING: undefined locals caused missing assignments!
end

CommonAiCombat._has_threat = function(l_10_0, l_10_1)
	if l_10_1._behavior.allowed_to_target then
		return l_10_1._targeting.currently_targeted_threat
	end
end

CommonAiCombat._debug_render = function(l_11_0, l_11_1)
	local l_11_2 = l_11_1:ai_data()
	local l_11_3 = Draw:brush()
	l_11_3:set_persistance(0.5)
	local l_11_4 = nil
	if alive(l_11_2.output.firing_target) then
		l_11_4 = l_11_2.output.firing_target:position()
	else
		if l_11_2.output.firing_target_position then
			l_11_4 = l_11_2.output.firing_target_position
		end
	else
		if l_11_2._targeting.currently_targeted_threat then
			l_11_4 = l_11_2._targeting.currently_targeted_threat:last_known_position()
			l_11_3:line(l_11_4, l_11_1:position() + Vector3(0, 0, 200), 10, Vector3(1, 0, 0))
			l_11_3:line(l_11_4, l_11_1:position() + Vector3(0, 0, 200), 10, Vector3(0, 1, 0))
			return 
		end
	else
		return 
	end
	if l_11_2.output.allowed_to_fire then
		l_11_3:set(Color(0, 1, 0))
	else
		l_11_3:set(Color(1, 0, 0))
	end
	l_11_3:line(l_11_4, l_11_1:position() + Vector3(0, 0, 200), 50, Vector3(1, 0, 0))
	l_11_3:line(l_11_4, l_11_1:position() + Vector3(0, 0, 200), 50, Vector3(0, 1, 0))
end


