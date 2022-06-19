require("units/beings/AiNerveSystem")
SkynetDefenceTurretAiNerveSystem = SkynetDefenceTurretAiNerveSystem or class(AiNerveSystem)
function SkynetDefenceTurretAiNerveSystem.init(A0_0, A1_1)
	AiNerveSystem.init(A0_0, A1_1)
	A0_0._ai_data = A0_0._unit:ai_data()
	A0_0._input = A1_1:input()
	A0_0._aim_object_missile = A1_1:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_MISSILE)
	A0_0._aim_object_gatling = A1_1:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_GATLING)
	A0_0._low_frequency = managers.update_scheduler:add_function(A0_0.low_frequency_update, "skynet_defence_turret_nervesystem")
end
function SkynetDefenceTurretAiNerveSystem.init_default_ai_data(A0_2)
	local L1_3, L2_4
	L1_3 = A0_2._ai_data
	L1_3 = L1_3.input
	L2_4 = A0_2._ai_data
	L2_4 = L2_4.default_attack_range
	L1_3.attack_range = L2_4
	L1_3 = A0_2._ai_data
	L1_3 = L1_3.input
	L2_4 = A0_2._ai_data
	L2_4 = L2_4.default_attack_delay
	L1_3.attack_delay = L2_4
	L1_3 = A0_2._ai_data
	L1_3 = L1_3.input
	L2_4 = A0_2._ai_data
	L2_4 = L2_4.default_forced_target_units
	L1_3.forced_target_units = L2_4
end
function SkynetDefenceTurretAiNerveSystem.update(A0_5, A1_6, A2_7, A3_8)
	if A1_6:damage_data().fully_damaged then
		A0_5:_update_dead(A1_6, A2_7, A3_8)
		return
	end
	if not AiNerveSystem.update(A0_5, A1_6, A2_7, A3_8) then
		A0_5._input:clear()
		return
	end
	A0_5._low_frequency:update(A0_5, A1_6, A2_7, A3_8)
end
function SkynetDefenceTurretAiNerveSystem.low_frequency_update(A0_9, A1_10, A2_11, A3_12)
	local L4_13, L5_14, L6_15, L7_16
	L4_13 = AiNerveSystem
	L4_13 = L4_13.low_frequency_update
	L5_14 = A0_9
	L6_15 = A1_10
	L7_16 = A2_11
	L4_13(L5_14, L6_15, L7_16, A3_12)
	L4_13 = A0_9._input
	L5_14 = L4_13
	L4_13 = L4_13.clear
	L4_13(L5_14)
	L4_13 = A0_9._ai_data
	L4_13 = L4_13.output
	L4_13 = L4_13.allowed_to_fire
	L5_14 = A0_9._ai_data
	L5_14 = L5_14.output
	L5_14 = L5_14.firing_target
	L6_15 = A0_9._ai_data
	L6_15 = L6_15.output
	L6_15 = L6_15.firing_target_position
	L7_16 = nil
	if L6_15 and alive(L5_14) then
		A0_9._input:set_aim_target_position(L6_15)
		if not A0_9._missile_speed then
			A0_9._missile_speed = A1_10:base()._weapon_missile:base()._speed
		end
		L7_16 = A0_9:_aim_moving_target2(L5_14, L6_15, A0_9._missile_speed, A0_9._aim_object_missile)
		A0_9._input:set_aim_target_position_missile(L7_16)
	end
	if L4_13 and alive(L5_14) then
		if not IntelUtilities.ai_friendly_fire(A1_10, L7_16) and A0_9:_target_angle(A0_9._aim_object_missile, L7_16) < A0_9._max_fire_angle_missile then
			A0_9._input:set_fire_missile()
		end
		if not IntelUtilities.ai_friendly_fire(A1_10, L6_15) and A0_9:_target_angle(A0_9._aim_object_gatling, L6_15) < A0_9._max_fire_angle_gatling then
			A0_9._input:set_fire_gatling()
		end
	end
	A0_9._input:set_miss_dispersion(A0_9:_update_weapons_dispersions(A1_10, {L5_14}, A3_12)[1])
end
function SkynetDefenceTurretAiNerveSystem._target_angle(A0_17, A1_18, A2_19)
	local L3_20, L4_21
	L4_21 = A1_18
	L3_20 = A1_18.position
	L3_20 = L3_20(L4_21)
	L3_20 = A2_19 - L3_20
	L4_21 = L3_20
	L3_20 = L3_20.length
	L3_20 = L3_20(L4_21)
	L4_21 = A1_18.position
	L4_21 = L4_21(A1_18)
	L4_21 = L4_21 + A1_18:rotation():y() * L3_20
	return (A2_19:angle(L4_21))
end
function SkynetDefenceTurretAiNerveSystem._aim_moving_target2(A0_22, A1_23, A2_24, A3_25, A4_26)
	local L5_27, L6_28, L7_29, L8_30, L9_31, L10_32
	L6_28 = A4_26
	L5_27 = A4_26.position
	L5_27 = L5_27(L6_28)
	L6_28 = A2_24
	L7_29 = L6_28
	L8_30 = L7_29
	L10_32 = A1_23
	L9_31 = A1_23.velocity
	L9_31 = L9_31(L10_32)
	L10_32 = 10000
	while L10_32 >= 100 and 0 < 5 do
		L8_30 = L7_29
		L7_29 = L6_28 + L9_31 * ((L7_29 - L5_27):length() / A3_25)
		L10_32 = (L7_29 - L8_30):length()
		if L10_32 < L10_32 then
			return L8_30
		end
	end
	return L7_29
end
function SkynetDefenceTurretAiNerveSystem._register(A0_33)
	local L1_34
	A0_33._registered = true
end
function SkynetDefenceTurretAiNerveSystem._unregister(A0_35)
	local L1_36
	A0_35._registered = false
end
function SkynetDefenceTurretAiNerveSystem._is_dead(A0_37)
	return A0_37._unit:enemy_data().dead
end
function SkynetDefenceTurretAiNerveSystem._update_dead(A0_38, A1_39, A2_40, A3_41)
	if not A0_38._braindead then
		A0_38:_kill_brain()
	end
	AiNerveSystem.update(A0_38, A1_39, A2_40, A3_41)
end
function SkynetDefenceTurretAiNerveSystem._debug(A0_42, A1_43, A2_44, A3_45)
end
