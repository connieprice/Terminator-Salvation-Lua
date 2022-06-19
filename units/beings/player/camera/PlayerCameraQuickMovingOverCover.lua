require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraQuickMovingOverCover then
	PlayerCameraQuickMovingOverCover = class(PlayerCameraState)
end
PlayerCameraQuickMovingOverCover.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraQuickMovingOverCover)
end

PlayerCameraQuickMovingOverCover.exit = function(l_2_0)
	l_2_0._camera:_switch_cover_camera_index()
end

PlayerCameraQuickMovingOverCover.update = function(l_3_0, l_3_1)
	local l_3_2 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_0._player_data.quick_moving_leap_stretch or not l_3_0._player_data.quick_moving then
		l_3_2 = l_3_0._camera:_quick_move_target_camera_name() .. "_" .. l_3_0._camera:_available_cover_camera_index()
		local l_3_3 = nil
		assert(l_3_0._camera:find_camera(l_3_2), l_3_2)
		l_3_0._camera:_update_quickmove_cover_edge_modifiers(l_3_0._camera:find_camera(l_3_2))
	else
		l_3_2 = "quick_move_over_cover"
	end
	l_3_0:_set_camera_name(l_3_2)
end


