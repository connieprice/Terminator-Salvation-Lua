if not CoreWorldCameraManager then
	CoreWorldCameraManager = class()
end
core:require_module("CoreScriptViewport")
CoreWorldCameraManager.init = function(l_1_0)
	l_1_0._camera = World:create_camera()
	l_1_0:set_default_fov(75)
	l_1_0:set_fov(l_1_0._default_fov)
	l_1_0:set_default_dof(150, 10000)
	l_1_0._current_near_dof = l_1_0._default_near_dof
	l_1_0._current_far_dof = l_1_0._default_far_dof
	l_1_0._default_dof_padding = 100
	l_1_0._current_dof_padding = l_1_0._default_dof_padding
	l_1_0._default_dof_clamp = 1
	l_1_0._current_dof_clamp = l_1_0._default_dof_clamp
	l_1_0:set_dof(l_1_0._default_near_dof, l_1_0._default_far_dof)
	l_1_0._camera:set_near_range(7.5)
	l_1_0._camera:set_far_range(200000)
	l_1_0._viewport = CoreScriptViewport.ScriptViewport:new(0, 0, 1, 1)
	l_1_0._director = l_1_0._viewport:director()
	l_1_0._shaker = l_1_0._director:shaker()
	l_1_0._camera_controller = l_1_0._director:make_camera(l_1_0._camera, "world_camera")
	l_1_0._viewport:set_camera(l_1_0._camera)
	l_1_0._director:set_camera(l_1_0._camera_controller)
	l_1_0._director:position_as(l_1_0._camera)
	l_1_0:_create_listener()
	l_1_0._use_gui = true
	Overlay:newgui():preload("core_world_camera")
	l_1_0._workspace = Overlay:newgui():create_screen_workspace(0, 0, 1, 1)
	l_1_0._gui = l_1_0._workspace:panel():gui("core_world_camera")
	l_1_0._gui_visible = nil
	l_1_0:_set_gui_visible(false)
	l_1_0:_clear_callback_lists()
	l_1_0:_set_dof_effect()
	l_1_0:clear()
end

CoreWorldCameraManager.use_gui = function(l_2_0)
	return l_2_0._use_gui
end

CoreWorldCameraManager._create_listener = function(l_3_0)
	l_3_0._listener_id = managers.listener:add_listener("world_camera", l_3_0._camera)
	l_3_0._listener_activation_id = nil
	local l_3_1, l_3_2 = managers.listener:add_set, managers.listener
	local l_3_3 = "world_camera"
	do
		local l_3_4 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_3_1(l_3_2, l_3_3, l_3_4)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreWorldCameraManager.set_default_fov = function(l_4_0, l_4_1)
	l_4_0._default_fov = l_4_1
end

CoreWorldCameraManager.default_fov = function(l_5_0)
	return l_5_0._default_fov
end

CoreWorldCameraManager.set_fov = function(l_6_0, l_6_1)
	l_6_0._camera:set_fov(l_6_1)
end

CoreWorldCameraManager.set_default_dof = function(l_7_0, l_7_1, l_7_2)
	l_7_0._default_near_dof = l_7_1
	l_7_0._default_far_dof = l_7_2
end

CoreWorldCameraManager.default_near_dof = function(l_8_0)
	return l_8_0._default_near_dof
end

CoreWorldCameraManager.default_far_dof = function(l_9_0)
	return l_9_0._default_far_dof
end

CoreWorldCameraManager.set_dof = function(l_10_0, l_10_1)
end

CoreWorldCameraManager.default_dof_padding = function(l_11_0)
	return l_11_0._default_dof_padding
end

CoreWorldCameraManager.default_dof_clamp = function(l_12_0)
	return l_12_0._default_dof_clamp
end

CoreWorldCameraManager._set_dof_effect = function(l_13_0)
	l_13_0._dof = {}
	l_13_0._dof.update_callback = "update_world_camera"
	l_13_0._dof.near_min = l_13_0:default_near_dof()
	l_13_0._dof.near_max = l_13_0:default_near_dof()
	l_13_0._dof.far_min = l_13_0:default_far_dof()
	l_13_0._dof.far_max = l_13_0:default_far_dof()
	l_13_0._dof.clamp = 1
	l_13_0._dof.prio = 1
	l_13_0._dof.name = "world_camera"
	l_13_0._dof.fade_in = 0.5
	l_13_0._dof.fade_out = 0.5
end

CoreWorldCameraManager.destroy = function(l_14_0)
	l_14_0:_destroy_listener()
	if l_14_0._viewport then
		l_14_0._viewport:destroy()
		l_14_0._viewport = nil
	end
	if alive(l_14_0._camera) then
		World:delete_camera(l_14_0._camera)
		l_14_0._camera = nil
	end
	if alive(l_14_0._workspace) then
		Overlay:newgui():destroy_workspace(l_14_0._workspace)
		l_14_0._workspace = nil
	end
end

CoreWorldCameraManager._destroy_listener = function(l_15_0)
	if l_15_0._listener_id then
		managers.listener:remove_listener(l_15_0._listener_id)
		managers.listener:remove_set("world_camera")
		l_15_0._listener_id = nil
	end
end

CoreWorldCameraManager.stop_simulation = function(l_16_0)
	l_16_0:_clear_callback_lists()
end

CoreWorldCameraManager._clear_callback_lists = function(l_17_0)
	l_17_0._last_world_camera_done_callback_id = {}
	l_17_0._world_camera_done_callback_list = {}
	l_17_0._last_sequence_done_callback_id = {}
	l_17_0._sequence_done_callback_list = {}
	l_17_0._last_sequence_camera_clip_callback_id = {}
	l_17_0._sequence_camera_clip_callback_list = {}
end

CoreWorldCameraManager.clear = function(l_18_0)
	l_18_0._world_cameras = {}
	l_18_0._world_camera_sequences = {}
	l_18_0._current_world_camera = nil
end

CoreWorldCameraManager.current_world_camera = function(l_19_0)
	return l_19_0._current_world_camera
end

CoreWorldCameraManager.save = function(l_20_0, l_20_1)
	local l_20_6, l_20_7 = nil
	local l_20_2 = File:open(l_20_1, "w")
	l_20_2:puts("<world_cameras>")
	for i_0,i_1 in pairs(l_20_0._world_cameras) do
		l_20_2:puts("\t" .. "<world_camera name=\"" .. l_20_8 .. "\" duration=\"" .. i_1:duration() .. "\" delay=\"" .. i_1:delay() .. "\" in_acc=\"" .. i_1:in_acc() .. "\" out_acc=\"" .. i_1:out_acc() .. "\">")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		i_1:save(l_20_2, "\t")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_20_2:puts("\t" .. "</world_camera>")
	end
	l_20_2:puts(save_value_string(l_20_0, "_world_camera_sequences", "\t"))
	l_20_2:puts("</world_cameras>")
	File:close(l_20_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldCameraManager.load = function(l_21_0, l_21_1, l_21_2)
	local l_21_7, l_21_8, l_21_9, l_21_11, l_21_12 = nil
	do
		local l_21_3 = File:parse_xml(l_21_1)
		for i_0 in l_21_3:children() do
			do
				if i_0:name() == "world_camera" then
					if not rawget(_G, "WorldCamera") then
						l_21_0._world_cameras[i_0:parameter("name")] = rawget(_G, "CoreWorldCamera"):new(i_0:parameter("name"))
						l_21_0._world_cameras[i_0:parameter("name")]:load(l_21_10)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				else
					local l_21_13 = nil
					l_21_0[parse_value_node(l_21_10)] = l_21_10
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 26 
end

CoreWorldCameraManager.update = function(l_22_0, l_22_1, l_22_2)
	if l_22_0._current_world_camera then
		l_22_0._current_world_camera:update(l_22_1, l_22_2)
	end
end

CoreWorldCameraManager._set_gui_visible = function(l_23_0, l_23_1)
	if l_23_0._gui_visible ~= l_23_1 then
		if l_23_1 and l_23_0._use_gui then
			l_23_0._workspace:show()
		else
			l_23_0._workspace:hide()
			l_23_0._gui_visible = l_23_1
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreWorldCameraManager.add_world_camera_done_callback = function(l_24_0, l_24_1, l_24_2)
	l_24_0._last_world_camera_done_callback_id[l_24_1] = l_24_0._last_world_camera_done_callback_id[l_24_1] or 0
	l_24_0._last_world_camera_done_callback_id[l_24_1] = l_24_0._last_world_camera_done_callback_id[l_24_1] + 1
	if not l_24_0._world_camera_done_callback_list[l_24_1] then
		l_24_0._world_camera_done_callback_list[l_24_1] = {}
	end
	l_24_0._world_camera_done_callback_list[l_24_1][l_24_0._last_world_camera_done_callback_id[l_24_1]] = l_24_2
	return l_24_0._last_world_camera_done_callback_id[l_24_1]
end

CoreWorldCameraManager.remove_world_camera_done_callback = function(l_25_0, l_25_1, l_25_2)
	l_25_0._world_camera_done_callback_list[l_25_1][l_25_2] = nil
end

CoreWorldCameraManager.add_sequence_done_callback = function(l_26_0, l_26_1, l_26_2)
	l_26_0._last_sequence_done_callback_id[l_26_1] = l_26_0._last_sequence_done_callback_id[l_26_1] or 0
	l_26_0._last_sequence_done_callback_id[l_26_1] = l_26_0._last_sequence_done_callback_id[l_26_1] + 1
	if not l_26_0._sequence_done_callback_list[l_26_1] then
		l_26_0._sequence_done_callback_list[l_26_1] = {}
	end
	l_26_0._sequence_done_callback_list[l_26_1][l_26_0._last_sequence_done_callback_id[l_26_1]] = l_26_2
	return l_26_0._last_sequence_done_callback_id[l_26_1]
end

CoreWorldCameraManager.remove_sequence_done_callback = function(l_27_0, l_27_1, l_27_2)
	l_27_0._sequence_done_callback_list[l_27_1][l_27_2] = nil
end

CoreWorldCameraManager.add_sequence_camera_clip_callback = function(l_28_0, l_28_1, l_28_2, l_28_3)
	l_28_0._last_sequence_camera_clip_callback_id[l_28_1] = l_28_0._last_sequence_camera_clip_callback_id[l_28_1] or 0
	l_28_0._last_sequence_camera_clip_callback_id[l_28_1] = l_28_0._last_sequence_camera_clip_callback_id[l_28_1] + 1
	if not l_28_0._sequence_camera_clip_callback_list[l_28_1] then
		l_28_0._sequence_camera_clip_callback_list[l_28_1] = {}
	end
	if not l_28_0._sequence_camera_clip_callback_list[l_28_1][l_28_2] then
		l_28_0._sequence_camera_clip_callback_list[l_28_1][l_28_2] = {}
	end
	l_28_0._sequence_camera_clip_callback_list[l_28_1][l_28_2][l_28_0._last_sequence_camera_clip_callback_id[l_28_1]] = l_28_3
	return l_28_0._last_sequence_camera_clip_callback_id[l_28_1]
end

CoreWorldCameraManager.remove_sequence_camera_clip_callback = function(l_29_0, l_29_1, l_29_2, l_29_3)
	l_29_0._sequence_camera_clip_callback_list[l_29_1][l_29_2][l_29_3] = nil
end

CoreWorldCameraManager.create_world_camera = function(l_30_0, l_30_1)
	if not rawget(_G, "WorldCamera") then
		l_30_0._world_cameras[l_30_1] = rawget(_G, "CoreWorldCamera"):new(l_30_1)
		return l_30_0._world_cameras[l_30_1]
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 12 
end

CoreWorldCameraManager.remove_world_camera = function(l_31_0, l_31_1)
	l_31_0._world_cameras[l_31_1] = nil
end

CoreWorldCameraManager.all_world_cameras = function(l_32_0)
	return l_32_0._world_cameras
end

CoreWorldCameraManager.world_camera = function(l_33_0, l_33_1)
	return l_33_0._world_cameras[l_33_1]
end

CoreWorldCameraManager.play_world_camera = function(l_34_0, l_34_1)
	do
		local l_34_2 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_34_0:_camera_sequence_table(l_34_1)()
	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreWorldCameraManager.new_play_world_camera = function(l_35_0, l_35_1)
	local l_35_2 = l_35_0._world_cameras[l_35_1.name]
	if l_35_2 then
		if l_35_0._current_world_camera then
			l_35_0._current_world_camera:stop()
		end
		l_35_0._current_world_camera = l_35_2
		local l_35_3, l_35_4 = l_35_0._current_world_camera:play(l_35_1)
		if not l_35_3 then
			if Application:editor() then
				managers.editor:output_error(l_35_4)
			end
			l_35_0:stop_world_camera()
			return 
		end
	else
		Application:error("WorldCamera named", l_35_1.name, "did not exist.")
	end
end

CoreWorldCameraManager.stop_world_camera = function(l_36_0)
	local l_36_5, l_36_6, l_36_7, l_36_8, l_36_9, l_36_10, l_36_11, l_36_12, l_36_17, l_36_18, l_36_19 = nil
	if not l_36_0._current_world_camera then
		return 
	end
	local l_36_1 = l_36_0._current_world_camera
	l_36_1:stop()
	if l_36_0._current_sequence then
		if l_36_0._sequence_camera_clip_callback_list[l_36_0._current_sequence_name] and l_36_0._sequence_camera_clip_callback_list[l_36_0._current_sequence_name][l_36_0._sequence_index] then
			for i_0,i_1 in pairs(l_36_0._sequence_camera_clip_callback_list[l_36_0._current_sequence_name][l_36_0._sequence_index]) do
				l_36_0:remove_sequence_camera_clip_callback(l_36_0._current_sequence_name, l_36_0._sequence_index, i_0)
				i_1(l_36_0._current_sequence_name, l_36_0._sequence_index, i_0)
			end
		end
		if l_36_0._sequence_index < #l_36_0._current_sequence then
			l_36_0._sequence_index = l_36_0._sequence_index + 1
			l_36_0:new_play_world_camera(l_36_0._current_sequence[l_36_0._sequence_index])
		end
	else
		l_36_0._current_world_camera = nil
		l_36_0:_sequence_done()
	end
	if l_36_0._world_camera_done_callback_list[l_36_1:name()] then
		local l_36_16 = pairs
		l_36_16 = l_36_16(l_36_0._world_camera_done_callback_list[l_36_1:name()])
		for i_0,i_1 in l_36_16 do
			l_36_0:remove_world_camera_done_callback(l_36_1:name(), l_36_15)
			i_1(l_36_1, l_36_15)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreWorldCameraManager.create_world_camera_sequence = function(l_37_0, l_37_1)
	l_37_0._world_camera_sequences[l_37_1] = {}
	return l_37_0._world_camera_sequences[l_37_1]
end

CoreWorldCameraManager.remove_world_camera_sequence = function(l_38_0, l_38_1)
	l_38_0._world_camera_sequences[l_38_1] = nil
end

CoreWorldCameraManager.all_world_camera_sequences = function(l_39_0)
	return l_39_0._world_camera_sequences
end

CoreWorldCameraManager.world_camera_sequence = function(l_40_0, l_40_1)
	return l_40_0._world_camera_sequences[l_40_1]
end

CoreWorldCameraManager.add_camera_to_sequence = function(l_41_0, l_41_1, l_41_2)
	local l_41_3 = l_41_0._world_camera_sequences[l_41_1]
	if not l_41_3 then
		Application:error("World camera sequence named", l_41_1, "did not exist.")
		return 
	end
	table.insert(l_41_3, l_41_0:_camera_sequence_table(l_41_2))
	return #l_41_3
end

CoreWorldCameraManager.insert_camera_to_sequence = function(l_42_0, l_42_1, l_42_2, l_42_3)
	local l_42_4 = l_42_0._world_camera_sequences[l_42_1]
	if not l_42_4 then
		Application:error("World camera sequence named", l_42_1, "did not exist.")
		return 
	end
	table.insert(l_42_4, l_42_3, l_42_2)
	return #l_42_4
end

CoreWorldCameraManager.remove_camera_from_sequence = function(l_43_0, l_43_1, l_43_2)
	local l_43_3 = l_43_0._world_camera_sequences[l_43_1]
	local l_43_4 = l_43_3[l_43_2]
	table.remove(l_43_3, l_43_2)
	return l_43_4
end

CoreWorldCameraManager._camera_sequence_table = function(l_44_0, l_44_1)
	local l_44_2 = {}
	l_44_2.name = l_44_1
	l_44_2.start = 0
	l_44_2.stop = 1
	return l_44_2
end

CoreWorldCameraManager._break_sequence = function(l_45_0)
	if l_45_0._current_sequence then
		l_45_0:_sequence_done()
	end
end

CoreWorldCameraManager._sequence_done = function(l_46_0)
	local l_46_6, l_46_7, l_46_8, l_46_9, l_46_10, l_46_11, l_46_12, l_46_13 = nil
	l_46_0:_set_listener_enabled(false)
	l_46_0:_reset_old_viewports()
	l_46_0:stop_dof()
	l_46_0:_set_gui_visible(false)
	managers.sound_environment:set_check_object_active(l_46_0._sound_environment_check_object, false)
	local l_46_1 = l_46_0._current_sequence
	local l_46_2 = l_46_0._current_sequence_name
	l_46_0._current_sequence = nil
	l_46_0._current_sequence_name = nil
	if l_46_0._sequence_done_callback_list[l_46_2] then
		for i_0,i_1 in pairs(l_46_0._sequence_done_callback_list[l_46_2]) do
			l_46_0:remove_sequence_done_callback(l_46_2, i_0)
			i_1(l_46_1, i_0)
		end
	end
end

CoreWorldCameraManager.play_world_camera_sequence = function(l_47_0, l_47_1, l_47_2)
	l_47_0:_break_sequence()
	do
		local l_47_3, l_47_4, l_47_5, l_47_6, l_47_7, l_47_11, l_47_12, l_47_13, l_47_14, l_47_15, l_47_16, l_47_17 = l_47_0._world_camera_sequences[l_47_1] or l_47_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_47_3 then
		Application:error("World camaera sequence named", l_47_1, "did not exist.")
		return 
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if #l_47_3 == 0 then
		Application:error("World camaera sequence named", l_47_1, "did not have any cameras.")
		return 
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_47_0._current_sequence = l_47_3
	l_47_0._current_sequence_name = l_47_1
	if not l_47_0._sound_environment_check_object then
		local l_47_8, l_47_9 = , managers.sound_environment:add_check_object
		local l_47_10 = managers.sound_environment
		l_47_9 = l_47_9(l_47_10, {object = l_47_0._camera, active = false, primary = true})
		l_47_0._sound_environment_check_object = l_47_9
	end
	managers.sound_environment:set_check_object_active(l_47_0._sound_environment_check_object, true)
	l_47_0:_save_old_viewports()
	l_47_0:_use_vp()
	l_47_0:_set_gui_visible(true)
	l_47_0:_set_listener_enabled(true)
	l_47_0:start_dof()
	l_47_0._sequence_index = 1
	l_47_0:new_play_world_camera(l_47_0._current_sequence[l_47_0._sequence_index])
end

CoreWorldCameraManager._save_old_viewports = function(l_48_0)
	managers.viewport:push()
end

CoreWorldCameraManager._use_vp = function(l_49_0)
	managers.viewport:deactivate_all_viewports()
	l_49_0:viewport():set_active(true)
end

CoreWorldCameraManager._reset_old_viewports = function(l_50_0)
	l_50_0:viewport():set_active(false)
	managers.viewport:pop()
end

CoreWorldCameraManager._set_listener_enabled = function(l_51_0, l_51_1)
	if l_51_1 and not l_51_0._listener_activation_id then
		l_51_0._listener_activation_id = managers.listener:activate_set("main", "world_camera")
	end
	do return end
	if l_51_0._listener_activation_id then
		managers.listener:deactivate_set(l_51_0._listener_activation_id)
		l_51_0._listener_activation_id = nil
	end
end

CoreWorldCameraManager.start_dof = function(l_52_0)
	if not l_52_0._using_dof then
		l_52_0._using_dof = true
		managers.DOF:play_dof_effect(l_52_0._dof)
	end
end

CoreWorldCameraManager.stop_dof = function(l_53_0)
	managers.DOF:stop_dof_effect("world_camera")
	l_53_0._using_dof = false
end

CoreWorldCameraManager.using_dof = function(l_54_0)
	return l_54_0._using_dof
end

CoreWorldCameraManager.update_dof_values = function(l_55_0, l_55_1, l_55_2, l_55_3, l_55_4)
	l_55_0._current_near_dof = l_55_1
	l_55_0._current_far_dof = l_55_2
	l_55_0._current_dof_padding = l_55_3
	l_55_0._current_dof_clamp = l_55_4
end

CoreWorldCameraManager.update_dof = function(l_56_0, l_56_1, l_56_2, l_56_3)
	local l_56_4 = l_56_3.data
	l_56_4.near_min = l_56_0._current_near_dof
	l_56_4.near_max = l_56_0._current_near_dof - l_56_0._current_dof_padding
	l_56_4.far_min = l_56_0._current_far_dof
	l_56_4.far_max = l_56_0._current_far_dof + l_56_0._current_dof_padding
	l_56_4.clamp = l_56_0._current_dof_clamp
end

CoreWorldCameraManager.viewport = function(l_57_0)
	return l_57_0._viewport
end

CoreWorldCameraManager.director = function(l_58_0)
	return l_58_0._director
end

CoreWorldCameraManager.workspace = function(l_59_0)
	return l_59_0._workspace
end

CoreWorldCameraManager.camera = function(l_60_0)
	return l_60_0._camera
end

CoreWorldCameraManager.camera_controller = function(l_61_0)
	return l_61_0._camera_controller
end

if not CoreWorldCamera then
	CoreWorldCamera = class()
end
CoreWorldCamera.init = function(l_62_0, l_62_1)
	l_62_0._world_camera_name = l_62_1
	l_62_0._points = {}
	l_62_0._positions = {}
	l_62_0._target_positions = {}
	l_62_0._duration = 2.5
	l_62_0._delay = 0
	l_62_0._playing = false
	l_62_0._target_offest = 1000
	l_62_0._in_accelerations = {}
	l_62_0._out_accelerations = {}
	l_62_0._in_accelerations.linear = 0.33
	l_62_0._out_accelerations.linear = 0.66
	l_62_0._in_accelerations.ease = 0
	l_62_0._out_accelerations.ease = 1
	l_62_0._in_accelerations.fast = 0.5
	l_62_0._out_accelerations.fast = 0.5
	l_62_0._in_acc = l_62_0._in_accelerations.linear
	l_62_0._out_acc = l_62_0._out_accelerations.linear
	l_62_0._old_viewport = nil
	l_62_0._keys = {}
	local l_62_2 = 0
	local l_62_3 = managers.worldcamera:default_fov()
	local l_62_4 = managers.worldcamera:default_near_dof()
	local l_62_5 = managers.worldcamera:default_far_dof()
	local l_62_6 = table.insert
	local l_62_7 = l_62_0._keys
	local l_62_8 = {}
	l_62_8.time = l_62_2
	l_62_8.fov = l_62_3
	l_62_8.near_dof = l_62_4
	l_62_8.far_dof = l_62_5
	l_62_6(l_62_7, l_62_8)
	l_62_6 = managers
	l_62_6 = l_62_6.worldcamera
	l_62_6, l_62_7 = l_62_6:default_dof_padding, l_62_6
	l_62_6 = l_62_6(l_62_7)
	l_62_0._dof_padding = l_62_6
	l_62_6 = managers
	l_62_6 = l_62_6.worldcamera
	l_62_6, l_62_7 = l_62_6:default_dof_clamp, l_62_6
	l_62_6 = l_62_6(l_62_7)
	l_62_0._dof_clamp = l_62_6
end

CoreWorldCamera.save = function(l_63_0, l_63_1, l_63_2)
	l_63_2 = l_63_2 .. "\t"
	l_63_1:puts(save_value_string(l_63_0, "_positions", l_63_2))
	l_63_1:puts(save_value_string(l_63_0, "_target_positions", l_63_2))
	l_63_1:puts(save_value_string(l_63_0, "_keys", l_63_2))
	l_63_1:puts(save_value_string(l_63_0, "_dof_padding", l_63_2))
	l_63_1:puts(save_value_string(l_63_0, "_dof_clamp", l_63_2))
end

CoreWorldCamera.load = function(l_64_0, l_64_1)
	l_64_0._duration = tonumber(l_64_1:parameter("duration"))
	l_64_0._delay = tonumber(l_64_1:parameter("delay"))
	if l_64_1:has_parameter("in_acc") then
		l_64_0._in_acc = tonumber(l_64_1:parameter("in_acc"))
	end
	if l_64_1:has_parameter("out_acc") then
		local l_64_5, l_64_6, l_64_7, l_64_8, l_64_14, l_64_15, l_64_16 = tonumber, l_64_1:parameter("out_acc"), .end
		l_64_5 = l_64_5(l_64_6, l_64_7, l_64_8, l_64_14, l_64_15, l_64_16)
		l_64_0._out_acc = l_64_5
	end
	for i_0 in l_64_1:children() do
		do
			if i_0:name() == "point" then
				local l_64_9 = tonumber(i_0:parameter("index"))
				for i_0 in l_64_13:children() do
					if i_0:name() == "pos" then
						l_64_0._positions[l_64_9] = math.string_to_vector(i_0:parameter("value"))
					else
						if i_0:name() == "t_pos" then
							l_64_0._target_positions[l_64_9] = math.string_to_vector(i_0:parameter("value"))
						end
					end
				end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			if l_64_13:name() == "value" then
				local l_64_17 = nil
				l_64_0[parse_value_node(l_64_13)] = l_64_13
			end
		end
	end
end

CoreWorldCamera.duration = function(l_65_0)
	return l_65_0._duration
end

CoreWorldCamera.set_duration = function(l_66_0, l_66_1)
	l_66_0._duration = l_66_1
end

CoreWorldCamera.duration = function(l_67_0)
	return l_67_0._duration
end

CoreWorldCamera.set_delay = function(l_68_0, l_68_1)
	l_68_0._delay = l_68_1
end

CoreWorldCamera.delay = function(l_69_0)
	return l_69_0._delay
end

CoreWorldCamera.set_dof_padding = function(l_70_0, l_70_1)
	l_70_0._dof_padding = l_70_1
end

CoreWorldCamera.dof_padding = function(l_71_0)
	return l_71_0._dof_padding
end

CoreWorldCamera.set_dof_clamp = function(l_72_0, l_72_1)
	l_72_0._dof_clamp = l_72_1
end

CoreWorldCamera.dof_clamp = function(l_73_0)
	return l_73_0._dof_clamp
end

CoreWorldCamera.name = function(l_74_0)
	return l_74_0._world_camera_name
end

CoreWorldCamera.in_acc = function(l_75_0)
	return l_75_0._in_acc
end

CoreWorldCamera.out_acc = function(l_76_0)
	return l_76_0._out_acc
end

CoreWorldCamera.in_acc_string = function(l_77_0)
	local l_77_4, l_77_5, l_77_6 = nil
	for i_0,i_1 in pairs(l_77_0._in_accelerations) do
		if i_1 == l_77_0._in_acc then
			return i_0
		end
	end
end

CoreWorldCamera.out_acc_string = function(l_78_0)
	local l_78_4, l_78_5, l_78_6 = nil
	for i_0,i_1 in pairs(l_78_0._out_accelerations) do
		if i_1 == l_78_0._out_acc then
			return i_0
		end
	end
end

CoreWorldCamera.set_in_acc = function(l_79_0, l_79_1)
	l_79_0._in_acc = l_79_0._in_accelerations[l_79_1]
end

CoreWorldCamera.set_out_acc = function(l_80_0, l_80_1)
	l_80_0._out_acc = l_80_0._out_accelerations[l_80_1]
end

CoreWorldCamera.positions_at_time = function(l_81_0, l_81_1)
	local l_81_2 = math.bezier
	local l_81_3 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_81_3 or l_81_3 then
		local l_81_4 = l_81_3(l_81_0._in_acc, l_81_0._out_acc)
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_81_5 = l_81_3(l_81_0._target_positions, 1)
		return l_81_4, l_81_5
	end
	return l_81_0._positions[1], l_81_0._target_positions[1]
end

CoreWorldCamera.update = function(l_82_0, l_82_1, l_82_2)
	if l_82_0._timer < l_82_0._stop_timer then
		l_82_0._timer = l_82_0._timer + l_82_2 / l_82_0._duration
		local l_82_3, l_82_4 = l_82_0:positions_at_time(l_82_0._timer)
		l_82_0:update_camera(l_82_3, l_82_4)
		l_82_0:set_current_fov(l_82_0:value_at_time(l_82_0._timer, "fov"))
		local l_82_5 = l_82_0:value_at_time(l_82_0._timer, "near_dof")
		local l_82_6 = l_82_0:value_at_time(l_82_0._timer, "far_dof")
		l_82_0:update_dof_values(l_82_5, l_82_6, l_82_0._dof_padding, l_82_0._dof_clamp)
	elseif l_82_0._delay > 0 and l_82_0._delay_timer < 1 then
		l_82_0._delay_timer = l_82_0._delay_timer + l_82_2 / l_82_0._delay
	else
		managers.worldcamera:stop_world_camera()
	end
end

CoreWorldCamera.update_dof_values = function(l_83_0, ...)
	managers.worldcamera:update_dof_values(...)
end

CoreWorldCamera.set_current_fov = function(l_84_0, l_84_1)
	managers.worldcamera:set_fov(l_84_1)
end

CoreWorldCamera.play = function(l_85_0, l_85_1)
	if #l_85_0._positions == 0 then
		return false, "Camera " .. l_85_0._world_camera_name .. " didn't have any points."
	end
	if l_85_0._duration == 0 then
		return false, "Camera " .. l_85_0._world_camera_name .. " has duration 0, must be higher."
	end
	l_85_0._timer = l_85_1.start or 0
	l_85_0._stop_timer = l_85_1.stop or 1
	l_85_0._delay_timer = 0
	l_85_0._index = 1
	l_85_0._target_point = nil
	l_85_0._playing = true
	l_85_0._bezier = l_85_0:bezier_function()
	l_85_0:update_camera(l_85_0._positions[1], l_85_0._target_positions[1])
	l_85_0:set_current_fov(l_85_0:value_at_time(l_85_0._timer, "fov"))
	return true
end

CoreWorldCamera.stop = function(l_86_0)
	l_86_0._playing = false
	l_86_0._bezier = nil
end

CoreWorldCamera.bezier_function = function(l_87_0)
	if #l_87_0._positions == 2 then
		return math.linear_bezier
	else
		if #l_87_0._positions == 3 then
			return math.quadratic_bezier
		end
	else
		if #l_87_0._positions == 4 then
			return math.bezier
		end
	end
	return nil
end

CoreWorldCamera.update_camera = function(l_88_0, l_88_1, l_88_2)
	managers.worldcamera:camera_controller():set_camera(l_88_1)
	managers.worldcamera:camera_controller():set_target(l_88_2)
end

CoreWorldCamera.add_point = function(l_89_0, l_89_1, l_89_2)
	if #l_89_0._positions < 4 then
		table.insert(l_89_0._positions, l_89_1)
		table.insert(l_89_0._target_positions, l_89_1 + l_89_2:y() * l_89_0._target_offest)
	end
end

CoreWorldCamera.get_points = function(l_90_0)
	return l_90_0._positions
end

CoreWorldCamera.get_point = function(l_91_0, l_91_1)
	local l_91_2 = {}
	l_91_2.pos = l_91_0._positions[l_91_1]
	l_91_2.t_pos = l_91_0._target_positions[l_91_1]
	return l_91_2
end

CoreWorldCamera.delete_point = function(l_92_0, l_92_1)
	table.remove(l_92_0._positions, l_92_1)
	table.remove(l_92_0._target_positions, l_92_1)
end

CoreWorldCamera.move_point = function(l_93_0, l_93_1, l_93_2, l_93_3)
	local l_93_4 = l_93_2 + l_93_3:y() * l_93_0._target_offest
	l_93_0._positions[l_93_1] = l_93_2
	l_93_0._target_positions[l_93_1] = l_93_4
end

CoreWorldCamera.positions = function(l_94_0)
	return l_94_0._positions
end

CoreWorldCamera.target_positions = function(l_95_0)
	return l_95_0._target_positions
end

CoreWorldCamera.insert_point = function(l_96_0, l_96_1, l_96_2, l_96_3)
end

CoreWorldCamera.keys = function(l_97_0)
	return l_97_0._keys
end

CoreWorldCamera.key = function(l_98_0, l_98_1)
	return l_98_0._keys[l_98_1]
end

CoreWorldCamera.next_key = function(l_99_0, l_99_1)
	local l_99_6, l_99_7, l_99_8 = nil
	local l_99_2 = 1
	for i_0,i_1 in ipairs(l_99_0._keys) do
		if i_1.time <= l_99_1 then
			l_99_2 = i_0 + 1
		end
	end
	if #l_99_0._keys < l_99_2 then
		l_99_2 = #l_99_0._keys
	end
	return l_99_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldCamera.prev_key = function(l_100_0, l_100_1, l_100_2)
	local l_100_7, l_100_8, l_100_9, l_100_10, l_100_11, l_100_12 = nil
	local l_100_3 = 1
	for i_0,i_1 in ipairs(l_100_0._keys) do
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_100_2 and i_1.time < l_100_1 then
			l_100_3 = i_0
		end
		for i_0,i_1 in l_100_4 do
			if i_1.time <= l_100_1 then
				l_100_3 = i_0
			end
		end
		return l_100_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreWorldCamera.add_key = function(l_101_0, l_101_1)
	local l_101_2 = 1
	local l_101_3, l_101_4, l_101_5 = nil, nil, nil
	l_101_3 = math.round(l_101_0:value_at_time(l_101_1, "fov"))
	l_101_4 = math.round(l_101_0:value_at_time(l_101_1, "near_dof"))
	local l_101_10, l_101_11 = math.round, l_101_0:value_at_time(l_101_1, "far_dof")
	l_101_10 = l_101_10(l_101_11)
	l_101_5 = l_101_10
	local l_101_6 = nil
	l_101_11 = ipairs
	l_101_6 = l_101_0._keys
	l_101_11 = l_101_11(l_101_6)
	for i_0,i_1 in l_101_11 do
		if l_101_9.time == l_101_1 then
			l_101_0._keys[l_101_8] = l_101_9
			return l_101_8, l_101_9
		elseif l_101_9.time < l_101_1 then
			l_101_2 = l_101_8 + 1
		end
	end
	table.insert(l_101_0._keys, l_101_2, l_101_10)
	return l_101_2, l_101_10
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldCamera.delete_key = function(l_102_0, l_102_1)
	table.remove(l_102_0._keys, l_102_1)
end

CoreWorldCamera.move_key = function(l_103_0, l_103_1, l_103_2)
	local l_103_3 = clone(l_103_0._keys[l_103_1])
	l_103_0:delete_key(l_103_1)
	local l_103_4, l_103_5 = l_103_0:add_key(l_103_2)
	l_103_5.fov = l_103_3.fov
	l_103_5.near_dof = l_103_3.near_dof
	l_103_5.far_dof = l_103_3.far_dof
	return l_103_4
end

CoreWorldCamera.value_at_time = function(l_104_0, l_104_1, l_104_2)
	local l_104_3 = l_104_0:prev_value_key(l_104_1, l_104_2)
	local l_104_4 = l_104_0:next_value_key(l_104_1, l_104_2)
	local l_104_5 = 1
	if l_104_4.time - l_104_3.time ~= 0 then
		l_104_5 = (l_104_1 - l_104_3.time) / (l_104_4.time - l_104_3.time)
	end
	return (l_104_4[l_104_2] - l_104_3[l_104_2]) * (l_104_5) + l_104_3[l_104_2]
end

CoreWorldCamera.prev_value_key = function(l_105_0, l_105_1, l_105_2)
	local l_105_3 = l_105_0:prev_key(l_105_1)
	local l_105_4 = l_105_0._keys[l_105_3]
	if l_105_4[l_105_2] then
		return l_105_4
	end
	do return end
	local l_105_5, l_105_6 = l_105_0:prev_value_key, l_105_0
	local l_105_7 = l_105_4.time
	local l_105_8 = l_105_2
	return l_105_5(l_105_6, l_105_7, l_105_8)
end

CoreWorldCamera.next_value_key = function(l_106_0, l_106_1, l_106_2)
	local l_106_3 = l_106_0:next_key(l_106_1)
	local l_106_4 = l_106_0._keys[l_106_3]
	if l_106_4[l_106_2] then
		return l_106_4
	end
	do return end
	local l_106_5, l_106_6 = l_106_0:next_value_key, l_106_0
	local l_106_7 = l_106_4.time
	local l_106_8 = l_106_2
	return l_106_5(l_106_6, l_106_7, l_106_8)
end

CoreWorldCamera.print_points = function(l_107_0)
	for l_107_4 = 1, 4 do
		cat_print("debug", l_107_4, l_107_0._positions[l_107_4], l_107_0._target_positions[l_107_4])
	end
end

CoreWorldCamera.playing = function(l_108_0)
	return l_108_0._playing
end


