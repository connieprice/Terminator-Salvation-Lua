require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraEnteringCover then
	PlayerCameraEnteringCover = class(PlayerCameraState)
end
PlayerCameraEnteringCover.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraEnteringCover)
end

PlayerCameraEnteringCover.exit = function(l_2_0)
	l_2_0._camera:_switch_cover_camera_index()
end

PlayerCameraEnteringCover.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._camera:_quick_move_target_camera_name()
	assert(l_3_2)
	if l_3_2 ~= l_3_0._cover_camera_name then
		l_3_0._cover_camera_name = l_3_2
		local l_3_3 = l_3_2 .. "_" .. l_3_0._camera:_available_cover_camera_index()
		local l_3_4 = l_3_0._camera:find_camera(l_3_3)
		assert(l_3_4)
		l_3_0._cover_camera = l_3_4
		l_3_0:_set_camera_name(l_3_3)
	end
	l_3_0._camera:_update_quickmove_cover_edge_modifiers(l_3_0._cover_camera)
end


