require("shared/Angle")
require("units/beings/AimPoseHelper")
RailHunterKiller = RailHunterKiller or class(RailVehicle)
RailHunterKiller._AIM_OBJECT_NAME_PRIMARY = "e_fire_right"
RailHunterKiller._AIM_OBJECT_NAME_SECONDARY = "e_fire_back"
RailHunterKiller._engine_rotor_r_p_s = 12.34
RailHunterKiller._engine_blow_length = 4000
function RailHunterKiller.init(A0_0, A1_1)
	RailVehicle.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._input = A0_0._unit:input()
	A0_0._damage_data = A0_0._unit:damage_data()
	A0_0._unit = A1_1
	A0_0._time_to_next_flare = 0
	A0_0._engines_on = true
	A0_0._effects = {}
	A0_0._aim_object = {}
	A0_0._aim_object[1] = A0_0._unit:get_object(RailHunterKiller._AIM_OBJECT_NAME_PRIMARY)
	A0_0._aim_object[2] = A0_0._unit:get_object(RailHunterKiller._AIM_OBJECT_NAME_SECONDARY)
	A0_0._aim_target_tolerance = {}
	A0_0._aim_target_tolerance[1] = A0_0._aim_target_angle_tolerance_primary_weapon
	A0_0._aim_target_tolerance[2] = A0_0._aim_target_angle_tolerance_secondary_weapon
	A0_0._max_angle_velocity = {}
	A0_0._max_angle_velocity[1] = A0_0._max_angle_velocity_primary_weapon
	A0_0._max_angle_velocity[2] = A0_0._max_angle_velocity_secondary_weapon
	A0_0._engine_loop_sound_instance = nil
	A0_0._engine_strain_sound_instance = nil
	A0_0._engine_sounds_on = false
	A0_0._engine_dust_slot_mask = managers.slot:get_mask("solid_objects")
	A0_0._engine_dust_check_interval = 0.3
	A0_0._engine_dust_check_prev = 0
	A0_0._engine_dust_obj_l = A0_0._unit:get_object("e_engine_flame_left")
	A0_0._engine_dust_obj_r = A0_0._unit:get_object("e_engine_flame_right")
	A0_0:_setup_weapons()
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
end
function RailHunterKiller._setup_weapons(A0_2)
	local L1_3, L2_4
	L1_3 = World
	L2_4 = L1_3
	L1_3 = L1_3.spawn_unit
	L1_3 = L1_3(L2_4, A0_2._weapon_primary_class, A0_2._unit:position(), A0_2._unit:rotation())
	L2_4 = assert
	L2_4(L1_3)
	L2_4 = L1_3.base
	L2_4 = L2_4(L1_3)
	L2_4 = L2_4.setup
	L2_4(L2_4, A0_2._unit, A0_2._weapon_primary_parent_object_names)
	L2_4 = L1_3.base
	L2_4 = L2_4(L1_3)
	L2_4 = L2_4.set_equiped
	L2_4(L2_4, true)
	A0_2._weapon_primary = L1_3
	L2_4 = World
	L2_4 = L2_4.spawn_unit
	L2_4 = L2_4(L2_4, A0_2._weapon_secondary_class, A0_2._unit:position(), A0_2._unit:rotation())
	assert(L2_4)
	L2_4:base():setup(A0_2._unit, A0_2._weapon_secondary_parent_object_names)
	L2_4:base():set_equiped(true)
	A0_2._weapon_secondary = L2_4
end
function RailHunterKiller.update(A0_5, A1_6, A2_7, A3_8)
	local L4_9, L5_10
	L4_9 = RailVehicle
	L4_9 = L4_9.update
	L5_10 = A0_5
	L4_9(L5_10, A1_6, A2_7, A3_8)
	L4_9 = alive
	L5_10 = A0_5._unit
	L4_9 = L4_9(L5_10)
	if not L4_9 then
		return
	end
	L4_9 = A0_5._input
	L5_10 = L4_9
	L4_9 = L4_9.primary_aim_target_position
	L4_9 = L4_9(L5_10)
	L5_10 = A0_5._input
	L5_10 = L5_10.secondary_aim_target_position
	L5_10 = L5_10(L5_10)
	A0_5:_update_weapon_status()
	if L4_9 then
		A0_5:_update_weapon_aiming(L4_9, A3_8, A0_5._aim_object[1], A0_5._unit:get_object("gun_1_left"), A0_5._unit:get_object("gun_2_left"), Vector3(-1, 0, 0), A0_5._max_angle_velocity[1])
		A0_5:_update_weapon_aiming(L4_9, A3_8, A0_5._aim_object[1], A0_5._unit:get_object("gun_1_right"), A0_5._unit:get_object("gun_2_right"), Vector3(-1, 0, 0), A0_5._max_angle_velocity[1])
	end
	if L5_10 then
		A0_5:_update_weapon_aiming(L5_10, A3_8, A0_5._aim_object[2], A0_5._unit:get_object("gun_back_1"), A0_5._unit:get_object("gun_back_2"), Vector3(1, 0, 0), A0_5._max_angle_velocity[2])
	end
	A0_5:_update_weapon(A0_5._weapon_primary, L4_9, A0_5._input:primary_fire(), A0_5.primary_attack_damage, A0_5._aim_object[1], A0_5._aim_target_tolerance[1])
	A0_5:_update_weapon(A0_5._weapon_secondary, L5_10, A0_5._input:secondary_fire(), A0_5.secondary_attack_damage, A0_5._aim_object[2], A0_5._aim_target_tolerance[2])
	A0_5:_update_effects(A2_7, A3_8)
	A0_5:_update_sound(A1_6, A2_7, A3_8)
end
function RailHunterKiller._update_sound(A0_11, A1_12, A2_13, A3_14)
	if A0_11._engine_sounds_on and A0_11._engines_on and not alive(A0_11._engine_strain_sound_instance) then
		if not alive(A0_11._engine_loop_sound_instance) then
			A0_11._engine_loop_sound_instance = A0_11._unit:play("hk_engine_loop")
		end
	elseif A0_11._engine_loop_sound_instance and A0_11._engine_loop_sound_instance:is_playing() then
		A0_11._engine_loop_sound_instance:stop()
	end
end
function RailHunterKiller.unit_damaged(A0_15, A1_16, A2_17, A3_18)
	if A0_15._engine_sounds_on and A0_15._engines_on and A0_15._damage_data.last_damage_taken >= tweak_data.rail.hunter_killer.sound.ENGINE_DAMAGE_SOUND_THRESHOLD and not alive(A0_15._engine_strain_sound_instance) then
		A0_15._engine_strain_sound_instance = A0_15._unit:play("hk_engine_strain")
	end
end
function RailHunterKiller._update_weapon_status(A0_19)
	if A0_19._unit:damage():is_body_group_destroyed("turret_front_left") and A0_19._weapon_primary then
		A0_19._weapon_primary:base():disable_projectile_spawner(1)
	end
	if A0_19._unit:damage():is_body_group_destroyed("turret_front_right") and A0_19._weapon_primary then
		A0_19._weapon_primary:base():disable_projectile_spawner(2)
	end
end
function RailHunterKiller._update_weapon_aiming(A0_20, A1_21, A2_22, A3_23, A4_24, A5_25, A6_26, A7_27)
	local L8_28, L9_29, L10_30, L11_31, L12_32, L13_33, L14_34, L15_35, L16_36
	if A1_21 then
		L8_28 = A3_23
		L10_30 = L8_28
		L9_29 = L8_28.position
		L9_29 = L9_29(L10_30)
		L11_31 = L8_28
		L10_30 = L8_28.rotation
		L10_30 = L10_30(L11_31)
		L11_31 = Rotation
		L12_32 = Vector3
		L13_33 = 1
		L14_34 = 0
		L15_35 = 0
		L12_32 = L12_32(L13_33, L14_34, L15_35)
		L13_33 = 90
		L11_31 = L11_31(L12_32, L13_33)
		L10_30 = L10_30 + L11_31
		L11_31 = AimPoseHelper
		L11_31 = L11_31.delta_yaw_and_pitch
		L12_32 = L9_29
		L13_33 = L10_30
		L14_34 = A1_21
		L12_32 = L11_31(L12_32, L13_33, L14_34)
		L13_33 = math
		L13_33 = L13_33.sqrt
		L14_34 = L11_31 * L11_31
		L15_35 = L12_32 * L12_32
		L14_34 = L14_34 + L15_35
		L13_33 = L13_33(L14_34)
		L14_34 = A2_22 * A7_27
		if L13_33 > L14_34 then
			L15_35 = L14_34 / L13_33
			L11_31 = L11_31 * L15_35
			L12_32 = L12_32 * L15_35
		end
		L16_36 = A4_24
		L15_35 = A4_24.new_local_rotation
		L15_35 = L15_35(L16_36)
		L16_36 = Rotation
		L16_36 = L16_36(Vector3(0, 0, 1), L11_31)
		L16_36 = L15_35 + L16_36
		A4_24:new_set_local_rotation(L16_36)
		L15_35 = A5_25:new_local_rotation()
		L16_36 = L15_35 + Rotation(A6_26, L12_32)
		A5_25:new_set_local_rotation(L16_36)
	end
end
function RailHunterKiller._update_weapon(A0_37, A1_38, A2_39, A3_40, A4_41, A5_42, A6_43)
	if not alive(A1_38) then
		return
	end
	if A1_38:weapon_data()._bullets_in_clip == 0 then
	elseif A3_40 then
	else
	end
	A1_38:weapon_data().fire_input = 0
	if A2_39 then
		A1_38:weapon_data().aim_target_position = A0_37:_weapon_aim_position(A2_39, A5_42, A6_43)
	end
	if A4_41 then
		A1_38:base():set_explosion_damage_at_center({hard = A4_41, soft = A4_41})
	end
end
function RailHunterKiller._weapon_aim_position(A0_44, A1_45, A2_46, A3_47)
	local L4_48, L5_49, L6_50
	L5_49 = A2_46
	L4_48 = A2_46.position
	L4_48 = L4_48(L5_49)
	L6_50 = A2_46
	L5_49 = A2_46.rotation
	L5_49 = L5_49(L6_50)
	L6_50 = L5_49.z
	L6_50 = L6_50(L5_49)
	if A1_45 and (A1_45 - L4_48):length() > 0.01 then
		if A3_47 > (A1_45 - L4_48) / (A1_45 - L4_48):length():angle(L6_50) then
		else
		end
	end
	return A2_46:position() + L6_50 * (A1_45 - L4_48):length() or A2_46:position() + L6_50 * 1000
end
function RailHunterKiller._update_effects(A0_51, A1_52, A2_53)
	if A1_52 >= A0_51._engine_dust_check_prev + A0_51._engine_dust_check_interval then
		A0_51._effects.effect_engine_dust_l, A0_51._engine_dust_vec_l = A0_51:_update_effect_engine_dust(A0_51._effects.effect_engine_dust_l, A0_51._engine_dust_obj_l, A2_53)
		A0_51._effects.effect_engine_dust_r, A0_51._engine_dust_vec_r = A0_51:_update_effect_engine_dust(A0_51._effects.effect_engine_dust_r, A0_51._engine_dust_obj_r, A2_53)
		A0_51._engine_dust_check_prev = A1_52
	else
		if A0_51._effects.effect_engine_dust_l and A0_51._engine_dust_vec_l then
			World:effect_manager():move_rotate(A0_51._effects.effect_engine_dust_l, A0_51._engine_dust_obj_l:position() + A0_51._engine_dust_vec_l, Rotation())
		end
		if A0_51._effects.effect_engine_dust_r and A0_51._engine_dust_vec_r then
			World:effect_manager():move_rotate(A0_51._effects.effect_engine_dust_r, A0_51._engine_dust_obj_r:position() + A0_51._engine_dust_vec_r, Rotation())
		end
	end
end
function RailHunterKiller._update_effect_engine_dust(A0_54, A1_55, A2_56, A3_57)
	local L4_58, L5_59, L6_60, L7_61
	L4_58 = A0_54._engines_on
	if L4_58 then
		L5_59 = A2_56
		L4_58 = A2_56.position
		L4_58 = L4_58(L5_59)
		L5_59 = nil
		L7_61 = A0_54
		L6_60 = A0_54.get_speed_kmh
		L6_60 = L6_60(L7_61)
		if L6_60 > 20 then
			L7_61 = A2_56
			L6_60 = A2_56.position
			L6_60 = L6_60(L7_61)
			L7_61 = Vector3
			L7_61 = L7_61(0, 0, -1)
			L7_61 = L7_61 * RailHunterKiller._engine_blow_length
			L5_59 = L6_60 + L7_61
		else
			L7_61 = A2_56
			L6_60 = A2_56.position
			L6_60 = L6_60(L7_61)
			L7_61 = A2_56.rotation
			L7_61 = L7_61(A2_56)
			L7_61 = L7_61.z
			L7_61 = L7_61(L7_61)
			L7_61 = L7_61 * RailHunterKiller._engine_blow_length
			L5_59 = L6_60 + L7_61
		end
		L6_60 = A0_54._unit
		L7_61 = L6_60
		L6_60 = L6_60.raycast
		L6_60 = L6_60(L7_61, "ray", L4_58, L5_59, "slot_mask", A0_54._engine_dust_slot_mask, "ignore_unit", A0_54._unit)
		if L6_60 then
			L7_61 = L6_60.position
			L7_61 = L7_61 + L6_60.ray * -40
			if not A1_55 then
				return World:effect_manager():spawn({
					effect = "hk_dust_twirl",
					position = L7_61,
					rotation = Rotation()
				}), L7_61 - A2_56:position()
			else
				World:effect_manager():move_rotate(A1_55, L7_61, Rotation())
				return A1_55, L7_61 - A2_56:position()
			end
		end
		if not L6_60 and A1_55 then
			L7_61 = World
			L7_61 = L7_61.effect_manager
			L7_61 = L7_61(L7_61)
			L7_61 = L7_61.fade_kill
			L7_61(L7_61, A1_55)
		end
	else
		L4_58 = A0_54._engines_on
		if not L4_58 and A1_55 then
			L4_58 = World
			L5_59 = L4_58
			L4_58 = L4_58.effect_manager
			L4_58 = L4_58(L5_59)
			L5_59 = L4_58
			L4_58 = L4_58.fade_kill
			L6_60 = A1_55
			L4_58(L5_59, L6_60)
		end
	end
	L4_58, L5_59 = nil, nil
	return L4_58, L5_59
end
function RailHunterKiller.destroy(A0_62)
	RailVehicle.destroy(A0_62)
	table.foreach(A0_62._effects, function(A0_63, A1_64)
		World:effect_manager():kill(A1_64)
	end)
	managers.action_event:unregister_listener(A0_62)
	A0_62:_stop_sounds()
	A0_62:_destroy_weapons()
end
function RailHunterKiller._stop_sounds(A0_65)
	if A0_65._engine_loop_sound_instance and A0_65._engine_loop_sound_instance:is_playing() then
		A0_65._engine_loop_sound_instance:stop()
	end
	if A0_65._engine_strain_sound_instance and A0_65._engine_strain_sound_instance:is_playing() then
		A0_65._engine_strain_sound_instance:stop()
	end
end
function RailHunterKiller._disable_weapons(A0_66)
	A0_66._weapon_primary:weapon_data().fire_input = 0
	A0_66._weapon_secondary:weapon_data().fire_input = 0
end
function RailHunterKiller._destroy_weapons(A0_67)
	if alive(A0_67._weapon_primary) then
		World:delete_unit(A0_67._weapon_primary)
		A0_67._weapon_primary = nil
	end
	if alive(A0_67._weapon_secondary) then
		World:delete_unit(A0_67._weapon_secondary)
		A0_67._weapon_secondary = nil
	end
end
function RailHunterKiller._update_flare(A0_68, A1_69, A2_70)
	if A0_68._input:flare() then
		if A0_68._time_to_next_flare > 0 then
			A0_68._time_to_next_flare = A0_68._time_to_next_flare - A2_70
		else
			World:effect_manager():spawn({
				effect = A0_68._flare_effect,
				position = A0_68._unit:get_object("rp_hk"):position(),
				rotation = Rotation:yaw_pitch_roll(0, 0, A0_68._unit:get_object("rp_hk"):rotation():roll())
			})
			A0_68._time_to_next_flare = tweak_data.rail.hunter_killer.flare_delay
		end
	end
end
function RailHunterKiller._disable_all_effects(A0_71)
	A0_71._engines_on = false
	managers.sequence:run_sequence_simple("disable_all_effects_delayed", A0_71._unit)
end
function RailHunterKiller.set_number_of_primary_bolts(A0_72, A1_73)
	A0_72._weapon_primary:logic()._clip_size = A1_73
	A0_72._weapon_primary:logic()._bullets_in_clip = A1_73
end
function RailHunterKiller.set_number_of_secondary_bolts(A0_74, A1_75)
	A0_74._weapon_secondary:logic()._clip_size = A1_75
	A0_74._weapon_secondary:logic()._bullets_in_clip = A1_75
end
