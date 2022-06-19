require("menu/2D/Menu2DPageControllerUtil")
require("menu/2D/Menu2DScroller")
require("menu/menu_animations/Menu2DPulseAnimation")
require("controller/ControllerWrapperInputPressedChecker")
if not Menu2DPageControllerPC then
	Menu2DPageControllerPC = class(Menu2DPage)
end
Menu2DPageControllerPC.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPage.init(l_1_0, l_1_1, l_1_2)
	l_1_0._text_spacing = tweak_data.menu2d.controller_pc.text_spacing
	l_1_0._slot_size = tweak_data.menu2d.controller_pc.box_spacing + tweak_data.menu2d.controller_pc.box_height
	l_1_0._box_height = tweak_data.menu2d.controller_pc.box_height
	l_1_0._title_text_id = l_1_1:parameter("text")
	l_1_0._icon_offset = 5
	l_1_0._action_button_background_alpha = 0.2
	l_1_0._input_button_background_alpha = 0.5
end

Menu2DPageControllerPC._parse_controller_setup_xml = function(l_2_0)
	local l_2_1 = Menu2DPageControllerUtil.parse_xml(l_2_0:controller_wrapper():get_type(), l_2_0:controller_wrapper())
	l_2_0._connected_connections = l_2_0:controller_wrapper():get_type()
	l_2_0._pc_connections = l_2_1
end

Menu2DPageControllerPC._create_pc_connections_gui = function(l_3_0)
	local l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13 = nil
	l_3_0._button_backgrounds = {}
	l_3_0._action_backgrounds = {}
	l_3_0._texts = {}
	l_3_0._input_texts = {}
	l_3_0._fade_objects = {}
	l_3_0:_add_title_text()
	local l_3_1 = l_3_0._root_panel:width()
	local l_3_2 = l_3_0:controller_wrapper()
	for i_0,i_1 in pairs(l_3_0._pc_connections) do
		l_3_0:_add_backgrounds(l_3_0._center_x - l_3_0._box_width, l_3_0._action_button_background_alpha, l_3_0._action_backgrounds)
		l_3_0:_add_backgrounds(l_3_0._center_x, l_3_0._input_button_background_alpha, l_3_0._button_backgrounds)
		l_3_0:_add_text(l_3_0._texts, managers.localization:text(i_1.text_id), "right", -l_3_0._center_x - l_3_0._text_spacing)
		local l_3_16 = nil
		l_3_0:_add_text(l_3_0._input_texts, l_3_0:_get_text(l_3_15.current_input, l_3_2:get_connection_settings(i_1.name)), "left", l_3_0._center_x + l_3_0._text_spacing)
		l_3_0._next_y = l_3_0._next_y + l_3_0._slot_size
	end
	if #l_3_0._action_backgrounds < l_3_0._max_visible_slots then
		l_3_0._parent_controller_panel:set_height(#l_3_0._action_backgrounds * l_3_0._slot_size)
	end
	l_3_0:_add_selection_bar()
	l_3_0:_add_selected_rect(l_3_0._button_backgrounds[1])
	l_3_0:_add_icon()
	l_3_0:_add_clickable_buttons()
	l_3_0._background = l_3_0._root_panel:rect({color = Color.black:with_alpha(0), layer = 2})
	l_3_0._background_animation = Menu2DFadeInAnimation:new(l_3_0._background, 0, 0.4, 0.6)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageControllerPC._add_clickable_buttons = function(l_4_0)
	local l_4_1 = l_4_0._panel:y() + l_4_0._parent_controller_panel:height()
	local l_4_2 = l_4_0:_add_button_and_text("mapping_defaults", l_4_0._parent_center_x, l_4_1)
	l_4_0._default_text_rect = l_4_0
	l_4_0._default_text = l_4_2
	l_4_2 = l_4_0._box_height
	l_4_2 = l_4_2 * 2
	l_4_1 = l_4_1 + l_4_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_0._back_text_rect = l_4_0
	l_4_0._back_text = l_4_2
end

Menu2DPageControllerPC._add_title_text = function(l_5_0)
	local l_5_1 = managers.localization:text(l_5_0._title_text_id)
	l_5_0._title = l_5_0:_create_text_object(l_5_0._panel, l_5_1, l_5_0._parent_center_x - l_5_0._box_width, 0, "left", 3, true)
	l_5_0:_fade_object(l_5_0._panel, l_5_0._title, 0, 1)
	local l_5_2, l_5_3, l_5_4, l_5_5 = l_5_0._title:text_rect()
	l_5_0._parent_controller_panel:set_y(l_5_0._parent_controller_panel:y() + l_5_5 + 10)
end

Menu2DPageControllerPC.update = function(l_6_0, l_6_1)
	Menu2DPage.update(l_6_0, l_6_1)
	if l_6_0._scroller then
		l_6_0._scroller:update(l_6_1)
	end
	if l_6_0._controller_checker then
		l_6_0._controller_checker:update()
	end
	if l_6_0._scroller then
		local l_6_2 = l_6_0._scroller:get_first_visible_index()
	if l_6_2 ~= l_6_0._current_first_slot_id then
		end
		local l_6_3 = -(l_6_2 - 1) * l_6_0._slot_size
		l_6_0._choice_panel:set_position(l_6_0._choice_panel:x(), l_6_3)
		local l_6_8 = l_6_0:_set_visible_ids
		local l_6_9 = l_6_0
		l_6_8(l_6_9, l_6_2, l_6_2 + l_6_0._max_visible_slots - 1)
	end
	if l_6_0._time_since_last_change > 0 then
		l_6_0._time_since_last_change = l_6_0._time_since_last_change - l_6_1
	end
	if l_6_0._mouse_input_delay > 0 then
		l_6_0._mouse_input_delay = l_6_0._mouse_input_delay - l_6_1
	end
	if l_6_0._selected_rect_pulse then
		l_6_0._selected_rect_pulse:update(l_6_1)
	end
	if l_6_0._fade_animations then
		local l_6_4 = true
		for i_0,i_1 in pairs(l_6_0._fade_animations) do
			if i_1:update(l_6_1) ~= true then
				l_6_4 = false
			end
		end
	if l_6_4 == true then
		end
		l_6_0._fade_animations = nil
	if l_6_0._start_fade_out then
		end
		l_6_0._fade_out_complete = true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_6_4 = l_6_0._background_animation
	if l_6_4 then
		l_6_4 = l_6_0._background_animation
		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_4 == true then
		end
		l_6_0._background_animation = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DPageControllerPC.user = function(l_7_0)
	local l_7_1, l_7_2 = managers.menu_input:bound_user, managers.menu_input
	return l_7_1(l_7_2)
end

Menu2DPageControllerPC.controller_wrapper = function(l_8_0)
	return l_8_0:user():controller_wrapper()
end

Menu2DPageControllerPC.input = function(l_9_0, l_9_1, l_9_2)
	if l_9_1.back and not l_9_0._waiting_for_button_input then
		managers.menu2d:back()
		return 
	end
	local l_9_3 = nil
	if not l_9_0._waiting_for_button_input and l_9_0._mouse_input_delay <= 0 then
		l_9_3 = l_9_0:_mouse_input(l_9_1.mouse)
	if l_9_3 == false then
		end
		managers.menu2d:back()
		return 
	end
	if l_9_0._scroller then
		l_9_0._scroller:input(l_9_1, l_9_2)
	end
	if l_9_3 or not l_9_0._waiting_for_button_input and l_9_1.select then
		l_9_0:_check_choice_panel_position()
		l_9_0._waiting_for_button_input = true
		l_9_0._potential_swap_button_text = l_9_0._input_texts[l_9_0._selection_bar_index + 1]:text()
		l_9_0._input_texts[l_9_0._selection_bar_index + 1]:set_text("")
		l_9_0._selected_rect:set_y(l_9_0._selection_bar_index * l_9_0._slot_size)
		l_9_0._selected_rect:show()
	elseif l_9_0._waiting_for_button_input then
		local l_9_4, l_9_5, l_9_6, l_9_7 = Menu2DPageControllerUtil.check_valid_button(l_9_0._pc_connections, l_9_0._selection_bar_index + 1, l_9_0._controller_checker, l_9_0:controller_wrapper())
	if l_9_4 then
		end
		local l_9_8 = l_9_0._pc_connections[l_9_0._selection_bar_index + 1].name
		local l_9_9 = l_9_0:controller_wrapper():get_connection_settings(l_9_8)
		local l_9_10 = l_9_0:_get_text(l_9_4, l_9_9)
		l_9_0._input_texts[l_9_0._selection_bar_index + 1]:set_text(l_9_10)
		l_9_0._waiting_for_button_input = nil
		l_9_0._selected_rect:hide()
		if l_9_5 then
			l_9_0._input_texts[l_9_5]:set_text(l_9_0._potential_swap_button_text)
			l_9_0:_set_pc_connections(l_9_6, l_9_7, l_9_9)
		end
		l_9_0:_set_pc_connections(l_9_8, l_9_4, l_9_9)
		l_9_0._time_since_last_change = 0.1
		l_9_0._mouse_input_delay = 0.3
	end
	local l_9_11 = l_9_1.move_axis.y
	if math.abs(l_9_11) > 0.2 and l_9_0._time_since_last_change <= 0 and not l_9_0._waiting_for_button_input then
		l_9_0._time_since_last_change = 0.1
		local l_9_12 = l_9_11 / math.abs(l_9_11)
		l_9_0:_change_selection(-l_9_12)
	end
end

Menu2DPageControllerPC._get_text = function(l_10_0, l_10_1, l_10_2)
	if l_10_2._controller_id == "mouse" then
		local l_10_5 = string.find
		l_10_5 = l_10_5(l_10_1, "mouse")
	if not l_10_5 then
		end
		l_10_5 = "MOUSE "
		l_10_1 = l_10_5 .. l_10_1
	end
	local l_10_3 = string.upper
	local l_10_4 = l_10_1
	return l_10_3(l_10_4)
end

Menu2DPageControllerPC._set_pc_connections = function(l_11_0, l_11_1, l_11_2, l_11_3)
	local l_11_8, l_11_9, l_11_10, l_11_11, l_11_12, l_11_13, l_11_14, l_11_15 = nil
	local l_11_4 = l_11_0:controller_wrapper()
	for i_0,i_1 in pairs(l_11_0._connected_connections) do
		if i_1.connected_to == l_11_1 then
			Menu2DPageControllerUtil.set_button_connection(l_11_2, i_1.name, l_11_4, l_11_3._controller_id)
			for i_0,i_1 in pairs(l_11_0._pc_connections) do
				if i_1.name == l_11_20.name then
					i_1.current_input = l_11_2
				end
			end
		end
	end
	l_11_4:rebind_connections(deep_clone(l_11_4:get_setup()))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageControllerPC._default_controls_pressed = function(l_12_0)
	local l_12_5, l_12_6, l_12_7, l_12_8, l_12_9, l_12_10, l_12_11 = nil
	managers.save:load_controller_settings(l_12_0:user(), true)
	l_12_0:_parse_controller_setup_xml()
	local l_12_1 = l_12_0:controller_wrapper()
	for i_0,i_1 in pairs(l_12_0._pc_connections) do
		l_12_0._input_texts[l_12_12]:set_text(l_12_0:_get_text(i_1.current_input, l_12_1:get_connection_settings(i_1.name)))
	end
end

Menu2DPageControllerPC._mouse_input = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7, l_13_8, l_13_10, l_13_11, l_13_12, l_13_13, l_13_15, l_13_16, l_13_17, l_13_18 = nil
	if l_13_1.cursor_position then
		for i_0,i_1 in pairs(l_13_0._action_backgrounds) do
			if l_13_0._current_first_slot_id <= i_0 and i_0 <= l_13_0._current_last_slot_id and l_13_20 - 1 ~= l_13_0._selection_bar_index and Menu2DUtilities.is_position_over_gui_object(l_13_1.cursor_position, i_1) then
				l_13_0._selection_bar_index = l_13_20 - 1
				l_13_0._selection_bar:set_y(l_13_0._slot_size * l_13_0._selection_bar_index)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if Menu2DUtilities.is_position_over_gui_object(l_13_1.cursor_position, i_1) and l_13_0._current_first_slot_id <= i_0 and i_0 <= l_13_0._current_last_slot_id and l_13_1.select then
				return true
			end
		end
		if Menu2DUtilities.is_position_over_gui_object(l_13_1.cursor_position, l_13_0._default_text_rect) then
			if l_13_1.select then
				l_13_0:_default_controls_pressed()
			end
			l_13_0._default_text_rect:set_color(Color.white:with_alpha(0.2))
		else
			l_13_0._default_text_rect:set_color(Color.white:with_alpha(0.1))
		end
		if Menu2DUtilities.is_position_over_gui_object(l_13_1.cursor_position, l_13_0._back_text_rect) then
			if l_13_1.select then
				return false
			end
			l_13_0._back_text_rect:set_color(Color.white:with_alpha(0.2))
		end
	else
		l_13_0._back_text_rect:set_color(Color.white:with_alpha(0.1))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DPageControllerPC._is_selection_bar_visible = function(l_14_0)
	if l_14_0._current_first_slot_id - 1 <= l_14_0._selection_bar_index and l_14_0._selection_bar_index <= l_14_0._current_last_slot_id then
		return true
	end
	return false
end

Menu2DPageControllerPC._check_choice_panel_position = function(l_15_0)
	if l_15_0:_is_selection_bar_visible() == false then
		local l_15_1, l_15_2 = nil, nil
		if l_15_0._selection_bar_index < l_15_0._current_first_slot_id then
			l_15_1 = l_15_0._selection_bar_index + 1
			l_15_2 = l_15_0._selection_bar_index + l_15_0._max_visible_slots
		else
			if l_15_0._current_last_slot_id < l_15_0._selection_bar_index then
				l_15_1 = l_15_0._selection_bar_index - l_15_0._max_visible_slots + 1
				l_15_2 = l_15_0._selection_bar_index + 1
			end
		end
		l_15_0:_set_visible_ids(l_15_1, l_15_2)
		l_15_0._choice_panel:set_position(l_15_0._choice_panel:x(), -l_15_0._slot_size * (l_15_1 - 1))
	end
end

Menu2DPageControllerPC._change_selection = function(l_16_0, l_16_1)
	local l_16_2 = l_16_0._selection_bar_index + l_16_1
	local l_16_3 = true
	local l_16_4 = 0
	l_16_0:_check_choice_panel_position()
	if l_16_2 < l_16_0._num_pc_connections and l_16_2 > -1 then
		l_16_0._selection_bar_index = l_16_2
		l_16_3 = false
		l_16_4 = l_16_0._choice_panel:y() + l_16_0._slot_size * -l_16_1
	elseif l_16_2 == l_16_0._num_pc_connections then
		l_16_0._selection_bar_index = 0
		l_16_0:_set_visible_ids(1, l_16_0._max_visible_slots)
		l_16_4 = -l_16_0._selection_bar_index * l_16_0._slot_size
	elseif l_16_2 == -1 then
		l_16_0._selection_bar_index = l_16_0._num_pc_connections - 1
		l_16_0:_set_visible_ids(1 + l_16_0._num_pc_connections - l_16_0._max_visible_slots, l_16_0._num_pc_connections)
		l_16_4 = l_16_0._parent_controller_panel:height() - l_16_0._choice_panel:height()
	end
	l_16_0._selection_bar:set_y(l_16_0._slot_size * l_16_0._selection_bar_index)
	local l_16_5 = l_16_2 + 1
	if l_16_0._current_last_slot_id < l_16_5 or l_16_5 < l_16_0._current_first_slot_id then
		if l_16_3 == false then
			l_16_0:_set_visible_ids(l_16_0._current_first_slot_id + l_16_1, l_16_0._current_last_slot_id + l_16_1)
		end
		l_16_0._choice_panel:set_position(l_16_0._choice_panel:x(), l_16_4)
	end
end

Menu2DPageControllerPC.confirm_mode = function(l_17_0)
	local l_17_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_17_1
end

Menu2DPageControllerPC._set_visible_ids = function(l_18_0, l_18_1, l_18_2)
	l_18_0._current_first_slot_id = l_18_1
	l_18_0._current_last_slot_id = l_18_2
	if l_18_0._scroller then
		l_18_0._scroller:set_first_visible_index(l_18_1)
	end
end

Menu2DPageControllerPC.create_controller_checker = function(l_19_0)
	l_19_0._controller_checker = ControllerWrapperInputPressedChecker:new(l_19_0:controller_wrapper())
end

Menu2DPageControllerPC.open = function(l_20_0, l_20_1, l_20_2)
	Menu2DPage.open(l_20_0, l_20_1, l_20_2, tweak_data.menu2d.layer_normal)
	managers.save:load_controller_settings(l_20_0:user())
	l_20_0._controller_checker = ControllerWrapperInputPressedChecker:new(l_20_0:controller_wrapper())
	l_20_0:_parse_controller_setup_xml()
	l_20_0._parent_controller_panel = l_20_0._root_panel:panel(l_20_1)
	l_20_0._choice_panel = l_20_0._parent_controller_panel:panel()
	l_20_0._box_width = l_20_0._choice_panel:width() * tweak_data.menu2d.controller_pc.box_width_scale
	l_20_0._choice_panel:set_width(l_20_0._box_width * 2)
	l_20_0._center_x = l_20_0._choice_panel:width() * 0.5
	l_20_0._parent_center_x = l_20_0._parent_controller_panel:width() * 0.5
	l_20_0._choice_panel:set_center_x(l_20_0._parent_center_x)
	l_20_0._time_since_last_change = -1
	l_20_0._mouse_input_delay = -1
	l_20_0._next_y = 0
	l_20_0._num_pc_connections = #l_20_0._pc_connections
	local l_20_3 = l_20_0._root_panel:height() * tweak_data.menu2d.controller_pc.panel_height_modifier
	l_20_0._max_visible_slots = math.floor(l_20_3 / l_20_0._slot_size)
	if l_20_0._num_pc_connections < l_20_0._max_visible_slots then
		l_20_0._max_visible_slots = l_20_0._num_pc_connections
	end
	l_20_0._parent_controller_panel:set_height(l_20_0._max_visible_slots * l_20_0._slot_size)
	l_20_0._choice_panel:set_height(l_20_0._num_pc_connections * l_20_0._slot_size)
	if l_20_0._num_pc_connections ~= l_20_0._max_visible_slots then
		l_20_0._scroller = Menu2DScroller:new(l_20_0._parent_controller_panel, l_20_0._choice_panel, l_20_0._num_pc_connections, 1, l_20_0._max_visible_slots, 0.4)
	end
	l_20_0:_set_visible_ids(1, l_20_0._max_visible_slots)
	l_20_0:_create_pc_connections_gui()
	l_20_0:_fade_in()
end

Menu2DPageControllerPC.destroy = function(l_21_0)
	local l_21_4, l_21_5, l_21_6, l_21_7, l_21_8, l_21_9 = nil
	if l_21_0._background then
		l_21_0._root_panel:remove(l_21_0._background)
		l_21_0._background = nil
		l_21_0._background_animation = nil
	end
	if l_21_0._scroller then
		l_21_0._scroller:destroy()
		l_21_0._scroller = nil
	end
	for i_0,i_1 in pairs(l_21_0._fade_objects) do
		i_1.parent_panel:remove(i_1.object)
	end
	l_21_0._fade_objects = nil
	l_21_0._fade_out_complete = nil
	Menu2DPage.destroy(l_21_0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageControllerPC._add_icon = function(l_22_0)
	local l_22_1 = "gui_menu_joypad_icon"
	if l_22_0:controller_wrapper():get_type() == "pc" then
		l_22_1 = "gui_menu_keyboard_icon"
	end
	local l_22_2, l_22_3 = l_22_0._panel:bitmap, l_22_0._panel
	local l_22_4 = {}
	l_22_4.color = Color.white:with_alpha(0)
	l_22_4.texture = l_22_1
	l_22_4.layer = 3
	l_22_4.width = 32
	l_22_4.height = 32
	l_22_2 = l_22_2(l_22_3, l_22_4)
	l_22_0._icon = l_22_2
	l_22_2, l_22_3 = l_22_0:_fade_object, l_22_0
	l_22_4 = l_22_0._panel
	l_22_2(l_22_3, l_22_4, l_22_0._icon, 0, 1)
	l_22_2 = l_22_0._icon
	l_22_2, l_22_3 = l_22_2:set_world_x, l_22_2
	l_22_4 = l_22_0._choice_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_22_2(l_22_3, l_22_4)
end

Menu2DPageControllerPC._add_selection_bar = function(l_23_0, l_23_1)
	local l_23_3, l_23_4 = l_23_1 or 0, l_23_0._choice_panel:bitmap
	do
		local l_23_5 = l_23_0._choice_panel
		l_23_4 = l_23_4(l_23_5, {color = Color.white:with_alpha(0), texture = "gui_menu_bg_gradient_pc", layer = 3, x = 0, y = l_23_3 * l_23_0._slot_size, width = l_23_0._choice_panel:width() * 0.5, height = l_23_0._box_height})
		l_23_0._selection_bar = l_23_4
		l_23_4, l_23_5 = l_23_0:_fade_object, l_23_0
		l_23_4(l_23_5, l_23_0._choice_panel, l_23_0._selection_bar, 0, 1)
		l_23_0._selection_bar_index = l_23_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageControllerPC._add_backgrounds = function(l_24_0, l_24_1, l_24_2, l_24_3)
	local l_24_4, l_24_5 = l_24_0._choice_panel:rect, l_24_0._choice_panel
	local l_24_6 = {}
	l_24_6.color = Color.white:with_alpha(0)
	l_24_6.layer = 1
	l_24_6.x = l_24_1
	l_24_6.y = l_24_0._next_y
	l_24_6.width = l_24_0._box_width
	l_24_6.height = l_24_0._box_height
	l_24_6.blend_mode = "normal"
	l_24_4 = l_24_4(l_24_5, l_24_6)
	l_24_5 = table
	l_24_5 = l_24_5.insert
	l_24_6 = l_24_3
	l_24_5(l_24_6, l_24_4)
	l_24_5, l_24_6 = l_24_0:_fade_object, l_24_0
	l_24_5(l_24_6, l_24_0._choice_panel, l_24_4, 0, l_24_2)
end

Menu2DPageControllerPC._add_button_and_text = function(l_25_0, l_25_1, l_25_2, l_25_3)
	local l_25_4 = managers.localization:text(l_25_1)
	local l_25_5 = l_25_0:_create_text_object(l_25_0._panel, l_25_4, -l_25_2 - l_25_0._text_spacing, l_25_3, "right", 3)
	local l_25_6, l_25_7 = l_25_0._panel:rect, l_25_0._panel
	local l_25_8 = {}
	l_25_8.color = Color.white:with_alpha(0)
	l_25_8.layer = 1
	l_25_8.x = l_25_2 - l_25_0._box_width
	l_25_8.y = l_25_3
	l_25_8.width = l_25_0._box_width
	l_25_8.height = l_25_0._box_height
	l_25_6 = l_25_6(l_25_7, l_25_8)
	l_25_7, l_25_8 = l_25_0:_fade_object, l_25_0
	l_25_7(l_25_8, l_25_0._panel, l_25_5, 0, 1)
	l_25_7, l_25_8 = l_25_0:_fade_object, l_25_0
	l_25_7(l_25_8, l_25_0._panel, l_25_6, 0, 0.1)
	l_25_7 = l_25_5
	l_25_8 = l_25_6
	return l_25_7, l_25_8
end

Menu2DPageControllerPC._add_text = function(l_26_0, l_26_1, l_26_2, l_26_3, l_26_4)
	local l_26_5 = l_26_0:_create_text_object(l_26_0._choice_panel, l_26_2, l_26_4, l_26_0._next_y, l_26_3, 3)
	table.insert(l_26_1, l_26_5)
	l_26_0:_fade_object(l_26_0._choice_panel, l_26_5, 0, 1)
end

Menu2DPageControllerPC._remove_backgrounds = function(l_27_0, l_27_1)
	local l_27_5, l_27_6, l_27_7, l_27_8 = nil
	for i_0,i_1 in pairs(l_27_1) do
		l_27_0._choice_panel:remove(i_1)
	end
	l_27_1 = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageControllerPC._add_selected_rect = function(l_28_0, l_28_1)
	local l_28_2, l_28_3 = l_28_0._choice_panel:rect, l_28_0._choice_panel
	local l_28_4 = {}
	l_28_4.color = Color.blue:with_alpha(0.5)
	l_28_4.layer = 4
	l_28_4.x = l_28_1:x()
	l_28_4.y = l_28_1:y()
	l_28_4.width = l_28_0._box_width
	l_28_4.height = l_28_0._box_height
	l_28_2 = l_28_2(l_28_3, l_28_4)
	l_28_0._selected_rect = l_28_2
	l_28_2 = l_28_0._selected_rect
	l_28_2, l_28_3 = l_28_2:hide, l_28_2
	l_28_2(l_28_3)
	l_28_2 = Menu2DPulseAnimation
	l_28_2, l_28_3 = l_28_2:new, l_28_2
	l_28_4 = l_28_0._selected_rect
	l_28_2 = l_28_2(l_28_3, l_28_4, 0.15, 0.1, 0.3, 0)
	l_28_0._selected_rect_pulse = l_28_2
end

Menu2DPageControllerPC.set_transition = function(l_29_0, l_29_1)
	Menu2DPage.set_transition(l_29_0, l_29_1)
	l_29_0._background_animation = Menu2DFadeOutAnimation:new(l_29_0._background, 0, 0.4, 0)
	l_29_0:_fade_out()
	managers.save:save_controller_settings(l_29_0:user())
	l_29_0._start_fade_out = true
end

Menu2DPageControllerPC._transition = function(l_30_0)
	if l_30_0._fade_out_complete and l_30_0._transition_active then
		return true
	end
end

Menu2DPageControllerPC._transition_end = function(l_31_0)
	Menu2DPage._transition_end(l_31_0)
end

Menu2DPageControllerPC._create_text_object = function(l_32_0, l_32_1, l_32_2, l_32_3, l_32_4, l_32_5, l_32_6, l_32_7)
	if not l_32_4 then
		l_32_4 = l_32_1:y()
	end
	local l_32_8 = tweak_data.menu2d.controls.text_scale
	if l_32_7 then
		l_32_8 = 1
	end
	l_32_2 = string.upper(l_32_2)
	local l_32_9, l_32_10 = l_32_1:text, l_32_1
	local l_32_11 = {}
	l_32_11.x = l_32_3
	l_32_11.y = l_32_4
	l_32_11.align = l_32_5
	l_32_11.text = l_32_2
	l_32_11.font = "faith_font_22"
	l_32_11.font_scale = l_32_8
	l_32_11.valign = "center"
	l_32_11.color = Color.white:with_alpha(0)
	l_32_11.layer = l_32_6
	l_32_11.wrap = true
	l_32_11.word_wrap = true
	l_32_9 = l_32_9(l_32_10, l_32_11)
	return l_32_9
end

Menu2DPageControllerPC._fade_object = function(l_33_0, l_33_1, l_33_2, l_33_3, l_33_4)
	local l_33_5 = {}
	l_33_5.parent_panel = l_33_1
	l_33_5.object = l_33_2
	l_33_5.min_alpha = l_33_3
	l_33_5.max_alpha = l_33_4
	table.insert(l_33_0._fade_objects, l_33_5)
end

Menu2DPageControllerPC._fade_in = function(l_34_0)
	local l_34_4, l_34_5, l_34_6, l_34_7, l_34_8, l_34_9 = nil
	l_34_0._fade_animations = {}
	for i_0,i_1 in pairs(l_34_0._fade_objects) do
		table.insert(l_34_0._fade_animations, Menu2DFadeInAnimation:new(i_1.object, 0, 0.4, i_1.max_alpha))
	end
end

Menu2DPageControllerPC._fade_out = function(l_35_0)
	local l_35_4, l_35_5, l_35_6, l_35_7, l_35_8, l_35_9 = nil
	l_35_0._fade_animations = {}
	for i_0,i_1 in pairs(l_35_0._fade_objects) do
		table.insert(l_35_0._fade_animations, Menu2DFadeOutAnimation:new(i_1.object, 0, 0.4, i_1.min_alpha))
	end
end


