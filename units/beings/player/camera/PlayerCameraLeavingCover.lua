require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraLeavingCover then
	PlayerCameraLeavingCover = class(PlayerCameraState)
end
PlayerCameraLeavingCover.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraLeavingCover)
	l_1_0:_set_camera_name("onground")
end


