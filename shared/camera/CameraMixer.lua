local L0_0
L0_0 = require
L0_0("shared/TableAlgorithms")
L0_0 = mvector3
L0_0 = L0_0.add
CameraMixer = CameraMixer or class()
function CameraMixer.init(A0_1)
	A0_1._cameras = {}
end
function CameraMixer.add_camera(A0_2, A1_3, A2_4)
	if A2_4 == nil or A2_4 == 0 or #A0_2._cameras == 0 then
		A2_4 = 1
	end
	table.insert(A0_2._cameras, {
		camera = A1_3,
		blend_time = A2_4,
		time = 1
	})
end
function CameraMixer.update(A0_5, A1_6, A2_7)
	local L3_8, L4_9, L5_10, L6_11, L7_12, L8_13, L9_14, L10_15, L11_16, L12_17, L13_18, L14_19, L15_20, L16_21, L17_22
	L3_8 = Vector3
	L3_8 = L3_8(L4_9, L5_10, L6_11)
	A1_6.position = L3_8
	L3_8 = Rotation
	L3_8 = L3_8()
	A1_6.rotation = L3_8
	A1_6.constraint_yaw = nil
	A1_6.constraint_pitch = nil
	A1_6.constraint_rot = nil
	A1_6.fov = 0
	A1_6.dof = nil
	L3_8 = 1
	for L7_12, L8_13 in L4_9(L5_10) do
		L9_14 = L8_13.time
		L9_14 = L9_14 + A2_7
		L8_13.time = L9_14
		L9_14 = math
		L9_14 = L9_14.sin
		L10_15 = math
		L10_15 = L10_15.clamp
		L11_16 = L8_13.time
		L12_17 = L8_13.blend_time
		L11_16 = L11_16 / L12_17
		L12_17 = 0
		L13_18 = 1
		L10_15 = L10_15(L11_16, L12_17, L13_18)
		L10_15 = L10_15 * 90
		L9_14 = L9_14(L10_15)
		L10_15 = L8_13.camera
		L11_16 = A1_6.position
		L12_17 = _UPVALUE0_
		L14_19 = L10_15
		L13_18 = L10_15.position
		L17_22 = L13_18(L14_19)
		L12_17 = L12_17(L13_18, L14_19, L15_20, L16_21, L17_22, L13_18(L14_19))
		L13_18 = _UPVALUE1_
		L14_19 = L12_17
		L15_20 = L11_16
		L13_18(L14_19, L15_20)
		L13_18 = _UPVALUE2_
		L14_19 = L12_17
		L15_20 = L9_14
		L13_18(L14_19, L15_20)
		L13_18 = _UPVALUE3_
		L14_19 = L11_16
		L15_20 = L12_17
		L13_18(L14_19, L15_20)
		L13_18 = A1_6.rotation
		L14_19 = _UPVALUE4_
		L15_20 = L13_18
		L16_21 = L13_18
		L17_22 = L10_15.rotation
		L17_22 = L17_22(L10_15)
		L14_19(L15_20, L16_21, L17_22, L9_14)
		L14_19 = A1_6.fov
		L16_21 = L10_15
		L15_20 = L10_15.camera_fov
		L15_20 = L15_20(L16_21)
		L15_20 = L15_20 - L14_19
		L15_20 = L15_20 * L9_14
		L15_20 = L14_19 + L15_20
		A1_6.fov = L15_20
		L16_21 = L10_15
		L15_20 = L10_15.camera_dof
		L15_20 = L15_20(L16_21)
		L16_21 = A1_6.dof
		if L16_21 then
			if not L15_20 then
				L17_22 = 1000000
				L15_20 = {}
				L15_20.amount = 0
				L15_20.near_min = 0
				L15_20.near_max = 0
				L15_20.far_min = L17_22
				L15_20.far_max = L17_22
			end
			L17_22 = L16_21.amount
			L17_22 = L17_22 + (L15_20.amount - L16_21.amount) * L9_14
			L16_21.amount = L17_22
			L17_22 = L16_21.near_min
			L17_22 = L17_22 + (L15_20.near_min - L16_21.near_min) * L9_14
			L16_21.near_min = L17_22
			L17_22 = L16_21.near_max
			L17_22 = L17_22 + (L15_20.near_max - L16_21.near_max) * L9_14
			L16_21.near_max = L17_22
			L17_22 = L16_21.far_min
			L17_22 = L17_22 + (L15_20.far_min - L16_21.far_min) * L9_14
			L16_21.far_min = L17_22
			L17_22 = L16_21.far_max
			L17_22 = L17_22 + (L15_20.far_max - L16_21.far_max) * L9_14
			L16_21.far_max = L17_22
		elseif L15_20 then
			L17_22 = {}
			A1_6.dof = L17_22
			L16_21 = A1_6.dof
			L17_22 = L15_20.amount
			L16_21.amount = L17_22
			L17_22 = L15_20.near_min
			L16_21.near_min = L17_22
			L17_22 = L15_20.near_max
			L16_21.near_max = L17_22
			L17_22 = L15_20.far_min
			L16_21.far_min = L17_22
			L17_22 = L15_20.far_max
			L16_21.far_max = L17_22
		end
		L17_22 = L10_15.camera_constraints
		L17_22 = L17_22(L10_15)
		if L17_22 and A1_6.constraint_rot then
			A1_6.constraint_rot = A1_6.constraint_rot:slerp(L17_22, L9_14)
		else
			A1_6.constraint_rot = L17_22
		end
		if L17_22(L10_15) and A1_6.constraint_yaw then
			A1_6.constraint_yaw = A1_6.constraint_yaw + (L17_22(L10_15) - A1_6.constraint_yaw) * L9_14
		else
			A1_6.constraint_yaw = L17_22(L10_15)
		end
		if L17_22(L10_15) and A1_6.constraint_pitch then
			A1_6.constraint_pitch = A1_6.constraint_pitch + (L17_22(L10_15) - A1_6.constraint_pitch) * L9_14
		else
			A1_6.constraint_pitch = L17_22(L10_15)
		end
		if L9_14 >= 1 then
			L3_8 = L7_12
		end
	end
	for L8_13 = 1, L3_8 - 1 do
		L9_14 = table
		L9_14 = L9_14.insert
		L10_15 = L4_9
		L11_16 = A0_5._cameras
		L11_16 = L11_16[1]
		L11_16 = L11_16.camera
		L9_14(L10_15, L11_16)
		L9_14 = table
		L9_14 = L9_14.remove
		L10_15 = A0_5._cameras
		L11_16 = 1
		L9_14(L10_15, L11_16)
	end
	return L4_9
end
function CameraMixer.active_camera(A0_23)
	local L1_24, L2_25
	L1_24 = A0_23._cameras
	L1_24 = #L1_24
	if L1_24 == 0 then
		L2_25 = nil
		return L2_25
	end
	L2_25 = A0_23._cameras
	L2_25 = L2_25[L1_24]
	L2_25 = L2_25.camera
	return L2_25
end
function CameraMixer.cameras(A0_26)
	local L1_27
	L1_27 = {}
	for 