require("units/beings/AiNerveSystem")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
WalkerAiNerveSystem = WalkerAiNerveSystem or class(AiNerveSystem)
function WalkerAiNerveSystem.init(A0_0, A1_1)
	AiNerveSystem.init(A0_0, A1_1)
	A0_0._time_since_last_fire = 999999
	A0_0:_setup_aimers()
	A0_0._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(A0_0.low_frequency_update, "walker_nervesystem"))
end
function WalkerAiNerveSystem.destroy(A0_2)
	A0_2._low_frequency:remove()
	AiNerveSystem.destroy(A0_2)
end
function WalkerAiNerveSystem.update(A0_3, A1_4, A2_5, A3_6)
	if not AiNerveSystem.update(A0_3, A1_4, A2_5, A3_6) then
		A1_4:input():clear()
		return
	end
	A0_3._low_frequency:update(A0_3, A3_6, A1_4, A2_5)
end
function WalkerAiNerveSystem.low_frequency_update(A0_7, A1_8, A2_9, A3_10)
	local L4_11, L5_12, L6_13, L7_14, L8_15
	L4_11 = AiNerveSystem
	L4_11 = L4_11.low_frequency_update
	L5_12 = A0_7
	L6_13 = A2_9
	L7_14 = A3_10
	L8_15 = A1_8
	L4_11(L5_12, L6_13, L7_14, L8_15)
	L4_11 = A0_7._ai_data
	L6_13 = A2_9
	L5_12 = A2_9.input
	L5_12 = L5_12(L6_13)
	L7_14 = L5_12
	L6_13 = L5_12.clear
	L6_13(L7_14)
	L7_14 = A0_7
	L6_13 = A0_7._update_weapons_dispersions
	L8_15 = A2_9
	L6_13 = L6_13(L7_14, L8_15, {
		L4_11.output.firing_target,
		nil
	}, A1_8)
	L8_15 = L5_12
	L7_14 = L5_12.set_miss_dispersions
	L7_14(L8_15, L6_13)
	L8_15 = A0_7
	L7_14 = A0_7._update_movement
	L7_14(L8_15, L4_11, L5_12, A0_7._unit_position)
	L8_15 = A0_7
	L7_14 = A0_7._update_aiming
	L8_15 = L7_14(L8_15, A2_9, L4_11, L5_12, A0_7._unit_position)
	A0_7:_update_prepare_fire(L4_11, L5_12, A0_7._unit_position, A2_9)
	A0_7:_update_fire(A1_8, L4_11, L5_12, A2_9, A0_7._unit_position, L7_14, L8_15)
	A0_7:_update_execution(L4_11, L4_11.output.moving_to_execute_target, false)
end
function WalkerAiNerveSystem._stun_update(A0_16, A1_17, A2_18, A3_19)
	AiNerveSystem._stun_update(A0_16, A1_17, A2_18, A3_19)
	A0_16:_update_execution(A0_16._ai_data, nil, true)
	A0_16._ai_data.input.abort_execution = true
end
function WalkerAiNerveSystem._update_movement(A0_20, A1_21, A2_22, A3_23)
	local L4_24, L5_25
	L5_25 = A0_20._move_to_position
	if L5_25 then
		L5_25 = A0_20._movement_blocked
		if not L5_25 then
			L5_25 = nil
			if A0_20._waypoint_options and A0_20._waypoint_options.speed and A1_21.SPEEDS then
				L5_25 = A1_21.SPEEDS[A0_20._waypoint_options.speed]
				assert(L5_25)
			else
				L5_25 = A1_21.output.move_speed
			end
			L4_24 = L5_25 * (A0_20._move_to_position - A3_23):normalized()
		end
	end
	if L4_24 then
		L5_25 = A2_22.set_movement
		L5_25(A2_22, L4_24)
	end
end
function WalkerAiNerveSystem._update_execution(A0_26, A1_27, A2_28, A3_29)
	if alive(A2_28) then
		if not A0_26._paralyzed_target then
			A0_26._paralyzed_target = A2_28
			if A0_26._paralyzed_target:ai_data() then
				A0_26._paralyzed_target:ai_data().external.paralyzed_by_unit = A0_26._unit
			end
		end
	elseif alive(A0_26._paralyzed_target) and A0_26._paralyzed_target:ai_data() then
		A0_26._paralyzed_target:ai_data().external.paralyzed_by_unit = nil
	end
	if A1_27.input.abort_execution and not A3_29 and not A2_28 then
		A1_27.input.abort_execution = false
	end
end
function WalkerAiNerveSystem._update_aiming(A0_30, A1_31, A2_32, A3_33, A4_34)
	local L5_35, L6_36, L7_37, L8_38, L9_39, L10_40, L11_41
	L8_38 = A2_32.output
	L9_39 = L8_38.allowed_to_fire
	if L9_39 then
		L10_40 = L8_38.moving_to_execute_target
		if L10_40 then
			L10_40 = L8_38.firing_target_position
			if L10_40 then
				L10_40 = A0_30._move_to_position
				if L10_40 then
					L10_40 = L8_38.firing_target_position
					L10_40 = L10_40 - A4_34
					L11_41 = L10_40
					L10_40 = L10_40.normalized
					L10_40 = L10_40(L11_41)
					L11_41 = A0_30._move_to_position
					L11_41 = L11_41 - A4_34
					L11_41 = L11_41.normalized
					L11_41 = L11_41(L11_41)
					L9_39 = math.dot(L10_40, L11_41) > WalkerTweakData.MIN_EXECUTION_AREA_FIRE_DOT
				end
			end
		end
	end
	if L9_39 then
		L11_41 = A0_30
		L10_40 = A0_30._find_firing_position
		L10_40 = L10_40(L11_41, L8_38.firing_target, L8_38.firing_target_position)
		L5_35 = L10_40
		L11_41 = A0_30
		L10_40 = A0_30._find_firing_position
		L10_40 = L10_40(L11_41, L8_38.secondary_weapon_firing_target, L8_38.secondary_weapon_firing_target_position, true)
		L6_36 = L10_40
		L7_37 = L5_35
	else
		L10_40 = A0_30._waypoint_rotation_look_at_position
		if L10_40 then
			L7_37 = A0_30._waypoint_rotation_look_at_position
			L5_35 = A0_30._waypoint_rotation_look_at_position
		else
			L10_40 = A0_30._move_to_position
			if L10_40 then
				L10_40 = A0_30._move_to_position
				L11_41 = math
				L11_41 = L11_41.UP
				L11_41 = L11_41 * WalkerTweakData.MOVE_TO_LOOK_AT_HEIGHT
				L7_37 = L10_40 + L11_41
				L5_35 = nil
			else
				L10_40 = L8_38.look_at_position
				if L10_40 then
					L7_37 = L8_38.look_at_position
					L10_40 = A0_30._move_to_position
					L5_35 = L10_40 or L8_38.look_at_position
				else
					L7_37 = nil
					L5_35 = nil
				end
			end
		end
	end
	L10_40 = nil
	L11_41 = A0_30._primary_aimer
	if L11_41 then
		if L5_35 then
			L11_41 = A0_30._primary_aimer
			L11_41 = L11_41.aim_position
			L11_41 = L11_41(L11_41, A0_30._primary_aim_object:position(), L5_35)
			L10_40 = L11_41
		end
	else
		L10_40 = L5_35
	end
	L11_41 = A3_33.set_aim_target_position
	L11_41(A3_33, L10_40)
	L11_41 = nil
	if A0_30._secondary_aimer then
		if L6_36 then
			L11_41 = A0_30._secondary_aimer:aim_position(A0_30._secondary_aim_object:position(), L6_36)
		end
	else
		L11_41 = L6_36
	end
	A3_33:set_secondary_aim_target_position(L11_41)
	L7_37 = A0_30:_calculate_good_look_at_position(A1_31, L7_37)
	A3_33:set_eye_target_position(L7_37)
	return L5_35, L6_36
end
function WalkerAiNerveSystem._calculate_good_look_at_position(A0_42, A1_43, A2_44)
	local L3_45, L4_46, L5_47
	if not A2_44 then
		return
	end
	L3_45 = 500
	L4_46 = mvector3
	L4_46 = L4_46.distance
	L5_47 = A2_44
	L4_46 = L4_46(L5_47, A0_42._unit_position)
	if L3_45 < L4_46 then
		return A2_44
	end
	L5_47 = A0_42._unit_position
	L5_47 = A2_44 - L5_47
	L5_47 = L5_47 + (L3_45 - L4_46) * L5_47:flat(math.UP):normalized()
	L4_46 = L3_45
	return A0_42._unit_position + L4_46 * Rotation:look_at(L5_47, math.UP):y()
end
function WalkerAiNerveSystem._update_prepare_fire(A0_48, A1_49, A2_50, A3_51)
	local L4_52, L5_53, L6_54
	L5_53 = A1_49.output
	L5_53 = L5_53.currently_targeted_threat
	if L5_53 then
		L5_53 = A0_48._time_since_last_fire
		L6_54 = tweak_data
		L6_54 = L6_54.ai
		L6_54 = L6_54.machines
		L6_54 = L6_54.walker
		L6_54 = L6_54.PREPARE_FIRE_END_TIME
		if L5_53 < L6_54 then
			L4_52 = true
		else
			L6_54 = A1_49
			L5_53 = A1_49.path
			L5_53 = L5_53(L6_54)
			if L5_53 then
				L6_54 = #L5_53
				if L6_54 > 0 then
					L6_54 = #L5_53
					L6_54 = L5_53[L6_54]
					if mvector3.distance(L6_54, A3_51) < tweak_data.ai.machines.walker.PREPARE_FIRE_DISTANCE then
						L4_52 = true
					end
				end
			end
		end
	end
	if L4_52 then
		L6_54 = A2_50
		L5_53 = A2_50.set_prepare_primary_fire
		L5_53(L6_54)
		L6_54 = A2_50
		L5_53 = A2_50.set_prepare_secondary_fire
		L5_53(L6_54)
	end
end
function WalkerAiNerveSystem._update_fire(A0_55, A1_56, A2_57, A3_58, A4_59, A5_60, A6_61, A7_62)
	local L8_63, L9_64, L10_65, L11_66, L12_67, L13_68, L14_69, L15_70, L16_71, L17_72, L18_73, L19_74
	L8_63 = A0_55._unit
	L9_64 = L8_63
	L8_63 = L8_63.enemy_data
	L8_63 = L8_63(L9_64)
	L9_64 = L8_63.reaching_for_target
	if not L9_64 then
		L9_64 = L8_63.reached_target
		L9_64 = L9_64 or L8_63.special_kill_strangul
	end
	L10_65 = A2_57.input
	L10_65.is_executing = L9_64
	L10_65 = A2_57.output
	L10_65 = L10_65.allowed_to_fire
	if not L10_65 then
		return
	end
	L10_65 = false
	L11_66 = true
	L12_67 = A2_57.output
	L13_68 = L12_67.moving_to_execute_target
	L14_69 = alive
	L15_70 = L13_68
	L14_69 = L14_69(L15_70)
	if L14_69 then
		L14_69 = mvector3
		L14_69 = L14_69.distance
		L16_71 = L13_68
		L15_70 = L13_68.position
		L15_70 = L15_70(L16_71)
		L16_71 = A5_60
		L14_69 = L14_69(L15_70, L16_71)
		L16_71 = A2_57
		L15_70 = A2_57.current_path_completed
		L15_70 = L15_70(L16_71)
		if L15_70 then
			L16_71 = L13_68
			L15_70 = L13_68.player_data
			L15_70 = L15_70(L16_71)
			if L15_70 then
				L16_71 = L15_70.in_cover
				L16_71 = L16_71 and L15_70.peeking_up
			else
				if L16_71 then
					L16_71 = WalkerTweakData
					L16_71 = L16_71.EXECUTION_MAX_DISTANCE
					if L14_69 < L16_71 and not L9_64 then
						L16_71 = nil
						L17_72 = L12_67.moving_to_execute_target
						L18_73 = L17_72
						L17_72 = L17_72.player_data
						L17_72 = L17_72(L18_73)
						if L17_72 then
							L18_73 = L17_72.cover_point
							if L18_73 then
								L18_73 = L17_72.is_crouching
								if L18_73 then
									L16_71 = "special_kill_in_cover"
								end
							end
						else
							L16_71 = "special_kill_1"
						end
						L18_73 = L12_67.moving_to_execute_position
						L19_74 = L12_67.moving_to_execute_rotation
						if not L18_73 or not L19_74 then
							L18_73, L19_74 = nil, nil
						end
						A3_58:set_special_kill(L12_67.moving_to_execute_target, L16_71, L18_73, L19_74)
						L11_66 = false
					else
					end
			end
			else
				L16_71 = WalkerTweakData
				L16_71 = L16_71.STRIKE_OF_DEATH_DISTANCE
				if L14_69 < L16_71 then
					L17_72 = L13_68
					L16_71 = L13_68.position
					L16_71 = L16_71(L17_72)
					L16_71 = L16_71 - A5_60
					L17_72 = mvector3
					L17_72 = L17_72.normalize
					L18_73 = L16_71
					L17_72 = L17_72(L18_73)
					if L17_72 < 0.01 then
						L19_74 = A4_59
						L18_73 = A4_59.rotation
						L18_73 = L18_73(L19_74)
						L19_74 = L18_73
						L18_73 = L18_73.y
						L18_73 = L18_73(L19_74)
						L16_71 = L18_73
					end
					L19_74 = A3_58
					L18_73 = A3_58.set_strike_of_death
					L18_73(L19_74, L16_71, L13_68)
					L11_66 = false
				end
			end
		end
	end
	L14_69 = A2_57.output
	L14_69 = L14_69.firing_target
	L15_70 = alive
	L16_71 = L14_69
	L15_70 = L15_70(L16_71)
	if L15_70 then
		L16_71 = L14_69
		L15_70 = L14_69.damage_data
		L15_70 = L15_70(L16_71)
		L16_71 = L15_70
		L15_70 = L15_70.is_fully_damaged
		L15_70 = L15_70(L16_71)
		if not L15_70 then
			L16_71 = L14_69
			L15_70 = L14_69.damage
			L15_70 = L15_70(L16_71)
			L16_71 = not L15_70 or L16_71(L17_72)
			if L16_71 then
				L17_72 = A2_57.output
				L17_72 = L17_72.moving_to_execute_target
				if not L17_72 and not L9_64 then
					L17_72 = A2_57.output
					L17_72 = L17_72.firing_target
					L18_73 = L17_72
					L17_72 = L17_72.position
					L17_72 = L17_72(L18_73)
					L17_72 = L17_72 - A5_60
					if L17_72 then
						L19_74 = L17_72
						L18_73 = L17_72.length
						L18_73 = L18_73(L19_74)
						L19_74 = WalkerTweakData
						L19_74 = L19_74.STRIKE_OF_DEATH_DISTANCE
						if L18_73 < L19_74 then
							L19_74 = A3_58
							L18_73 = A3_58.set_strike_of_death
							L18_73(L19_74, L17_72:normalized(), A2_57.output.firing_target)
							L11_66 = false
						end
					end
				end
			end
		end
	end
	if L11_66 and A6_61 then
		L15_70 = A2_57.output
		L15_70 = L15_70.allowed_to_fire
		if L15_70 then
			L15_70 = IntelUtilities
			L15_70 = L15_70.ai_friendly_fire
			L16_71 = A4_59
			L17_72 = A6_61
			L15_70 = L15_70(L16_71, L17_72)
			if not L15_70 then
				L16_71 = A3_58
				L15_70 = A3_58.set_primary_fire
				L15_70(L16_71)
				L10_65 = true
			end
		end
	end
	if L11_66 and A7_62 then
		L15_70 = A2_57.output
		L15_70 = L15_70.secondary_weapon_allowed_to_fire
		if L15_70 then
			L15_70 = IntelUtilities
			L15_70 = L15_70.ai_friendly_fire
			L16_71 = A4_59
			L17_72 = A7_62
			L15_70 = L15_70(L16_71, L17_72)
			if not L15_70 then
				L15_70 = mvector3
				L15_70 = L15_70.distance
				L16_71 = A0_55._unit_position
				L17_72 = A7_62
				L15_70 = L15_70(L16_71, L17_72)
				L16_71 = WalkerTweakData
				L16_71 = L16_71.SECONDARY_WEAPON_MIN_FIRING_DISTANCE
				if L15_70 > L16_71 then
					L16_71 = A3_58
					L15_70 = A3_58.set_secondary_fire
					L15_70(L16_71)
					L10_65 = true
				end
			end
		end
	end
	if L10_65 then
		A0_55._time_since_last_fire = 0
	else
		L15_70 = A0_55._time_since_last_fire
		L15_70 = L15_70 + A1_56
		A0_55._time_since_last_fire = L15_70
	end
end
function WalkerAiNerveSystem._find_firing_position(A0_75, A1_76, A2_77, A3_78)
	local L4_79, L5_80
	L5_80 = alive
	L5_80 = L5_80(A1_76)
	if L5_80 then
		L5_80 = A1_76.targeting_info
		L5_80 = L5_80(A1_76)
		if L5_80 then
			L4_79 = L5_80:primary_target_position()
		else
			L4_79 = A1_76:oobb():center()
		end
	elseif A2_77 then
		L4_79 = A2_77
	end
	if L4_79 and A3_78 then
		L5_80 = managers
		L5_80 = L5_80.slot
		L5_80 = L5_80.get_mask
		L5_80 = L5_80(L5_80, "statics")
		if World:raycast("ray", L4_79, L4_79 - math.UP * 500, "slot_mask", L5_80, "ignore_unit", A0_75._unit) then
			L4_79 = World:raycast("ray", L4_79, L4_79 - math.UP * 500, "slot_mask", L5_80, "ignore_unit", A0_75._unit).position
		end
	end
	return L4_79
end
function WalkerAiNerveSystem._setup_aimers(A0_81)
	local L1_82, L2_83
	L1_82 = A0_81._primary_aimer_setup
	if L1_82 then
		L2_83 = A0_81._setup_aimer
		L2_83(A0_81, L1_82, "_primary_aimer", "_primary_aim_object")
	end
	L2_83 = A0_81._secondary_aimer_setup
	if L2_83 then
		A0_81:_setup_aimer(L2_83, "_secondary_aimer", "_secondary_aim_object")
	end
end
function WalkerAiNerveSystem._setup_aimer(A0_84, A1_85, A2_86, A3_87)
	local L4_88, L5_89, L6_90, L7_91, L8_92, L9_93
	L4_88 = A1_85.class_name
	L5_89 = assert
	L6_90 = L4_88 and L4_88 ~= ""
	L5_89(L6_90)
	L5_89 = rawget
	L6_90 = _G
	L7_91 = L4_88
	L5_89 = L5_89(L6_90, L7_91)
	L6_90 = A1_85.data
	L8_92 = L5_89
	L7_91 = L5_89.new
	L9_93 = L6_90
	L7_91 = L7_91(L8_92, L9_93)
	A0_84[A2_86] = L7_91
	L8_92 = A1_85.aim_object_name
	L9_93 = assert
	L9_93(L8_92 and L8_92 ~= "")
	L9_93 = A0_84._unit
	L9_93 = L9_93.get_object
	L9_93 = L9_93(L9_93, L8_92)
	assert(L9_93, "Aim object '" .. L8_92 .. "' doesn't exist")
	A0_84[A3_87] = L9_93
end
function WalkerAiNerveSystem._update_weapons_dispersions(A0_94, A1_95, A2_96, A3_97)
	local L4_98
	L4_98 = tweak_data
	L4_98 = L4_98.ai
	L4_98 = L4_98.machines
	L4_98 = L4_98.walker
	A0_94._miss_max_dispersion = L4_98.MISS_MAX_DISPERSION
	A0_94._miss_timer_speed = L4_98.MISS_TIMER_SPEED
	A0_94._number_of_dispersion_weapons = L4_98.NUMBER_OF_DISPERSION_WEAPONS
	return AiNerveSystem._update_weapons_dispersions(A0_94, A1_95, A2_96, A3_97)
end
