require("shared/camera/SharedCamera")
require("shared/Interpolator")
if not DynamicDistanceDofCamera then
	DynamicDistanceDofCamera = class(SharedCamera)
end
DynamicDistanceDofCamera.parse_parameters = function(l_1_0, l_1_1)
	SharedCamera.parse_parameters(l_1_0, l_1_1)
	local l_1_2 = l_1_1:parameters()
	l_1_0:parse_settings(l_1_2)
	l_1_0._dof_distance = Interpolator:new(0, l_1_0._dof_distance_interpolation_speed)
end

DynamicDistanceDofCamera.parse_settings = function(l_2_0, l_2_1)
	l_2_0._full_focus_distance = l_2_1.full_focus_distance
	assert(l_2_0._full_focus_distance)
	l_2_0._blur_distance = l_2_1.blur_distance
	assert(l_2_0._blur_distance)
	l_2_0._amount = l_2_1.amount
	assert(l_2_0._amount)
	l_2_0._dof_distance_interpolation_speed = l_2_1.dof_distance_interpolation_speed
	assert(l_2_0._dof_distance_interpolation_speed)
	l_2_0._min_distance = l_2_1.min_distance
	assert(l_2_0._min_distance)
	l_2_0._max_distance = l_2_1.max_distance
	assert(l_2_0._max_distance)
end

DynamicDistanceDofCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0:_update_dof(l_3_3)
end

DynamicDistanceDofCamera._update_dof = function(l_4_0, l_4_1)
	local l_4_2 = nil
	local l_4_3 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_4_0._camera_data.dof_target_position then
		local l_4_4 = nil
		l_4_0._dof_distance:set_target(l_4_0:camera_position() - l_4_0._camera_data.dof_target_position:length())
		l_4_0._dof_distance:update(l_4_1)
		local l_4_5 = nil
		local l_4_6 = l_4_0._dof_distance:value()
		local l_4_7 = l_4_0._full_focus_distance / 2
		local l_4_8 = l_4_0._min_distance
		l_4_2.near_min = math.clamp(l_4_6 - l_4_7, l_4_8, l_4_0._max_distance)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_2.near_max = math.clamp(l_4_2.near_min - l_4_0._blur_distance, l_4_8, l_4_0._max_distance)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_2.far_min = math.clamp(l_4_6 + l_4_7, l_4_8, l_4_0._max_distance)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_2.far_max = math.clamp(l_4_2.far_min + l_4_0._blur_distance, l_4_8, l_4_0._max_distance)
		l_4_2.amount = l_4_0._amount
	end
	l_4_0.dof = l_4_2
end


