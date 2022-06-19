require("viewport/UserViewport")
if not UserViewportManager then
	UserViewportManager = class()
end
UserViewportManager.preload = function()
	UserViewport.preload()
end

UserViewportManager.init = function(l_2_0, l_2_1)
	l_2_0:clear()
	l_2_0._root_panel = l_2_1
	l_2_0._all_listeners_paused = false
	l_2_0._far_range_single_player = tweak_data.player.camera.FAR_RANGE_STD
	l_2_0._far_range_split_screen = tweak_data.player.camera.FAR_RANGE_STD
	managers.viewport:set_splitscreen_cb(l_2_0._adjust_viewport_parameters_event, l_2_0)
end

UserViewportManager.clear = function(l_3_0)
	l_3_0._viewport_creation_enabled = false
	l_3_0._user_to_viewport = {}
end

UserViewportManager.destroy = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7 = nil
	for i_0,i_1 in pairs(l_4_0._user_to_viewport) do
		i_1:destroy()
	end
end

UserViewportManager.release_unit = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7, l_5_8, l_5_9, l_5_10 = nil
	for i_0,i_1 in pairs(l_5_0._user_to_viewport) do
		if i_1:viewed_unit() == l_5_1 then
			i_1:release_viewed_unit()
		end
	end
end

UserViewportManager.get_engine_viewport_for_unit = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10 = nil
	for i_0,i_1 in pairs(l_6_0._user_to_viewport) do
		if i_1:viewed_unit() == l_6_1 then
			return i_1:engine_viewport()
		end
	end
end

UserViewportManager.create_user_viewport = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_1._wanted_player_slot_id
	local l_7_4 = managers.splittable_viewport:create_splittable_viewport(l_7_2, l_7_3)
	local l_7_5 = UserViewport:new(l_7_1, l_7_4, l_7_0._root_panel:panel(), l_7_0._all_listeners_paused)
	l_7_0._user_to_viewport[l_7_1] = l_7_5
	return l_7_5
end

UserViewportManager.has_any_viewport = function(l_8_0)
	return l_8_0:viewport_count() > 0
end

UserViewportManager.viewport_count = function(l_9_0)
	local l_9_1 = TableAlgorithms.count
	local l_9_2 = l_9_0._user_to_viewport
	return l_9_1(l_9_2)
end

UserViewportManager.viewport = function(l_10_0, l_10_1)
	return l_10_0._user_to_viewport[l_10_1]
end

UserViewportManager.viewports = function(l_11_0)
	return l_11_0._user_to_viewport
end

UserViewportManager.update = function(l_12_0, l_12_1)
	local l_12_5, l_12_6, l_12_7, l_12_8 = nil
	if l_12_0._viewport_creation_enabled then
		l_12_0:create_viewports_for_session_users()
		l_12_0:set_assigned_units_to_viewports()
	end
	l_12_0:destroy_viewports_for_session_users_that_left()
	for i_0,i_1 in pairs(l_12_0._user_to_viewport) do
		i_1:update()
	end
end

UserViewportManager.render = function(l_13_0)
	local l_13_4, l_13_5, l_13_6, l_13_7 = nil
	for i_0,i_1 in pairs(l_13_0._user_to_viewport) do
		i_1:render()
	end
end

UserViewportManager.save = function(l_14_0, l_14_1)
	local l_14_6, l_14_7, l_14_8, l_14_9, l_14_10, l_14_11 = nil
	l_14_1.viewports = {}
	local l_14_2 = 1
	for i_0,i_1 in pairs(l_14_0._user_to_viewport) do
		l_14_1.viewports[l_14_2] = {}
		i_1:save(l_14_1.viewports[l_14_2])
		l_14_2 = l_14_2 + 1
	end
end

UserViewportManager.load = function(l_15_0, l_15_1)
	local l_15_5, l_15_6, l_15_7, l_15_8 = nil
	for i_0,i_1 in ipairs(l_15_1.viewports) do
		user_viewport:load(i_1)
	end
end

UserViewportManager.create_viewports_for_session_users = function(l_16_0)
	local l_16_6, l_16_7, l_16_8, l_16_9, l_16_10, l_16_11 = nil
	local l_16_1 = {}
	local l_16_2 = managers.local_session_user:users()
	for i_0,i_1 in pairs(l_16_2) do
		if not l_16_0._user_to_viewport[i_1] then
			l_16_0:create_viewport_for_session_user(i_1)
		end
	end
end

UserViewportManager.set_assigned_units_to_viewports = function(l_17_0)
	local l_17_4, l_17_5, l_17_6, l_17_7, l_17_8, l_17_9, l_17_10 = nil
	for i_0,i_1 in pairs(l_17_0._user_to_viewport) do
		if i_0:assigned_unit() and not i_1:viewed_unit() then
			i_1:view_unit(i_0:assigned_unit())
		end
	end
end

UserViewportManager.destroy_viewports_for_session_users_that_left = function(l_18_0)
	local l_18_5, l_18_6, l_18_7, l_18_8, l_18_9, l_18_10, l_18_11, l_18_12 = nil
	local l_18_1 = {}
	for i_0,i_1 in pairs(l_18_0._user_to_viewport) do
		if not managers.local_session_user:has_user(i_0) then
			l_18_1[i_0] = i_1
		end
	end
	for i_0,i_1 in pairs(l_18_1) do
		l_18_0:destroy_viewport_for_session_user(i_0, i_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UserViewportManager.create_viewport_for_session_user = function(l_19_0, l_19_1)
	local l_19_2 = l_19_1:assigned_unit()
	if not l_19_2 then
		return 
	end
	assert(alive(l_19_2))
	local l_19_3 = l_19_0:create_user_viewport(l_19_1)
	l_19_3:view_unit(l_19_2)
	l_19_0:_adjust_viewport_parameters()
end

UserViewportManager.destroy_viewport_for_session_user = function(l_20_0, l_20_1, l_20_2)
	assert(l_20_2)
	l_20_0._user_to_viewport[l_20_1] = nil
	assert(l_20_2._splittable_viewport)
	managers.splittable_viewport:destroy_viewport(l_20_2._splittable_viewport, l_20_1._wanted_player_slot_id)
	l_20_2:destroy()
end

UserViewportManager.enable_viewport_creation = function(l_21_0)
	l_21_0._viewport_creation_enabled = true
end

UserViewportManager.pause_all_sounds = function(l_22_0)
	local l_22_4, l_22_5, l_22_6, l_22_7 = nil
	if l_22_0._all_listeners_paused then
		return 
	end
	for i_0,i_1 in pairs(l_22_0._user_to_viewport) do
		i_1:pause_listener()
	end
	l_22_0._all_listeners_paused = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UserViewportManager.resume_all_sounds = function(l_23_0)
	local l_23_4, l_23_5, l_23_6, l_23_7 = nil
	if not l_23_0._all_listeners_paused then
		return 
	end
	for i_0,i_1 in pairs(l_23_0._user_to_viewport) do
		i_1:resume_listener()
	end
	l_23_0._all_listeners_paused = false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UserViewportManager.hide_all_huds = function(l_24_0)
	local l_24_4, l_24_5, l_24_6, l_24_7 = nil
	for i_0,i_1 in pairs(l_24_0._user_to_viewport) do
		i_1:remove_hud()
	end
end

UserViewportManager.show_all_huds = function(l_25_0)
	local l_25_4, l_25_5, l_25_6, l_25_7 = nil
	for i_0,i_1 in pairs(l_25_0._user_to_viewport) do
		i_1:add_hud()
	end
end

UserViewportManager._adjust_viewport_parameters_event = function(l_26_0)
	local l_26_4, l_26_5, l_26_6, l_26_7 = nil
	for i_0,i_1 in pairs(l_26_0._user_to_viewport) do
		local l_26_10 = nil
		if (i_1._splittable_viewport:script_viewport():environment_change_alternative() and not RenderSettings.split_screen) or not i_1._splittable_viewport:script_viewport():environment_change_alternative() and RenderSettings.split_screen then
			l_26_10:set_environment(i_1._splittable_viewport:script_viewport():environment_change_name(), tweak_data.player.camera.split_screen_environment_blend)
		end
	end
end

UserViewportManager._adjust_viewport_parameters = function(l_27_0)
	local l_27_5, l_27_6, l_27_7, l_27_8 = nil
	if not RenderSettings.split_screen or not l_27_0._far_range_split_screen then
		local l_27_1 = l_27_0._far_range_single_player
	end
	for i_0,i_1 in pairs(l_27_0._user_to_viewport) do
		local l_27_2 = nil
		i_1:engine_camera():set_far_range(l_27_2)
	end
end

UserViewportManager.set_far_range = function(l_28_0, l_28_1, l_28_2)
	l_28_0._far_range_single_player = l_28_1
	l_28_0._far_range_split_screen = l_28_2
end


