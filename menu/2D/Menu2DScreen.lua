require("menu/2D/Menu2DScreenSlot.lua")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
if not Menu2DScreen then
	Menu2DScreen = class()
end
Menu2DScreen.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._scroll = false
	l_1_0._max_visible_slots = 14
	l_1_0._layer_border = tweak_data.menu2d.layer_normal + 20
	l_1_0._layer_selection = tweak_data.menu2d.layer_normal + 15
	l_1_0._layer_gradient = tweak_data.menu2d.layer_normal + 10
	l_1_0._layer_text = tweak_data.menu2d.layer_normal
	l_1_0._layer_bg = 0
	l_1_0._text_height = tweak_data.menu2d.text_font_size
	l_1_0._text_item_height = l_1_0._text_height + tweak_data.menu2d.spacing
	l_1_0._width = 1280
	l_1_0._page_name_y = 40
	l_1_0._slots = {}
	l_1_0._page_animations = {}
	l_1_0._page = l_1_2
	l_1_0._scroll_multiplier = 1
	l_1_0._in_transition = false
end

Menu2DScreen.destroy = function(l_2_0)
	l_2_0._root_panel:hide()
	l_2_0._full_screen_panel:hide()
	l_2_0:destroy_all_slots()
	l_2_0._full_screen_panel_root:remove(l_2_0._full_screen_panel)
	l_2_0._page_animations = {}
	if l_2_0._up_arrow then
		l_2_0._root_panel:remove(l_2_0._up_arrow)
	end
	if l_2_0._down_arrow then
		l_2_0._root_panel:remove(l_2_0._down_arrow)
	end
	if l_2_0._replay_scenario_back_text then
		l_2_0._root_panel:remove(l_2_0._replay_scenario_back_text)
	end
	if l_2_0._replay_scenario_selection_bar then
		l_2_0._root_panel:remove(l_2_0._replay_scenario_selection_bar)
	end
	l_2_0._up_arrow = nil
	l_2_0._down_arrow = nil
end

Menu2DScreen.show = function(l_3_0)
	l_3_0._root_panel:show()
end

Menu2DScreen.hide = function(l_4_0)
	l_4_0._root_panel:hide()
end

Menu2DScreen.create = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5)
	l_5_0._transition_time = l_5_0._page:transition_time()
	l_5_0._root_panel = l_5_1
	l_5_0._full_screen_panel_root = l_5_2
	local l_5_6, l_5_7 = l_5_2:panel, l_5_2
	local l_5_8 = {}
	l_5_8.layer = tweak_data.menu2d.layer_normal
	l_5_6 = l_5_6(l_5_7, l_5_8)
	l_5_0._full_screen_panel = l_5_6
	l_5_6 = l_5_0._root_panel
	l_5_6, l_5_7 = l_5_6:h, l_5_6
	l_5_6 = l_5_6(l_5_7)
	l_5_0._next_start_y = 0
	l_5_0._visible_slots = 0
	l_5_0._current_slot = 1
	l_5_7 = l_5_0._root_panel
	l_5_7, l_5_8 = l_5_7:w, l_5_7
	l_5_7 = l_5_7(l_5_8)
	l_5_0._width = l_5_7
	l_5_7 = tweak_data
	l_5_7 = l_5_7.menu2d
	l_5_7 = l_5_7.widget_border
	l_5_8 = l_5_0._full_screen_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_7 = l_5_7 * l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_7 = l_5_7 - l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._widget_border = l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._page_y = l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_5_9 = l_5_8
	local l_5_10 = {}
	l_5_10.y = tweak_data.menu2d.choice_panel_y
	l_5_10.height = l_5_0._root_panel:h() - tweak_data.menu2d.choice_panel_y
	l_5_10.layer = l_5_0._layer_text
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._dummy_panel = l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_9 = l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_10 = {height = 0, width = l_5_0._dummy_panel:w(), layer = l_5_0._layer_text, halign = "right"}
	l_5_0._choice_panel = l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_9 = l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_10 = {color = tweak_data.menu2d.widget_border_color:with_alpha(0), x = l_5_7, y = 0, width = 2, height = l_5_0._full_screen_panel:h(), layer = l_5_0._layer_border}
	l_5_0._widget_border_rect = l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_9 = l_5_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_10 = {text = l_5_0._page:text(), font = "credits_merged", color = tweak_data.menu2d.normal_menu.page_name_color:with_alpha(0), halign = "top", valign = "top", align = "right", width = l_5_0._widget_border, height = 60, x = 0, y = l_5_0._page_y, layer = l_5_0._layer_text}
	l_5_0._page_name = l_5_8
	l_5_0._slots, l_5_8 = l_5_8, {}
	l_5_8 = ipairs
	l_5_9 = l_5_0._page
	l_5_9, l_5_10 = l_5_9:choices, l_5_9
	l_5_10, l_5_9 = .end, l_5_9(l_5_10)
	local l_5_11, l_5_12 = nil
	l_5_8 = l_5_8(l_5_9, l_5_10, l_5_11, l_5_12)
	for l_5_11,l_5_12 in l_5_8 do
		l_5_0:_set_choice(l_5_11, l_5_12)
	end
	if #l_5_0._page:choices() > 0 then
		l_5_0._choice_panel:set_h(l_5_0._slots[#l_5_0._slots]:bottom_y() - l_5_0._slots[1]:y())
		if l_5_4 == nil or #l_5_0._slots < l_5_4 then
			l_5_4 = 1
		else
			if l_5_0._slots[l_5_4]:choice():text() ~= l_5_5 then
				l_5_4 = 1
				for i_0,i_1 in pairs(l_5_0._slots) do
					if i_1:choice():text() == l_5_5 then
						l_5_4 = i_0
					end
				end
			end
		end
		if l_5_0._dummy_panel:h() < l_5_0._slots[#l_5_0._slots]:bottom_y() or l_5_0._page:name() == "replay_scenario" then
			l_5_0._scroll = true
			l_5_0._choice_wanted_y = 0
			l_5_0._current_top = 1
			l_5_0._current_end = l_5_0._visible_slots
			l_5_0._max_visible_slots = math.floor(l_5_0._dummy_panel:h() / l_5_0._slots[l_5_0._current_slot]:height())
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_5_0._visible_slots < l_5_0._max_visible_slots then
				l_5_0._dummy_panel:set_height(l_5_0._slots[l_5_0._current_slot]:height() * l_5_0._max_visible_slots)
				l_5_0._dummy_panel:set_world_center_y(l_5_0._full_screen_panel:world_center_y())
				l_5_0:_create_arrows_and_text()
			else
				l_5_0._choice_wanted_y = 0
				l_5_0._scroll = false
			end
			l_5_0:set_selection(l_5_4, true)
		end
		if l_5_3 then
			l_5_0:start_transition_forward_in()
		elseif l_5_3 ~= "reset" then
			l_5_0:start_transition_backward_in()
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 236 
end

Menu2DScreen._create_arrows_and_text = function(l_6_0)
	local l_6_1, l_6_2 = l_6_0._root_panel:bitmap, l_6_0._root_panel
	local l_6_3 = {}
	l_6_3.texture = "gui_menu_resume_arrow"
	l_6_3.blend_mode = "add"
	l_6_3.color = Color.white:with_alpha(0)
	l_6_3.layer = 10
	l_6_1 = l_6_1(l_6_2, l_6_3)
	l_6_0._up_arrow = l_6_1
	l_6_1 = l_6_0._root_panel
	l_6_1, l_6_2 = l_6_1:bitmap, l_6_1
	l_6_1, l_6_3 = l_6_1(l_6_2, l_6_3), {texture = "gui_menu_resume_arrow", blend_mode = "add", rotation = 180, color = Color.white:with_alpha(0), layer = 10}
	l_6_0._down_arrow = l_6_1
	l_6_1 = l_6_0._up_arrow
	l_6_1, l_6_2 = l_6_1:texture_height, l_6_1
	l_6_1 = l_6_1(l_6_2)
	l_6_2 = l_6_0._up_arrow
	l_6_2, l_6_3 = l_6_2:texture_width, l_6_2
	l_6_2 = l_6_2(l_6_3)
	l_6_3 = l_6_0._slots
	l_6_3 = l_6_3[l_6_0._current_slot]
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_6_4 = l_6_3:world_x() + l_6_3:width() * 0.5 - l_6_2 * 0.5
	l_6_0._up_arrow:set_world_x(l_6_4)
	l_6_0._up_arrow:set_world_y(l_6_3:world_y() - l_6_1)
	l_6_0._down_arrow:set_world_x(l_6_4)
	l_6_0._down_arrow:set_y(l_6_0._up_arrow:y() + l_6_0._dummy_panel:height() + l_6_1)
	local l_6_5, l_6_6 = l_6_0._root_panel:text, l_6_0._root_panel
	local l_6_7 = {}
	l_6_7.text = managers.localization:text("menu_back")
	l_6_7.font = "faith_font_22"
	l_6_7.color = Color.white:with_alpha(0)
	l_6_7.align = "right"
	l_6_7.width = l_6_0._widget_border
	l_6_7.x = 0
	l_6_7.y = l_6_0._page_name:y() + l_6_0._page_name:height()
	l_6_7.layer = tweak_data.menu2d.layer_normal
	l_6_5 = l_6_5(l_6_6, l_6_7)
	l_6_0._replay_scenario_back_text = l_6_5
	l_6_5 = l_6_0._replay_scenario_back_text
	l_6_5, l_6_6 = l_6_5:text_rect, l_6_5
	l_6_5 = l_6_5(l_6_6)
	local l_6_8 = nil
	l_6_0._replay_scenario_back_text:set_height(l_6_8)
	local l_6_9, l_6_10 = l_6_0._root_panel:bitmap, l_6_0._root_panel
	local l_6_11 = {}
	l_6_11.color = Color.white:with_alpha(0)
	l_6_11.texture = "gui_menu_bg_gradient"
	l_6_11.x = 0
	l_6_11.w = tweak_data.menu2d.spacing_widget_border + l_6_0._replay_scenario_back_text:width()
	l_6_9 = l_6_9(l_6_10, l_6_11)
	l_6_0._replay_scenario_selection_bar = l_6_9
	l_6_9 = l_6_0._replay_scenario_back_text
	l_6_9, l_6_10 = l_6_9:world_center, l_6_9
	l_6_9 = l_6_9(l_6_10)
	l_6_11 = l_6_0._replay_scenario_selection_bar
	l_6_11(l_6_11, R13_PC141)
end

Menu2DScreen.reset = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_0._slots[l_7_0._current_slot]:choice():text()
	l_7_0:destroy()
	l_7_0:create(l_7_1, l_7_2, "reset", l_7_0._current_slot, l_7_3)
	l_7_0:show()
end

Menu2DScreen.update = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12 = nil
	if not l_8_0._current_slot or l_8_0._current_slot < 1 then
		return 
	end
	for i_0,i_1 in pairs(l_8_0._slots) do
		i_1:update(l_8_1)
	end
	for i_0,i_1 in pairs(l_8_0._page_animations) do
		i_1:update(l_8_1)
	end
	if l_8_0._widget_animation and l_8_0._widget_animation:update(l_8_1) == true then
		l_8_0._widget_animation = nil
	end
	if l_8_0._up_arrow_animation and l_8_0._up_arrow_animation:update(l_8_1) == true then
		l_8_0._up_arrow_animation = nil
	end
	if l_8_0._down_arrow_animation and l_8_0._down_arrow_animation:update(l_8_1) == true then
		l_8_0._down_arrow_animation = nil
	end
	if l_8_0._replay_scenario_back_text_animation and l_8_0._replay_scenario_back_text_animation:update(l_8_1) == true then
		l_8_0._replay_scenario_back_text_animation = nil
	end
	if l_8_0._replay_scenario_selection_bar_animation and l_8_0._replay_scenario_selection_bar_animation:update(l_8_1) == true then
		l_8_0._replay_scenario_selection_bar_animation = nil
	end
	if l_8_0._up_arrow then
		if l_8_0._current_top == 1 then
			l_8_0._up_arrow:set_color(Color.white:with_alpha(0.5))
		end
	else
		l_8_0._up_arrow:set_color(Color.white:with_alpha(1))
	end
	if l_8_0._down_arrow then
		if l_8_0._current_end == #l_8_0._slots then
			l_8_0._down_arrow:set_color(Color.white:with_alpha(0.5))
		end
	else
		l_8_0._down_arrow:set_color(Color.white:with_alpha(1))
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_8_0._scroll then
		l_8_0._choice_panel:set_y(nil)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_8_0._scroll_bar then
		l_8_0._scroll_bar:update(l_8_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

Menu2DScreen.get_selected_choice = function(l_9_0)
	if #l_9_0._slots > 0 then
		return l_9_0._slots[l_9_0._current_slot]:choice(), l_9_0._current_slot
	end
end

Menu2DScreen.selection_changed = function(l_10_0, l_10_1, l_10_2)
	if not l_10_0._current_slot then
		return 
	end
	l_10_0._input_y = l_10_1
	l_10_1 = l_10_1 > 0 and -1 or 1
	local l_10_3 = l_10_0._slots[l_10_0._current_slot]
	if l_10_3 and l_10_0._dummy_panel:world_y() - l_10_3:height() <= l_10_3:world_y() and l_10_3:world_y() <= l_10_0._dummy_panel:world_y() + l_10_0._dummy_panel:h() then
		l_10_3 = true
	else
		l_10_3 = false
	end
	if l_10_3 and #l_10_0._slots > 1 then
		local l_10_4 = true
		if not l_10_0._scroll then
			l_10_0._slots[l_10_0._current_slot]:selection_changed(false)
			l_10_4 = l_10_0:next_slot(l_10_1)
			l_10_0._slots[l_10_0._current_slot]:selection_changed(true)
		end
		managers.menu2d:sound():play("menu_move")
		if l_10_0._scroll then
			local l_10_5 = l_10_0._current_slot + (l_10_1)
			if l_10_5 ~= 0 and l_10_5 ~= #l_10_0._slots + 1 then
				l_10_0._slots[l_10_0._current_slot]:selection_changed(false, nil, l_10_2)
				l_10_0:_set_top_and_end_slot(l_10_5, l_10_1)
				l_10_0:set_selection(l_10_5, true)
			end
			l_10_4 = false
		end
		if l_10_4 then
			l_10_0._scroll_multiplier = 2
		end
	else
		l_10_0._scroll_multiplier = 1
	end
end

Menu2DScreen._set_top_and_end_slot = function(l_11_0, l_11_1, l_11_2)
	if l_11_0._current_end < l_11_1 or l_11_1 < l_11_0._current_top then
		l_11_0._current_top = l_11_0._current_top + l_11_2
		l_11_0._current_end = l_11_0._current_end + l_11_2
		l_11_0._choice_wanted_y = -(l_11_0._current_top - 1) * l_11_0._slots[1]:height()
	end
	l_11_0._current_slot = l_11_1
end

Menu2DScreen._slot_is_visible = function(l_12_0, l_12_1)
	if not l_12_0._scroll or l_12_0._scroll and l_12_1 <= l_12_0._current_end and l_12_0._current_top <= l_12_1 then
		return true
	end
	return false
end

Menu2DScreen.mouse_input = function(l_13_0, l_13_1)
	local l_13_2 = l_13_1.cursor_position
	if l_13_0._scroll then
		if l_13_1.wheel_down then
			l_13_0:selection_changed(-1, true)
		end
	elseif l_13_1.wheel_up then
		l_13_0:selection_changed(1, true)
	end
	if l_13_2 then
		l_13_0._has_clicked_on_arrow = nil
		if l_13_0._up_arrow and l_13_0._down_arrow then
			local l_13_3, l_13_4 = nil, nil
			if l_13_1.select and Menu2DUtilities.is_position_over_gui_object(l_13_2, l_13_0._up_arrow) then
				l_13_0._has_clicked_on_arrow = true
				l_13_0:selection_changed(1)
			end
		elseif l_13_1.select and Menu2DUtilities.is_position_over_gui_object(l_13_2, l_13_0._down_arrow) then
			l_13_0._has_clicked_on_arrow = true
			l_13_0:selection_changed(-1)
		end
		if l_13_0._replay_scenario_selection_bar and Menu2DUtilities.is_position_over_gui_object(l_13_2, l_13_0._replay_scenario_selection_bar) then
			l_13_0._replay_scenario_selection_bar:set_color(Color.white:with_alpha(1))
			l_13_0._replay_scenario_back_text:set_color(Color.white:with_alpha(1))
			if l_13_1.select then
				managers.menu2d:back()
			end
		elseif l_13_0._replay_scenario_selection_bar then
			l_13_0._replay_scenario_selection_bar:set_color(Color.white:with_alpha(0))
			l_13_0._replay_scenario_back_text:set_color(Color.white:with_alpha(0.5))
		end
		l_13_0:mouse_position_changed(l_13_2)
		local l_13_5, l_13_6 = l_13_0:_find_mouse_over_widget(l_13_2)
	if l_13_6 then
		end
		l_13_6:mouse_input(l_13_1)
	end
end

Menu2DScreen.mouse_position_changed = function(l_14_0, l_14_1)
	local l_14_2, l_14_3 = l_14_0:_find_mouse_over_slot(l_14_1)
	if l_14_3 and l_14_2 ~= l_14_0._current_slot and not l_14_3:empty() and (not l_14_0._scroll or l_14_0._current_top > l_14_2 or l_14_2 <= l_14_0._current_end) then
		l_14_0._slots[l_14_0._current_slot]:selection_changed(false)
		l_14_0._current_slot = l_14_2
		l_14_0._slots[l_14_0._current_slot]:selection_changed(true)
		managers.menu2d:sound():play("menu_move")
	end
end

Menu2DScreen.mouse_has_selected_choice = function(l_15_0, l_15_1)
	if l_15_0._has_clicked_on_arrow then
		return false
	end
	if l_15_1.select then
		assert(l_15_1.cursor_position)
		return l_15_0:_find_mouse_over_choice(l_15_1.cursor_position) ~= nil
	else
		return false
	end
end

Menu2DScreen._find_mouse_over_slot = function(l_16_0, l_16_1)
	local l_16_2, l_16_3 = l_16_0:_find_mouse_over_slot_item, l_16_0
	local l_16_4 = l_16_1
	local l_16_5 = "is_mouse_over_slot"
	return l_16_2(l_16_3, l_16_4, l_16_5)
end

Menu2DScreen._find_mouse_over_choice = function(l_17_0, l_17_1)
	local l_17_2, l_17_3 = l_17_0:_find_mouse_over_slot_item, l_17_0
	local l_17_4 = l_17_1
	local l_17_5 = "is_mouse_over_choice"
	return l_17_2(l_17_3, l_17_4, l_17_5)
end

Menu2DScreen._find_mouse_over_widget = function(l_18_0, l_18_1)
	local l_18_2, l_18_3 = l_18_0:_find_mouse_over_slot_item, l_18_0
	local l_18_4 = l_18_1
	local l_18_5 = "is_mouse_over_widget"
	return l_18_2(l_18_3, l_18_4, l_18_5)
end

Menu2DScreen._find_mouse_over_slot_item = function(l_19_0, l_19_1, l_19_2)
	local l_19_6, l_19_7, l_19_8, l_19_9, l_19_10, l_19_11, l_19_12, l_19_13 = nil
	for i_0,i_1 in pairs(l_19_0._slots) do
		if i_1[l_19_2](i_1, l_19_1) and l_19_0:_slot_is_visible(i_0) then
			return i_0, i_1
		end
	end
	return nil, nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DScreen.next_slot = function(l_20_0, l_20_1)
	local l_20_2 = l_20_0._current_slot + l_20_1
	local l_20_3 = false
	if #l_20_0._slots < l_20_2 then
		l_20_0._current_slot = 1
		l_20_3 = true
	elseif l_20_2 < 1 then
		l_20_0._current_slot = #l_20_0._slots
		l_20_3 = true
	else
		l_20_0._current_slot = l_20_2
	end
	if l_20_0._slots[l_20_0._current_slot]:empty() and #l_20_0._slots >= l_20_0._current_slot and l_20_0._current_slot >= 1 then
		l_20_3 = l_20_0:next_slot(l_20_1)
	end
	return l_20_3
end

Menu2DScreen.set_selection = function(l_21_0, l_21_1, l_21_2)
	if not l_21_0._scroll then
		l_21_0._slots[l_21_0._current_slot]:selection_changed(false)
	else
		l_21_0._slots[l_21_0._current_slot]:fast_fade_selection_bar()
	end
	l_21_0._current_slot = l_21_1
	l_21_0._slots[l_21_0._current_slot]:selection_changed(true, true)
	if l_21_2 then
		l_21_0._choice_panel:set_y(l_21_0._choice_wanted_y)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

Menu2DScreen._fade_slots = function(l_22_0, l_22_1)
	l_22_0._animations = {}
	l_22_0._in_transition = true
	local l_22_2, l_22_3 = nil, nil
	if l_22_1 == "fade_out" then
		l_22_3 = 0
		l_22_2 = Menu2DFadeOutAnimation:new(l_22_0._page_name, 0, l_22_0:transition_time(), 0)
		if l_22_0._widget_border_rect then
			l_22_0._widget_animation = Menu2DFadeOutAnimation:new(l_22_0._widget_border_rect, 0, l_22_0:transition_time(), 0)
		end
		if l_22_0._up_arrow and l_22_0._down_arrow then
			l_22_0._up_arrow_animation = Menu2DFadeOutAnimation:new(l_22_0._up_arrow, 0, l_22_0:transition_time(), 0)
			l_22_0._down_arrow_animation = Menu2DFadeOutAnimation:new(l_22_0._down_arrow, 0, l_22_0:transition_time(), 0)
		end
		if l_22_0._replay_scenario_selection_bar and l_22_0._replay_scenario_back_text then
			l_22_0._replay_scenario_back_text_animation = Menu2DFadeOutAnimation:new(l_22_0._replay_scenario_back_text, 0, l_22_0:transition_time(), 0)
			l_22_0._replay_scenario_selection_bar_animation = Menu2DFadeOutAnimation:new(l_22_0._replay_scenario_selection_bar, 0, l_22_0:transition_time(), 0)
		end
	else
		l_22_3 = 1
		l_22_2 = Menu2DFadeInAnimation:new(l_22_0._page_name, 0, l_22_0:transition_time(), 1)
		if l_22_0._widget_border_rect then
			l_22_0._widget_animation = Menu2DFadeInAnimation:new(l_22_0._widget_border_rect, 0, l_22_0:transition_time(), 0.2)
		end
		if l_22_0._up_arrow and l_22_0._down_arrow then
			l_22_0._up_arrow_animation = Menu2DFadeInAnimation:new(l_22_0._up_arrow, 0, l_22_0:transition_time(), 1)
			l_22_0._down_arrow_animation = Menu2DFadeInAnimation:new(l_22_0._down_arrow, 0, l_22_0:transition_time(), 1)
		end
	if l_22_0._replay_scenario_selection_bar then
		end
	if l_22_0._replay_scenario_back_text then
		end
		local l_22_7, l_22_9 = Menu2DFadeInAnimation:new, Menu2DFadeInAnimation
		local l_22_8, l_22_10 = l_22_0._replay_scenario_back_text, 0
		l_22_7 = l_22_7(l_22_9, l_22_8, l_22_10, l_22_0:transition_time(), 0.5)
		l_22_0._replay_scenario_back_text_animation = l_22_7
	end
	table.insert(l_22_0._page_animations, l_22_2)
	for i_0,i_1 in ipairs(l_22_0._slots) do
		local l_22_13 = i_1:transition
		local l_22_14 = i_1
		l_22_13(l_22_14, tostring(l_22_1), {0, l_22_0:transition_time(), l_22_3})
	end
end

Menu2DScreen.start_transition_forward_out = function(l_23_0, l_23_1)
	l_23_0:_fade_slots("fade_out")
end

Menu2DScreen.start_transition_backward_out = function(l_24_0, l_24_1)
	l_24_0:_fade_slots("fade_out")
end

Menu2DScreen.start_transition_forward_in = function(l_25_0)
	l_25_0:_fade_slots("fade_in")
end

Menu2DScreen.start_transition_backward_in = function(l_26_0)
	l_26_0:_fade_slots("fade_in")
	if alive(l_26_0._page_name_selection_bar) and not managers.menu2d:gradient_page_name() then
		table.insert(l_26_0._animations, l_26_0._page_name_selection_bar:animate(Menu2DAnimations.slide_in, tweak_data.menu2d.animation.page_name_gradient_move_speed, l_26_0._page_name_selection_bar:x()))
		managers.menu2d:set_gradient_page_name(true)
	end
end

Menu2DScreen.transition_time = function(l_27_0)
	if not l_27_0._page:transition_time() then
		return tweak_data.menu2d.animation.fade_out_page_name_time
	end
end

Menu2DScreen.animation_done = function(l_28_0)
	local l_28_4, l_28_5 = nil
	if l_28_0._in_transition == true then
		for i_0,i_1 in pairs(l_28_0._slots) do
			if i_1:animations_fade_completed() == false then
				return false
			end
		end
		l_28_0._in_transition = false
		l_28_0._page:set_transition_time()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DScreen._set_choice = function(l_29_0, l_29_1, l_29_2)
	if not l_29_0._next_start_y then
		local l_29_3 = Menu2DScreenSlot:new(l_29_0._full_screen_panel, l_29_0._choice_panel, l_29_0._text_height, not l_29_2:allowed() or 0, l_29_0._width, l_29_0._widget_border, l_29_0._page)
		table.insert(l_29_0._slots, l_29_3)
		l_29_3:set(l_29_2)
		l_29_0._next_start_y = l_29_0._next_start_y + l_29_3:height()
		if l_29_0._next_start_y < l_29_0._dummy_panel:h() then
			l_29_0._visible_slots = l_29_0._visible_slots + 1
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 14 
end

Menu2DScreen._hide_all_slots = function(l_30_0)
	local l_30_4, l_30_5, l_30_6, l_30_7 = nil
	for i_0,i_1 in ipairs(l_30_0._slots) do
		i_1:hide()
	end
end

Menu2DScreen.destroy_all_slots = function(l_31_0)
	local l_31_4, l_31_5, l_31_6, l_31_7 = nil
	for i_0,i_1 in ipairs(l_31_0._slots) do
		i_1:destroy()
	end
	l_31_0._slots = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DScreen.confirm_mode = function(l_32_0)
	if not l_32_0._current_slot then
		return nil
	end
	local l_32_1, l_32_2 = l_32_0._slots[l_32_0._current_slot]:confirm_mode, l_32_0._slots[l_32_0._current_slot]
	return l_32_1(l_32_2)
end

Menu2DScreen.slots = function(l_33_0)
	return l_33_0._slots
end


