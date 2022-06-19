require("menu/2D/Menu2DMouseStates")
if not Menu2DMouse then
	Menu2DMouse = class()
end
Menu2DMouse.init = function(l_1_0, l_1_1)
	l_1_0._root_panel = l_1_1
	local l_1_2 = {}
	l_1_2.x = l_1_1:width() / 2
	l_1_2.y = l_1_1:height() / 2
	l_1_0._cursor_position = l_1_2
	l_1_2 = l_1_0._root_panel
	local l_1_3 = l_1_2
	local l_1_4 = {}
	l_1_4.texture = "gui_pc_mouse_cursor"
	l_1_4.x = l_1_0._cursor_position.x
	l_1_4.y = l_1_0._cursor_position.y
	l_1_4.layer = 10000
	l_1_4.rotation = 0
	l_1_4.visible = false
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._cursor = l_1_2
	l_1_0._visible = false
	l_1_0._hot_spot, l_1_2 = l_1_2, {x = 11, y = 8}
	l_1_0._idle_timer = 0
	l_1_2 = FiniteStateMachine
	l_1_2, l_1_3 = l_1_2:new, l_1_2
	l_1_4 = l_1_0
	l_1_2 = l_1_2(l_1_3, l_1_4, "_mouse", Menu2DMouseStateInvisible)
	l_1_0._state_machine = l_1_2
end

Menu2DMouse.destroy = function(l_2_0)
	l_2_0._state_machine:destroy()
	l_2_0._root_panel:remove(l_2_0._cursor)
end

Menu2DMouse.update = function(l_3_0, l_3_1, l_3_2)
	l_3_0._menu_active = l_3_2
	local l_3_3 = l_3_0:_update_input()
	l_3_0:_update_cursor(l_3_3, l_3_1)
	local l_3_4 = {}
	l_3_4.input = l_3_3
	l_3_0._state_data = l_3_4
	l_3_4 = l_3_0._state_machine
	l_3_4(l_3_4, l_3_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_4.input = nil
	return l_3_3
end

Menu2DMouse._update_input = function(l_4_0)
	local l_4_1 = {}
	local l_4_2 = managers.menu_input
	if l_4_0:active() then
		local l_4_3 = l_4_2:mouse_axis()
		local l_4_4 = l_4_2:mouse_button_pressed("menu_mouse_select")
		local l_4_5 = l_4_2:mouse_button_released("menu_mouse_select")
		local l_4_6 = l_4_2:mouse_button_bool("menu_mouse_select")
		local l_4_7 = false
		if l_4_2:mouse_connection_enabled("menu_mouse_back") then
			l_4_7 = l_4_2:mouse_button_pressed("menu_mouse_back")
		end
		local l_4_8, l_4_9 = nil, nil
		if l_4_3:length() > 0 or l_4_6 or l_4_5 then
			l_4_0:_move_cursor_position(l_4_3)
			l_4_8 = l_4_3
			l_4_9 = l_4_0._cursor_position
		end
		local l_4_10 = false
		local l_4_11 = false
		if l_4_2:mouse_connection_enabled("menu_mouse_wheel_up") then
			l_4_10 = l_4_2:mouse_button_pressed("menu_mouse_wheel_up")
		end
		if l_4_2:mouse_connection_enabled("menu_mouse_wheel_down") then
			l_4_11 = l_4_2:mouse_button_pressed("menu_mouse_wheel_down")
		end
		local l_4_12 = {}
		l_4_12.cursor_movement = l_4_8
		l_4_12.cursor_position = l_4_9
		l_4_12.select = l_4_5
		l_4_12.select_pressed = l_4_4
		l_4_12.select_down = l_4_6
		l_4_12.back = l_4_7
		l_4_12.wheel_up = l_4_10
		l_4_12.wheel_down = l_4_11
		l_4_1 = l_4_12
	elseif l_4_0._visible then
		l_4_0:request_hide()
	end
	return l_4_1
end

Menu2DMouse._move_cursor_position = function(l_5_0, l_5_1)
	l_5_0._cursor_position.x = math.clamp(l_5_0._cursor_position.x + l_5_1.x, l_5_0._root_panel:world_left(), l_5_0._root_panel:world_right())
	l_5_0._cursor_position.y = math.clamp(l_5_0._cursor_position.y - l_5_1.y, l_5_0._root_panel:world_top(), l_5_0._root_panel:world_bottom())
end

Menu2DMouse._update_cursor = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = l_6_1.cursor_position
	if l_6_4 then
		l_6_0._cursor:set_world_position(l_6_0._cursor_position.x - l_6_0._hot_spot.x, l_6_0._cursor_position.y - l_6_0._hot_spot.y)
	end
end

Menu2DMouse.request_show = function(l_7_0)
	l_7_0._request_show = true
end

Menu2DMouse.request_hide = function(l_8_0)
	l_8_0._request_hide = true
end

Menu2DMouse.active = function(l_9_0)
	if managers.menu_input:mouse_active() then
		return l_9_0._menu_active
	end
end


