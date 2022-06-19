require("units/beings/player/camera/PlayerCameraState")
PlayerCameraWounded = PlayerCameraWounded or class(PlayerCameraState)
function PlayerCameraWounded.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraWounded)
	A0_0:_set_camera_name("wounded")
end
