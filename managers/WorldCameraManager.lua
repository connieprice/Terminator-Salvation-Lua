require("managers/WorldCamera")
if not WorldCameraManager then
	WorldCameraManager = class(CoreWorldCameraManager)
end
WorldCameraManager.init = function(l_1_0)
	CoreWorldCameraManager.init(l_1_0)
	World:preload_unit("world_camera_mover")
	l_1_0._use_gui = false
	l_1_0._default_shake_animation_state = "idle"
	l_1_0._default_shake_animation_delay = 0
	l_1_0._default_shake_animation_loop = false
	l_1_0._current_animation = nil
	if not l_1_0._camera_unit then
		local l_1_1 = "player_cam"
		World:preload_unit(l_1_1)
		l_1_0._camera_unit = World:spawn_unit(l_1_1, Vector3(), Rotation())
		l_1_0._camera_unit:play_redirect("idle")
		l_1_0._camera_unit:set_driving("script")
		l_1_0._camera_unit:set_visible(false)
	end
end

WorldCameraManager.destroy = function(l_2_0)
	if l_2_0._camera_unit then
		l_2_0._camera_unit:set_slot(0)
		l_2_0._camera_unit = nil
	end
	CoreWorldCameraManager.destroy(l_2_0)
end

WorldCameraManager.get_camera_unit = function(l_3_0)
	return l_3_0._camera_unit
end

WorldCameraManager._create_listener = function(l_4_0)
end

WorldCameraManager._destroy_listener = function(l_5_0)
end

WorldCameraManager._set_listener_enabled = function(l_6_0, l_6_1)
	if l_6_1 then
		l_6_0:enable_listener()
		if managers.user_viewport then
			managers.user_viewport:pause_all_sounds()
		end
	else
		l_6_0:disable_listener()
	if managers.user_viewport then
		end
		managers.user_viewport:resume_all_sounds()
	end
end

WorldCameraManager.enable_listener = function(l_7_0)
	if not l_7_0._sound_listener_id then
		l_7_0._sound_listener_id = Sound:add_listener(l_7_0._camera)
		Sound:set_listener_parameter(l_7_0._sound_listener_id, "environment", "outdoor")
	end
end

WorldCameraManager.disable_listener = function(l_8_0)
	if l_8_0._sound_listener_id then
		Sound:remove_listener(l_8_0._sound_listener_id)
		l_8_0._sound_listener_id = nil
	end
end

WorldCameraManager.update_dof_values = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4)
	CoreWorldCameraManager.update_dof_values(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4)
	local l_9_5 = math.clamp(l_9_0._current_near_dof - l_9_0._current_dof_padding, 1, 1000000)
	local l_9_6 = l_9_0._current_near_dof
	local l_9_7 = l_9_0._current_far_dof
	local l_9_8 = l_9_0._current_far_dof + l_9_0._current_dof_padding
	l_9_0._viewport:set_dof(l_9_0._current_dof_clamp, l_9_5, l_9_6, l_9_7, l_9_8)
end

WorldCameraManager.stop_simulation = function(l_10_0)
	CoreWorldCameraManager.stop_simulation(l_10_0)
	if not l_10_0._current_world_camera then
		return 
	end
	local l_10_1 = l_10_0._current_world_camera
	l_10_1:stop()
	if l_10_0._current_sequence then
		l_10_0._current_world_camera = nil
		l_10_0:_sequence_done()
	end
end

WorldCameraManager.start_dof = function(l_11_0)
	if not l_11_0._using_dof then
		l_11_0._using_dof = true
	end
end

WorldCameraManager.stop_dof = function(l_12_0)
	l_12_0._viewport:set_dof(0, 0, 0, 0, 0)
	l_12_0._using_dof = false
end

WorldCameraManager._set_gui_visible = function(l_13_0, l_13_1)
	l_13_0._workspace:hide()
end

WorldCameraManager.default_shake_animation_state = function(l_14_0)
	return l_14_0._default_shake_animation_state
end

WorldCameraManager.default_shake_animation_delay = function(l_15_0)
	return l_15_0._default_shake_animation_delay
end

WorldCameraManager.default_shake_animation_loop = function(l_16_0)
	return l_16_0._default_shake_animation_loop
end

WorldCameraManager.play_world_camera = function(l_17_0, l_17_1, l_17_2, l_17_3)
	l_17_0._backwards = l_17_2
	do
		local l_17_4 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_17_3 then
			if l_17_2 then
				do return end
			end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_17_0:play_world_camera_sequence()
	end
	 -- WARNING: undefined locals caused missing assignments!
end

WorldCameraManager.backwards = function(l_18_0)
	return l_18_0._backwards
end

WorldCameraManager.new_play_world_camera = function(l_19_0, l_19_1)
	local l_19_2 = l_19_0._world_cameras[l_19_1.name]
	CoreWorldCameraManager.new_play_world_camera(l_19_0, l_19_1)
end


