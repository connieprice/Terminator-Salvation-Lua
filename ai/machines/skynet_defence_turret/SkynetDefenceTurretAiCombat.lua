SkynetDefenceTurretAiCombat = SkynetDefenceTurretAiCombat or class()
function SkynetDefenceTurretAiCombat.init_data(A0_0, A1_1)
	A1_1._combat = {}
end
function SkynetDefenceTurretAiCombat.logic_skynet_defence_turret_combat_init(A0_2, A1_3, A2_4, A3_5, A4_6, A5_7, A6_8, A7_9)
	local L8_10
	A0_2._start_time = A1_3
	L8_10 = 0
	return L8_10
end
function SkynetDefenceTurretAiCombat.logic_skynet_defence_turret_combat_passive(A0_11, A1_12, A2_13, A3_14, A4_15, A5_16, A6_17, A7_18)
	if #A2_13:ai_data().input.forced_target_units > 0 and A1_12 - A0_11._start_time > A2_13:ai_data().input.attack_delay then
		return 0
	end
	A2_13:ai_data().output.allowed_to_fire = false
	return nil
end
function SkynetDefenceTurretAiCombat.logic_skynet_defence_turret_combat_forced_targets(A0_19, A1_20, A2_21, A3_22, A4_23, A5_24, A6_25, A7_26)
	local L8_27, L9_28, L10_29, L11_30, L12_31, L13_32, L14_33
	L9_28 = A2_21
	L8_27 = A2_21.ai_data
	L8_27 = L8_27(L9_28)
	L10_29 = A0_19
	L9_28 = A0_19._closest_target
	L11_30 = A2_21
	L12_31 = L8_27.input
	L12_31 = L12_31.forced_target_units
	L9_28 = L9_28(L10_29, L11_30, L12_31)
	if L9_28 then
		L10_29 = nil
		L12_31 = L9_28
		L11_30 = L9_28.targeting_info
		L11_30 = L11_30(L12_31)
		if L11_30 then
			L13_32 = L11_30
			L12_31 = L11_30.primary_target_position
			L12_31 = L12_31(L13_32)
			L10_29 = L12_31
		else
			L13_32 = L9_28
			L12_31 = L9_28.oobb
			L12_31 = L12_31(L13_32)
			L14_33 = L12_31
			L13_32 = L12_31.center
			L13_32 = L13_32(L14_33)
			L10_29 = L13_32
		end
		L12_31 = L8_27.input
		L12_31 = L12_31.attack_range
		L13_32 = L8_27.input
		L13_32 = L13_32.attack_range
		L14_33 = A2_21.get_object
		L14_33 = L14_33(A2_21, SkynetDefenceTurretBase._CENTER_OBJECT_NAME)
		L14_33 = L14_33.position
		L14_33 = L14_33(L14_33)
		L14_33 = L14_33 - A2_21:position()
		if IntelUtilities.have_line_of_fire(A2_21, L13_32, L8_27.UNIT_WEAPONS, L9_28, L10_29, L14_33, L8_27.LINE_OF_FIRE_SLOT_MASK, L8_27.FRIENDLY_UNITS_SLOT_MASK) then
			L8_27.output.firing_target = L9_28
			L8_27.output.firing_target_position = L10_29
			L8_27.output.allowed_to_fire = true
			return nil
		end
	end
	L10_29 = L8_27.output
	L10_29.allowed_to_fire = false
	L10_29 = nil
	return L10_29
end
function SkynetDefenceTurretAiCombat._targets_alive_cnt(A0_34, A1_35)
	local L2_36, L3_37, L4_38, L5_39, L6_40, L7_41
	L2_36 = 0
	for L6_40, L7_41 in L3_37(L4_38) do
		if alive(L7_41) then
			L2_36 = L2_36 + 1
		end
	end
	return L2_36
end
function SkynetDefenceTurretAiCombat._closest_target(A0_42, A1_43, A2_44)
	local L3_45, L4_46, L5_47, L6_48, L7_49, L8_50, L9_51
	L4_46 = A1_43
	L3_45 = A1_43.ai_data
	L3_45 = L3_45(L4_46)
	L4_46 = nil
	for L8_50, L9_51 in L5_47(L6_48) do
		if alive(L9_51) then
			if not L4_46 then
				L4_46 = L9_51
			elseif (L9_51:position() - A1_43:position()):length() < (L4_46:position() - A1_43:position()):length() then
				L4_46 = L9_51
			end
		end
	end
	return L4_46
end
