require("projectile/ProjectileSpawner")
require("projectile/InstantBullet")
require("projectile/InstantFeedbackBullet")
InstantBulletSpawner = InstantBulletSpawner or class(ProjectileSpawner)
function InstantBulletSpawner.init(A0_0, A1_1)
	ProjectileSpawner.init(A1_1)
	A0_0.slot_mask = managers.slot:get_mask(A0_0._slot_mask)
	A0_0._unit = A1_1
	A0_0._range = 0
	A0_0._near_damage_threshold = 0
	A0_0._near_damage = 0
	A0_0._far_damage_threshold = 0
	A0_0._far_damage = 0
	A0_0._slot_mask = nil
	A0_0._tracer_fx = nil
	A0_0._tracer_vel = nil
	A0_0._tracer_length = nil
	A0_0._tracer_rate = 3
	A0_0._tracer_rate_count = 0
	A0_0._decal = nil
	A0_0._decal_rate = 2
	A0_0._decal_rate_count = 1
	A0_0._damage = nil
	if A0_0._bullet_class == nil then
		A0_0._bullet_class = "InstantBullet"
	end
	A0_0._bullet_class_object = rawget(_G, A0_0._bullet_class)
	A0_0._emitter = managers.action_event:create_emitter(A1_1)
	A0_0._spawn_emitter_id = managers.projectile_manager:register_emitter(A0_0)
end
function InstantBulletSpawner.destroy(A0_2)
	A0_2._emitter:destroy()
	managers.projectile_manager:unregister_emitter(A0_2._spawn_emitter_id)
end
function InstantBulletSpawner.spawn_projectile(A0_3, A1_4, A2_5, A3_6)
	assert(A0_3._damage)
	if tweak_data.disable_spawn_projectiles then
		return nil
	end
	managers.projectile_manager:spawn_projectile_event(A0_3._spawn_emitter_id, InstantBulletSpawner.spawn_callback, A2_5, A3_6, A1_4)
	return nil
end
function InstantBulletSpawner.spawn_callback(A0_7, A1_8, A2_9, A3_10)
	local L4_11, L5_12, L6_13, L7_14, L8_15
	L5_12 = A0_7._tracer_rate_count
	if L5_12 == 0 then
		L4_11 = A0_7._tracer_fx
	end
	L5_12 = nil
	L6_13 = A0_7._decal_rate_count
	if L6_13 == 0 then
		L5_12 = A0_7._decal_fx
	end
	L6_13 = A0_7._tracer_rate_count
	L6_13 = L6_13 + 1
	L7_14 = A0_7._tracer_rate
	L6_13 = L6_13 % L7_14
	A0_7._tracer_rate_count = L6_13
	L6_13 = A0_7._decal_rate_count
	L6_13 = L6_13 + 1
	L7_14 = A0_7._decal_rate
	L6_13 = L6_13 % L7_14
	A0_7._decal_rate_count = L6_13
	L6_13 = A0_7._bullet_class_object
	L7_14 = L6_13
	L6_13 = L6_13.new
	L8_15 = A0_7._range
	L6_13 = L6_13(L7_14, L8_15, A0_7._near_damage_threshold, A0_7._near_damage, A0_7._far_damage_threshold, A0_7._far_damage, A0_7.slot_mask, L4_11, A0_7._tracer_vel, A0_7._tracer_length, A0_7._decal, A0_7._damage, A0_7._inflictor_type, A0_7._hi_target_speed, A0_7._unit:name())
	L7_14 = nil
	if A1_8 == nil then
		L8_15 = A0_7._unit
		L8_15 = L8_15.position
		L8_15 = L8_15(L8_15)
		L7_14 = L8_15
	else
		L7_14 = A1_8
	end
	L8_15 = nil
	if A2_9 == nil then
		L8_15 = A0_7._unit:rotation()
	else
		L8_15 = A2_9
	end
	if not alive(A3_10) then
		A3_10 = A0_7._unit
	end
	L6_13:spawn(A3_10, L7_14, L8_15)
	A0_7._emitter:unit_spawn_projectile(A3_10, A0_7._bullet_class, L7_14, L8_15)
	return L6_13
end
