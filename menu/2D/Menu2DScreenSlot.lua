require("menu/menu_animations/Menu2DPulseAnimation")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
require("menu/2D/Menu2DUtilities")
if not Menu2DScreenSlot then
	Menu2DScreenSlot = class()
end
Menu2DScreenSlot.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	l_1_0._root_panel = l_1_2
	l_1_0._widget_border = l_1_6
	local l_1_8, l_1_9 = l_1_2:panel, l_1_2
	local l_1_10 = {}
	l_1_10.x = 0
	l_1_10.y = l_1_4
	l_1_10.width = l_1_2:w()
	l_1_10.height = l_1_3
	l_1_8 = l_1_8(l_1_9, l_1_10)
	l_1_0._panel = l_1_8
	l_1_0._height = l_1_3
	l_1_0._root_panel = l_1_1
	l_1_8 = l_1_0._panel
	l_1_8, l_1_9 = l_1_8:text, l_1_8
	l_1_8, l_1_10 = l_1_8(l_1_9, l_1_10), {text = "", font = "faith_font_22", color = tweak_data.menu2d.normal_menu.choice_text_color:with_alpha(0), h = l_1_0._panel:h(), valign = "center", vertical = "center", align = "right", width = l_1_6, x = 0, layer = tweak_data.menu2d.layer_normal}
	l_1_0._text = l_1_8
	l_1_8, l_1_9 = l_1_7:selection_side, l_1_7
	l_1_8 = l_1_8(l_1_9)
	if l_1_8 == "left" then
		l_1_8, l_1_9 = l_1_1:bitmap, l_1_1
		l_1_8, l_1_10 = l_1_8(l_1_9, l_1_10), {texture = "gui_menu_bg_gradient", x = 0, y = l_1_0._text:world_y(), w = l_1_0._text:world_right() + tweak_data.menu2d.spacing_widget_border}
		l_1_0._selection_bar = l_1_8
		l_1_8 = l_1_0._text
		l_1_8, l_1_9 = l_1_8:world_center, l_1_8
		l_1_8 = l_1_8(l_1_9)
		l_1_10 = l_1_0._selection_bar
		l_1_10(l_1_10, R12_PC70)
	else
		l_1_8 = l_1_0._text
		l_1_8, l_1_9 = l_1_8:world_right, l_1_8
		l_1_8 = l_1_8(l_1_9)
		l_1_9 = tweak_data
		l_1_9 = l_1_9.menu2d
		l_1_9 = l_1_9.spacing_widget_border
		l_1_8 = l_1_8 + l_1_9
		l_1_9 = l_1_0._root_panel
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_9 = l_1_9:bitmap
		local l_1_11 = {}
		l_1_11.texture = "gui_resumegame_gradient"
		l_1_11.x = l_1_8
		R12_PC70 = l_1_0._panel
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_11.y = R12_PC70
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_11.w = R12_PC70
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_11.h = R12_PC70
		l_1_9 = l_1_9(l_1_10, l_1_11)
		l_1_0._selection_bar = l_1_9
	end
	l_1_8 = l_1_0._selection_bar
	l_1_8, l_1_9 = l_1_8:set_color, l_1_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_8(l_1_9, l_1_10)
	l_1_0._text_animation = nil
	l_1_0._selection_bar_animations, l_1_8 = l_1_8, {}
end

Menu2DScreenSlot.disable_selection_bar = function(l_2_0)
	l_2_0._selection_bar:parent():remove(l_2_0._selection_bar)
	l_2_0._selection_bar = nil
	l_2_0._selection_bar_animations = {}
end

Menu2DScreenSlot.destroy = function(l_3_0)
	l_3_0._selection_bar:parent():remove(l_3_0._selection_bar)
	l_3_0._panel:parent():remove(l_3_0._panel)
	if l_3_0._widget then
		l_3_0._widget:destroy()
	end
	l_3_0._text_animation = nil
	l_3_0._selection_bar_animations = nil
end

Menu2DScreenSlot.set = function(l_4_0, l_4_1)
	l_4_0._choice = l_4_1
	l_4_0._text:set_text(l_4_1:text())
	l_4_0._panel:show()
	l_4_0._widget = l_4_1:widget()
	l_4_1:open_code()
	if l_4_0._widget then
		if l_4_0._widget.height then
			l_4_0._panel:set_height(l_4_0._widget:height())
			if l_4_0._selection_bar then
				l_4_0._selection_bar:set_height(l_4_0._widget:height())
			end
			local l_4_2 = l_4_0._text:world_right() + tweak_data.menu2d.spacing_widget_border
			l_4_0._height = l_4_0._widget:height()
		end
		local l_4_3, l_4_4 = l_4_0._panel:panel, l_4_0._panel
		local l_4_5 = {}
		l_4_5.x = l_4_0._widget_border + 2 * tweak_data.menu2d.spacing_widget_border
		l_4_5.width = l_4_0._panel:width() - l_4_0._widget_border - 20
		l_4_3 = l_4_3(l_4_4, l_4_5)
		l_4_0._widget_panel = l_4_3
		l_4_3 = l_4_0._widget
		l_4_3, l_4_4 = l_4_3:show, l_4_3
		l_4_5 = l_4_0._root_panel
		l_4_3(l_4_4, l_4_5, l_4_0._widget_panel)
	end
	l_4_0:selection_changed(false, true)
end

Menu2DScreenSlot.update = function(l_5_0, l_5_1)
	local l_5_2 = true
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_5_0._text_animation and l_5_0._text_animation:update(l_5_1) == false then
		l_5_2 = false
	else
		l_5_0._text_animation = nil
	end
	if l_5_0._text_animation == nil and l_5_0._activate_pulse then
		l_5_0:_start_pulse()
	end
	if TableAlgorithms.is_empty(l_5_0._selection_bar_animations) == false then
		local l_5_3 = l_5_0._selection_bar_animations[1]:update(l_5_1)
		if l_5_3 == true then
			table.remove(l_5_0._selection_bar_animations, 1)
		end
	else
		l_5_2 = false
	end
	if l_5_0._widget then
		l_5_0._widget:update(l_5_1)
	end
	l_5_0._transition_done = l_5_2
	local l_5_4, l_5_5 = l_5_0._text:world_center()
	if l_5_0._selection_bar then
		l_5_0._selection_bar:set_world_center_y(l_5_5)
	end
end

Menu2DScreenSlot.stop_animation = function(l_6_0)
	l_6_0._text:stop()
end

Menu2DScreenSlot.hide = function(l_7_0, l_7_1)
	l_7_0._panel:hide()
end

Menu2DScreenSlot.show = function(l_8_0, l_8_1)
	l_8_0._panel:show()
end

Menu2DScreenSlot.animations_fade_completed = function(l_9_0)
	return l_9_0._transition_done
end

Menu2DScreenSlot.visible = function(l_10_0, l_10_1)
	local l_10_2, l_10_3 = l_10_0._panel:visible, l_10_0._panel
	return l_10_2(l_10_3)
end

Menu2DScreenSlot.height = function(l_11_0)
	return l_11_0._height
end

Menu2DScreenSlot.y = function(l_12_0)
	local l_12_1, l_12_2 = l_12_0._panel:y, l_12_0._panel
	return l_12_1(l_12_2)
end

Menu2DScreenSlot.widget_texture = function(l_13_0)
	local l_13_1, l_13_2 = l_13_0._widget:texture, l_13_0._widget
	return l_13_1(l_13_2)
end

Menu2DScreenSlot.text = function(l_14_0)
	return l_14_0._text
end

Menu2DScreenSlot.world_y = function(l_15_0)
	local l_15_1, l_15_2 = l_15_0._panel:world_y, l_15_0._panel
	return l_15_1(l_15_2)
end

Menu2DScreenSlot.bottom_y = function(l_16_0)
	return l_16_0._panel:y() + l_16_0._panel:h()
end

Menu2DScreenSlot.empty = function(l_17_0)
	local l_17_1, l_17_2 = l_17_0._choice:empty, l_17_0._choice
	return l_17_1(l_17_2)
end

Menu2DScreenSlot.choice = function(l_18_0)
	return l_18_0._choice
end

Menu2DScreenSlot._start_pulse = function(l_19_0)
	l_19_0._text:set_color(tweak_data.menu2d.normal_menu.choice_text_color_active)
	l_19_0._text_animation = Menu2DPulseAnimation:new(l_19_0._text, tweak_data.menu2d.animation.choice_pulse_speed, tweak_data.menu2d.animation.choice_pulse_low_alpha, tweak_data.menu2d.animation.choice_pulse_high_alpha, tweak_data.menu2d.animation.choice_pulse_wait)
	l_19_0._activate_pulse = nil
end

Menu2DScreenSlot.fast_fade_selection_bar = function(l_20_0)
	local l_20_1 = Menu2DFadeOutAnimation:new(l_20_0._selection_bar, 0, 0.01, 0)
	l_20_0._selection_bar_animations = {}
	table.insert(l_20_0._selection_bar_animations, l_20_1)
end

Menu2DScreenSlot.selection_changed = function(l_21_0, l_21_1, l_21_2, l_21_3)
	l_21_0._active = l_21_1
	l_21_0._activate_pulse = l_21_1
	if l_21_1 == true then
		l_21_0._choice:set_active(l_21_2)
		if l_21_0._selection_bar then
			local l_21_4 = Menu2DFadeInAnimation:new(l_21_0._selection_bar, 0, 0.25, 1)
			l_21_0._selection_bar_animations = {}
			table.insert(l_21_0._selection_bar_animations, l_21_4)
		end
	else
		l_21_0._choice:set_inactive(l_21_2)
		if l_21_0._selection_bar then
			l_21_0._selection_bar_animations = {}
			local l_21_5 = 0.25
			if l_21_3 then
				l_21_5 = 0.01
			end
			local l_21_6 = Menu2DFadeOutAnimation:new(l_21_0._selection_bar, 0, l_21_5, 0)
			table.insert(l_21_0._selection_bar_animations, l_21_6)
		end
		l_21_0._text:set_color(tweak_data.menu2d.normal_menu.choice_text_color)
		l_21_0._text_animation = Menu2DFadeOutAnimation:new(l_21_0._text, 0, 0.25, 1)
	end
	if l_21_0._widget then
		l_21_0._widget:selection_changed(l_21_1)
	end
end

Menu2DScreenSlot.destroy = function(l_22_0, l_22_1)
	l_22_0._root_panel:remove(l_22_0._panel)
end

Menu2DScreenSlot.transition = function(l_23_0, l_23_1, l_23_2)
	if l_23_1 == "fade_in" then
		l_23_0._text:set_color(tweak_data.menu2d.normal_menu.choice_text_color:with_alpha(0))
		l_23_0._text_animation = Menu2DFadeInAnimation:new(l_23_0._text, 0, 0.25, 1)
	end
	if l_23_1 == "fade_out" then
		if l_23_0._selection_bar then
			local l_23_3 = Menu2DFadeOutAnimation:new(l_23_0._selection_bar, 0, 0.25, 0)
			table.insert(l_23_0._selection_bar_animations, l_23_3)
		end
		l_23_0._text_animation = Menu2DFadeOutAnimation:new(l_23_0._text, 0, 0.25, 0)
		l_23_0._activate_pulse = nil
	end
	if l_23_0._widget then
		l_23_0._widget:animate(l_23_1, l_23_2)
	end
end

Menu2DScreenSlot.confirm_mode = function(l_24_0)
	if l_24_0._widget then
		local l_24_1, l_24_2 = l_24_0._widget:confirm_mode, l_24_0._widget
		return l_24_1(l_24_2)
	end
	if l_24_0._choice then
		return "confirm"
	end
	return nil
end

Menu2DScreenSlot.is_mouse_over_slot = function(l_25_0, l_25_1)
	local l_25_2 = Menu2DUtilities.is_position_over_gui_object
	local l_25_3 = l_25_1
	local l_25_4 = l_25_0._panel
	return l_25_2(l_25_3, l_25_4)
end

Menu2DScreenSlot.is_mouse_over_choice = function(l_26_0, l_26_1)
	if not l_26_0._selection_bar then
		local l_26_2, l_26_3 = l_26_0:is_mouse_over_slot, l_26_0
		local l_26_4 = l_26_1
		return l_26_2(l_26_3, l_26_4)
	end
	local l_26_5 = Menu2DUtilities.is_position_over_gui_object
	local l_26_6 = l_26_1
	local l_26_7 = l_26_0._selection_bar
	return l_26_5(l_26_6, l_26_7)
end

Menu2DScreenSlot.is_mouse_over_widget = function(l_27_0, l_27_1)
	if not l_27_0._widget_panel then
		return false
	end
	local l_27_2 = Menu2DUtilities.is_position_over_gui_object
	local l_27_3 = l_27_1
	local l_27_4 = l_27_0._widget_panel
	return l_27_2(l_27_3, l_27_4)
end

Menu2DScreenSlot.mouse_input = function(l_28_0, l_28_1)
	l_28_0._widget:mouse_input(l_28_1)
end


