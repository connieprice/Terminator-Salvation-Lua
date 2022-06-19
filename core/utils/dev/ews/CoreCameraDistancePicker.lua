CoreCameraDistancePicker = CoreCameraDistancePicker or class()
function CoreCameraDistancePicker.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4
	L4_4 = EWS
	L4_4 = L4_4.BoxSizer
	L4_4 = L4_4(L4_4, "HORIZONTAL")
	A0_0.__panel = EWS:Panel(A1_1)
	A0_0.__panel:set_sizer(L4_4)
	A0_0.__field = EWS:SpinCtrl(A0_0.__panel, A2_2 or "", "", "")
	A0_0.__field:set_range(0, 100000)
	A0_0.__field:set_min_size(A0_0.__field:get_min_size():with_x(0))
	A0_0.__button = EWS:Button(A0_0.__panel, A3_3 or "Pick", "", "BU_EXACTFIT")
	A0_0.__button:fit_inside()
	L4_4:add(A0_0.__field, 1, 0, "EXPAND")
	L4_4:add(A0_0.__button, 0, 5, "LEFT")
	A0_0.__button:connect("EVT_COMMAND_BUTTON_CLICKED", callback(A0_0, A0_0, "_enter_pick_mode"))
end
function CoreCameraDistancePicker.panel(A0_5)
	local L1_6
	L1_6 = A0_5.__panel
	return L1_6
end
function CoreCameraDistancePicker.update(A0_7, A1_8, A2_9)
	local L3_10, L4_11, L5_12, L6_13, L7_14, L8_15
	L3_10 = A0_7.__is_picking
	if L3_10 then
		L3_10 = managers
		L3_10 = L3_10.viewport
		if L3_10 then
			L3_10 = managers
			L3_10 = L3_10.viewport
			L4_11 = L3_10
			L3_10 = L3_10.get_current_camera
			L3_10 = L3_10(L4_11)
		end
	end
	if L3_10 then
		L5_12 = L3_10
		L4_11 = L3_10.position
		L4_11 = L4_11(L5_12)
		L6_13 = A0_7
		L5_12 = A0_7._screen_to_world
		L7_14 = managers
		L7_14 = L7_14.editor
		L8_15 = L7_14
		L7_14 = L7_14.cursor_pos
		L7_14 = L7_14(L8_15)
		L8_15 = L7_14
		L7_14 = L7_14.with_z
		L8_15 = L7_14(L8_15, L3_10:far_range())
		L5_12 = L5_12(L6_13, L7_14, L8_15, L7_14(L8_15, L3_10:far_range()))
		L6_13 = World
		L7_14 = L6_13
		L6_13 = L6_13.raycast
		L8_15 = L4_11
		L6_13 = L6_13(L7_14, L8_15, L5_12)
		if L6_13 then
			L7_14 = Draw
			L8_15 = L7_14
			L7_14 = L7_14.pen
			L7_14 = L7_14(L8_15)
			L8_15 = A0_7._world_to_screen
			L8_15 = L8_15(A0_7, L6_13.position)
			L7_14:set("screen")
			L7_14:set(Color("ff0000"))
			L7_14:circle(L8_15, 0.1)
			L7_14:line(L8_15:with_x(-1), L8_15:with_x(L8_15.x - 0.1))
			L7_14:line(L8_15:with_x(L8_15.x + 0.1), L8_15:with_x(1))
			L7_14:line(L8_15:with_y(-1), L8_15:with_y(L8_15.y - 0.1))
			L7_14:line(L8_15:with_y(L8_15.y + 0.1), L8_15:with_y(1))
			A0_7.__field:set_value(string.format("%i", math.max(0, math.round(L6_13.distance - 10))))
		end
		L7_14 = EWS
		L8_15 = L7_14
		L7_14 = L7_14.MouseEvent
		L7_14 = L7_14(L8_15, "EVT_MOTION")
		L8_15 = L7_14
		L7_14 = L7_14.left_is_down
		L7_14 = L7_14(L8_15)
		if L7_14 then
			L8_15 = A0_7
			L7_14 = A0_7._exit_pick_mode
			L7_14(L8_15)
		end
	end
end
function CoreCameraDistancePicker._screen_to_world(A0_16, A1_17)
	local L2_18, L3_19, L4_20, L5_21
	L2_18 = assert
	L3_19 = managers
	L3_19 = L3_19.viewport
	if L3_19 then
		L3_19 = managers
		L3_19 = L3_19.viewport
		L4_20 = L3_19
		L3_19 = L3_19.get_current_camera
		L3_19 = L3_19(L4_20)
	end
	L2_18 = L2_18(L3_19)
	L3_19 = assert
	L4_20 = managers
	L4_20 = L4_20.viewport
	if L4_20 then
		L4_20 = managers
		L4_20 = L4_20.viewport
		L5_21 = L4_20
		L4_20 = L4_20.get_active_vp
		L4_20 = L4_20(L5_21)
	end
	L3_19 = L3_19(L4_20)
	L5_21 = L3_19
	L4_20 = L3_19.get_rect
	L4_20 = L4_20(L5_21)
	L5_21 = A1_17.with_x
	L5_21 = L5_21(A1_17, A1_17.x * 2 * L3_19:get_width_multiplier() / L4_20.w)
	L5_21 = L5_21.with_y
	L5_21 = L5_21(L5_21, A1_17.y * 2 / L4_20.h)
	return L2_18:screen_to_world(L5_21)
end
function CoreCameraDistancePicker._world_to_screen(A0_22, A1_23)
	return (assert(managers.viewport and managers.viewport:get_current_camera()):world_to_screen(A1_23):with_x(assert(managers.viewport and managers.viewport:get_current_camera()):world_to_screen(A1_23).x * 2 * assert(managers.viewport and managers.viewport:get_active_vp()):get_width_multiplier() / assert(managers.viewport and managers.viewport:get_active_vp()):get_rect().w):with_y(-assert(managers.viewport and managers.viewport:get_current_camera()):world_to_screen(A1_23).y / 2 * assert(managers.viewport and managers.viewport:get_active_vp()):get_rect().h))
end
function CoreCameraDistancePicker.connect(A0_24, A1_25, A2_26, A3_27)
	if A3_27 then
		A0_24.__field:connect(A1_25, A2_26, A3_27)
	else
		A0_24.__field:connect(A1_25, A2_26)
	end
end
function CoreCameraDistancePicker.disconnect(A0_28, A1_29, A2_30, A3_31)
	if A3_31 then
		A0_28.__field:disconnect(A1_29, A2_30, A3_31)
	else
		A0_28.__field:disconnect(A1_29, A2_30)
	end
end
function CoreCameraDistancePicker.get_value(A0_32, A1_33)
	return A0_32.__field:get_value(A1_33)
end
function CoreCameraDistancePicker.set_value(A0_34, A1_35)
	A0_34.__field:set_value(A1_35)
end
function CoreCameraDistancePicker.change_value(A0_36, A1_37)
	A0_36.__field:change_value(A1_37)
end
function CoreCameraDistancePicker.set_background_colour(A0_38, A1_39, A2_40, A3_41)
	A0_38.__field:set_background_colour(A1_39, A2_40, A3_41)
	A0_38.__field:refresh()
	A0_38.__field:update()
end
function CoreCameraDistancePicker.enabled(A0_42)
	return A0_42.__field:enabled()
end
function CoreCameraDistancePicker.set_enabled(A0_43, A1_44)
	A0_43.__field:set_enabled(A1_44)
	A0_43.__button:set_enabled(A1_44 and not A0_43.__pick_button_disabled)
end
function CoreCameraDistancePicker.set_pick_button_enabled(A0_45, A1_46)
	A0_45.__pick_button_disabled = not A1_46 or nil
	A0_45.__button:set_enabled(A0_45:enabled() and not A0_45.__pick_button_disabled)
end
function CoreCameraDistancePicker.has_focus(A0_47)
	return A0_47.__is_picking or EWS:get_window_in_focus() == A0_47.__field
end
function CoreCameraDistancePicker._enter_pick_mode(A0_48)
	local L1_49
	A0_48.__is_picking = true
end
function CoreCameraDistancePicker._exit_pick_mode(A0_50)
	local L1_51
	A0_50.__is_picking = nil
end
