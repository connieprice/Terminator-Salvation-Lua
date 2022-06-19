require("units/beings/player/camera/PlayerCameraState")
PlayerCameraOnGround = PlayerCameraOnGround or class(PlayerCameraState)
function PlayerCameraOnGround.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraOnGround)
end
function PlayerCameraOnGround.update(A0_1, A1_2)
	local L2_3
	if A0_1._player_data.is_precision_aiming then
		L2_3 = "zoom_aim_right"
	else
		L2_3 = "onground"
	end
	A0_1:_set_camera_name(L2_3)
end
