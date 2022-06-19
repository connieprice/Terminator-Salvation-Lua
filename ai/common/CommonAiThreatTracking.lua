require("ai/common/CommonAiThreat")
require("ai/common/IntelUtilities")
require("ai/common/FindTargetsObject")
require("shared/TableAlgorithms")
require("shared/ClusterCalculator")
if not CommonAiThreatTracking then
	CommonAiThreatTracking = class()
end
CommonAiThreatTracking.EVENT_CORRELATION_THRESHOLD = 0.8
CommonAiThreatTracking.EVENT_CORRELATION_MAX_TIME = 3
CommonAiThreatTracking.MAX_NON_UNIT_THREATS = 3
CommonAiThreatTracking.init_data = function(l_1_0, l_1_1)
	l_1_1._threat_tracking = {}
	l_1_1._threat_tracking._threats = {}
	l_1_1._threat_tracking._new_threats_last_processed_time = 0
	l_1_1._threat_tracking._targets = {}
end

CommonAiThreatTracking.logic_common_threat_tracking_main = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = l_2_2:ai_data()
	local l_2_9 = l_2_8._threat_tracking
	local l_2_10 = l_2_0:_find_targets(l_2_2, l_2_8)
	l_2_0:_process_damages(l_2_1, l_2_9, l_2_8.input.buffered_damages, l_2_2)
	l_2_0:_purge_threats(l_2_1, l_2_9._threats, l_2_8)
	l_2_0:_process_events(l_2_1, l_2_9, l_2_8._sensory_data, l_2_2)
	l_2_0:_try_to_blame(l_2_2, l_2_8, l_2_9._threats, l_2_10)
	l_2_0:_scan_for_targets(l_2_2, l_2_8, l_2_9._threats, l_2_10, l_2_1)
	l_2_0:_update_unit_clusters(l_2_9._threats, l_2_8.threat_constants)
	l_2_0:_update_threats(l_2_9._threats, l_2_1)
	if Global.category_debug_render["ai.threat"] then
		l_2_0:_debug_render(l_2_2, l_2_8, l_2_9, Global.category_debug_render["ai.threat"])
	end
	l_2_8.output.has_threats = not TableAlgorithms.is_empty(l_2_9._threats)
	return nil
end

CommonAiThreatTracking._debug_render = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	local l_3_11, l_3_12 = nil
	if l_3_4 ~= true and l_3_1:name() ~= l_3_4 then
		return 
	end
	local l_3_5 = Draw:brush()
	l_3_5:set_persistance(1)
	local l_3_6 = Draw:brush()
	local l_3_10 = l_3_6:set_font
	l_3_10(l_3_6, "editor_font", 60)
	l_3_10(l_3_6, 1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_3_10 do
		local l_3_22, l_3_23 = nil, alive
		l_3_23 = l_3_23(l_3_13:unit())
		if l_3_23 then
			l_3_23 = Color
			l_3_23 = l_3_23(1, 0, 0)
			l_3_22 = l_3_23
		else
			l_3_23 = Color
			l_3_23 = l_3_23(1, 1, 0)
			l_3_22 = l_3_23
		end
		l_3_23(l_3_6, l_3_22, "OverlayVertexColorTextured")
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_23(l_3_5, l_3_22)
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_3_14 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_3_15 = nil
		l_3_15 = nil
		local l_3_16 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_3_16 then
			l_3_15 = l_3_16
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			l_3_15 = l_3_16 + Vector3(0, 0, 100)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_16(l_3_5, l_3_14, l_3_15, 50)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if ((not l_3_16 or l_3_16) and not l_3_16) or l_3_16 then
			local l_3_17 = nil
			l_3_17 = l_3_16
			local l_3_18 = nil
			l_3_18 = pairs
			l_3_18 = l_3_18(managers.sensory_events)
			for i_0,i_1 in l_3_18 do
				if i_1 == l_3_16 then
					l_3_17 = l_3_21
			else
				end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_17 = l_3_13
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_17 = l_3_23
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_3_17 = l_3_15 - l_3_14
		l_3_17 = (l_3_17) / 2
		l_3_17 = l_3_14 + l_3_17
		l_3_5:line(l_3_17, l_3_17 + Vector3(0, 0, 1) * l_3_16 * 500, 25, Vector3(1, 0, 0))
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_3_5:line(l_3_17, l_3_17 + Vector3(0, 0, 1) * l_3_16 * 500, 25, Vector3(0, 1, 0))
		l_3_6:center_text(l_3_14 + (l_3_15 - l_3_14) / 2 + Vector3(0, 0, 100), l_3_23)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_10(l_3_6, Color(1, 1, l_3_22), "OverlayVertexColorTextured")
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_6:center_text(l_3_1:position() + Vector3(0, l_3_22, l_3_23), "threats: " .. TableAlgorithms.count(l_3_22))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiThreatTracking._find_targets = function(l_4_0, l_4_1, l_4_2)
	if tweak_data.ai.USE_ASYNC_CASTS then
		if l_4_0:_vision_disabled(l_4_2) then
			return nil
		end
		if not l_4_2._find_targets then
			l_4_2._find_targets = FindTargetObject:new(l_4_1)
		end
		if l_4_2._find_targets:is_query_done() then
			local l_4_3 = l_4_2._find_targets:get_result()
			l_4_2._threat_tracking._targets = TableAlgorithms.copy(l_4_3)
			local l_4_7, l_4_8, l_4_9, l_4_10, l_4_15 = l_4_2._find_targets:start_query, l_4_2._find_targets, l_4_1:position(), .end
			l_4_7(l_4_8, l_4_9, l_4_10, l_4_15)
		end
		for i_0,i_1 in pairs(l_4_2._threat_tracking._targets) do
			if not alive(i_1) then
				l_4_2._threat_tracking._targets[l_4_17] = nil
			end
		end
		return l_4_2._threat_tracking._targets
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		local l_4_11 = nil
		local l_4_12 = nil
		local l_4_13 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		do
			local l_4_14 = nil
			return IntelUtilities.find_targets(l_4_1, l_4_11, l_4_12)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CommonAiThreatTracking._scan_for_targets = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5)
	local l_5_10, l_5_11, l_5_12, l_5_13, l_5_14, l_5_15, l_5_16, l_5_17, l_5_18, l_5_19 = nil
	if l_5_0:_vision_disabled(l_5_2) then
		return 
	end
	local l_5_6 = nil
	for i_0,i_1 in pairs(l_5_4) do
		if alive(i_1) then
			l_5_6 = i_1:key()
		if not l_5_3[l_5_6] then
			end
		if not i_1:damage_data():is_fully_damaged() then
			end
			local l_5_27, l_5_29, l_5_31, l_5_33 = , l_5_0:_new_threat(l_5_1, i_1):associate_unit, l_5_0:_new_threat(l_5_1, i_1)
			l_5_33 = l_5_25
			local l_5_26, l_5_28, l_5_30, l_5_32, l_5_34 = nil
			l_5_29(l_5_31, l_5_33)
			l_5_3[l_5_6] = l_5_27
		end
	end
	local l_5_21 = nil
	for i_0,i_1 in pairs(l_5_3) do
		do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_5_4[l_5_21] ~= nil or nil then
				do return end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			i_1:set_unit_line_of_sight(nil, l_5_5)
			i_1:set_unit_line_of_fire(false)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiThreatTracking._process_damages = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	local l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17 = nil
	for i_0,i_1 in pairs(l_6_3) do
		if not i_1:read() then
			i_1:set_read()
			l_6_0:_associate_threat(i_1, l_6_2._threats, l_6_4, l_6_1):set_last_time(l_6_1)
			l_6_0:_associate_threat(i_1, l_6_2._threats, l_6_4, l_6_1):set_last_damage_direction(i_1:direction())
			l_6_0:_associate_threat(i_1, l_6_2._threats, l_6_4, l_6_1):add_damage(i_1:damage())
		if i_1:damage() == 0 then
			end
			l_6_0:_associate_threat(i_1, l_6_2._threats, l_6_4, l_6_1):add_non_damage_agression()
		end
	end
end

CommonAiThreatTracking._associate_threat = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4)
	local l_7_5, l_7_10, l_7_11, l_7_12, l_7_13 = nil
	local l_7_6 = 0
	for i_0,i_1 in pairs(l_7_2) do
		local l_7_7 = 0.8
		if l_7_7 <= math.dot(l_7_1:direction(), i_1:last_known_direction()) and l_7_6 < math.dot(l_7_1:direction(), i_1:last_known_direction()) then
			l_7_6 = math.dot(l_7_1:direction(), i_1:last_known_direction())
			l_7_5 = i_1
		end
	end
	if l_7_5 then
		return l_7_5
	end
	do return end
	l_7_0:_new_threat(l_7_3):set_last_time(l_7_4)
	table.insert(l_7_2, l_7_0:_new_threat(l_7_3))
	l_7_0:_limit_max_non_unit_threats(l_7_2)
	return l_7_0:_new_threat(l_7_3)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiThreatTracking._purge_threats = function(l_8_0, l_8_1, l_8_2, l_8_3)
	TableAlgorithms.remove_if(l_8_2, function(l_9_0)
		-- upvalues: l_8_3 , l_8_1
		local l_9_1 = iff(l_9_0:unit(), l_8_3.TIME_TO_FORGET_THREATNING_UNIT, l_8_3.TIME_TO_FORGET_UNIDENTIFIED_THREAT)
		if l_9_1 < l_8_1 - l_9_0:last_time() then
			cat_print("ai", "discarding threat, last time " .. l_9_0:last_time())
		end
		local l_9_6 = nil
		if l_9_0:unit() and l_9_0:unit_dead() and true then
			cat_print("ai", "threat terminated")
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_9_6 or true then
			l_9_0:set_not_valid()
			return true
		else
			return false
		end
  end)
end

CommonAiThreatTracking._process_events = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4)
	l_9_0:_associate_events(l_9_1, l_9_2._threats, l_9_3, l_9_4)
	l_9_0:_find_new_threats_by_events(l_9_1, l_9_3, l_9_2, l_9_4)
end

CommonAiThreatTracking._associate_events = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4)
	local l_10_13, l_10_14, l_10_15, l_10_16, l_10_17, l_10_18 = nil
	if #l_10_3.memory == 0 or #l_10_2 == 0 then
		return 
	end
	local l_10_5 = l_10_4:position()
	local l_10_6 = l_10_4:ai_data().THREATENING_EVENT_SOURCE_TYPES
	local l_10_7, l_10_8, l_10_9 = nil, nil, nil
	for i_0,i_1 in pairs(l_10_3.memory) do
		l_10_7 = i_1.buffered_event.event
		if l_10_7:valid() and not i_1.threat_tracking_processed and l_10_6[l_10_7:source_type_id()] then
			local l_10_27 = nil
			l_10_8 = mvector3.copy(l_10_7:position())
			mvector3.subtract(l_10_8, l_10_5)
			mvector3.normalize(l_10_8)
			local l_10_20 = l_10_26.buffered_event
			local l_10_21, l_10_22 = nil, nil
			for i_0,i_1 in pairs(l_10_2) do
				if l_10_1 - i_1:last_time() < l_10_0.EVENT_CORRELATION_MAX_TIME and i_1:last_time() - l_10_20.event:start_time() < l_10_0.EVENT_CORRELATION_MAX_TIME then
					local l_10_30 = nil
				if l_10_0.EVENT_CORRELATION_THRESHOLD < mvector3.dot(l_10_8, i_1:last_known_direction()) and (not l_10_21 or l_10_22 < mvector3.dot(l_10_8, i_1:last_known_direction())) then
					end
					l_10_21 = l_10_29
					l_10_22 = mvector3.dot(l_10_8, i_1:last_known_direction())
				end
			end
		if l_10_21 then
			end
			if l_10_21:associated_event() then
				if l_10_21:associated_event().has_ended and not l_10_20.has_ended then
					do return end
				end
			end
			 -- DECOMPILER ERROR: unhandled construct in 'if'

			if l_10_21:associated_event().has_ended and l_10_20.has_ended and associated_event_sound_level < l_10_9 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if true then
				false(l_10_21, l_10_20)
				l_10_21:set_last_time(l_10_1)
			end
			l_10_26.threat_tracking_processed = true
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiThreatTracking._event_threat_correlated = function(l_11_0, l_11_1, l_11_2, l_11_3)
	if l_11_0.EVENT_CORRELATION_MAX_TIME < l_11_2:last_time() - l_11_1:start_time() then
		return false
	end
	local l_11_4 = mvector3.copy(l_11_1:position())
	mvector3.subtract(l_11_4, l_11_3)
	mvector3.normalize(l_11_4)
	local l_11_5 = mvector3.dot(l_11_4, l_11_2:last_known_direction())
	return l_11_0.EVENT_CORRELATION_THRESHOLD < l_11_5
end

CommonAiThreatTracking._find_new_threats_by_events = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4)
	local l_12_5, l_12_9, l_12_10, l_12_11, l_12_12, l_12_13, l_12_14 = nil
	for i_0,i_1 in pairs(l_12_2.memory) do
		local l_12_6 = l_12_3._threats
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if (l_12_5 and l_12_5 >= l_12_17.time_discovered) or l_12_4:ai_data().THREATENING_EVENT_SOURCE_TYPES[i_1.buffered_event.event:source_type_id()] then
			local l_12_18 = nil
		if not l_12_0:_can_find_threat_for_event(l_12_6, i_1.buffered_event.event, l_12_4:position()) then
			end
			local l_12_19 = nil
			l_12_0:_new_threat(l_12_4):associate_event(l_12_18)
			l_12_0:_new_threat(l_12_4):set_last_time(l_12_1)
			table.insert(l_12_6, l_12_0:_new_threat(l_12_4))
			l_12_0:_limit_max_non_unit_threats(l_12_6)
		end
	end
	if l_12_5 then
		l_12_3._new_threats_last_processed_time = l_12_5
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CommonAiThreatTracking._limit_max_non_unit_threats = function(l_13_0, l_13_1)
	local l_13_2, l_13_3, l_13_4, l_13_6, l_13_7, l_13_8, l_13_9, l_13_10, l_13_11, l_13_12, l_13_13, l_13_14 = nil, nil, nil
	for i_0,i_1 in pairs(l_13_1) do
		local l_13_5 = 0
		if not i_1:unit_associated() then
			l_13_5 = l_13_5 + 1
		if not l_13_3 or i_1:last_time() < l_13_4 then
			end
			l_13_2 = i_0
			l_13_3 = i_1
			l_13_4 = i_1:last_time()
		end
	end
	if l_13_0.MAX_NON_UNIT_THREATS < l_13_5 then
		l_13_3:set_not_valid()
		l_13_1[l_13_2] = nil
	end
end

CommonAiThreatTracking._can_find_threat_for_event = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_7, l_14_8 = nil
	for i_0,i_1 in pairs(l_14_1) do
		if l_14_0:_event_threat_correlated(l_14_2, i_1, l_14_3) then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiThreatTracking._try_to_blame = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4)
	local l_15_9, l_15_10, l_15_11, l_15_12, l_15_13, l_15_14, l_15_16, l_15_24, l_15_25, l_15_26, l_15_27 = nil
	if l_15_0:_vision_disabled(l_15_2) then
		return 
	end
	do
		local l_15_5 = {}
		for i_0,i_1 in pairs(l_15_3) do
			if not i_1:unit() then
				table.insert(l_15_5, i_1)
			end
		end
		if #l_15_5 > 0 then
			for i_0,i_1 in pairs(l_15_5) do
				local l_15_20 = nil
				for i_0,i_1 in pairs(l_15_4) do
					local l_15_21, l_15_22 = nil, nil
					 -- DECOMPILER ERROR: Overwrote pending register.

					if not l_15_19:associated_event() or 0.8 < (math.dot(l_15_19:last_known_direction(), i_1:position() - l_15_1:position():normalized())) then
						local l_15_32 = nil
						if not l_15_20 then
							do return end
						end
						 -- DECOMPILER ERROR: unhandled construct in 'if'

						if l_15_19:associated_event() and nil < l_15_22 then
							do return end
						if (math.dot(l_15_19:last_known_direction(), i_1:position() - l_15_1:position():normalized())) < l_15_21 then
							end
						end
					if true then
						end
						l_15_20 = l_15_31
						 -- DECOMPILER ERROR: Confused about usage of registers!

						l_15_22 = nil
						l_15_21 = (math.dot(l_15_19:last_known_direction(), i_1:position() - l_15_1:position():normalized()))
					end
				end
				if l_15_20 then
					l_15_19:associate_unit(l_15_20)
					if l_15_3[l_15_20:key()] then
						l_15_3[l_15_20:key()]:merge(l_15_19)
					else
						l_15_3[l_15_20:key()] = l_15_19
						l_15_3[l_15_18] = nil
						 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

					end
				end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CommonAiThreatTracking._new_threat = function(l_16_0, l_16_1)
	cat_print("ai", "New threat")
	return CommonAiThreat:new(function()
		-- upvalues: l_16_1
		return l_16_1:damage_data().health
  end, function()
		-- upvalues: l_16_1
		local l_18_0, l_18_1 = l_16_1:position, l_16_1
		return l_18_0(l_18_1)
  end, l_16_1:ai_data().threat_constants)
end

CommonAiThreatTracking._threat_position_function = function(l_17_0)
	local l_17_1, l_17_2 = l_17_0:last_known_position, l_17_0
	return l_17_1(l_17_2)
end

CommonAiThreatTracking._update_unit_clusters = function(l_18_0, l_18_1, l_18_2)
	local l_18_7, l_18_8, l_18_9, l_18_10, l_18_11, l_18_12, l_18_13, l_18_14, l_18_15, l_18_16, l_18_17, l_18_18 = nil
	if not l_18_2.ENABLE_UNIT_CLUSTERING then
		return 
	end
	local l_18_3 = {}
	for i_0,i_1 in pairs(l_18_1) do
		if alive(i_1:unit()) and l_18_33:last_known_position() then
			table.insert(l_18_3, l_18_33)
		end
		local l_18_19 = 0
		local l_18_20, l_18_24, l_18_25, l_18_26 = 0
		l_18_24, l_18_25 = l_18_33:set_cluster_info, l_18_33
		l_18_26 = l_18_19
		local l_18_30, l_18_32 = l_18_20
		l_18_24(l_18_25, l_18_26, l_18_30)
	end
	local l_18_23 = l_18_3
	ClusterCalculator:new():calculate(l_18_23, CommonAiThreatTracking._threat_position_function, tweak_data.ai.CLUSTERING_MAX_DISTANCE)
	ClusterCalculator:new():calculate_number_of_items()
	ClusterCalculator:new():calculate_spheres()
	for i_0,i_1 in ipairs(l_18_23) do
		for i_0,i_1 in pairs(i_1.items) do
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_18_27.radius > 0 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			i_1:set_cluster_info(l_18_27.number_of_items, nil)
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	CommonAiThreatTracking:_debug_render_clusters(ClusterCalculator:new():clusters())
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CommonAiThreatTracking._debug_render_clusters = function(l_19_0, l_19_1)
	if Global.category_debug_render["ai.cluster"] and l_19_1 then
		local l_19_2 = Draw:brush()
		l_19_2:set_persistance(1)
		local l_19_3 = Vector3(0, 0, 100)
		local l_19_4 = {}
		local l_19_9 = Color(1, 0, 0)
		local l_19_10 = Color(0, 1, 0)
		local l_19_15, l_19_16, l_19_21 = Color(0, 0, 1), Color(1, 1, 0), Color(0, 1, 1)
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		local l_19_5 = Color(1, 0, 1)
		 -- DECOMPILER ERROR: Overwrote pending register.

		for l_19_21,l_19_5 in l_19_10 do
			local l_19_6, l_19_7, l_19_8 = Color(0, 0, 0), Color(1, 1, 1), .end
			l_19_6 = #l_19_4
			l_19_6 = l_19_9 % l_19_6
			l_19_6 = l_19_6 + 1
			l_19_6 = l_19_4[l_19_6]
			local l_19_11 = nil
			l_19_7, l_19_8 = l_19_2:set_color, l_19_2
			l_19_11 = l_19_6
			l_19_7(l_19_8, l_19_11)
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_19_7 = pairs
			l_19_8 = l_19_5.items
			l_19_7 = l_19_7(l_19_8)
			for i_0,i_1 in l_19_7 do
				local l_19_14 = nil
				local l_19_20 = l_19_2
				l_19_14(l_19_20, l_19_13:last_known_position() + l_19_3, 50)
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_19_20 = l_19_5.items
				 -- DECOMPILER ERROR: Overwrote pending register.

				for i_0,i_1 in l_19_14 do
					if l_19_13 ~= l_19_19 then
						l_19_2:line(l_19_13:last_known_position() + l_19_3, l_19_19:last_known_position() + l_19_3, 10 + 10 * (l_19_9 + 1))
					end
					l_19_2:sphere(l_19_19:last_known_position() + l_19_3, 50)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			l_19_2:set_color(l_19_6:with_alpha(0.5))
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_19_2:sphere(l_19_5.center, math.max(l_19_5.radius, l_19_14))
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CommonAiThreatTracking._update_threats = function(l_20_0, l_20_1, l_20_2)
	local l_20_6, l_20_7, l_20_8, l_20_9 = nil
	for i_0,i_1 in pairs(l_20_1) do
		i_1:update(l_20_2)
	end
end

CommonAiThreatTracking._vision_disabled = function(l_21_0, l_21_1)
	return l_21_1.input.is_stunned or l_21_1.current_unit_eyes == nil
end


