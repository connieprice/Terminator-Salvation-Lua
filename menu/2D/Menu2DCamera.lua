Menu2DCamera = Menu2DCamera or class()
Menu2DCamera._cameras = {
	mainmenu = {
		difficulty_level = "mainmenu_to_difficulty_level",
		options = "mainmenu_to_options",
		checkpoints = "mainmenu_to_checkpoints"
	},
	confirm_overwrite_save_game = {
		difficulty_level = "mainmenu_to_difficulty_level"
	},
	confirm_overwrite_replay_scenario = {
		checkpoints = "mainmenu_to_checkpoints"
	}
}
function Menu2DCamera.init(A0_0)
	World:preload_unit("player_cam")
	A0_0:_set_camera_pos()
end
function Menu2DCamera._set_camera_pos(A0_1)
	local L1_2
	L1_2 = true
	managers.worldcamera:play_world_camera("mainmenu_to_options", L1_2)
end
function Menu2DCamera.play(A0_3, A1_4, A2_5, A3_6)
	local L4_7, L5_8, L6_9
	L5_8 = A0_3
	L4_7 = A0_3._lookup_camera_name
	L6_9 = A1_4
	L4_7 = L4_7(L5_8, L6_9, A2_5)
	if L4_7 then
		L5_8 = managers
		L5_8 = L5_8.worldcamera
		L6_9 = L5_8
		L5_8 = L5_8.current_world_camera
		L5_8 = L5_8(L6_9)
		if L5_8 then
			L6_9 = L5_8.playing
			L6_9 = L6_9(L5_8)
		else
			if not L6_9 then
				L6_9 = managers
				L6_9 = L6_9.worldcamera
				L6_9 = L6_9.play_world_camera
				L6_9(L6_9, L4_7, A3_6)
		end
		else
			L6_9 = nil
			if A3_6 then
				L6_9 = managers.worldcamera:current_world_camera():current_time()
			else
				L6_9 = L5_8:current_time() - TimerManager:main():delta_time()
			end
			managers.worldcamera:play_world_camera(L4_7, A3_6, L6_9)
		end
		A0_3._wc_backward = A3_6
	end
	L5_8 = L4_7 ~= nil
	return L5_8
end
function Menu2DCamera._lookup_camera_name(A0_10, A1_11, A2_12)
	local L3_13
	L3_13 = Menu2DCamera
	L3_13 = L3_13._cameras
	L3_13 = L3_13[A1_11]
	if L3_13 and L3_13[A2_12] then
		return L3_13[A2_12]
	end
end
