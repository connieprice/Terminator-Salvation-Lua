require("menu/2D/widgets/Menu2DWidgetBase.lua")
if not Menu2DWidgetSpinControl then
	Menu2DWidgetSpinControl = class(Menu2DWidgetBase)
end
Menu2DWidgetSpinControl._bmp_inactive_alpha = 0.3
Menu2DWidgetSpinControl._text_inactive_alpha = 0.6
Menu2DWidgetSpinControl.init = function(l_1_0, l_1_1)
	Menu2DWidgetBase.init(l_1_0, l_1_1)
	l_1_0._choices = {}
	l_1_0._animation_time = 0.2
end

Menu2DWidgetSpinControl.parse = function(l_2_0, l_2_1)
end

Menu2DWidgetSpinControl.update = function(l_3_0, l_3_1)
	if l_3_0._left_arrow_animation and l_3_0._left_arrow_animation:update(l_3_1) then
		l_3_0._left_arrow_animation = nil
	end
	if l_3_0._right_arrow_animation and l_3_0._right_arrow_animation:update(l_3_1) then
		l_3_0._right_arrow_animation = nil
	end
	if l_3_0._text_animation and l_3_0._text_animation:update(l_3_1) then
		l_3_0._text_animation = nil
	end
end

Menu2DWidgetSpinControl.selected_choice = function(l_4_0)
	return l_4_0._selected_index
end

Menu2DWidgetSpinControl.set_selected_choice = function(l_5_0, l_5_1)
	l_5_0._selected_index = l_5_1
end

Menu2DWidgetSpinControl.add_choice = function(l_6_0, l_6_1)
	local l_6_2 = nil
	if l_6_1.ignore_localization ~= true then
		l_6_2 = managers.localization:text(l_6_1.text)
	else
		l_6_2 = l_6_1.text
	end
	table.insert(l_6_0._choices, l_6_2)
end

Menu2DWidgetSpinControl.clear = function(l_7_0)
	l_7_0._choices = {}
end

Menu2DWidgetSpinControl.create_gui = function(l_8_0)
	local l_8_1 = 80
	l_8_0._params.panel:set_width(l_8_0._params.panel:width() - l_8_1)
	local l_8_2 = l_8_0._params.panel:x()
	local l_8_3 = l_8_0._params.panel:x()
	local l_8_4 = l_8_0._params.panel:width()
	local l_8_5 = l_8_0._params.panel:height()
	local l_8_6, l_8_7 = l_8_0._params.panel:bitmap, l_8_0._params.panel
	local l_8_8 = {}
	l_8_8.x = 0
	l_8_8.texture = "gui_menu_scroll_arrow"
	l_8_8.rotation = 270
	l_8_8.layer = 3
	l_8_8.color = Color.white:with_alpha(0)
	l_8_6 = l_8_6(l_8_7, l_8_8)
	l_8_0._left_arrow = l_8_6
	l_8_6 = l_8_0._params
	l_8_6 = l_8_6.panel
	l_8_6, l_8_7 = l_8_6:bitmap, l_8_6
	l_8_6, l_8_8 = l_8_6(l_8_7, l_8_8), {x = l_8_4 - l_8_0._left_arrow:texture_width(), texture = "gui_menu_scroll_arrow", rotation = 90, layer = 3, color = Color.white:with_alpha(0)}
	l_8_0._right_arrow = l_8_6
	l_8_6 = l_8_0._selected_index
	if not l_8_6 then
		l_8_6 = 1
	end
	l_8_0._selected_index = l_8_6
	l_8_6 = l_8_0._params
	l_8_6 = l_8_6.panel
	l_8_6, l_8_7 = l_8_6:text, l_8_6
	l_8_6, l_8_8 = l_8_6(l_8_7, l_8_8), {text = l_8_0._choices[l_8_0._selected_index], color = Color.white:with_alpha(0), align = "center", valign = "center", font = "faith_font_22", font_scale = tweak_data.menu2d.controls.text_scale, x = 0, y = 0, layer = 3, wrap = true, word_wrap = true}
	l_8_0._text = l_8_6
	l_8_6 = l_8_0._text
	l_8_6, l_8_7 = l_8_6:world_center_y, l_8_6
	l_8_6 = l_8_6(l_8_7)
	l_8_7 = l_8_0._left_arrow
	l_8_7, l_8_8 = l_8_7:set_world_center_y, l_8_7
	l_8_7(l_8_8, l_8_6)
	l_8_7 = l_8_0._right_arrow
	l_8_7, l_8_8 = l_8_7:set_world_center_y, l_8_7
	l_8_7(l_8_8, l_8_6)
end

Menu2DWidgetSpinControl.set_active = function(l_9_0, l_9_1)
end

Menu2DWidgetSpinControl.set_inactive = function(l_10_0, l_10_1)
end

Menu2DWidgetSpinControl.destroy = function(l_11_0)
	l_11_0._params.panel:remove(l_11_0._left_arrow)
	l_11_0._params.panel:remove(l_11_0._right_arrow)
	l_11_0._params.panel:remove(l_11_0._text)
end

Menu2DWidgetSpinControl.animate = function(l_12_0, l_12_1, l_12_2)
	if l_12_1 == "fade_out" then
		l_12_0._left_arrow_animation = Menu2DFadeOutAnimation:new(l_12_0._left_arrow, 0, l_12_0._animation_time, 0)
		l_12_0._right_arrow_animation = Menu2DFadeOutAnimation:new(l_12_0._right_arrow, 0, l_12_0._animation_time, 0)
		l_12_0._text_animation = Menu2DFadeOutAnimation:new(l_12_0._text, 0, l_12_0._animation_time, 0)
	elseif l_12_1 == "fade_in" then
		l_12_0._left_arrow_animation = Menu2DFadeInAnimation:new(l_12_0._left_arrow, 0, l_12_0._animation_time, 1)
		l_12_0._right_arrow_animation = Menu2DFadeInAnimation:new(l_12_0._right_arrow, 0, l_12_0._animation_time, 1)
		l_12_0._text_animation = Menu2DFadeInAnimation:new(l_12_0._text, 0, l_12_0._animation_time, 1)
	end
end

Menu2DWidgetSpinControl.confirm_mode = function(l_13_0)
	return "confirm"
end

Menu2DWidgetSpinControl._set_new_index = function(l_14_0, l_14_1)
	if l_14_1 == 0 then
		l_14_1 = #l_14_0._choices
	else
		if l_14_1 == #l_14_0._choices + 1 then
			l_14_1 = 1
		end
	end
	l_14_0._selected_index = l_14_1
	l_14_0._text:set_text(l_14_0._choices[l_14_0._selected_index])
end

Menu2DWidgetSpinControl.input = function(l_15_0, l_15_1)
	local l_15_2 = nil
	if l_15_1.x > 0 then
		l_15_2 = l_15_0._selected_index + 1
	elseif l_15_1.x < 0 then
		l_15_2 = l_15_0._selected_index - 1
	end
	if l_15_2 then
		l_15_0:_set_new_index(l_15_2)
	end
end

Menu2DWidgetSpinControl.mouse_input = function(l_16_0, l_16_1)
	if l_16_1.cursor_position and l_16_1.select then
		local l_16_2 = nil
		if Menu2DUtilities.is_position_over_gui_object(l_16_1.cursor_position, l_16_0._left_arrow) then
			l_16_2 = l_16_0._selected_index - 1
		else
			if Menu2DUtilities.is_position_over_gui_object(l_16_1.cursor_position, l_16_0._right_arrow) then
				l_16_2 = l_16_0._selected_index + 1
			end
		end
	if l_16_2 then
		end
		l_16_0:_set_new_index(l_16_2)
	end
end


