require("units/beings/player/camera/PlayerCameraState")
PlayerCameraLeavingCover = PlayerCameraLeavingCover or class(PlayerCameraState)
function PlayerCameraLeavingCover.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraLeavingCover)
	A0_0:_set_camera_name("onground")
end
