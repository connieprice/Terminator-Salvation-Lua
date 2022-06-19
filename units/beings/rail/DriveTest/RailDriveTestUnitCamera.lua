require("shared/camera/CameraRoot")
RailDriveTestUnitCamera = RailDriveTestUnitCamera or class(CameraRoot)
function RailDriveTestUnitCamera.init(A0_0, A1_1)
	local L2_2
	L2_2 = CameraRoot
	L2_2 = L2_2.init
	L2_2(A0_0, A1_1)
	L2_2 = A0_0.read_cameras
	L2_2(A0_0, "rail_drive_test_camera")
	L2_2 = A0_0.view_camera
	L2_2(A0_0, "unit")
	L2_2 = A0_0.find_camera
	L2_2 = L2_2(A0_0, "rail_drive_test_camera")
	assert(L2_2)
	L2_2._unit:set_local_position(Vector3(0, 0, A0_0.height))
end
