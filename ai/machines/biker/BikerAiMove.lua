BikerAiMove = BikerAiMove or class()
function BikerAiMove.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._move = L2_2
	L2_2 = A1_1._move
	L2_2.allowed_to_fire = false
	L2_2 = A1_1._move
	L2_2.target_from_behind = true
	L2_2 = A1_1._move
	L2_2.range_offset = 300
end
function BikerAiMove.logic_biker_move_init(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	local L8_11
	L8_11 = 0
	return L8_11
end
function BikerAiMove.logic_biker_move_passive(A0_12, A1_13, A2_14, A3_15, A4_16, A5_17, A6_18, A7_19)
	if A2_14:ai_data().input.target_range and A2_14:ai_data().input.forced_target_units then
		return 0
	end
	return nil
end
function BikerAiMove.logic_biker_move_to_target_range(A0_20, A1_21, A2_22, A3_23, A4_24, A5_25, A6_26, A7_27)
	local L8_28, L9_29, L10_30
	L9_29 = A2_22
	L8_28 = A2_22.ai_data
	L8_28 = L8_28(L9_29)
	L10_30 = A0_20
	L9_29 = A0_20._closest_target
	L9_29 = L9_29(L10_30, A2_22, L8_28.input.forced_target_units)
	L10_30 = nil
	if L9_29 then
		L10_30 = A0_20:_get_pursuit_speed(A2_22, L9_29, L8_28)
	end
	L8_28.output.closest_target = L9_29
	L8_28.output.speed = L10_30
	return nil
end
function BikerAiMove._closest_target(A0_31, A1_32, A2_33)
	local L3_34, L4_35, L5_36, L6_37, L7_38, L8_39, L9_40
	L4_35 = A1_32
	L3_34 = A1_32.ai_data
	L3_34 = L3_34(L4_35)
	L4_35 = nil
	for L8_39, L9_40 in L5_36(L6_37) do
		if alive(L9_40) then
			if not L4_35 then
				L4_35 = L9_40
			elseif (L9_40:position() - A1_32:position()):length() < (L4_35:position() - A1_32:position()):length() then
				L4_35 = L9_40
			end
		end
	end
	return L4_35
end
function BikerAiMove._get_pursuit_speed(A0_41, A1_42, A2_43, A3_44)
	local L4_45, L5_46, L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54, L14_55, L15_56, L16_57, L17_58
	L4_45 = A1_42:position():with_z(0)
	L5_46 = A2_43:position():with_z(0)
	L6_47 = L5_46 - L4_45
	L7_48 = L6_47:length()
	L8_49 = A2_43:rotation():y():normalized()
	L9_50 = A2_43:base():get_speed_vector()
	L10_51 = (L8_49:dot(L9_50) * L8_49):length()
	if A3_44._combat.current_attack_type == 1 then
		L15_56 = tweak_data.rail.biker.NEAR_SPEED_CORRECTION
		L16_57 = tweak_data.rail.biker.NEAR_MIN_SPEED
		L17_58 = tweak_data.rail.biker.NEAR_MAX_SPEED
	elseif A3_44._combat.current_attack_type == 2 then
		L15_56 = tweak_data.rail.biker.MEDIUM_SPEED_CORRECTION
		L16_57 = tweak_data.rail.biker.MEDIUM_MIN_SPEED
		L17_58 = tweak_data.rail.biker.MEDIUM_MAX_SPEED
	elseif A3_44._combat.current_attack_type == 3 or A3_44._combat.current_attack_type == 4 then
		L15_56 = tweak_data.rail.biker.FAR_SPEED_CORRECTION
		L16_57 = tweak_data.rail.biker.FAR_MIN_SPEED
		L17_58 = tweak_data.rail.biker.FAR_MAX_SPEED
	elseif A3_44._combat.current_attack_type == 5 then
		L15_56 = tweak_data.rail.biker.APPROACH_SPEED_CORRECTION
		L16_57 = tweak_data.rail.biker.APPROACH_MIN_SPEED
		L17_58 = tweak_data.rail.biker.APPROACH_MAX_SPEED
	end
	if A3_44._move.target_from_behind then
		if L7_48 > A3_44.input.target_range - A3_44._move.range_offset then
			L13_54 = math.max(L15_56, L10_51) * (L7_48 / (A3_44.input.target_range - A3_44._move.range_offset))
		else
			L13_54 = L10_51 * (L7_48 / (A3_44.input.target_range - A3_44._move.range_offset))
		end
	elseif not A0_41:_is_behind_target_vehicle(A1_42, A2_43) then
		if L7_48 > A3_44.input.target_range - A3_44._move.range_offset then
			L13_54 = math.max(L15_56, L10_51) * (L7_48 / (A3_44.input.target_range - A3_44._move.range_offset))
		else
			L13_54 = L10_51 * ((2 * (A3_44.input.target_range - A3_44._move.range_offset) - L7_48) / (A3_44.input.target_range - A3_44._move.range_offset))
		end
	else
		L13_54 = L10_51 * (1 + (L7_48 + tweak_data.rail.biker.RETARDATION_DISTANCE) / tweak_data.rail.biker.RETARDATION_DISTANCE)
	end
	L14_55 = math.clamp(L13_54, L16_57, L17_58) / tweak_data.rail.biker.NORMALIZED_SPEED_FACTOR
	return L14_55
end
function BikerAiMove._is_behind_target_vehicle(A0_59, A1_60, A2_61)
	local L3_62, L4_63
	L4_63 = A2_61
	L3_62 = A2_61.rotation
	L3_62 = L3_62(L4_63)
	L4_63 = L3_62
	L3_62 = L3_62.y
	L3_62 = L3_62(L4_63)
	L4_63 = A2_61.position
	L4_63 = L4_63(A2_61)
	L4_63 = L4_63 - A1_60:position()
	return L3_62:dot(L4_63) >= 0
end
