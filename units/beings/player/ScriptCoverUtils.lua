ScriptCoverUtils = ScriptCoverUtils or class()
function ScriptCoverUtils.ground_position(A0_0, A1_1)
	local L2_2, L3_3
	L2_2 = assert
	L3_3 = A1_1
	L2_2(L3_3)
	L3_3 = A0_0
	L2_2 = A0_0.position
	L2_2 = L2_2(L3_3)
	L3_3 = math
	L3_3 = L3_3.UP
	L3_3 = L3_3 * tweak_data.player.cover.QM_TARGET_POINT_GROUND_RAY_LENGTH
	L2_2 = L2_2 + L3_3
	L3_3 = A0_0.position
	L3_3 = L3_3(A0_0)
	L3_3 = L3_3 - math.UP * tweak_data.player.cover.QM_TARGET_POINT_GROUND_RAY_LENGTH
	if World:raycast("ray", L2_2, L3_3, "ray_type", "body", "sphere_cast_radius", A1_1, "slot_mask", managers.slot:get_mask("footstep_decals")) then
		return World:raycast("ray", L2_2, L3_3, "ray_type", "body", "sphere_cast_radius", A1_1, "slot_mask", managers.slot:get_mask("footstep_decals")).position - math.UP * A1_1
	end
	return A0_0:position()
end
function ScriptCoverUtils.can_leave_cover(A0_4, A1_5, A2_6, A3_7)
	local L4_8, L5_9, L6_10, L7_11, L8_12, L9_13, L10_14, L11_15, L12_16
	L4_8 = 30
	if A3_7 == "left_forward" or A3_7 == "right_forward" then
		L5_9 = 60
		L6_10 = 120
		L7_11 = 100
		L8_12 = iff
		L9_13 = A3_7 == "left_forward"
		L10_14 = -A2_6
		L11_15 = A2_6
		L8_12 = L8_12(L9_13, L10_14, L11_15)
		L10_14 = A0_4
		L9_13 = A0_4.position
		L9_13 = L9_13(L10_14)
		L10_14 = math
		L10_14 = L10_14.UP
		L10_14 = L10_14 * L5_9
		L9_13 = L9_13 + L10_14
		L10_14 = L8_12 * L6_10
		L10_14 = L9_13 + L10_14
		L11_15 = ScriptCoverUtils
		L11_15 = L11_15._raycast
		L12_16 = L9_13
		L11_15 = L11_15(L12_16, L10_14, L4_8, "solid_objects", A0_4)
		if L11_15 then
			L12_16 = false
			return L12_16
		end
		L12_16 = A1_5 * L7_11
		L12_16 = L10_14 - L12_16
		L11_15 = ScriptCoverUtils._raycast(L10_14, L12_16, L4_8, "solid_objects", A0_4)
		if L11_15 then
			return false
		end
	end
	L5_9 = true
	return L5_9
end
function ScriptCoverUtils.can_peek_around_cover_edge(A0_17, A1_18, A2_19, A3_20)
	local L4_21, L5_22, L6_23, L7_24, L8_25, L9_26, L10_27, L11_28, L12_29
	L4_21 = 30
	L5_22 = 60
	L6_23 = 100
	L7_24 = 100
	L8_25 = iff
	L9_26 = A3_20 == "left"
	L10_27 = -A2_19
	L11_28 = A2_19
	L8_25 = L8_25(L9_26, L10_27, L11_28)
	L9_26 = math
	L9_26 = L9_26.UP
	L9_26 = L9_26 * L5_22
	L9_26 = A0_17 + L9_26
	L10_27 = L8_25 * L6_23
	L10_27 = L9_26 + L10_27
	L11_28 = ScriptCoverUtils
	L11_28 = L11_28._raycast
	L12_29 = L9_26
	L11_28 = L11_28(L12_29, L10_27, L4_21, "solid_non_ai_objects")
	if L11_28 then
		L12_29 = false
		return L12_29
	end
	L12_29 = A1_18 * L7_24
	L12_29 = L10_27 - L12_29
	L11_28 = ScriptCoverUtils._raycast(L10_27, L12_29, L4_21, "solid_non_ai_objects")
	if L11_28 then
		return false
	end
	return true
end
function ScriptCoverUtils._raycast(A0_30, A1_31, A2_32, A3_33, A4_34)
	local L6_35, L7_36, L8_37, L9_38, L10_39, L11_40, L12_41, L13_42, L14_43, L15_44
	L6_35 = A4_34 or World
	L8_37 = L6_35
	L7_36 = L6_35.raycast
	L9_38 = "ray"
	L10_39 = A0_30
	L11_40 = A1_31
	L12_41 = "sphere_cast_radius"
	L13_42 = A2_32
	L14_43 = "ray_type"
	L15_44 = "low_quality_collision"
	L7_36 = L7_36(L8_37, L9_38, L10_39, L11_40, L12_41, L13_42, L14_43, L15_44, "slot_mask", managers.slot:get_mask(A3_33))
	return L7_36
end
