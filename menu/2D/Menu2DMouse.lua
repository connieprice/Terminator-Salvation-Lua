require("menu/2D/Menu2DMouseStates")
Menu2DMouse = Menu2DMouse or class()
function Menu2DMouse.init(A0_0, A1_1)
	A0_0._root_panel = A1_1
	A0_0._cursor_position = {
		x = A1_1:width() / 2,
		y = A1_1:height() / 2
	}
	A0_0._cursor = A0_0._root_panel:bitmap({
		texture = "gui_pc_mouse_cursor",
		x = A0_0._cursor_position.x,
		y = A0_0._cursor_position.y,
		layer = 10000,
		rotation = 0,
		visible = false
	})
	A0_0._visible = false
	A0_0._hot_spot = {x = 11, y = 8}
	A0_0._idle_timer = 0
	A0_0._state_machine = FiniteStateMachine:new(A0_0, "_mouse", Menu2DMouseStateInvisible)
end
function Menu2DMouse.destroy(A0_2)
	A0_2._state_machine:destroy()
	A0_2._root_panel:remove(A0_2._cursor)
end
function Menu2DMouse.update(A0_3, A1_4, A2_5)
	local L3_6
	A0_3._menu_active = A2_5
	L3_6 = A0_3._update_input
	L3_6 = L3_6(A0_3)
	A0_3:_update_cursor(L3_6, A1_4)
	A0_3._state_data = {input = L3_6}
	A0_3._state_machine:update(A1_4)
	A0_3._state_data.input = nil
	return L3_6
end
function Menu2DMouse._update_input(A0_7)
	local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18
	L1_8 = {}
	L2_9 = managers
	L2_9 = L2_9.menu_input
	L4_11 = A0_7
	L3_10 = A0_7.active
	L3_10 = L3_10(L4_11)
	if L3_10 then
		L4_11 = L2_9
		L3_10 = L2_9.mouse_axis
		L3_10 = L3_10(L4_11)
		L5_12 = L2_9
		L4_11 = L2_9.mouse_button_pressed
		L6_13 = "menu_mouse_select"
		L4_11 = L4_11(L5_12, L6_13)
		L6_13 = L2_9
		L5_12 = L2_9.mouse_button_released
		L7_14 = "menu_mouse_select"
		L5_12 = L5_12(L6_13, L7_14)
		L7_14 = L2_9
		L6_13 = L2_9.mouse_button_bool
		L8_15 = "menu_mouse_select"
		L6_13 = L6_13(L7_14, L8_15)
		L7_14 = false
		L9_16 = L2_9
		L8_15 = L2_9.mouse_connection_enabled
		L10_17 = "menu_mouse_back"
		L8_15 = L8_15(L9_16, L10_17)
		if L8_15 then
			L9_16 = L2_9
			L8_15 = L2_9.mouse_button_pressed
			L10_17 = "menu_mouse_back"
			L8_15 = L8_15(L9_16, L10_17)
			L7_14 = L8_15
		end
		L8_15, L9_16 = nil, nil
		L11_18 = L3_10
		L10_17 = L3_10.length
		L10_17 = L10_17(L11_18)
		if L10_17 > 0 or L6_13 or L5_12 then
			L11_18 = A0_7
			L10_17 = A0_7._move_cursor_position
			L10_17(L11_18, L3_10)
			L8_15 = L3_10
			L9_16 = A0_7._cursor_position
		end
		L10_17 = false
		L11_18 = false
		if L2_9:mouse_connection_enabled("menu_mouse_wheel_up") then
			L10_17 = L2_9:mouse_button_pressed("menu_mouse_wheel_up")
		end
		if L2_9:mouse_connection_enabled("menu_mouse_wheel_down") then
			L11_18 = L2_9:mouse_button_pressed("menu_mouse_wheel_down")
		end
		L1_8 = {
			cursor_movement = L8_15,
			cursor_position = L9_16,
			select = L5_12,
			select_pressed = L4_11,
			select_down = L6_13,
			back = L7_14,
			wheel_up = L10_17,
			wheel_down = L11_18
		}
	else
		L3_10 = A0_7._visible
		if L3_10 then
			L4_11 = A0_7
			L3_10 = A0_7.request_hide
			L3_10(L4_11)
		end
	end
	return L1_8
end
function Menu2DMouse._move_cursor_position(A0_19, A1_20)
	local L2_21, L3_22, L4_23
	L2_21 = A0_19._cursor_position
	L3_22 = math
	L3_22 = L3_22.clamp
	L4_23 = A0_19._cursor_position
	L4_23 = L4_23.x
	L4_23 = L4_23 + A1_20.x
	L3_22 = L3_22(L4_23, A0_19._root_panel:world_left(), A0_19._root_panel:world_right())
	L2_21.x = L3_22
	L2_21 = A0_19._cursor_position
	L3_22 = math
	L3_22 = L3_22.clamp
	L4_23 = A0_19._cursor_position
	L4_23 = L4_23.y
	L4_23 = L4_23 - A1_20.y
	L3_22 = L3_22(L4_23, A0_19._root_panel:world_top(), A0_19._root_panel:world_bottom())
	L2_21.y = L3_22
end
function Menu2DMouse._update_cursor(A0_24, A1_25, A2_26, A3_27)
	if A1_25.cursor_position then
		A0_24._cursor:set_world_position(A0_24._cursor_position.x - A0_24._hot_spot.x, A0_24._cursor_position.y - A0_24._hot_spot.y)
	end
end
function Menu2DMouse.request_show(A0_28)
	local L1_29
	A0_28._request_show = true
end
function Menu2DMouse.request_hide(A0_30)
	local L1_31
	A0_30._request_hide = true
end
function Menu2DMouse.active(A0_32)
	return managers.menu_input:mouse_active() and A0_32._menu_active
end
