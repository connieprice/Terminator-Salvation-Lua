require("shared/FiniteStateMachine")
if not OverHeatBar then
	OverHeatBar = class()
end
OverHeatBar.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0._panel = l_1_1
	l_1_0._y = l_1_4
	l_1_0._x = l_1_3
	local l_1_7, l_1_8 = l_1_0._panel:bitmap, l_1_0._panel
	local l_1_9 = {}
	l_1_9.name = l_1_2
	l_1_9.texture = l_1_2
	l_1_7 = l_1_7(l_1_8, l_1_9)
	l_1_0._texture = l_1_7
	l_1_7 = l_1_0._texture
	l_1_7, l_1_8 = l_1_7:set_lefttop, l_1_7
	l_1_9 = l_1_3
	l_1_7(l_1_8, l_1_9, l_1_4)
	l_1_7 = Interpolator
	l_1_7, l_1_8 = l_1_7:new, l_1_7
	l_1_9 = 0
	l_1_7 = l_1_7(l_1_8, l_1_9, tweak_data.machine.hud.OVERHEAT_GROW_SPEED)
	l_1_0._height_interpolator = l_1_7
	if not l_1_6 then
		l_1_7 = l_1_0._texture
		l_1_7, l_1_8 = l_1_7:color, l_1_7
		l_1_7 = l_1_7(l_1_8)
	end
	l_1_0._color = l_1_7
	l_1_7 = l_1_0._color
	l_1_0._texture_color = l_1_7
	l_1_7 = l_1_5 or 1
	l_1_0._main_alpha = l_1_7
	l_1_7, l_1_8 = l_1_0:set_alpha, l_1_0
	l_1_9 = 0
	l_1_7(l_1_8, l_1_9)
end

OverHeatBar.set_image_height = function(l_2_0, l_2_1)
	l_2_0._image_height = l_2_1
end

OverHeatBar.set_texture_size = function(l_3_0, l_3_1)
	l_3_0._texture_size = l_3_1
end

OverHeatBar.set_image_width = function(l_4_0, l_4_1)
	l_4_0._texture_size = l_4_1
end

OverHeatBar.destroy = function(l_5_0)
	l_5_0._panel:remove(l_5_0._texture)
end

OverHeatBar.activate = function(l_6_0)
	l_6_0._height_interpolator:set_target(2)
	l_6_0._height_interpolator:set_speed(tweak_data.machine.hud.OVERHEAT_GROW_SPEED)
end

OverHeatBar.inactivate = function(l_7_0)
	l_7_0._height_interpolator:set_target(0.1)
	l_7_0._height_interpolator:set_speed(tweak_data.machine.hud.OVERHEAT_SHRINK_SPEED)
end

OverHeatBar.set_alpha = function(l_8_0, l_8_1)
	l_8_0._texture:set_color(l_8_0._texture_color:with_alpha(l_8_1 * l_8_0._main_alpha))
end

OverHeatBar.set_red_alpha = function(l_9_0, l_9_1)
	local l_9_2 = Color(1, 1 - l_9_1, 1 - l_9_1) * l_9_0._texture_color
	l_9_0._texture:set_color(l_9_2)
end

OverHeatBar.set_y_position = function(l_10_0, l_10_1)
	l_10_0._y = pos_y
	l_10_0._texture:set_lefttop(pos_x, pos_y)
end

OverHeatBar.update = function(l_11_0, l_11_1)
	if not l_11_0._height_interpolator:has_reached_target() then
		l_11_0._height_interpolator:update(l_11_1)
		local l_11_2 = l_11_0._height_interpolator:value()
		l_11_0:_resize_and_reposition(l_11_2)
	end
end

OverHeatBar._resize_and_reposition = function(l_12_0, l_12_1)
	local l_12_2 = l_12_0._texture_size * l_12_1
	l_12_0._texture:set_size(l_12_0._texture_size, l_12_2)
	l_12_0._texture:set_center_y(l_12_0._y)
end


