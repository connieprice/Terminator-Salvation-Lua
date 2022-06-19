if not PlayerTankCamera then
	PlayerTankCamera = class(CameraRoot)
end
PlayerTankCamera.init = function(l_1_0, l_1_1)
	CameraRoot.init(l_1_0, l_1_1)
	l_1_0._root_camera = managers.camera:create_cameras("player_tank", l_1_1)
	l_1_0:build_camera_name_map()
end

PlayerTankCamera.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = l_2_1:player_data()
	local l_2_5 = l_2_4.rail_vehicle_camera
	local l_2_6 = l_2_4.rail_vehicle_camera_blend_time
	if l_2_5 then
		l_2_0:view_camera(l_2_5, l_2_6)
	else
		l_2_0:view_camera("default_tank_camera", 0)
	end
	CameraRoot.update(l_2_0, l_2_1, l_2_2, l_2_3)
end


