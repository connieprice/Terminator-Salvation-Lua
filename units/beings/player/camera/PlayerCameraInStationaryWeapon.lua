require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraInStationaryWeapon then
	PlayerCameraInStationaryWeapon = class(PlayerCameraState)
end
PlayerCameraInStationaryWeapon.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraInStationaryWeapon)
end

PlayerCameraInStationaryWeapon.update = function(l_2_0, l_2_1)
	local l_2_2 = nil
	if l_2_0._player_data.is_precision_aiming then
		l_2_2 = "stationary_weapon_zoom_aim"
	else
		l_2_2 = "stationary_weapon"
	end
	l_2_0:_set_camera_name(l_2_2)
end


