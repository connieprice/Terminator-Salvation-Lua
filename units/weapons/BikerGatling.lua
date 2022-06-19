require("projectile/InstantBulletSpawner")
require("shared/VectorUtilities")
if not BikerGatling then
	BikerGatling = class(MiniGun)
end
BikerGatling.init = function(l_1_0, l_1_1)
	MiniGun.init(l_1_0, l_1_1)
	l_1_0._bullet_tracers = {}
	l_1_0._bullets_fired = 0
	local l_1_2 = l_1_0._projectile_spawner:base()
	l_1_0._range = l_1_2._range
	l_1_0._slot_mask = managers.slot:get_mask(l_1_2._slot_mask)
end

BikerGatling.fire = function(l_2_0, l_2_1)
	MiniGun.fire(l_2_0, l_2_1)
	l_2_0._bullets_fired = l_2_0._bullets_fired + 1
	local l_2_2 = l_2_0._wdata.aim_target_position
	local l_2_3 = l_2_0._obj_fire:position()
	local l_2_4 = l_2_2 - l_2_3:normalized()
	l_2_4 = VectorUtilities.angle_constraint_direction(l_2_4, l_2_0._obj_fire:rotation():y(), l_2_0._max_fire_object_and_aim_angle_diff)
	local l_2_5 = WeaponUtilities.dispersion(l_2_4, l_2_0._wdata.miss_dispersion, l_2_0._wdata._dispersion)
	if l_2_0._tracer_effect and l_2_0._bullets_fired % l_2_0._tracer_rate == 0 then
		local l_2_6 = Rotation:look_at(l_2_5, Vector3(0, 0, 1))
		local l_2_7 = l_2_0._obj_fire:to_local(l_2_6)
		l_2_7 = Rotation(l_2_7:z(), l_2_7:x(), l_2_7:y())
		local l_2_8, l_2_9 = World:effect_manager():spawn, World:effect_manager()
		local l_2_10 = {}
		l_2_10.effect = l_2_0._tracer_effect
		l_2_10.parent = l_2_0._obj_fire
		l_2_10.rotation = l_2_7
		l_2_10.force_synch = false
		l_2_8 = l_2_8(l_2_9, l_2_10)
		l_2_9 = l_2_0._unit
		l_2_9, l_2_10 = l_2_9:raycast, l_2_9
		l_2_9 = (l_2_9(l_2_10, "ray", l_2_0._obj_fire:position(), l_2_0._obj_fire:position() + l_2_0._obj_fire:rotation():y() * l_2_0._range, "slot_mask", l_2_0._slot_mask, "ignore_unit", l_2_0._unit))
		l_2_10 = nil
		if l_2_9 then
			l_2_10 = l_2_9.position
		else
			l_2_10 = l_2_0._obj_fire:position() + l_2_7:z() * l_2_0._range
		end
		local l_2_11 = l_2_1 + math.max(0, l_2_0._obj_fire:position() - (l_2_10):length() - l_2_0._tracer_length) / l_2_0._tracer_speed
		l_2_0._bullet_tracers[l_2_8] = l_2_11
	end
	if l_2_0._bullet_damage then
		l_2_0._projectile_spawner:base()._damage.soft = l_2_0._bullet_damage
	end
end

BikerGatling.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	MiniGun.update(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0:update_bullet_tracers(l_3_2, l_3_3)
end

BikerGatling.update_bullet_tracers = function(l_4_0, l_4_1, l_4_2)
	local l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13 = nil
	local l_4_3 = l_4_1 + l_4_2 * 3
	for i_0,i_1 in pairs(l_4_0._bullet_tracers) do
		if i_1 < l_4_3 then
			World:effect_manager():kill(i_0)
			l_4_0._bullet_tracers[i_0] = nil
		end
	end
end

BikerGatling.destroy = function(l_5_0)
	MiniGun.destroy(l_5_0)
end

BikerGatling.set_bullet_damage = function(l_6_0, l_6_1)
	l_6_0._bullet_damage = l_6_1
end


