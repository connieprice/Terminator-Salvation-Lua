local L0_0
L0_0 = require
L0_0("shared/camera/SharedCamera")
L0_0 = mvector3
L0_0 = L0_0.add
PositionOnlyCamera = PositionOnlyCamera or class(SharedCamera)
function PositionOnlyCamera.init(A0_1, A1_2)
	SharedCamera.init(A0_1, A1_2)
end
function PositionOnlyCamera.parse_parameters(A0_3, A1_4)
	local L2_5
	L2_5 = SharedCamera
	L2_5 = L2_5.parse_parameters
	L2_5(A0_3, A1_4)
	L2_5 = Vector3
	L2_5 = L2_5(0, 0, 0)
	if A1_4.position then
		L2_5 = TableSerializer._load_vector(A1_4.position)
	end
	A0_3:set_local_rotation(Rotation())
	A0_3:set_local_position(L2_5)
end
function PositionOnlyCamera.update(A0_6, A1_7, A2_8, A3_9, A4_10)
	_UPVALUE0_(A0_6._position, A0_6._local_position)
	_UPVALUE1_(A0_6._position, A4_10)
	_UPVALUE2_(A0_6._position, A3_9)
end
