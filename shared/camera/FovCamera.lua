require("shared/camera/SharedCamera")
FovCamera = FovCamera or class(SharedCamera)
function FovCamera.parse_parameters(A0_0, A1_1)
	local L2_2
	L2_2 = SharedCamera
	L2_2 = L2_2.parse_parameters
	L2_2(A0_0, A1_1)
	L2_2 = A1_1.fov
	assert(L2_2)
	A0_0:set_fov(L2_2)
end
function FovCamera.set_fov(A0_3, A1_4)
	A0_3._fov = A1_4
end
function FovCamera.fov(A0_5)
	local L1_6
	L1_6 = A0_5._fov
	return L1_6
end
