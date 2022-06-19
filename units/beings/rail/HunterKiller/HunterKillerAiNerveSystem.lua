require("units/beings/AiNerveSystem")
HunterKillerAiNerveSystem = HunterKillerAiNerveSystem or class(AiNerveSystem)
function HunterKillerAiNerveSystem.init(A0_0, A1_1)
	AiNerveSystem.init(A0_0, A1_1)
	A0_0._locked_firing_target = nil
end
function HunterKillerAiNerveSystem.init_default_ai_data(A0_2)
	local L1_3, L2_4
	L1_3 = A0_2._unit
	L2_4 = L1_3
	L1_3 = L1_3.ai_data
	L1_3 = L1_3(L2_4)
	L2_4 = L1_3.input
	L2_4.forced_target_selection = L1_3.default_forced_target_selection
	L2_4 = L1_3.input
	L2_4.forced_target_units = {}
	L2_4 = L1_3.input
	L2_4 = L2_4.forced_target_units
	L2_4[1] = L1_3.default_forced_target_units
	L2_4 = L1_3.input
	L2_4 = L2_4.forced_target_units
	L2_4[2] = L1_3.default_forced_target_units
	L2_4 = L1_3.input
	L2_4.forced_target_locations = {}
	L2_4 = L1_3.input
	L2_4 = L2_4.forced_target_locations
	L2_4[1] = L1_3.default_forced_target_locations
	L2_4 = L1_3.input
	L2_4 = L2_4.forced_target_locations
	L2_4[2] = L1_3.default_forced_target_locations
	L2_4 = L1_3.input
	L2_4.forced_attacks = {}
	L2_4 = L1_3.input
	L2_4 = L2_4.forced_attacks
	L2_4[1] = L1_3.default_forced_primary_attacks or {}
	L2_4 = L1_3.input
	L2_4 = L2_4.forced_attacks
	L2_4[2] = L1_3.default_forced_secondary_attacks or {}
	L2_4 = L1_3.input
	L2_4.override_previous_forced_attacks = L1_3.default_override_previous_forced_attacks
	L2_4 = L1_3.input
	L2_4.forced_flares = L1_3.default_forced_flares or {}
	L2_4 = L1_3.default_primary_attack_properties
	if L2_4 then
		L2_4 = L1_3.default_primary_attack_properties
		L2_4 = L2_4.clip
		if L2_4 and tonumber(L2_4) then
			A0_2._unit:base():set_number_of_primary_bolts(tonumber(L2_4))
		end
	end
	L2_4 = L1_3.default_secondary_attack_properties
	if L2_4 then
		L2_4 = L1_3.default_secondary_attack_properties
		L2_4 = L2_4.clip
		if L2_4 and tonumber(L2_4) then
			A0_2._unit:base():set_number_of_secondary_bolts(tonumber(L2_4))
		end
	end
end
function HunterKillerAiNerveSystem.update(A0_5, A1_6, A2_7, A3_8)
	local L4_9, L5_10, L6_11, L7_12, L8_13, L9_14, L10_15
	L5_10 = A1_6
	L4_9 = A1_6.damage_data
	L4_9 = L4_9(L5_10)
	L5_10 = L4_9
	L4_9 = L4_9.is_fully_damaged
	L4_9 = L4_9(L5_10)
	if L4_9 then
		L5_10 = A0_5
		L4_9 = A0_5._update_dead
		L6_11 = A1_6
		L7_12 = A2_7
		L8_13 = A3_8
		L4_9(L5_10, L6_11, L7_12, L8_13)
		return
	end
	L4_9 = AiNerveSystem
	L4_9 = L4_9.update
	L5_10 = A0_5
	L6_11 = A1_6
	L7_12 = A2_7
	L8_13 = A3_8
	L4_9 = L4_9(L5_10, L6_11, L7_12, L8_13)
	if not L4_9 then
		return
	end
	L5_10 = A1_6
	L4_9 = A1_6.ai_data
	L4_9 = L4_9(L5_10)
	L6_11 = A1_6
	L5_10 = A1_6.enemy_data
	L5_10 = L5_10(L6_11)
	L7_12 = A1_6
	L6_11 = A1_6.input
	L6_11 = L6_11(L7_12)
	L8_13 = A1_6
	L7_12 = A1_6.base
	L7_12 = L7_12(L8_13)
	L9_14 = A1_6
	L8_13 = A1_6.base
	L8_13 = L8_13(L9_14)
	L8_13 = L8_13._weapon_primary
	L10_15 = A1_6
	L9_14 = A1_6.base
	L9_14 = L9_14(L10_15)
	L9_14 = L9_14._weapon_secondary
	L10_15 = L6_11.clear
	L10_15(L6_11)
	L10_15 = alive
	L10_15 = L10_15(L8_13)
	if L10_15 then
		L10_15 = L4_9.output
		L10_15 = L10_15.allowed_to_fire
		L10_15 = L10_15[1]
		if L10_15 then
			L10_15 = L7_12._weapon_primary
			L10_15 = L10_15.base
			L10_15 = L10_15(L10_15)
			L10_15 = L10_15._speed
			L6_11:set_primary_aim_target_position(A0_5:_get_aim_target_position(A1_6, L10_15, 1, A0_5._unit:base()._aim_object[1]))
			L6_11:set_primary_fire()
		end
	end
	L10_15 = alive
	L10_15 = L10_15(L9_14)
	if L10_15 then
		L10_15 = L4_9.output
		L10_15 = L10_15.allowed_to_fire
		L10_15 = L10_15[2]
		if L10_15 then
			L10_15 = L7_12._weapon_secondary
			L10_15 = L10_15.base
			L10_15 = L10_15(L10_15)
			L10_15 = L10_15._speed
			L6_11:set_secondary_aim_target_position(A0_5:_get_aim_target_position(A1_6, L10_15, 2, A0_5._unit:base()._aim_object[2]))
			L6_11:set_secondary_fire()
		end
	end
	L10_15 = L6_11.set_flare
	L10_15(L6_11, L4_9.output.allowed_to_release_flare)
end
function HunterKillerAiNerveSystem._register(A0_16)
	local L1_17
	A0_16._registered = true
end
function HunterKillerAiNerveSystem._unregister(A0_18)
	local L1_19
	A0_18._registered = false
end
function HunterKillerAiNerveSystem._get_aim_target_position(A0_20, A1_21, A2_22, A3_23, A4_24)
	local L5_25, L6_26
	L6_26 = A1_21
	L5_25 = A1_21.ai_data
	L5_25 = L5_25(L6_26)
	L6_26 = nil
	if L5_25.output.firing_target_unit[A3_23] and alive(L5_25.output.firing_target_unit[A3_23]) then
		L6_26 = A0_20:_aim_moving_target2(L5_25.output.firing_target_unit[A3_23], A2_22, A4_24)
	elseif L5_25.output.firing_target_position[A3_23] then
		L6_26 = L5_25.output.firing_target_position[A3_23]
	end
	return L6_26
end
function HunterKillerAiNerveSystem._aim_moving_target(A0_27, A1_28, A2_29, A3_30)
	return A1_28:position() + A1_28:velocity() * ((A1_28:position() + A1_28:velocity() - A3_30:position()):length() / A2_29)
end
function HunterKillerAiNerveSystem._aim_moving_target2(A0_31, A1_32, A2_33, A3_34)
	local L4_35, L5_36, L6_37, L7_38, L8_39, L9_40
	L5_36 = A3_34
	L4_35 = A3_34.position
	L4_35 = L4_35(L5_36)
	L6_37 = A1_32
	L5_36 = A1_32.position
	L5_36 = L5_36(L6_37)
	L6_37 = L5_36
	L7_38 = L6_37
	L9_40 = A1_32
	L8_39 = A1_32.velocity
	L8_39 = L8_39(L9_40)
	L9_40 = 10000
	while L9_40 >= 100 and 0 < 5 do
		L7_38 = L6_37
		L6_37 = L5_36 + L8_39 * ((L6_37 - L4_35):length() / A2_33)
		L9_40 = (L6_37 - L7_38):length()
		if L9_40 < L9_40 then
			return L7_38
		end
	end
	return L6_37
end
function HunterKillerAiNerveSystem._is_dead(A0_41)
	return A0_41._unit:enemy_data().dead
end
function HunterKillerAiNerveSystem._update_dead(A0_42, A1_43, A2_44, A3_45)
	if not A0_42._braindead then
		A0_42:_kill_brain()
	end
	AiNerveSystem.update(A0_42, A1_43, A2_44, A3_45)
	A1_43:input():clear()
end
