core:require_module("CoreScriptViewport")
if not CoreFreeFlight then
	CoreFreeFlight = class()
end
CoreFreeFlight.init = function(l_1_0)
	l_1_0._active = false
	l_1_0._update = true
	l_1_0._all_update = true
	l_1_0._freeflight_locked = false
	l_1_0._ff_vp = CoreScriptViewport.ScriptViewport:new(0, 0, 1, 1)
	local l_1_1 = World:create_camera()
	l_1_1:set_near_range(20)
	l_1_1:set_far_range(600000)
	l_1_1:set_fov(75)
	l_1_0._freeze_camera = World:create_camera()
	l_1_0._freeze_camera:set_near_range(20)
	l_1_0._freeze_camera:set_far_range(600000)
	l_1_0._freeze_camera:set_fov(75)
	l_1_0._camera = l_1_1
	l_1_0._ff_vp:set_camera(l_1_0._freeze_camera)
	l_1_0._listener_id = managers.listener:add_listener("freeflight", l_1_0._freeze_camera)
	l_1_0._listener_activation_id = nil
	local l_1_2, l_1_3 = managers.listener:add_set, managers.listener
	local l_1_4 = "freeflight"
	do
		local l_1_5 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_1_2(l_1_3, l_1_4, l_1_5)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_2(l_1_3)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreFreeFlight.set_controller = function(l_2_0)
	l_2_0._controller = managers.controller:create_controller(nil, nil, true)
	l_2_0._controller:disable()
	if Application:debug_build() then
		l_2_0._toggle_ctrlr = Input:create_virtual_controller()
		if Input:keyboard():has_button("f9") then
			l_2_0._toggle_ctrlr:connect(Input:keyboard(), "f9", "use_ff")
			l_2_0._toggle_ctrlr:add_trigger("use_ff", callback(l_2_0, l_2_0, "toggle_ff"))
		end
	if Application:editor() then
		end
		if Input:keyboard():has_button("f11") then
			l_2_0._toggle_ctrlr:connect(Input:keyboard(), "f11", "add_point")
			l_2_0._toggle_ctrlr:add_trigger("add_point", callback(l_2_0, l_2_0, "add_bm_point"))
		end
	if Input:keyboard():has_button("f12") then
		end
		l_2_0._toggle_ctrlr:connect(Input:keyboard(), "f12", "save_points")
		l_2_0._toggle_ctrlr:add_trigger("save_points", callback(l_2_0, l_2_0, "save_bm_points"))
	end
end

CoreFreeFlight.set_listener_enabled = function(l_3_0, l_3_1)
	if l_3_1 and not l_3_0._listener_activation_id then
		l_3_0._listener_activation_id = managers.listener:activate_set("main", "freeflight")
	end
	do return end
	if l_3_0._listener_activation_id then
		managers.listener:deactivate_set(l_3_0._listener_activation_id)
		l_3_0._listener_activation_id = nil
	end
end

CoreFreeFlight.add_bm_point = function(l_4_0)
	local l_4_1 = l_4_0._camera:new_rotation()
	l_4_1 = Rotation(l_4_1:x(), -l_4_1:z(), l_4_1:y())
	managers.benchmark:add_point("default", Global.zone_data.load_zone, l_4_0._camera:position(), l_4_1)
end

CoreFreeFlight.save_bm_points = function(l_5_0)
	managers.benchmark:save_points()
end

CoreFreeFlight.position_output = function(l_6_0)
	local l_6_1 = l_6_0._ff_vp:camera():position()
	cat_debug("debug", "<position pos_x=\"" .. l_6_1.x .. "\" pos_y=\"" .. l_6_1.y .. "\" pos_z=\"" .. l_6_1.z .. "\"/>")
	cat_debug("debug", "<position pos=\"" .. l_6_1.x .. " " .. l_6_1.y .. " " .. l_6_1.z .. "\"/>")
end

CoreFreeFlight.get_controller = function(l_7_0)
	return l_7_0._controller
end

CoreFreeFlight.destroy = function(l_8_0)
	if alive(l_8_0._toggle_ctrlr) then
		Input:destroy_virtual_controller(l_8_0._toggle_ctrlr)
		l_8_0._toggle_ctrlr = nil
	end
	if l_8_0._controller then
		l_8_0._controller:destroy()
		l_8_0._controller = nil
	end
	if l_8_0._listener_id then
		managers.listener:remove_listener(l_8_0._listener_id)
		managers.listener:remove_set("freeflight")
		l_8_0._listener_id = nil
	end
	if managers.sound_environment:obj_alive(l_8_0._sound_environment_check_object) then
		managers.sound_environment:remove_check_object(l_8_0._sound_environment_check_object)
	end
	if l_8_0._ff_vp then
		l_8_0._ff_vp:destroy()
		l_8_0._ff_vp = nil
	end
end

CoreFreeFlight.connect_triggers = function(l_9_0)
	l_9_0._controller:enable()
	l_9_0._controller:add_trigger("up", callback(l_9_0, l_9_0, "move_speed_up"))
	l_9_0._controller:add_trigger("down", callback(l_9_0, l_9_0, "move_speed_down"))
	l_9_0._controller:add_trigger("right", callback(l_9_0, l_9_0, "turn_speed_up"))
	l_9_0._controller:add_trigger("left", callback(l_9_0, l_9_0, "turn_speed_down"))
	l_9_0._controller:add_trigger("action_1", callback(l_9_0, l_9_0, "toggle_frustum_freeze"))
	l_9_0._controller:add_trigger("action_2", callback(l_9_0, l_9_0, "position_output"))
	l_9_0._controller:add_trigger("action_3", callback(l_9_0, l_9_0, "dump_units"))
	l_9_0._controller:add_trigger("action_4", callback(l_9_0, l_9_0, "print_position"))
	l_9_0._controller:add_trigger("position_output", callback(l_9_0, l_9_0, "position_output"))
	l_9_0._controller:add_trigger("debug_spawn", callback(l_9_0, l_9_0, "debug_spawn"))
	l_9_0._triggers_connected = true
end

CoreFreeFlight.disconnect_triggers = function(l_10_0)
	l_10_0._controller:clear_triggers(false)
	l_10_0._controller:disable()
	l_10_0._triggers_connected = false
end

CoreFreeFlight.toggle_ff = function(l_11_0)
	if l_11_0:in_focus() then
		l_11_0:on_loose_focus()
	else
		l_11_0:on_get_focus()
	end
end

CoreFreeFlight.set_old_vp = function(l_12_0, l_12_1)
	l_12_0._old_vp = l_12_1
end

CoreFreeFlight.on_get_focus = function(l_13_0)
	if not l_13_0:in_focus() and (not managers.editor or script_debug.running_simulation) then
		l_13_0:connect_triggers()
		l_13_0._freeze_camera_locked = false
		l_13_0._old_vp = managers.viewport:first_active_viewport()
		managers.viewport:push()
		managers.viewport:deactivate_all_viewports()
		l_13_0._ff_vp:set_active(true)
		l_13_0:set_listener_enabled(true)
		if managers.sound_environment:obj_alive(l_13_0._sound_environment_check_object) then
			managers.sound_environment:set_check_object_active(l_13_0._sound_environment_check_object, true)
		end
		local l_13_1, l_13_2 = nil, nil
		if l_13_0._old_vp then
			l_13_2 = l_13_0._old_vp:camera():position()
			l_13_1 = l_13_0._old_vp:camera():new_rotation()
		else
			l_13_2 = Vector3(0, 0, 300)
			l_13_1 = Rotation(0, 0, 0)
		end
		l_13_0:init_camera(l_13_2, l_13_1)
		l_13_0._active = true
	end
end

CoreFreeFlight.on_loose_focus = function(l_14_0, l_14_1, l_14_2, l_14_3)
	if l_14_0:in_focus() then
		l_14_0:disconnect_triggers()
		l_14_0:set_listener_enabled(false)
		if managers.sound_environment:obj_alive(l_14_0._sound_environment_check_object) then
			managers.sound_environment:set_check_object_active(l_14_0._sound_environment_check_object, false)
		end
		l_14_0._ff_vp:set_active(false)
		managers.viewport:pop()
		l_14_0._active = false
	end
end

CoreFreeFlight.in_focus = function(l_15_0)
	return l_15_0._active
end

CoreFreeFlight.update = function(l_16_0, l_16_1, l_16_2)
	if l_16_0:in_focus() then
		if not l_16_0._freeflight_locked then
			l_16_0:update_camera(l_16_1, l_16_2)
		end
		if l_16_0._controller:get_input_bool("action_5") then
			l_16_0:inc_near_range()
		else
			if l_16_0._controller:get_input_bool("action_6") then
				l_16_0:dec_near_range()
			end
		end
		l_16_0:draw_freeze_frustum()
	end
end

CoreFreeFlight.toggle_lock_freeflight = function(l_17_0, l_17_1, l_17_2, l_17_3)
	l_17_0._freeflight_locked = not l_17_0._freeflight_locked
end

CoreFreeFlight.print_position = function(l_18_0)
	cat_print("debug", "Camera position: Vector3( " .. l_18_0._camera:position().x .. ", " .. l_18_0._camera:position().y .. ", " .. l_18_0._camera:position().z .. ")")
end

CoreFreeFlight.debug_spawn = function(l_19_0)
	local l_19_1 = l_19_0._camera:position()
	if Global.debug_unit and Global.debug_unit ~= nil then
		World:spawn_unit(Global.debug_unit, l_19_1)
	end
end

CoreFreeFlight.dump_units = function(l_20_0)
	local l_20_1 = 400
	local l_20_2 = l_20_0._camera:position() + l_20_0._camera:new_rotation():y() * l_20_1
	local l_20_7 = World:find_units_quick
	local l_20_8 = World
	l_20_7 = l_20_7(l_20_8, "sphere", l_20_2, l_20_1, managers.slot:get_mask("all"))
	local l_20_3 = nil
	l_20_8 = cat_debug
	l_20_3 = "debug"
	l_20_8(l_20_3, "Dump Units:")
	l_20_8 = pairs
	l_20_3 = l_20_7
	l_20_8 = l_20_8(l_20_3)
	for i_0,i_1 in l_20_8 do
		local l_20_9 = l_20_6:rotation()
		cat_debug("debug", "Name:     " .. l_20_6:name())
		cat_debug("debug", "Position: " .. tostring(l_20_6:position()))
		cat_debug("debug", "Rotation:  [Yaw: " .. tostring(l_20_9:yaw()) .. ", Pitch: " .. tostring(l_20_9:pitch()) .. " Roll: " .. tostring(l_20_9:roll()) .. "]")
		cat_debug("debug", "")
	end
	cat_debug("debug", "")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreFreeFlight.move_speed_up = function(l_21_0)
	local l_21_1 = math.clamp(l_21_0._move_speed * 0.3, 8, 8000)
	l_21_0._move_speed = math.clamp(l_21_0._move_speed + l_21_1, 10, 80000)
end

CoreFreeFlight.move_speed_down = function(l_22_0)
	local l_22_1 = math.clamp(l_22_0._move_speed * 0.3, 8, 8000)
	l_22_0._move_speed = math.clamp(l_22_0._move_speed - l_22_1, 10, 80000)
end

CoreFreeFlight.turn_speed_up = function(l_23_0)
	l_23_0._turn_speed = math.clamp(l_23_0._turn_speed + 90, 10, 1080)
end

CoreFreeFlight.turn_speed_down = function(l_24_0)
	l_24_0._turn_speed = math.clamp(l_24_0._turn_speed - 90, 10, 1080)
end

CoreFreeFlight.inc_near_range = function(l_25_0)
	l_25_0._ff_vp:camera():set_near_range(math.clamp(l_25_0._ff_vp:camera():near_range() + 1, 1, 1000))
end

CoreFreeFlight.dec_near_range = function(l_26_0)
	l_26_0._ff_vp:camera():set_near_range(math.clamp(l_26_0._ff_vp:camera():near_range() - 1, 1, 1000))
end

CoreFreeFlight.toggle_frustum_freeze = function(l_27_0)
	if l_27_0._freeze_camera_locked then
		l_27_0._freeze_camera_locked = false
		l_27_0._camera:set_far_range(l_27_0._freeze_camera:far_range())
		l_27_0:step_timer()
		script_debug.draw_enabled = l_27_0._old_debug_draw_enabled
	else
		l_27_0._freeze_camera_locked = true
		l_27_0._camera:set_far_range(l_27_0._freeze_camera:far_range() * 10)
		l_27_0:draw_freeze_frustum()
		l_27_0:step_timer()
		l_27_0._old_debug_draw_enabled = script_debug.draw_enabled
		script_debug.draw_enabled = true
		Application:set_frustum_freeze_camera(l_27_0._freeze_camera, l_27_0._camera)
	end
end

CoreFreeFlight.step_timer = function(l_28_0)
end

CoreFreeFlight.set_update = function(l_29_0, l_29_1)
	l_29_0._update = l_29_1
end

CoreFreeFlight.set_all_update = function(l_30_0, l_30_1)
	l_30_0._all_update = l_30_1
end

CoreFreeFlight.init_camera = function(l_31_0, l_31_1, l_31_2)
	l_31_0._move_speed = 1000
	l_31_0._turn_speed = 1000
	l_31_0._camera:set_local_position(l_31_1)
	l_31_0._yaw = l_31_2:roll()
	l_31_0._pitch = l_31_2:yaw()
	l_31_0._freeze_camera:set_local_position(l_31_1)
	l_31_0._lock_pos = false
end

CoreFreeFlight.update_camera = function(l_32_0, l_32_1, l_32_2)
	if l_32_0._camera then
		local l_32_3 = l_32_0._move_speed * l_32_2
		local l_32_4 = l_32_0._turn_speed * l_32_2 * 0.1
		local l_32_5 = l_32_0._controller:get_input_axis("axis_1") * l_32_3
		local l_32_6 = l_32_0._camera:new_rotation()
		local l_32_7 = l_32_6:x() * l_32_5.x + l_32_6:y() * l_32_5.y
		if l_32_0._controller:get_input_bool("action_6") then
			l_32_7 = Vector3(l_32_7.x, l_32_7.y, l_32_7.z + l_32_3)
		end
		if l_32_0._controller:get_input_bool("action_5") then
			l_32_7 = Vector3(l_32_7.x, l_32_7.y, l_32_7.z - l_32_3)
		end
		local l_32_8 = l_32_0._controller:get_input_axis("axis_2") * l_32_4
		l_32_0._pitch = math.clamp(l_32_0._pitch + l_32_8.y, -90, 90)
		l_32_0._yaw = l_32_0._yaw - l_32_8.x
		if l_32_0._update and l_32_0._all_update then
			l_32_0._camera:set_local_position(l_32_0._camera:local_position() + l_32_7)
			l_32_0._camera:new_set_rotation(Rotation(l_32_0._pitch, 0, l_32_0._yaw))
		end
	if l_32_0._all_update then
		end
	if not l_32_0._freeze_camera_locked then
		end
		l_32_0._freeze_camera:set_local_position(l_32_0._camera:local_position())
		l_32_0._freeze_camera:new_set_rotation(l_32_0._camera:new_rotation())
	end
end

CoreFreeFlight.draw_freeze_frustum = function(l_33_0)
	if l_33_0._freeze_camera_locked then
		local l_33_1 = l_33_0._freeze_camera:far_range()
		local l_33_2 = l_33_0._freeze_camera:position()
		Application:draw_sphere(l_33_2, 1000, 0, 0, 1)
		local l_33_3 = l_33_0._freeze_camera:new_rotation()
		local l_33_4 = l_33_0._freeze_camera:fov()
		local l_33_5 = Application:screen_resolution()
		local l_33_6 = l_33_5.y / l_33_5.x
		local l_33_7 = math.sin(l_33_4 * 0.5) * l_33_1
		local l_33_8 = math.sin(l_33_4 * 0.5) * l_33_1 * l_33_6
		local l_33_9 = {}
		local l_33_13, l_33_14 = Vector3(-l_33_7, l_33_1, -l_33_8), Vector3(l_33_7, l_33_1, -l_33_8)
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in l_33_13 do
			local l_33_15 = l_33_12:length()
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_33_13:draw_line(l_33_2, l_33_2 + l_33_9[1]:rotate_with(l_33_3), 0, 0, 1)
		Application:draw_line(l_33_2, l_33_2 + l_33_9[2]:rotate_with(l_33_3), 0, 0, 1)
		Application:draw_line(l_33_2, l_33_2 + l_33_9[3]:rotate_with(l_33_3), 0, 0, 1)
		Application:draw_line(l_33_2, l_33_2 + l_33_9[4]:rotate_with(l_33_3), 0, 0, 1)
		Application:draw_line(l_33_2 + l_33_9[3]:rotate_with(l_33_3), l_33_2 + l_33_9[1]:rotate_with(l_33_3), 0, 0, 1)
		Application:draw_line(l_33_2 + l_33_9[1]:rotate_with(l_33_3), l_33_2 + l_33_9[2]:rotate_with(l_33_3), 0, 0, 1)
		Application:draw_line(l_33_2 + l_33_9[2]:rotate_with(l_33_3), l_33_2 + l_33_9[4]:rotate_with(l_33_3), 0, 0, 1)
		Application:draw_line(l_33_2 + l_33_9[3]:rotate_with(l_33_3), l_33_2 + l_33_9[4]:rotate_with(l_33_3), 0, 0, 1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


