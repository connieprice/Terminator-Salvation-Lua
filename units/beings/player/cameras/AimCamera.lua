require("shared/camera/SharedCamera")
require("shared/Angle")
require("shared/Interpolator")
local l_0_0 = mvector3.add
local l_0_1 = mvector3.set
local l_0_2 = mvector3.copy
local l_0_3 = mvector3.negate
local l_0_4 = mvector3.rotate_with
local l_0_5 = mvector3.normalize
local l_0_6 = mrotation.set_zero
local l_0_7 = mrotation.multiply
local l_0_8 = mrotation.invert
if not AimCamera then
	AimCamera = class(SharedCamera)
end
AimCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0._pitch_offset = false
end

AimCamera.parse_parameters = function(l_2_0, l_2_1)
	SharedCamera.parse_parameters(l_2_0, l_2_1)
	if l_2_1.pitch_offset ~= "true" then
		l_2_0._pitch_offset = not l_2_1.pitch_offset
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 13 
end

AimCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
	-- upvalues: l_0_1 , l_0_2 , l_0_4 , l_0_0 , l_0_3 , l_0_5 , l_0_6 , l_0_7 , l_0_8
	local l_3_5 = l_3_0._camera_data.eye_target_position
	if not l_3_5 then
		return 
	end
	if l_3_0._pitch_offset then
		l_0_1(l_3_0._local_position, l_3_0:_update_pitch_offset(l_3_3, l_3_4))
	end
	local l_3_6 = l_0_2(l_3_0._local_position)
	l_0_4(l_3_6, l_3_4)
	l_0_0(l_3_6, l_3_3)
	l_0_3(l_3_6)
	l_0_0(l_3_6, l_3_5)
	l_0_5(l_3_6)
	l_0_6(l_3_0._local_rotation)
	l_0_7(l_3_0._local_rotation, l_3_4)
	l_0_8(l_3_0._local_rotation)
	l_0_7(l_3_0._local_rotation, Rotation(l_3_6, math.UP))
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
end

AimCamera._update_pitch_offset = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = l_4_1 + l_4_0:local_position():rotate_with(l_4_2)
	local l_4_4 = l_4_0._camera_data.eye_target_position - l_4_3
	if l_4_4:length() > 0 then
		local l_4_5 = l_4_4:to_polar_with_reference(l_4_2:y(), l_4_2:z())
		local l_4_6 = l_4_5.pitch
		local l_4_7, l_4_18 = l_4_5.spin
	if l_4_6 < 0 and l_4_6 > -90 then
		end
		l_4_18 = math
		l_4_18 = l_4_18.abs
		l_4_18 = l_4_18(l_4_6)
		l_4_18 = l_4_18 / 90
		local l_4_8, l_4_19 = nil
		l_4_8 = math
		l_4_8 = l_4_8.sign
		l_4_19 = l_4_6
		l_4_8 = l_4_8(l_4_19)
		l_4_8 = -l_4_8
		l_4_19 = math
		l_4_19 = l_4_19.sin
		l_4_19 = l_4_19(270 + l_4_18 * 180)
		l_4_19 = l_4_19 * 0.5
		l_4_19 = l_4_19 + 0.5
		l_4_8 = l_4_8 * (l_4_19)
		l_4_19 = tweak_data
		l_4_19 = l_4_19.player
		l_4_19 = l_4_19.camera
		l_4_19 = l_4_19.AIMING_DOWN_FORWARD_OFFSET
		l_4_8 = l_4_8 * l_4_19
		local l_4_9, l_4_20 = nil
		l_4_19 = Vector3
		l_4_9 = 0
		l_4_20 = l_4_8
		l_4_19 = l_4_19(l_4_9, l_4_20, 0)
		local l_4_10, l_4_21 = nil
		l_4_9, l_4_20 = l_4_19:rotate_with, l_4_19
		local l_4_11, l_4_12, l_4_22, l_4_23 = nil
		l_4_10 = Rotation
		l_4_21 = math
		l_4_21 = l_4_21.UP
		l_4_11 = l_4_7
		l_4_21, l_4_10 = .end, l_4_10(l_4_21, l_4_11)
		local l_4_13, l_4_14, l_4_15, l_4_24, l_4_25, l_4_26 = nil
		return l_4_9(l_4_20, l_4_10, l_4_21, l_4_11, l_4_12, l_4_22, l_4_23, l_4_13, l_4_14, l_4_15, l_4_24, l_4_25, l_4_26)
	end
	local l_4_16, l_4_17 = l_4_0:local_position, l_4_0
	return l_4_16(l_4_17)
end


