if not SkynetDefenceTurretBase then
	SkynetDefenceTurretBase = class()
end
SkynetDefenceTurretBase._AIM_OBJECT_NAME_MISSILE = "a_fire_missile_left_top"
SkynetDefenceTurretBase._AIM_OBJECT_NAME_GATLING = "a_gatling_fire"
SkynetDefenceTurretBase._AIM_OBJECT_NAME_TURRET = "at_turret_yaw"
SkynetDefenceTurretBase._PITCH_OBJECT_NAME_MISSILE = "at_missile_pitch"
SkynetDefenceTurretBase._PITCH_OBJECT_NAME_GATLING = "at_gatling_pitch"
SkynetDefenceTurretBase._YAW_OBJECT_NAME_TURRET = "at_turret_yaw"
SkynetDefenceTurretBase._CENTER_OBJECT_NAME = "at_turret_yaw"
SkynetDefenceTurretBase._MAX_ANGLE_VELOCITY = 90
SkynetDefenceTurretBase.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._input = l_1_0._unit:input()
	l_1_0._aim_object_missile = l_1_0._unit:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_MISSILE)
	l_1_0._aim_object_gatling = l_1_0._unit:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_GATLING)
	l_1_0._aim_object_turret = l_1_0._unit:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_TURRET)
	l_1_0._pitch_object_missile = l_1_0._unit:get_object(SkynetDefenceTurretBase._PITCH_OBJECT_NAME_MISSILE)
	l_1_0._pitch_object_gatling = l_1_0._unit:get_object(SkynetDefenceTurretBase._PITCH_OBJECT_NAME_GATLING)
	l_1_0._yaw_object_turret = l_1_0._unit:get_object(SkynetDefenceTurretBase._YAW_OBJECT_NAME_TURRET)
	l_1_0._prev_aim_target_position = Vector3(0, 0, 0)
	l_1_0._prev_aim_target_position_update = Vector3(0, 0, 0)
	l_1_0._same_aim_target_pos = 10
	l_1_0._same_aim_target_pos_cnt = 0
	l_1_0:_setup_weapons()
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
end

SkynetDefenceTurretBase._setup_weapons = function(l_2_0)
	local l_2_1 = World:spawn_unit(l_2_0._weapon_class_missile, l_2_0._unit:position(), l_2_0._unit:rotation())
	assert(l_2_1)
	l_2_1:base():setup(l_2_0._unit, l_2_0._weapon_class_missile_object_names)
	l_2_1:base():set_equiped(true)
	l_2_0._weapon_missile = l_2_1
	local l_2_2 = World:spawn_unit(l_2_0._weapon_class_gatling, l_2_0._unit:position(), l_2_0._unit:rotation())
	assert(l_2_2)
	l_2_2:base():setup(l_2_0._unit)
	l_2_2:base():set_rotation_object(l_2_0._unit:get_object("at_gatling_barrel_rotate"))
	l_2_2:base():set_fire_object(l_2_0._unit, "a_gatling_fire")
	l_2_2:base():set_equiped(true)
	l_2_0._weapon_gatling = l_2_2
end

SkynetDefenceTurretBase.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if not l_3_0._input:aim_target_position() then
		local l_3_4, l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12 = Vector3(0, 0, 0)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_0._prev_aim_target_position - l_3_4:length() > 1 or l_3_0._prev_aim_target_position_update - l_3_4:length() > 30 then
		l_3_0._same_aim_target_pos_cnt = 0
	else
		l_3_0._same_aim_target_pos_cnt = l_3_0._same_aim_target_pos_cnt + 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_4 and l_3_0._same_aim_target_pos_cnt <= l_3_0._same_aim_target_pos then
		l_3_0:_update_weapon_aiming(l_3_3, l_3_4)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_3_0._prev_aim_target_position_update = l_3_4
	end
	l_3_0:_update_weapon(l_3_0._weapon_missile, l_3_0._input:fire_missile(), l_3_0._input:aim_target_position_missile())
	l_3_0:_update_weapon(l_3_0._weapon_gatling, l_3_0._input:fire_gatling(), l_3_0._input:aim_target_position())
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_3_0._prev_aim_target_position = l_3_4
end

SkynetDefenceTurretBase._update_weapon = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = l_4_1:weapon_data()
	local l_4_5 = l_4_1:base()
	if l_4_2 and l_4_3 and not l_4_4._bullets_in_clip == 0 then
		l_4_4.fire_input = 1
	else
		l_4_4.fire_input = 0
	end
	if l_4_3 then
		l_4_4.aim_target_position = l_4_3
	end
	l_4_4.miss_dispersion = l_4_0._input:miss_dispersion()
end

SkynetDefenceTurretBase._update_weapon_aiming = function(l_5_0, l_5_1, l_5_2)
	if l_5_2 then
		l_5_0:_update_turret_yaw(l_5_1, l_5_2)
		l_5_0:_update_missile_pitch(l_5_1, l_5_2)
		l_5_0:_update_gatling_pitch(l_5_1, l_5_2)
		l_5_0._unit:set_moving()
	end
end

SkynetDefenceTurretBase._update_turret_yaw = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = l_6_0:_get_delta_pitch_and_yaw(l_6_1, l_6_0._aim_object_turret, l_6_2)
	local l_6_4 = l_6_3.delta_yaw
	local l_6_5 = l_6_0._yaw_object_turret:new_local_rotation()
	local l_6_6 = l_6_5 + Rotation(Vector3(0, 0, -1), l_6_4)
	l_6_0._yaw_object_turret:new_set_local_rotation(l_6_6)
end

SkynetDefenceTurretBase._update_missile_pitch = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_0:_get_delta_pitch_and_yaw(l_7_1, l_7_0._aim_object_missile, l_7_2)
	local l_7_4 = l_7_3.delta_pitch
	local l_7_5 = l_7_0._pitch_object_missile:new_local_rotation()
	local l_7_6 = l_7_5 + Rotation(Vector3(1, 0, 0), l_7_4)
	l_7_0._pitch_object_missile:new_set_local_rotation(l_7_6)
end

SkynetDefenceTurretBase._update_gatling_pitch = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_0:_get_delta_pitch_and_yaw(l_8_1, l_8_0._aim_object_gatling, l_8_2)
	local l_8_4 = l_8_3.delta_pitch
	local l_8_5 = l_8_0._pitch_object_gatling:new_local_rotation()
	local l_8_6 = l_8_5 + Rotation(Vector3(0, 1, 0), l_8_4)
	l_8_0._pitch_object_gatling:new_set_local_rotation(l_8_6)
end

SkynetDefenceTurretBase._get_delta_pitch_and_yaw = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = l_9_2
	local l_9_5 = l_9_4:position()
	local l_9_6 = l_9_4:rotation()
	local l_9_7, l_9_8 = AimPoseHelper.delta_yaw_and_pitch(l_9_5, l_9_6, l_9_3)
	local l_9_9 = math.sqrt(l_9_7 * l_9_7 + l_9_8 * l_9_8)
	local l_9_10 = SkynetDefenceTurretBase._MAX_ANGLE_VELOCITY * l_9_1
	if l_9_10 < l_9_9 then
		local l_9_11 = l_9_10 / l_9_9
		l_9_7 = l_9_7 * l_9_11
		l_9_8 = l_9_8 * l_9_11
	end
	local l_9_12 = {}
	l_9_12.delta_pitch = l_9_8
	l_9_12.delta_yaw = l_9_7
	return l_9_12
end

SkynetDefenceTurretBase.fully_damaged = function(l_10_0)
	if l_10_0._enemy_data and not l_10_0._enemy_data.dead then
		l_10_0._enemy_data.dead = true
	end
	l_10_0._emitter:unit_fully_damaged(l_10_0._unit)
	managers.unit_scripting:unit_dead(l_10_0._unit)
end

SkynetDefenceTurretBase.destroy = function(l_11_0)
	managers.unit_scripting:unit_destroyed(l_11_0._unit)
	if alive(l_11_0._weapon_missile) then
		World:delete_unit(l_11_0._weapon_missile)
	end
	if alive(l_11_0._weapon_gatling) then
		World:delete_unit(l_11_0._weapon_gatling)
	end
end


