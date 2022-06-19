require("shared/Angle")
require("shared/InterpolatorLinear")
if not SelfPropelledUnitProjectile then
	SelfPropelledUnitProjectile = class()
end
SelfPropelledUnitProjectile.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._spawning_unit = l_1_1
	l_1_0._orientation_obj = l_1_0._unit:orientation_object()
	l_1_0._detonation_time = 10
	l_1_0._start_position = l_1_0._unit:position()
	l_1_0._start_pitch = Rotation:look_at(l_1_0._unit:rotation():y(), Vector3(0, 0, 1)):yaw()
	l_1_0._start_yaw = Rotation:look_at(l_1_0._unit:rotation():y(), Vector3(0, 0, 1)):roll()
	l_1_0._start_rotation = l_1_0._unit:rotation()
	l_1_0._life_time = 10
	l_1_0._lived_time = 0
	l_1_0._rotation = l_1_0._rotation_min + math:random((l_1_0._rotation_max - l_1_0._rotation_min) * 10000) / 10000
	l_1_0._engine_init_time = 1
	l_1_0._initial_speed = 2500
	l_1_0._speed = 7000
	l_1_0._radial_velocity = 0
	l_1_0._velocity_dampening = 2
	l_1_0._gravity = 0
	l_1_0._current_velocity = Vector3(0, 0, 0)
	l_1_0._dispersion = 0.1
	l_1_0._blind_fire_dispersion = 1
	l_1_0._gravity_velocity = Vector3(0, 0, 0)
	l_1_0._radius = 0
	l_1_0._dispersion_radius = 50
	l_1_0._curr_angle = math.random(180)
	l_1_0._acceleration_dampening = 6
	l_1_0._inherited_velocity = Vector3(0, 0, 0)
	if Global.category_debug_render.projectile_trace then
		local l_1_2 = Draw:brush()
		l_1_2:set_persistance(60)
		l_1_2:set_color(Color(1, 0, 0, 1), 1)
		l_1_2:sphere(l_1_0._start_position, 5)
		local l_1_3 = Draw:pen("permanent")
		l_1_3:set("blue")
		l_1_3:line(l_1_0._start_position, l_1_0._start_position + l_1_0._start_rotation:y() * 100)
	end
end

SelfPropelledUnitProjectile.set_spawning_unit = function(l_2_0, l_2_1)
	l_2_0._spawning_unit = l_2_1
end

SelfPropelledUnitProjectile.set_blind_fire = function(l_3_0, l_3_1)
	if not l_3_1 or not l_3_0._blind_fire_dispersion then
		l_3_0._dispersion = l_3_0._dispersion
	end
end

SelfPropelledUnitProjectile.set_precision_aiming = function(l_4_0, l_4_1)
	if l_4_1 or not l_4_0._blind_fire_dispersion then
		l_4_0._dispersion = l_4_0._dispersion
	end
end

SelfPropelledUnitProjectile.update = function(l_5_0, l_5_1, l_5_2, l_5_3)
	l_5_0:_update_lifetime(l_5_1, l_5_2, l_5_3)
	l_5_0:_update_hit(l_5_1, l_5_2, l_5_3)
	l_5_0:_update_rotation(l_5_1, l_5_2, l_5_3)
	l_5_0:_update_position(l_5_1, l_5_2, l_5_3)
	l_5_0:_update_trail_effect(l_5_1, l_5_2, l_5_3)
	l_5_0:_update_projectile_effect(l_5_1, l_5_2, l_5_3)
	l_5_0._previous_position = l_5_0._unit:position()
end

SelfPropelledUnitProjectile._update_position = function(l_6_0, l_6_1, l_6_2, l_6_3)
	if not l_6_0._curr_speed then
		l_6_0._curr_speed = l_6_0._initial_speed
	end
	local l_6_4 = l_6_0._speed
	if l_6_0._lived_time < l_6_0._engine_init_time then
		l_6_4 = l_6_0._initial_speed
	end
	l_6_0._curr_speed = l_6_0._curr_speed + (l_6_4 - l_6_0._curr_speed) * l_6_0._acceleration_dampening * l_6_3
	l_6_0._gravity_velocity = l_6_0._gravity_velocity + l_6_0._gravity * Vector3(0, 0, -1) * l_6_3
	local l_6_5 = l_6_0._start_rotation:y():normalized() * l_6_0._curr_speed + l_6_0._gravity_velocity + l_6_0._inherited_velocity
	if l_6_0._radial_velocity and l_6_0._dispersion > 0 then
		local l_6_6 = l_6_0._unit:position() - l_6_0._start_position
		local l_6_7 = math.acos(math.dot(l_6_0._start_rotation:y():normalized(), l_6_6:normalized()))
		local l_6_8 = l_6_6:length() * math.sin(l_6_7)
		local l_6_9 = l_6_0._dispersion_radius * l_6_0._dispersion * (1 - l_6_0._lived_time / l_6_0._life_time)
		if (2 * l_6_9 >= l_6_8 and not l_6_0._left_dispersion) or l_6_9 >= l_6_8 then
			local l_6_13 = nil
			local l_6_14 = nil
			local l_6_15 = math.acos(math.dot(l_6_6:flat(l_6_0._start_rotation:y()):normalized(), l_6_0._start_rotation:x():normalized()))
			do
				local l_6_19 = nil
			end
			l_6_0._curr_angle = (360 - math.acos(math.dot(l_6_14, l_6_0._start_rotation:z():normalized())) + ((((l_6_15 <= 90 and math.acos(math.dot(l_6_14, l_6_0._start_rotation:z():normalized()))) or l_6_13) and 180) or (not l_6_0._left_dispersion and math.random(135, 225)) or 0)) % 360
			l_6_0._left_dispersion = true
		end
		do return end
		l_6_0._left_dispersion = false
		l_6_5 = l_6_5 + (l_6_0._start_rotation:z():normalized() * math.cos(l_6_0._curr_angle) * l_6_0._radial_velocity + l_6_0._start_rotation:x():normalized() * math.sin(l_6_0._curr_angle) * l_6_0._radial_velocity)
	end
	if l_6_0._velocity_dampening and l_6_0._velocity_dampening > 0 then
		l_6_0._current_velocity = l_6_0._current_velocity + (l_6_5 - l_6_0._current_velocity) * l_6_0._velocity_dampening * l_6_3
	else
		l_6_0._current_velocity = l_6_5
	end
	local l_6_20 = l_6_0._unit:position()
	l_6_0._unit:set_position(l_6_20 + l_6_0._current_velocity * l_6_3)
	if Global.category_debug_render.projectile_trace and l_6_0._previous_position then
		local l_6_21 = Draw:pen("permanent")
		l_6_21:set("green")
		l_6_21:line(l_6_0._previous_position, l_6_0._unit:position())
	end
end

SelfPropelledUnitProjectile._update_rotation = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if l_7_0._engine_init_time < l_7_0._lived_time and l_7_0._previous_position then
		local l_7_4 = Rotation(l_7_0._unit:rotation():x(), l_7_0._unit:position() - l_7_0._previous_position, l_7_0._unit:rotation():z()) * Rotation(Vector3(0, 1, 0), l_7_0._rotation * l_7_3)
		l_7_0._unit:set_rotation(l_7_4)
	end
end

SelfPropelledUnitProjectile._update_lifetime = function(l_8_0, l_8_1, l_8_2, l_8_3)
	if l_8_0._life_time <= l_8_0._lived_time then
		l_8_0:destroy(l_8_1)
	end
	l_8_0._lived_time = l_8_0._lived_time + l_8_3
end

SelfPropelledUnitProjectile._update_trail_effect = function(l_9_0, l_9_1, l_9_2, l_9_3)
	while l_9_0._trail_effect and l_9_0._trail_effect_init_distance <= l_9_0:distance_travelled() do
		local l_9_4 = l_9_0._unit:get_object(l_9_0._trail_effect_object)
		if not l_9_0._prev_trail_spawn_pos then
			l_9_0._prev_trail_spawn_pos = l_9_4:position()
			return 
		end
		local l_9_5 = l_9_4:position() - l_9_0._prev_trail_spawn_pos:length()
		local l_9_6 = l_9_4:position() - l_9_0._prev_trail_spawn_pos:normalized()
		while l_9_0._trail_effect_spawn_space < l_9_5 do
			local l_9_7 = l_9_0._prev_trail_spawn_pos + l_9_6 * l_9_0._trail_effect_spawn_space
			local l_9_8 = Rotation:look_at(l_9_0._prev_trail_spawn_pos, l_9_7, Vector3(0, 0, 1)) * Rotation(Vector3(1, 0, 0), 90)
			local l_9_9, l_9_10 = World:effect_manager():spawn, World:effect_manager()
			local l_9_11 = {}
			l_9_11.effect = l_9_0._trail_effect
			l_9_11.position = l_9_7
			l_9_11.rotation = l_9_8
			l_9_9 = l_9_9(l_9_10, l_9_11)
			l_9_10 = l_9_0._trail_effect_spawn_space
			l_9_5 = l_9_5 - l_9_10
			l_9_0._prev_trail_spawn_pos = l_9_7
			l_9_10 = Global
			l_9_10 = l_9_10.category_debug_render
			l_9_10 = l_9_10.projectile_trace
			if l_9_10 then
				l_9_10 = Draw
				l_9_10, l_9_11 = l_9_10:brush, l_9_10
				l_9_10 = l_9_10(l_9_11)
				l_9_11(l_9_10, 60)
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_9_11(l_9_10, Color(1, 0, 0, 1), 1)
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_9_11(l_9_10, l_9_7, 5)
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

SelfPropelledUnitProjectile._update_projectile_effect = function(l_10_0, l_10_1, l_10_2, l_10_3)
	if l_10_0._projectile_effect and not l_10_0._projectile_effect_id and l_10_0._projectile_effect_init_distance <= l_10_0:distance_travelled() then
		local l_10_4, l_10_5 = World:effect_manager():spawn, World:effect_manager()
		local l_10_6 = {}
		l_10_6.effect = l_10_0._projectile_effect
		l_10_6.parent = l_10_0._unit:get_object(l_10_0._projectile_effect_object)
		l_10_6.normal = Vector3(0, 1, 0)
		l_10_6.force_synch = true
		l_10_4 = l_10_4(l_10_5, l_10_6)
		l_10_0._projectile_effect_id = l_10_4
	end
end

SelfPropelledUnitProjectile._update_hit = function(l_11_0, l_11_1, l_11_2, l_11_3)
	if l_11_0._previous_position and l_11_0._safety_distance <= l_11_0:distance_travelled() then
		local l_11_4 = l_11_0._unit:position()
		local l_11_5 = l_11_0._previous_position
		local l_11_6 = nil
		if l_11_0._radius > 0 then
			local l_11_7 = managers.slot:get_mask("target_world") - SlotMask(l_11_0._ignore_unit_slot)
			l_11_6 = l_11_0._unit:raycast("ray", l_11_5, l_11_4, "ray_type", "body", "sphere_cast_radius", l_11_0._radius, "slot_mask", l_11_7, "ignore_unit", l_11_0._unit, "bundle", 5)
		else
			local l_11_8 = managers.slot:get_mask("solid_objects") - SlotMask(l_11_0._ignore_unit_slot)
			l_11_6 = l_11_0._unit:raycast("ray", l_11_5, l_11_4, "slot_mask", l_11_8, "ignore_unit", l_11_0._unit)
		end
	if l_11_6 then
		end
		local l_11_9 = l_11_6.position + l_11_6.normal * 20
		l_11_0:hit(l_11_9, l_11_6)
	if Global.category_debug_render.projectile_trace then
		end
		local l_11_10 = Draw:brush()
		l_11_10:set_persistance(60)
		l_11_10:set_color(Color(1, 1, 0, 0), 1)
		l_11_10:sphere(l_11_9, 5)
		local l_11_11 = Draw:pen("permanent")
		l_11_11:set("green")
		l_11_11:line(l_11_9, l_11_9 + l_11_6.normal * 100)
	end
end

SelfPropelledUnitProjectile.set_explosion_damage_at_center = function(l_12_0, l_12_1)
	l_12_0._explosion_damage_at_center = l_12_1
end

SelfPropelledUnitProjectile.set_explosion_radius = function(l_13_0, l_13_1)
	l_13_0._explosion_radius = l_13_1
end

SelfPropelledUnitProjectile.set_speed = function(l_14_0, l_14_1)
	l_14_0._speed = l_14_1
end

SelfPropelledUnitProjectile.set_initial_speed = function(l_15_0, l_15_1)
	l_15_0._initial_speed = l_15_1
end

SelfPropelledUnitProjectile.hit = function(l_16_0, l_16_1, l_16_2)
	local l_16_3 = World:spawn_unit(l_16_0._explosion_unit, l_16_1)
	if l_16_0._explosion_damage_at_center then
		l_16_3:base():set_damage_at_center(l_16_0._explosion_damage_at_center)
	end
	if l_16_3:base().set_spawning_unit then
		l_16_3:base():set_spawning_unit(l_16_0._spawning_unit)
	end
	if l_16_0._decal then
		local l_16_4 = l_16_2.ray - l_16_2.normal * l_16_2.ray:dot(l_16_2.normal) * 2
		local l_16_5 = World:project_decal(l_16_0._decal, l_16_1, l_16_2.ray, l_16_4, l_16_2.normal)
	if l_16_5 and l_16_5 ~= "" then
		end
		local l_16_6, l_16_7 = World:effect_manager():spawn, World:effect_manager()
		local l_16_8 = {}
		l_16_8.effect = l_16_5
		l_16_8.position = l_16_1
		l_16_8.normal = l_16_2.normal
		l_16_6(l_16_7, l_16_8)
	end
	local l_16_9, l_16_10 = World:effect_manager():spawn, World:effect_manager()
	local l_16_11 = {}
	l_16_11.effect = l_16_0._explosion_effect
	l_16_11.position = l_16_1
	l_16_11.normal = l_16_2.normal
	l_16_9(l_16_10, l_16_11)
	l_16_9 = l_16_0._unit
	l_16_9, l_16_10 = l_16_9:set_slot, l_16_9
	l_16_11 = 0
	l_16_9(l_16_10, l_16_11)
	l_16_9 = l_16_0._projectile_effect_kill_delay
	if l_16_9 then
		l_16_9 = World
		l_16_9, l_16_10 = l_16_9:effect_manager, l_16_9
		l_16_9 = l_16_9(l_16_10)
		l_16_9, l_16_10 = l_16_9:set_remaining_lifetime, l_16_9
		l_16_11 = l_16_0._projectile_effect_id
		l_16_9(l_16_10, l_16_11, l_16_0._projectile_effect_kill_delay)
	else
		l_16_9 = World
		l_16_9, l_16_10 = l_16_9:effect_manager, l_16_9
		l_16_9 = l_16_9(l_16_10)
		l_16_9, l_16_10 = l_16_9:fade_kill, l_16_9
		l_16_11 = l_16_0._projectile_effect_id
		l_16_9(l_16_10, l_16_11)
	end
end

SelfPropelledUnitProjectile.distance_travelled = function(l_17_0)
	local l_17_1 = l_17_0._unit:position()
	local l_17_2 = l_17_1 - l_17_0._start_position
	local l_17_3, l_17_4 = l_17_2:length, l_17_2
	return l_17_3(l_17_4)
end

SelfPropelledUnitProjectile.destroy = function(l_18_0, l_18_1)
	l_18_0._unit:set_slot(0)
	if l_18_0._projectile_effect_kill_delay then
		World:effect_manager():set_remaining_lifetime(l_18_0._projectile_effect_id, l_18_0._projectile_effect_kill_delay)
	else
		World:effect_manager():fade_kill(l_18_0._projectile_effect_id)
	end
end


