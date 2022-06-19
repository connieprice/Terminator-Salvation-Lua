require("shared/camera/SharedCamera")
local l_0_0 = mvector3.lerp
local l_0_1 = mvector3.rotate_with
local l_0_2 = mvector3.subtract
local l_0_3 = mrotation.slerp
local l_0_4 = mrotation.set_zero
local l_0_5 = mrotation.multiply
if not BlendCamera then
	BlendCamera = class(SharedCamera)
end
BlendCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
end

BlendCamera.on_activate = function(l_2_0, l_2_1)
	if l_2_0._source_camera then
		l_2_0._source_camera:set_active(l_2_1)
	end
	if l_2_0._target_camera then
		l_2_0._target_camera:set_active(l_2_1)
	end
end

local l_0_6 = function(l_3_0, l_3_1, l_3_2)
	assert(l_3_0)
	assert(l_3_1)
	assert(l_3_2)
	return l_3_0 * (1 - l_3_2) + l_3_1 * l_3_2
end

local l_0_7 = function(l_4_0, l_4_1, l_4_2)
	if not l_4_0 then
		local l_4_3 = l_4_1
	elseif not l_4_1 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_4_0
end

BlendCamera.default_dof = function()
	local l_5_0 = 1000000
	local l_5_1 = {}
	l_5_1.amount = 0
	l_5_1.near_min = 0
	l_5_1.near_max = 0
	l_5_1.far_min = l_5_0
	l_5_1.far_max = l_5_0
	return l_5_1
end

BlendCamera.update = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	-- upvalues: l_0_0 , l_0_1 , l_0_2 , l_0_3 , l_0_4 , l_0_5 , l_0_7 , l_0_6
	local l_6_5 = l_6_0._source_camera
	local l_6_6 = l_6_0._target_camera
	if not l_6_5 or not l_6_6 then
		return 
	end
	local l_6_7 = l_6_0._factor
	local l_6_8 = l_6_4:inverse()
	l_0_0(l_6_0._local_position, l_6_5:position(), l_6_6:position(), l_6_7)
	l_0_1(l_6_0._local_position, l_6_8)
	l_0_2(l_6_0._local_position, l_6_3)
	local l_6_9 = Rotation()
	l_0_3(l_6_9, l_6_5:rotation(), l_6_6:rotation(), l_6_7)
	l_0_4(l_6_0._local_rotation)
	l_0_5(l_6_0._local_rotation, l_6_8)
	l_0_5(l_6_0._local_rotation, l_6_9)
	l_6_0._fov = l_0_7(l_6_5:camera_fov(), l_6_6:camera_fov(), l_6_7)
	if not l_6_5:camera_dof() then
		local l_6_10, l_6_12, l_6_13, l_6_15, l_6_17, l_6_18, l_6_20, l_6_22, l_6_23, l_6_25, l_6_27, l_6_28, l_6_30, l_6_32, l_6_33, l_6_35, l_6_37, l_6_39, l_6_41, l_6_43 = BlendCamera.default_dof(), l_6_6:camera_dof()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_6_12 then
		local l_6_11, l_6_14, l_6_16, l_6_19, l_6_21, l_6_24, l_6_26, l_6_29, l_6_31, l_6_34, l_6_36, l_6_38, l_6_40, l_6_42, l_6_44 = , BlendCamera.default_dof()
	end
	l_6_0.dof = {}
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_0.dof.amount = l_0_6(l_6_11.amount, l_6_14.amount, l_6_7)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_0.dof.near_min = l_0_6(l_6_11.near_min, l_6_14.near_min, l_6_7)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_0.dof.near_max = l_0_6(l_6_11.near_max, l_6_14.near_max, l_6_7)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_0.dof.far_min = l_0_6(l_6_11.far_min, l_6_14.far_min, l_6_7)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_0.dof.far_max = l_0_6(l_6_11.far_max, l_6_14.far_max, l_6_7)
	if l_6_6._constraints_rot and l_6_5._constraints_rot then
		l_6_0._constraints_rot = l_6_5._constraints_rot:slerp(l_6_6._constraints_rot, l_6_0._factor)
	end
	if l_6_6._constraints_yaw and l_6_5._constraints_yaw then
		l_6_0._constraints_yaw = math.lerp(l_6_5._constraints_yaw, l_6_6._constraints_yaw, l_6_0._factor)
	end
	if l_6_6._constraints_pitch and l_6_5._constraints_pitch then
		l_6_0._constraints_pitch = math.lerp(l_6_5._constraints_pitch, l_6_6._constraints_pitch, l_6_0._factor)
	end
	SharedCamera.update(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
end

BlendCamera.set_source_camera = function(l_7_0, l_7_1)
	if l_7_1 == l_7_0._source_camera then
		return 
	end
	if l_7_0._source_camera and l_7_0:is_active() then
		l_7_0._source_camera:set_active(false)
	end
	if l_7_0:is_active() then
		l_7_1:set_active(true)
	end
	l_7_0._source_camera = l_7_1
	l_7_0._fov = l_7_1:camera_fov()
end

BlendCamera.set_target_camera = function(l_8_0, l_8_1)
	if l_8_1 == l_8_0._target_camera then
		return 
	end
	if l_8_0._target_camera and l_8_0:is_active() then
		l_8_0._target_camera:set_active(false)
	end
	if l_8_0:is_active() then
		l_8_1:set_active(true)
	end
	l_8_0._target_camera = l_8_1
end

BlendCamera.set_factor = function(l_9_0, l_9_1)
	l_9_0._factor = l_9_1
end


