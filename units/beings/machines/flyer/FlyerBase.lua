require("shared/Interpolator")
require("units/beings/machines/flyer/states/FlyerNormalState")
require("units/beings/machines/flyer/states/FlyerFullyDamagedState")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
if not FlyerBase then
	FlyerBase = class()
end
local l_0_0 = "aim"
FlyerBase.init = function(l_1_0, l_1_1)
	-- upvalues: l_0_0
	l_1_0._unit = l_1_1
	l_1_1:set_driving("orientation_object")
	local l_1_2 = l_1_1:enemy_data()
	l_1_0._enemy_data = l_1_2
	l_1_0._damage_data = l_1_1:damage_data()
	l_1_0._input = l_1_1:input()
	l_1_2.can_shoot = false
	l_1_0:_setup_weapons()
	local l_1_3 = l_1_1:get_object(l_0_0)
	l_1_0._aim_object = l_1_3
	l_1_0._aim_pose_aimer = AimPoseAimer:new(l_1_1:anim_state_machine(), l_1_3, "gun_yaw", "gun_pitch", 40)
	l_1_0._chassi_body = l_1_1:body("default_body")
	assert(l_1_0._chassi_body)
	l_1_0:_enter_state(FlyerNormalState:new(l_1_1))
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_1_0.low_frequency_update, "flyer_base"))
	l_1_0._engine_effect_object = l_1_1:get_object("e_engine")
	l_1_0._ai_data = l_1_1:ai_data()
	l_1_0._weapon_data = l_1_0._weapon:weapon_data()
	l_1_0._damage = l_1_1:damage()
	l_1_0._sound = l_1_1:sound()
	l_1_0._effects = l_1_1:effects()
end

FlyerBase.destroy = function(l_2_0)
	l_2_0._low_frequency:remove()
	local l_2_1 = l_2_0._unit
	if l_2_0._engine_started then
		l_2_0._emitter:engine_thrust_stop(l_2_1)
	end
	managers.unit_scripting:unit_destroyed(l_2_1)
	local l_2_2 = l_2_0._state
	if l_2_2 and l_2_2.leave then
		l_2_2:leave()
	end
	l_2_0:_destroy_weapons()
	l_2_0._emitter:destroy()
end

FlyerBase.chassi_body = function(l_3_0)
	return l_3_0._chassi_body
end

FlyerBase._enter_state = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._state
	if l_4_2 and l_4_2.leave then
		l_4_2:leave()
	end
	l_4_0._state = l_4_1
	if l_4_1.enter then
		l_4_1:enter()
	end
end

FlyerBase._update_state = function(l_5_0, l_5_1)
	local l_5_2 = l_5_0._state
	if l_5_2.update then
		local l_5_3 = l_5_2:update(l_5_1)
	if l_5_3 then
		end
		l_5_0:_enter_state(l_5_3)
	end
end

FlyerBase._disable_weapons = function(l_6_0)
	l_6_0._weapon_data.fire_input = 0
end

FlyerBase._setup_weapons = function(l_7_0)
	local l_7_1 = l_7_0._unit
	local l_7_2 = World:spawn_unit(l_7_0._weapon_class, l_7_1:position(), l_7_1:rotation())
	local l_7_3 = l_7_2:base()
	l_7_3:setup(l_7_1, l_7_0._weapon_parent_object_name)
	l_7_3:set_equiped(true)
	l_7_0._weapon = l_7_2
end

FlyerBase._destroy_weapons = function(l_8_0)
	local l_8_1 = l_8_0._weapon
	if alive(l_8_1) then
		World:delete_unit(l_8_1)
		l_8_0._weapon = nil
	end
end

FlyerBase.update = function(l_9_0, l_9_1, l_9_2, l_9_3)
	if not l_9_0._camera_data then
		l_9_0._camera_data = l_9_1:camera_data()
		assert(l_9_0._camera_data)
	end
	l_9_0._camera_data.eye_target_position = l_9_0._input:eye_target_position()
	l_9_0._damage:update_damage(l_9_1, l_9_2, l_9_3)
	l_9_0:_update_state(l_9_3)
	l_9_0:_update_movement(l_9_3)
	l_9_0._low_frequency:update(l_9_0, l_9_3)
	l_9_0._effects:update_effects(l_9_1, l_9_2, l_9_3)
end

FlyerBase.low_frequency_update = function(l_10_0, l_10_1)
	l_10_0:_update_weapons_and_aiming(l_10_1)
	l_10_0:_check_detected_threat()
	l_10_0:_update_engines(l_10_1)
end

FlyerBase._check_detected_threat = function(l_11_0)
	local l_11_1 = l_11_0._unit
	local l_11_2 = l_11_0._ai_data.output.detected_threat
	if not l_11_0._previous_detected_threat and l_11_2 then
		l_11_0._emitter:unit_detected_threat(l_11_1)
	end
	l_11_0._previous_detected_threat = l_11_2
end

FlyerBase._update_weapons_and_aiming = function(l_12_0, l_12_1)
	local l_12_2 = l_12_0._input:aim_target_position()
	l_12_0:_update_weapon_aiming(l_12_1, l_12_2)
	l_12_0:_update_weapons(l_12_2)
	l_12_0._enemy_data.firing = l_12_0._weapon_data._firing
end

FlyerBase._update_engines = function(l_13_0, l_13_1)
	local l_13_2 = l_13_0._unit
	if not l_13_0._engine_started then
		local l_13_3 = l_13_0._engine_effect_object
		local l_13_4 = {}
		l_13_4.parent = l_13_3
		l_13_4.force_synch = true
		l_13_0._emitter:engine_thrust_start(l_13_2, l_13_4)
		l_13_0._engine_started = true
	end
	local l_13_5 = mvector3.length(l_13_0._chassi_body:velocity())
	local l_13_6 = l_13_5 / 1000
	local l_13_7 = math.clamp(l_13_6, 0, 1)
	l_13_0._enemy_data.engine_thrust = l_13_7
	l_13_0._sound:update_engine_sound(l_13_5)
end

FlyerBase._update_weapon_aiming = function(l_14_0, l_14_1, l_14_2)
	if l_14_0._input:fire() and not l_14_0._enemy_data.can_shoot then
		l_14_0._unit:play_redirect("eject_gun")
		return 
	end
	if l_14_2 then
		l_14_0._aim_pose_aimer:update(l_14_1, l_14_2, 45, 45, 45, 45, nil, nil, nil, nil, true)
	end
end

FlyerBase._update_movement = function(l_15_0, l_15_1)
	local l_15_2 = l_15_0._input
	local l_15_3 = l_15_2:acceleration()
	local l_15_4 = l_15_2:angular_acceleration()
	local l_15_5 = l_15_0._chassi_body
	l_15_5:accelerate(l_15_3)
	l_15_5:rot_accelerate(l_15_4)
end

FlyerBase._update_weapons = function(l_16_0, l_16_1)
	local l_16_2 = l_16_0:_weapon_aim_position(l_16_1)
	local l_16_3 = l_16_0._weapon
	local l_16_4 = l_16_0._input
	local l_16_5 = l_16_0._weapon_data
	local l_16_6 = nil
	if l_16_5._reload_ready and l_16_5._reload_required then
		l_16_5._reload_request = true
		l_16_6 = 0
	else
		if l_16_0._enemy_data.can_shoot and l_16_4:fire() and l_16_2 then
			l_16_6 = 1
		end
	else
		l_16_6 = 0
	end
	l_16_5.fire_input = l_16_6
	if l_16_2 then
		l_16_5.aim_target_position = l_16_2
	end
	l_16_5.miss_dispersion = l_16_4:miss_dispersion()
end

FlyerBase._weapon_aim_position = function(l_17_0, l_17_1)
	local l_17_2 = l_17_0._aim_object
	local l_17_3 = l_17_2:position()
	local l_17_4 = l_17_2:rotation()
	local l_17_5 = (l_17_4:y())
	local l_17_6 = nil
	if l_17_1 then
		local l_17_7 = l_17_1 - l_17_3
		local l_17_8 = mvector3.normalize(l_17_7)
	if l_17_8 > 0.01 then
		end
		assert(l_17_0._aim_target_angle_tolerance)
		if mvector3.angle(l_17_7, l_17_5) < l_17_0._aim_target_angle_tolerance then
			l_17_6 = l_17_1
		end
	else
		return nil
	end
	if not l_17_6 then
		l_17_6 = l_17_3 + l_17_5 * 1000
	end
	return l_17_6
end

FlyerBase.set_search_light_enabled = function(l_18_0, l_18_1)
	if l_18_1 then
		local l_18_2, l_18_3 = "light_on"
	else
		local l_18_4 = "light_off"
	end
	if l_18_1 and not l_18_0._enemy_data.can_shoot then
		l_18_0._unit:play_redirect("eject_gun")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	managers.sequence:run_sequence_simple(l_18_4, l_18_0._unit)
end

FlyerBase.check_fully_damaged = function(l_19_0)
	if l_19_0._damage_data:is_fully_damaged() then
		local l_19_1, l_19_2 = FlyerFullyDamagedState:new, FlyerFullyDamagedState
		local l_19_3 = l_19_0._unit
		return l_19_1(l_19_2, l_19_3)
	end
end


