require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/ReticuleAngularArrowStates")
if not ReticuleAngularArrow then
	ReticuleAngularArrow = class()
end
ReticuleAngularArrow.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8)
	l_1_0.parent_panel = l_1_1
	l_1_0._size_modifier = l_1_8 or 1
	l_1_0._centre_x = l_1_3
	l_1_0._centre_y = l_1_4
	l_1_0._radius = l_1_5 * l_1_0._size_modifier
	l_1_0._angle = l_1_6
	l_1_0._end_angle = l_1_7
	l_1_0._current_angle = 0
	l_1_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	local l_1_10 = l_1_0.parent_panel:bitmap
	do
		local l_1_11 = l_1_0.parent_panel
		l_1_10 = l_1_10(l_1_11, {name = l_1_2, texture = l_1_2})
		l_1_0._arrow_texture = l_1_10
		l_1_10 = l_1_0._arrow_texture
		l_1_10, l_1_11 = l_1_10:set_size, l_1_10
		l_1_10(l_1_11, 32 * l_1_0._size_modifier, 32 * l_1_0._size_modifier)
		l_1_10 = FiniteStateMachine
		l_1_10, l_1_11 = l_1_10:new, l_1_10
		l_1_10 = l_1_10(l_1_11, l_1_0, "_reticule_angular_arrow", ReticuleAngularArrowIdleState)
		l_1_0._state = l_1_10
		l_1_10 = l_1_0._state
		l_1_10, l_1_11 = l_1_10:set_debug, l_1_10
		l_1_10(l_1_11, false)
		l_1_10, l_1_11 = l_1_0:set_angle, l_1_0
		l_1_10(l_1_11, l_1_6)
		l_1_10, l_1_11 = l_1_0:set_alpha, l_1_0
		l_1_10(l_1_11, 1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ReticuleAngularArrow.set_angle = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._centre_x + l_2_0._radius * math.cos(l_2_1 - 90)
	local l_2_3 = l_2_0._centre_y + l_2_0._radius * math.sin(l_2_1 - 90)
	l_2_0._current_angle = l_2_1
	l_2_0._arrow_texture:set_rotation(l_2_1)
	l_2_0:set_position(l_2_2, l_2_3)
end

ReticuleAngularArrow.set_position = function(l_3_0, l_3_1, l_3_2)
	l_3_0._arrow_texture:set_center_x(l_3_1)
	l_3_0._arrow_texture:set_center_y(l_3_2)
end

ReticuleAngularArrow.set_radius = function(l_4_0, l_4_1)
	l_4_0._radius = l_4_1 * l_4_0._size_modifier
	l_4_0:set_angle(l_4_0._current_angle)
end

ReticuleAngularArrow.set_alpha = function(l_5_0, l_5_1)
	l_5_0._alpha = l_5_1
	l_5_0._arrow_texture:set_color(l_5_0._color:with_alpha(l_5_1 * tweak_data.machine.hud.MAIN_ALPHA))
end

ReticuleAngularArrow.get_current_angle = function(l_6_0)
	return l_6_0._current_angle
end

ReticuleAngularArrow.get_end_angle = function(l_7_0)
	return l_7_0._end_angle
end

ReticuleAngularArrow.get_original_angle = function(l_8_0)
	return l_8_0._angle
end

ReticuleAngularArrow.wants_to_rotate_right = function(l_9_0)
	return l_9_0._wants_to_rotate_right
end

ReticuleAngularArrow.wants_to_rotate_left = function(l_10_0)
	return l_10_0._wants_to_rotate_left
end

ReticuleAngularArrow.rotate_right = function(l_11_0)
	l_11_0._wants_to_rotate_right = true
	l_11_0._wants_to_rotate_left = false
end

ReticuleAngularArrow.rotate_left = function(l_12_0)
	l_12_0._wants_to_rotate_right = false
	l_12_0._wants_to_rotate_left = true
end

ReticuleAngularArrow.update = function(l_13_0, l_13_1, l_13_2)
	l_13_0._state:update(l_13_2)
end

ReticuleAngularArrow.at_end_position = function(l_14_0)
	return math.abs(l_14_0._current_angle - l_14_0._end_angle) < 0.01
end

ReticuleAngularArrow.at_start_position = function(l_15_0)
	return math.abs(l_15_0._current_angle - l_15_0._angle) < 0.01
end


