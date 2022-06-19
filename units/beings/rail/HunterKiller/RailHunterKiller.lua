require("shared/Angle")
require("units/beings/AimPoseHelper")
if not RailHunterKiller then
	RailHunterKiller = class(RailVehicle)
end
RailHunterKiller._AIM_OBJECT_NAME_PRIMARY = "e_fire_right"
RailHunterKiller._AIM_OBJECT_NAME_SECONDARY = "e_fire_back"
RailHunterKiller._engine_rotor_r_p_s = 12.34
RailHunterKiller._engine_blow_length = 4000
RailHunterKiller.init = function(l_1_0, l_1_1)
	RailVehicle.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._input = l_1_0._unit:input()
	l_1_0._damage_data = l_1_0._unit:damage_data()
	l_1_0._unit = l_1_1
	l_1_0._time_to_next_flare = 0
	l_1_0._engines_on = true
	l_1_0._effects = {}
	l_1_0._aim_object = {}
	l_1_0._aim_object[1] = l_1_0._unit:get_object(RailHunterKiller._AIM_OBJECT_NAME_PRIMARY)
	l_1_0._aim_object[2] = l_1_0._unit:get_object(RailHunterKiller._AIM_OBJECT_NAME_SECONDARY)
	l_1_0._aim_target_tolerance = {}
	l_1_0._aim_target_tolerance[1] = l_1_0._aim_target_angle_tolerance_primary_weapon
	l_1_0._aim_target_tolerance[2] = l_1_0._aim_target_angle_tolerance_secondary_weapon
	l_1_0._max_angle_velocity = {}
	l_1_0._max_angle_velocity[1] = l_1_0._max_angle_velocity_primary_weapon
	l_1_0._max_angle_velocity[2] = l_1_0._max_angle_velocity_secondary_weapon
	l_1_0._engine_loop_sound_instance = nil
	l_1_0._engine_strain_sound_instance = nil
	l_1_0._engine_sounds_on = false
	l_1_0._engine_dust_slot_mask = managers.slot:get_mask("solid_objects")
	l_1_0._engine_dust_check_interval = 0.3
	l_1_0._engine_dust_check_prev = 0
	l_1_0._engine_dust_obj_l = l_1_0._unit:get_object("e_engine_flame_left")
	l_1_0._engine_dust_obj_r = l_1_0._unit:get_object("e_engine_flame_right")
	l_1_0:_setup_weapons()
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
end

RailHunterKiller._setup_weapons = function(l_2_0)
	local l_2_1 = World:spawn_unit(l_2_0._weapon_primary_class, l_2_0._unit:position(), l_2_0._unit:rotation())
	assert(l_2_1)
	l_2_1:base():setup(l_2_0._unit, l_2_0._weapon_primary_parent_object_names)
	l_2_1:base():set_equiped(true)
	l_2_0._weapon_primary = l_2_1
	local l_2_2 = World:spawn_unit(l_2_0._weapon_secondary_class, l_2_0._unit:position(), l_2_0._unit:rotation())
	assert(l_2_2)
	l_2_2:base():setup(l_2_0._unit, l_2_0._weapon_secondary_parent_object_names)
	l_2_2:base():set_equiped(true)
	l_2_0._weapon_secondary = l_2_2
end

RailHunterKiller.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	RailVehicle.update(l_3_0, l_3_1, l_3_2, l_3_3)
	if not alive(l_3_0._unit) then
		return 
	end
	local l_3_4 = l_3_0._input:primary_aim_target_position()
	local l_3_5 = l_3_0._input:secondary_aim_target_position()
	l_3_0:_update_weapon_status()
	if l_3_4 then
		l_3_0:_update_weapon_aiming(l_3_4, l_3_3, l_3_0._aim_object[1], l_3_0._unit:get_object("gun_1_left"), l_3_0._unit:get_object("gun_2_left"), Vector3(-1, 0, 0), l_3_0._max_angle_velocity[1])
		l_3_0:_update_weapon_aiming(l_3_4, l_3_3, l_3_0._aim_object[1], l_3_0._unit:get_object("gun_1_right"), l_3_0._unit:get_object("gun_2_right"), Vector3(-1, 0, 0), l_3_0._max_angle_velocity[1])
	end
	if l_3_5 then
		l_3_0:_update_weapon_aiming(l_3_5, l_3_3, l_3_0._aim_object[2], l_3_0._unit:get_object("gun_back_1"), l_3_0._unit:get_object("gun_back_2"), Vector3(1, 0, 0), l_3_0._max_angle_velocity[2])
	end
	l_3_0:_update_weapon(l_3_0._weapon_primary, l_3_4, l_3_0._input:primary_fire(), l_3_0.primary_attack_damage, l_3_0._aim_object[1], l_3_0._aim_target_tolerance[1])
	l_3_0:_update_weapon(l_3_0._weapon_secondary, l_3_5, l_3_0._input:secondary_fire(), l_3_0.secondary_attack_damage, l_3_0._aim_object[2], l_3_0._aim_target_tolerance[2])
	l_3_0:_update_effects(l_3_2, l_3_3)
	l_3_0:_update_sound(l_3_1, l_3_2, l_3_3)
end

RailHunterKiller._update_sound = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if l_4_0._engine_sounds_on and l_4_0._engines_on and not alive(l_4_0._engine_strain_sound_instance) and not alive(l_4_0._engine_loop_sound_instance) then
		l_4_0._engine_loop_sound_instance = l_4_0._unit:play("hk_engine_loop")
	end
	do return end
	if l_4_0._engine_loop_sound_instance and l_4_0._engine_loop_sound_instance:is_playing() then
		l_4_0._engine_loop_sound_instance:stop()
	end
end

RailHunterKiller.unit_damaged = function(l_5_0, l_5_1, l_5_2, l_5_3)
	if l_5_0._engine_sounds_on and l_5_0._engines_on and tweak_data.rail.hunter_killer.sound.ENGINE_DAMAGE_SOUND_THRESHOLD <= l_5_0._damage_data.last_damage_taken and not alive(l_5_0._engine_strain_sound_instance) then
		l_5_0._engine_strain_sound_instance = l_5_0._unit:play("hk_engine_strain")
	end
end

RailHunterKiller._update_weapon_status = function(l_6_0)
	if l_6_0._unit:damage():is_body_group_destroyed("turret_front_left") and l_6_0._weapon_primary then
		l_6_0._weapon_primary:base():disable_projectile_spawner(1)
	end
	if l_6_0._unit:damage():is_body_group_destroyed("turret_front_right") and l_6_0._weapon_primary then
		l_6_0._weapon_primary:base():disable_projectile_spawner(2)
	end
end

RailHunterKiller._update_weapon_aiming = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5, l_7_6, l_7_7)
	if l_7_1 then
		local l_7_8 = l_7_3
		local l_7_9 = l_7_8:position()
		local l_7_10 = l_7_8:rotation() + Rotation(Vector3(1, 0, 0), 90)
		local l_7_11, l_7_12 = AimPoseHelper.delta_yaw_and_pitch(l_7_9, l_7_10, l_7_1)
		local l_7_13 = math.sqrt(l_7_11 * l_7_11 + l_7_12 * l_7_12)
		local l_7_14 = l_7_2 * l_7_7
		if l_7_14 < l_7_13 then
			local l_7_15 = l_7_14 / l_7_13
			l_7_11 = l_7_11 * l_7_15
			l_7_12 = l_7_12 * l_7_15
		end
		local l_7_16 = l_7_4:new_local_rotation()
		local l_7_17 = l_7_16 + Rotation(Vector3(0, 0, 1), l_7_11)
		l_7_4:new_set_local_rotation(l_7_17)
		l_7_16 = l_7_5:new_local_rotation()
		l_7_17 = l_7_16 + Rotation(l_7_6, l_7_12)
		l_7_5:new_set_local_rotation(l_7_17)
	end
end

RailHunterKiller._update_weapon = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4, l_8_5, l_8_6)
	if not alive(l_8_1) then
		return 
	end
	local l_8_7 = l_8_1:weapon_data()
	local l_8_8 = (l_8_1:base())
	local l_8_9 = nil
	if l_8_7._bullets_in_clip == 0 then
		l_8_9 = 0
	elseif l_8_3 then
		l_8_9 = 1
	else
		l_8_9 = 0
	end
	l_8_7.fire_input = l_8_9
	if l_8_2 then
		l_8_7.aim_target_position = l_8_0:_weapon_aim_position(l_8_2, l_8_5, l_8_6)
	end
	if l_8_4 then
		local l_8_10, l_8_11 = l_8_8:set_explosion_damage_at_center, l_8_8
		local l_8_12 = {}
		l_8_12.hard = l_8_4
		l_8_12.soft = l_8_4
		l_8_10(l_8_11, l_8_12)
	end
end

RailHunterKiller._weapon_aim_position = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = l_9_2:position()
	local l_9_5 = l_9_2:rotation()
	local l_9_6 = (l_9_5:z())
	local l_9_7 = nil
	if l_9_1 then
		local l_9_8 = l_9_1 - l_9_4
		local l_9_9 = l_9_8:length()
	if l_9_9 > 0.01 then
		end
		local l_9_10 = l_9_8 / l_9_9
		if l_9_10:angle(l_9_6) < l_9_3 then
			l_9_7 = l_9_1
		end
	else
		l_9_7 = l_9_2:position() + l_9_6 * l_9_9
	end
	if not l_9_7 then
		l_9_7 = l_9_2:position() + l_9_6 * 1000
	end
	return l_9_7
end

RailHunterKiller._update_effects = function(l_10_0, l_10_1, l_10_2)
	if l_10_0._engine_dust_check_prev + l_10_0._engine_dust_check_interval <= l_10_1 then
		local l_10_3 = l_10_0._effects
		do
			local l_10_4 = l_10_0:_update_effect_engine_dust(l_10_0._effects.effect_engine_dust_l, l_10_0._engine_dust_obj_l, l_10_2)
			l_10_0._engine_dust_vec_l = l_10_0
			l_10_3.effect_engine_dust_l = l_10_4
			l_10_3 = l_10_0._effects
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_10_0._engine_dust_vec_r = l_10_0
			l_10_3.effect_engine_dust_r = l_10_4
			l_10_0._engine_dust_check_prev = l_10_1
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		if l_10_0._effects.effect_engine_dust_l and l_10_0._engine_dust_vec_l then
			World:effect_manager():move_rotate(l_10_0._effects.effect_engine_dust_l, l_10_0._engine_dust_obj_l:position() + l_10_0._engine_dust_vec_l, Rotation())
		end
	if l_10_0._effects.effect_engine_dust_r then
		end
	if l_10_0._engine_dust_vec_r then
		end
		World:effect_manager():move_rotate(l_10_0._effects.effect_engine_dust_r, l_10_0._engine_dust_obj_r:position() + l_10_0._engine_dust_vec_r, Rotation())
	end
end

RailHunterKiller._update_effect_engine_dust = function(l_11_0, l_11_1, l_11_2, l_11_3)
	if l_11_0._engines_on then
		local l_11_4 = (l_11_2:position())
		local l_11_5 = nil
		if l_11_0:get_speed_kmh() > 20 then
			l_11_5 = l_11_2:position() + Vector3(0, 0, -1) * RailHunterKiller._engine_blow_length
		else
			l_11_5 = l_11_2:position() + l_11_2:rotation():z() * RailHunterKiller._engine_blow_length
		end
		local l_11_6 = l_11_0._unit:raycast("ray", l_11_4, l_11_5, "slot_mask", l_11_0._engine_dust_slot_mask, "ignore_unit", l_11_0._unit)
		if l_11_6 then
			local l_11_7 = l_11_6.position + l_11_6.ray * -40
			if not l_11_1 then
				local l_11_8, l_11_9 = World:effect_manager():spawn, World:effect_manager()
				local l_11_10 = {}
				l_11_10.effect = "hk_dust_twirl"
				l_11_10.position = l_11_7
				l_11_10.rotation = Rotation()
				l_11_8 = l_11_8(l_11_9, l_11_10)
				l_11_9, l_11_10 = l_11_2:position, l_11_2
				l_11_9 = l_11_9(l_11_10)
				l_11_9 = l_11_7 - l_11_9
				return l_11_8, l_11_9
			end
		else
			World:effect_manager():move_rotate(l_11_1, l_11_7, Rotation())
			return l_11_1, l_11_7 - l_11_2:position()
		end
		if not l_11_6 and l_11_1 then
			World:effect_manager():fade_kill(l_11_1)
		end
	elseif not l_11_0._engines_on and l_11_1 then
		World:effect_manager():fade_kill(l_11_1)
	end
	return nil, nil
end

RailHunterKiller.destroy = function(l_12_0)
	RailVehicle.destroy(l_12_0)
	table.foreach(l_12_0._effects, function(l_13_0, l_13_1)
		World:effect_manager():kill(l_13_1)
  end)
	managers.action_event:unregister_listener(l_12_0)
	l_12_0:_stop_sounds()
	l_12_0:_destroy_weapons()
end

RailHunterKiller._stop_sounds = function(l_13_0)
	if l_13_0._engine_loop_sound_instance and l_13_0._engine_loop_sound_instance:is_playing() then
		l_13_0._engine_loop_sound_instance:stop()
	end
	if l_13_0._engine_strain_sound_instance and l_13_0._engine_strain_sound_instance:is_playing() then
		l_13_0._engine_strain_sound_instance:stop()
	end
end

RailHunterKiller._disable_weapons = function(l_14_0)
	local l_14_1 = l_14_0._weapon_primary:weapon_data()
	l_14_1.fire_input = 0
	l_14_0._weapon_secondary:weapon_data().fire_input = 0
end

RailHunterKiller._destroy_weapons = function(l_15_0)
	if alive(l_15_0._weapon_primary) then
		World:delete_unit(l_15_0._weapon_primary)
		l_15_0._weapon_primary = nil
	end
	if alive(l_15_0._weapon_secondary) then
		World:delete_unit(l_15_0._weapon_secondary)
		l_15_0._weapon_secondary = nil
	end
end

RailHunterKiller._update_flare = function(l_16_0, l_16_1, l_16_2)
	if l_16_0._input:flare() then
		if l_16_0._time_to_next_flare > 0 then
			l_16_0._time_to_next_flare = l_16_0._time_to_next_flare - l_16_2
		end
	else
		local l_16_3 = l_16_0._flare_effect
		local l_16_4 = l_16_0._unit:get_object("rp_hk"):position()
		local l_16_5 = Rotation:yaw_pitch_roll(0, 0, l_16_0._unit:get_object("rp_hk"):rotation():roll())
		local l_16_6, l_16_7 = World:effect_manager():spawn, World:effect_manager()
		local l_16_8 = {}
		l_16_8.effect = l_16_3
		l_16_8.position = l_16_4
		l_16_8.rotation = l_16_5
		l_16_6(l_16_7, l_16_8)
		l_16_6 = tweak_data
		l_16_6 = l_16_6.rail
		l_16_6 = l_16_6.hunter_killer
		l_16_6 = l_16_6.flare_delay
		l_16_0._time_to_next_flare = l_16_6
	end
end

RailHunterKiller._disable_all_effects = function(l_17_0)
	l_17_0._engines_on = false
	managers.sequence:run_sequence_simple("disable_all_effects_delayed", l_17_0._unit)
end

RailHunterKiller.set_number_of_primary_bolts = function(l_18_0, l_18_1)
	local l_18_2 = l_18_0._weapon_primary:logic()
	l_18_2._clip_size = l_18_1
	l_18_2._bullets_in_clip = l_18_1
end

RailHunterKiller.set_number_of_secondary_bolts = function(l_19_0, l_19_1)
	local l_19_2 = l_19_0._weapon_secondary:logic()
	l_19_2._clip_size = l_19_1
	l_19_2._bullets_in_clip = l_19_1
end


