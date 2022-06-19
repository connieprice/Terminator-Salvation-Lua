local L0_0
L0_0 = require
L0_0("shared/Interpolator")
L0_0 = require
L0_0("units/beings/machines/flyer/states/FlyerNormalState")
L0_0 = require
L0_0("units/beings/machines/flyer/states/FlyerFullyDamagedState")
L0_0 = require
L0_0("shared/updatescheduler/UpdateSchedulerDtMethod")
L0_0 = FlyerBase
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
FlyerBase = L0_0
L0_0 = "aim"
function FlyerBase.init(A0_1, A1_2)
	local L2_3, L3_4
	A0_1._unit = A1_2
	L3_4 = A1_2
	L2_3 = A1_2.set_driving
	L2_3(L3_4, "orientation_object")
	L3_4 = A1_2
	L2_3 = A1_2.enemy_data
	L2_3 = L2_3(L3_4)
	A0_1._enemy_data = L2_3
	L3_4 = A1_2.damage_data
	L3_4 = L3_4(A1_2)
	A0_1._damage_data = L3_4
	L3_4 = A1_2.input
	L3_4 = L3_4(A1_2)
	A0_1._input = L3_4
	L2_3.can_shoot = false
	L3_4 = A0_1._setup_weapons
	L3_4(A0_1)
	L3_4 = A1_2.get_object
	L3_4 = L3_4(A1_2, _UPVALUE0_)
	A0_1._aim_object = L3_4
	A0_1._aim_pose_aimer = AimPoseAimer:new(A1_2:anim_state_machine(), L3_4, "gun_yaw", "gun_pitch", 40)
	A0_1._chassi_body = A1_2:body("default_body")
	assert(A0_1._chassi_body)
	A0_1:_enter_state(FlyerNormalState:new(A1_2))
	A0_1._emitter = managers.action_event:create_emitter(A1_2)
	A0_1._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(A0_1.low_frequency_update, "flyer_base"))
	A0_1._engine_effect_object = A1_2:get_object("e_engine")
	A0_1._ai_data = A1_2:ai_data()
	A0_1._weapon_data = A0_1._weapon:weapon_data()
	A0_1._damage = A1_2:damage()
	A0_1._sound = A1_2:sound()
	A0_1._effects = A1_2:effects()
end
function FlyerBase.destroy(A0_5)
	local L1_6
	L1_6 = A0_5._low_frequency
	L1_6 = L1_6.remove
	L1_6(L1_6)
	L1_6 = A0_5._unit
	if A0_5._engine_started then
		A0_5._emitter:engine_thrust_stop(L1_6)
	end
	managers.unit_scripting:unit_destroyed(L1_6)
	if A0_5._state and A0_5._state.leave then
		A0_5._state:leave()
	end
	A0_5:_destroy_weapons()
	A0_5._emitter:destroy()
end
function FlyerBase.chassi_body(A0_7)
	local L1_8
	L1_8 = A0_7._chassi_body
	return L1_8
end
function FlyerBase._enter_state(A0_9, A1_10)
	local L2_11
	L2_11 = A0_9._state
	if L2_11 and L2_11.leave then
		L2_11:leave()
	end
	A0_9._state = A1_10
	if A1_10.enter then
		A1_10:enter()
	end
end
function FlyerBase._update_state(A0_12, A1_13)
	local L2_14, L3_15
	L2_14 = A0_12._state
	L3_15 = L2_14.update
	if L3_15 then
		L3_15 = L2_14.update
		L3_15 = L3_15(L2_14, A1_13)
		if L3_15 then
			A0_12:_enter_state(L3_15)
		end
	end
end
function FlyerBase._disable_weapons(A0_16)
	A0_16._weapon_data.fire_input = 0
end
function FlyerBase._setup_weapons(A0_17)
	local L1_18, L2_19
	L1_18 = A0_17._unit
	L2_19 = World
	L2_19 = L2_19.spawn_unit
	L2_19 = L2_19(L2_19, A0_17._weapon_class, L1_18:position(), L1_18:rotation())
	L2_19:base():setup(L1_18, A0_17._weapon_parent_object_name)
	L2_19:base():set_equiped(true)
	A0_17._weapon = L2_19
end
function FlyerBase._destroy_weapons(A0_20)
	local L1_21
	L1_21 = A0_20._weapon
	if alive(L1_21) then
		World:delete_unit(L1_21)
		A0_20._weapon = nil
	end
end
function FlyerBase.update(A0_22, A1_23, A2_24, A3_25)
	if not A0_22._camera_data then
		A0_22._camera_data = A1_23:camera_data()
		assert(A0_22._camera_data)
	end
	A0_22._camera_data.eye_target_position = A0_22._input:eye_target_position()
	A0_22._damage:update_damage(A1_23, A2_24, A3_25)
	A0_22:_update_state(A3_25)
	A0_22:_update_movement(A3_25)
	A0_22._low_frequency:update(A0_22, A3_25)
	A0_22._effects:update_effects(A1_23, A2_24, A3_25)
end
function FlyerBase.low_frequency_update(A0_26, A1_27)
	A0_26:_update_weapons_and_aiming(A1_27)
	A0_26:_check_detected_threat()
	A0_26:_update_engines(A1_27)
end
function FlyerBase._check_detected_threat(A0_28)
	local L1_29, L2_30
	L1_29 = A0_28._unit
	L2_30 = A0_28._ai_data
	L2_30 = L2_30.output
	L2_30 = L2_30.detected_threat
	if not A0_28._previous_detected_threat and L2_30 then
		A0_28._emitter:unit_detected_threat(L1_29)
	end
	A0_28._previous_detected_threat = L2_30
end
function FlyerBase._update_weapons_and_aiming(A0_31, A1_32)
	local L2_33
	L2_33 = A0_31._input
	L2_33 = L2_33.aim_target_position
	L2_33 = L2_33(L2_33)
	A0_31:_update_weapon_aiming(A1_32, L2_33)
	A0_31:_update_weapons(L2_33)
	A0_31._enemy_data.firing = A0_31._weapon_data._firing
end
function FlyerBase._update_engines(A0_34, A1_35)
	local L2_36, L3_37, L4_38
	L2_36 = A0_34._unit
	L3_37 = A0_34._engine_started
	if not L3_37 then
		L3_37 = A0_34._engine_effect_object
		L4_38 = {}
		L4_38.parent = L3_37
		L4_38.force_synch = true
		A0_34._emitter:engine_thrust_start(L2_36, L4_38)
		A0_34._engine_started = true
	end
	L3_37 = mvector3
	L3_37 = L3_37.length
	L4_38 = A0_34._chassi_body
	L4_38 = L4_38.velocity
	L4_38 = L4_38(L4_38)
	L3_37 = L3_37(L4_38, L4_38(L4_38))
	L4_38 = L3_37 / 1000
	A0_34._enemy_data.engine_thrust = math.clamp(L4_38, 0, 1)
	A0_34._sound:update_engine_sound(L3_37)
end
function FlyerBase._update_weapon_aiming(A0_39, A1_40, A2_41)
	if A0_39._input:fire() and not A0_39._enemy_data.can_shoot then
		A0_39._unit:play_redirect("eject_gun")
		return
	end
	if A2_41 then
		A0_39._aim_pose_aimer:update(A1_40, A2_41, 45, 45, 45, 45, nil, nil, nil, nil, true)
	end
end
function FlyerBase._update_movement(A0_42, A1_43)
	local L2_44, L3_45, L4_46
	L2_44 = A0_42._input
	L4_46 = L2_44
	L3_45 = L2_44.acceleration
	L3_45 = L3_45(L4_46)
	L4_46 = L2_44.angular_acceleration
	L4_46 = L4_46(L2_44)
	A0_42._chassi_body:accelerate(L3_45)
	A0_42._chassi_body:rot_accelerate(L4_46)
end
function FlyerBase._update_weapons(A0_47, A1_48)
	if A0_47._weapon_data._reload_ready and A0_47._weapon_data._reload_required then
		A0_47._weapon_data._reload_request = true
	elseif A0_47._enemy_data.can_shoot and A0_47._input:fire() and A0_47:_weapon_aim_position(A1_48) then
	else
	end
	A0_47._weapon_data.fire_input = 0
	if A0_47:_weapon_aim_position(A1_48) then
		A0_47._weapon_data.aim_target_position = A0_47:_weapon_aim_position(A1_48)
	end
	A0_47._weapon_data.miss_dispersion = A0_47._input:miss_dispersion()
end
function FlyerBase._weapon_aim_position(A0_49, A1_50)
	local L2_51, L3_52, L4_53, L5_54, L6_55, L7_56
	L2_51 = A0_49._aim_object
	L4_53 = L2_51
	L3_52 = L2_51.position
	L3_52 = L3_52(L4_53)
	L5_54 = L2_51
	L4_53 = L2_51.rotation
	L4_53 = L4_53(L5_54)
	L6_55 = L4_53
	L5_54 = L4_53.y
	L5_54 = L5_54(L6_55)
	L6_55 = nil
	if A1_50 then
		L7_56 = A1_50 - L3_52
		if mvector3.normalize(L7_56) > 0.01 then
			assert(A0_49._aim_target_angle_tolerance)
			if mvector3.angle(L7_56, L5_54) < A0_49._aim_target_angle_tolerance then
				L6_55 = A1_50
			else
				return nil
			end
		end
	end
	if not L6_55 then
		L7_56 = L5_54 * 1000
		L6_55 = L3_52 + L7_56
	end
	return L6_55
end
function FlyerBase.set_search_light_enabled(A0_57, A1_58)
	local L2_59, L3_60
	if A1_58 then
		L2_59 = "light_on"
	else
		L2_59 = "light_off"
	end
	L3_60 = A0_57._unit
	A0_57._debug_search_light_enabled = A1_58
	if A1_58 and not A0_57._enemy_data.can_shoot then
		L3_60:play_redirect("eject_gun")
	end
	managers.sequence:run_sequence_simple(L2_59, L3_60)
end
function FlyerBase.check_fully_damaged(A0_61)
	if A0_61._damage_data:is_fully_damaged() then
		return FlyerFullyDamagedState:new(A0_61._unit)
	end
end
