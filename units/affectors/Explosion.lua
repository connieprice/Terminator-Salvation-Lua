if not Explosion then
	Explosion = class()
end
debug_throw_grenade = function()
		local l_1_0 = managers.player:players()
		local l_1_1, l_1_2 = next(l_1_0, nil)
		assert(l_1_2)
		if l_1_2 then
			local l_1_3 = l_1_2:player_data()
			local l_1_4 = l_1_3.camera_position
			local l_1_5 = Vector3(0, 1, 0):rotate_with(l_1_3.camera_rotation)
			local l_1_6 = World:spawn_unit("hand_grenade", l_1_4 + 150 * l_1_5)
			l_1_6:push(10, l_1_5 * 1000)
		end
  end
Explosion.init = function(l_2_0, l_2_1)
	l_2_0._unit = l_2_1
	l_2_0._spawning_unit = l_2_1
	l_2_0._action_emitter = managers.action_event:create_emitter(l_2_1)
	l_2_0._potential_victims_slot_mask = managers.slot:get_mask("explosion_targets")
	l_2_0._explosion_covers_slot_mask = managers.slot:get_mask("explosion_covers")
	l_2_0._radius = nil
	l_2_0._rays_per_frame = 10
	l_2_0._physics_effect = nil
	l_2_0._found_potential_victims = false
	l_2_0._body_damage_factor = 0.01
	l_2_0._action_emitter:unit_explosion(l_2_1, l_2_0._unit:position())
	local l_2_5, l_2_6 = pairs, managers.player:human_players()
	l_2_5 = l_2_5(l_2_6)
	for i_0,i_1 in l_2_5 do
		l_2_0._action_emitter:unit_explosion(l_2_4, l_2_0._unit:position())
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Explosion.destroy = function(l_3_0)
	l_3_0._action_emitter:destroy()
	l_3_0._action_emitter = nil
end

Explosion.set_spawning_unit = function(l_4_0, l_4_1)
	l_4_0._spawning_unit = l_4_1
end

Explosion.set_faith_damage = function(l_5_0, l_5_1)
	l_5_0._damage.hard = l_5_1.hard
	l_5_0._damage.soft = l_5_1.soft
end

Explosion.set_inflictor_type = function(l_6_0, l_6_1)
	l_6_0._inflictor_type = l_6_1
end

Explosion._find_potential_victims = function(l_7_0)
	local l_7_5 = World:find_units
	local l_7_6 = World
	l_7_5 = l_7_5(l_7_6, "intersect", "force_physics", "sphere", l_7_0._unit:position(), l_7_0._radius, l_7_0._potential_victims_slot_mask)
	local l_7_1 = nil
	l_7_0._work_item_vector, l_7_6 = l_7_6, {}
	l_7_6 = pairs
	l_7_1 = l_7_5
	l_7_6 = l_7_6(l_7_1)
	for i_0,i_1 in l_7_6 do
		if alive(l_7_4) and (not l_7_4:damage_data() or not l_7_4:damage_data():is_fully_damaged()) then
			local l_7_7 = {}
			local l_7_8 = {}
			local l_7_9 = {}
			l_7_9.is_done = false
			l_7_9.unit = l_7_4
			l_7_9.body_queue = l_7_7
			l_7_9.hit_bodies = l_7_8
			l_7_9.num_damage_bodies = 0
			local l_7_10 = l_7_4:num_bodies()
			for l_7_14 = 0, l_7_10 - 1 do
				local l_7_15 = l_7_4:body(l_7_14)
				if l_7_15:enabled() and l_7_15:has_ray_type("explosion") then
					if l_7_15:extension() and l_7_15:extension().damage then
						local l_7_16 = l_7_15:extension().damage
					if l_7_16.is_explosion_receiver then
						end
					if l_7_16:is_explosion_receiver() then
						end
						local l_7_17 = table.insert
						local l_7_18 = l_7_7
						local l_7_19 = {}
						l_7_19.body = l_7_15
						l_7_19.body_damage_extension = l_7_16
						l_7_17(l_7_18, l_7_19)
					end
				else
					local l_7_20 = table.insert
					local l_7_21 = l_7_7
					local l_7_22 = {}
					l_7_22.body = l_7_15
					l_7_20(l_7_21, l_7_22)
				end
			end
		if #l_7_7 > 0 then
			end
			l_7_9.num_damage_bodies = #l_7_9.body_queue
			table.insert(l_7_0._work_item_vector, l_7_9)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Explosion.update = function(l_8_0, l_8_1, l_8_2, l_8_3)
	if not l_8_0._found_potential_victims then
		l_8_0:_find_potential_victims()
		l_8_0._found_potential_victims = true
		l_8_0._current_work_item = 1
	end
	if l_8_0:is_all_work_done() then
		l_8_0._unit:set_slot(0)
		return 
	end
	do
		while 1 do
			local l_8_4 = l_8_0._rays_per_frame
			while l_8_4 > 0 and not l_8_0:is_all_work_done() do
				local l_8_5 = l_8_0._work_item_vector[l_8_0._current_work_item]
				if not l_8_5.is_done then
					l_8_0:raycast_for_work_item(l_8_5)
					l_8_4 = l_8_4 - 1
				end
				l_8_0._current_work_item = l_8_0._current_work_item + 1
				if #l_8_0._work_item_vector < l_8_0._current_work_item then
					l_8_0._current_work_item = 1
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

Explosion.is_all_work_done = function(l_9_0)
	local l_9_4, l_9_5 = nil
	for i_0,i_1 in ipairs(l_9_0._work_item_vector) do
		if not i_1.is_done then
			return false
		end
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Explosion.raycast_for_work_item = function(l_10_0, l_10_1)
	if not alive(l_10_1.unit) then
		l_10_1.is_done = true
		return true
	end
	local l_10_2 = assert
	l_10_2(#l_10_1.body_queue ~= 0)
	l_10_2 = table
	l_10_2 = l_10_2.remove
	l_10_2 = l_10_2(l_10_1.body_queue, 1)
	local l_10_5 = l_10_2.body:oobb():center()
	local l_10_6 = (World:raycast("ray", l_10_0._unit:position(), l_10_5, "slot_mask", l_10_0._explosion_covers_slot_mask, "ray_type", "explosion"))
	local l_10_7, l_10_8 = nil, nil
	if not l_10_6 then
		l_10_7 = l_10_0:_setup_body_damage(l_10_2.body, l_10_5 - l_10_0._unit:position())
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		if l_10_1.unit == l_10_6.unit then
			l_10_7 = l_10_0:_setup_body_damage(l_10_2.body, l_10_6.position - l_10_0._unit:position())
		end
	end
	if l_10_7 then
		local l_10_9 = table.insert
		local l_10_10 = l_10_1.hit_bodies
		local l_10_11 = {}
		l_10_11.body = l_10_2.body
		l_10_11.damage = l_10_7
		l_10_11.direction = l_10_8
		l_10_9(l_10_10, l_10_11)
	else
		l_10_1.num_damage_bodies = l_10_1.num_damage_bodies - 1
	end
	if #l_10_1.body_queue == 0 then
		l_10_1.is_done = true
	if #l_10_1.hit_bodies > 0 then
		end
		local l_10_12 = function(l_11_0, l_11_1)
			return l_11_0.damage.distance < l_11_1.damage.distance
    end
		table.sort(l_10_1.hit_bodies, l_10_12)
		l_10_0:deal_damage_to_unit(l_10_1.unit, l_10_1.hit_bodies, l_10_1.num_damage_bodies)
	end
end

Explosion._setup_body_damage = function(l_11_0, l_11_1, l_11_2)
	if l_11_1:extension() and l_11_1:extension().damage then
		if l_11_2:length() == 0 then
			l_11_2 = Vector3(1, 0, 0)
			do
				local l_11_3, l_11_4 = 0.001
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_11_2 = l_11_2 * (1 / l_11_3)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_11_5 = nil
		local l_11_6 = l_11_3 / l_11_0._radius
		local l_11_7 = nil
		local l_11_8 = nil
		local l_11_9 = math.clamp((1 - l_11_6) * l_11_1:oobb():size():length() * l_11_0._body_damage_factor, 0, 1)
		return {hard = l_11_0._damage_at_center.hard, soft = l_11_0._damage_at_center.soft, damage_factor = l_11_9, inflictor_type = l_11_0._inflictor_type, size = l_11_8, distance = l_11_5}, l_11_2, l_11_8
	end
	return nil
end

Explosion.set_damage_at_center = function(l_12_0, l_12_1)
	l_12_0._damage_at_center = l_12_1
end

Explosion.deal_damage_to_unit = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_8, l_13_9, l_13_10, l_13_11, l_13_12, l_13_13, l_13_14, l_13_15 = nil
	local l_13_4 = 0
	for i_0,i_1 in pairs(l_13_2) do
		local l_13_18 = i_1.body
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		do
			local l_13_19, l_13_20 = nil
	end
	if l_13_4 < l_13_18:extension().damage then
		end
		if l_13_0._physics_effect and l_13_0._physics_effect ~= "" and l_13_4 > 0 and (not l_13_1:damage_data() or l_13_1:damage_data().is_affected_by_explosion_physics_effect) then
			World:play_physic_effect(l_13_0._physics_effect, l_13_1, l_13_0._unit:position(), l_13_0._radius, l_13_4)
		end
		l_13_0._action_emitter:unit_explode(l_13_1, l_13_0._unit:position(), l_13_4)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 31 
end


