require("shared/camera/CameraRoot")
UnitCamera = UnitCamera or class(CameraRoot)
function UnitCamera.activate(A0_0)
	local L1_1
	L1_1 = CameraRoot
	L1_1 = L1_1.activate
	L1_1(A0_0)
	L1_1 = managers
	L1_1 = L1_1.camera
	L1_1 = L1_1.create_cameras
	L1_1 = L1_1(L1_1, "generic_unit", A0_0._unit)
	A0_0._root_camera = L1_1
	L1_1 = A0_0.build_camera_name_map
	L1_1(A0_0)
	L1_1 = A0_0.view_camera
	L1_1(A0_0, "unit")
	L1_1 = A0_0.height
	if L1_1 then
		L1_1 = A0_0.find_camera
		L1_1 = L1_1(A0_0, "unit_offset")
		assert(L1_1)
		L1_1:set_local_position(Vector3(0, 0, A0_0.height))
	end
end
