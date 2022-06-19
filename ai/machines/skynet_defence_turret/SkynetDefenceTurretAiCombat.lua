if not SkynetDefenceTurretAiCombat then
	SkynetDefenceTurretAiCombat = class()
end
SkynetDefenceTurretAiCombat.init_data = function(l_1_0, l_1_1)
	l_1_1._combat = {}
end

SkynetDefenceTurretAiCombat.logic_skynet_defence_turret_combat_init = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	l_2_0._start_time = l_2_1
	return 0
end

SkynetDefenceTurretAiCombat.logic_skynet_defence_turret_combat_passive = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	local l_3_8 = l_3_2:ai_data()
	if #l_3_8.input.forced_target_units > 0 and l_3_8.input.attack_delay < l_3_1 - l_3_0._start_time then
		return 0
	end
	l_3_8.output.allowed_to_fire = false
	return nil
end

SkynetDefenceTurretAiCombat.logic_skynet_defence_turret_combat_forced_targets = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	local l_4_9 = l_4_0:_closest_target(l_4_2, l_4_8.input.forced_target_units)
	if l_4_9 then
		local l_4_10 = nil
		local l_4_11 = l_4_9:targeting_info()
		if l_4_11 then
			l_4_10 = l_4_11:primary_target_position()
		else
			local l_4_12 = l_4_9:oobb()
			l_4_10 = l_4_12:center()
		end
		local l_4_13 = l_4_8.input.attack_range
		local l_4_14 = l_4_8.input.attack_range
		local l_4_15 = l_4_2:get_object(SkynetDefenceTurretBase._CENTER_OBJECT_NAME):position() - l_4_2:position()
		local l_4_16 = IntelUtilities.have_line_of_fire(l_4_2, l_4_14, l_4_8.UNIT_WEAPONS, l_4_9, l_4_10, l_4_15, l_4_8.LINE_OF_FIRE_SLOT_MASK, l_4_8.FRIENDLY_UNITS_SLOT_MASK)
	if l_4_16 then
		end
		l_4_8.output.firing_target = l_4_9
		l_4_8.output.firing_target_position = l_4_10
		l_4_8.output.allowed_to_fire = true
		return nil
	end
	l_4_8.output.allowed_to_fire = false
	return nil
end

SkynetDefenceTurretAiCombat._targets_alive_cnt = function(l_5_0, l_5_1)
	local l_5_6, l_5_7 = nil
	local l_5_2 = 0
	for i_0,i_1 in ipairs(l_5_1) do
		if alive(i_1) then
			l_5_2 = l_5_2 + 1
		end
	end
	return l_5_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SkynetDefenceTurretAiCombat._closest_target = function(l_6_0, l_6_1, l_6_2)
	local l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15 = nil
	local l_6_3 = (l_6_1:ai_data())
	local l_6_4 = nil
	for i_0,i_1 in pairs(l_6_2) do
		if alive(i_1) then
			if not l_6_4 then
				l_6_4 = i_1
			end
		else
			if i_1:position() - l_6_1:position():length() < l_6_4:position() - l_6_1:position():length() then
				l_6_4 = i_1
			end
		end
	end
	return l_6_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


