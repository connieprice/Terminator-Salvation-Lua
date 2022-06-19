require("shared/camera/SharedCamera")
KeepActivationRotationCamera = KeepActivationRotationCamera or class(SharedCamera)
function KeepActivationRotationCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0._activation_rotation = Rotation()
end
function KeepActivationRotationCamera.on_activate(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7
	L2_4 = SharedCamera
	L2_4 = L2_4.on_activate
	L3_5 = A0_2
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	if A1_3 then
		L2_4 = A0_2._root_unit
		L3_5 = L2_4
		L2_4 = L2_4.camera
		L2_4 = L2_4(L3_5)
		L2_4 = L2_4._camera_data
		L2_4 = L2_4.rotation
		L3_5 = A0_2._keep_yaw
		if L3_5 then
			L4_6 = L2_4
			L3_5 = L2_4.roll
			L3_5 = L3_5(L4_6)
		else
			L3_5 = L3_5 or 0
		end
		L4_6 = A0_2._keep_pitch
		if L4_6 then
			L5_7 = L2_4
			L4_6 = L2_4.yaw
			L4_6 = L4_6(L5_7)
		else
			L4_6 = L4_6 or 0
		end
		L5_7 = A0_2._keep_roll
		if L5_7 then
			L5_7 = L2_4.pitch
			L5_7 = L5_7(L2_4)
		else
			L5_7 = L5_7 or 0
		end
		A0_2._activation_rotation = Rotation(L4_6, L5_7, L3_5)
	end
end
function KeepActivationRotationCamera.parse_parameters(A0_8, A1_9)
	SharedCamera.parse_parameters(A0_8, A1_9)
	A0_8._keep_yaw = A1_9.keep_yaw
	A0_8._keep_pitch = A1_9.keep_pitch
	A0_8._keep_roll = A1_9.keep_roll
end
function KeepActivationRotationCamera.update(A0_10, A1_11, A2_12, A3_13, A4_14)
	A0_10:set_local_rotation_from_world_rotation(A0_10._activation_rotation)
	SharedCamera.update(A0_10, A1_11, A2_12, A3_13, A4_14)
end
