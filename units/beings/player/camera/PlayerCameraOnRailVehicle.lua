require("units/beings/player/camera/PlayerCameraState")
if not PlayerCameraOnRailVehicle then
	PlayerCameraOnRailVehicle = class(PlayerCameraState)
end
PlayerCameraOnRailVehicle.init = function(l_1_0)
	PlayerCameraState.init(l_1_0, PlayerCameraOnRailVehicle)
	l_1_0:_set_collision(l_1_0._camera._update_no_collision)
end

PlayerCameraOnRailVehicle.exit = function(l_2_0)
	l_2_0._camera._state_blend_time_override = nil
end

PlayerCameraOnRailVehicle.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._player_data
	l_3_0:_set_camera_name(l_3_2.rail_vehicle_camera)
	l_3_0._camera._state_blend_time_override = l_3_2.rail_vehicle_camera_blend_time
end


