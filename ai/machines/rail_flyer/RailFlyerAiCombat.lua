if not RailFlyerAiCombat then
	RailFlyerAiCombat = class()
end
RailFlyerAiCombat.init_data = function(l_1_0, l_1_1)
	l_1_1._combat = {}
	l_1_1._combat.targets = {}
	l_1_1._behavior = {}
	l_1_1._behavior.target = nil
	l_1_1._behavior.follow_target = false
	l_1_1._behavior.move_to_position = nil
	l_1_1._behavior.allowed_to_fire = true
end

RailFlyerAiCombat.logic_rail_flyer_combat_passive = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = l_2_2:ai_data()
	if l_2_8._behavior.target and l_2_8.output.allowed_to_fire then
		return 0, true
	end
	do return end
	if l_2_8._combat.targets ~= nil and l_2_8._combat.targets[1] then
		l_2_8._behavior.target = l_2_8._combat.targets[1]
		table.remove(l_2_8._combat.targets, 1)
	else
		l_2_8._behavior.target = l_2_0:_find_any_targets()
	end
	l_2_0:_allowed_to_fire(l_2_2, l_2_8)
	return nil
end

RailFlyerAiCombat._allowed_to_fire = function(l_3_0, l_3_1, l_3_2)
	l_3_0:_check_for_updates(l_3_1)
	if l_3_2._behavior.target and l_3_2._move.allowed_to_fire and l_3_2._behavior.allowed_to_fire then
		l_3_2.output.allowed_to_fire = true
	end
end

RailFlyerAiCombat.logic_rail_flyer_combat_fire = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_8 = l_4_2:ai_data()
	if not l_4_8._behavior.target then
		return 0
	end
	if not l_4_8._behavior.allowed_to_fire then
		return 0, true
	end
	l_4_0:_allowed_to_fire(l_4_2, l_4_8)
	return nil
end

RailFlyerAiCombat._find_any_targets = function(l_5_0)
	local l_5_5, l_5_6 = World:find_units_quick, World
	l_5_5 = l_5_5(l_5_6, "all", managers.slot:get_mask("rail_vehicles"))
	local l_5_1 = nil
	l_5_6 = pairs
	l_5_1 = l_5_5
	l_5_6 = l_5_6(l_5_1)
	for i_0,i_1 in l_5_6 do
		return l_5_4
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailFlyerAiCombat._check_for_updates = function(l_6_0, l_6_1)
	local l_6_6, l_6_7, l_6_8, l_6_9 = nil
	local l_6_2 = l_6_1:ai_data()
	if l_6_2._combat.new_targets ~= nil then
		l_6_2._combat.targets = {}
		for i_0,i_1 in pairs(l_6_2._combat.new_targets) do
			if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
				table.insert(l_6_2._combat.targets, managers.unit_scripting:get_unit_by_name(i_1.script_name))
			end
		end
		l_6_2._behavior.target = l_6_1:ai_data()._combat.targets[1]
		l_6_2._combat.new_targets = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


