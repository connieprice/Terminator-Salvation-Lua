require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
if not Menu2DScroller then
	Menu2DScroller = class()
end
Menu2DScroller.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0._panel = l_1_1
	l_1_0._max_index = l_1_3
	l_1_0._first_visible_index = l_1_4
	l_1_0._fade_speed = l_1_6
	l_1_0._visible_slots = l_1_5
	l_1_0._max_invisible_slots = l_1_3 - l_1_5
	l_1_0._fade_animations = {}
	local l_1_7 = l_1_2:x() + l_1_2:width()
	l_1_0._up_arrow = l_1_0:_create_object("gui_menu_scroll_arrow", l_1_7)
	l_1_0._down_arrow = l_1_0:_create_object("gui_menu_scroll_arrow", l_1_7, 180)
	l_1_0._dot = l_1_0:_create_object("gui_menu_scroll_dot", l_1_7)
	local l_1_8 = l_1_0._up_arrow:texture_width()
	local l_1_9 = l_1_0._up_arrow:texture_height()
	l_1_0._down_arrow:set_y(l_1_0._panel:height() - l_1_9)
	l_1_0:_set_dot_y(l_1_0._up_arrow:y())
	l_1_0._dot_step = (l_1_0._panel:height() - l_1_9 * 3) / l_1_0._max_invisible_slots
	l_1_0._scroll_speed = tweak_data.menu2d.controller_pc.scroll_dot_speed
	local l_1_10, l_1_11 = l_1_1:rect, l_1_1
	local l_1_12 = {}
	l_1_12.x = l_1_0._dot:x()
	l_1_12.y = l_1_0._up_arrow:y() + l_1_9
	l_1_12.width = l_1_8
	l_1_12.height = l_1_0._down_arrow:y() - l_1_0._up_arrow:y() - l_1_9
	l_1_12.color = Color.white:with_alpha(0)
	l_1_10 = l_1_10(l_1_11, l_1_12)
	l_1_0._bar_rect = l_1_10
end

Menu2DScroller.resize_after_table = function(l_2_0, l_2_1)
	l_2_0._up_arrow:set_y(l_2_1.y)
	l_2_0._down_arrow:set_y(l_2_1.y + l_2_1.height)
	l_2_0:_set_dot_y(l_2_1.y)
	l_2_0._dot_step = (l_2_1.height - l_2_0._up_arrow:texture_height() * 3) / l_2_0._max_invisible_slots
	l_2_0._bar_rect:set_y(l_2_1.y)
	l_2_0._bar_rect:set_height(l_2_1.height)
end

Menu2DScroller.destroy = function(l_3_0)
	l_3_0._panel:remove(l_3_0._up_arrow)
	l_3_0._panel:remove(l_3_0._down_arrow)
	l_3_0._panel:remove(l_3_0._dot)
	l_3_0._panel:remove(l_3_0._bar_rect)
	l_3_0._dot = nil
end

Menu2DScroller._create_object = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_5, l_4_6 = l_4_3 or 0, l_4_0._panel:bitmap
	do
		local l_4_7 = l_4_0._panel
		l_4_6 = l_4_6(l_4_7, {x = l_4_2, y = 0, rotation = l_4_5, texture = l_4_1, blend_mode = "add", color = Color.white:with_alpha(0), layer = 10})
		l_4_7 = Menu2DFadeInAnimation
		 -- DECOMPILER ERROR: Overwrote pending register.

		table.insert(l_4_0._fade_animations, l_4_7)
		return l_4_6
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DScroller.get_first_visible_index = function(l_5_0)
	return l_5_0._first_visible_index
end

Menu2DScroller.input = function(l_6_0, l_6_1, l_6_2)
	if l_6_1.mouse and not l_6_0._wanted_y_position then
		local l_6_3 = l_6_1.mouse.cursor_position
		local l_6_4 = l_6_1.mouse.select
		if l_6_3 and l_6_4 then
			if Menu2DUtilities.is_position_over_gui_object(l_6_3, l_6_0._up_arrow) and l_6_0._first_visible_index ~= 1 then
				l_6_0:set_first_visible_index(l_6_0._first_visible_index - 1)
			end
		else
			if Menu2DUtilities.is_position_over_gui_object(l_6_3, l_6_0._down_arrow) and l_6_0._first_visible_index ~= l_6_0._max_index - l_6_0._visible_slots + 1 then
				l_6_0:set_first_visible_index(l_6_0._first_visible_index + 1)
			end
		else
			local l_6_5, l_6_6 = Menu2DUtilities.position_over_gui_object(l_6_3, l_6_0._bar_rect)
		if l_6_5 and l_6_6 then
			end
			local l_6_7 = l_6_6 * l_6_0._bar_rect:height()
			l_6_0:_set_dot_y(l_6_7, true)
		end
	else
		if l_6_1.mouse.wheel_down and l_6_0._first_visible_index ~= l_6_0._max_index - l_6_0._visible_slots + 1 then
			l_6_0:set_first_visible_index(l_6_0._first_visible_index + 1)
		end
	else
		if l_6_1.mouse.wheel_up and l_6_0._first_visible_index ~= 1 then
			l_6_0:set_first_visible_index(l_6_0._first_visible_index - 1)
		end
	end
end

Menu2DScroller._check_y = function(l_7_0, l_7_1)
	if l_7_0._bar_rect then
		local l_7_2 = l_7_0._bar_rect:height() - l_7_0._down_arrow:texture_height()
		if l_7_2 < l_7_1 then
			return l_7_2
		end
	end
	return l_7_1
end

Menu2DScroller._set_dot_y = function(l_8_0, l_8_1, l_8_2)
	l_8_0._dot:set_y(l_8_0:_check_y(l_8_1) + l_8_0._up_arrow:texture_height())
	if l_8_2 then
		local l_8_3 = math.fmod(l_8_1, l_8_0._dot_step)
		local l_8_4 = math.floor(l_8_1 / l_8_0._dot_step) + 1
		if l_8_0._dot_step * 0.5 < l_8_3 and l_8_4 <= l_8_0._max_invisible_slots then
			l_8_0._first_visible_index = l_8_4 + 1
		end
	else
		l_8_0._first_visible_index = l_8_4
	end
end

Menu2DScroller._current_dot_y = function(l_9_0)
	return l_9_0._dot:y() - l_9_0._up_arrow:texture_height()
end

Menu2DScroller.update = function(l_10_0, l_10_1)
	local l_10_7, l_10_8 = nil
	if l_10_0._dot and l_10_0._wanted_y_position then
		local l_10_2 = l_10_0:_current_dot_y() + l_10_1 * l_10_0._scroll_direction * l_10_0._scroll_speed
		if (l_10_2 < l_10_0._wanted_y_position and l_10_0._scroll_direction < 0) or l_10_0._wanted_y_position < l_10_2 and l_10_0._scroll_direction > 0 then
			l_10_2 = l_10_0._wanted_y_position
			l_10_0._wanted_y_position = nil
		end
		l_10_0:_set_dot_y(l_10_2)
	end
	if l_10_0._fade_animations then
		local l_10_3 = true
		for i_0,i_1 in pairs(l_10_0._fade_animations) do
			if i_1:update(l_10_1) ~= true then
				l_10_3 = false
			end
		end
	if l_10_3 == true then
		end
		l_10_0._fade_animations = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DScroller.set_first_visible_index = function(l_11_0, l_11_1)
	l_11_0._first_visible_index = l_11_1
	if l_11_1 == 0 then
		local l_11_2 = nil
	end
	local l_11_3 = l_11_0._first_visible_index - 1
	l_11_0._wanted_y_position = l_11_0._dot_step * l_11_3
	if l_11_0._wanted_y_position < l_11_0._dot:y() then
		l_11_0._scroll_direction = -1
	else
		l_11_0._scroll_direction = 1
	end
end


