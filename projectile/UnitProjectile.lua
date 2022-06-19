if not UnitProjectile then
	UnitProjectile = class()
end
UnitProjectile.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._spawning_unit = l_1_1
	l_1_0._detonation_time = 20
	l_1_0._explode_when_dead = true
	l_1_0._start_position = l_1_0._unit:position()
	l_1_0._min_detonation_time = 0
	l_1_0._detonate_on_proximity = nil
	l_1_0._detonate_on_collision = true
	l_1_0._proximity_radius = 100
	l_1_0._anti_gravity = 0
	l_1_0._drop_down_distance = nil
	l_1_0._drop_down_time = 0.5
	l_1_0._drop_down_x_velocity_multiplier = 5
	l_1_0._drop_down_y_velocity_multiplier = 5
	l_1_0._drop_down_z_velocity_multiplier = 10
	l_1_0._drop_down_z_gravity = 0
	l_1_0._explosion_covers_slot_mask = managers.slot:get_mask("explosion_covers")
	if not l_1_0._min_detonation_distance then
		l_1_0._min_detonation_distance = 0
	end
	if not l_1_0._explosion_effect then
		l_1_0._explosion_effect = "weapon_m79_explosion"
	end
	l_1_1:set_body_collision_callback(callback(l_1_0, l_1_0, "collision_callback"))
	l_1_0._work_item_vector = {}
	l_1_0._rays_per_frame = 6
	l_1_0._explode_at_position = nil
	l_1_0._blind_fire_velocity_forward = 500
	l_1_0._blind_fire_velocity_up = 500
	l_1_0._ignore_self = true
end

UnitProjectile.set_blind_fire = function(l_2_0, l_2_1)
	l_2_0._blind_fire = l_2_1
end

UnitProjectile.set_spawning_unit = function(l_3_0, l_3_1)
	l_3_0._spawning_unit = l_3_1
end

UnitProjectile.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if not l_4_0._init_push then
		if l_4_0._blind_fire then
			l_4_1:push(l_4_1:mass(), l_4_1:rotation():y() * l_4_0._blind_fire_velocity_forward)
			l_4_1:push(l_4_1:mass(), math.UP * l_4_0._blind_fire_velocity_up)
		else
			l_4_1:push(l_4_1:mass(), l_4_1:rotation():y() * l_4_0._initial_velocity)
			l_4_0._init_push = true
		end
		l_4_0._detonation_time = l_4_0._detonation_time - l_4_3
		l_4_0._min_detonation_time = l_4_0._min_detonation_time - l_4_3
		local l_4_4 = l_4_0:distance_travelled()
		l_4_0:_update_arc(l_4_1, l_4_3, l_4_4)
		local l_4_5 = nil
		if l_4_0._detonate_on_proximity then
			if l_4_0._min_detonation_time <= 0 or l_4_0._min_detonation_distance <= l_4_4 then
				local l_4_6 = l_4_0:_check_proximity()
			end
		do
			else
				local l_4_14 = false
				end
				if (not l_4_14 and l_4_0._detonate_on_collision and l_4_14) or l_4_0._detonation_time <= 0 or not l_4_0._unit:damage_data() or not l_4_0._unit:damage_data():is_fully_damaged() or l_4_0._explode_when_dead then
					l_4_0:_detonate(nil)
				end
				if Global.category_debug_render.projectile_trace then
					l_4_0:_draw_projectile_trace()
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 65 
end

UnitProjectile.collision_callback = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5, l_5_6, l_5_7, l_5_8)
	if l_5_0._ignore_self and l_5_4 == l_5_0._spawning_unit then
		return 
	end
	l_5_0._collided = true
	l_5_0._collision_normal = l_5_7
	l_5_0._collision_position = l_5_6
end

UnitProjectile._detonate = function(l_6_0, l_6_1)
	if not l_6_1 then
		l_6_1 = l_6_0._unit:position()
	end
	l_6_0._unit:set_slot(0)
	local l_6_2 = World:spawn_unit(l_6_0._explosion_unit, l_6_1)
	if l_6_2:base().set_spawning_unit then
		l_6_2:base():set_spawning_unit(l_6_0._spawning_unit)
	end
	local l_6_3 = Rotation(math.UP, 0)
	if l_6_0._detonate_on_collision then
		l_6_3 = l_6_0._unit:rotation()
	end
	local l_6_4, l_6_5 = World:effect_manager():spawn, World:effect_manager()
	local l_6_6 = {}
	l_6_6.effect = l_6_0._explosion_effect
	l_6_6.position = l_6_0._unit:position()
	l_6_6.rotation = l_6_3
	l_6_4(l_6_5, l_6_6)
	l_6_4 = l_6_0._decal
	if l_6_4 then
		l_6_4 = l_6_0._last_blocked_ray
		if l_6_4 then
			l_6_4 = l_6_0._last_blocked_ray
			l_6_5 = l_6_4.ray
			l_6_6 = l_6_4.normal
			l_6_6 = l_6_6 * l_6_4.ray:dot(l_6_4.normal)
			l_6_6 = l_6_6 * 2
			l_6_5 = l_6_5 - l_6_6
			l_6_6 = World
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_6_6 and l_6_6 ~= "" then
				local l_6_7, l_6_8 = World:effect_manager():spawn, World:effect_manager()
				local l_6_9 = {}
				l_6_9.effect = l_6_6
				l_6_9.position = l_6_1
				l_6_9.normal = l_6_4.normal
				l_6_7(l_6_8, l_6_9)
			end
			l_6_0._last_blocked_ray = nil
		end
	else
		l_6_4 = World
		l_6_4, l_6_5 = l_6_4:project_decal, l_6_4
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_6_4 = l_6_4(l_6_5, l_6_6, l_6_1, Vector3(0, 0, -1))
	if l_6_4 and l_6_4 ~= "" then
		end
		l_6_5 = World
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_6_5 = l_6_5:effect_manager
		l_6_5 = l_6_5(l_6_6)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_6_5 = l_6_5:spawn
		local l_6_10 = {}
		l_6_10.effect = l_6_4
		l_6_10.position = l_6_1
		l_6_10.normal = Vector3(0, 0, 1)
		l_6_5(l_6_6, l_6_10)
	end
end

UnitProjectile._update_arc = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if l_7_0._drop_down_distance and l_7_0._drop_down_distance < l_7_3 and l_7_0._drop_down_time > 0 and not l_7_0._collided then
		l_7_0._drop_down_time = l_7_0._drop_down_time - l_7_2
		local l_7_4 = l_7_0._unit
		local l_7_5 = l_7_4:velocity()
		local l_7_6 = l_7_0._drop_down_x_velocity_multiplier * l_7_2 * -l_7_5.x
		local l_7_7 = l_7_0._drop_down_y_velocity_multiplier * l_7_2 * -l_7_5.y
		if l_7_5.z <= 0 or not l_7_0._drop_down_z_velocity_multiplier * l_7_2 * -l_7_5.z then
			local l_7_8, l_7_9 = l_7_0._drop_down_z_gravity * l_7_2
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_7_10 = nil
		l_7_4:push(l_7_4:mass(), Vector3(l_7_6, l_7_7, l_7_8))
	elseif not l_7_0._collided and math.abs(l_7_0._anti_gravity) > 0 then
		local l_7_11 = Vector3(0, 0, l_7_0._anti_gravity * l_7_2)
		l_7_1:push(l_7_1:mass(), l_7_11)
	end
end

UnitProjectile.distance_travelled = function(l_8_0)
	local l_8_1 = l_8_0._unit:position()
	local l_8_2 = l_8_1 - l_8_0._start_position
	local l_8_3, l_8_4 = l_8_2:length, l_8_2
	return l_8_3(l_8_4)
end

UnitProjectile._check_proximity = function(l_9_0)
	assert(l_9_0._detonate_on_proximity)
	local l_9_1 = l_9_0._unit
	local l_9_8, l_9_9 = World:find_units, World
	l_9_8 = l_9_8(l_9_9, "sphere", l_9_1:position(), l_9_0._proximity_radius, managers.slot:get_mask("enemies"))
	local l_9_2 = nil
	local l_9_3 = nil
	l_9_2, l_9_3 = l_9_1:position, l_9_1
	l_9_2 = l_9_2(l_9_3)
	local l_9_4 = nil
	l_9_3 = pairs
	l_9_4 = l_9_8
	l_9_3 = l_9_3(l_9_4)
	for i_0,i_1 in l_9_3 do
		local l_9_10 = {}
		local l_9_11 = {}
		l_9_11.unit = l_9_7
		l_9_11.body_queue = l_9_10
		l_9_11.position = l_9_2
		table.insert(l_9_9, l_9_11)
		local l_9_12 = l_9_7:num_bodies()
		for l_9_16 = 0, l_9_12 - 1 do
			local l_9_17 = l_9_7:body(l_9_16)
			if l_9_17:enabled() then
				local l_9_18 = table.insert
				local l_9_19 = l_9_10
				local l_9_20 = {}
				l_9_20.body = l_9_17
				l_9_18(l_9_19, l_9_20)
			end
		end
	end
	if #l_9_9 > 0 then
		table.insert(l_9_0._work_item_vector, l_9_9)
	end
	while 1 do
		while l_9_0._rays_per_frame > 0 and #l_9_0._work_item_vector > 0 do
			assert(l_9_0._work_item_vector[1][1])
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_9_0:raycast_for_work_item(l_9_1, l_9_0._work_item_vector[1][1]) then
				return true, l_9_0._work_item_vector[1][1].position
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			table.remove(l_9_0._work_item_vector[1], 1)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if #l_9_0._work_item_vector[1] <= 0 then
				table.remove(l_9_0._work_item_vector, 1)
			end
		end
		return false
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
end

UnitProjectile.is_all_work_done = function(l_10_0)
	return #l_10_0._work_item_vector > 0
end

UnitProjectile.raycast_for_work_item = function(l_11_0, l_11_1, l_11_2)
	if not alive(l_11_2.unit) or #l_11_2.body_queue == 0 then
		return false
	end
	local l_11_3 = table.remove(l_11_2.body_queue, 1)
	local l_11_4 = l_11_1:raycast("ray", l_11_2.position, l_11_3.body:center_of_mass(), "slot_mask", l_11_0._explosion_covers_slot_mask, "ignore_unit", l_11_2.unit)
	l_11_0._last_blocked_ray = l_11_4
	return not l_11_4
end

UnitProjectile._draw_projectile_trace = function(l_12_0)
	local l_12_1 = l_12_0._unit:position()
	if l_12_0._prev_pos then
		local l_12_2 = Draw:pen("one_second")
		l_12_2:set("green")
		l_12_2:line(l_12_0._prev_pos, l_12_1)
	end
	l_12_0._prev_pos = l_12_0._unit:position()
end


