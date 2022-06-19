require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraUnknownState then
	PlayerCameraUnknownState = class(PlayerCameraState)
end
PlayerCameraUnknownState.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraUnknownState)
	l_1_0:_set_camera_name("onground")
end


