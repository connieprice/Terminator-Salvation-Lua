require("units/beings/player/camera/PlayerCameraState")
PlayerCameraPeekingUpInCover = PlayerCameraPeekingUpInCover or class(PlayerCameraState)
function PlayerCameraPeekingUpInCover.init(A0_0)
	local L1_1
	L1_1 = PlayerCameraState
	L1_1 = L1_1.init
	L1_1(A0_0, PlayerCameraPeekingUpInCover)
	L1_1 = nil
	if A0_0._player_data.facing_right_in_cover then
		L1_1 = "zoom_aim_right"
	else
		L1_1 = "zoom_aim_left"
	end
	A0_0:_set_camera_name(L1_1)
end
