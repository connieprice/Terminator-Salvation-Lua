PlayerTankCamera = PlayerTankCamera or class(CameraRoot)
function PlayerTankCamera.init(A0_0, A1_1)
	CameraRoot.init(A0_0, A1_1)
	A0_0._root_camera = managers.camera:create_cameras("player_tank", A1_1)
	A0_0:build_camera_name_map()
end
function PlayerTankCamera.update(A0_2, A1_3, A2_4, A3_5)
	local L4_6, L5_7, L6_8
	L5_7 = A1_3
	L4_6 = A1_3.player_data
	L4_6 = L4_6(L5_7)
	L5_7 = L4_6.rail_vehicle_camera
	L6_8 = L4_6.rail_vehicle_camera_blend_time
	if L5_7 then
		A0_2:view_camera(L5_7, L6_8)
	else
		A0_2:view_camera("default_tank_camera", 0)
	end
	CameraRoot.update(A0_2, A1_3, A2_4, A3_5)
end
