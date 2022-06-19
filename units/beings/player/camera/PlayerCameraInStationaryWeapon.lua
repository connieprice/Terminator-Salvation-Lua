require("units/beings/player/camera/PlayerCameraState")
PlayerCameraInStationaryWeapon = PlayerCameraInStationaryWeapon or class(PlayerCameraState)
function PlayerCameraInStationaryWeapon.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraInStationaryWeapon)
end
function PlayerCameraInStationaryWeapon.update(A0_1, A1_2)
	local L2_3
	if A0_1._player_data.is_precision_aiming then
		L2_3 = "stationary_weapon_zoom_aim"
	else
		L2_3 = "stationary_weapon"
	end
	A0_1:_set_camera_name(L2_3)
end
