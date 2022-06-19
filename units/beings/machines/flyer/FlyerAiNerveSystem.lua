require("units/beings/AiNerveSystem")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
FlyerAiNerveSystem = FlyerAiNerveSystem or class(AiNerveSystem)
FlyerAiNerveSystem.NORMAL_MOVE_SPEED = 1
function FlyerAiNerveSystem.init(A0_0, A1_1)
	local L2_2
	L2_2 = AiNerveSystem
	L2_2 = L2_2.init
	L2_2(A0_0, A1_1)
	A0_0._locked_firing_target = nil
	L2_2 = A1_1.body
	L2_2 = L2_2(A1_1, "default_body")
	A0_0._chassi_body = L2_2
	L2_2 = assert
	L2_2(A0_0._chassi_body)
	L2_2 = math
	L2_2 = L2_2.rand
	L2_2 = L2_2(0.8, 1.2)
	A0_0._flyer_movement = FlyerMovement:new(A0_0._chassi_body, L2_2)
	A0_0._dead_acceleration = nil
	A0_0._dead_approach_acceleration = Vector3(0, 0, 0)
	A0_0._dead_angular_acceleration = nil
	A0_0._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(A0_0.low_frequency_update, "flyer_nervesystem"))
	A0_0._velocity_fraction = 0
	A0_0._look_at_position = nil
	A0_0._next_pos = nil
	A0_0._physics_timer = TimerManager:physics()
	A0_0._damage_data = A1_1:damage_data()
end
function FlyerAiNerveSystem.destroy(A0_3)
	A0_3._low_frequency:remove()
	AiNerveSystem.destroy(A0_3)
end
function FlyerAiNerveSystem.init_default_ai_data(A0_4)
	local L1_5, L2_6
	L1_5 = A0_4._ai_data
	L1_5 = L1_5.input
	L2_6 = A0_4._ai_data
	L2_6 = L2_6.default_speed
	L1_5.speed = L2_6
end
function FlyerAiNerveSystem._end_stun(A0_7)
	A0_7._flyer_movement:reset()
end
function FlyerAiNerveSystem._stun_update(A0_8, A1_9, A2_10, A3_11)
	local L4_12, L5_13, L6_14, L7_15, L8_16, L9_17, L10_18
	L5_13 = A1_9
	L4_12 = A1_9.input
	L4_12 = L4_12(L5_13)
	L6_14 = L4_12
	L5_13 = L4_12.clear
	L5_13(L6_14)
	L5_13 = A0_8._chassi_body
	L6_14 = L5_13
	L5_13 = L5_13.position
	L5_13 = L5_13(L6_14)
	L6_14 = L5_13
	L5_13 = L5_13.with_z
	L7_15 = A0_8._last_target_pos
	L7_15 = L7_15.z
	L5_13 = L5_13(L6_14, L7_15)
	L6_14 = A0_8._flyer_movement
	L7_15 = L6_14
	L6_14 = L6_14.update
	L8_16 = A3_11
	L9_17 = nil
	L10_18 = false
	L7_15 = L6_14(L7_15, L8_16, L9_17, L10_18, false, 0, L5_13, nil)
	L9_17 = L4_12
	L8_16 = L4_12.set_acceleration
	L10_18 = L6_14
	L8_16(L9_17, L10_18)
	L9_17 = L4_12
	L8_16 = L4_12.set_angular_acceleration
	L10_18 = L7_15
	L8_16(L9_17, L10_18)
end
function FlyerAiNerveSystem.update(A0_19, A1_20, A2_21, A3_22)
	if A0_19._damage_data.fully_damaged then
		A0_19:_update_dead(A1_20, A2_21, A3_22)
		return
	end
	if not AiNerveSystem.update(A0_19, A1_20, A2_21, A3_22) then
		A1_20:input():clear()
		return
	end
	if A0_19._waypoint_options and A0_19._waypoint_options.speed then
		A0_19._velocity_fraction = A0_19._waypoint_options.speed
	else
		A0_19._velocity_fraction = A0_19._ai_data.output.move_speed
	end
	if not A0_19._low_frequency:update(A0_19, A3_22, A1_20, A2_21) then
		A0_19:_update_move(A1_20, A2_21, A3_22, false)
	end
end
function FlyerAiNerveSystem.low_frequency_update(A0_23, A1_24, A2_25, A3_26)
	local L4_27, L5_28, L6_29, L7_30
	L4_27 = AiNerveSystem
	L4_27 = L4_27.low_frequency_update
	L5_28 = A0_23
	L6_29 = A2_25
	L7_30 = A3_26
	L4_27(L5_28, L6_29, L7_30, A1_24)
	L5_28 = A2_25
	L4_27 = A2_25.enemy_data
	L4_27 = L4_27(L5_28)
	L5_28 = A0_23._ai_data
	L5_28 = L5_28.output
	L6_29, L7_30 = nil, nil
	if not L4_27.preparing_to_fire and not L4_27.is_firing or not A0_23._locked_firing_target then
		A0_23._locked_firing_target = L5_28.firing_target
	end
	if L5_28.allowed_to_fire and (A0_23._chassi_body:velocity():length() < tweak_data.ai.machines.flyer.MAX_FIRE_VELOCITY or A0_23._ai_data.no_max_fire_velocity) then
		if alive(A0_23._locked_firing_target) then
			if A0_23._locked_firing_target:targeting_info() then
				L6_29 = A0_23._locked_firing_target:targeting_info():primary_target_position()
			else
				L6_29 = A0_23._locked_firing_target:oobb():center()
			end
			L7_30 = true
		elseif A0_23._ai_data.output.firing_target_position then
			L6_29 = L5_28.firing_target_position
			L7_30 = true
		end
		if L7_30 and IntelUtilities.ai_friendly_fire(A2_25, L6_29) then
			L7_30 = false
		end
	end
	L7_30 = A0_23:_burst_fire(A3_26, L7_30, L4_27.firing)
	A0_23._look_at_position = A0_23:_get_look_at_position(A0_23._next_pos, L6_29)
	L6_29 = L6_29 or A0_23._look_at_position
	A2_25:input():clear()
	A0_23:_update_move(A2_25, A3_26, A1_24, true)
	A2_25:input():set_aim_target_position(L6_29)
	if L7_30 then
		A2_25:input():set_fire()
		A2_25:input():set_miss_dispersion(A0_23:_update_weapons_dispersions(A2_25, {
			A0_23._locked_firing_target
		}, A1_24)[1])
	end
	A2_25:input():set_defensive(L5_28.defensive)
	A0_23._ai_data.input.is_firing = L4_27.preparing_to_fire or L4_27.is_firing
	if L5_28.self_destroy then
		A2_25:input():set_self_destroy()
	end
end
function FlyerAiNerveSystem._update_move(A0_31, A1_32, A2_33, A3_34, A4_35)
	local L5_36, L6_37, L7_38, L8_39, L9_40, L10_41, L11_42, L12_43, L13_44
	if not A4_35 then
		L6_37 = A0_31
		L5_36 = A0_31._update_path
		L7_38 = A1_32
		L8_39 = A2_33
		L5_36(L6_37, L7_38, L8_39)
	end
	L5_36 = A0_31._look_at_position
	if not L5_36 then
		L6_37 = A0_31
		L5_36 = A0_31._get_look_at_position
		L7_38 = A0_31._next_pos
		L8_39 = nil
		L5_36 = L5_36(L6_37, L7_38, L8_39)
	end
	A0_31._look_at_position = L5_36
	L5_36 = A0_31._move_to_position
	if not L5_36 then
		L5_36 = A0_31._last_target_pos
		if not L5_36 then
			L5_36 = A0_31._chassi_body
			L6_37 = L5_36
			L5_36 = L5_36.position
			L5_36 = L5_36(L6_37)
		end
	end
	A0_31._last_target_pos = L5_36
	L5_36 = A0_31._move_to_position
	if L5_36 then
		L5_36 = A0_31._ai_data
		L6_37 = L5_36
		L5_36 = L5_36.path
		L5_36 = L5_36(L6_37)
		if L5_36 then
			L5_36 = A0_31._ai_data
			L6_37 = L5_36
			L5_36 = L5_36.path
			L5_36 = L5_36(L6_37)
			L6_37 = A0_31._current_path_index
			L6_37 = L6_37 + 1
			L5_36 = L5_36[L6_37]
			A0_31._next_pos = L5_36
		end
	else
		A0_31._next_pos = nil
	end
	L5_36 = A0_31._physics_timer
	L6_37 = L5_36
	L5_36 = L5_36.delta_time
	L5_36 = L5_36(L6_37)
	L7_38 = A1_32
	L6_37 = A1_32.input
	L6_37 = L6_37(L7_38)
	L7_38 = A0_31._velocity_fraction
	if L7_38 > 0.001 then
		L8_39 = A0_31
		L7_38 = A0_31._force_path
		L7_38 = L7_38(L8_39)
		L8_39 = A0_31._ai_data
		L8_39 = L8_39.output
		L8_39 = L8_39.allowed_to_strafe
		if L8_39 then
			L8_39 = A0_31._ai_data
			L9_40 = L8_39
			L8_39 = L8_39.path
			L8_39 = L8_39(L9_40)
			if L8_39 then
				L8_39 = A0_31._ai_data
				L9_40 = L8_39
				L8_39 = L8_39.path
				L8_39 = L8_39(L9_40)
				L8_39 = #L8_39
				L8_39 = L8_39 == 1
			end
		end
		L9_40 = A0_31._flyer_movement
		L10_41 = L9_40
		L9_40 = L9_40.update
		L11_42 = L5_36
		L12_43 = A0_31._look_at_position
		L13_44 = L8_39
		L10_41 = L9_40(L10_41, L11_42, L12_43, L13_44, L7_38, A0_31._velocity_fraction, A0_31._last_target_pos, A0_31._next_pos)
		L12_43 = L6_37
		L11_42 = L6_37.set_acceleration
		L13_44 = L9_40
		L11_42(L12_43, L13_44)
		L12_43 = L6_37
		L11_42 = L6_37.set_angular_acceleration
		L13_44 = L10_41
		L11_42(L12_43, L13_44)
	else
		L8_39 = L6_37
		L7_38 = L6_37.set_acceleration
		L9_40 = Vector3
		L10_41 = 0
		L11_42 = 0
		L12_43 = 0
		L13_44 = L9_40(L10_41, L11_42, L12_43)
		L7_38(L8_39, L9_40, L10_41, L11_42, L12_43, L13_44, L9_40(L10_41, L11_42, L12_43))
		L8_39 = L6_37
		L7_38 = L6_37.set_angular_acceleration
		L9_40 = Vector3
		L10_41 = 0
		L11_42 = 0
		L12_43 = 0
		L13_44 = L9_40(L10_41, L11_42, L12_43)
		L7_38(L8_39, L9_40, L10_41, L11_42, L12_43, L13_44, L9_40(L10_41, L11_42, L12_43))
	end
end
function FlyerAiNerveSystem._get_look_at_position(A0_45, A1_46, A2_47)
	local L3_48
	if A2_47 then
		L3_48 = A2_47
	elseif A0_45._ai_data.output.look_at_position then
		L3_48 = A0_45._ai_data.output.look_at_position
	elseif A0_45._waypoint_rotation_look_at_position then
		L3_48 = A0_45._waypoint_rotation_look_at_position
	elseif A0_45._move_to_position then
		if A1_46 then
			L3_48 = math.lerp(A1_46, A0_45._move_to_position, math.min(1, (A0_45._chassi_body:position() - A0_45._move_to_position):length() / 500))
		else
			L3_48 = A0_45._move_to_position
		end
	else
		L3_48 = A0_45._chassi_body:position()
	end
	if (L3_48 - A0_45._chassi_body:position()):length() < 50 then
		L3_48 = L3_48 + 500 * A0_45._chassi_body:rotation():y()
	end
	return L3_48
end
function FlyerAiNerveSystem._update_dead(A0_49, A1_50, A2_51, A3_52)
	local L4_53, L5_54, L6_55, L7_56, L8_57
	L4_53 = A0_49._braindead
	if not L4_53 then
		L5_54 = A0_49
		L4_53 = A0_49._kill_brain
		L4_53(L5_54)
	end
	L4_53 = AiNerveSystem
	L4_53 = L4_53.update
	L5_54 = A0_49
	L6_55 = A1_50
	L7_56 = A2_51
	L8_57 = A3_52
	L4_53(L5_54, L6_55, L7_56, L8_57)
	L5_54 = A1_50
	L4_53 = A1_50.input
	L4_53 = L4_53(L5_54)
	L6_55 = L4_53
	L5_54 = L4_53.clear
	L5_54(L6_55)
	L5_54 = NavigationGraphUtilities
	L5_54 = L5_54.get_on_ground_position
	L6_55 = A0_49._unit_position
	L5_54 = L5_54(L6_55)
	if L5_54 then
		L6_55 = mvector3
		L6_55 = L6_55.distance
		L7_56 = A0_49._unit_position
		L8_57 = L5_54
		L6_55 = L6_55(L7_56, L8_57)
		if L6_55 < 100 then
			return
		end
	end
	L6_55 = A0_49._chassi_body
	L7_56 = L6_55
	L6_55 = L6_55.rotation
	L6_55 = L6_55(L7_56)
	L7_56 = A0_49._dead_acceleration
	if not L7_56 then
		L8_57 = L6_55
		L7_56 = L6_55.y
		L7_56 = L7_56(L8_57)
		L8_57 = L6_55.z
		L8_57 = L8_57(L6_55)
		if A0_49._chassi_body:velocity():dot(L7_56) > 500 then
			A0_49._dead_approach_acceleration = A0_49._chassi_body:velocity() * 1
		end
		A0_49._dead_acceleration = 0.1 * (math.rand(1000, 1200) * L8_57:spread(20))
		A0_49._dead_angular_acceleration = math.rand(1000, 1200) / 180 * L8_57:spread(20):cross(L8_57):normalized()
	end
	L8_57 = L4_53
	L7_56 = L4_53.set_acceleration
	L7_56(L8_57, A0_49._dead_acceleration:rotate_with(L6_55) + A0_49._dead_approach_acceleration)
	L8_57 = L4_53
	L7_56 = L4_53.set_angular_acceleration
	L7_56(L8_57, A0_49._dead_angular_acceleration)
end
function FlyerAiNerveSystem._update_weapons_dispersions(A0_58, A1_59, A2_60, A3_61)
	local L4_62
	L4_62 = tweak_data
	L4_62 = L4_62.ai
	L4_62 = L4_62.machines
	L4_62 = L4_62.flyer
	A0_58._miss_max_dispersion = L4_62.MISS_MAX_DISPERSION
	A0_58._miss_timer_speed = L4_62.MISS_TIMER_SPEED
	A0_58._number_of_dispersion_weapons = L4_62.NUMBER_OF_DISPERSION_WEAPONS
	return AiNerveSystem._update_weapons_dispersions(A0_58, A1_59, A2_60, A3_61)
end
function FlyerAiNerveSystem._burst_fire(A0_63, A1_64, A2_65, A3_66)
	local L4_67
	L4_67 = tweak_data
	L4_67 = L4_67.ai
	L4_67 = L4_67.machines
	L4_67 = L4_67.flyer
	A0_63._burst_mean_time = L4_67.BURST_LENGTH
	A0_63._burst_standard_deviation_time = 2 * L4_67.BURST_LENGTH
	A0_63._burst_max_deviation_time = 0.4 * L4_67.BURST_LENGTH
	A0_63._burst_pause_mean_time = L4_67.TIME_BETWEEN_BURSTS
	A0_63._burst_pause_standard_deviation_time = 2 * L4_67.TIME_BETWEEN_BURSTS
	A0_63._burst_pause_max_deviation_time = 0.4 * L4_67.TIME_BETWEEN_BURSTS
	return AiNerveSystem._burst_fire(A0_63, A1_64, A2_65, A3_66)
end
