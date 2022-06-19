RailFlyerAiCombat = RailFlyerAiCombat or class()
function RailFlyerAiCombat.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._combat = L2_2
	L2_2 = A1_1._combat
	L2_2.targets = {}
	L2_2 = {}
	A1_1._behavior = L2_2
	L2_2 = A1_1._behavior
	L2_2.target = nil
	L2_2 = A1_1._behavior
	L2_2.follow_target = false
	L2_2 = A1_1._behavior
	L2_2.move_to_position = nil
	L2_2 = A1_1._behavior
	L2_2.allowed_to_fire = true
end
function RailFlyerAiCombat.logic_rail_flyer_combat_passive(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	local L8_11
	L8_11 = A2_5.ai_data
	L8_11 = L8_11(A2_5)
	if L8_11._behavior.target then
		if L8_11.output.allowed_to_fire then
			return 0, true
		end
	elseif L8_11._combat.targets ~= nil and L8_11._combat.targets[1] then
		L8_11._behavior.target = L8_11._combat.targets[1]
		table.remove(L8_11._combat.targets, 1)
	else
		L8_11._behavior.target = A0_3:_find_any_targets()
	end
	A0_3:_allowed_to_fire(A2_5, L8_11)
	return nil
end
function RailFlyerAiCombat._allowed_to_fire(A0_12, A1_13, A2_14)
	A0_12:_check_for_updates(A1_13)
	if A2_14._behavior.target and A2_14._move.allowed_to_fire and A2_14._behavior.allowed_to_fire then
		A2_14.output.allowed_to_fire = true
	end
end
function RailFlyerAiCombat.logic_rail_flyer_combat_fire(A0_15, A1_16, A2_17, A3_18, A4_19, A5_20, A6_21, A7_22)
	local L8_23
	L8_23 = A2_17.ai_data
	L8_23 = L8_23(A2_17)
	if not L8_23._behavior.target then
		return 0
	end
	if not L8_23._behavior.allowed_to_fire then
		return 0, true
	end
	A0_15:_allowed_to_fire(A2_17, L8_23)
	return nil
end
function RailFlyerAiCombat._find_any_targets(A0_24)
	local L1_25
	L1_25 = World
	L1_25 = L1_25.find_units_quick
	L1_25 = L1_25(L1_25, "all", managers.slot:get_mask("rail_vehicles"))
	for 