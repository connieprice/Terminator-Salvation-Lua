require("projectile/ProjectileSpawner")
require("projectile/InstantBullet")
require("projectile/InstantFeedbackBullet")
if not InstantBulletSpawner then
	InstantBulletSpawner = class(ProjectileSpawner)
end
InstantBulletSpawner.init = function(l_1_0, l_1_1)
	ProjectileSpawner.init(l_1_1)
	l_1_0.slot_mask = managers.slot:get_mask(l_1_0._slot_mask)
	l_1_0._unit = l_1_1
	l_1_0._range = 0
	l_1_0._near_damage_threshold = 0
	l_1_0._near_damage = 0
	l_1_0._far_damage_threshold = 0
	l_1_0._far_damage = 0
	l_1_0._slot_mask = nil
	l_1_0._tracer_fx = nil
	l_1_0._tracer_vel = nil
	l_1_0._tracer_length = nil
	l_1_0._tracer_rate = 3
	l_1_0._tracer_rate_count = 0
	l_1_0._decal = nil
	l_1_0._decal_rate = 2
	l_1_0._decal_rate_count = 1
	l_1_0._damage = nil
	if l_1_0._bullet_class == nil then
		l_1_0._bullet_class = "InstantBullet"
	end
	l_1_0._bullet_class_object = rawget(_G, l_1_0._bullet_class)
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0._spawn_emitter_id = managers.projectile_manager:register_emitter(l_1_0)
end

InstantBulletSpawner.destroy = function(l_2_0)
	l_2_0._emitter:destroy()
	managers.projectile_manager:unregister_emitter(l_2_0._spawn_emitter_id)
end

InstantBulletSpawner.spawn_projectile = function(l_3_0, l_3_1, l_3_2, l_3_3)
	assert(l_3_0._damage)
	if tweak_data.disable_spawn_projectiles then
		return nil
	end
	managers.projectile_manager:spawn_projectile_event(l_3_0._spawn_emitter_id, InstantBulletSpawner.spawn_callback, l_3_2, l_3_3, l_3_1)
	return nil
end

InstantBulletSpawner.spawn_callback = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = nil
	if l_4_0._tracer_rate_count == 0 then
		l_4_4 = l_4_0._tracer_fx
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_0._decal_rate_count == 0 then
		local l_4_5 = nil
		local l_4_6 = (l_4_0._bullet_class_object:new(l_4_0._range, l_4_0._near_damage_threshold, l_4_0._near_damage, l_4_0._far_damage_threshold, l_4_0._far_damage, l_4_0.slot_mask, l_4_4, l_4_0._tracer_vel, l_4_0._tracer_length, l_4_0._decal, l_4_0._damage, l_4_0._inflictor_type, l_4_0._hi_target_speed, l_4_0._unit:name()))
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_4_1 == nil then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		do
			local l_4_7 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_4_2 == nil then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if not alive(l_4_3) then
				l_4_6:spawn(l_4_3, l_4_7, nil)
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_4_0._emitter:unit_spawn_projectile(l_4_3, l_4_0._bullet_class, l_4_7, nil)
				return l_4_6
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 10 63 
end


