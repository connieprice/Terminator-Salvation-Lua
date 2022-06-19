if not HunterKillerAiCombat then
	HunterKillerAiCombat = class()
end
HunterKillerAiCombat.init_data = function(l_1_0, l_1_1)
	l_1_1._combat = {}
	l_1_1._combat.forced_attacks = {}
	l_1_1._combat.forced_attack_cnt = {}
	l_1_1._combat.forced_attack_start = {}
end

HunterKillerAiCombat.logic_hk_combat_init = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	return 0
end

HunterKillerAiCombat.logic_hk_combat_passive = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	local l_3_8 = l_3_2:ai_data()
	if #l_3_8.input.forced_attacks[1] > 0 or #l_3_8.input.forced_attacks[2] > 0 then
		l_3_8._combat.forced_attacks[1] = l_3_0:_get_forced_attacks(l_3_2, 1)
		l_3_8._combat.forced_attacks[2] = l_3_0:_get_forced_attacks(l_3_2, 2)
		l_3_8._combat.forced_attack_cnt[1] = 1
		l_3_8._combat.forced_attack_cnt[2] = 1
		return 0
	end
	l_3_8.output.firing_target_position = {}
	l_3_8.output.firing_target_unit = {}
	l_3_8.output.allowed_to_fire[1] = false
	l_3_8.output.allowed_to_fire[2] = false
	return nil
end

HunterKillerAiCombat.logic_hk_combat_forced_fire = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	if l_4_8.input.override_previous_forced_attacks then
		l_4_8.input.override_previous_forced_attacks = false
		return 0
	end
	if #l_4_8.input.forced_attacks[1] > 0 then
		l_4_0:_hk_combat_forced_fire(l_4_2, l_4_1, 1)
	end
	if #l_4_8.input.forced_attacks[2] > 0 then
		l_4_0:_hk_combat_forced_fire(l_4_2, l_4_1, 2)
	end
	if #l_4_8.input.forced_attacks[1] == 0 and #l_4_8.input.forced_attacks[2] == 0 then
		l_4_8.output.allowed_to_fire[1] = false
		l_4_8.output.allowed_to_fire[2] = false
		return 0
	end
	return nil
end

HunterKillerAiCombat.logic_hk_combat_fire = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5, l_5_6, l_5_7)
	return nil
	 -- WARNING: undefined locals caused missing assignments!
end

HunterKillerAiCombat._hk_combat_forced_fire = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = l_6_1:ai_data()
	l_6_0:_update_forced_attack_rounds(l_6_1, l_6_2, l_6_4.input.forced_target_selection, l_6_3)
	if #l_6_4.input.forced_attacks[l_6_3] == 0 then
		l_6_4.output.allowed_to_fire[l_6_3] = false
		return 
	end
	if l_6_4._combat.forced_attack_cnt[l_6_3] % 2 == 0 then
		l_6_4.output.allowed_to_fire[l_6_3] = false
		return 
	end
	if (not l_6_4.output.firing_target_unit[l_6_3] and not l_6_4.output.firing_target_position[l_6_3]) or not alive(l_6_4.output.firing_target_unit[l_6_3]) then
		l_6_0:_update_forced_attack_target(l_6_1, l_6_2, l_6_4.input.forced_target_selection, l_6_3)
	end
	if not l_6_4.output.firing_target_unit[l_6_3] and not l_6_4.output.firing_target_position[l_6_3] then
		l_6_4.output.allowed_to_fire[l_6_3] = false
		return 
	end
	if #l_6_4._combat.forced_attacks[l_6_3] > 0 then
		l_6_4.output.allowed_to_fire[l_6_3] = true
	else
		l_6_4.output.allowed_to_fire[l_6_3] = false
	end
end

HunterKillerAiCombat._get_forced_attacks = function(l_7_0, l_7_1, l_7_2)
	local l_7_9, l_7_10, l_7_11, l_7_12 = nil
	local l_7_3 = l_7_1:ai_data()
	if string.sub(l_7_3.input.forced_target_selection, 1, 11) == "[locations]" then
		local l_7_4 = {}
		if #l_7_3.input.forced_attacks[l_7_2] > 0 then
			local l_7_5 = l_7_3.input.forced_target_locations[l_7_2]
			for i_0,i_1 in ipairs(l_7_5) do
				table.insert(l_7_4, l_7_3.input.forced_attacks[l_7_2][1])
				table.insert(l_7_4, l_7_3.input.forced_attacks[l_7_2][2])
			end
		end
		return l_7_4
	else
		return l_7_3.input.forced_attacks[l_7_2]
	end
end

HunterKillerAiCombat._update_forced_attack_rounds = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
	local l_8_5 = l_8_1:ai_data()
	if l_8_5._combat.forced_attack_cnt[l_8_4] <= #l_8_5._combat.forced_attacks[l_8_4] then
		if not l_8_5._combat.forced_attack_start[l_8_4] then
			l_8_5._combat.forced_attack_start[l_8_4] = l_8_2
		end
		local l_8_6 = tonumber(l_8_5._combat.forced_attacks[l_8_4][l_8_5._combat.forced_attack_cnt[l_8_4]])
		local l_8_7 = l_8_5._combat.forced_attack_start[l_8_4] + l_8_6
	if l_8_7 < l_8_2 then
		end
		l_8_5._combat.forced_attack_cnt[l_8_4] = l_8_5._combat.forced_attack_cnt[l_8_4] + 1
		l_8_5._combat.forced_attack_start[l_8_4] = nil
		l_8_5.output.firing_target_unit[l_8_4] = nil
		l_8_5.output.firing_target_position[l_8_4] = nil
	if #l_8_5._combat.forced_attacks[l_8_4] < l_8_5._combat.forced_attack_cnt[l_8_4] then
		end
		l_8_5.input.forced_attacks[l_8_4] = {}
	end
end

HunterKillerAiCombat._update_forced_attack_target = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4)
	local l_9_5 = (l_9_1:ai_data())
	local l_9_6, l_9_7 = nil, nil
	if l_9_3 == "[units] top to bottom" then
		l_9_6 = l_9_0:_get_top_priority_target(l_9_1, l_9_4)
	elseif l_9_3 == "[units] closest" then
		l_9_6 = l_9_0:_get_closest_target(l_9_1, l_9_4)
	elseif l_9_3 == "[units] random" then
		l_9_6 = l_9_0:_get_random_target(l_9_1, l_9_4)
	elseif l_9_3 == "[locations] index order" then
		l_9_7 = l_9_0:_get_top_priority_location_target(l_9_1, l_9_2, l_9_4)
	elseif l_9_3 == "[locations] random" then
		l_9_7 = l_9_0:_get_random_location_target(l_9_1, l_9_2, l_9_4)
	end
	l_9_5.output.firing_target_unit[l_9_4] = l_9_6
	l_9_5.output.firing_target_position[l_9_4] = l_9_7
end

HunterKillerAiCombat._get_top_priority_target = function(l_10_0, l_10_1, l_10_2)
	local l_10_7, l_10_8, l_10_9, l_10_10 = nil
	local l_10_3 = l_10_1:ai_data()
	for i_0,i_1 in pairs(l_10_3.input.forced_target_units[l_10_2]) do
		if alive(i_1) then
			return i_1
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

HunterKillerAiCombat._get_closest_target = function(l_11_0, l_11_1, l_11_2)
	local l_11_11, l_11_12, l_11_13, l_11_14, l_11_15, l_11_16, l_11_17, l_11_18 = nil
	local l_11_3 = (l_11_1:ai_data())
	local l_11_4, l_11_5, l_11_6 = nil, nil, nil
	local l_11_7 = l_11_1:position()
	for i_0,i_1 in pairs(l_11_3.input.forced_target_units[l_11_2]) do
		if alive(i_1) then
			if not l_11_4 then
				l_11_4 = i_1
			end
		else
			l_11_6 = mvector3.distance(i_1:position(), l_11_7)
			l_11_5 = mvector3.distance(l_11_4:position(), l_11_7)
		if l_11_6 < l_11_5 then
			end
			l_11_4 = i_1
		end
	end
	return l_11_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

HunterKillerAiCombat._get_random_target = function(l_12_0, l_12_1, l_12_2)
	local l_12_8, l_12_9, l_12_10, l_12_11, l_12_12, l_12_13 = nil
	local l_12_3 = l_12_1:ai_data()
	local l_12_4 = {}
	for i_0,i_1 in pairs(l_12_3.input.forced_target_units[l_12_2]) do
		if alive(i_1) then
			table.insert(l_12_4, i_1)
		end
	end
	if #l_12_4 > 0 then
		return l_12_4[1 + math:random(#l_12_4 - 1)]
	else
		return nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

HunterKillerAiCombat._get_top_priority_location_target = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_4 = l_13_1:ai_data()
	local l_13_5 = math.ceil(l_13_4._combat.forced_attack_cnt[l_13_3] / 2)
	if l_13_4.input.forced_target_locations[l_13_3][l_13_5] then
		return l_13_4.input.forced_target_locations[l_13_3][l_13_5].position
	else
		return nil
	end
end

HunterKillerAiCombat._get_random_location_target = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_4 = l_14_1:ai_data()
	local l_14_5 = 1 + math:random(#l_14_4.input.forced_target_locations[l_14_3] - 1)
	if l_14_4.input.forced_target_locations[l_14_3][l_14_5] then
		return l_14_4.input.forced_target_locations[l_14_3][l_14_5].position
	else
		return nil
	end
end


