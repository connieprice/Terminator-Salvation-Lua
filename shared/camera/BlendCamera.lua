local L0_0
L0_0 = require
L0_0("shared/camera/SharedCamera")
L0_0 = mvector3
L0_0 = L0_0.lerp
BlendCamera = BlendCamera or class(SharedCamera)
function BlendCamera.init(A0_1, A1_2)
	SharedCamera.init(A0_1, A1_2)
end
function BlendCamera.on_activate(A0_3, A1_4)
	if A0_3._source_camera then
		A0_3._source_camera:set_active(A1_4)
	end
	if A0_3._target_camera then
		A0_3._target_camera:set_active(A1_4)
	end
end
function BlendCamera.default_dof()
	local L0_5, L1_6
	L0_5 = 1000000
	L1_6 = {}
	L1_6.amount = 0
	L1_6.near_min = 0
	L1_6.near_max = 0
	L1_6.far_min = L0_5
	L1_6.far_max = L0_5
	return L1_6
end
function BlendCamera.update(A0_7, A1_8, A2_9, A3_10, A4_11)
	local L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18
	L5_12 = A0_7._source_camera
	L6_13 = A0_7._target_camera
	if not L5_12 or not L6_13 then
		return
	end
	L7_14 = A0_7._factor
	L9_16 = A4_11
	L8_15 = A4_11.inverse
	L8_15 = L8_15(L9_16)
	L9_16 = _UPVALUE0_
	L10_17 = A0_7._local_position
	L11_18 = L5_12.position
	L11_18 = L11_18(L5_12)
	L9_16(L10_17, L11_18, L6_13:position(), L7_14)
	L9_16 = _UPVALUE1_
	L10_17 = A0_7._local_position
	L11_18 = L8_15
	L9_16(L10_17, L11_18)
	L9_16 = _UPVALUE2_
	L10_17 = A0_7._local_position
	L11_18 = A3_10
	L9_16(L10_17, L11_18)
	L9_16 = Rotation
	L9_16 = L9_16()
	L10_17 = _UPVALUE3_
	L11_18 = L9_16
	L10_17(L11_18, L5_12:rotation(), L6_13:rotation(), L7_14)
	L10_17 = _UPVALUE4_
	L11_18 = A0_7._local_rotation
	L10_17(L11_18)
	L10_17 = _UPVALUE5_
	L11_18 = A0_7._local_rotation
	L10_17(L11_18, L8_15)
	L10_17 = _UPVALUE5_
	L11_18 = A0_7._local_rotation
	L10_17(L11_18, L9_16)
	L10_17 = _UPVALUE6_
	L11_18 = L5_12.camera_fov
	L11_18 = L11_18(L5_12)
	L10_17 = L10_17(L11_18, L6_13:camera_fov(), L7_14)
	A0_7._fov = L10_17
	L11_18 = L5_12
	L10_17 = L5_12.camera_dof
	L10_17 = L10_17(L11_18)
	L11_18 = L6_13.camera_dof
	L11_18 = L11_18(L6_13)
	L10_17 = L10_17 or BlendCamera.default_dof()
	L11_18 = L11_18 or BlendCamera.default_dof()
	A0_7.dof = {}
	A0_7.dof.amount = _UPVALUE7_(L10_17.amount, L11_18.amount, L7_14)
	A0_7.dof.near_min = _UPVALUE7_(L10_17.near_min, L11_18.near_min, L7_14)
	A0_7.dof.near_max = _UPVALUE7_(L10_17.near_max, L11_18.near_max, L7_14)
	A0_7.dof.far_min = _UPVALUE7_(L10_17.far_min, L11_18.far_min, L7_14)
	A0_7.dof.far_max = _UPVALUE7_(L10_17.far_max, L11_18.far_max, L7_14)
	if L6_13._constraints_rot and L5_12._constraints_rot then
		A0_7._constraints_rot = L5_12._constraints_rot:slerp(L6_13._constraints_rot, A0_7._factor)
	end
	if L6_13._constraints_yaw and L5_12._constraints_yaw then
		A0_7._constraints_yaw = math.lerp(L5_12._constraints_yaw, L6_13._constraints_yaw, A0_7._factor)
	end
	if L6_13._constraints_pitch and L5_12._constraints_pitch then
		A0_7._constraints_pitch = math.lerp(L5_12._constraints_pitch, L6_13._constraints_pitch, A0_7._factor)
	end
	SharedCamera.update(A0_7, A1_8, A2_9, A3_10, A4_11)
end
function BlendCamera.set_source_camera(A0_19, A1_20)
	if A1_20 == A0_19._source_camera then
		return
	end
	if A0_19._source_camera and A0_19:is_active() then
		A0_19._source_camera:set_active(false)
	end
	if A0_19:is_active() then
		A1_20:set_active(true)
	end
	A0_19._source_camera = A1_20
	A0_19._fov = A1_20:camera_fov()
end
function BlendCamera.set_target_camera(A0_21, A1_22)
	if A1_22 == A0_21._target_camera then
		return
	end
	if A0_21._target_camera and A0_21:is_active() then
		A0_21._target_camera:set_active(false)
	end
	if A0_21:is_active() then
		A1_22:set_active(true)
	end
	A0_21._target_camera = A1_22
end
function BlendCamera.set_factor(A0_23, A1_24)
	A0_23._factor = A1_24
end
