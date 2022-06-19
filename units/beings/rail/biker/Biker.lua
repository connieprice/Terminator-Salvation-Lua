if not Biker then
	Biker = class(Rail2WheeledVehicle)
end
Biker._AIM_OBJECT = "a_fire_plasma_upper_left"
Biker._ROOT_OBJECT = "rp_biker"
Biker._ENGINE_SOUNDBANK_NAME = "rs2_sound"
Biker._ENGINE_SOUND_NAME = "rs2_motoloop"
Biker._ENGINE_SOUND_OUTPUT_OBJECT_NAME = "rp_biker"
Biker.init = function(l_1_0, l_1_1)
	Rail2WheeledVehicle.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._input = l_1_0._unit:input()
	l_1_0._unit = l_1_1
	l_1_0._aim_object = l_1_0._unit:get_object(Biker._AIM_OBJECT)
	l_1_0._root_object = l_1_0._unit:get_object(Biker._ROOT_OBJECT)
	l_1_0._engine_sound = Sound:make_bank(Biker._ENGINE_SOUNDBANK_NAME, Biker._ENGINE_SOUND_NAME)
	local l_1_2 = l_1_1:get_object(Biker._ENGINE_SOUND_OUTPUT_OBJECT_NAME)
	l_1_0._engine_sound:set_output(l_1_2)
	l_1_0._engine_sound:set_ambient(true)
	l_1_0._collidable_units = World:find_units_quick("all", World:make_slot_mask(39))
	l_1_0._gatling_l = l_1_0._unit:get_object("a_gatling_gyro_l")
	l_1_0._gatling_r = l_1_0._unit:get_object("a_gatling_gyro_r")
	l_1_0._hip_l = l_1_0._unit:get_object("a_hip_l_target_02")
	l_1_0._hip_r = l_1_0._unit:get_object("a_hip_r_target_02")
	l_1_0._collision_distance = tweak_data.rail.biker.COLLISION_DISTANCE
	l_1_0._collision_detection_delay = 0.1
	l_1_0._collision_detection_time = 0
	l_1_0._collision_detection_radius = l_1_0._collision_distance + 1000
	l_1_0:_setup_weapons()
end

Biker._setup_weapons = function(l_2_0)
	l_2_0._primary_weapon_l = World:spawn_unit(l_2_0._primary_weapon_class, l_2_0._unit:position(), l_2_0._unit:rotation())
	l_2_0._primary_weapon_l:base():setup(l_2_0._unit)
	l_2_0._primary_weapon_l:base():set_equiped(true)
	l_2_0._unit:link("a_gatling_barrel_left", l_2_0._primary_weapon_l, "at_gatling_barrel")
	l_2_0._primary_weapon_r = World:spawn_unit(l_2_0._primary_weapon_class, l_2_0._unit:position(), l_2_0._unit:rotation())
	l_2_0._primary_weapon_r:base():setup(l_2_0._unit)
	l_2_0._primary_weapon_r:base():set_equiped(true)
	local l_2_4 = l_2_0._unit:link
	local l_2_5 = l_2_0._unit
	l_2_4(l_2_5, "a_gatling_barrel_right", l_2_0._primary_weapon_r, "at_gatling_barrel")
	l_2_0._secondary_weapons, l_2_4 = l_2_4, {}
	l_2_4 = pairs
	l_2_5 = l_2_0._secondary_weapon_parent_object_names
	l_2_4 = l_2_4(l_2_5)
	for i_0,i_1 in l_2_4 do
		local l_2_6 = World:spawn_unit(l_2_0._secondary_weapon_class, l_2_0._unit:position(), l_2_0._unit:rotation())
		local l_2_7, l_2_8 = l_2_6:base():setup, l_2_6:base()
		local l_2_9 = l_2_0._unit
		local l_2_10 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_2_7(l_2_8, l_2_9, l_2_10)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_7(l_2_8, l_2_9)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_7(l_2_8, l_2_9)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

Biker.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_11, l_3_12 = nil
	Rail2WheeledVehicle.update(l_3_0, l_3_1, l_3_2, l_3_3)
	if not l_3_0._engine_sound:is_playing() then
		l_3_0._engine_sound:play()
	end
	l_3_0:_update_collision_detection(l_3_1, l_3_2, l_3_3)
	l_3_0:_update_animation_speed()
	local l_3_4 = l_3_0._input:primary_fire()
	local l_3_5 = l_3_0._input:secondary_fire()
	local l_3_6 = l_3_0._aim_object:position() + l_3_0._aim_object:rotation():y() * 100000
	l_3_0:_update_primary_weapon(l_3_0._primary_weapon_l, l_3_6)
	local l_3_10 = l_3_0:_update_primary_weapon
	l_3_10(l_3_0, l_3_0._primary_weapon_r, l_3_6)
	l_3_10 = pairs
	l_3_10 = l_3_10(l_3_0._secondary_weapons)
	for i_0,i_1 in l_3_10 do
		l_3_0:_update_secondary_weapon(i_1, l_3_6)
	end
	l_3_0:_update_gatling_gyro()
	l_3_0:_update_effects()
	if Global.category_debug_render["rail_biker.position"] then
		Draw:pen(Color(1, 0, 1, 0)):sphere(l_3_0._unit:position() + Vector3(0, 0, 100), 100)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Biker._update_collision_detection = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13, l_4_14 = nil
	if l_4_0._collision_detection_time <= l_4_2 then
		if not l_4_0._collided then
			for i_0,i_1 in ipairs(l_4_0._collidable_units) do
				if alive(i_1) and l_4_0._unit:position() - i_1:position():length() <= l_4_0._collision_detection_radius then
					local l_4_17 = nil
					local l_4_18 = nil
				if l_4_16:oobb():point_inside(l_4_0._unit:position() + l_4_0._unit:rotation():y() * l_4_0._collision_distance + l_4_0._unit:rotation():z() * 50) then
					end
					Application:debug("BIKER COLLISION WITH", l_4_16:name())
					l_4_0._unit:damage():set_fully_damaged()
					l_4_0._collided = true
				end
			end
		end
		l_4_0._collision_detection_time = l_4_2 + l_4_0._collision_detection_delay
	end
end

Biker._update_gatling_gyro = function(l_5_0)
	local l_5_1 = l_5_0._root_object:rotation():pitch()
	local l_5_2 = 0
	if l_5_0._biker_roll_prev then
		l_5_2 = l_5_1 - l_5_0._biker_roll_prev
	end
	l_5_0._biker_roll_prev = l_5_1
	l_5_0._gatling_l:set_local_rotation(Rotation(l_5_0._gatling_l:local_rotation():yaw(), l_5_0._gatling_l:local_rotation():pitch() + (l_5_2), l_5_0._gatling_l:local_rotation():roll()))
	l_5_0._gatling_r:set_local_rotation(Rotation(l_5_0._gatling_r:local_rotation():yaw(), l_5_0._gatling_r:local_rotation():pitch() + (l_5_2), l_5_0._gatling_r:local_rotation():roll()))
	if l_5_1 > 0 then
		l_5_0._hip_l:set_local_position(l_5_0._hip_l:local_position() + Vector3(0, 0, -(l_5_2) * 1))
		l_5_0._hip_r:set_local_position(l_5_0._hip_r:local_position() + Vector3(0, 0, (l_5_2) * 1))
	elseif l_5_1 < 0 then
		l_5_0._hip_l:set_local_position(l_5_0._hip_l:local_position() + Vector3(0, 0, -(l_5_2) * 1))
		l_5_0._hip_r:set_local_position(l_5_0._hip_r:local_position() + Vector3(0, 0, (l_5_2) * 1))
	end
end

Biker._update_effects = function(l_6_0)
	local l_6_6, l_6_7 = nil
	local l_6_1 = l_6_0._unit:get_object("lo_charge_light")
	local l_6_2 = 0
	for i_0,i_1 in pairs(l_6_0._secondary_weapons) do
		l_6_2 = l_6_2 + i_1:logic():get_power_up_percent()
	end
	l_6_2 = (l_6_2) / #l_6_0._secondary_weapons
	l_6_1:set_multiplier(l_6_2 * 10000)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Biker._update_primary_weapon = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_1:weapon_data()
	local l_7_4 = l_7_1:base()
	local l_7_5 = l_7_0._input:primary_fire()
	local l_7_6 = l_7_0._input:primary_damage()
	if l_7_5 and not l_7_3._bullets_in_clip == 0 then
		l_7_3.fire_input = 1
	else
		l_7_3.fire_input = 0
	end
	if l_7_6 then
		l_7_4:set_bullet_damage(l_7_6)
	end
	l_7_3.aim_target_position = l_7_2
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_7_3._bullets_in_clip == 0 then
		l_7_1:base():reload()
	end
end

Biker._update_secondary_weapon = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_1:weapon_data()
	local l_8_4 = l_8_1:base()
	local l_8_5 = l_8_0._input:secondary_fire()
	local l_8_6 = l_8_0._input:secondary_damage()
	if l_8_5 and not l_8_3._bullets_in_clip == 0 then
		l_8_3.fire_input = 1
	else
		l_8_3.fire_input = 0
	end
	if l_8_6 then
		local l_8_10, l_8_11 = , l_8_4:set_explosion_damage_at_center
		local l_8_12 = l_8_4
		l_8_11(l_8_12, {hard = l_8_6, soft = l_8_6})
	end
	l_8_3.aim_target_position = l_8_2
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_8_10 then
		l_8_1:base():reload()
	end
end

Biker.destroy = function(l_9_0)
	Rail2WheeledVehicle.destroy(l_9_0)
	l_9_0._engine_sound:stop()
	l_9_0:_destroy_weapons()
end

Biker._destroy_weapons = function(l_10_0)
	local l_10_4, l_10_5, l_10_6, l_10_7, l_10_8, l_10_9 = nil
	if alive(l_10_0._primary_weapon_l) then
		World:delete_unit(l_10_0._primary_weapon_l)
		l_10_0._primary_weapon_l = nil
	end
	if alive(l_10_0._primary_weapon_r) then
		World:delete_unit(l_10_0._primary_weapon_r)
		l_10_0._primary_weapon_r = nil
	end
	for i_0,i_1 in pairs(l_10_0._secondary_weapons) do
		if alive(i_1) then
			World:delete_unit(i_1)
		end
	end
	l_10_0._secondary_weapons = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Biker._update_animation_speed = function(l_11_0)
	local l_11_1 = l_11_0._input:warp()
	if l_11_1 then
		local l_11_2 = l_11_0._input:target_unit():position()
		local l_11_3 = l_11_0._input:warp_distance()
		l_11_0._warp_time = l_11_0:get_animation_time_to_be_within(l_11_2, l_11_3)
	else
		local l_11_4 = l_11_0._input:speed()
		local l_11_5 = 1
		if l_11_4 then
			l_11_5 = l_11_4 / tweak_data.rail.biker.BIKER_SPEED_IN_ANIMATION
		end
		l_11_0:set_animation_speed(l_11_5)
	end
end

Biker._update_animation = function(l_12_0, l_12_1)
	l_12_0._unit:set_driving("animation")
	if l_12_0._warp_time then
		l_12_0._current_anim_time = l_12_0._warp_time
		l_12_0._state_machine:set_global("g_time", l_12_0._warp_time / l_12_0._total_animation_time)
		l_12_0._warp_time = nil
	elseif l_12_0._total_animation_time > 0 then
		l_12_0._current_anim_time = l_12_0._current_anim_time + l_12_1 * l_12_0._animation_speed_mult
		l_12_0._state_machine:set_global("g_time", l_12_0._current_anim_time / l_12_0._total_animation_time)
	end
end

Biker.get_animation_time_to_be_within = function(l_13_0, l_13_1, l_13_2)
	local l_13_3 = AnimationManager:animation_set(l_13_0._unit:name())
	local l_13_4 = l_13_3:animation_total_duration(l_13_0._current_animation)
	local l_13_5 = l_13_0._unit:position()
	local l_13_6 = l_13_0._unit:rotation()
	local l_13_7 = l_13_0._unit:orientation_object():name()
	local l_13_8 = 0
	local l_13_9 = l_13_3:animation_rotation(l_13_0._current_animation, l_13_7, l_13_8)
	l_13_6 = l_13_6 * l_13_9:inverse()
	do
		while 1 do
			local l_13_10 = l_13_5
			while l_13_8 < l_13_4 do
				l_13_8 = l_13_8 + 0.1
				local l_13_11 = l_13_3:animation_position(l_13_0._current_animation, l_13_7, l_13_8)
				local l_13_12 = l_13_11 - l_13_10
				l_13_10 = l_13_11
				l_13_12 = l_13_12:rotate_with(l_13_6)
				l_13_5 = l_13_5 + l_13_12
				if l_13_5 - l_13_1:length() < l_13_2 then
					return l_13_8
				end
			end
			return 0
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


