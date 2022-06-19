require("shared/camera/CameraRoot")
if not RailDriveTestUnitCamera then
	RailDriveTestUnitCamera = class(CameraRoot)
end
RailDriveTestUnitCamera.init = function(l_1_0, l_1_1)
	CameraRoot.init(l_1_0, l_1_1)
	l_1_0:read_cameras("rail_drive_test_camera")
	l_1_0:view_camera("unit")
	local l_1_2 = l_1_0:find_camera("rail_drive_test_camera")
	assert(l_1_2)
	l_1_2._unit:set_local_position(Vector3(0, 0, l_1_0.height))
end


