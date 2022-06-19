require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraWounded then
	PlayerCameraWounded = class(PlayerCameraState)
end
PlayerCameraWounded.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraWounded)
	l_1_0:_set_camera_name("wounded")
end


