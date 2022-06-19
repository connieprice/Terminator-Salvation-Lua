require("projectile/ProjectileSpawner")
require("projectile/InstantBullet")
if not InstantShellSpawner then
	InstantShellSpawner = class(ProjectileSpawner)
end
InstantShellSpawner.init = function(l_1_0, l_1_1)
	ProjectileSpawner.init(l_1_1)
	l_1_0.slot_mask = managers.slot:get_mask(l_1_0._slot_mask)
	l_1_0._unit = l_1_1
	l_1_0._spread = 0
	l_1_0._range = 0
	l_1_0._near_damage_threshold = 0
	l_1_0._near_damage = 0
	l_1_0._far_damage_threshold = 0
	l_1_0._far_damage = 0
	l_1_0._slot_mask = nil
	l_1_0._tracer_fx = nil
	l_1_0._decal = nil
	l_1_0._damage = nil
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0._unit_map = {}
end

InstantShellSpawner.destroy = function(l_2_0)
	l_2_0._emitter:destroy()
end

InstantShellSpawner.spawn_projectile = function(l_3_0, l_3_1, l_3_2, l_3_3)
	assert(l_3_0._damage)
	l_3_0._spawning_unit = l_3_1
	local l_3_4 = l_3_0._inflictor_type
	if alive(l_3_1) and l_3_1:control():is_human_controlled() then
		l_3_4 = "player_" .. l_3_0._inflictor_type
	end
	local l_3_5 = l_3_2
	local l_3_6 = l_3_5 + l_3_3:y() * l_3_0._range
	local l_3_7 = l_3_6 - l_3_5
	local l_3_8 = l_3_7:dot(l_3_7)
	local l_3_9 = math.tan(l_3_0._spread)
	local l_3_10 = l_3_9 * l_3_0._range
	local l_3_15 = World:find_bodies
	local l_3_16 = World
	l_3_15 = l_3_15(l_3_16, "intersect", "cone", l_3_5, l_3_6, l_3_10, managers.slot:get_mask("shootable_wo_adr_shield"))
	local l_3_11 = nil
	l_3_16 = pairs
	l_3_11 = l_3_15
	l_3_16 = l_3_16(l_3_11)
	for i_0,i_1 in l_3_16 do
		if alive(l_3_14) and l_3_14:has_ray_type("body") then
			local l_3_22, l_3_24, l_3_26, l_3_42, l_3_44 = l_3_1:raycast, l_3_1, "ray", l_3_2, l_3_14:position()
			l_3_22 = l_3_22(l_3_24, l_3_26, l_3_42, l_3_44, "passed", callback(l_3_0, l_3_0, "add_body"), "slot_mask", managers.slot:get_mask("shootable_wo_adr_shield"))
			local l_3_17 = nil
		if l_3_22 then
			end
			l_3_24 = l_3_22.body
		if l_3_24 == l_3_14 then
			end
			l_3_24, l_3_26 = l_3_0:add_body, l_3_0
			l_3_42 = l_3_22
			local l_3_21, l_3_23, l_3_25 = nil
			l_3_24(l_3_26, l_3_42)
		end
	end
	for i_0,i_1 in pairs(l_3_0._unit_map) do
		for l_3_37,l_3_38 in pairs(i_1.bodies) do
			local l_3_27, l_3_43, l_3_45 = l_3_38.ray.body
			l_3_38.damage_ratio = 0
			l_3_43, l_3_45 = l_3_27:extension, l_3_27
			l_3_43 = l_3_43(l_3_45)
			if l_3_43 then
				l_3_43, l_3_45 = l_3_27:extension, l_3_27
				l_3_43 = l_3_43(l_3_45)
				l_3_43 = l_3_43.damage
			if l_3_43 then
				end
				l_3_43, l_3_45 = l_3_27:oobb, l_3_27
				l_3_43 = l_3_43(l_3_45)
				local l_3_28 = nil
				l_3_45 = math
				l_3_45 = l_3_45.clamp
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_3_45 = l_3_45(l_3_28, 0, 1)
				local l_3_29 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				local l_3_30 = nil
				l_3_29 = l_3_0._range
				l_3_29 = l_3_9 * l_3_29
				l_3_29 = l_3_29 * l_3_45
				local l_3_31 = nil
			if l_3_29 > 0 then
				end
				l_3_30, l_3_31 = l_3_43:center, l_3_43
				l_3_30 = l_3_30(l_3_31)
				local l_3_32 = nil
				l_3_31, l_3_32 = l_3_43:size, l_3_43
				l_3_31 = l_3_31(l_3_32)
				local l_3_33 = nil
				l_3_32 = l_3_31.x
				l_3_33 = l_3_31.y
				l_3_32 = l_3_32 + l_3_33
				l_3_33 = l_3_31.z
				l_3_32 = l_3_32 + l_3_33
				l_3_32 = (l_3_32) / 3
				local l_3_34 = nil
				l_3_33 = mvector3
				l_3_33 = l_3_33.distance
				l_3_34 = l_3_28
				l_3_33 = l_3_33(l_3_34, l_3_30)
				local l_3_35 = nil
				l_3_34 = l_3_32 + l_3_29
			if l_3_33 < l_3_34 then
				end
				l_3_34 = nil
				local l_3_36 = nil
				if l_3_32 < l_3_29 then
					l_3_35 = math
					l_3_35 = l_3_35.clamp
					l_3_36 = l_3_29 + l_3_32
					l_3_36 = l_3_36 - l_3_33
					l_3_36 = (l_3_36) / (2 * (l_3_32))
					l_3_35 = l_3_35(l_3_36, 0, 1)
					l_3_36 = l_3_32 / (l_3_29)
					l_3_35 = l_3_35 * (l_3_36)
					l_3_38.damage_ratio = l_3_35
				else
					l_3_35 = math
					l_3_35 = l_3_35.clamp
					l_3_36 = l_3_29 + l_3_32
					l_3_36 = l_3_36 - l_3_33
					l_3_36 = (l_3_36) / (2 * (l_3_29))
					l_3_35 = l_3_35(l_3_36, 0, 1)
					l_3_38.damage_ratio = l_3_35
				end
				l_3_35 = i_1.total_ratio
				l_3_36 = l_3_38.damage_ratio
				l_3_35 = l_3_35 + l_3_36
				i_1.total_ratio = l_3_35
			end
		end
	end
	for i_0,i_1 in pairs(l_3_0._unit_map) do
		for i_0,i_1 in pairs(i_1.bodies) do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_3_0:apply_damage(i_1.ray.body, i_1.ray, i_1.damage_ratio / math.max(1, l_3_39.total_ratio)) > 0 then
				l_3_0:apply_push(l_3_39.unit, i_1.ray.ray)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if 12 > 0 then
				l_3_0:play_effect(i_1.ray)
				 -- DECOMPILER ERROR: Confused about usage of registers!

			end
		end
	end
	while 12 - 1 > 0 do
		if World:raycast("ray", l_3_2, l_3_2 + l_3_3:y():spread(l_3_0._spread) * l_3_0._range, "slot_mask", managers.slot:get_mask("shootable_wo_adr_shield"), "ignore_unit", l_3_1) then
			l_3_0:play_effect(World:raycast("ray", l_3_2, l_3_2 + l_3_3:y():spread(l_3_0._spread) * l_3_0._range, "slot_mask", managers.slot:get_mask("shootable_wo_adr_shield"), "ignore_unit", l_3_1))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

InstantShellSpawner.apply_damage = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if alive(l_4_1) and l_4_1:extension() and l_4_1:extension().damage then
		local l_4_4 = l_4_0:calculate_damage(l_4_2.distance, l_4_2.body)
		local l_4_5 = assert
		l_4_5(l_4_4 >= 0)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		assert(l_4_0._damage)
		l_4_0._damage.damage_factor = l_4_4 * l_4_3
		l_4_0._damage.inflictor_type = l_4_0._inflictor_type
		return l_4_5
	end
	return 0
	 -- WARNING: undefined locals caused missing assignments!
end

InstantShellSpawner.apply_push = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_1:physics()
	if l_5_3 then
		l_5_3:push(0.01, 10000 * l_5_2)
	end
end

InstantShellSpawner.calculate_damage = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._far_damage_threshold < l_6_1 then
		return l_6_0._far_damage
	elseif l_6_0._near_damage_threshold < l_6_1 then
		local l_6_3 = 1 - l_6_0._far_damage
		local l_6_4 = assert
		l_6_4(l_6_3 >= 0)
		l_6_4 = l_6_0._far_damage_threshold
		l_6_4 = l_6_4 - l_6_0._near_damage_threshold
		local l_6_7 = assert
		l_6_7(l_6_4 >= 0)
		l_6_7 = l_6_0._near_damage_threshold
		l_6_7 = l_6_1 - l_6_7
		l_6_7 = (l_6_7) / (l_6_4)
		l_6_7 = l_6_3 * (l_6_7)
		l_6_7 = 1 - l_6_7
		return l_6_7
	else
		return 1
	end
end

InstantShellSpawner.play_effect = function(l_7_0, l_7_1)
	local l_7_2 = l_7_1.ray - l_7_1.normal * l_7_1.ray:dot(l_7_1.normal) * 2
	local l_7_3 = World:project_decal(l_7_0._decal, l_7_1.position, l_7_1.ray, l_7_2, l_7_1.normal)
	local l_7_4 = l_7_1.unit
	if l_7_3 and l_7_3 ~= "" and script_debug.draw_gunfx then
		local l_7_5, l_7_6 = World:effect_manager():spawn, World:effect_manager()
		local l_7_7 = {}
		l_7_7.effect = l_7_3
		l_7_7.position = l_7_1.position
		l_7_7.normal = l_7_1.normal
		l_7_7.force_sync = true
		l_7_5(l_7_6, l_7_7)
	end
end

InstantShellSpawner.add_body = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0._unit_map[l_8_1.body:unit():key()]
	if l_8_2 == nil then
		local l_8_3 = {}
		l_8_3.bodies = {}
		l_8_3.hit = false
		l_8_3.total_ratio = 0
		l_8_3.unit = l_8_1.body:unit()
		l_8_2 = l_8_3
		l_8_3 = l_8_0._unit_map
		l_8_3[l_8_1.body:unit():key()] = l_8_2
	end
	if l_8_2.bodies[l_8_1.body:key()] == nil then
		local l_8_4 = l_8_2.bodies
		local l_8_5 = l_8_1.body:key()
		local l_8_6 = {}
		l_8_6.ray = l_8_1
		l_8_4[l_8_5] = l_8_6
	end
end


