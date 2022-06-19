core:require_module("CoreScriptViewport")
CoreFreeFlight = CoreFreeFlight or class()
function CoreFreeFlight.init(A0_0)
	A0_0._active = false
	A0_0._update = true
	A0_0._all_update = true
	A0_0._freeflight_locked = false
	A0_0._ff_vp = CoreScriptViewport.ScriptViewport:new(0, 0, 1, 1)
	World:create_camera():set_near_range(20)
	World:create_camera():set_far_range(600000)
	World:create_camera():set_fov(75)
	A0_0._freeze_camera = World:create_camera()
	A0_0._freeze_camera:set_near_range(20)
	A0_0._freeze_camera:set_far_range(600000)
	A0_0._freeze_camera:set_fov(75)
	A0_0._camera = World:create_camera()
	A0_0._ff_vp:set_camera(A0_0._freeze_camera)
	A0_0._listener_id = managers.listener:add_listener("freeflight", A0_0._freeze_camera)
	A0_0._listener_activation_id = nil
	managers.listener:add_set("freeflight", {"freeflight"})
	A0_0._freeze_camera_locked = false
	A0_0._triggers_connected = false
	A0_0._sound_environment_check_object = managers.sound_environment:add_check_object({
		object = A0_0._camera,
		active = false,
		primary = true
	})
	A0_0:set_controller()
end
function CoreFreeFlight.set_controller(A0_1)
	A0_1._controller = managers.controller:create_controller(nil, nil, true)
	A0_1._controller:disable()
	if Application:debug_build() then
		A0_1._toggle_ctrlr = Input:create_virtual_controller()
		if Input:keyboard():has_button("f9") then
			A0_1._toggle_ctrlr:connect(Input:keyboard(), "f9", "use_ff")
			A0_1._toggle_ctrlr:add_trigger("use_ff", callback(A0_1, A0_1, "toggle_ff"))
		end
		if Application:editor() then
			if Input:keyboard():has_button("f11") then
				A0_1._toggle_ctrlr:connect(Input:keyboard(), "f11", "add_point")
				A0_1._toggle_ctrlr:add_trigger("add_point", callback(A0_1, A0_1, "add_bm_point"))
			end
			if Input:keyboard():has_button("f12") then
				A0_1._toggle_ctrlr:connect(Input:keyboard(), "f12", "save_points")
				A0_1._toggle_ctrlr:add_trigger("save_points", callback(A0_1, A0_1, "save_bm_points"))
			end
		end
	end
end
function CoreFreeFlight.set_listener_enabled(A0_2, A1_3)
	if A1_3 then
		if not A0_2._listener_activation_id then
			A0_2._listener_activation_id = managers.listener:activate_set("main", "freeflight")
		end
	elseif A0_2._listener_activation_id then
		managers.listener:deactivate_set(A0_2._listener_activation_id)
		A0_2._listener_activation_id = nil
	end
end
function CoreFreeFlight.add_bm_point(A0_4)
	local L1_5
	L1_5 = A0_4._camera
	L1_5 = L1_5.new_rotation
	L1_5 = L1_5(L1_5)
	L1_5 = Rotation(L1_5:x(), -L1_5:z(), L1_5:y())
	managers.benchmark:add_point("default", Global.zone_data.load_zone, A0_4._camera:position(), L1_5)
end
function CoreFreeFlight.save_bm_points(A0_6)
	managers.benchmark:save_points()
end
function CoreFreeFlight.position_output(A0_7)
	cat_debug("debug", "<position pos_x=\"" .. A0_7._ff_vp:camera():position().x .. "\" pos_y=\"" .. A0_7._ff_vp:camera():position().y .. "\" pos_z=\"" .. A0_7._ff_vp:camera():position().z .. "\"/>")
	cat_debug("debug", "<position pos=\"" .. A0_7._ff_vp:camera():position().x .. " " .. A0_7._ff_vp:camera():position().y .. " " .. A0_7._ff_vp:camera():position().z .. "\"/>")
end
function CoreFreeFlight.get_controller(A0_8)
	local L1_9
	L1_9 = A0_8._controller
	return L1_9
end
function CoreFreeFlight.destroy(A0_10)
	if alive(A0_10._toggle_ctrlr) then
		Input:destroy_virtual_controller(A0_10._toggle_ctrlr)
		A0_10._toggle_ctrlr = nil
	end
	if A0_10._controller then
		A0_10._controller:destroy()
		A0_10._controller = nil
	end
	if A0_10._listener_id then
		managers.listener:remove_listener(A0_10._listener_id)
		managers.listener:remove_set("freeflight")
		A0_10._listener_id = nil
	end
	if managers.sound_environment:obj_alive(A0_10._sound_environment_check_object) then
		managers.sound_environment:remove_check_object(A0_10._sound_environment_check_object)
	end
	if A0_10._ff_vp then
		A0_10._ff_vp:destroy()
		A0_10._ff_vp = nil
	end
end
function CoreFreeFlight.connect_triggers(A0_11)
	A0_11._controller:enable()
	A0_11._controller:add_trigger("up", callback(A0_11, A0_11, "move_speed_up"))
	A0_11._controller:add_trigger("down", callback(A0_11, A0_11, "move_speed_down"))
	A0_11._controller:add_trigger("right", callback(A0_11, A0_11, "turn_speed_up"))
	A0_11._controller:add_trigger("left", callback(A0_11, A0_11, "turn_speed_down"))
	A0_11._controller:add_trigger("action_1", callback(A0_11, A0_11, "toggle_frustum_freeze"))
	A0_11._controller:add_trigger("action_2", callback(A0_11, A0_11, "position_output"))
	A0_11._controller:add_trigger("action_3", callback(A0_11, A0_11, "dump_units"))
	A0_11._controller:add_trigger("action_4", callback(A0_11, A0_11, "print_position"))
	A0_11._controller:add_trigger("position_output", callback(A0_11, A0_11, "position_output"))
	A0_11._controller:add_trigger("debug_spawn", callback(A0_11, A0_11, "debug_spawn"))
	A0_11._triggers_connected = true
end
function CoreFreeFlight.disconnect_triggers(A0_12)
	A0_12._controller:clear_triggers(false)
	A0_12._controller:disable()
	A0_12._triggers_connected = false
end
function CoreFreeFlight.toggle_ff(A0_13)
	if A0_13:in_focus() then
		A0_13:on_loose_focus()
	else
		A0_13:on_get_focus()
	end
end
function CoreFreeFlight.set_old_vp(A0_14, A1_15)
	A0_14._old_vp = A1_15
end
function CoreFreeFlight.on_get_focus(A0_16)
	local L1_17, L2_18
	L2_18 = A0_16
	L1_17 = A0_16.in_focus
	L1_17 = L1_17(L2_18)
	if not L1_17 then
		L1_17 = managers
		L1_17 = L1_17.editor
		if L1_17 then
			L1_17 = script_debug
			L1_17 = L1_17.running_simulation
		elseif L1_17 then
			L2_18 = A0_16
			L1_17 = A0_16.connect_triggers
			L1_17(L2_18)
			A0_16._freeze_camera_locked = false
			L1_17 = managers
			L1_17 = L1_17.viewport
			L2_18 = L1_17
			L1_17 = L1_17.first_active_viewport
			L1_17 = L1_17(L2_18)
			A0_16._old_vp = L1_17
			L1_17 = managers
			L1_17 = L1_17.viewport
			L2_18 = L1_17
			L1_17 = L1_17.push
			L1_17(L2_18)
			L1_17 = managers
			L1_17 = L1_17.viewport
			L2_18 = L1_17
			L1_17 = L1_17.deactivate_all_viewports
			L1_17(L2_18)
			L1_17 = A0_16._ff_vp
			L2_18 = L1_17
			L1_17 = L1_17.set_active
			L1_17(L2_18, true)
			L2_18 = A0_16
			L1_17 = A0_16.set_listener_enabled
			L1_17(L2_18, true)
			L1_17 = managers
			L1_17 = L1_17.sound_environment
			L2_18 = L1_17
			L1_17 = L1_17.obj_alive
			L1_17 = L1_17(L2_18, A0_16._sound_environment_check_object)
			if L1_17 then
				L1_17 = managers
				L1_17 = L1_17.sound_environment
				L2_18 = L1_17
				L1_17 = L1_17.set_check_object_active
				L1_17(L2_18, A0_16._sound_environment_check_object, true)
			end
			L1_17, L2_18 = nil, nil
			if A0_16._old_vp then
				L2_18 = A0_16._old_vp:camera():position()
				L1_17 = A0_16._old_vp:camera():new_rotation()
			else
				L2_18 = Vector3(0, 0, 300)
				L1_17 = Rotation(0, 0, 0)
			end
			A0_16:init_camera(L2_18, L1_17)
			A0_16._active = true
		end
	end
end
function CoreFreeFlight.on_loose_focus(A0_19, A1_20, A2_21, A3_22)
	if A0_19:in_focus() then
		A0_19:disconnect_triggers()
		A0_19:set_listener_enabled(false)
		if managers.sound_environment:obj_alive(A0_19._sound_environment_check_object) then
			managers.sound_environment:set_check_object_active(A0_19._sound_environment_check_object, false)
		end
		A0_19._ff_vp:set_active(false)
		managers.viewport:pop()
		A0_19._active = false
	end
end
function CoreFreeFlight.in_focus(A0_23)
	local L1_24
	L1_24 = A0_23._active
	return L1_24
end
function CoreFreeFlight.update(A0_25, A1_26, A2_27)
	if A0_25:in_focus() then
		if not A0_25._freeflight_locked then
			A0_25:update_camera(A1_26, A2_27)
		end
		if A0_25._controller:get_input_bool("action_5") then
			A0_25:inc_near_range()
		elseif A0_25._controller:get_input_bool("action_6") then
			A0_25:dec_near_range()
		end
		A0_25:draw_freeze_frustum()
	end
end
function CoreFreeFlight.toggle_lock_freeflight(A0_28, A1_29, A2_30, A3_31)
	local L4_32
	L4_32 = A0_28._freeflight_locked
	L4_32 = not L4_32
	A0_28._freeflight_locked = L4_32
end
function CoreFreeFlight.print_position(A0_33)
	cat_print("debug", "Camera position: Vector3( " .. A0_33._camera:position().x .. ", " .. A0_33._camera:position().y .. ", " .. A0_33._camera:position().z .. ")")
end
function CoreFreeFlight.debug_spawn(A0_34)
	local L1_35
	L1_35 = A0_34._camera
	L1_35 = L1_35.position
	L1_35 = L1_35(L1_35)
	if Global.debug_unit and Global.debug_unit ~= nil then
		World:spawn_unit(Global.debug_unit, L1_35)
	end
end
function CoreFreeFlight.dump_units(A0_36)
	local L1_37, L2_38, L3_39
	L1_37 = 400
	L2_38 = A0_36._camera
	L3_39 = L2_38
	L2_38 = L2_38.position
	L2_38 = L2_38(L3_39)
	L3_39 = A0_36._camera
	L3_39 = L3_39.new_rotation
	L3_39 = L3_39(L3_39)
	L3_39 = L3_39.y
	L3_39 = L3_39(L3_39)
	L3_39 = L3_39 * L1_37
	L2_38 = L2_38 + L3_39
	L3_39 = World
	L3_39 = L3_39.find_units_quick
	L3_39 = L3_39(L3_39, "sphere", L2_38, L1_37, managers.slot:get_mask("all"))
	cat_debug("debug", "Dump Units:")
	for 