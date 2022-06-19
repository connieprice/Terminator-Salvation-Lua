core:module("CoreViewportManager2")
core:require_module("CoreClass")
core:require_module("CoreApp")
core:require_module("CoreCode")
core:require_module("CoreScriptViewportVMInterface")
core:require_module("CoreEnvironmentManagerVPMInterface")
if not ViewportManager then
	ViewportManager = CoreClass.class()
end
ViewportManager.init = function(l_1_0)
	CoreApp.min_exe_version("1.0.78.10226", "CoreViewportManager2")
	l_1_0._envm_interface = CoreEnvironmentManagerVPMInterface.EnvironmentManagerVPMInterface:new(managers.environment)
	l_1_0._resolution_changed_func_map = {}
	l_1_0._active_viewports = {}
	l_1_0._viewports = {}
	l_1_0._viewport_states_stack = {}
	l_1_0._cached_environment_name = nil
	script_debug.render_sky = true
end

ViewportManager.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_7, l_2_8, l_2_9, l_2_10 = nil
	local l_2_3 = Profiler:start("CoreViewportManager")
	for i_0,i_1 in ipairs(l_2_0._active_viewports) do
		i_1:update(l_2_1, l_2_2)
	end
	Profiler:stop(l_2_3)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ViewportManager.paused_update = function(l_3_0, l_3_1, l_3_2)
	l_3_0:update(l_3_1, l_3_2)
end

ViewportManager.render = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7 = nil
	for i_0,i_1 in ipairs(l_4_0._active_viewports) do
		i_1:render()
	end
end

ViewportManager.destroy = function(l_5_0)
	local l_5_4, l_5_5, l_5_6, l_5_7 = nil
	for i_0,i_1 in pairs(l_5_0._viewports) do
		i_1:destroy()
	end
end

ViewportManager.active_viewports = function(l_6_0)
	local l_6_5, l_6_6, l_6_7, l_6_8 = nil
	local l_6_1 = {}
	for i_0,i_1 in ipairs(l_6_0._active_viewports) do
		table.insert(l_6_1, i_1:vp())
	end
	return l_6_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ViewportManager.num_active_viewports = function(l_7_0)
	return #l_7_0._active_viewports
end

ViewportManager.first_active_viewport = function(l_8_0)
	if #l_8_0._active_viewports > 0 then
		local l_8_1 = l_8_0._active_viewports[1]:vp()
	else
		return false
	end
end

ViewportManager.viewports = function(l_9_0)
	local l_9_5, l_9_6, l_9_7, l_9_8 = nil
	local l_9_1 = {}
	for i_0,i_1 in ipairs(l_9_0._viewports) do
		table.insert(l_9_1, i_1:vp())
	end
	return l_9_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ViewportManager.feed_all_environments = function(l_10_0)
	local l_10_4, l_10_5, l_10_6, l_10_7 = nil
	for i_0,i_1 in ipairs(l_10_0._viewports) do
		i_1:refeed()
	end
end

ViewportManager.add_resolution_changed_func = function(l_11_0, l_11_1)
	l_11_0._resolution_changed_func_map[l_11_1] = l_11_1
	return l_11_1
end

ViewportManager.remove_resolution_changed_func = function(l_12_0, l_12_1)
	l_12_0._resolution_changed_func_map[l_12_1] = nil
end

ViewportManager.resolution_changed = function(l_13_0)
	local l_13_4, l_13_5, l_13_6, l_13_7, l_13_8 = nil
	for i_0,i_1 in pairs(l_13_0._resolution_changed_func_map) do
		i_1(i_0)
	end
end

ViewportManager.deactivate_all_viewports = function(l_14_0)
	local l_14_4, l_14_5, l_14_6, l_14_7 = nil
	for i_0,i_1 in ipairs(l_14_0._viewports) do
		i_1:vp():set_active(false)
	end
end

ViewportManager.push = function(l_15_0)
	local l_15_5, l_15_6, l_15_7, l_15_8 = nil
	local l_15_1 = {}
	for i_0,i_1 in ipairs(l_15_0._viewports) do
		l_15_1[i_1] = i_1:vp():active()
	end
	table.insert(l_15_0._viewport_states_stack, l_15_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ViewportManager.pop = function(l_16_0)
	local l_16_5, l_16_6, l_16_7, l_16_8, l_16_9, l_16_10 = nil
	if #l_16_0._viewport_states_stack > 0 then
		local l_16_1 = l_16_0._viewport_states_stack[#l_16_0._viewport_states_stack]
		for i_0,i_1 in ipairs(l_16_0._viewports) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_16_1[i_1] then
				i_1:vp():set_active(l_16_1[i_1])
			end
		end
		table.remove(l_16_0._viewport_states_stack, #l_16_0._viewport_states_stack)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ViewportManager._reg_vp = function(l_17_0, l_17_1)
	local l_17_2 = CoreScriptViewportVMInterface.ScriptViewportVMInterface:new(l_17_1)
	table.insert(l_17_0._viewports, l_17_2)
	return l_17_2
end

ViewportManager._activate_vp = function(l_18_0, l_18_1)
	table.insert(l_18_0._active_viewports, l_18_1)
	l_18_0:_splitscreen_event()
end

ViewportManager._deactivate_vp = function(l_19_0, l_19_1)
	local l_19_5, l_19_6, l_19_7, l_19_8, l_19_9 = nil
	for i_0,i_1 in ipairs(l_19_0._active_viewports) do
		if i_1 == l_19_1 then
			table.remove(l_19_0._active_viewports, i_0)
			return 
		end
	end
	error("Viewport is not active!")
	l_19_0:_splitscreen_event()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ViewportManager._destroy_viewport = function(l_20_0, l_20_1, l_20_2)
	local l_20_6, l_20_7, l_20_8, l_20_9, l_20_10 = nil
	for i_0,i_1 in ipairs(l_20_0._viewports) do
		if i_1 == l_20_1 then
			table.remove(l_20_0._viewports, i_0)
	else
		end
	end
	if CoreCode.alive(l_20_2) then
		Application:destroy_viewport(l_20_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

ViewportManager._feed_environment = function(l_21_0, l_21_1, l_21_2, l_21_3)
	l_21_0._envm_interface:feed(l_21_1, l_21_2, l_21_3)
end

ViewportManager._create_environment_change = function(l_22_0, l_22_1, l_22_2, l_22_3)
	local l_22_4, l_22_5 = l_22_0._envm_interface:create_environment_change, l_22_0._envm_interface
	local l_22_6 = l_22_1
	local l_22_7 = l_22_2
	local l_22_8 = l_22_3
	return l_22_4(l_22_5, l_22_6, l_22_7, l_22_8)
end

ViewportManager._set_environment_name_cache = function(l_23_0, l_23_1)
	l_23_0._cached_environment_name = l_23_1
end

ViewportManager._environment_name_cache = function(l_24_0)
	return l_24_0._cached_environment_name
end

ViewportManager._splitscreen_event = function(l_25_0)
	if l_25_0:num_active_viewports() > 1 and not l_25_0._split_screen then
		l_25_0._split_screen = true
		RenderSettings.split_screen = true
		if l_25_0._splitscreen_cb then
			l_25_0._splitscreen_cb(l_25_0._splitscreen_cb_data)
		end
	else
		if l_25_0:num_active_viewports() < 2 and (l_25_0._split_screen == true or l_25_0._split_screen == nil) then
			l_25_0._split_screen = false
			RenderSettings.split_screen = false
		if l_25_0._splitscreen_cb then
			end
			l_25_0._splitscreen_cb(l_25_0._splitscreen_cb_data)
		end
	end
end

ViewportManager.first_active_world_viewport = function(l_26_0)
	local l_26_4, l_26_5, l_26_6, l_26_7, l_26_8, l_26_9 = nil
	for i_0,i_1 in ipairs(l_26_0._active_viewports) do
		if i_1:vp():is_rendering_scene("World") then
			local l_26_11 = i_1:vp
			return l_26_11(i_1)
		end
	end
end

ViewportManager.set_splitscreen_cb = function(l_27_0, l_27_1, l_27_2)
	l_27_0._splitscreen_cb = l_27_1
	l_27_0._splitscreen_cb_data = l_27_2
end

ViewportManager.mul_camera_far = function(l_28_0, l_28_1)
	local l_28_5, l_28_6, l_28_7, l_28_8 = nil
	for i_0,i_1 in ipairs(l_28_0._viewports) do
		i_1:mul_camera_far(l_28_1)
	end
end

ViewportManager.camera_call = function(l_29_0, l_29_1, ...)
	local l_29_5, l_29_6, l_29_7, l_29_8 = nil
	for i_0,i_1 in ipairs(l_29_0._viewports) do
		i_1:camera_call(l_29_1, ...)
	end
end

ViewportManager.recreate_envm_interface = function(l_30_0)
	l_30_0._envm_interface = CoreEnvironmentManagerVPMInterface.EnvironmentManagerVPMInterface:new(managers.environment)
end

ViewportManager.get_current_camera = function(l_31_0)
	local l_31_1 = l_31_0:active_viewports()
	if #l_31_1 > 1 then
		local l_31_2 = l_31_1[1]:camera()
	else
		return false
	end
end

ViewportManager.get_active_vp = function(l_32_0)
	local l_32_1, l_32_2 = l_32_0:active_vp():vp, l_32_0:active_vp()
	return l_32_1(l_32_2)
end

ViewportManager.active_vp = function(l_33_0)
	local l_33_1 = l_33_0:active_viewports()
	if #l_33_1 > 1 then
		local l_33_2 = l_33_1[1]
	else
		return false
	end
end

ViewportManager.toggle_safe_rect = function(l_34_0)
end

ViewportManager.get_safe_rect = function(l_35_0)
	local l_35_1 = 0.075
	local l_35_2 = 1 - l_35_1 * 2
	local l_35_3 = {}
	l_35_3.x = l_35_1
	l_35_3.y = l_35_1
	l_35_3.width = l_35_2
	l_35_3.height = l_35_2
	return l_35_3
end


