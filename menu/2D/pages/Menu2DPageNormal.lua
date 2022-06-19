require("menu/2D/Menu2DPage")
if not Menu2DPageNormal then
	Menu2DPageNormal = class(Menu2DPage)
end
Menu2DPageNormal.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPage.init(l_1_0, l_1_1, l_1_2)
	l_1_0._screen = Menu2DScreen:new(l_1_0._panel, l_1_0)
	l_1_0._time_since_move = 0
end

Menu2DPageNormal.post_init = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in ipairs(l_2_0._choices) do
		i_1:post_init()
	end
end

Menu2DPageNormal.parse = function(l_3_0, l_3_1)
	Menu2DPage.parse(l_3_0, l_3_1)
	l_3_0._text = l_3_1:parameter("text")
	l_3_0._type = l_3_1:parameter("type")
	l_3_0._close_callback = l_3_1:parameter("close_callback")
	l_3_0._open_callback = l_3_1:parameter("open_callback")
	l_3_0._close_code = l_3_1:parameter("close_code")
	l_3_0._open_code = l_3_1:parameter("open_code")
	l_3_0._back_code = l_3_1:parameter("back_code")
	l_3_0._start_code = l_3_1:parameter("start_code")
	l_3_0._ignore_localization = toboolean(l_3_1:parameter("ignore_localization"))
	l_3_0._selection_side = l_3_1:parameter("selection_side")
	l_3_0._default_choice = l_3_1:parameter("default_choice")
	l_3_0._choices = {}
	for l_3_5 = 0, l_3_1:num_children() - 1 do
		l_3_0:add_choice(Menu2DChoice:new(l_3_1:child(l_3_5)))
	end
end

Menu2DPageNormal.center_all_text = function(l_4_0)
	return l_4_0._center_all_text
end

Menu2DPageNormal.can_go_back = function(l_5_0)
	if l_5_0._back_code then
		return true
	end
	return nil
end

Menu2DPageNormal.confirm_mode = function(l_6_0)
	local l_6_1, l_6_2 = l_6_0._screen:confirm_mode, l_6_0._screen
	return l_6_1(l_6_2)
end

Menu2DPageNormal.add_choice = function(l_7_0, l_7_1)
	if not l_7_1:platform() or l_7_1:platform() == SystemInfo:platform() then
		table.insert(l_7_0._choices, l_7_1)
	end
end

Menu2DPageNormal.clear = function(l_8_0)
	local l_8_4, l_8_5, l_8_6, l_8_7 = nil
	for i_0,i_1 in ipairs(l_8_0._choices) do
		i_1:destroy()
	end
	l_8_0._choices = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageNormal.open = function(l_9_0, l_9_1, l_9_2)
	if l_9_0._open_code then
		local l_9_3, l_9_4 = loadstring("return " .. l_9_0._open_code)
		local l_9_5 = l_9_3()
	if type(l_9_5) == "function" then
		end
		l_9_5(l_9_0)
	end
	l_9_0._activated_transition = nil
	Menu2DPage.open(l_9_0, l_9_1, l_9_2, tweak_data.menu2d.layer_normal)
	l_9_0._screen:create(l_9_0._panel, l_9_0._root_panel, l_9_2, l_9_0._last_choice_index, l_9_0._last_choice_text)
	l_9_0._screen:show()
end

Menu2DPageNormal.reopen = function(l_10_0, l_10_1, l_10_2)
	Menu2DPage.reopen(l_10_0, l_10_1, l_10_2)
	l_10_0._screen:reset(l_10_0._panel, l_10_0._root_panel)
end

Menu2DPageNormal._call = function(l_11_0, l_11_1)
	local l_11_2, l_11_3 = loadstring("return " .. l_11_1)
	local l_11_4 = l_11_2()
	if type(l_11_4) == "function" then
		l_11_4(l_11_0)
	end
end

Menu2DPageNormal.close = function(l_12_0)
	local l_12_1, l_12_2 = l_12_0._screen:get_selected_choice()
	l_12_0._last_choice_index = l_12_2
	l_12_0._last_choice_text = l_12_1:text()
	if l_12_0._close_code then
		l_12_0:_call(l_12_0._close_code)
	end
	l_12_0._screen:destroy()
	l_12_0:destroy()
end

Menu2DPageNormal.update = function(l_13_0, l_13_1)
	l_13_0._screen:update(l_13_1)
	Menu2DPage.update(l_13_0, l_13_1)
end

Menu2DPageNormal.set_transition = function(l_14_0, l_14_1)
	l_14_0:set_transition_time()
	Menu2DPage.set_transition(l_14_0, l_14_1)
	l_14_0._forward_transition = l_14_1
	local l_14_2 = false
	if l_14_1 then
		l_14_0._screen:start_transition_forward_out(l_14_2)
	else
		l_14_0._screen:start_transition_backward_out(l_14_2)
	end
end

Menu2DPageNormal._transition = function(l_15_0)
	if l_15_0._screen:animation_done() and l_15_0._transition_active then
		return true
	end
end

Menu2DPageNormal.transition_active = function(l_16_0)
	if l_16_0._screen:animation_done() == true and l_16_0._transition_active == false then
		return false
	end
	return true
end

Menu2DPageNormal.input = function(l_17_0, l_17_1, l_17_2)
	l_17_0:_update_keyboard_movement(l_17_1, l_17_2)
	l_17_0._screen:mouse_input(l_17_1.mouse)
	local l_17_3 = false
	local l_17_4 = l_17_0._screen:get_selected_choice()
	if l_17_0:_input_select_state(l_17_1) then
		l_17_3 = true
	else
		if l_17_0._screen:mouse_has_selected_choice(l_17_1.mouse) then
			l_17_3 = true
		end
	end
	if l_17_3 then
		l_17_0:advance()
	elseif l_17_1.back then
		if l_17_0._back_code then
			l_17_0:_call(l_17_0._back_code)
		else
			managers.menu2d:back()
		end
	elseif l_17_0._start_code and l_17_1.start then
		l_17_0:_call(l_17_0._start_code)
	end
end

Menu2DPageNormal._update_keyboard_movement = function(l_18_0, l_18_1, l_18_2)
	l_18_0._time_since_move = l_18_0._time_since_move + l_18_2
	local l_18_3 = Vector3(0, 0, 0)
	local l_18_4 = l_18_1.move_axis:length()
	if l_18_4 > 0.2 then
		if l_18_0._move_axis_at_rest or l_18_0._is_repeating_move and l_18_0._time_since_move > 0.1 then
			l_18_3 = l_18_1.move_axis:normalized()
			l_18_0._time_since_move = 0
		elseif l_18_0._time_since_move > 0.3 then
			l_18_3 = l_18_1.move_axis:normalized()
			l_18_0._time_since_move = 0
			l_18_0._is_repeating_move = true
		end
		l_18_0._move_axis_at_rest = false
	else
		l_18_0._move_axis_at_rest = true
		l_18_0._is_repeating_move = false
	end
	if l_18_1.move_axis.y <= 0 or not 1 then
		l_18_3:with_y(math.abs(l_18_3.y) <= 0.7 or -1)
	end
	l_18_0._screen:selection_changed(l_18_3.y)
	local l_18_5 = l_18_0._screen:get_selected_choice()
	if l_18_5 then
		l_18_5:input(l_18_3)
	end
end

Menu2DPageNormal._input_select_state = function(l_19_0, l_19_1)
	return l_19_1.select
end

Menu2DPageNormal.advance = function(l_20_0)
	if l_20_0._screen:get_selected_choice() then
		l_20_0._activated_transition = true
		l_20_0._screen:get_selected_choice():activate()
	end
end

Menu2DPageNormal.set_text = function(l_21_0, l_21_1)
	if l_21_1 then
		l_21_0._text = l_21_1
	end
end

Menu2DPageNormal.text = function(l_22_0)
	if not l_22_0._ignore_localization then
		local l_22_1, l_22_2 = managers.localization:text, managers.localization
		do
			local l_22_3 = l_22_0._text or ""
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_22_1(l_22_2, l_22_3)
	else
		return l_22_0._text
	end
end

Menu2DPageNormal.choices = function(l_23_0)
	return l_23_0._choices
end

Menu2DPageNormal.open_code = function(l_24_0)
	return l_24_0._open_code
end

Menu2DPageNormal.selection_side = function(l_25_0)
	return l_25_0._selection_side or "left"
end

Menu2DPageNormal.set_transition_time = function(l_26_0, l_26_1)
	l_26_0._transition_time = l_26_1
end

Menu2DPageNormal.transition_time = function(l_27_0)
	return l_27_0._transition_time
end

Menu2DPageNormal._find_choice = function(l_28_0, l_28_1)
	local l_28_5, l_28_6, l_28_7, l_28_8 = nil
	for i_0,i_1 in ipairs(l_28_0._choices) do
		if i_1:name() == l_28_1 then
			return i_1
		end
	end
end


