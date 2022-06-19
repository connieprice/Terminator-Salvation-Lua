PointUnitProjectile = PointUnitProjectile or class()
function PointUnitProjectile.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._detonation_time = 10
	A0_0._explode_when_dead = true
	A0_0._start_position = A0_0._unit:position()
	A0_0._keep_on_ground_time = 5
	if A0_0._projectile_effect then
		A0_0._projectile_effect_id = World:effect_manager():spawn({
			effect = A0_0._projectile_effect,
			parent = A0_0._unit:get_object("rp_empty"),
			normal = Vector3(0, 1, 0),
			force_synch = true
		})
	end
end
function PointUnitProjectile.update(A0_2, A1_3, A2_4, A3_5)
	local L4_6, L5_7, L6_8, L7_9, L8_10
	L4_6 = A0_2._unit
	L5_7 = L4_6
	L4_6 = L4_6.move
	L6_8 = A0_2._unit
	L7_9 = L6_8
	L6_8 = L6_8.rotation
	L6_8 = L6_8(L7_9)
	L7_9 = L6_8
	L6_8 = L6_8.y
	L6_8 = L6_8(L7_9)
	L7_9 = A0_2._velocity
	L7_9 = L7_9 * A3_5
	L6_8 = L6_8 * L7_9
	L4_6(L5_7, L6_8)
	L4_6 = A0_2._previous_position
	if L4_6 then
		L5_7 = A0_2
		L4_6 = A0_2.distance_travelled
		L4_6 = L4_6(L5_7)
		L5_7 = A0_2._safety_distance
		if L4_6 >= L5_7 then
			L4_6 = A0_2._unit
			L5_7 = L4_6
			L4_6 = L4_6.position
			L4_6 = L4_6(L5_7)
			L5_7 = A0_2._previous_position
			L6_8 = managers
			L6_8 = L6_8.slot
			L7_9 = L6_8
			L6_8 = L6_8.get_mask
			L8_10 = "solid_objects"
			L6_8 = L6_8(L7_9, L8_10)
			L7_9 = A0_2._unit
			L8_10 = L7_9
			L7_9 = L7_9.raycast
			L7_9 = L7_9(L8_10, "ray", L5_7, L4_6, "slot_mask", L6_8, "ignore_unit", A0_2._unit)
			if L7_9 then
				L8_10 = L7_9.position
				L8_10 = L8_10 + L7_9.normal * 20
				A0_2:hit(L8_10, L7_9.normal)
			end
		end
	end
	L4_6 = A0_2._unit
	L5_7 = L4_6
	L4_6 = L4_6.position
	L4_6 = L4_6(L5_7)
	A0_2._previous_position = L4_6
	L4_6 = Global
	L4_6 = L4_6.category_debug_render
	L4_6 = L4_6.projectile_trace
	if L4_6 then
		L5_7 = A0_2
		L4_6 = A0_2._draw_projectile_trace
		L4_6(L5_7)
	end
end
function PointUnitProjectile.hit(A0_11, A1_12, A2_13)
	if A0_11._explosion_damage_at_center then
		World:spawn_unit("explosion", A1_12):explosion()._damage_at_center = A0_11._explosion_damage_at_center
	end
	if A0_11._explosion_radius then
		World:spawn_unit("explosion", A1_12):explosion()._radius = A0_11._explosion_radius
	end
	World:effect_manager():spawn({
		effect = A0_11._explosion_effect,
		position = A1_12,
		normal = A2_13
	})
	A0_11._unit:set_slot(0)
	World:effect_manager():kill(A0_11._projectile_effect_id)
end
function PointUnitProjectile._draw_projectile_trace(A0_14)
	local L1_15, L2_16
	L1_15 = A0_14._unit
	L2_16 = L1_15
	L1_15 = L1_15.position
	L1_15 = L1_15(L2_16)
	L2_16 = A0_14._prev_pos
	if L2_16 then
		L2_16 = Draw
		L2_16 = L2_16.pen
		L2_16 = L2_16(L2_16, "one_second")
		L2_16:set("green")
		L2_16:line(A0_14._prev_pos, L1_15)
	end
	L2_16 = A0_14._unit
	L2_16 = L2_16.position
	L2_16 = L2_16(L2_16)
	A0_14._prev_pos = L2_16
	L2_16 = Draw
	L2_16 = L2_16.brush
	L2_16 = L2_16(L2_16)
	L2_16:set_color(Color(1, 1, 0, 0), 1)
	L2_16:sphere(A0_14._unit:position(), 10)
	L2_16 = Draw:pen("permanent")
	L2_16:rotation(A0_14._unit:get_object("rp_empty"):position(), A0_14._unit:get_object("rp_empty"):rotation(), 100)
end
function PointUnitProjectile.distance_travelled(A0_17)
	return (A0_17._unit:position() - A0_17._start_position):length()
end
function PointUnitProjectile.destroy(A0_18, A1_19)
	A0_18._unit:set_slot(0)
	World:effect_manager():kill(A0_18._projectile_effect_id)
end
