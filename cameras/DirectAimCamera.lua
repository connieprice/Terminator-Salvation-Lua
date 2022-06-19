require("shared/camera/SharedCamera")
DirectAimCamera = DirectAimCamera or class(SharedCamera)
function DirectAimCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
end
function DirectAimCamera.parse_parameters(A0_2, A1_3)
	SharedCamera.parse_parameters(A0_2, A1_3)
	if A1_3.yaw_limit then
		A0_2._yaw_limit = tonumber(A1_3.yaw_limit)
		A0_2._constraints_yaw = A0_2._yaw_limit
	end
	if A1_3.pitch_limit then
		A0_2._pitch_limit = tonumber(A1_3.pitch_limit)
		A0_2._constraints_pitch = A0_2._pitch_limit
	end
	if A1_3.root_rotation then
		A0_2._root_rotation = toboolean(A1_3.root_rotation)
	end
	A0_2._rotation_offset = Rotation(0, 0, 0)
	if A1_3.rotation then
		A0_2._rotation_offset = math.string_to_rotation(A1_3.rotation)
	end
end
function DirectAimCamera.update(A0_4, A1_5, A2_6, A3_7, A4_8)
	local L5_9, L6_10
	L6_10 = A0_4._root_rotation
	if L6_10 then
		L6_10 = A0_4._root_unit
		L6_10 = L6_10.position
		L6_10 = L6_10(L6_10)
		L5_9 = L6_10
	else
		L5_9 = A3_7
	end
	L6_10 = A0_4._camera_data
	L6_10 = L6_10.eye_target_position
	L6_10 = L6_10 - L5_9
	A0_4:set_local_rotation(A4_8:inverse() * Rotation(L6_10, math.UP))
	if A0_4._yaw_limit and A0_4._pitch_limit then
		A0_4._constraints_rot = A4_8 * A0_4._rotation_offset
	end
	SharedCamera.update(A0_4, A1_5, A2_6, A3_7, A4_8)
end
