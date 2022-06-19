if not CommonAiTargeting then
	CommonAiTargeting = class()
end
CommonAiTargeting.init_data = function(l_1_0, l_1_1)
	l_1_1._targeting = {}
	l_1_1._targeting.currently_targeted_threat = nil
	l_1_1._targeting.current_secondary_threats = nil
end

CommonAiTargeting.logic_common_targeting_main = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = l_2_2:ai_data()
	l_2_0:_set_targets(l_2_2)
	if Global.category_debug_render["ai.target"] then
		l_2_0:_debug_render(l_2_2, l_2_8)
	end
	return nil
end

CommonAiTargeting._debug_render = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = Global.category_debug_render["ai.target"]
	local l_3_4 = l_3_1:position()
	local l_3_5 = true
	if l_3_3 ~= true and l_3_1:name() ~= l_3_3 then
		l_3_5 = false
	end
	if l_3_5 then
		local l_3_6 = Draw:brush()
		l_3_6:set_persistance(0.5)
		if l_3_2._targeting.currently_targeted_threat then
			local l_3_7 = l_3_2._targeting.currently_targeted_threat
			assert(l_3_7:last_known_direction())
			local l_3_8 = l_3_7:last_known_position()
			if not l_3_8 then
				assert(l_3_7:last_known_direction())
				l_3_8 = l_3_4 + l_3_7:last_known_direction() * 500
			end
			local l_3_12, l_3_13 = l_3_6:line, l_3_6
			local l_3_14 = l_3_4 + Vector3(0, 0, 100)
			l_3_12(l_3_13, l_3_14, l_3_4 + (l_3_8 - l_3_4) * 0.75, 10)
		end
	if l_3_2._targeting.current_secondary_threats then
		end
		for i_0,i_1 in pairs(l_3_2._targeting.current_secondary_threats) do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_3_15 == 1 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_3_17 = nil
			if not l_3_16:last_known_position() then
				assert(l_3_16:last_known_direction())
			end
			l_3_6:set_color(l_3_17)
			l_3_6:line(l_3_4 + Vector3(0, 0, 100), l_3_4 + (l_3_4 + l_3_16:last_known_direction() * 500 - l_3_4) * 0.75, nil)
		end
	end
end

CommonAiTargeting._set_targets = function(l_4_0, l_4_1)
	local l_4_2 = l_4_1:ai_data()
	l_4_0:_set_primary_target(l_4_1)
	if l_4_2.NUMBER_OF_SECONDARY_TARGETS and l_4_2.NUMBER_OF_SECONDARY_TARGETS > 0 then
		l_4_0:_set_secondary_targets(l_4_1)
	else
		l_4_2._targeting.current_secondary_threats = nil
	end
end

CommonAiTargeting._set_primary_target = function(l_5_0, l_5_1)
	local l_5_2 = l_5_1:ai_data()
	local l_5_3 = l_5_2._threat_tracking._threats
	if TableAlgorithms.is_empty(l_5_3) then
		l_5_2._targeting.currently_targeted_threat = nil
		return 
	end
	if l_5_2._targeting.currently_targeted_threat and not l_5_2._targeting.currently_targeted_threat:is_valid() then
		l_5_2._targeting.currently_targeted_threat = nil
	end
	local l_5_4 = nil
	local l_5_5 = l_5_2.threat_constants.primary_weights
	local l_5_6 = function(l_6_0)
		local l_6_1, l_6_2 = l_6_0:primary_target_priority, l_6_0
		return l_6_1(l_6_2)
  end
	local l_5_10 = l_5_0:_is_targetable
	local l_5_11 = l_5_0
	l_5_10 = l_5_10(l_5_11, l_5_2._targeting.currently_targeted_threat, l_5_1, l_5_5, l_5_6)
	if l_5_10 then
		l_5_10 = l_5_2._targeting
		l_5_4 = l_5_10.currently_targeted_threat
	end
	l_5_10 = pairs
	l_5_11 = l_5_3
	l_5_10 = l_5_10(l_5_11)
	for i_0,i_1 in l_5_10 do
		if l_5_0:_is_targetable(l_5_9, l_5_1, l_5_5, l_5_6, nil, l_5_4) and l_5_9 ~= l_5_4 and (not l_5_4 or l_5_0:_compare_primary(l_5_9, l_5_4, l_5_2)) then
			l_5_4 = l_5_9
		end
	end
	l_5_2._targeting.currently_targeted_threat = l_5_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiTargeting._set_secondary_targets = function(l_6_0, l_6_1)
	local l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16 = nil
	local l_6_2 = l_6_1:ai_data()
	local l_6_3 = {}
	local l_6_4 = l_6_2.threat_constants.secondary_weights
	local l_6_5 = function(l_7_0)
		local l_7_1, l_7_2 = l_7_0:secondary_target_priority, l_7_0
		return l_7_1(l_7_2)
  end
	for i_0,i_1 in pairs(l_6_2._threat_tracking._threats) do
		if l_6_0:_is_targetable(i_1, l_6_1, l_6_4, l_6_5, nil, l_6_2._targeting.currently_targeted_threat) and l_6_24 ~= l_6_2._targeting.currently_targeted_threat then
			local l_6_21, l_6_23 = table.insert, l_6_3
			l_6_21(l_6_23, l_6_24)
		end
	end
	table.sort(l_6_3, function(l_8_0, l_8_1)
		-- upvalues: l_6_2
		return CommonAiTargeting._secondary_threat_priority(l_8_1, l_6_2) < CommonAiTargeting._secondary_threat_priority(l_8_0, l_6_2)
  end)
	l_6_2._targeting.current_secondary_threats = {}
	for i = 1, l_6_2.NUMBER_OF_SECONDARY_TARGETS do
		for i_0,i_1 in ipairs(l_6_3) do
			if l_6_0:_is_targetable(i_1, l_6_1, l_6_4, l_6_5, l_6_17, l_6_2._targeting.currently_targeted_threat) then
				l_6_2._targeting.current_secondary_threats[l_6_17] = i_1
				l_6_17 = l_6_17 + 1
		else
			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiTargeting._is_targetable = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5, l_7_6)
	if not l_7_1 then
		return false
	end
	local l_7_16, l_7_17, l_7_18, l_7_19 = alive, l_7_1:unit(), .end
	l_7_16 = l_7_16(l_7_17, l_7_18, l_7_19)
	if l_7_16 then
		l_7_16, l_7_17 = l_7_1:unit_dead, l_7_1
		l_7_16 = l_7_16(l_7_17)
		l_7_16 = not l_7_16
	if not l_7_16 then
		end
		l_7_17 = false
		return l_7_17
	end
	l_7_16, l_7_17 = l_7_1:unit_associated, l_7_1
	l_7_16 = l_7_16(l_7_17)
	if l_7_16 then
		l_7_16 = l_7_4
		l_7_17 = l_7_1
		l_7_16 = l_7_16(l_7_17)
		l_7_17 = tweak_data
		l_7_17 = l_7_17.ai
		l_7_17 = l_7_17.UNIT_THREAT_MIN_VALUE
		if l_7_16 < l_7_17 then
			l_7_17 = false
			return l_7_17
		end
	elseif not l_7_6 then
		l_7_16 = l_7_4
		l_7_17 = l_7_1
		l_7_16 = l_7_16(l_7_17)
		l_7_17 = tweak_data
		l_7_17 = l_7_17.ai
		l_7_17 = l_7_17.NON_UNIT_THREAT_MIN_VALUE
	if l_7_16 < l_7_17 then
		end
		l_7_17 = false
		return l_7_17
	end
	l_7_16 = l_7_3.FIRING_ARC_INFO
	if l_7_16 then
		l_7_16 = nil
		local l_7_7 = nil
		l_7_17, l_7_18 = l_7_1:last_known_position, l_7_1
		l_7_17 = l_7_17(l_7_18)
		if l_7_17 then
			l_7_17, l_7_18 = l_7_1:last_known_position, l_7_1
			l_7_17 = l_7_17(l_7_18)
			l_7_18, l_7_19 = l_7_2:position, l_7_2
			l_7_18 = l_7_18(l_7_19)
			l_7_16 = l_7_17 - l_7_18
		else
			l_7_17, l_7_18 = l_7_1:last_known_direction, l_7_1
			l_7_17 = l_7_17(l_7_18)
			l_7_16 = l_7_17
		end
		l_7_17 = IntelUtilities
		l_7_17 = l_7_17.orientation_object_info
		l_7_18, l_7_19 = l_7_2:get_object, l_7_2
		l_7_7 = l_7_3.FIRING_ARC_ORIENTATION_OBJECT
		l_7_18 = l_7_18(l_7_19, l_7_7)
		l_7_19 = l_7_3.FIRING_ARC_ORIENTATION_OBJECT_AXIS
		l_7_17 = l_7_17(l_7_18, l_7_19)
		local l_7_8, l_7_9 = nil
		l_7_19, l_7_7 = l_7_16:to_polar_with_reference, l_7_16
		l_7_8 = 
		l_7_9 = math
		l_7_9 = l_7_9.UP
		l_7_19 = l_7_19(l_7_7, l_7_8, l_7_9)
		local l_7_10 = nil
		if l_7_5 then
			l_7_7 = l_7_3.FIRING_ARC_INFO
			l_7_7 = l_7_7[l_7_5]
			local l_7_11 = nil
			l_7_8, l_7_9 = l_7_0:_within_firing_arc, l_7_0
			local l_7_12, l_7_13 = nil
			l_7_10 = l_7_7
			local l_7_14 = nil
			l_7_11 = l_7_19
			local l_7_15 = nil
			return l_7_8(l_7_9, l_7_10, l_7_11)
		else
			l_7_7 = ipairs
			l_7_8 = l_7_3.FIRING_ARC_INFO
			l_7_7 = l_7_7(l_7_8)
			for l_7_10,i_1 in l_7_7 do
				if l_7_0:_within_firing_arc(i_1, l_7_19) then
					return true
				end
			end
			return false
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_7_16 = true
		return l_7_16
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CommonAiTargeting._within_firing_arc = function(l_8_0, l_8_1, l_8_2)
	return math.abs(-l_8_2.spin + l_8_1.CENTER_ANGLE) < l_8_1.HALF_FOV and math.abs(l_8_2.pitch) < l_8_1.HALF_ZFOV
end

CommonAiTargeting._compare_primary = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_5 = l_9_1:primary_target_priority()
	local l_9_6 = l_9_2:primary_target_priority()
	if l_9_1 == l_9_3._targeting.currently_targeted_threat then
		l_9_5 = l_9_5 * l_9_3.threat_constants.primary_weights.SAME_TARGET_FACTOR
		do
			local l_9_4 = nil
			l_9_6 = l_9_6 * l_9_4.CHANGE_TARGET_FACTOR
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		if l_9_2 == l_9_3._targeting.currently_targeted_threat then
			l_9_5 = l_9_5 * l_9_4.CHANGE_TARGET_FACTOR
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_9_6 = l_9_6 * l_9_4.SAME_TARGET_FACTOR
		end
	end
	return l_9_6 < l_9_5
end

CommonAiTargeting._secondary_threat_priority = function(l_10_0, l_10_1)
	if not l_10_1._targeting.current_secondary_threats or #l_10_1._targeting.current_secondary_threats == 0 then
		return l_10_0:primary_target_priority()
	end
	if l_10_1._targeting.current_secondary_threats and TableAlgorithms.find_value(l_10_0, l_10_1._targeting.current_secondary_threats) then
		do return end
	end
	do
		local l_10_2 = l_10_0:primary_target_priority() * l_10_1.threat_constants.secondary_weights.SAME_TARGET_FACTOR * l_10_1.threat_constants.secondary_weights.CHANGE_TARGET_FACTOR
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_10_2
end


