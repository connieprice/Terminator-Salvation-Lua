require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraPeekingRightInCover then
	PlayerCameraPeekingRightInCover = class(PlayerCameraState)
end
PlayerCameraPeekingRightInCover.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraPeekingRightInCover)
	l_1_0:_set_camera_name("zoom_aim_right")
end


