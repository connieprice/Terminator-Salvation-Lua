require("shared/camera/SharedCamera")
MovingCamera = MovingCamera or class(SharedCamera)
function MovingCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0:reset()
end
function MovingCamera.parse_parameters(A0_2, A1_3)
	local L2_4, L3_5
	L3_5 = A1_3
	L2_4 = A1_3.parameter
	L2_4 = L2_4(L3_5, "move")
	if L2_4 then
		L3_5 = math
		L3_5 = L3_5.string_to_vector
		L3_5 = L3_5(L2_4)
		A0_2._move = L3_5
	end
	L3_5 = A1_3.parameter
	L3_5 = L3_5(A1_3, "max_offset")
	if L3_5 then
		A0_2._max_offset = math.string_to_vector(L3_5)
	end
end
function MovingCamera.update(A0_6, A1_7, A2_8, A3_9)
	SharedCamera.update(A0_6, A1_7, A2_8, A3_9)
	if A0_6._active then
		A0_6:_update_move(A3_9)
	end
end
function MovingCamera._update_move(A0_10, A1_11)
	local L2_12, L3_13
	L2_12 = A0_10._unit
	L3_13 = L2_12
	L2_12 = L2_12.local_position
	L2_12 = L2_12(L3_13)
	L3_13 = Vector3
	L3_13 = L3_13(A0_10._move.x * A1_11, A0_10._move.y * A1_11, A0_10._move.z * A1_11)
	L3_13 = L2_12 + L3_13
	if A0_10._max_offset then
		L3_13 = Vector3(math.clamp(L3_13.x, -A0_10._max_offset.x, A0_10._max_offset.x), math.clamp(L3_13.y, -A0_10._max_offset.y, A0_10._max_offset.y), math.clamp(L3_13.z, -A0_10._max_offset.z, A0_10._max_offset.z))
	end
	A0_10._unit:set_local_position(L3_13)
end
function MovingCamera.reset(A0_14)
	A0_14._move = Vector3(0, 0, 0)
end
