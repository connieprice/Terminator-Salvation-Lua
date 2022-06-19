require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraPeekingLeftInCover then
	PlayerCameraPeekingLeftInCover = class(PlayerCameraState)
end
PlayerCameraPeekingLeftInCover.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraPeekingLeftInCover)
	l_1_0:_set_camera_name("zoom_aim_left")
end


