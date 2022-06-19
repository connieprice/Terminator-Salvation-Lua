require("shared/camera/SharedCamera")
RotatingCamera = RotatingCamera or class(SharedCamera)
function RotatingCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0:reset()
end
function RotatingCamera.parse_parameters(A0_2, A1_3)
	local L2_4
	L2_4 = A1_3.parameter
	L2_4 = L2_4(A1_3, "rotate")
	if L2_4 then
		A0_2._rotate = math.string_to_vector(L2_4)
	end
end
function RotatingCamera.update(A0_5, A1_6, A2_7, A3_8)
	SharedCamera.update(A0_5, A1_6, A2_7, A3_8)
	if A0_5._active then
		A0_5:_update_rotate(A3_8)
	end
end
function RotatingCamera._update_rotate(A0_9, A1_10)
	local L2_11, L3_12
	L2_11 = A0_9._unit
	L3_12 = L2_11
	L2_11 = L2_11.local_rotation
	L2_11 = L2_11(L3_12)
	L3_12 = Rotation
	L3_12 = L3_12(A0_9._rotate.x * A1_10, A0_9._rotate.y * A1_10, A0_9._rotate.z * A1_10)
	L3_12 = L2_11 * L3_12
	A0_9._unit:set_local_rotation(L3_12)
end
function RotatingCamera.reset(A0_13)
	A0_13._rotate = Rotation(0, 0, 0)
end
