require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraOnGround then
	PlayerCameraOnGround = class(PlayerCameraState)
end
PlayerCameraOnGround.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraOnGround)
end

PlayerCameraOnGround.update = function(l_2_0, l_2_1)
	local l_2_2 = nil
	if l_2_0._player_data.is_precision_aiming then
		l_2_2 = "zoom_aim_right"
	else
		l_2_2 = "onground"
	end
	l_2_0:_set_camera_name(l_2_2)
end


