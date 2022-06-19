if not UserViewport then
	UserViewport = class()
end
UserViewport.preload = function()
	local l_1_5, l_1_6, l_1_7 = nil
	UserViewport._indoor_environments = {}
	local l_1_0 = File:new_parse_xml("data/settings/indoor_environments.xml")
	local l_1_1 = l_1_0:children()
	local l_1_2 = l_1_1
	for i_0 in l_1_2 do
		local l_1_9 = i_0:parameter("name")
		UserViewport._indoor_environments[l_1_9] = toboolean(l_1_8:parameter("value"))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UserViewport.init = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4)
	l_2_0._user = l_2_1
	l_2_0._splittable_viewport = l_2_2
	l_2_0._root_panel = l_2_3
	l_2_0._panel = l_2_3:panel()
	l_2_0._listener_paused = l_2_4
	l_2_0._callback = function(...)
		-- upvalues: l_2_0
		l_2_0:_change_environment(...)
  end
	managers.sound_environment:add_environment_changed_callback(l_2_0._callback)
	l_2_0:set_dof_updator(callback(l_2_0, l_2_0, "_update_dof"))
end

UserViewport.destroy = function(l_3_0)
	l_3_0._splittable_viewport:destroy()
	l_3_0._splittable_viewport = nil
	l_3_0:release_viewed_unit()
	l_3_0._root_panel:remove(l_3_0._panel)
	managers.sound_environment:remove_environment_changed_callback(l_3_0._callback)
end

UserViewport.release_viewed_unit = function(l_4_0)
	if not l_4_0._listener_paused then
		l_4_0:_remove_sound_listener()
	end
	if not alive(l_4_0._unit) then
		return 
	end
	l_4_0:remove_hud()
	if l_4_0._unit:world_sound() then
		l_4_0._unit:world_sound():disable()
	end
	l_4_0._unit:camera():deactivate()
	l_4_0._unit = nil
end

UserViewport.viewed_unit = function(l_5_0)
	return l_5_0._unit
end

UserViewport.view_unit = function(l_6_0, l_6_1)
	assert(l_6_1.camera)
	l_6_0:release_viewed_unit()
	l_6_0._unit = l_6_1
	if not l_6_0._listener_paused then
		l_6_0:_remove_sound_listener()
		l_6_0:_add_sound_listener()
	end
	l_6_0:add_hud()
	if l_6_0._unit:world_sound() then
		l_6_0._unit:world_sound():enable()
	end
	l_6_0._unit:camera():activate()
end

UserViewport.update = function(l_7_0)
	if l_7_0._unit and not alive(l_7_0._unit) then
		l_7_0._unit = nil
		l_7_0:release_viewed_unit()
	end
end

UserViewport.render = function(l_8_0)
	l_8_0:update_hud_panel()
	if not alive(l_8_0._unit) then
		return 
	end
	l_8_0._user:set_rumble_listener_transform(l_8_0._unit:position(), l_8_0._unit:rotation())
	l_8_0:_update_cameras()
end

UserViewport.engine_camera = function(l_9_0)
	local l_9_1, l_9_2 = l_9_0._splittable_viewport:engine_camera, l_9_0._splittable_viewport
	return l_9_1(l_9_2)
end

UserViewport._update_cameras = function(l_10_0)
	local l_10_1 = l_10_0._unit:camera()
	local l_10_2 = managers.worldcamera:current_world_camera()
	local l_10_3 = l_10_0._splittable_viewport:engine_camera()
	l_10_1:render()
	local l_10_4 = l_10_0._unit:camera_data()
	assert(l_10_4)
	l_10_4.camera_position = l_10_1:camera_position()
	l_10_4.camera_rotation = l_10_1:camera_rotation()
	l_10_3:set_position(l_10_1:camera_position())
	l_10_3:new_set_rotation(l_10_1:camera_rotation())
	local l_10_5 = l_10_1:camera_fov()
	if l_10_5 and l_10_5 ~= 0 then
		l_10_3:set_fov(l_10_5)
	else
		l_10_3:set_fov(90)
	end
	if not l_10_2 then
		l_10_0._dof_updator(l_10_1:camera_dof())
	end
end

UserViewport.set_dof_updator = function(l_11_0, l_11_1)
	l_11_0._dof_updator = l_11_1
end

UserViewport._update_dof = function(l_12_0, l_12_1)
	if not l_12_1 then
		l_12_0._splittable_viewport:script_viewport():set_dof(0, 0, 0, 0, 0)
		return 
	end
	l_12_0._splittable_viewport:script_viewport():set_dof(l_12_1.amount, l_12_1.near_min, l_12_1.near_max, l_12_1.far_min, l_12_1.far_max)
end

UserViewport.update_hud_panel = function(l_13_0)
	local l_13_1 = l_13_0._splittable_viewport.rectangle
	local l_13_2 = l_13_1.left * l_13_0._root_panel:width()
	local l_13_3 = l_13_1.top * l_13_0._root_panel:height()
	local l_13_4 = l_13_1:width() * l_13_0._root_panel:width()
	local l_13_5 = l_13_1:height() * l_13_0._root_panel:height()
	l_13_0._panel:set_x(l_13_2)
	l_13_0._panel:set_y(l_13_3)
	l_13_0._panel:set_width(l_13_4)
	l_13_0._panel:set_height(l_13_5)
end

UserViewport.pause_listener = function(l_14_0)
	l_14_0:_remove_sound_listener()
	l_14_0._listener_paused = true
end

UserViewport.resume_listener = function(l_15_0)
	l_15_0:_add_sound_listener()
	l_15_0._listener_paused = false
end

UserViewport._add_sound_listener = function(l_16_0)
	if l_16_0._unit:get_object("listener") == nil then
		local l_16_1, l_16_2 = l_16_0._unit:orientation_object()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_16_0:_setup_sound_listener(l_16_1)
end

UserViewport._change_environment = function(l_17_0, l_17_1)
	if l_17_0._sound_listener_id then
		if UserViewport._indoor_environments[l_17_1] ~= nil then
			Sound:set_listener_parameter(l_17_0._sound_listener_id, "environment", "default")
		end
	else
		Sound:set_listener_parameter(l_17_0._sound_listener_id, "environment", "outdoor")
	end
end

UserViewport._setup_sound_listener = function(l_18_0, l_18_1)
	local l_18_2 = l_18_0._splittable_viewport:engine_camera()
	l_18_0._sound_listener_id = Sound:add_listener(l_18_1, l_18_2, l_18_2)
	local l_18_3 = nil
	if l_18_0._unit:name() == "john_connor" then
		local l_18_4 = {}
		l_18_4.listener = l_18_0._sound_listener_id
		l_18_4.active = true
		l_18_4.primary = true
		l_18_3 = l_18_4
	else
		local l_18_5 = {}
		l_18_5.listener = l_18_0._sound_listener_id
		l_18_5.active = true
		l_18_5.primary = false
		l_18_3 = l_18_5
	end
	local l_18_6 = managers.sound_environment:environment_at_position(l_18_0._unit:position())
	l_18_0:_change_environment(l_18_6)
	l_18_0._check_object_id = managers.sound_environment:add_listener(l_18_3)
end

UserViewport._remove_sound_listener = function(l_19_0)
	if l_19_0._sound_listener_id then
		managers.sound_environment:remove_check_object(l_19_0._check_object_id)
		l_19_0._check_object_id = nil
		Sound:remove_listener(l_19_0._sound_listener_id)
		l_19_0._sound_listener_id = nil
	end
end

UserViewport.add_hud = function(l_20_0)
	if l_20_0._unit:hud() then
		l_20_0._unit:hud():set_gui_panel(l_20_0._panel, l_20_0)
	end
	if l_20_0._unit:hud_sound() then
		l_20_0._unit:set_extension_update_enabled("hud_sound", true)
	end
end

UserViewport.remove_hud = function(l_21_0)
	if l_21_0._unit and l_21_0._unit:hud() then
		l_21_0._unit:hud():release_gui_panel()
	end
	if l_21_0._unit:hud_sound() then
		l_21_0._unit:set_extension_update_enabled("hud_sound", false)
	end
end

UserViewport.engine_camera = function(l_22_0)
	local l_22_1, l_22_2 = l_22_0._splittable_viewport:engine_camera, l_22_0._splittable_viewport
	return l_22_1(l_22_2)
end

UserViewport.engine_viewport = function(l_23_0)
	local l_23_1, l_23_2 = l_23_0._splittable_viewport:get_engine_viewport, l_23_0._splittable_viewport
	return l_23_1(l_23_2)
end

UserViewport.save = function(l_24_0, l_24_1)
	l_24_1.user_index = l_24_0._user:index()
	l_24_1.viewport_index = l_24_0._splittable_viewport:index()
end

UserViewport.load = function(l_25_0, l_25_1)
	l_25_0._user = managers.local_user:user(l_25_1.user_index)
	l_25_0._splittable_viewport = managers.splittable_viewport:viewport(l_25_1._viewport_index)
end


