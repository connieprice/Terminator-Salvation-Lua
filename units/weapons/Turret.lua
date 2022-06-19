if not Turret then
	Turret = class()
end
Turret.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._traverse = l_1_0._unit:get_object("at_traverse")
	l_1_0._elevation = l_1_0._unit:get_object("at_elevation")
	l_1_0._pintle = l_1_0._unit:get_object("at_pintle")
	l_1_0._unit:set_driving("animation")
	if not l_1_0._traverse then
		l_1_0._traverse = l_1_0._unit:orientation_object()
	end
	if l_1_0._fire_name == nil then
		l_1_0._fire = l_1_0._unit:get_object("at_elevation")
	else
		l_1_0._fire = l_1_0._unit:get_object(l_1_0._fire_name)
	end
	l_1_0._traverse_yaw = 0
	l_1_0._pitch = 0
	l_1_0._yaw = 0
end

Turret.set_vehicle = function(l_2_0, l_2_1)
	l_2_0._vehicle = l_2_1
end

Turret.get_vehicle = function(l_3_0)
	return l_3_0._vehicle
end

Turret.dead = function(l_4_0)
end

Turret.destroy = function(l_5_0)
	l_5_0._unit:set_slot(0)
	l_5_0._unit = nil
end

Turret.set_traverse_angle = function(l_6_0, l_6_1)
	l_6_0._traverse_yaw = l_6_1 - l_6_0._unit:rotation():roll()
	local l_6_2 = l_6_0._traverse:new_local_rotation()
	l_6_0._traverse:new_set_local_rotation(Rotation(l_6_2:yaw(), l_6_2:pitch(), l_6_0._traverse_yaw))
end

Turret.aim_at = function(l_7_0, l_7_1)
	local l_7_2 = l_7_0._traverse:rotation():inverse()
	local l_7_3 = l_7_0._traverse:position()
	l_7_3 = l_7_3:rotate_with(l_7_2)
	local l_7_4 = l_7_1:rotate_with(l_7_2)
	local l_7_5 = Rotation:look_at(l_7_3, l_7_4, math.UP)
	l_7_0._pintle:new_set_local_rotation(Rotation(0, 0, l_7_5:roll()))
	l_7_0._elevation:new_set_local_rotation(Rotation(l_7_5:yaw(), 0, 0))
	l_7_0._unit:set_moving()
end

Turret.set_aim_vec = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0._traverse:rotation():inverse()
	local l_8_3 = l_8_1:rotate_with(l_8_2)
	local l_8_4 = Rotation:look_at(l_8_3, math.UP)
	l_8_0._pintle:new_set_local_rotation(Rotation(0, 0, l_8_4:roll()))
	l_8_0._elevation:new_set_local_rotation(Rotation(l_8_4:yaw(), 0, 0))
	l_8_0._unit:set_moving()
end

Turret.draw_info = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = Draw:brush()
	l_9_4:set_screen(true)
	l_9_4:set_blend_mode("add")
	l_9_4:set_font("editor_font", 0.05)
	l_9_4:set_color(Color(0, 0, 1, 1))
	l_9_4:text(Vector3(l_9_1, l_9_2, 1), l_9_3)
end


