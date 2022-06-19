TargetingCamera = TargetingCamera or class(SharedCamera)
function TargetingCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._target = "enemy"
end
function TargetingCamera.parse_parameters(A0_2, A1_3)
	SharedCamera.parse_parameters(A0_2, A1_3)
	if A1_3.target then
		A0_2._target = A1_3.target
	end
end
function TargetingCamera.update(A0_4, A1_5, A2_6, A3_7, A4_8)
	local L5_9, L6_10
	L5_9 = A0_4._root_unit
	L6_10 = L5_9
	L5_9 = L5_9.player_data
	L5_9 = L5_9(L6_10)
	L5_9 = L5_9.named_camera_targets
	L6_10 = A0_4._target
	L5_9 = L5_9[L6_10]
	L6_10 = alive
	L6_10 = L6_10(L5_9)
	if L6_10 then
		L6_10 = L5_9.position
		L6_10 = L6_10(L5_9)
		L6_10 = L6_10 - A3_7
		A0_4:set_local_rotation(A4_8:inverse() * Rotation(L6_10, math.UP))
	end
	L6_10 = SharedCamera
	L6_10 = L6_10.update
	L6_10(A0_4, A1_5, A2_6, A3_7, A4_8)
end
