require("shared/camera/SharedCamera")
require("shared/Angle")
require("shared/Interpolator")
PlayerAimCamera = PlayerAimCamera or class(SharedCamera)
function PlayerAimCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
end
function PlayerAimCamera.update(A0_2, A1_3, A2_4, A3_5)
	if not A0_2._camera_data.eye_target_position then
		return
	end
end
function PlayerAimCamera._rotation_to_eye_target(A0_6)
	local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12, L7_13
	L1_7 = A0_6._unit
	L2_8 = L1_7
	L1_7 = L1_7.position
	L1_7 = L1_7(L2_8)
	L2_8 = A0_6._camera_data
	L2_8 = L2_8.eye_target_position
	L3_9 = A0_6._camera_data
	L3_9 = L3_9.camera_position
	L4_10 = L2_8 - L1_7
	L5_11 = L3_9 - L1_7
	L6_12 = A0_6._unit
	L7_13 = L6_12
	L6_12 = L6_12.rotation
	L6_12 = L6_12(L7_13)
	L7_13 = L6_12
	L6_12 = L6_12.x
	L6_12 = L6_12(L7_13)
	L7_13 = L6_12
	L6_12 = L6_12.dot
	L6_12 = L6_12(L7_13, L5_11)
	L7_13 = L4_10.length
	L7_13 = L7_13(L4_10)
	L7_13 = L6_12 / L7_13
	return Rotation(L4_10, math.UP) * Rotation(math.UP, 90 - math.acos(L7_13))
end
