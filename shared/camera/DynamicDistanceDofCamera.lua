require("shared/camera/SharedCamera")
require("shared/Interpolator")
DynamicDistanceDofCamera = DynamicDistanceDofCamera or class(SharedCamera)
function DynamicDistanceDofCamera.parse_parameters(A0_0, A1_1)
	local L2_2
	L2_2 = SharedCamera
	L2_2 = L2_2.parse_parameters
	L2_2(A0_0, A1_1)
	L2_2 = A1_1.parameters
	L2_2 = L2_2(A1_1)
	A0_0:parse_settings(L2_2)
	A0_0._dof_distance = Interpolator:new(0, A0_0._dof_distance_interpolation_speed)
end
function DynamicDistanceDofCamera.parse_settings(A0_3, A1_4)
	A0_3._full_focus_distance = A1_4.full_focus_distance
	assert(A0_3._full_focus_distance)
	A0_3._blur_distance = A1_4.blur_distance
	assert(A0_3._blur_distance)
	A0_3._amount = A1_4.amount
	assert(A0_3._amount)
	A0_3._dof_distance_interpolation_speed = A1_4.dof_distance_interpolation_speed
	assert(A0_3._dof_distance_interpolation_speed)
	A0_3._min_distance = A1_4.min_distance
	assert(A0_3._min_distance)
	A0_3._max_distance = A1_4.max_distance
	assert(A0_3._max_distance)
end
function DynamicDistanceDofCamera.update(A0_5, A1_6, A2_7, A3_8)
	SharedCamera.update(A0_5, A1_6, A2_7, A3_8)
	A0_5:_update_dof(A3_8)
end
function DynamicDistanceDofCamera._update_dof(A0_9, A1_10)
	local L2_11, L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18
	L3_12 = A0_9._camera_data
	L4_13 = L3_12.dof_target_position
	if L4_13 then
		L6_15 = A0_9
		L5_14 = A0_9.camera_position
		L5_14 = L5_14(L6_15)
		L5_14 = L5_14 - L4_13
		L6_15 = L5_14
		L5_14 = L5_14.length
		L5_14 = L5_14(L6_15)
		L6_15 = A0_9._dof_distance
		L7_16 = L6_15
		L6_15 = L6_15.set_target
		L8_17 = L5_14
		L6_15(L7_16, L8_17)
		L6_15 = A0_9._dof_distance
		L7_16 = L6_15
		L6_15 = L6_15.update
		L8_17 = A1_10
		L6_15(L7_16, L8_17)
		L6_15 = A0_9._dof_distance
		L7_16 = L6_15
		L6_15 = L6_15.value
		L6_15 = L6_15(L7_16)
		L7_16 = A0_9._full_focus_distance
		L7_16 = L7_16 / 2
		L8_17 = A0_9._min_distance
		L9_18 = A0_9._max_distance
		L2_11 = {}
		L2_11.near_min = math.clamp(L6_15 - L7_16, L8_17, L9_18)
		L2_11.near_max = math.clamp(L2_11.near_min - A0_9._blur_distance, L8_17, L9_18)
		L2_11.far_min = math.clamp(L6_15 + L7_16, L8_17, L9_18)
		L2_11.far_max = math.clamp(L2_11.far_min + A0_9._blur_distance, L8_17, L9_18)
		L2_11.amount = A0_9._amount
	end
	A0_9.dof = L2_11
end
