require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/ReticuleArrowStates")
if not ReticuleArrow then
	ReticuleArrow = class()
end
ReticuleArrow.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8)
	l_1_0.parent_panel = l_1_1
	l_1_0._size_modifier = l_1_8 or 1
	l_1_0._x = l_1_3
	l_1_0._y = l_1_4
	l_1_0._align_x = l_1_5
	l_1_0._align_y = l_1_6
	l_1_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	local l_1_10 = l_1_0.parent_panel:bitmap
	do
		local l_1_11 = l_1_0.parent_panel
		l_1_10 = l_1_10(l_1_11, {name = l_1_2, texture = l_1_2})
		l_1_0._arrow_texture = l_1_10
		l_1_10 = l_1_0._arrow_texture
		l_1_10, l_1_11 = l_1_10:set_size, l_1_10
		l_1_10(l_1_11, 64 * l_1_0._size_modifier, 64 * l_1_0._size_modifier)
		if l_1_7 then
			l_1_10 = l_1_0._arrow_texture
			l_1_10, l_1_11 = l_1_10:rotate, l_1_10
			l_1_10(l_1_11, l_1_7)
		end
		l_1_10 = l_1_0._align_x
		l_1_10, l_1_11 = l_1_10:find, l_1_10
		l_1_10 = l_1_10(l_1_11, "right")
		if l_1_10 then
			l_1_10 = l_1_0._arrow_texture
			l_1_10, l_1_11 = l_1_10:set_right, l_1_10
			l_1_10(l_1_11, l_1_0._x)
		else
			l_1_10 = l_1_0._align_x
			l_1_10, l_1_11 = l_1_10:find, l_1_10
			l_1_10 = l_1_10(l_1_11, "left")
			if l_1_10 then
				l_1_10 = l_1_0._arrow_texture
				l_1_10, l_1_11 = l_1_10:set_left, l_1_10
				l_1_10(l_1_11, l_1_0._x)
			end
		else
			l_1_10 = l_1_0._arrow_texture
			l_1_10, l_1_11 = l_1_10:set_center_x, l_1_10
			l_1_10(l_1_11, l_1_0._x)
		end
		l_1_10 = l_1_0._align_y
		l_1_10, l_1_11 = l_1_10:find, l_1_10
		l_1_10 = l_1_10(l_1_11, "top")
		if l_1_10 then
			l_1_10 = l_1_0._arrow_texture
			l_1_10, l_1_11 = l_1_10:set_top, l_1_10
			l_1_10(l_1_11, l_1_0._y)
		else
			l_1_10 = l_1_0._align_y
			l_1_10, l_1_11 = l_1_10:find, l_1_10
			l_1_10 = l_1_10(l_1_11, "bottom")
			if l_1_10 then
				l_1_10 = l_1_0._arrow_texture
				l_1_10, l_1_11 = l_1_10:set_bottom, l_1_10
				l_1_10(l_1_11, l_1_0._y)
			end
		else
			l_1_10 = l_1_0._arrow_texture
			l_1_10, l_1_11 = l_1_10:set_center_y, l_1_10
			l_1_10(l_1_11, l_1_0._y)
		end
		l_1_10 = FiniteStateMachine
		l_1_10, l_1_11 = l_1_10:new, l_1_10
		l_1_10 = l_1_10(l_1_11, l_1_0, "_reticule_arrow", ReticuleArrowIdleState)
		l_1_0._state = l_1_10
		l_1_10 = l_1_0._state
		l_1_10, l_1_11 = l_1_10:set_debug, l_1_10
		l_1_10(l_1_11, false)
		l_1_10 = l_1_0._arrow_texture
		l_1_10, l_1_11 = l_1_10:x, l_1_10
		l_1_10 = l_1_10(l_1_11)
		l_1_0._x = l_1_10
		l_1_10 = l_1_0._arrow_texture
		l_1_10, l_1_11 = l_1_10:y, l_1_10
		l_1_10 = l_1_10(l_1_11)
		l_1_0._y = l_1_10
		l_1_10 = l_1_0._x
		l_1_0._current_x = l_1_10
		l_1_10 = l_1_0._y
		l_1_0._current_y = l_1_10
		l_1_10, l_1_11 = l_1_0:set_alpha, l_1_0
		l_1_10(l_1_11, 0)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ReticuleArrow.set_move_in_end_position = function(l_2_0, l_2_1, l_2_2)
	l_2_0._move_in_end_position = {}
	l_2_0._move_in_end_position.x = l_2_0._arrow_texture:x() + l_2_1
	l_2_0._move_in_end_position.y = l_2_0._arrow_texture:y() + l_2_2
end

ReticuleArrow.get_move_in_end_position = function(l_3_0)
	if not l_3_0._move_in_end_position then
		return nil, nil
	end
	return l_3_0._move_in_end_position.x, l_3_0._move_in_end_position.y
end

ReticuleArrow.get_current_position = function(l_4_0)
	return l_4_0._arrow_texture:x(), l_4_0._arrow_texture:y()
end

ReticuleArrow.get_original_position = function(l_5_0)
	return l_5_0._x, l_5_0._y
end

ReticuleArrow.get_alpha = function(l_6_0)
	return l_6_0._alpha
end

ReticuleArrow.set_alpha = function(l_7_0, l_7_1)
	l_7_0._alpha = l_7_1
	l_7_0._arrow_texture:set_color(l_7_0._color:with_alpha(l_7_1 * tweak_data.machine.hud.MAIN_ALPHA))
end

ReticuleArrow.set_position = function(l_8_0, l_8_1, l_8_2)
	l_8_0._arrow_texture:set_x(l_8_1)
	l_8_0._arrow_texture:set_y(l_8_2)
	l_8_0._current_x = l_8_1
	l_8_0._current_y = l_8_2
end

ReticuleArrow.wants_to_move_in = function(l_9_0)
	return l_9_0._wants_to_move_in
end

ReticuleArrow.wants_to_move_out = function(l_10_0)
	return l_10_0._wants_to_move_out
end

ReticuleArrow.move_in = function(l_11_0)
	l_11_0._wants_to_move_in = true
	l_11_0._wants_to_move_out = false
end

ReticuleArrow.move_out = function(l_12_0)
	l_12_0._wants_to_move_in = false
	l_12_0._wants_to_move_out = true
end

ReticuleArrow.update = function(l_13_0, l_13_1, l_13_2)
	l_13_0._state:update(l_13_2)
end

ReticuleArrow.at_end_position = function(l_14_0)
	if math.abs(l_14_0._current_x - l_14_0._move_in_end_position.x) < 0.01 and math.abs(l_14_0._current_y - l_14_0._move_in_end_position.y) < 0.01 then
		return true
	end
	return false
end

ReticuleArrow.at_start_position = function(l_15_0)
	if math.abs(l_15_0._current_x - l_15_0._x) < 0.01 and math.abs(l_15_0._current_y - l_15_0._y) < 0.01 then
		return true
	end
	return false
end


