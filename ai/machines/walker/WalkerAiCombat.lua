WalkerAiCombat = WalkerAiCombat or class(CommonAiCombat)
function WalkerAiCombat.init_data(A0_0, A1_1)
	CommonAiCombat.init_data(A0_0, A1_1)
	A1_1._combat._select_firing_targets = WalkerAiCombat._select_firing_targets
	A1_1._combat._primary_fire_timer = 0
	A1_1._combat._secondary_fire_timer = 0
end
function WalkerAiCombat._select_firing_targets(A0_2, A1_3, A2_4, A3_5)
	local L4_6, L5_7, L6_8, L7_9, L8_10, L9_11
	L4_6 = A1_3._targeting
	L4_6 = L4_6.current_secondary_threats
	if L4_6 then
		L4_6 = TableAlgorithms
		L4_6 = L4_6.is_empty
		L5_7 = A1_3._targeting
		L5_7 = L5_7.current_secondary_threats
		L4_6 = L4_6(L5_7)
		L4_6 = not L4_6
	end
	L5_7 = A1_3._combat
	L6_8 = A1_3._combat
	L6_8 = L6_8._last_time
	L6_8 = L6_8 or A2_4
	L5_7._last_time = L6_8
	L5_7 = A1_3._combat
	L5_7 = L5_7._last_time
	L5_7 = A2_4 - L5_7
	L6_8 = A1_3._combat
	L6_8._last_time = A2_4
	L6_8 = WalkerAiCombat
	L6_8 = L6_8._update_firing_timers
	L7_9 = A1_3
	L8_10 = L5_7
	L6_8(L7_9, L8_10)
	L6_8 = A1_3._targeting
	L6_8 = L6_8.currently_targeted_threat
	L7_9 = A1_3._combat
	L7_9 = L7_9._primary_fire_timer
	L7_9 = L7_9 <= 0
	L8_10 = A1_3._combat
	L8_10 = L8_10._secondary_fire_timer
	L8_10 = L8_10 <= 0
	L9_11 = {}
	L9_11.primary_weapon = {}
	L9_11.secondary_weapon = {}
	if A3_5 then
		L9_11.primary_weapon = WalkerAiCombat._weapon_target(A0_2, L6_8)
		if L7_9 then
			WalkerAiCombat._secondary_weapon_primary_target(L9_11, A0_2, A1_3)
		elseif L8_10 and A1_3._targeting.current_secondary_threats[2] then
			WalkerAiCombat._secondary_weapon_secondary_target(L9_11, A0_2, A1_3)
		end
	else
		if A1_3._targeting.current_secondary_threats[1] then
			L9_11.primary_weapon = WalkerAiCombat._weapon_target(A0_2, A1_3._targeting.current_secondary_threats[1])
		else
			L9_11.primary_weapon = WalkerAiCombat._weapon_target(A0_2, L6_8)
		end
		if L8_10 and A1_3._targeting.current_secondary_threats[2] and A1_3._targeting.current_secondary_threats[2] == A1_3._targeting.current_secondary_threats[1] then
			WalkerAiCombat._secondary_weapon_secondary_target(L9_11, A0_2, A1_3)
		elseif L7_9 then
			WalkerAiCombat._secondary_weapon_primary_target(L9_11, A0_2, A1_3)
		end
	end
	A1_3.output.firing_target = L9_11.primary_weapon.target_unit
	A1_3.output.firing_target_position = L9_11.primary_weapon.target_position
	A1_3.output.allowed_to_fire = L9_11.primary_weapon.allowed_to_fire
	A1_3.output.secondary_weapon_firing_target = L9_11.secondary_weapon.target_unit
	A1_3.output.secondary_weapon_firing_target_position = L9_11.secondary_weapon.target_position
	A1_3.output.secondary_weapon_allowed_to_fire = L9_11.secondary_weapon.allowed_to_fire
end
function WalkerAiCombat._update_firing_timers(A0_12, A1_13)
	local L2_14, L3_15, L4_16
	L2_14 = A0_12._targeting
	L2_14 = L2_14.currently_targeted_threat
	L3_15 = A0_12._combat
	L3_15 = L3_15._primary_fire_timer
	if L3_15 > 0 then
		L3_15 = A0_12._combat
		L4_16 = A0_12._combat
		L4_16 = L4_16._primary_fire_timer
		L4_16 = L4_16 - A1_13
		L3_15._primary_fire_timer = L4_16
	end
	L3_15 = A0_12._combat
	L3_15 = L3_15._secondary_fire_timer
	if L3_15 > 0 then
		L3_15 = A0_12._combat
		L4_16 = A0_12._combat
		L4_16 = L4_16._secondary_fire_timer
		L4_16 = L4_16 - A1_13
		L3_15._secondary_fire_timer = L4_16
	end
	L3_15 = WalkerAiCombat
	L3_15 = L3_15._is_unit_quickmoving
	L4_16 = L2_14.unit
	L4_16 = L4_16(L2_14)
	L3_15 = L3_15(L4_16, L4_16(L2_14))
	if L3_15 then
		L4_16 = A0_12._combat
		L4_16 = L4_16._last_primary_target_quickmove_state
		if not L4_16 then
			L4_16 = A0_12._combat
			L4_16._primary_fire_timer = 0
		end
	end
	L4_16 = A0_12._combat
	L4_16._last_primary_target_quickmove_state = L3_15
	L4_16 = false
	if A0_12._targeting.current_secondary_threats[2] then
		L4_16 = WalkerAiCombat._is_unit_quickmoving(A0_12._targeting.current_secondary_threats[2]:unit())
	end
	if L4_16 and not A0_12._combat._last_secondary_target_quickmove_state then
		A0_12._combat._secondary_fire_timer = 0
	end
	A0_12._combat._last_secondary_target_quickmove_state = L4_16
end
function WalkerAiCombat._is_threat_quickmoving(A0_17)
	local L1_18
	L1_18 = A0_17.unit
	L1_18 = L1_18(A0_17)
	if not alive(L1_18) then
		return false
	end
	return WalkerAiCombat._is_unit_quickmoving(L1_18)
end
function WalkerAiCombat._is_unit_quickmoving(A0_19)
	if alive(A0_19) and A0_19:player_data() and A0_19:player_data().quickmove then
		return true
	end
	return false
end
function WalkerAiCombat._secondary_weapon_primary_target(A0_20, A1_21, A2_22)
	local L3_23, L4_24
	L3_23 = A2_22._targeting
	L3_23 = L3_23.currently_targeted_threat
	L4_24 = WalkerAiCombat
	L4_24 = L4_24._is_threat_quickmoving
	L4_24 = L4_24(L3_23)
	L4_24 = not L4_24
	A0_20.secondary_weapon = WalkerAiCombat._weapon_target(A1_21, L3_23, L4_24)
	if L3_23:unit_line_of_sight() and not WalkerAiCombat._threat_in_cover(L3_23) then
	else
	end
	A1_21:ai_data()._combat._primary_fire_timer = math.random(tweak_data.ai.machines.walker.SECONDARY_WEAPON_ON_PRIMARY_TARGET_TIME.min, tweak_data.ai.machines.walker.SECONDARY_WEAPON_ON_PRIMARY_TARGET_TIME.max)
end
function WalkerAiCombat._secondary_weapon_secondary_target(A0_25, A1_26, A2_27)
	local L3_28, L4_29
	L3_28 = A2_27._targeting
	L3_28 = L3_28.current_secondary_threats
	L3_28 = L3_28[2]
	L4_29 = WalkerAiCombat
	L4_29 = L4_29._is_threat_quickmoving
	L4_29 = L4_29(L3_28)
	L4_29 = not L4_29
	A0_25.secondary_weapon = WalkerAiCombat._weapon_target(A1_26, L3_28, L4_29)
	A1_26:ai_data()._combat._secondary_fire_timer = math.random(tweak_data.ai.machines.walker.SECONDARY_WEAPON_ON_SECONDARY_TARGET_TIME.min, tweak_data.ai.machines.walker.SECONDARY_WEAPON_ON_SECONDARY_TARGET_TIME.max)
end
function WalkerAiCombat._threat_in_cover(A0_30)
	if not alive(A0_30:unit()) then
		return false
	end
	if not A0_30:unit():player_data() then
		return false
	end
	return A0_30:unit():player_data().in_cover
end
function WalkerAiCombat._weapon_target(A0_31, A1_32, A2_33)
	local L3_34, L4_35, L5_36
	L3_34 = {}
	L4_35 = alive
	L5_36 = A1_32.unit
	L5_36 = L5_36(A1_32)
	L4_35 = L4_35(L5_36, L5_36(A1_32))
	if not L4_35 then
		return L3_34
	end
	L5_36 = A1_32
	L4_35 = A1_32.unit_line_of_fire
	L4_35 = L4_35(L5_36)
	if A2_33 then
		L5_36 = WalkerAiCombat
		L5_36 = L5_36._threat_in_cover
		L5_36 = L5_36(A1_32)
		if L5_36 then
			L4_35 = false
		end
	end
	if L4_35 then
		L5_36 = A1_32.unit
		L5_36 = L5_36(A1_32)
		L3_34.target_unit = L5_36
		L3_34.allowed_to_fire = true
	else
		L5_36 = nil
		if A1_32:last_known_position() and A2_33 then
			if (A0_31:position() - A1_32:last_known_position()):length() > tweak_data.ai.machines.walker.SECONDARY_WEAPON_AVOID_DIRECT_FIRE_DISTANCE then
				L5_36 = A1_32:last_known_position() + (A0_31:position() - A1_32:last_known_position()):normalized() * tweak_data.ai.machines.walker.SECONDARY_WEAPON_AVOID_DIRECT_FIRE_DISTANCE
			end
		else
			L5_36 = WalkerAiCombat._threat_firing_position(A0_31:position(), A1_32)
		end
		if L5_36 then
			L3_34.target_position = L5_36
			L3_34.allowed_to_fire = IntelUtilities.ai_have_position_line_of_fire(A0_31, L5_36, nil, 200)
		end
	end
	return L3_34
end
