BikerAiCombat = BikerAiCombat or class()
BikerAiCombat.attack_types = {
	"near",
	"medium",
	"far",
	"appr. near",
	"appr. far"
}
function BikerAiCombat.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._combat = L2_2
	L2_2 = A1_1._combat
	L2_2.current_attack_type = 5
	L2_2 = A1_1._combat
	L2_2.approach_finished = false
end
function BikerAiCombat.logic_biker_combat_init(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	local L8_11
	L8_11 = 0
	return L8_11
end
function BikerAiCombat.logic_biker_combat_passive(A0_12, A1_13, A2_14, A3_15, A4_16, A5_17, A6_18, A7_19)
	if A2_14:ai_data().input.forced_target_units and A2_14:ai_data().input.forced_attack_ranges and A2_14:ai_data().input.forced_attack_fov then
		return 0
	end
	A2_14:ai_data().output.allowed_to_fire = false
	return nil
end
function BikerAiCombat.logic_biker_combat_forced_fire(A0_20, A1_21, A2_22, A3_23, A4_24, A5_25, A6_26, A7_27)
	local L8_28, L9_29
	L9_29 = A2_22
	L8_28 = A2_22.ai_data
	L8_28 = L8_28(L9_29)
	L9_29 = A0_20._targets_alive_cnt
	L9_29 = L9_29(A0_20, L8_28.input.forced_target_units)
	if L9_29 == 0 then
		L9_29 = L8_28.input
		L9_29.forced_target_units = {}
		L9_29 = L8_28.output
		L9_29.allowed_to_fire = false
		L9_29 = 0
		return L9_29
	end
	L9_29 = A0_20._targets_in_fov
	L9_29 = L9_29(A0_20, A2_22, L8_28.input.forced_target_units)
	if #L9_29 > 0 then
		L8_28.output.attack_type = A0_20:_closest_target(A2_22, L9_29).attack_type
		L8_28.output.allowed_to_fire = true
		L8_28._combat.current_attack_type = A0_20:_closest_target(A2_22, L9_29).attack_type
		if Global.category_debug_render.rail_biker then
			Draw:pen("one_second"):set("red")
			Draw:pen("one_second"):line(A2_22:base()._aim_object:position(), A0_20:_closest_target(A2_22, L9_29).unit:position())
		end
		return nil
	end
	L8_28.output.allowed_to_fire = false
	return nil
end
function BikerAiCombat.logic_biker_combat_fire(A0_30, A1_31, A2_32, A3_33, A4_34, A5_35, A6_36, A7_37)
	return nil
end
function BikerAiCombat._targets_alive_cnt(A0_38, A1_39)
	local L2_40, L3_41, L4_42, L5_43, L6_44, L7_45
	L2_40 = 0
	for L6_44, L7_45 in L3_41(L4_42) do
		if alive(L7_45) then
			L2_40 = L2_40 + 1
		end
	end
	return L2_40
end
function BikerAiCombat._targets_in_fov(A0_46, A1_47, A2_48)
	local L3_49, L4_50, L5_51, L6_52, L7_53, L8_54, L9_55, L10_56, L11_57, L12_58, L13_59, L14_60, L15_61, L16_62, L17_63, L18_64, L19_65, L20_66, L21_67, L22_68
	L4_50 = A1_47
	L3_49 = A1_47.ai_data
	L3_49 = L3_49(L4_50)
	L4_50 = L3_49.input
	L4_50 = L4_50.forced_attack_fov
	L4_50 = L4_50[1]
	L5_51 = L3_49.input
	L5_51 = L5_51.forced_attack_fov
	L5_51 = L5_51[2]
	L6_52 = L3_49.input
	L6_52 = L6_52.forced_attack_fov
	L6_52 = L6_52[3]
	L7_53 = L3_49.input
	L7_53 = L7_53.forced_attack_ranges
	L7_53 = L7_53[1]
	L8_54 = L3_49.input
	L8_54 = L8_54.forced_attack_ranges
	L8_54 = L8_54[2]
	L9_55 = L3_49.input
	L9_55 = L9_55.forced_attack_ranges
	L9_55 = L9_55[3]
	L10_56 = L3_49.input
	L10_56 = L10_56.forced_attack_ranges
	L10_56 = L10_56[4]
	L12_58 = A1_47
	L11_57 = A1_47.base
	L11_57 = L11_57(L12_58)
	L11_57 = L11_57._aim_object
	L13_59 = L11_57
	L12_58 = L11_57.position
	L12_58 = L12_58(L13_59)
	L14_60 = L11_57
	L13_59 = L11_57.rotation
	L13_59 = L13_59(L14_60)
	L14_60 = L13_59
	L13_59 = L13_59.y
	L13_59 = L13_59(L14_60)
	L13_59 = L13_59 * L7_53
	L15_61 = L11_57
	L14_60 = L11_57.rotation
	L14_60 = L14_60(L15_61)
	L15_61 = L14_60
	L14_60 = L14_60.y
	L14_60 = L14_60(L15_61)
	L14_60 = L14_60 * L8_54
	L16_62 = L11_57
	L15_61 = L11_57.rotation
	L15_61 = L15_61(L16_62)
	L16_62 = L15_61
	L15_61 = L15_61.y
	L15_61 = L15_61(L16_62)
	L15_61 = L15_61 * L9_55
	L16_62 = {}
	for L20_66, L21_67 in L17_63(L18_64) do
		L22_68 = alive
		L22_68 = L22_68(L21_67)
		if L22_68 then
			L22_68 = L21_67.position
			L22_68 = L22_68(L21_67)
			L22_68 = L22_68 - L11_57:position()
			if L7_53 >= (L12_58 - L21_67:position()):length() and L4_50 >= L15_61:angle(L22_68) then
				table.insert(L16_62, {
					unit = L21_67,
					distance = (L12_58 - L21_67:position()):length(),
					attack_type = 1
				})
				L3_49._combat.approach_finished = true
			elseif L7_53 < (L12_58 - L21_67:position()):length() and L8_54 >= (L12_58 - L21_67:position()):length() and L5_51 >= L15_61:angle(L22_68) then
				table.insert(L16_62, {
					unit = L21_67,
					distance = (L12_58 - L21_67:position()):length(),
					attack_type = 2
				})
				L3_49._combat.approach_finished = true
			elseif L8_54 < (L12_58 - L21_67:position()):length() and L9_55 >= (L12_58 - L21_67:position()):length() and L6_52 >= L15_61:angle(L22_68) then
				table.insert(L16_62, {
					unit = L21_67,
					distance = (L12_58 - L21_67:position()):length(),
					attack_type = 3
				})
				L3_49._combat.approach_finished = true
			elseif L9_55 < (L12_58 - L21_67:position()):length() and L10_56 >= (L12_58 - L21_67:position()):length() and not L3_49._combat.approach_finished then
				table.insert(L16_62, {
					unit = L21_67,
					distance = (L12_58 - L21_67:position()):length(),
					attack_type = 4
				})
			elseif L10_56 < (L12_58 - L21_67:position()):length() and not L3_49._combat.approach_finished then
				table.insert(L16_62, {
					unit = L21_67,
					distance = (L12_58 - L21_67:position()):length(),
					attack_type = 5
				})
			end
		end
	end
	if L17_63 then
		L20_66 = L12_58
		L21_67 = L13_59
		L22_68 = L14_60
		L17_63(L18_64, L19_65, L20_66, L21_67, L22_68, L15_61, L7_53, L8_54, L9_55, L4_50, L5_51, L6_52, A2_48, L16_62)
	end
	return L16_62
end
function BikerAiCombat._closest_target(A0_69, A1_70, A2_71)
	local L3_72, L4_73
	L4_73 = A1_70
	L3_72 = A1_70.ai_data
	L3_72 = L3_72(L4_73)
	L4_73 = nil
	for 