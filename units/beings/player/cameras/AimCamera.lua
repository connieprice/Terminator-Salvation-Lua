local L0_0
L0_0 = require
L0_0("shared/camera/SharedCamera")
L0_0 = require
L0_0("shared/Angle")
L0_0 = require
L0_0("shared/Interpolator")
L0_0 = mvector3
L0_0 = L0_0.add
AimCamera = AimCamera or class(SharedCamera)
function AimCamera.init(A0_1, A1_2)
	SharedCamera.init(A0_1, A1_2)
	A0_1._pitch_offset = false
end
function AimCamera.parse_parameters(A0_3, A1_4)
	SharedCamera.parse_parameters(A0_3, A1_4)
	if A1_4.pitch_offset then
		A0_3._pitch_offset = A1_4.pitch_offset == "true"
	end
end
function AimCamera.update(A0_5, A1_6, A2_7, A3_8, A4_9)
	local L5_10, L6_11
	L5_10 = A0_5._camera_data
	L5_10 = L5_10.eye_target_position
	if not L5_10 then
		return
	end
	L6_11 = A0_5._pitch_offset
	if L6_11 then
		L6_11 = _UPVALUE0_
		L6_11(A0_5._local_position, A0_5:_update_pitch_offset(A3_8, A4_9))
	end
	L6_11 = _UPVALUE1_
	L6_11 = L6_11(A0_5._local_position)
	_UPVALUE2_(L6_11, A4_9)
	_UPVALUE3_(L6_11, A3_8)
	_UPVALUE4_(L6_11)
	_UPVALUE3_(L6_11, L5_10)
	_UPVALUE5_(L6_11)
	_UPVALUE6_(A0_5._local_rotation)
	_UPVALUE7_(A0_5._local_rotation, A4_9)
	_UPVALUE8_(A0_5._local_rotation)
	_UPVALUE7_(A0_5._local_rotation, Rotation(L6_11, math.UP))
	SharedCamera.update(A0_5, A1_6, A2_7, A3_8, A4_9)
end
function AimCamera._update_pitch_offset(A0_12, A1_13, A2_14)
	local L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21
	L4_16 = A0_12
	L3_15 = A0_12.local_position
	L3_15 = L3_15(L4_16)
	L4_16 = L3_15
	L3_15 = L3_15.rotate_with
	L5_17 = A2_14
	L3_15 = L3_15(L4_16, L5_17)
	L3_15 = A1_13 + L3_15
	L4_16 = A0_12._camera_data
	L4_16 = L4_16.eye_target_position
	L4_16 = L4_16 - L3_15
	L6_18 = L4_16
	L5_17 = L4_16.length
	L5_17 = L5_17(L6_18)
	if L5_17 > 0 then
		L6_18 = L4_16
		L5_17 = L4_16.to_polar_with_reference
		L8_20 = A2_14
		L7_19 = A2_14.y
		L7_19 = L7_19(L8_20)
		L9_21 = A2_14
		L8_20 = A2_14.z
		L9_21 = L8_20(L9_21)
		L5_17 = L5_17(L6_18, L7_19, L8_20, L9_21, L8_20(L9_21))
		L6_18 = L5_17.pitch
		L7_19 = L5_17.spin
		if L6_18 < 0 and L6_18 > -90 then
			L8_20 = math
			L8_20 = L8_20.abs
			L9_21 = L6_18
			L8_20 = L8_20(L9_21)
			L8_20 = L8_20 / 90
			L9_21 = math
			L9_21 = L9_21.sign
			L9_21 = L9_21(L6_18)
			L9_21 = -L9_21
			L9_21 = L9_21 * (math.sin(270 + L8_20 * 180) * 0.5 + 0.5)
			L9_21 = L9_21 * tweak_data.player.camera.AIMING_DOWN_FORWARD_OFFSET
			return Vector3(0, L9_21, 0):rotate_with(Rotation(math.UP, L7_19))
		end
	end
	L6_18 = A0_12
	L5_17 = A0_12.local_position
	return L5_17(L6_18)
end
