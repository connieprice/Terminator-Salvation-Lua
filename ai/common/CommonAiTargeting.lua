CommonAiTargeting = CommonAiTargeting or class()
function CommonAiTargeting.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._targeting = L2_2
	L2_2 = A1_1._targeting
	L2_2.currently_targeted_threat = nil
	L2_2 = A1_1._targeting
	L2_2.current_secondary_threats = nil
end
function CommonAiTargeting.logic_common_targeting_main(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	local L8_11
	L8_11 = A2_5.ai_data
	L8_11 = L8_11(A2_5)
	A0_3:_set_targets(A2_5)
	if Global.category_debug_render["ai.target"] then
		A0_3:_debug_render(A2_5, L8_11)
	end
	return nil
end
function CommonAiTargeting._debug_render(A0_12, A1_13, A2_14)
	local L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21, L10_22, L11_23, L12_24, L13_25
	L3_15 = Global
	L3_15 = L3_15.category_debug_render
	L3_15 = L3_15["ai.target"]
	L5_17 = A1_13
	L4_16 = A1_13.position
	L4_16 = L4_16(L5_17)
	L5_17 = true
	if L3_15 ~= true then
		L6_18 = A1_13.name
		L6_18 = L6_18(L7_19)
		if L6_18 ~= L3_15 then
			L5_17 = false
		end
	end
	if L5_17 then
		L6_18 = Draw
		L6_18 = L6_18.brush
		L6_18 = L6_18(L7_19)
		L7_19(L8_20, L9_21)
		if L7_19 then
			L10_22 = L7_19
			L13_25 = L9_21(L10_22)
			L8_20(L9_21, L10_22, L11_23, L12_24, L13_25, L9_21(L10_22))
			if not L8_20 then
				L11_23 = L7_19
				L10_22 = L7_19.last_known_direction
				L13_25 = L10_22(L11_23)
				L9_21(L10_22, L11_23, L12_24, L13_25, L10_22(L11_23))
				L10_22 = L7_19
			end
			L10_22 = L6_18
			L11_23 = Vector3
			L12_24 = 0
			L13_25 = 0
			L11_23 = L11_23(L12_24, L13_25, 100)
			L11_23 = L4_16 + L11_23
			L12_24 = L8_20 - L4_16
			L12_24 = L12_24 * 0.75
			L12_24 = L4_16 + L12_24
			L13_25 = 10
			L9_21(L10_22, L11_23, L12_24, L13_25)
		end
		if L7_19 then
			for L10_22, L11_23 in L7_19(L8_20) do
				L12_24, L13_25 = nil, nil
				if L10_22 == 1 then
					L12_24 = Color(0, 1, 1)
					L13_25 = 20
				else
					L12_24 = Color(1, 0, 1)
					L13_25 = 10
				end
				if not L11_23:last_known_position() then
					assert(L11_23:last_known_direction())
				end
				L6_18:set_color(L12_24)
				L6_18:line(L4_16 + Vector3(0, 0, 100), L4_16 + (L4_16 + L11_23:last_known_direction() * 500 - L4_16) * 0.75, L13_25)
			end
		end
	end
end
function CommonAiTargeting._set_targets(A0_26, A1_27)
	A0_26:_set_primary_target(A1_27)
	if A1_27:ai_data().NUMBER_OF_SECONDARY_TARGETS and A1_27:ai_data().NUMBER_OF_SECONDARY_TARGETS > 0 then
		A0_26:_set_secondary_targets(A1_27)
	else
		A1_27:ai_data()._targeting.current_secondary_threats = nil
	end
end
function CommonAiTargeting._set_primary_target(A0_28, A1_29)
	local L2_30, L3_31, L4_32, L5_33, L6_34, L7_35, L8_36, L9_37, L10_38, L11_39
	L3_31 = A1_29
	L2_30 = A1_29.ai_data
	L2_30 = L2_30(L3_31)
	L3_31 = L2_30._threat_tracking
	L3_31 = L3_31._threats
	L4_32 = TableAlgorithms
	L4_32 = L4_32.is_empty
	L5_33 = L3_31
	L4_32 = L4_32(L5_33)
	if L4_32 then
		L4_32 = L2_30._targeting
		L4_32.currently_targeted_threat = nil
		return
	end
	L4_32 = L2_30._targeting
	L4_32 = L4_32.currently_targeted_threat
	if L4_32 then
		L4_32 = L2_30._targeting
		L4_32 = L4_32.currently_targeted_threat
		L5_33 = L4_32
		L4_32 = L4_32.is_valid
		L4_32 = L4_32(L5_33)
		if not L4_32 then
			L4_32 = L2_30._targeting
			L4_32.currently_targeted_threat = nil
		end
	end
	L4_32 = nil
	L5_33 = L2_30.threat_constants
	L5_33 = L5_33.primary_weights
	function L6_34(A0_40)
		return A0_40:primary_target_priority()
	end
	L10_38 = A1_29
	L11_39 = L5_33
	if L7_35 then
		L4_32 = L7_35.currently_targeted_threat
	end
	for L10_38, L11_39 in L7_35(L8_36) do
		if A0_28:_is_targetable(L11_39, A1_29, L5_33, L6_34, nil, L4_32) and L11_39 ~= L4_32 and (not L4_32 or A0_28:_compare_primary(L11_39, L4_32, L2_30)) then
			L4_32 = L11_39
		end
	end
	L7_35.currently_targeted_threat = L4_32
end
function CommonAiTargeting._set_secondary_targets(A0_41, A1_42)
	local L2_43, L3_44, L4_45, L5_46, L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54, L14_55
	L3_44 = A1_42
	L2_43 = A1_42.ai_data
	L2_43 = L2_43(L3_44)
	L3_44 = {}
	L4_45 = L2_43.threat_constants
	L4_45 = L4_45.secondary_weights
	function L5_46(A0_56)
		return A0_56:secondary_target_priority()
	end
	for L9_50, L10_51 in L6_47(L7_48) do
		L13_54 = L10_51
		L14_55 = A1_42
		if L11_52 then
			if L10_51 ~= L11_52 then
				L13_54 = L10_51
				L11_52(L12_53, L13_54)
			end
		end
	end
	L6_47(L7_48, L8_49)
	L6_47.current_secondary_threats = L7_48
	for L9_50 = 1, L2_43.NUMBER_OF_SECONDARY_TARGETS do
		for L13_54, L14_55 in L10_51(L11_52) do
			if A0_41:_is_targetable(L14_55, A1_42, L4_45, L5_46, L9_50, L2_43._targeting.currently_targeted_threat) then
				L2_43._targeting.current_secondary_threats[L9_50] = L14_55
				L9_50 = L9_50 + 1
			else
			end
		end
	end
end
function CommonAiTargeting._is_targetable(A0_57, A1_58, A2_59, A3_60, A4_61, A5_62, A6_63)
	local L7_64, L8_65, L9_66, L10_67, L11_68, L12_69, L13_70, L14_71, L15_72
	if not A1_58 then
		L7_64 = false
		return L7_64
	end
	L7_64 = alive
	L9_66 = A1_58
	L8_65 = A1_58.unit
	L15_72 = L8_65(L9_66)
	L7_64 = L7_64(L8_65, L9_66, L10_67, L11_68, L12_69, L13_70, L14_71, L15_72, L8_65(L9_66))
	if L7_64 then
		L8_65 = A1_58
		L7_64 = A1_58.unit_dead
		L7_64 = L7_64(L8_65)
		L7_64 = not L7_64
		if not L7_64 then
			L8_65 = false
			return L8_65
		end
	end
	L8_65 = A1_58
	L7_64 = A1_58.unit_associated
	L7_64 = L7_64(L8_65)
	if L7_64 then
		L7_64 = A4_61
		L8_65 = A1_58
		L7_64 = L7_64(L8_65)
		L8_65 = tweak_data
		L8_65 = L8_65.ai
		L8_65 = L8_65.UNIT_THREAT_MIN_VALUE
		if L7_64 < L8_65 then
			L8_65 = false
			return L8_65
		end
	elseif not A6_63 then
		L7_64 = A4_61
		L8_65 = A1_58
		L7_64 = L7_64(L8_65)
		L8_65 = tweak_data
		L8_65 = L8_65.ai
		L8_65 = L8_65.NON_UNIT_THREAT_MIN_VALUE
		if L7_64 < L8_65 then
			L8_65 = false
			return L8_65
		end
	end
	L7_64 = A3_60.FIRING_ARC_INFO
	if L7_64 then
		L7_64 = nil
		L9_66 = A1_58
		L8_65 = A1_58.last_known_position
		L8_65 = L8_65(L9_66)
		if L8_65 then
			L9_66 = A1_58
			L8_65 = A1_58.last_known_position
			L8_65 = L8_65(L9_66)
			L10_67 = A2_59
			L9_66 = A2_59.position
			L9_66 = L9_66(L10_67)
			L7_64 = L8_65 - L9_66
		else
			L9_66 = A1_58
			L8_65 = A1_58.last_known_direction
			L8_65 = L8_65(L9_66)
			L7_64 = L8_65
		end
		L8_65 = IntelUtilities
		L8_65 = L8_65.orientation_object_info
		L10_67 = A2_59
		L9_66 = A2_59.get_object
		L9_66 = L9_66(L10_67, L11_68)
		L10_67 = A3_60.FIRING_ARC_ORIENTATION_OBJECT_AXIS
		L9_66 = L8_65(L9_66, L10_67)
		L10_67 = L7_64.to_polar_with_reference
		L10_67 = L10_67(L11_68, L12_69, L13_70)
		if A5_62 then
			L14_71 = L11_68
			L15_72 = L10_67
			return L12_69(L13_70, L14_71, L15_72)
		else
			for L14_71, L15_72 in L11_68(L12_69) do
				if A0_57:_within_firing_arc(L15_72, L10_67) then
					return true
				end
			end
			return L11_68
		end
	else
		L7_64 = true
		return L7_64
	end
end
function CommonAiTargeting._within_firing_arc(A0_73, A1_74, A2_75)
	return math.abs(-A2_75.spin + A1_74.CENTER_ANGLE) < A1_74.HALF_FOV and math.abs(A2_75.pitch) < A1_74.HALF_ZFOV
end
function CommonAiTargeting._compare_primary(A0_76, A1_77, A2_78, A3_79)
	if A1_77 == A3_79._targeting.currently_targeted_threat then
	elseif A2_78 == A3_79._targeting.currently_targeted_threat then
	end
	return A1_77:primary_target_priority() * A3_79.threat_constants.primary_weights.SAME_TARGET_FACTOR * A3_79.threat_constants.primary_weights.CHANGE_TARGET_FACTOR > A2_78:primary_target_priority() * A3_79.threat_constants.primary_weights.CHANGE_TARGET_FACTOR * A3_79.threat_constants.primary_weights.SAME_TARGET_FACTOR
end
function CommonAiTargeting._secondary_threat_priority(A0_80, A1_81)
	if not A1_81._targeting.current_secondary_threats or #A1_81._targeting.current_secondary_threats == 0 then
		return (A0_80:primary_target_priority())
	end
	if A1_81._targeting.current_secondary_threats and TableAlgorithms.find_value(A0_80, A1_81._targeting.current_secondary_threats) then
	else
	end
	return A0_80:primary_target_priority() * A1_81.threat_constants.secondary_weights.SAME_TARGET_FACTOR * A1_81.threat_constants.secondary_weights.CHANGE_TARGET_FACTOR
end
