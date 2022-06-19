if not Menu2DCamera then
	Menu2DCamera = class()
end
local l_0_0 = Menu2DCamera
local l_0_1 = {}
local l_0_2 = {}
l_0_2.difficulty_level = "mainmenu_to_difficulty_level"
l_0_2.options = "mainmenu_to_options"
l_0_2.checkpoints = "mainmenu_to_checkpoints"
l_0_1.mainmenu = l_0_2
l_0_1.confirm_overwrite_save_game, l_0_2 = l_0_2, {difficulty_level = "mainmenu_to_difficulty_level"}
l_0_1.confirm_overwrite_replay_scenario, l_0_2 = l_0_2, {checkpoints = "mainmenu_to_checkpoints"}
l_0_0._cameras = l_0_1
l_0_0 = Menu2DCamera
l_0_1 = function(l_1_0)
	World:preload_unit("player_cam")
	l_1_0:_set_camera_pos()
end

l_0_0.init = l_0_1
l_0_0 = Menu2DCamera
l_0_1 = function(l_2_0)
	local l_2_1 = true
	managers.worldcamera:play_world_camera("mainmenu_to_options", l_2_1)
end

l_0_0._set_camera_pos = l_0_1
l_0_0 = Menu2DCamera
l_0_1 = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_0:_lookup_camera_name(l_3_1, l_3_2)
	if l_3_4 then
		local l_3_5 = managers.worldcamera:current_world_camera()
		if not l_3_5 or not l_3_5:playing() then
			managers.worldcamera:play_world_camera(l_3_4, l_3_3)
		else
			local l_3_6 = nil
			if l_3_3 then
				l_3_6 = managers.worldcamera:current_world_camera():current_time()
			else
				l_3_6 = l_3_5:current_time() - TimerManager:main():delta_time()
			end
			managers.worldcamera:play_world_camera(l_3_4, l_3_3, l_3_6)
		end
		l_3_0._wc_backward = l_3_3
	end
	return l_3_4 ~= nil
end

l_0_0.play = l_0_1
l_0_0 = Menu2DCamera
l_0_1 = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = Menu2DCamera._cameras[l_4_1]
	if l_4_3 then
		local l_4_4 = l_4_3[l_4_2]
		if l_4_4 then
			return l_4_4
		end
	end
end

l_0_0._lookup_camera_name = l_0_1

