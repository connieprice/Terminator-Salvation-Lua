require("units/beings/player/camera/PlayerCameraState")
PlayerCameraOnRailVehicle = PlayerCameraOnRailVehicle or class(PlayerCameraState)
function PlayerCameraOnRailVehicle.init(A0_0)
	PlayerCameraState.init(A0_0, PlayerCameraOnRailVehicle)
	A0_0:_set_collision(A0_0._camera._update_no_collision)
end
function PlayerCameraOnRailVehicle.exit(A0_1)
	A0_1._camera._state_blend_time_override = nil
end
function PlayerCameraOnRailVehicle.update(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._player_data
	A0_2:_set_camera_name(L2_4.rail_vehicle_camera)
	A0_2._camera._state_blend_time_override = L2_4.rail_vehicle_camera_blend_time
end
