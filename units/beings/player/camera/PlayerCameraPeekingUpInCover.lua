require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraPeekingUpInCover then
	PlayerCameraPeekingUpInCover = class(PlayerCameraState)
end
PlayerCameraPeekingUpInCover.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraPeekingUpInCover)
	local l_1_1 = nil
	if l_1_0._player_data.facing_right_in_cover then
		l_1_1 = "zoom_aim_right"
	else
		l_1_1 = "zoom_aim_left"
	end
	l_1_0:_set_camera_name(l_1_1)
end


