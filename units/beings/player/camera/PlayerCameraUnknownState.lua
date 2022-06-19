require("units/beings/player/camera/PlayerCameraState")
PlayerCameraUnknownState = PlayerCameraUnknownState or class(PlayerCameraState)
function PlayerCameraUnknownState.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraUnknownState)
	A0_0:_set_camera_name("onground")
end
