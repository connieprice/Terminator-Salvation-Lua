if not CoreCameraDistancePicker then
	CoreCameraDistancePicker = class()
end
CoreCameraDistancePicker.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_4 = EWS:BoxSizer("HORIZONTAL")
	l_1_0.__panel = EWS:Panel(l_1_1)
	l_1_0.__panel:set_sizer(l_1_4)
	local l_1_5, l_1_6 = EWS:SpinCtrl, EWS
	local l_1_7 = l_1_0.__panel
	do
		l_1_5 = l_1_5(l_1_6, l_1_7, l_1_2 or "", "", "")
		l_1_0.__field = l_1_5
		l_1_5 = l_1_0.__field
		l_1_5, l_1_6 = l_1_5:set_range, l_1_5
		l_1_7 = 0
		l_1_5(l_1_6, l_1_7, 100000)
		l_1_5 = l_1_0.__field
		l_1_5, l_1_6 = l_1_5:set_min_size, l_1_5
		l_1_7 = l_1_0.__field
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_5(l_1_6, l_1_7)
		l_1_5 = EWS
		l_1_5, l_1_6 = l_1_5:Button, l_1_5
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_5 = l_1_5(l_1_6, l_1_7, l_1_3 or "Pick", "", "BU_EXACTFIT")
		l_1_0.__button = l_1_5
		l_1_5 = l_1_0.__button
		l_1_5, l_1_6 = l_1_5:fit_inside, l_1_5
		l_1_5(l_1_6)
		l_1_5, l_1_6 = l_1_4:add, l_1_4
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_5(l_1_6, l_1_7, 1, 0, "EXPAND")
		l_1_5, l_1_6 = l_1_4:add, l_1_4
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_5(l_1_6, l_1_7, 0, 5, "LEFT")
		l_1_5 = l_1_0.__button
		l_1_5, l_1_6 = l_1_5:connect, l_1_5
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_5(l_1_6, l_1_7, callback(l_1_0, l_1_0, "_enter_pick_mode"))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCameraDistancePicker.panel = function(l_2_0)
	return l_2_0.__panel
end

CoreCameraDistancePicker.update = function(l_3_0, l_3_1, l_3_2)
	if l_3_0.__is_picking and managers.viewport then
		local l_3_3, l_3_4, l_3_5 = managers.viewport:get_current_camera()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_3 then
		local l_3_6 = nil
		local l_3_7 = l_3_3:position()
		local l_3_8 = nil
		if World:raycast(l_3_7, l_3_0:_screen_to_world(managers.editor:cursor_pos():with_z(l_3_6:far_range()))) then
			local l_3_9 = nil
			local l_3_10 = Draw:pen()
			l_3_10:set("screen")
			l_3_10:set(Color("ff0000"))
			l_3_10:circle(l_3_0:_world_to_screen(l_3_9.position), 0.1)
			l_3_10:line(l_3_0:_world_to_screen(l_3_9.position):with_x(-1), l_3_0:_world_to_screen(l_3_9.position):with_x(l_3_0:_world_to_screen(l_3_9.position).x - 0.1))
			l_3_10:line(l_3_0:_world_to_screen(l_3_9.position):with_x(l_3_0:_world_to_screen(l_3_9.position).x + 0.1), l_3_0:_world_to_screen(l_3_9.position):with_x(1))
			l_3_10:line(l_3_0:_world_to_screen(l_3_9.position):with_y(-1), l_3_0:_world_to_screen(l_3_9.position):with_y(l_3_0:_world_to_screen(l_3_9.position).y - 0.1))
			l_3_10:line(l_3_0:_world_to_screen(l_3_9.position):with_y(l_3_0:_world_to_screen(l_3_9.position).y + 0.1), l_3_0:_world_to_screen(l_3_9.position):with_y(1))
			l_3_0.__field:set_value(string.format("%i", math.max(0, math.round(l_3_9.distance - 10))))
		end
	if EWS:MouseEvent("EVT_MOTION"):left_is_down() then
		end
		l_3_0:_exit_pick_mode()
	end
end

CoreCameraDistancePicker._screen_to_world = function(l_4_0, l_4_1)
	if managers.viewport then
		local l_4_2 = assert(managers.viewport:get_current_camera())
	end
	if managers.viewport then
		local l_4_3 = assert(managers.viewport:get_active_vp())
	end
	local l_4_4 = l_4_3:get_rect()
	local l_4_9 = l_4_1:with_x
	l_4_9 = l_4_9(l_4_1, l_4_1.x * 2 * l_4_3:get_width_multiplier() / l_4_4.w)
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_4_5 = nil
	local l_4_6, l_4_7 = l_4_2
	l_4_7 = l_4_9
	local l_4_8 = nil
	return l_4_5(l_4_6, l_4_7)
end

CoreCameraDistancePicker._world_to_screen = function(l_5_0, l_5_1)
	if managers.viewport then
		local l_5_2 = assert(managers.viewport:get_current_camera())
	end
	if managers.viewport then
		local l_5_3 = assert(managers.viewport:get_active_vp())
	end
	local l_5_4 = l_5_3:get_rect()
	local l_5_5 = l_5_2:world_to_screen(l_5_1)
	return l_5_5:with_x(l_5_5.x * 2 * l_5_3:get_width_multiplier() / l_5_4.w):with_y(-l_5_5.y / 2 * l_5_4.h)
end

CoreCameraDistancePicker.connect = function(l_6_0, l_6_1, l_6_2, l_6_3)
	if l_6_3 then
		l_6_0.__field:connect(l_6_1, l_6_2, l_6_3)
	else
		l_6_0.__field:connect(l_6_1, l_6_2)
	end
end

CoreCameraDistancePicker.disconnect = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if l_7_3 then
		l_7_0.__field:disconnect(l_7_1, l_7_2, l_7_3)
	else
		l_7_0.__field:disconnect(l_7_1, l_7_2)
	end
end

CoreCameraDistancePicker.get_value = function(l_8_0, l_8_1)
	local l_8_2, l_8_3 = l_8_0.__field:get_value, l_8_0.__field
	local l_8_4 = l_8_1
	return l_8_2(l_8_3, l_8_4)
end

CoreCameraDistancePicker.set_value = function(l_9_0, l_9_1)
	l_9_0.__field:set_value(l_9_1)
end

CoreCameraDistancePicker.change_value = function(l_10_0, l_10_1)
	l_10_0.__field:change_value(l_10_1)
end

CoreCameraDistancePicker.set_background_colour = function(l_11_0, l_11_1, l_11_2, l_11_3)
	l_11_0.__field:set_background_colour(l_11_1, l_11_2, l_11_3)
	l_11_0.__field:refresh()
	l_11_0.__field:update()
end

CoreCameraDistancePicker.enabled = function(l_12_0)
	local l_12_1, l_12_2 = l_12_0.__field:enabled, l_12_0.__field
	return l_12_1(l_12_2)
end

CoreCameraDistancePicker.set_enabled = function(l_13_0, l_13_1)
	l_13_0.__field:set_enabled(l_13_1)
	local l_13_2, l_13_3 = l_13_0.__button:set_enabled, l_13_0.__button
	do
		if l_13_1 then
			l_13_2(l_13_3, not l_13_0.__pick_button_disabled)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCameraDistancePicker.set_pick_button_enabled = function(l_14_0, l_14_1)
	if l_14_1 then
		local l_14_2 = nil
		l_14_2 = l_14_2
	end
	l_14_0.__pick_button_disabled = l_14_2
	l_14_2 = l_14_0.__button
	if l_14_0:enabled() then
		l_14_2(l_14_2, not l_14_0.__pick_button_disabled)
	end
end

CoreCameraDistancePicker.has_focus = function(l_15_0)
	return l_15_0.__is_picking or EWS:get_window_in_focus() == l_15_0.__field
end

CoreCameraDistancePicker._enter_pick_mode = function(l_16_0)
	l_16_0.__is_picking = true
end

CoreCameraDistancePicker._exit_pick_mode = function(l_17_0)
	l_17_0.__is_picking = nil
end


