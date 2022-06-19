require("shared/camera/SharedCamera")
require("shared/TableSerializer")
TargetCameraNode = TargetCameraNode or class(SharedCamera)
function TargetCameraNode.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
end
function TargetCameraNode.parse_parameters(A0_2, A1_3)
	local L2_4, L3_5, L4_6
	L2_4 = SharedCamera
	L2_4 = L2_4.parse_parameters
	L3_5 = A0_2
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L2_4 = A1_3.target_object_name
	A0_2._target_object_name = L2_4
	L2_4 = A1_3.target_position_offset
	if L2_4 then
		L3_5 = TableSerializer
		L3_5 = L3_5._load_vector
		L4_6 = L2_4
		L3_5 = L3_5(L4_6)
		A0_2._target_position_offset = L3_5
	end
	L3_5 = A1_3.interpolation_speed
	if L3_5 then
		L4_6 = tonumber
		L4_6 = L4_6(L3_5)
		A0_2._interpolation_speed = L4_6
	end
	L4_6 = A0_2._target_object_name
	if L4_6 then
		A0_2._target_object = A0_2._root_unit:get_object(L4_6)
	end
end
function TargetCameraNode.update(A0_7, A1_8, A2_9, A3_10, A4_11)
	local L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21
	L6_13 = A0_7._target_object
	if L6_13 then
		L6_13 = A0_7._target_object
		L7_14 = L6_13
		L6_13 = L6_13.position
		L6_13 = L6_13(L7_14)
		L5_12 = L6_13
	else
		L6_13 = A0_7._target_position
		if L6_13 then
			L5_12 = A0_7._target_position
		else
			L6_13 = A0_7._root_unit
			L7_14 = L6_13
			L6_13 = L6_13.position
			L6_13 = L6_13(L7_14)
			L5_12 = L6_13
		end
	end
	L6_13 = A0_7._target_position_offset
	if L6_13 then
		L5_12 = L5_12 + L6_13
	end
	L7_14 = L5_12 - A3_10
	L9_16 = L7_14
	L8_15 = L7_14.length
	L8_15 = L8_15(L9_16)
	if L8_15 > 0 then
		L9_16 = L7_14 / L8_15
		L10_17 = Rotation
		L11_18 = L9_16
		L12_19 = math
		L12_19 = L12_19.UP
		L10_17 = L10_17(L11_18, L12_19)
		L12_19 = A4_11
		L11_18 = A4_11.inverse
		L11_18 = L11_18(L12_19)
		L11_18 = L11_18 * L10_17
		L12_19 = nil
		L13_20 = A0_7._interpolation_speed
		if L13_20 then
			L14_21 = A0_7
			L13_20 = A0_7.local_rotation
			L13_20 = L13_20(L14_21)
			L14_21 = math
			L14_21 = L14_21.min
			L14_21 = L14_21(A0_7._interpolation_speed * A2_9, 1)
			L12_19 = L13_20:slerp(L11_18, L14_21)
		else
			L12_19 = L11_18
		end
		L14_21 = A0_7
		L13_20 = A0_7.set_local_rotation
		L13_20(L14_21, L12_19)
	end
	L9_16 = SharedCamera
	L9_16 = L9_16.update
	L10_17 = A0_7
	L11_18 = A1_8
	L12_19 = A2_9
	L13_20 = A3_10
	L14_21 = A4_11
	L9_16(L10_17, L11_18, L12_19, L13_20, L14_21)
end
function TargetCameraNode.set_target_position(A0_22, A1_23)
	A0_22._target_position = A1_23
	A0_22._target_object = nil
end
