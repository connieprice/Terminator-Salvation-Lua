require("projectile/InstantBulletSpawner")
require("shared/VectorUtilities")
BikerGatling = BikerGatling or class(MiniGun)
function BikerGatling.init(A0_0, A1_1)
	MiniGun.init(A0_0, A1_1)
	A0_0._bullet_tracers = {}
	A0_0._bullets_fired = 0
	A0_0._range = A0_0._projectile_spawner:base()._range
	A0_0._slot_mask = managers.slot:get_mask(A0_0._projectile_spawner:base()._slot_mask)
end
function BikerGatling.fire(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9
	L2_4 = MiniGun
	L2_4 = L2_4.fire
	L3_5 = A0_2
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._bullets_fired
	L2_4 = L2_4 + 1
	A0_2._bullets_fired = L2_4
	L2_4 = A0_2._wdata
	L2_4 = L2_4.aim_target_position
	L3_5 = A0_2._obj_fire
	L4_6 = L3_5
	L3_5 = L3_5.position
	L3_5 = L3_5(L4_6)
	L4_6 = L2_4 - L3_5
	L5_7 = L4_6
	L4_6 = L4_6.normalized
	L4_6 = L4_6(L5_7)
	L5_7 = VectorUtilities
	L5_7 = L5_7.angle_constraint_direction
	L6_8 = L4_6
	L7_9 = A0_2._obj_fire
	L7_9 = L7_9.rotation
	L7_9 = L7_9(L7_9)
	L7_9 = L7_9.y
	L7_9 = L7_9(L7_9)
	L5_7 = L5_7(L6_8, L7_9, A0_2._max_fire_object_and_aim_angle_diff)
	L4_6 = L5_7
	L5_7 = WeaponUtilities
	L5_7 = L5_7.dispersion
	L6_8 = L4_6
	L7_9 = A0_2._wdata
	L7_9 = L7_9.miss_dispersion
	L5_7 = L5_7(L6_8, L7_9, A0_2._wdata._dispersion)
	L6_8 = A0_2._tracer_effect
	if L6_8 then
		L6_8 = A0_2._bullets_fired
		L7_9 = A0_2._tracer_rate
		L6_8 = L6_8 % L7_9
		if L6_8 == 0 then
			L6_8 = Rotation
			L7_9 = L6_8
			L6_8 = L6_8.look_at
			L6_8 = L6_8(L7_9, L5_7, Vector3(0, 0, 1))
			L7_9 = A0_2._obj_fire
			L7_9 = L7_9.to_local
			L7_9 = L7_9(L7_9, L6_8)
			L7_9 = Rotation(L7_9:z(), L7_9:x(), L7_9:y())
			if A0_2._unit:raycast("ray", A0_2._obj_fire:position(), A0_2._obj_fire:position() + A0_2._obj_fire:rotation():y() * A0_2._range, "slot_mask", A0_2._slot_mask, "ignore_unit", A0_2._unit) then
			else
			end
			A0_2._bullet_tracers[World:effect_manager():spawn({
				effect = A0_2._tracer_effect,
				parent = A0_2._obj_fire,
				rotation = L7_9,
				force_synch = false
			})] = A1_3 + math.max(0, (A0_2._obj_fire:position() - (A0_2._obj_fire:position() + L7_9:z() * A0_2._range)):length() - A0_2._tracer_length) / A0_2._tracer_speed
		end
	end
	L6_8 = A0_2._bullet_damage
	if L6_8 then
		L6_8 = A0_2._projectile_spawner
		L7_9 = L6_8
		L6_8 = L6_8.base
		L6_8 = L6_8(L7_9)
		L6_8 = L6_8._damage
		L7_9 = A0_2._bullet_damage
		L6_8.soft = L7_9
	end
end
function BikerGatling.update(A0_10, A1_11, A2_12, A3_13)
	MiniGun.update(A0_10, A1_11, A2_12, A3_13)
	A0_10:update_bullet_tracers(A2_12, A3_13)
end
function BikerGatling.update_bullet_tracers(A0_14, A1_15, A2_16)
	local L3_17, L4_18, L5_19, L6_20, L7_21
	L3_17 = A2_16 * 3
	L3_17 = A1_15 + L3_17
	for L7_21, 