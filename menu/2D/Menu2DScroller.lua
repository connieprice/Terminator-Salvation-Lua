require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
Menu2DScroller = Menu2DScroller or class()
function Menu2DScroller.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	local L7_7
	A0_0._panel = A1_1
	A0_0._max_index = A3_3
	A0_0._first_visible_index = A4_4
	A0_0._fade_speed = A6_6
	A0_0._visible_slots = A5_5
	L7_7 = A3_3 - A5_5
	A0_0._max_invisible_slots = L7_7
	L7_7 = {}
	A0_0._fade_animations = L7_7
	L7_7 = A2_2.x
	L7_7 = L7_7(A2_2)
	L7_7 = L7_7 + A2_2:width()
	A0_0._up_arrow = A0_0:_create_object("gui_menu_scroll_arrow", L7_7)
	A0_0._down_arrow = A0_0:_create_object("gui_menu_scroll_arrow", L7_7, 180)
	A0_0._dot = A0_0:_create_object("gui_menu_scroll_dot", L7_7)
	A0_0._down_arrow:set_y(A0_0._panel:height() - A0_0._up_arrow:texture_height())
	A0_0:_set_dot_y(A0_0._up_arrow:y())
	A0_0._dot_step = (A0_0._panel:height() - A0_0._up_arrow:texture_height() * 3) / A0_0._max_invisible_slots
	A0_0._scroll_speed = tweak_data.menu2d.controller_pc.scroll_dot_speed
	A0_0._bar_rect = A1_1:rect({
		x = A0_0._dot:x(),
		y = A0_0._up_arrow:y() + A0_0._up_arrow:texture_height(),
		width = A0_0._up_arrow:texture_width(),
		height = A0_0._down_arrow:y() - A0_0._up_arrow:y() - A0_0._up_arrow:texture_height(),
		color = Color.white:with_alpha(0)
	})
end
function Menu2DScroller.resize_after_table(A0_8, A1_9)
	A0_8._up_arrow:set_y(A1_9.y)
	A0_8._down_arrow:set_y(A1_9.y + A1_9.height)
	A0_8:_set_dot_y(A1_9.y)
	A0_8._dot_step = (A1_9.height - A0_8._up_arrow:texture_height() * 3) / A0_8._max_invisible_slots
	A0_8._bar_rect:set_y(A1_9.y)
	A0_8._bar_rect:set_height(A1_9.height)
end
function Menu2DScroller.destroy(A0_10)
	A0_10._panel:remove(A0_10._up_arrow)
	A0_10._panel:remove(A0_10._down_arrow)
	A0_10._panel:remove(A0_10._dot)
	A0_10._panel:remove(A0_10._bar_rect)
	A0_10._dot = nil
end
function Menu2DScroller._create_object(A0_11, A1_12, A2_13, A3_14)
	local L4_15, L5_16, L6_17
	L4_15 = A3_14 or 0
	L5_16 = A0_11._panel
	L6_17 = L5_16
	L5_16 = L5_16.bitmap
	L5_16 = L5_16(L6_17, {
		x = A2_13,
		y = 0,
		rotation = L4_15,
		texture = A1_12,
		blend_mode = "add",
		color = Color.white:with_alpha(0),
		layer = 10
	})
	L6_17 = Menu2DFadeInAnimation
	L6_17 = L6_17.new
	L6_17 = L6_17(L6_17, L5_16, 0, A0_11._fade_speed, 1)
	table.insert(A0_11._fade_animations, L6_17)
	return L5_16
end
function Menu2DScroller.get_first_visible_index(A0_18)
	local L1_19
	L1_19 = A0_18._first_visible_index
	return L1_19
end
function Menu2DScroller.input(A0_20, A1_21, A2_22)
	local L3_23, L4_24, L5_25, L6_26, L7_27
	L3_23 = A1_21.mouse
	if L3_23 then
		L3_23 = A0_20._wanted_y_position
		if not L3_23 then
			L3_23 = A1_21.mouse
			L3_23 = L3_23.cursor_position
			L4_24 = A1_21.mouse
			L4_24 = L4_24.select
			if L3_23 and L4_24 then
				L5_25 = Menu2DUtilities
				L5_25 = L5_25.is_position_over_gui_object
				L6_26 = L3_23
				L7_27 = A0_20._up_arrow
				L5_25 = L5_25(L6_26, L7_27)
				if L5_25 then
					L5_25 = A0_20._first_visible_index
					if L5_25 ~= 1 then
						L6_26 = A0_20
						L5_25 = A0_20.set_first_visible_index
						L7_27 = A0_20._first_visible_index
						L7_27 = L7_27 - 1
						L5_25(L6_26, L7_27)
					end
				else
					L5_25 = Menu2DUtilities
					L5_25 = L5_25.is_position_over_gui_object
					L6_26 = L3_23
					L7_27 = A0_20._down_arrow
					L5_25 = L5_25(L6_26, L7_27)
					if L5_25 then
						L5_25 = A0_20._first_visible_index
						L6_26 = A0_20._max_index
						L7_27 = A0_20._visible_slots
						L6_26 = L6_26 - L7_27
						L6_26 = L6_26 + 1
						if L5_25 ~= L6_26 then
							L6_26 = A0_20
							L5_25 = A0_20.set_first_visible_index
							L7_27 = A0_20._first_visible_index
							L7_27 = L7_27 + 1
							L5_25(L6_26, L7_27)
						end
					else
						L5_25 = Menu2DUtilities
						L5_25 = L5_25.position_over_gui_object
						L6_26 = L3_23
						L7_27 = A0_20._bar_rect
						L6_26 = L5_25(L6_26, L7_27)
						if L5_25 and L6_26 then
							L7_27 = A0_20._bar_rect
							L7_27 = L7_27.height
							L7_27 = L7_27(L7_27)
							L7_27 = L6_26 * L7_27
							A0_20:_set_dot_y(L7_27, true)
						end
					end
				end
			else
				L5_25 = A1_21.mouse
				L5_25 = L5_25.wheel_down
				if L5_25 then
					L5_25 = A0_20._first_visible_index
					L6_26 = A0_20._max_index
					L7_27 = A0_20._visible_slots
					L6_26 = L6_26 - L7_27
					L6_26 = L6_26 + 1
					if L5_25 ~= L6_26 then
						L6_26 = A0_20
						L5_25 = A0_20.set_first_visible_index
						L7_27 = A0_20._first_visible_index
						L7_27 = L7_27 + 1
						L5_25(L6_26, L7_27)
					end
				else
					L5_25 = A1_21.mouse
					L5_25 = L5_25.wheel_up
					if L5_25 then
						L5_25 = A0_20._first_visible_index
						if L5_25 ~= 1 then
							L6_26 = A0_20
							L5_25 = A0_20.set_first_visible_index
							L7_27 = A0_20._first_visible_index
							L7_27 = L7_27 - 1
							L5_25(L6_26, L7_27)
						end
					end
				end
			end
		end
	end
end
function Menu2DScroller._check_y(A0_28, A1_29)
	if A0_28._bar_rect and A1_29 > A0_28._bar_rect:height() - A0_28._down_arrow:texture_height() then
		return A0_28._bar_rect:height() - A0_28._down_arrow:texture_height()
	end
	return A1_29
end
function Menu2DScroller._set_dot_y(A0_30, A1_31, A2_32)
	A0_30._dot:set_y(A0_30:_check_y(A1_31) + A0_30._up_arrow:texture_height())
	if A2_32 then
		if math.fmod(A1_31, A0_30._dot_step) > A0_30._dot_step * 0.5 and math.floor(A1_31 / A0_30._dot_step) + 1 <= A0_30._max_invisible_slots then
			A0_30._first_visible_index = math.floor(A1_31 / A0_30._dot_step) + 1 + 1
		else
			A0_30._first_visible_index = math.floor(A1_31 / A0_30._dot_step) + 1
		end
	end
end
function Menu2DScroller._current_dot_y(A0_33)
	return A0_33._dot:y() - A0_33._up_arrow:texture_height()
end
function Menu2DScroller.update(A0_34, A1_35)
	local L2_36
	L2_36 = A0_34._dot
	if L2_36 then
		L2_36 = A0_34._wanted_y_position
		if L2_36 then
			L2_36 = A0_34._current_dot_y
			L2_36 = L2_36(A0_34)
			L2_36 = L2_36 + A1_35 * A0_34._scroll_direction * A0_34._scroll_speed
			if L2_36 < A0_34._wanted_y_position and A0_34._scroll_direction < 0 or L2_36 > A0_34._wanted_y_position and A0_34._scroll_direction > 0 then
				L2_36 = A0_34._wanted_y_position
				A0_34._wanted_y_position = nil
			end
			A0_34:_set_dot_y(L2_36)
		end
	end
	L2_36 = A0_34._fade_animations
	if L2_36 then
		L2_36 = true
		for 