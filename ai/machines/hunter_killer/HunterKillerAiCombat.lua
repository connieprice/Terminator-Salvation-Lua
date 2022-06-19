HunterKillerAiCombat = HunterKillerAiCombat or class()
function HunterKillerAiCombat.init_data(A0_0, A1_1)
	local L2_2, L3_3
	L2_2 = {}
	A1_1._combat = L2_2
	L2_2 = A1_1._combat
	L3_3 = {}
	L2_2.forced_attacks = L3_3
	L2_2 = A1_1._combat
	L3_3 = {}
	L2_2.forced_attack_cnt = L3_3
	L2_2 = A1_1._combat
	L3_3 = {}
	L2_2.forced_attack_start = L3_3
end
function HunterKillerAiCombat.logic_hk_combat_init(A0_4, A1_5, A2_6, A3_7, A4_8, A5_9, A6_10, A7_11)
	local L8_12
	L8_12 = 0
	return L8_12
end
function HunterKillerAiCombat.logic_hk_combat_passive(A0_13, A1_14, A2_15, A3_16, A4_17, A5_18, A6_19, A7_20)
	if #A2_15:ai_data().input.forced_attacks[1] > 0 or 0 < #A2_15:ai_data().input.forced_attacks[2] then
		A2_15:ai_data()._combat.forced_attacks[1] = A0_13:_get_forced_attacks(A2_15, 1)
		A2_15:ai_data()._combat.forced_attacks[2] = A0_13:_get_forced_attacks(A2_15, 2)
		A2_15:ai_data()._combat.forced_attack_cnt[1] = 1
		A2_15:ai_data()._combat.forced_attack_cnt[2] = 1
		return 0
	end
	A2_15:ai_data().output.firing_target_position = {}
	A2_15:ai_data().output.firing_target_unit = {}
	A2_15:ai_data().output.allowed_to_fire[1] = false
	A2_15:ai_data().output.allowed_to_fire[2] = false
	return nil
end
function HunterKillerAiCombat.logic_hk_combat_forced_fire(A0_21, A1_22, A2_23, A3_24, A4_25, A5_26, A6_27, A7_28)
	if A2_23:ai_data().input.override_previous_forced_attacks then
		A2_23:ai_data().input.override_previous_forced_attacks = false
		return 0
	end
	if 0 < #A2_23:ai_data().input.forced_attacks[1] then
		A0_21:_hk_combat_forced_fire(A2_23, A1_22, 1)
	end
	if 0 < #A2_23:ai_data().input.forced_attacks[2] then
		A0_21:_hk_combat_forced_fire(A2_23, A1_22, 2)
	end
	if #A2_23:ai_data().input.forced_attacks[1] == 0 and #A2_23:ai_data().input.forced_attacks[2] == 0 then
		A2_23:ai_data().output.allowed_to_fire[1] = false
		A2_23:ai_data().output.allowed_to_fire[2] = false
		return 0
	end
	return nil
end
function HunterKillerAiCombat.logic_hk_combat_fire(A0_29, A1_30, A2_31, A3_32, A4_33, A5_34, A6_35, A7_36)
	return nil
end
function HunterKillerAiCombat._hk_combat_forced_fire(A0_37, A1_38, A2_39, A3_40)
	A0_37:_update_forced_attack_rounds(A1_38, A2_39, A1_38:ai_data().input.forced_target_selection, A3_40)
	if #A1_38:ai_data().input.forced_attacks[A3_40] == 0 then
		A1_38:ai_data().output.allowed_to_fire[A3_40] = false
		return
	end
	if A1_38:ai_data()._combat.forced_attack_cnt[A3_40] % 2 == 0 then
		A1_38:ai_data().output.allowed_to_fire[A3_40] = false
		return
	end
	if not A1_38:ai_data().output.firing_target_unit[A3_40] and not A1_38:ai_data().output.firing_target_position[A3_40] or not alive(A1_38:ai_data().output.firing_target_unit[A3_40]) then
		A0_37:_update_forced_attack_target(A1_38, A2_39, A1_38:ai_data().input.forced_target_selection, A3_40)
	end
	if not A1_38:ai_data().output.firing_target_unit[A3_40] and not A1_38:ai_data().output.firing_target_position[A3_40] then
		A1_38:ai_data().output.allowed_to_fire[A3_40] = false
		return
	end
	if 0 < #A1_38:ai_data()._combat.forced_attacks[A3_40] then
		A1_38:ai_data().output.allowed_to_fire[A3_40] = true
	else
		A1_38:ai_data().output.allowed_to_fire[A3_40] = false
	end
end
function HunterKillerAiCombat._get_forced_attacks(A0_41, A1_42, A2_43)
	local L3_44, L4_45, L5_46
	L4_45 = A1_42
	L3_44 = A1_42.ai_data
	L3_44 = L3_44(L4_45)
	L4_45 = string
	L4_45 = L4_45.sub
	L5_46 = L3_44.input
	L5_46 = L5_46.forced_target_selection
	L4_45 = L4_45(L5_46, 1, 11)
	if L4_45 == "[locations]" then
		L4_45 = {}
		L5_46 = L3_44.input
		L5_46 = L5_46.forced_attacks
		L5_46 = L5_46[A2_43]
		L5_46 = #L5_46
		if L5_46 > 0 then
			L5_46 = L3_44.input
			L5_46 = L5_46.forced_target_locations
			L5_46 = L5_46[A2_43]
			for 