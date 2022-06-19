SkynetDefenceTurretBase = SkynetDefenceTurretBase or class()
SkynetDefenceTurretBase._AIM_OBJECT_NAME_MISSILE = "a_fire_missile_left_top"
SkynetDefenceTurretBase._AIM_OBJECT_NAME_GATLING = "a_gatling_fire"
SkynetDefenceTurretBase._AIM_OBJECT_NAME_TURRET = "at_turret_yaw"
SkynetDefenceTurretBase._PITCH_OBJECT_NAME_MISSILE = "at_missile_pitch"
SkynetDefenceTurretBase._PITCH_OBJECT_NAME_GATLING = "at_gatling_pitch"
SkynetDefenceTurretBase._YAW_OBJECT_NAME_TURRET = "at_turret_yaw"
SkynetDefenceTurretBase._CENTER_OBJECT_NAME = "at_turret_yaw"
SkynetDefenceTurretBase._MAX_ANGLE_VELOCITY = 90
function SkynetDefenceTurretBase.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._input = A0_0._unit:input()
	A0_0._aim_object_missile = A0_0._unit:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_MISSILE)
	A0_0._aim_object_gatling = A0_0._unit:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_GATLING)
	A0_0._aim_object_turret = A0_0._unit:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_TURRET)
	A0_0._pitch_object_missile = A0_0._unit:get_object(SkynetDefenceTurretBase._PITCH_OBJECT_NAME_MISSILE)
	A0_0._pitch_object_gatling = A0_0._unit:get_object(SkynetDefenceTurretBase._PITCH_OBJECT_NAME_GATLING)
	A0_0._yaw_object_turret = A0_0._unit:get_object(SkynetDefenceTurretBase._YAW_OBJECT_NAME_TURRET)
	A0_0._prev_aim_target_position = Vector3(0, 0, 0)
	A0_0._prev_aim_target_position_update = Vector3(0, 0, 0)
	A0_0._same_aim_target_pos = 10
	A0_0._same_aim_target_pos_cnt = 0
	A0_0:_setup_weapons()
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
end
function SkynetDefenceTurretBase._setup_weapons(A0_2)
	local L1_3, L2_4
	L1_3 = World
	L2_4 = L1_3
	L1_3 = L1_3.spawn_unit
	L1_3 = L1_3(L2_4, A0_2._weapon_class_missile, A0_2._unit:position(), A0_2._unit:rotation())
	L2_4 = assert
	L2_4(L1_3)
	L2_4 = L1_3.base
	L2_4 = L2_4(L1_3)
	L2_4 = L2_4.setup
	L2_4(L2_4, A0_2._unit, A0_2._weapon_class_missile_object_names)
	L2_4 = L1_3.base
	L2_4 = L2_4(L1_3)
	L2_4 = L2_4.set_equiped
	L2_4(L2_4, true)
	A0_2._weapon_missile = L1_3
	L2_4 = World
	L2_4 = L2_4.spawn_unit
	L2_4 = L2_4(L2_4, A0_2._weapon_class_gatling, A0_2._unit:position(), A0_2._unit:rotation())
	assert(L2_4)
	L2_4:base():setup(A0_2._unit)
	L2_4:base():set_rotation_object(A0_2._unit:get_object("at_gatling_barrel_rotate"))
	L2_4:base():set_fire_object(A0_2._unit, "a_gatling_fire")
	L2_4:base():set_equiped(true)
	A0_2._weapon_gatling = L2_4
end
function SkynetDefenceTurretBase.update(A0_5, A1_6, A2_7, A3_8)
	local L4_9
	L4_9 = A0_5._input
	L4_9 = L4_9.aim_target_position
	L4_9 = L4_9(L4_9)
	if not L4_9 then
		L4_9 = Vector3
		L4_9 = L4_9(0, 0, 0)
	end
	if (A0_5._prev_aim_target_position - L4_9):length() > 1 or (A0_5._prev_aim_target_position_update - L4_9):length() > 30 then
		A0_5._same_aim_target_pos_cnt = 0
	else
		A0_5._same_aim_target_pos_cnt = A0_5._same_aim_target_pos_cnt + 1
	end
	if L4_9 and A0_5._same_aim_target_pos_cnt <= A0_5._same_aim_target_pos then
		A0_5:_update_weapon_aiming(A3_8, L4_9)
		A0_5._prev_aim_target_position_update = L4_9
	end
	A0_5:_update_weapon(A0_5._weapon_missile, A0_5._input:fire_missile(), A0_5._input:aim_target_position_missile())
	A0_5:_update_weapon(A0_5._weapon_gatling, A0_5._input:fire_gatling(), A0_5._input:aim_target_position())
	A0_5._prev_aim_target_position = L4_9
end
function SkynetDefenceTurretBase._update_weapon(A0_10, A1_11, A2_12, A3_13)
	if A2_12 and A3_13 and not (A1_11:weapon_data()._bullets_in_clip == 0) then
		A1_11:weapon_data().fire_input = 1
	else
		A1_11:weapon_data().fire_input = 0
	end
	if A3_13 then
		A1_11:weapon_data().aim_target_position = A3_13
	end
	A1_11:weapon_data().miss_dispersion = A0_10._input:miss_dispersion()
end
function SkynetDefenceTurretBase._update_weapon_aiming(A0_14, A1_15, A2_16)
	if A2_16 then
		A0_14:_update_turret_yaw(A1_15, A2_16)
		A0_14:_update_missile_pitch(A1_15, A2_16)
		A0_14:_update_gatling_pitch(A1_15, A2_16)
		A0_14._unit:set_moving()
	end
end
function SkynetDefenceTurretBase._update_turret_yaw(A0_17, A1_18, A2_19)
	local L3_20, L4_21, L5_22, L6_23
	L4_21 = A0_17
	L3_20 = A0_17._get_delta_pitch_and_yaw
	L5_22 = A1_18
	L6_23 = A0_17._aim_object_turret
	L3_20 = L3_20(L4_21, L5_22, L6_23, A2_19)
	L4_21 = L3_20.delta_yaw
	L5_22 = A0_17._yaw_object_turret
	L6_23 = L5_22
	L5_22 = L5_22.new_local_rotation
	L5_22 = L5_22(L6_23)
	L6_23 = Rotation
	L6_23 = L6_23(Vector3(0, 0, -1), L4_21)
	L6_23 = L5_22 + L6_23
	A0_17._yaw_object_turret:new_set_local_rotation(L6_23)
end
function SkynetDefenceTurretBase._update_missile_pitch(A0_24, A1_25, A2_26)
	local L3_27, L4_28, L5_29, L6_30
	L4_28 = A0_24
	L3_27 = A0_24._get_delta_pitch_and_yaw
	L5_29 = A1_25
	L6_30 = A0_24._aim_object_missile
	L3_27 = L3_27(L4_28, L5_29, L6_30, A2_26)
	L4_28 = L3_27.delta_pitch
	L5_29 = A0_24._pitch_object_missile
	L6_30 = L5_29
	L5_29 = L5_29.new_local_rotation
	L5_29 = L5_29(L6_30)
	L6_30 = Rotation
	L6_30 = L6_30(Vector3(1, 0, 0), L4_28)
	L6_30 = L5_29 + L6_30
	A0_24._pitch_object_missile:new_set_local_rotation(L6_30)
end
function SkynetDefenceTurretBase._update_gatling_pitch(A0_31, A1_32, A2_33)
	local L3_34, L4_35, L5_36, L6_37
	L4_35 = A0_31
	L3_34 = A0_31._get_delta_pitch_and_yaw
	L5_36 = A1_32
	L6_37 = A0_31._aim_object_gatling
	L3_34 = L3_34(L4_35, L5_36, L6_37, A2_33)
	L4_35 = L3_34.delta_pitch
	L5_36 = A0_31._pitch_object_gatling
	L6_37 = L5_36
	L5_36 = L5_36.new_local_rotation
	L5_36 = L5_36(L6_37)
	L6_37 = Rotation
	L6_37 = L6_37(Vector3(0, 1, 0), L4_35)
	L6_37 = L5_36 + L6_37
	A0_31._pitch_object_gatling:new_set_local_rotation(L6_37)
end
function SkynetDefenceTurretBase._get_delta_pitch_and_yaw(A0_38, A1_39, A2_40, A3_41)
	local L4_42, L5_43, L6_44
	L4_42 = A2_40
	L6_44 = L4_42
	L5_43 = L4_42.position
	L5_43 = L5_43(L6_44)
	L6_44 = L4_42.rotation
	L6_44 = L6_44(L4_42)
	if math.sqrt(AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) * AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) + AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) * AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41)) > SkynetDefenceTurretBase._MAX_ANGLE_VELOCITY * A1_39 then
	end
	return {
		delta_pitch = AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) * (SkynetDefenceTurretBase._MAX_ANGLE_VELOCITY * A1_39 / math.sqrt(AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) * AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) + AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) * AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41))),
		delta_yaw = AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) * (SkynetDefenceTurretBase._MAX_ANGLE_VELOCITY * A1_39 / math.sqrt(AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) * AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) + AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41) * AimPoseHelper.delta_yaw_and_pitch(L5_43, L6_44, A3_41)))
	}
end
function SkynetDefenceTurretBase.fully_damaged(A0_45)
	if A0_45._enemy_data and not A0_45._enemy_data.dead then
		A0_45._enemy_data.dead = true
	end
	A0_45._emitter:unit_fully_damaged(A0_45._unit)
	managers.unit_scripting:unit_dead(A0_45._unit)
end
function SkynetDefenceTurretBase.destroy(A0_46)
	managers.unit_scripting:unit_destroyed(A0_46._unit)
	if alive(A0_46._weapon_missile) then
		World:delete_unit(A0_46._weapon_missile)
	end
	if alive(A0_46._weapon_gatling) then
		World:delete_unit(A0_46._weapon_gatling)
	end
end
