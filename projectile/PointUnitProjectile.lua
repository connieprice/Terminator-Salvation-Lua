if not PointUnitProjectile then
	PointUnitProjectile = class()
end
PointUnitProjectile.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._detonation_time = 10
	l_1_0._explode_when_dead = true
	l_1_0._start_position = l_1_0._unit:position()
	l_1_0._keep_on_ground_time = 5
	if l_1_0._projectile_effect then
		local l_1_2, l_1_3 = World:effect_manager():spawn, World:effect_manager()
		local l_1_4 = {}
		l_1_4.effect = l_1_0._projectile_effect
		l_1_4.parent = l_1_0._unit:get_object("rp_empty")
		l_1_4.normal = Vector3(0, 1, 0)
		l_1_4.force_synch = true
		l_1_2 = l_1_2(l_1_3, l_1_4)
		l_1_0._projectile_effect_id = l_1_2
	end
end

PointUnitProjectile.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0._unit:move(l_2_0._unit:rotation():y() * (l_2_0._velocity * l_2_3))
	if l_2_0._previous_position and l_2_0._safety_distance <= l_2_0:distance_travelled() then
		local l_2_4 = l_2_0._unit:position()
		local l_2_5 = l_2_0._previous_position
		local l_2_6 = managers.slot:get_mask("solid_objects")
		local l_2_7 = l_2_0._unit:raycast("ray", l_2_5, l_2_4, "slot_mask", l_2_6, "ignore_unit", l_2_0._unit)
	if l_2_7 then
		end
		local l_2_8 = l_2_7.position + l_2_7.normal * 20
		l_2_0:hit(l_2_8, l_2_7.normal)
	end
	l_2_0._previous_position = l_2_0._unit:position()
	if Global.category_debug_render.projectile_trace then
		l_2_0:_draw_projectile_trace()
	end
end

PointUnitProjectile.hit = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = World:spawn_unit("explosion", l_3_1)
	if l_3_0._explosion_damage_at_center then
		l_3_3:explosion()._damage_at_center = l_3_0._explosion_damage_at_center
	end
	if l_3_0._explosion_radius then
		l_3_3:explosion()._radius = l_3_0._explosion_radius
	end
	local l_3_4, l_3_5 = World:effect_manager():spawn, World:effect_manager()
	local l_3_6 = {}
	l_3_6.effect = l_3_0._explosion_effect
	l_3_6.position = l_3_1
	l_3_6.normal = l_3_2
	l_3_4(l_3_5, l_3_6)
	l_3_4 = l_3_0._unit
	l_3_4, l_3_5 = l_3_4:set_slot, l_3_4
	l_3_6 = 0
	l_3_4(l_3_5, l_3_6)
	l_3_4 = World
	l_3_4, l_3_5 = l_3_4:effect_manager, l_3_4
	l_3_4 = l_3_4(l_3_5)
	l_3_4, l_3_5 = l_3_4:kill, l_3_4
	l_3_6 = l_3_0._projectile_effect_id
	l_3_4(l_3_5, l_3_6)
end

PointUnitProjectile._draw_projectile_trace = function(l_4_0)
	local l_4_1 = l_4_0._unit:position()
	if l_4_0._prev_pos then
		local l_4_2 = Draw:pen("one_second")
		l_4_2:set("green")
		l_4_2:line(l_4_0._prev_pos, l_4_1)
	end
	l_4_0._prev_pos = l_4_0._unit:position()
	local l_4_3 = Draw:brush()
	l_4_3:set_color(Color(1, 1, 0, 0), 1)
	l_4_3:sphere(l_4_0._unit:position(), 10)
	l_4_3 = Draw:pen("permanent")
	l_4_3:rotation(l_4_0._unit:get_object("rp_empty"):position(), l_4_0._unit:get_object("rp_empty"):rotation(), 100)
end

PointUnitProjectile.distance_travelled = function(l_5_0)
	local l_5_1 = l_5_0._unit:position()
	local l_5_2 = l_5_1 - l_5_0._start_position
	local l_5_3, l_5_4 = l_5_2:length, l_5_2
	return l_5_3(l_5_4)
end

PointUnitProjectile.destroy = function(l_6_0, l_6_1)
	l_6_0._unit:set_slot(0)
	World:effect_manager():kill(l_6_0._projectile_effect_id)
end


