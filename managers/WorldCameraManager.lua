require("managers/WorldCamera")
WorldCameraManager = WorldCameraManager or class(CoreWorldCameraManager)
function WorldCameraManager.init(A0_0)
	local L1_1
	L1_1 = CoreWorldCameraManager
	L1_1 = L1_1.init
	L1_1(A0_0)
	L1_1 = World
	L1_1 = L1_1.preload_unit
	L1_1(L1_1, "world_camera_mover")
	A0_0._use_gui = false
	A0_0._default_shake_animation_state = "idle"
	A0_0._default_shake_animation_delay = 0
	A0_0._default_shake_animation_loop = false
	A0_0._current_animation = nil
	L1_1 = A0_0._camera_unit
	if not L1_1 then
		L1_1 = "player_cam"
		World:preload_unit(L1_1)
		A0_0._camera_unit = World:spawn_unit(L1_1, Vector3(), Rotation())
		A0_0._camera_unit:play_redirect("idle")
		A0_0._camera_unit:set_driving("script")
		A0_0._camera_unit:set_visible(false)
	end
end
function WorldCameraManager.destroy(A0_2)
	if A0_2._camera_unit then
		A0_2._camera_unit:set_slot(0)
		A0_2._camera_unit = nil
	end
	CoreWorldCameraManager.destroy(A0_2)
end
function WorldCameraManager.get_camera_unit(A0_3)
	local L1_4
	L1_4 = A0_3._camera_unit
	return L1_4
end
function WorldCameraManager._create_listener(A0_5)
	local L1_6
end
function WorldCameraManager._destroy_listener(A0_7)
	local L1_8
end
function WorldCameraManager._set_listener_enabled(A0_9, A1_10)
	if A1_10 then
		A0_9:enable_listener()
		if managers.user_viewport then
			managers.user_viewport:pause_all_sounds()
		end
	else
		A0_9:disable_listener()
		if managers.user_viewport then
			managers.user_viewport:resume_all_sounds()
		end
	end
end
function WorldCameraManager.enable_listener(A0_11)
	if not A0_11._sound_listener_id then
		A0_11._sound_listener_id = Sound:add_listener(A0_11._camera)
		Sound:set_listener_parameter(A0_11._sound_listener_id, "environment", "outdoor")
	end
end
function WorldCameraManager.disable_listener(A0_12)
	if A0_12._sound_listener_id then
		Sound:remove_listener(A0_12._sound_listener_id)
		A0_12._sound_listener_id = nil
	end
end
function WorldCameraManager.update_dof_values(A0_13, A1_14, A2_15, A3_16, A4_17)
	local L5_18, L6_19, L7_20, L8_21
	L5_18 = CoreWorldCameraManager
	L5_18 = L5_18.update_dof_values
	L6_19 = A0_13
	L7_20 = A1_14
	L8_21 = A2_15
	L5_18(L6_19, L7_20, L8_21, A3_16, A4_17)
	L5_18 = math
	L5_18 = L5_18.clamp
	L6_19 = A0_13._current_near_dof
	L7_20 = A0_13._current_dof_padding
	L6_19 = L6_19 - L7_20
	L7_20 = 1
	L8_21 = 1000000
	L5_18 = L5_18(L6_19, L7_20, L8_21)
	L6_19 = A0_13._current_near_dof
	L7_20 = A0_13._current_far_dof
	L8_21 = A0_13._current_far_dof
	L8_21 = L8_21 + A0_13._current_dof_padding
	A0_13._viewport:set_dof(A0_13._current_dof_clamp, L5_18, L6_19, L7_20, L8_21)
end
function WorldCameraManager.stop_simulation(A0_22)
	CoreWorldCameraManager.stop_simulation(A0_22)
	if not A0_22._current_world_camera then
		return
	end
	A0_22._current_world_camera:stop()
	if A0_22._current_sequence then
		A0_22._current_world_camera = nil
		A0_22:_sequence_done()
	end
end
function WorldCameraManager.start_dof(A0_23)
	if not A0_23._using_dof then
		A0_23._using_dof = true
	end
end
function WorldCameraManager.stop_dof(A0_24)
	A0_24._viewport:set_dof(0, 0, 0, 0, 0)
	A0_24._using_dof = false
end
function WorldCameraManager._set_gui_visible(A0_25, A1_26)
	A0_25._workspace:hide()
end
function WorldCameraManager.default_shake_animation_state(A0_27)
	local L1_28
	L1_28 = A0_27._default_shake_animation_state
	return L1_28
end
function WorldCameraManager.default_shake_animation_delay(A0_29)
	local L1_30
	L1_30 = A0_29._default_shake_animation_delay
	return L1_30
end
function WorldCameraManager.default_shake_animation_loop(A0_31)
	local L1_32
	L1_32 = A0_31._default_shake_animation_loop
	return L1_32
end
function WorldCameraManager.play_world_camera(A0_33, A1_34, A2_35, A3_36)
	local L4_37
	A0_33._backwards = A2_35
	L4_37 = {
		A0_33:_camera_sequence_table(A1_34)
	}
	if A3_36 then
		if A2_35 then
			L4_37[1].stop = A3_36
		else
			L4_37[1].start = A3_36
		end
	end
	A0_33:play_world_camera_sequence(nil, L4_37)
end
function WorldCameraManager.backwards(A0_38)
	local L1_39
	L1_39 = A0_38._backwards
	return L1_39
end
function WorldCameraManager.new_play_world_camera(A0_40, A1_41)
	CoreWorldCameraManager.new_play_world_camera(A0_40, A1_41)
end
