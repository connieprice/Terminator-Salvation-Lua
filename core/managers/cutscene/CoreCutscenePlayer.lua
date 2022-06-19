require("core/managers/cutscene/CoreCutsceneCast")
require("core/managers/cutscene/CoreCutsceneKeyCollection")
core:require_module("CoreScriptViewport")
if not CoreCutscenePlayer then
	CoreCutscenePlayer = class()
end
mixin(CoreCutscenePlayer, get_core_or_local("CutsceneKeyCollection"))
CoreCutscenePlayer.BLACK_BAR_GUI_LAYER = 29
CoreCutscenePlayer.BLACK_BAR_TOP_GUI_NAME = "__CutscenePlayer__black_bar_top"
CoreCutscenePlayer.BLACK_BAR_BOTTOM_GUI_NAME = "__CutscenePlayer__black_bar_bottom"
CoreCutscenePlayer._all_keys_sorted_by_time = function(l_1_0)
	return l_1_0._owned_cutscene_keys
end

CoreCutscenePlayer.init = function(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0._cutscene = assert(l_2_1, "No cutscene supplied.")
	do
		if not l_2_2 then
			l_2_0._viewport = l_2_0:_create_viewport()
			if not l_2_3 then
				l_2_0._cast = l_2_0:_create_cast()
			end
			l_2_0._owned_cutscene_keys = {}
			l_2_0._time = 0
			cat_print("cutscene", string.format("[CoreCutscenePlayer] Created CutscenePlayer for \"%s\".", l_2_0:cutscene_name()))
			if not alive(l_2_0._viewport:camera()) then
				l_2_0:_create_camera()
			end
			l_2_0:_create_future_camera()
			l_2_0:_clear_workspace()
			l_2_0._resolution_changed_callback_id = managers.viewport:add_resolution_changed_func(callback(l_2_0, l_2_0, "_configure_viewport"))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 10 
end

CoreCutscenePlayer._create_future_camera = function(l_3_0)
	l_3_0._future_camera_locator = World:spawn_unit("locator", Vector3(0, 0, 0), Rotation())
	l_3_0._future_camera = World:create_camera()
	l_3_0:_initialize_camera(l_3_0._future_camera)
	l_3_0._future_camera:link(l_3_0._future_camera_locator:get_object("locator"))
	l_3_0._future_camera:new_set_local_rotation(Rotation(-90, 0, 0))
	l_3_0._cast:_reparent_to_locator_unit(l_3_0._cast:_root_unit(), l_3_0._future_camera_locator)
end

CoreCutscenePlayer.add_keys = function(l_4_0, l_4_1)
	if not l_4_1 then
		l_4_1 = l_4_0._cutscene
	end
	local l_4_5, l_4_6 = ipairs, l_4_1:_all_keys_sorted_by_time()
	l_4_5 = l_4_5(l_4_6)
	for i_0,i_1 in l_4_5 do
		if l_4_0:_is_driving_sound_key(l_4_4) then
			l_4_0:_set_driving_sound_from_key(l_4_4)
		else
			local l_4_7 = l_4_4:clone()
			l_4_7:set_key_collection(l_4_0)
			l_4_7:set_cast(l_4_0._cast)
			table.insert(l_4_0._owned_cutscene_keys, l_4_7)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer._is_driving_sound_key = function(l_5_0, l_5_1)
	if l_5_1.ELEMENT_NAME == CoreSoundCutsceneKey.ELEMENT_NAME and l_5_1:frame() == 0 then
		local l_5_2 = l_5_1:sync_to_video()
	else
		return false
	end
end

CoreCutscenePlayer._set_driving_sound_from_key = function(l_6_0, l_6_1)
	cat_print("cutscene", string.format("[CoreCutscenePlayer] Using sound cue \"%s/%s\" to drive the playhead.", l_6_1:bank(), l_6_1:cue()))
	l_6_0._driving_sound = assert(Sound:make_bank(l_6_1:bank(), l_6_1:cue()), string.format("Driving sound cue \"%s/%s\" not found.", l_6_1:bank(), l_6_1:cue()))
end

CoreCutscenePlayer.set_timer = function(l_7_0, l_7_1)
	l_7_0._cast:set_timer(l_7_1)
	if alive(l_7_0._workspace) then
		l_7_0._workspace:set_timer(l_7_1)
	end
	local l_7_2 = l_7_0:_camera_controller()
	if alive(l_7_2) then
		l_7_2:set_timer(l_7_1)
	end
end

CoreCutscenePlayer.viewport = function(l_8_0)
	return l_8_0._viewport
end

CoreCutscenePlayer.cutscene_name = function(l_9_0)
	local l_9_1, l_9_2 = l_9_0._cutscene:name, l_9_0._cutscene
	return l_9_1(l_9_2)
end

CoreCutscenePlayer.cutscene_duration = function(l_10_0)
	local l_10_1, l_10_2 = l_10_0._cutscene:duration, l_10_0._cutscene
	return l_10_1(l_10_2)
end

CoreCutscenePlayer.camera_attributes = function(l_11_0)
	local l_11_6, l_11_7 = nil
	local l_11_1 = l_11_0:_camera()
	local l_11_2 = {}
	l_11_2.aspect_ratio = l_11_1:aspect_ratio()
	l_11_2.fov = l_11_1:fov()
	l_11_2.near_range = l_11_1:near_range()
	l_11_2.far_range = l_11_1:far_range()
	if l_11_0._dof_attributes then
		for i_0,i_1 in pairs(l_11_0._dof_attributes) do
			l_11_2[i_0] = i_1
		end
	end
	return l_11_2
end

CoreCutscenePlayer.depth_of_field_attributes = function(l_12_0)
	return l_12_0._dof_attributes
end

CoreCutscenePlayer.prime = function(l_13_0)
	local l_13_4, l_13_5, l_13_6, l_13_7, l_13_8, l_13_9, l_13_10, l_13_11, l_13_12, l_13_13, l_13_14, l_13_15, l_13_16, l_13_17, l_13_18, l_13_19, l_13_20, l_13_21 = nil
	if not l_13_0._primed then
		l_13_0._cast:prime(l_13_0._cutscene)
		for i_0,i_1 in dpairs(l_13_0._owned_cutscene_keys) do
			if i_1:is_valid() then
				l_13_0:prime_cutscene_key(i_1)
			else
				if not i_1.__tostring or not i_1:__tostring() then
					Application:error(string.format("[CoreCutscenePlayer] Invalid cutscene key in \"%s\": %s", l_13_0:cutscene_name(), tostring(i_1)))
				end
				table.delete(l_13_0._owned_cutscene_keys, i_1)
			end
		end
		l_13_0:_process_camera_cutscene_keys_between(-1, 0)
		if l_13_0:_camera_object() ~= nil then
			l_13_0:_reparent_camera()
		end
		if l_13_0._driving_sound then
			l_13_0._driving_sound:prime()
		end
		l_13_0._primed = true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutscenePlayer.is_primed = function(l_14_0)
	return l_14_0._primed == true
end

CoreCutscenePlayer._driving_sound_offset = function(l_15_0)
	if alive(l_15_0._driving_sound_instance) then
		local l_15_1 = l_15_0:_master_driving_sound_instance(l_15_0._driving_sound_instance)
		if l_15_1 == nil then
			return 0
		else
			if not alive(l_15_1) or not l_15_1:is_playing() then
				return nil
			end
		end
		local l_15_2, l_15_3 = l_15_1:offset()
		if l_15_3 < l_15_0._time then
			cat_print("cutscene", string.format("[CoreCutscenePlayer] Bad SoundInstance offset: Got %g, previous was %g.", l_15_3, l_15_0._time))
			l_15_3 = l_15_0._time
		end
		return l_15_3
	end
	return nil
end

CoreCutscenePlayer._master_driving_sound_instance = function(l_16_0, l_16_1)
	if not l_16_0._driving_sound_instance_map then
		l_16_0._driving_sound_instance_map = {}
	end
	if l_16_0._driving_sound_instance_map[l_16_1] == nil then
		if l_16_1.playing_instances then
			local l_16_2, l_16_3, l_16_4 = l_16_1:playing_instances()[1]
		else
			l_16_0._driving_sound_instance_map[l_16_1] = l_16_1
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_16_1
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 18 
end

CoreCutscenePlayer.is_presentable = function(l_17_0)
	return not l_17_0:_driving_sound_offset() and not l_17_0._cast:is_ready(l_17_0._cutscene) or 1 > 0
end

CoreCutscenePlayer.is_viewport_enabled = function(l_18_0)
	if managers.viewport and l_18_0._viewport then
		return l_18_0._viewport:active()
	end
end

CoreCutscenePlayer.unload = function(l_19_0)
	l_19_0:stop()
	local l_19_4 = l_19_0:keys_between
	l_19_4 = l_19_4(l_19_0, math.huge, -math.huge)
	for i_0 in l_19_4 do
		l_19_3:unload(l_19_0)
	end
	if l_19_0._owned_cast then
		l_19_0._owned_cast:unload()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutscenePlayer.destroy = function(l_20_0)
	local l_20_4, l_20_5 = cat_print, "cutscene"
	l_20_4(l_20_5, string.format("[CoreCutscenePlayer] Destroying CutscenePlayer for \"%s\".", l_20_0:cutscene_name()))
	l_20_4, l_20_5 = l_20_0:set_viewport_enabled, l_20_0
	l_20_4(l_20_5, false)
	l_20_4 = pairs
	l_20_5 = l_20_0._owned_gui_objects
	if not l_20_5 then
		l_20_4, l_20_5 = l_20_4(l_20_5), {}
		for i_0,i_1 in l_20_4 do
		end
		l_20_0:invoke_callback_in_gui(l_20_2, "on_cutscene_player_destroyed", l_20_0)
	end
	l_20_0._owned_gui_objects = nil
	l_20_0:unload()
	if l_20_0._listener_id and managers.listener then
		managers.listener:remove_listener(l_20_0._listener_id)
	end
	l_20_0._listener_id = nil
	if l_20_0._resolution_changed_callback_id and managers.viewport then
		managers.viewport:remove_resolution_changed_func(l_20_0._resolution_changed_callback_id)
	end
	l_20_0._resolution_changed_callback_id = nil
	if l_20_0._owned_camera_controller then
		l_20_0._viewport:director():release_camera()
		assert(l_20_0._viewport:director():camera() == nil)
	end
	if alive(l_20_0._workspace) then
		Overlay:newgui():destroy_workspace(l_20_0._workspace)
	end
	l_20_0._workspace = nil
	if l_20_0._owned_viewport and l_20_0._owned_viewport:alive() then
		l_20_0._owned_viewport:destroy()
	end
	l_20_0._owned_viewport = nil
	if alive(l_20_0._owned_camera) then
		World:delete_camera(l_20_0._owned_camera)
	end
	l_20_0._owned_camera = nil
	if alive(l_20_0._future_camera) then
		World:delete_camera(l_20_0._future_camera)
	end
	l_20_0._future_camera = nil
	if alive(l_20_0._future_camera_locator) then
		World:delete_unit(l_20_0._future_camera_locator)
	end
	l_20_0._future_camera_locator = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer.update = function(l_21_0, l_21_1, l_21_2)
	local l_21_3 = false
	if l_21_0:is_playing() then
		if alive(l_21_0._driving_sound_instance) then
			l_21_0._driving_sound_instance:unpause()
		elseif l_21_0._driving_sound then
			l_21_0._driving_sound_instance = l_21_0._driving_sound:play("offset", l_21_0._time)
		end
		if l_21_0:is_presentable() then
			if not l_21_0:_driving_sound_offset() then
				local l_21_4, l_21_5, l_21_6 = l_21_0._time + l_21_2
			end
			local l_21_7, l_21_8 = , l_21_0:seek
			local l_21_9 = l_21_0
			l_21_8 = l_21_8(l_21_9, l_21_7, l_21_0._time == l_21_7)
			l_21_3 = l_21_8 == false
		end
	else
		if alive(l_21_0._driving_sound_instance) then
			l_21_0._driving_sound_instance:pause()
		end
	end
	if l_21_3 then
		l_21_0:stop()
	else
		if l_21_0:is_viewport_enabled() then
			l_21_0:refresh()
		end
	end
	return not l_21_3
end

CoreCutscenePlayer.refresh = function(l_22_0)
	if l_22_0:_camera_has_cut() and managers.environment then
		managers.environment:clear_luminance()
	end
	l_22_0:_update_future_camera()
	l_22_0:_update_depth_of_field()
end

CoreCutscenePlayer.evaluate_current_frame = function(l_23_0)
	l_23_0._last_evaluated_time = l_23_0._last_evaluated_time or -1
	l_23_0:_set_visible(true)
	l_23_0:_process_discontinuity_cutscene_keys_between(l_23_0._last_evaluated_time, l_23_0._time)
	l_23_0:_evaluate_animations()
	l_23_0:_resume_discontinuity()
	l_23_0:_process_camera_cutscene_keys_between(l_23_0._last_evaluated_time, l_23_0._time)
	l_23_0:_reparent_camera()
	l_23_0:_process_non_camera_cutscene_keys_between(l_23_0._last_evaluated_time, l_23_0._time)
	l_23_0._last_evaluated_time = l_23_0._time
end

CoreCutscenePlayer.preroll_cutscene_keys = function(l_24_0)
	if l_24_0._time > 0 then
		return 
	end
	local l_24_4, l_24_5 = ipairs, l_24_0:_all_keys_sorted_by_time()
	l_24_4 = l_24_4(l_24_5)
	for i_0,i_1 in l_24_4 do
		if l_24_3:frame() > 0 then
			do return end
		end
		if l_24_3.preroll then
			l_24_3:preroll(l_24_0)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer.is_playing = function(l_25_0)
	return l_25_0._playing or false
end

CoreCutscenePlayer.play = function(l_26_0)
	l_26_0._playing = true
end

CoreCutscenePlayer.pause = function(l_27_0)
	l_27_0._playing = nil
end

CoreCutscenePlayer.stop = function(l_28_0)
	l_28_0._playing = nil
	l_28_0._driving_sound_instance = nil
	l_28_0:_set_visible(false)
end

CoreCutscenePlayer.skip_to_end = function(l_29_0)
	local l_29_4 = l_29_0:keys_between
	l_29_4 = l_29_4(l_29_0, l_29_0._time, math.huge)
	for i_0 in l_29_4 do
		if l_29_3.skip then
			l_29_0:skip_cutscene_key(l_29_3)
		end
	end
	if alive(l_29_0._driving_sound_instance) then
		l_29_0._driving_sound_instance:stop()
	end
	l_29_0._driving_sound_instance = nil
	l_29_0._time = l_29_0:cutscene_duration()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer.seek = function(l_30_0, l_30_1, l_30_2)
	l_30_0._time = math.min(math.max(0, l_30_1), l_30_0:cutscene_duration())
	if not l_30_2 then
		l_30_0:evaluate_current_frame()
	end
	return l_30_0._time == l_30_1
end

CoreCutscenePlayer.distance_from_camera = function(l_31_0, l_31_1, l_31_2)
	local l_31_3 = l_31_0:_actor_object(l_31_1, l_31_2)
	do
		if l_31_3 then
			return l_31_0:_camera():world_to_screen(l_31_3:position()).z
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutscenePlayer.set_camera = function(l_32_0, l_32_1)
	local l_32_2 = assert
	if l_32_1 ~= nil then
		local l_32_3 = string.begins(l_32_1, "camera")
		l_32_3 = l_32_3
		l_32_2(l_32_3)
	end
	l_32_0._camera_name = l_32_1
end

CoreCutscenePlayer.set_camera_attribute = function(l_33_0, l_33_1, l_33_2)
	local l_33_3 = l_33_0:_camera()
	local l_33_4 = assert(l_33_3["set_" .. l_33_1], "Invalid camera attribute.")
	l_33_4(l_33_3, l_33_2)
	l_33_4(l_33_0._future_camera, l_33_2)
end

CoreCutscenePlayer.set_camera_depth_of_field = function(l_34_0, l_34_1, l_34_2)
	local l_34_3 = l_34_2 - l_34_1
	if not l_34_0._dof_attributes then
		l_34_0._dof_attributes = {}
	end
	l_34_0._dof_attributes.near_focus_distance_min = math.max(1e-006, l_34_1 - l_34_3 * 0.33)
	l_34_0._dof_attributes.near_focus_distance_max = math.max(1e-006, l_34_1)
	l_34_0._dof_attributes.far_focus_distance_min = l_34_2
	l_34_0._dof_attributes.far_focus_distance_max = l_34_2 + l_34_3 * 0.67
end

CoreCutscenePlayer._update_depth_of_field = function(l_35_0)
	if managers.DOF and l_35_0._dof_attributes then
		local l_35_1 = l_35_0._dof_attributes.far_focus_distance_min - l_35_0._dof_attributes.near_focus_distance_max
		managers.DOF:set_dof(l_35_0._viewport, l_35_1 * 0.33, l_35_0._dof_attributes.near_focus_distance_max, l_35_0._dof_attributes.far_focus_distance_min, l_35_1 * 0.67, 1)
	end
end

CoreCutscenePlayer.play_camera_shake = function(l_36_0, l_36_1, l_36_2, l_36_3, l_36_4)
	return function()
		-- upvalues: l_36_0 , l_36_5
		l_36_0._viewport:director():shaker():stop_immediately(l_36_5)
  end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreCutscenePlayer.has_gui = function(l_37_0, l_37_1)
	return l_37_0._owned_gui_objects ~= nil and l_37_0._owned_gui_objects[l_37_1] ~= nil
end

CoreCutscenePlayer.load_gui = function(l_38_0, l_38_1)
	local l_38_2 = true
	Overlay:newgui():preload(l_38_1)
	l_38_0:_gui_panel(l_38_1, l_38_2)
	l_38_0:set_gui_visible(l_38_1, false)
end

CoreCutscenePlayer.set_gui_visible = function(l_39_0, l_39_1, l_39_2)
	local l_39_3 = l_39_0:_gui_panel(l_39_1)
	if not l_39_2 == l_39_3:visible() then
		l_39_0:invoke_callback_in_gui(l_39_1, "on_cutscene_player_set_visible", l_39_2, l_39_0)
		l_39_3:set_visible(l_39_2)
	end
end

CoreCutscenePlayer.invoke_callback_in_gui = function(l_40_0, l_40_1, l_40_2, ...)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if (not l_40_0._owned_gui_objects or alive(l_40_0._owned_gui_objects[l_40_1])) and l_40_0._owned_gui_objects[l_40_1]:has_script() then
		local l_40_4 = nil
		local l_40_5 = nil
	if type(rawget(l_40_0._owned_gui_objects[l_40_1]:script(), l_40_2)) == "function" then
		end
		if Application:debug_build() then
			local l_40_6 = nil
			local l_40_7 = table.concat
			local l_40_8 = table.collect
			l_40_8 = l_40_8({...}, function(l_41_0)
				if type(l_41_0) ~= "string" or not string.format("%q", l_41_0) then
					return tostring(l_41_0)
				end
      end)
			l_40_7 = l_40_7(l_40_8, ", ")
			l_40_8 = cat_print
			l_40_8("cutscene", string.format("[CoreCutscenePlayer] Calling %s(%s) in Gui \"%s\".", l_40_2, l_40_7, l_40_1))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_40_6(...)
	end
end

CoreCutscenePlayer._gui_panel = function(l_41_0, l_41_1, l_41_2)
	local l_41_3 = l_41_0._workspace:panel():child(l_41_1)
	if l_41_3 == nil then
		if not l_41_2 then
			Application:error("[CoreCutscenePlayer] The gui \"" .. l_41_1 .. "\" was not preloaded, causing a performance spike.")
		end
		if not l_41_0._owned_gui_objects then
			l_41_0._owned_gui_objects = {}
		end
		local l_41_4 = l_41_0:_viewport_rect()
		local l_41_5, l_41_6 = l_41_0._workspace:panel():panel, l_41_0._workspace:panel()
		local l_41_7 = {}
		l_41_7.name = l_41_1
		l_41_7.visible = false
		l_41_7.halign = "grow"
		l_41_7.valign = "grow"
		l_41_7.x = l_41_4.px
		l_41_7.y = l_41_4.py
		l_41_7.width = l_41_4.pw
		l_41_7.height = l_41_4.ph
		l_41_5 = l_41_5(l_41_6, l_41_7)
		l_41_3 = l_41_5
		l_41_5, l_41_6 = l_41_3:gui, l_41_3
		l_41_7 = l_41_1
		l_41_5 = l_41_5(l_41_6, l_41_7)
		l_41_6 = l_41_0._owned_gui_objects
		l_41_6[l_41_1] = l_41_5
	end
	return l_41_3
end

CoreCutscenePlayer.set_viewport_enabled = function(l_42_0, l_42_1)
	local l_42_2 = l_42_0._viewport:active()
	if l_42_1 ~= l_42_2 then
		if l_42_1 then
			managers.viewport:push()
			managers.viewport:deactivate_all_viewports()
			l_42_0._viewport:set_active(true)
		else
			l_42_0._viewport:set_active(false)
			managers.viewport:pop()
		end
		l_42_0:_set_listener_enabled(l_42_1)
		l_42_0:_set_depth_of_field_enabled(l_42_1)
		l_42_0._viewport:set_width_mul_enabled(not l_42_1)
		do
			local l_42_3, l_42_4, l_42_5, l_42_6 = not l_42_0._widescreen or l_42_1
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_42_0._workspace:panel():child(l_42_0.BLACK_BAR_TOP_GUI_NAME):set_visible(l_42_3)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_42_0._workspace:panel():child(l_42_0.BLACK_BAR_BOTTOM_GUI_NAME):set_visible(l_42_3)
	end
end

CoreCutscenePlayer.set_widescreen = function(l_43_0, l_43_1)
	do
		l_43_0._widescreen = l_43_1 or nil
		l_43_0:_configure_viewport()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer.set_key_handler = function(l_44_0, l_44_1)
	l_44_0._key_handler = l_44_1
end

CoreCutscenePlayer.prime_cutscene_key = function(l_45_0, l_45_1, l_45_2)
	local l_45_3 = l_45_0._key_handler
	if l_45_3 and l_45_3.prime_cutscene_key then
		local l_45_4 = l_45_3.prime_cutscene_key
		local l_45_5 = l_45_3
		local l_45_6 = l_45_0
		local l_45_7, l_45_12 = l_45_1
		l_45_12 = l_45_2
		local l_45_8, l_45_13 = nil
		return l_45_4(l_45_5, l_45_6, l_45_7, l_45_12)
	else
		local l_45_9, l_45_10 = l_45_1:prime, l_45_1
		local l_45_11 = l_45_0
		return l_45_9(l_45_10, l_45_11)
	end
end

CoreCutscenePlayer.evaluate_cutscene_key = function(l_46_0, l_46_1, l_46_2, l_46_3)
	local l_46_4 = l_46_0._key_handler
	if l_46_4 and l_46_4.evaluate_cutscene_key then
		local l_46_5 = l_46_4.evaluate_cutscene_key
		local l_46_6 = l_46_4
		local l_46_7 = l_46_0
		local l_46_8 = l_46_1
		local l_46_9 = l_46_2
		local l_46_10, l_46_16 = l_46_3
		return l_46_5(l_46_6, l_46_7, l_46_8, l_46_9, l_46_10)
	else
		local l_46_11, l_46_12 = l_46_1:play, l_46_1
		local l_46_13 = l_46_0
		local l_46_14 = false
		local l_46_15 = false
		return l_46_11(l_46_12, l_46_13, l_46_14, l_46_15)
	end
end

CoreCutscenePlayer.revert_cutscene_key = function(l_47_0, l_47_1, l_47_2, l_47_3)
	local l_47_4 = l_47_0._key_handler
	if l_47_4 and l_47_4.revert_cutscene_key then
		local l_47_5 = l_47_4.revert_cutscene_key
		local l_47_6 = l_47_4
		local l_47_7 = l_47_0
		local l_47_8 = l_47_1
		local l_47_9 = l_47_2
		local l_47_10, l_47_16 = l_47_3
		return l_47_5(l_47_6, l_47_7, l_47_8, l_47_9, l_47_10)
	else
		local l_47_11, l_47_12 = l_47_1:play, l_47_1
		local l_47_13 = l_47_0
		local l_47_14 = true
		local l_47_15 = false
		return l_47_11(l_47_12, l_47_13, l_47_14, l_47_15)
	end
end

CoreCutscenePlayer.update_cutscene_key = function(l_48_0, l_48_1, l_48_2, l_48_3)
	local l_48_4 = l_48_0._key_handler
	if l_48_4 and l_48_4.update_cutscene_key then
		local l_48_5 = l_48_4.update_cutscene_key
		local l_48_6 = l_48_4
		local l_48_7 = l_48_0
		local l_48_8 = l_48_1
		local l_48_9, l_48_15 = l_48_2
		l_48_15 = l_48_3
		local l_48_10, l_48_16 = nil
		return l_48_5(l_48_6, l_48_7, l_48_8, l_48_9, l_48_15)
	else
		local l_48_11, l_48_12 = l_48_1:update, l_48_1
		local l_48_13 = l_48_0
		local l_48_14 = l_48_2
		return l_48_11(l_48_12, l_48_13, l_48_14)
	end
end

CoreCutscenePlayer.skip_cutscene_key = function(l_49_0, l_49_1)
	local l_49_2 = l_49_0._key_handler
	if l_49_2 and l_49_2.skip_cutscene_key then
		local l_49_3 = l_49_2.skip_cutscene_key
		local l_49_4 = l_49_2
		local l_49_5 = l_49_0
		local l_49_6, l_49_10 = l_49_1
		return l_49_3(l_49_4, l_49_5, l_49_6)
	else
		local l_49_7, l_49_8 = l_49_1:skip, l_49_1
		local l_49_9 = l_49_0
		return l_49_7(l_49_8, l_49_9)
	end
end

CoreCutscenePlayer.time_in_relation_to_cutscene_key = function(l_50_0, l_50_1)
	local l_50_2 = l_50_0._key_handler
	if l_50_2 and l_50_2.time_in_relation_to_cutscene_key then
		local l_50_3 = l_50_2.time_in_relation_to_cutscene_key
		local l_50_4 = l_50_2
		local l_50_5 = l_50_1
		return l_50_3(l_50_4, l_50_5)
	else
		return l_50_0._time - l_50_1:time()
	end
end

CoreCutscenePlayer._set_visible = function(l_51_0, l_51_1)
	l_51_0._cast:set_cutscene_visible(l_51_0._cutscene, l_51_1)
end

CoreCutscenePlayer._set_listener_enabled = function(l_52_0, l_52_1)
	if l_52_1 and not l_52_0._listener_activation_id then
		l_52_0._listener_activation_id = managers.listener:activate_set("main", "cutscene")
	end
	do return end
	if l_52_0._listener_activation_id then
		managers.listener:deactivate_set(l_52_0._listener_activation_id)
	end
	l_52_0._listener_activation_id = nil
end

CoreCutscenePlayer._set_depth_of_field_enabled = function(l_53_0, l_53_1)
	if l_53_1 then
		managers.environment:disable_dof()
	else
		managers.environment:enable_dof()
		managers.environment:needs_update()
	end
end

CoreCutscenePlayer._viewport_rect = function(l_54_0)
	if not l_54_0._widescreen or not l_54_0:_wide_viewport_rect() then
		return l_54_0:_full_viewport_rect()
	end
end

CoreCutscenePlayer._full_viewport_rect = function(l_55_0)
	local l_55_1 = RenderSettings.resolution
	local l_55_2 = {}
	l_55_2.x = 0
	l_55_2.y = 0
	l_55_2.w = 1
	l_55_2.h = 1
	l_55_2.px = 0
	l_55_2.py = 0
	l_55_2.pw = l_55_1.x
	l_55_2.ph = l_55_1.y
	return l_55_2
end

CoreCutscenePlayer._wide_viewport_rect = function(l_56_0)
	local l_56_1 = RenderSettings.resolution
	local l_56_2 = 1 / core_setup.aspect_ratio
	local l_56_3 = 0.5625
	local l_56_4 = math.min(l_56_2 / l_56_3, 1)
	local l_56_5 = 1 / l_56_2 * l_56_3 * l_56_4
	local l_56_6 = (1 - l_56_4) / 2
	local l_56_7 = (1 - l_56_5) / 2
	local l_56_8 = {}
	l_56_8.x = l_56_6
	l_56_8.y = l_56_7
	l_56_8.w = l_56_4
	l_56_8.h = l_56_5
	l_56_8.px = l_56_8.x * l_56_1.x
	l_56_8.py = l_56_8.y * l_56_1.y
	l_56_8.pw = l_56_8.w * l_56_1.x
	l_56_8.ph = l_56_8.h * l_56_1.y
	return l_56_8
end

CoreCutscenePlayer._camera = function(l_57_0)
	if not l_57_0._viewport:camera() then
		return l_57_0:_create_camera()
	end
end

CoreCutscenePlayer._camera_controller = function(l_58_0)
	local l_58_1 = l_58_0._viewport:director():camera()
	do
		if not l_58_1 then
			return l_58_0:_create_camera_controller()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutscenePlayer._camera_object = function(l_59_0)
	if l_59_0._camera_name then
		return l_59_0:_actor_object(l_59_0._camera_name, "locator")
	end
end

CoreCutscenePlayer._actor_object = function(l_60_0, l_60_1, l_60_2)
	if l_60_0._cast:actor_unit(l_60_1, l_60_0._cutscene) == nil and managers.cutscene then
		local l_60_3 = managers.cutscene:cutscene_actors_in_world()[l_60_1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_60_3 then
			return l_60_3:get_object(l_60_2)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutscenePlayer._clear_workspace = function(l_61_0)
	if alive(l_61_0._workspace) then
		Overlay:newgui():destroy_workspace(l_61_0._workspace)
	end
	local l_61_1 = RenderSettings.resolution
	l_61_0._workspace = Overlay:newgui():create_scaled_screen_workspace(l_61_1.x, l_61_1.y, 0, 0, l_61_1.x)
	l_61_0._workspace:set_timer(managers.cutscene:timer())
	local l_61_2, l_61_3 = l_61_0._workspace:panel():rect, l_61_0._workspace:panel()
	local l_61_4 = {}
	l_61_4.visible = l_61_0._widescreen
	l_61_4.layer = l_61_0.BLACK_BAR_GUI_LAYER
	l_61_4.name = l_61_0.BLACK_BAR_TOP_GUI_NAME
	l_61_4.color = Color.black
	l_61_2(l_61_3, l_61_4)
	l_61_2 = l_61_0._workspace
	l_61_2, l_61_3 = l_61_2:panel, l_61_2
	l_61_2 = l_61_2(l_61_3)
	l_61_2, l_61_3 = l_61_2:rect, l_61_2
	l_61_2(l_61_3, l_61_4)
	l_61_4 = {visible = l_61_0._widescreen, layer = l_61_0.BLACK_BAR_GUI_LAYER, name = l_61_0.BLACK_BAR_BOTTOM_GUI_NAME, color = Color.black}
	l_61_2 = l_61_0._workspace
	l_61_2, l_61_3 = l_61_2:show, l_61_2
	l_61_2(l_61_3)
	l_61_2, l_61_3 = l_61_0:_configure_viewport, l_61_0
	l_61_2(l_61_3)
end

CoreCutscenePlayer._create_viewport = function(l_62_0)
	local l_62_1 = assert
	l_62_1(l_62_0._owned_viewport == nil)
	l_62_1 = CoreScriptViewport
	l_62_1 = l_62_1.ScriptViewport
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_62_0._owned_viewport = l_62_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_62_1
end

CoreCutscenePlayer._configure_viewport = function(l_63_0)
	l_63_0:set_camera_attribute("aspect_ratio", core_setup.aspect_ratio)
	if alive(l_63_0._workspace) then
		local l_63_1 = RenderSettings.resolution
		l_63_0._workspace:set_screen(l_63_1.x, l_63_1.y, 0, 0, l_63_1.x)
		local l_63_2 = l_63_0:_viewport_rect()
		if l_63_0._widescreen then
			local l_63_3 = l_63_0:is_viewport_enabled()
		end
		local l_63_4, l_63_5 = , l_63_0._workspace:panel():child(l_63_0.BLACK_BAR_TOP_GUI_NAME):configure
		local l_63_6 = l_63_0._workspace:panel():child(l_63_0.BLACK_BAR_TOP_GUI_NAME)
		l_63_5(l_63_6, {visible = l_63_4, x = 0, y = 0, width = l_63_2.pw, height = l_63_2.py})
		l_63_5 = l_63_0._workspace
		l_63_5, l_63_6 = l_63_5:panel, l_63_5
		l_63_5 = l_63_5(l_63_6)
		l_63_5, l_63_6 = l_63_5:child, l_63_5
		l_63_5 = l_63_5(l_63_6, l_63_0.BLACK_BAR_BOTTOM_GUI_NAME)
		l_63_5, l_63_6 = l_63_5:configure, l_63_5
		l_63_5(l_63_6, {visible = l_63_4, x = 0, y = l_63_1.y - l_63_2.py, width = l_63_2.pw, height = l_63_2.py})
		l_63_5 = l_63_0._owned_gui_objects
	if l_63_5 then
		end
		l_63_5 = pairs
		l_63_6 = table
		l_63_6 = l_63_6.map_copy
		local l_63_7, l_63_8 = .end
		l_63_5 = l_63_5(l_63_6, l_63_7, l_63_8)
		for l_63_8,i_1 in l_63_5 do
			l_63_0:invoke_callback_in_gui(l_63_8, "on_cutscene_player_set_visible", false, l_63_0)
			l_63_0:invoke_callback_in_gui(l_63_8, "on_cutscene_player_destroyed", l_63_0)
			l_63_0._workspace:panel():child(l_63_8):clear()
			local l_63_10, l_63_11 = , l_63_0._workspace:panel():child(l_63_8):configure
			local l_63_12 = l_63_0._workspace:panel():child(l_63_8)
			l_63_11(l_63_12, {x = l_63_2.px, y = l_63_2.py, width = l_63_2.pw, height = l_63_2.ph})
			l_63_11 = l_63_0._owned_gui_objects
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_63_11[l_63_8] = l_63_12
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutscenePlayer._create_camera = function(l_64_0)
	local l_64_1 = assert
	l_64_1(l_64_0._owned_camera == nil)
	l_64_1 = World
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_64_0._owned_camera = l_64_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_64_1(l_64_0, l_64_0._owned_camera)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_64_1(l_64_1, l_64_0._owned_camera)
	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_64_1
end

CoreCutscenePlayer._initialize_camera = function(l_65_0, l_65_1)
	l_65_1:set_fov(CoreZoomCameraCutsceneKey.DEFAULT_CAMERA_FOV)
	l_65_1:set_near_range(7.5)
	l_65_1:set_far_range(50000)
	l_65_1:set_width_multiplier(1)
end

CoreCutscenePlayer._create_camera_controller = function(l_66_0)
	local l_66_1 = assert
	l_66_1(l_66_0._owned_camera_controller == nil)
	l_66_1 = l_66_0._viewport
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_66_0._owned_camera_controller = l_66_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_66_1(l_66_1, managers.cutscene:timer())
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_66_1(l_66_1, l_66_0._owned_camera_controller)
	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_66_1
end

CoreCutscenePlayer._create_cast = function(l_67_0)
	local l_67_1 = assert
	l_67_1(l_67_0._owned_cast == nil)
	l_67_1 = core_or_local
	l_67_1 = l_67_1("CutsceneCast")
	l_67_0._owned_cast = l_67_1
	l_67_1 = l_67_0._owned_cast
	return l_67_1
end

CoreCutscenePlayer._evaluate_animations = function(l_68_0)
	l_68_0._cast:evaluate_cutscene_at_time(l_68_0._cutscene, l_68_0._time)
end

CoreCutscenePlayer._notify_discontinuity = function(l_69_0)
	local l_69_4, l_69_5 = pairs, l_69_0._cutscene:controlled_unit_types()
	l_69_4 = l_69_4(l_69_5)
	for i_0,i_1 in l_69_4 do
		local l_69_6 = l_69_0._cast:actor_unit(l_69_2, l_69_0._cutscene)
		for l_69_10 = 0, l_69_6:num_bodies() - 1 do
			local l_69_11 = l_69_6:body(l_69_10)
			if l_69_11:dynamic() and l_69_11:enabled() then
				l_69_11:set_enabled(false)
				if not l_69_0._disabled_bodies then
					l_69_0._disabled_bodies = {}
				end
				table.insert(l_69_0._disabled_bodies, l_69_11)
			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer._resume_discontinuity = function(l_70_0)
	local l_70_4, l_70_5, l_70_6, l_70_7 = nil
	if l_70_0._disabled_bodies then
		for i_0,i_1 in ipairs(l_70_0._disabled_bodies) do
			i_1:enable_with_no_velocity()
		end
		l_70_0._disabled_bodies = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutscenePlayer._process_discontinuity_cutscene_keys_between = function(l_71_0, l_71_1, l_71_2)
	local l_71_6 = l_71_0:keys_between
	l_71_6 = l_71_6(l_71_0, l_71_1, l_71_2, CoreDiscontinuityCutsceneKey.ELEMENT_NAME)
	for i_0 in l_71_6 do
		l_71_0:evaluate_cutscene_key(l_71_5, l_71_2, l_71_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer._process_camera_cutscene_keys_between = function(l_72_0, l_72_1, l_72_2)
	local l_72_6 = l_72_0:keys_between
	l_72_6 = l_72_6(l_72_0, l_72_1, l_72_2, CoreChangeCameraCutsceneKey.ELEMENT_NAME)
	for i_0 in l_72_6 do
		do
			if l_72_1 < l_72_2 then
				l_72_0:evaluate_cutscene_key(l_72_5, l_72_2, l_72_1)
			else
				l_72_0:revert_cutscene_key(l_72_5, l_72_2, l_72_1)
			end
		end
		for i_0 in l_72_0:keys_to_update(l_72_2, CoreChangeCameraCutsceneKey.ELEMENT_NAME) do
			l_72_0:update_cutscene_key(i_0, l_72_2 - i_0:time(), math.max(0, l_72_1 - i_0:time()))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer._process_non_camera_cutscene_keys_between = function(l_73_0, l_73_1, l_73_2)
	local l_73_6 = l_73_0:keys_between
	l_73_6 = l_73_6(l_73_0, l_73_1, l_73_2)
	for i_0 in l_73_6 do
		do
			if l_73_5.ELEMENT_NAME ~= CoreChangeCameraCutsceneKey.ELEMENT_NAME and l_73_5.ELEMENT_NAME ~= CoreDiscontinuityCutsceneKey.ELEMENT_NAME then
				if l_73_1 < l_73_2 then
					l_73_0:evaluate_cutscene_key(l_73_5, l_73_2, l_73_1)
				end
			else
				l_73_0:revert_cutscene_key(l_73_5, l_73_2, l_73_1)
			end
		end
		for i_0 in l_73_0:keys_to_update(l_73_2) do
			if i_0.ELEMENT_NAME ~= CoreChangeCameraCutsceneKey.ELEMENT_NAME and i_0.ELEMENT_NAME ~= CoreDiscontinuityCutsceneKey.ELEMENT_NAME then
				l_73_0:update_cutscene_key(i_0, l_73_2 - i_0:time(), math.max(0, l_73_1 - i_0:time()))
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscenePlayer._reparent_camera = function(l_74_0)
	if l_74_0._camera_name then
		local l_74_1, l_74_2, l_74_3, l_74_4, l_74_5, l_74_6, l_74_7 = assert(l_74_0:_camera_object(), string.format("Camera \"%s\" not found in cutscene \"%s\".", l_74_0._camera_name, l_74_0:cutscene_name()))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_74_1 ~= nil and l_74_1 ~= l_74_0:_camera_controller():get_camera() then
		l_74_0:_camera_controller():set_both(l_74_1)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_74_0._listener_id then
			managers.listener:set_listener(l_74_0._listener_id, l_74_1)
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		l_74_0._listener_id = managers.listener:add_listener("cutscene", l_74_1)
	end
end

CoreCutscenePlayer._update_future_camera = function(l_75_0)
	if l_75_0._cutscene:is_optimized() then
		local l_75_1, l_75_2 = l_75_0._cast:evaluate_object_at_time(l_75_0._cutscene, "camera", "locator", l_75_0._time + 0.16666667)
		l_75_0._future_camera_locator:warp_to(l_75_2, l_75_1)
		World:effect_manager():add_camera(l_75_0._future_camera)
		World:lod_viewers():add_viewer(l_75_0._future_camera)
	end
end

CoreCutscenePlayer._camera_has_cut = function(l_76_0)
	if not l_76_0._last_frame_camera_position then
		l_76_0._last_frame_camera_position = Vector3(0, 0, 0)
	end
	if not l_76_0._last_frame_camera_rotation then
		l_76_0._last_frame_camera_rotation = Rotation()
	end
	local l_76_1 = l_76_0:_camera()
	local l_76_2 = l_76_1:position()
	local l_76_3 = l_76_1:new_rotation()
	local l_76_4 = l_76_0._last_frame_camera_position - l_76_2
	local l_76_5 = Rotation:rotation_difference(l_76_0._last_frame_camera_rotation, l_76_3)
	do
		return l_76_4:length() > 50 or l_76_5:yaw() > 5 or l_76_5:pitch() > 5 or l_76_5:roll() > 5
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


