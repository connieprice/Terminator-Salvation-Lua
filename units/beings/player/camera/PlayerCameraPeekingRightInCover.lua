require("units/beings/player/camera/PlayerCameraState")
PlayerCameraPeekingRightInCover = PlayerCameraPeekingRightInCover or class(PlayerCameraState)
function PlayerCameraPeekingRightInCover.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraPeekingRightInCover)
	A0_0:_set_camera_name("zoom_aim_right")
end
