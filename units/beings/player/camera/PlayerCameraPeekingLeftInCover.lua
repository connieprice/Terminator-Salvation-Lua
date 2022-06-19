require("units/beings/player/camera/PlayerCameraState")
PlayerCameraPeekingLeftInCover = PlayerCameraPeekingLeftInCover or class(PlayerCameraState)
function PlayerCameraPeekingLeftInCover.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraPeekingLeftInCover)
	A0_0:_set_camera_name("zoom_aim_left")
end
