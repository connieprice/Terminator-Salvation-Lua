local L0_0, L1_1, L2_2, L3_3, L4_4, L5_5
L0_0 = mvector3
L0_0 = L0_0.add
L1_1 = mvector3
L1_1 = L1_1.subtract
L2_2 = mvector3
L2_2 = L2_2.set
L3_3 = mvector3
L3_3 = L3_3.rotate_with
L4_4 = mrotation
L4_4 = L4_4.set_zero
L5_5 = mrotation
L5_5 = L5_5.multiply
SharedCamera = SharedCamera or class()
function SharedCamera.init(A0_6, A1_7)
	A0_6._children = {}
	A0_6._active_children = {}
	A0_6._active_count = 0
	A0_6._position = Vector3(0, 0, 0)
	A0_6._rotation = Rotation()
	A0_6._root_unit = A1_7
	A0_6._camera_data = A1_7:camera_data()
	A0_6._name = ""
	A0_6._local_position = Vector3(0, 0, 0)
	A0_6._local_rotation = Rotation()
	A0_6._fov = 0
	A0_6._constraints_rot = nil
	A0_6._constraints_yaw = nil
	A0_6._constraints_pitch = nil
end
function SharedCamera.parse_parameters(A0_8, A1_9)
	if A1_9.fov then
		A0_8._fov = tonumber(A1_9.fov)
	end
	if A1_9.name then
		A0_8._name = A1_9.name
	end
end
function SharedCamera.destroy(A0_10)
	A0_10._active_children = {}
	for 