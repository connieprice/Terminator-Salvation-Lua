local L0_0
L0_0 = require
L0_0("shared/TableSerializer")
L0_0 = require
L0_0("shared/camera/CameraMixer")
function L0_0(A0_1, A1_2, A2_3, A3_4, A4_5)
	local L5_6, L6_7, L7_8, L8_9, L9_10, L10_11
	L5_6 = A0_1.update
	L9_10 = A3_4
	L10_11 = A4_5
	L5_6(L6_7, L7_8, L8_9, L9_10, L10_11)
	L5_6 = A0_1._active_children
	A3_4 = A0_1._position
	A4_5 = A0_1._rotation
	for L9_10, L10_11 in L6_7(L7_8) do
		_UPVALUE0_(L10_11, A1_2, A2_3, A3_4, A4_5)
	end
end
CameraRoot = CameraRoot or class()
function CameraRoot.init(A0_12, A1_13)
	A0_12._unit = A1_13
	A0_12._active_count = 0
	A0_12:reset()
	A0_12._camera_name_map = {}
end
function CameraRoot.destroy(A0_14)
	if A0_14._root_camera then
		A0_14._root_camera:destroy()
	end
end
function CameraRoot.reset(A0_15)
	A0_15._time = 0
	A0_15._dt = 0
	A0_15._mixer = CameraMixer:new()
	A0_15._camera_data = {}
	A0_15._camera_data.position = Vector3(0, 0, 0)
	A0_15._camera_data.rotation = Rotation()
	A0_15._camera_data.constraint_yaw = 0
	A0_15._camera_data.constraint_pitch = 0
	A0_15._camera_data.constraint_rot = Rotation()
	A0_15._camera_data.fov = 0
	A0_15._camera_data.dof = nil
end
function CameraRoot._set_mixer_cameras_active(A0_16, A1_17)
	local L2_18
	L2_18 = A0_16._mixer
	L2_18 = L2_18.cameras
	L2_18 = L2_18(L2_18)
	for 