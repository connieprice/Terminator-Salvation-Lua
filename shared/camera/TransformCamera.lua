require("shared/camera/SharedCamera")
TransformCamera = TransformCamera or class(SharedCamera)
function TransformCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
end
function TransformCamera.parse_parameters(A0_2, A1_3)
	local L2_4, L3_5
	L2_4 = SharedCamera
	L2_4 = L2_4.parse_parameters
	L3_5 = A0_2
	L2_4(L3_5, A1_3)
	L2_4 = Vector3
	L3_5 = 0
	L2_4 = L2_4(L3_5, 0, 0)
	L3_5 = A1_3.position
	if L3_5 then
		L3_5 = TableSerializer
		L3_5 = L3_5._load_vector
		L3_5 = L3_5(A1_3.position)
		L2_4 = L3_5
	end
	L3_5 = Rotation
	L3_5 = L3_5()
	if A1_3.rotation then
		L3_5 = math.string_to_rotation(A1_3.rotation)
	end
	A0_2:set_local_rotation(L3_5)
	A0_2:set_local_position(L2_4)
end
