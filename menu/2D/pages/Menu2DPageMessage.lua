require("menu/2D/Menu2DPage")
require("menu/menu_animations/Menu2DPulseAnimation")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
require("menu/2D/Menu2DUtilities")
if not Menu2DPageMessage then
	Menu2DPageMessage = class(Menu2DPage)
end
Menu2DPageMessage.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	Menu2DPage.init(l_1_0, l_1_1, l_1_2)
	l_1_0._show_saving_icon = toboolean(l_1_1:parameter("show_saving_icon"))
	l_1_0._confirm_code = l_1_1:parameter("confirm_code")
	l_1_0._abort_code = l_1_1:parameter("abort_code")
	l_1_0._auto_abort = tonumber(l_1_1:parameter("auto_abort"))
	l_1_0._message_text = tostring(l_1_1:parameter("text"))
	local l_1_7 = toboolean
	l_1_7 = l_1_7(l_1_1:parameter("disable_background"))
	l_1_0._disable_background = l_1_7
	l_1_0._choice_options, l_1_7 = l_1_7, {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_1_7 do
		local l_1_8 = {}
		l_1_8.text = l_1_6:parameter("text")
		l_1_8.callback_code = l_1_6:parameter("code")
		local l_1_9 = l_1_6:parameter("platform")
		if not l_1_9 or l_1_9 == SystemInfo:platform() then
			table.insert(l_1_0._choice_options, l_1_8)
		end
		local l_1_10 = toboolean(l_1_6:parameter("selected_option"))
		if l_1_10 and l_1_10 == true then
			l_1_0._default_selected_option_index = #l_1_0._choice_options
		end
	end
	l_1_0._single_option = false
	 -- DECOMPILER ERROR: Overwrote pending register.

	if #l_1_7 < 2 then
		l_1_0._single_option = true
	end
	l_1_0._fade_out_started = false
	l_1_0._option_animation = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageMessage.destroy = function(l_2_0)
	Menu2DPage.destroy(l_2_0)
	if l_2_0._background then
		l_2_0._full_screen_panel:remove(l_2_0._background)
		l_2_0._background = nil
	end
end

Menu2DPageMessage.set_transition = function(l_3_0)
	l_3_0:_fade_all()
end

Menu2DPageMessage._call = function(l_4_0, l_4_1)
	local l_4_2 = loadstring("return " .. l_4_1)
	l_4_2()
end

Menu2DPageMessage._fade_all = function(l_5_0)
	if not l_5_0._disable_background then
		l_5_0._background_animation = Menu2DFadeOutAnimation:new(l_5_0._background, 0, l_5_0._animation_speed, 0)
	end
	l_5_0._message_animation = Menu2DFadeOutAnimation:new(l_5_0._message, 0, l_5_0._animation_speed, 0)
	local l_5_4 = Menu2DFadeOutAnimation:new
	local l_5_5 = Menu2DFadeOutAnimation
	l_5_4 = l_5_4(l_5_5, l_5_0._line, 0, l_5_0._animation_speed, 0)
	l_5_0._line_animation = l_5_4
	l_5_4 = l_5_0._options
	if l_5_4 then
		l_5_4 = l_5_0._options
		l_5_4 = #l_5_4
	if l_5_4 > 0 then
		end
		l_5_4 = pairs
		l_5_5 = l_5_0._options
		l_5_4 = l_5_4(l_5_5)
		for i_0,i_1 in l_5_4 do
			l_5_3:stop()
			l_5_3:animate(Menu2DAnimations.fade_out, 0, l_5_0._animation_speed, 0)
		end
	if l_5_0._dot then
		end
		l_5_0._dot_animation = Menu2DFadeOutAnimation:new(l_5_0._dot, 0, l_5_0._animation_speed, 0)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_5_0._option_animation = nil
	if l_5_0._save_panel then
		l_5_0._save_panel:hide()
	end
	l_5_0._fade_out_started = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageMessage.transition_active = function(l_6_0)
	if l_6_0._all_fades_completed then
		return l_6_0._all_fades_completed
	end
end

Menu2DPageMessage.update = function(l_7_0, l_7_1)
	Menu2DPage.update(l_7_0, l_7_1)
	if l_7_0._auto_abort then
		l_7_0:_update_auto_abort(l_7_1)
	end
	if l_7_0._save_panel then
		l_7_0._save_panel:update(l_7_1)
	end
	if l_7_0._option_animation then
		l_7_0._option_animation:update(l_7_1)
	end
	local l_7_2 = true
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_7_0._background_animation and l_7_0._background_animation:update(l_7_1) == true then
		l_7_0._background_animation = nil
	else
		l_7_2 = false
	end
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_7_0._message_animation and l_7_0._message_animation:update(l_7_1) == true then
		l_7_0._message_animation = nil
	else
		l_7_2 = false
	end
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_7_0._line_animation and l_7_0._line_animation:update(l_7_1) == true then
		l_7_0._line_animation = nil
	else
		l_7_2 = false
	end
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_7_0._dot_animation and l_7_0._dot_animation:update(l_7_1) == true then
		l_7_0._dot_animation = nil
	else
		l_7_2 = false
	end
	if l_7_0._fade_out_started then
		l_7_0._all_fades_completed = not l_7_2
	end
end

Menu2DPageMessage.input = function(l_8_0, l_8_1)
	if l_8_1.back and l_8_0._abort_code then
		l_8_0:_call(l_8_0._abort_code)
		return 
	end
	if l_8_0._single_option == false then
		l_8_0:_update_keyboard_movement(l_8_1)
		l_8_0:_update_mouse_movement(l_8_1.mouse)
	end
	if l_8_1.select or not l_8_1.mouse.cursor_position or not l_8_1.mouse.select or l_8_0:_find_mouse_over_option(l_8_1.mouse.cursor_position) ~= nil then
		local l_8_5 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_8_0._selected_option_index then
			managers.menu2d:sound():play("menu_select")
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if nil then
				l_8_0:_call(nil)
			end
		elseif l_8_0._confirm_code then
			l_8_0:_call(l_8_0._confirm_code)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 49 
end

Menu2DPageMessage._update_keyboard_movement = function(l_9_0, l_9_1)
	local l_9_2 = nil
	if l_9_1.move_axis:length() and l_9_1.move_axis:length() > 0.2 then
		if l_9_0._move_axis_at_rest or l_9_0._is_repeating_move and l_9_0._time_since_move > 0.1 then
			l_9_2 = l_9_1.move_axis:normalized()
			l_9_0._time_since_move = 0
		elseif l_9_0._time_since_move and l_9_0._time_since_move > 0.3 then
			l_9_2 = l_9_1.move_axis:normalized()
			l_9_0._time_since_move = 0
			l_9_0._is_repeating_move = true
		end
		l_9_0._move_axis_at_rest = false
	else
		l_9_0._move_axis_at_rest = true
		l_9_0._is_repeating_move = false
	end
	if l_9_2 and l_9_2:length() > 0.3 then
		managers.menu2d:sound():play("menu_move")
		if l_9_2.x < 0 and l_9_0._selected_option_index > 1 then
			l_9_0:_set_selected_option(l_9_0._selected_option_index - 1)
		end
	elseif l_9_2.x > 0 and l_9_0._selected_option_index < #l_9_0._choice_options then
		l_9_0:_set_selected_option(l_9_0._selected_option_index + 1)
	end
end

Menu2DPageMessage._update_mouse_movement = function(l_10_0, l_10_1)
	local l_10_2 = l_10_1.cursor_position
	if l_10_2 then
		local l_10_3 = l_10_0:_find_mouse_over_option(l_10_2)
	if l_10_3 then
		end
	if l_10_3 ~= l_10_0._selected_option_index then
		end
		l_10_0:_set_selected_option(l_10_3)
	end
end

Menu2DPageMessage._find_mouse_over_option = function(l_11_0, l_11_1)
	local l_11_5, l_11_6, l_11_7, l_11_8 = nil
	for i_0,i_1 in pairs(l_11_0._options) do
		local l_11_11, l_11_12 = i_1:text_rect()
		if Menu2DUtilities.is_position_over_rect(l_11_1, l_11_11, l_11_12, R15_PC13, R16_PC13) then
			return l_11_9
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageMessage._set_selected_option = function(l_12_0, l_12_1, l_12_2)
	if l_12_0._selected_option_index and l_12_0._selected_option_index ~= l_12_1 then
		l_12_0._options[l_12_0._selected_option_index]:stop()
		l_12_0._options[l_12_0._selected_option_index]:animate(Menu2DAnimations.fade_out, 0, l_12_0._selection_change_speed, l_12_0._selection_inactive_alpha)
	end
	l_12_0._option_animation = Menu2DPulseAnimation:new(l_12_0._options[l_12_1], l_12_0._pulse_speed, l_12_0._selection_inactive_alpha, 1, l_12_0._pulse_wait_at_end)
	l_12_0._selected_option_index = l_12_1
	if l_12_0._dot and l_12_2 == nil then
		l_12_0:_change_dot_position()
	end
end

Menu2DPageMessage.open = function(l_13_0, l_13_1, l_13_2, l_13_3, l_13_4, l_13_5)
	l_13_0._selected_option_index = l_13_0._default_selected_option_index
	Menu2DPage.open(l_13_0, l_13_1, l_13_2, l_13_3)
	if l_13_0._auto_abort then
		l_13_0._abort_timer = l_13_0._auto_abort
	end
	l_13_0._animation_speed = 0.4
	l_13_0._selection_change_speed = 0.1
	l_13_0._selection_inactive_alpha = 0.4
	l_13_0._pulse_wait_at_end = 0.1
	l_13_0._pulse_speed = 0.4
	l_13_0._spacing = 30
	l_13_0._width_multiplier = 0.7
	local l_13_6 = {}
	l_13_6.x = l_13_0._panel:width() * ((1 - l_13_0._width_multiplier) / 2)
	l_13_6.y = l_13_0._panel:height() * 0.4
	l_13_0._text_start = l_13_6
	l_13_6 = managers
	l_13_6 = l_13_6.menu
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_13_0._full_screen_panel = l_13_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_13_6 then
		local l_13_7 = l_13_6
		local l_13_8 = {}
		l_13_8.color = Color.black:with_alpha(0)
		l_13_8.layer = 1
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_13_0._background = l_13_6
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_13_7 = l_13_6
		l_13_8 = l_13_0._background
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_13_0._background_animation = l_13_6
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_13_9 = l_13_6
	do
		 -- DECOMPILER ERROR: Overwrote pending register.

		if not l_13_5 then
			l_13_9(l_13_0, l_13_6)
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_13_9(l_13_0)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_13_9 > 0 then
				l_13_9(l_13_0)
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_13_9(l_13_0)
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_13_9 then
				l_13_9(l_13_0)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 73 
end

Menu2DPageMessage.close = function(l_14_0, ...)
	Menu2DPage.close(l_14_0, ...)
end

Menu2DPageMessage._add_dot = function(l_15_0)
	local l_15_1, l_15_2 = l_15_0._options_panel:bitmap, l_15_0._options_panel
	local l_15_3 = {}
	l_15_3.name = "dot"
	l_15_3.texture = "gui_hud_selection_dot"
	l_15_3.align = "center"
	l_15_1 = l_15_1(l_15_2, l_15_3)
	l_15_0._dot = l_15_1
	l_15_1 = l_15_0._dot
	l_15_1, l_15_2 = l_15_1:width, l_15_1
	l_15_1 = l_15_1(l_15_2)
	l_15_1 = l_15_1 * 0.5
	l_15_0._dot_size = l_15_1
	l_15_1 = Menu2DFadeInAnimation
	l_15_1, l_15_2 = l_15_1:new, l_15_1
	l_15_3 = l_15_0._dot
	l_15_1 = l_15_1(l_15_2, l_15_3, 0, l_15_0._animation_speed, 1)
	l_15_0._dot_animation = l_15_1
	l_15_1, l_15_2 = l_15_0:_change_dot_position, l_15_0
	l_15_1(l_15_2)
end

Menu2DPageMessage._change_dot_position = function(l_16_0)
	local l_16_1 = l_16_0._options[l_16_0._selected_option_index]
	local l_16_2, l_16_3, l_16_4, l_16_5 = l_16_1:text_rect()
	local l_16_8 = l_16_1:x() + l_16_4 * 0.5 - l_16_0._dot_size
	if l_16_0._last_option_index ~= l_16_0._selected_option_index then
		local l_16_6, l_16_7 = l_16_3 - l_16_5 - 10
	end
	l_16_0._dot:set_x(l_16_8)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_16_0._dot:set_y(l_16_6)
	l_16_0._dot:set_align("left")
end

Menu2DPageMessage._add_options = function(l_17_0)
	local l_17_5, l_17_6, l_17_7, l_17_8, l_17_9, l_17_10 = nil
	l_17_0._options = {}
	local l_17_1 = 0
	local l_17_2, l_17_3 = l_17_0._panel:panel, l_17_0._panel
	local l_17_4 = {}
	l_17_4.layer = 1
	l_17_2 = l_17_2(l_17_3, l_17_4)
	l_17_0._options_panel = l_17_2
	l_17_2 = l_17_0._options_panel
	l_17_2, l_17_3 = l_17_2:set_width, l_17_2
	l_17_4 = 0
	l_17_2(l_17_3, l_17_4)
	l_17_2 = ipairs
	l_17_3 = l_17_0._choice_options
	l_17_2 = l_17_2(l_17_3)
	for i_0,i_1 in l_17_2 do
		local l_17_13 = nil
		local l_17_14 = l_17_0:_create_text
		local l_17_15 = l_17_0
		local l_17_16 = l_17_12.text
		l_17_14 = l_17_14(l_17_15, l_17_16, l_17_11, l_17_1, l_17_11 == #l_17_0._choice_options)
		l_17_1 = 
		l_17_13 = l_17_14
		l_17_14 = table
		l_17_14 = l_17_14.insert
		l_17_15 = l_17_0._options
		l_17_16 = l_17_13
		l_17_14(l_17_15, l_17_16)
		l_17_14, l_17_15 = l_17_13:animate, l_17_13
		l_17_16 = Menu2DAnimations
		l_17_16 = l_17_16.fade_in
		l_17_14(l_17_15, l_17_16, 0, l_17_0._animation_speed, l_17_0._selection_inactive_alpha)
	end
	l_17_0._options_panel:set_x(l_17_0._panel:width() / 2 - l_17_0._options_panel:width() / 2)
	l_17_0:_set_selected_option(l_17_0._selected_option_index, true)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageMessage._create_text = function(l_18_0, l_18_1, l_18_2, l_18_3, l_18_4)
	if l_18_4 == false then
		local l_18_5, l_18_6 = managers.localization:text(l_18_1) .. "  "
	else
		l_18_0._last_option_index = l_18_2
	end
	local l_18_7, l_18_8 = managers.localization:text(l_18_1), l_18_0._options_panel:text
	local l_18_9 = l_18_0._options_panel
	l_18_8 = l_18_8(l_18_9, {text = l_18_7, x = l_18_3, y = 0, width = l_18_0._panel:width(), align = "left", vertical = "center", font = "faith_font_22", color = Color.white:with_alpha(0), layer = 2, wrap = true, word_wrap = true})
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_18_10, l_18_11 = nil
	if l_18_0._panel:width() < l_18_3 + l_18_11 then
		l_18_3 = l_18_11
		l_18_8:set_x(l_18_3)
	else
		l_18_3 = l_18_3 + l_18_11
	end
	if l_18_0._options_panel:width() < l_18_3 + l_18_11 then
		l_18_0._options_panel:set_width(l_18_0._options_panel:width() + l_18_11)
	end
	return l_18_8, l_18_3
end

Menu2DPageMessage._add_save_icon = function(l_19_0)
	l_19_0._save_panel = IoIconPanel:new(l_19_0._panel, "gui_saving_icon", tweak_data.player.new_hud.io_icon_panel.SAVE_SPIN_SPEED)
	local l_19_1 = l_19_0._panel:width() / 2 - l_19_0._save_panel:icon_width() / 2
	local l_19_2 = l_19_0._line:bottom() + l_19_0._spacing * 0.5
	local l_19_3, l_19_4 = l_19_0._save_panel:panel():configure, l_19_0._save_panel:panel()
	local l_19_5 = {}
	l_19_5.x = l_19_1
	l_19_5.y = l_19_2
	l_19_3(l_19_4, l_19_5)
	l_19_3 = l_19_0._save_panel
	l_19_3, l_19_4 = l_19_3:show, l_19_3
	l_19_3(l_19_4)
end

Menu2DPageMessage._add_message = function(l_20_0, l_20_1)
	local l_20_2 = l_20_0._text_start.x
	local l_20_3 = l_20_0._text_start.y
	local l_20_4, l_20_5 = l_20_0._panel:text, l_20_0._panel
	local l_20_6 = {}
	l_20_6.x = l_20_2
	l_20_6.y = l_20_3
	l_20_6.width = l_20_0._panel:width() * l_20_0._width_multiplier
	l_20_6.align = "center"
	l_20_6.vertical = "bottom"
	l_20_6.font = "faith_font_22"
	l_20_6.color = Color.white:with_alpha(0)
	l_20_6.layer = 2
	l_20_6.wrap = true
	l_20_6.word_wrap = true
	l_20_6.text = l_20_1
	l_20_4 = l_20_4(l_20_5, l_20_6)
	l_20_0._message = l_20_4
	l_20_4 = l_20_0._message
	l_20_4, l_20_5 = l_20_4:set_bottom, l_20_4
	l_20_6 = l_20_3
	l_20_4(l_20_5, l_20_6)
	l_20_4 = Menu2DFadeInAnimation
	l_20_4, l_20_5 = l_20_4:new, l_20_4
	l_20_6 = l_20_0._message
	l_20_4 = l_20_4(l_20_5, l_20_6, 0, l_20_0._animation_speed, 1)
	l_20_0._message_animation = l_20_4
end

Menu2DPageMessage._add_line = function(l_21_0)
	local l_21_1, l_21_2 = l_21_0._panel:rect, l_21_0._panel
	local l_21_3 = {}
	l_21_3.x = l_21_0._panel:width() * (1 - l_21_0._width_multiplier) / 2
	l_21_3.y = l_21_0._message:bottom() + l_21_0._spacing
	l_21_3.width = l_21_0._panel:width() * l_21_0._width_multiplier
	l_21_3.height = 1
	l_21_3.color = Color.white:with_alpha(0)
	l_21_3.layer = 2
	l_21_1 = l_21_1(l_21_2, l_21_3)
	l_21_0._line = l_21_1
	l_21_1 = l_21_0._line
	l_21_1, l_21_2 = l_21_1:set_bottom, l_21_1
	l_21_3 = l_21_0._message
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_21_1(l_21_2, l_21_3)
	l_21_1 = Menu2DFadeInAnimation
	l_21_1, l_21_2 = l_21_1:new, l_21_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_21_1 = l_21_1(l_21_2, l_21_3, 0, l_21_0._animation_speed, 0.5)
	l_21_0._line_animation = l_21_1
	l_21_1 = l_21_0._choice_options
	l_21_1 = #l_21_1
	if l_21_1 == 0 then
		l_21_1 = l_21_0._show_saving_icon
	if not l_21_1 then
		end
		l_21_1 = l_21_0._line
		l_21_1, l_21_2 = l_21_1:hide, l_21_1
		l_21_1(l_21_2)
	end
end

Menu2DPageMessage._set_message = function(l_22_0, l_22_1, l_22_2)
	local l_22_3, l_22_4 = managers.localization:text, managers.localization
	do
		if not l_22_2 then
			l_22_3 = l_22_3(l_22_4, l_22_0._message_text, l_22_1)
			l_22_4 = l_22_0._message
			l_22_4(l_22_4, l_22_3)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 7 
end

Menu2DPageMessage.can_go_back = function(l_23_0)
	return l_23_0._abort_code ~= nil
end

Menu2DPageMessage._update_auto_abort = function(l_24_0, l_24_1)
	local l_24_2 = {}
	l_24_2.ABORT_TIMER = math.max(math.ceil(l_24_0._abort_timer), 0)
	if l_24_0._abort_timer > 0 then
		l_24_0._abort_timer = l_24_0._abort_timer - l_24_1
	else
		local l_24_3 = {}
		l_24_3.ABORT_TIMER = 0
		l_24_2 = l_24_3
		l_24_3(l_24_0, l_24_0._abort_code)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_24_3(l_24_0, l_24_2)
end


