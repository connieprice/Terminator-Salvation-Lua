WorldCamera = WorldCamera or class(CoreWorldCamera)
WorldCamera.SMOOTH_CAMERA_EXPONENT = 4.5
function WorldCamera.init(A0_0, A1_1)
	CoreWorldCamera.init(A0_0, A1_1)
	A0_0._in_accelerations.smooth_ease = 0.1
	A0_0._out_accelerations.smooth_ease = 0.9
	A0_0._animation_set_name = "world_camera_mover"
	A0_0._animation_set = AnimationManager:animation_set(A0_0._animation_set_name)
	assert(A0_0._animation_set, "The animation set must exist" .. A0_0._animation_set_name)
	A0_0._shake_animation_state = managers.worldcamera:default_shake_animation_state()
	A0_0._shake_animation_delay = managers.worldcamera:default_shake_animation_delay()
	A0_0._shake_animation_loop = managers.worldcamera:default_shake_animation_loop()
	A0_0._time_transform_funcs = {
		linear = A0_0.bezier_time_transform,
		fast = A0_0.bezier_time_transform,
		ease = A0_0.bezier_time_transform,
		smooth_ease = A0_0.exponential_time_transform
	}
	A0_0._in_acc_type = "linear"
	A0_0._out_acc_type = "linear"
end
function WorldCamera.stop(A0_2)
	CoreWorldCamera.stop(A0_2)
	A0_2._camera_unit = nil
end
function WorldCamera.start_shake_animation(A0_3)
	local L1_4
	L1_4 = A0_3.shake_animation_state
	L1_4 = L1_4(A0_3)
	if L1_4 == "idle" then
		A0_3._camera_unit = managers.worldcamera:get_camera_unit()
	end
	A0_3._total_animation_time = A0_3._animation_set:animation_total_duration(L1_4)
	A0_3._current_anim_time = 0
	A0_3._shake_animation_delay_timer = A0_3:shake_animation_delay()
	A0_3:_update_shake_animation(0)
end
function WorldCamera.play(A0_5, A1_6, A2_7, A3_8)
	if #A0_5._positions == 0 then
		return false, "Camera " .. A0_5._world_camera_name .. " didn't have any points."
	end
	if A0_5._duration == 0 then
		return false, "Camera " .. A0_5._world_camera_name .. " has duration 0, must be higher."
	end
	if not managers.worldcamera:backwards() then
		A0_5._timer = A1_6.start or 0
		A0_5._stop_timer = A1_6.stop or 1
	else
		A0_5._timer = A1_6.stop or 1
		A0_5._stop_timer = A1_6.start or 0
	end
	A0_5:start_shake_animation()
	A0_5:update(0, 0)
	A0_5._delay_timer = 0
	A0_5._index = 1
	A0_5._target_point = nil
	A0_5._playing = true
	A0_5._bezier = A0_5:bezier_function()
	A0_5:set_current_fov(A0_5:value_at_time(A0_5._timer, "fov"))
	return true
end
function WorldCamera.update(A0_9, A1_10, A2_11)
	local L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18, L10_19
	L3_12 = managers
	L3_12 = L3_12.worldcamera
	L4_13 = L3_12
	L3_12 = L3_12.backwards
	L3_12 = L3_12(L4_13)
	L5_14 = A0_9
	L4_13 = A0_9.reached_end
	L6_15 = not L3_12
	L4_13 = L4_13(L5_14, L6_15)
	if L4_13 then
		if not L3_12 then
			L4_13 = A0_9._timer
			L5_14 = A0_9._duration
			L5_14 = A2_11 / L5_14
			L4_13 = L4_13 + L5_14
			A0_9._timer = L4_13
			L4_13 = math
			L4_13 = L4_13.min
			L5_14 = 1
			L6_15 = A0_9._timer
			L4_13 = L4_13(L5_14, L6_15)
			A0_9._timer = L4_13
		else
			L4_13 = A0_9._timer
			L5_14 = A0_9._duration
			L5_14 = A2_11 / L5_14
			L4_13 = L4_13 - L5_14
			A0_9._timer = L4_13
			L4_13 = math
			L4_13 = L4_13.max
			L5_14 = 0
			L6_15 = A0_9._timer
			L4_13 = L4_13(L5_14, L6_15)
			A0_9._timer = L4_13
		end
		L4_13 = A0_9._timer
		L6_15 = A0_9
		L5_14 = A0_9.positions_at_time
		L7_16 = L4_13
		L6_15 = L5_14(L6_15, L7_16)
		L8_17 = A0_9
		L7_16 = A0_9.update_camera
		L9_18 = L5_14
		L10_19 = L6_15
		L7_16(L8_17, L9_18, L10_19)
		L8_17 = A0_9
		L7_16 = A0_9.set_current_fov
		L10_19 = A0_9
		L9_18 = A0_9.value_at_time
		L10_19 = L9_18(L10_19, A0_9._timer, "fov")
		L7_16(L8_17, L9_18, L10_19, L9_18(L10_19, A0_9._timer, "fov"))
		L8_17 = A0_9
		L7_16 = A0_9.value_at_time
		L9_18 = A0_9._timer
		L10_19 = "near_dof"
		L7_16 = L7_16(L8_17, L9_18, L10_19)
		L9_18 = A0_9
		L8_17 = A0_9.value_at_time
		L10_19 = A0_9._timer
		L8_17 = L8_17(L9_18, L10_19, "far_dof")
		L10_19 = A0_9
		L9_18 = A0_9.update_dof_values
		L9_18(L10_19, L7_16, L8_17, A0_9._dof_padding, A0_9._dof_clamp)
	else
		L4_13 = A0_9._delay
		if L4_13 < 0 then
			A0_9._delay_timer = nil
			L4_13 = nil
			if not L3_12 then
				L5_14 = A0_9._timer
				L6_15 = A0_9._duration
				L4_13 = L5_14 + L6_15
			else
				L5_14 = A0_9._timer
				L6_15 = A0_9._duration
				L4_13 = L5_14 - L6_15
			end
			L5_14 = L4_13
			L7_16 = A0_9
			L6_15 = A0_9.positions_at_time
			L8_17 = L5_14
			L7_16 = L6_15(L7_16, L8_17)
			L9_18 = A0_9
			L8_17 = A0_9.update_camera
			L10_19 = L6_15
			L8_17(L9_18, L10_19, L7_16)
		else
			L4_13 = A0_9._delay
			if L4_13 > 0 then
				L4_13 = A0_9._delay_timer
				if L4_13 < 1 then
					L4_13 = A0_9._delay_timer
					L5_14 = A0_9._delay
					L5_14 = A2_11 / L5_14
					L4_13 = L4_13 + L5_14
					A0_9._delay_timer = L4_13
				end
			else
				L4_13 = managers
				L4_13 = L4_13.worldcamera
				L5_14 = L4_13
				L4_13 = L4_13.stop_world_camera
				L4_13(L5_14)
			end
		end
	end
	L5_14 = A0_9
	L4_13 = A0_9._update_shake_animation
	L6_15 = A2_11
	L4_13(L5_14, L6_15)
end
function WorldCamera.reached_end(A0_20, A1_21)
	local L2_22, L3_23
	if A1_21 then
		L2_22 = A0_20._timer
		L3_23 = A0_20._stop_timer
		L2_22 = L2_22 < L3_23
		return L2_22
	else
		L2_22 = A0_20._timer
		L3_23 = A0_20._stop_timer
		L2_22 = L2_22 > L3_23
		return L2_22
	end
end
function WorldCamera._update_shake_animation(A0_24, A1_25)
	if A0_24._camera_unit then
	elseif A0_24._shake_animation_delay_timer > 0 then
		A0_24._current_animation = nil
		A0_24._shake_animation_delay_timer = A0_24._shake_animation_delay_timer - A1_25
	elseif 0 < A0_24._total_animation_time then
		A0_24._current_anim_time = A0_24._current_anim_time + A1_25
		if A0_24._current_anim_time >= A0_24._total_animation_time and not A0_24:shake_animation_loop() then
			A0_24._current_animation = nil
			return
		end
		A0_24._current_animation = A0_24:shake_animation_state()
		A0_24._current_anim_time = A0_24._current_anim_time % A0_24._total_animation_time
	end
end
function WorldCamera.update_camera(A0_26, A1_27, A2_28)
	local L3_29, L4_30, L5_31, L6_32, L7_33
	L4_30 = A0_26._camera_unit
	if L4_30 then
		L4_30 = A0_26._camera_unit
		L5_31 = L4_30
		L4_30 = L4_30.set_position
		L6_32 = A1_27
		L4_30(L5_31, L6_32)
		L4_30 = A0_26._camera_unit
		L5_31 = L4_30
		L4_30 = L4_30.get_object
		L6_32 = "camera_offset"
		L4_30 = L4_30(L5_31, L6_32)
		L5_31 = L4_30
		L4_30 = L4_30.rotation
		L4_30 = L4_30(L5_31)
		L3_29 = L4_30
	else
		L4_30 = A0_26._animation_set
		L5_31 = L4_30
		L4_30 = L4_30.animation_rotation
		L7_33 = A0_26
		L6_32 = A0_26.shake_animation_state
		L6_32 = L6_32(L7_33)
		L7_33 = "at_camera"
		L4_30 = L4_30(L5_31, L6_32, L7_33, A0_26._current_anim_time)
		L3_29 = L4_30
	end
	L4_30 = Rotation
	L5_31 = L4_30
	L4_30 = L4_30.look_at
	L6_32 = A1_27
	L7_33 = A2_28
	L4_30 = L4_30(L5_31, L6_32, L7_33, Vector3(0, 0, 1))
	L4_30 = L4_30 * L3_29
	L5_31 = A2_28 - A1_27
	L6_32 = L5_31
	L5_31 = L5_31.length
	L5_31 = L5_31(L6_32)
	L7_33 = L4_30
	L6_32 = L4_30.y
	L6_32 = L6_32(L7_33)
	L6_32 = L6_32 * L5_31
	A2_28 = A1_27 + L6_32
	L6_32 = managers
	L6_32 = L6_32.worldcamera
	L7_33 = L6_32
	L6_32 = L6_32.camera_controller
	L6_32 = L6_32(L7_33)
	L7_33 = L6_32
	L6_32 = L6_32.set_camera
	L6_32(L7_33, A1_27)
	L6_32 = managers
	L6_32 = L6_32.worldcamera
	L7_33 = L6_32
	L6_32 = L6_32.camera_controller
	L6_32 = L6_32(L7_33)
	L7_33 = L6_32
	L6_32 = L6_32.set_target
	L6_32(L7_33, A2_28)
	L6_32 = Rotation
	L7_33 = L6_32
	L6_32 = L6_32.look_at
	L6_32 = L6_32(L7_33, A1_27, A2_28, Vector3(0, 0, 1))
	L7_33 = L3_29.rotate_with
	L7_33 = L7_33(L3_29, L6_32)
	L3_29 = L7_33
	L7_33 = managers
	L7_33 = L7_33.worldcamera
	L7_33 = L7_33.camera_controller
	L7_33 = L7_33(L7_33)
	L7_33 = L7_33.set_default_up
	L7_33(L7_33, L3_29:z())
	L7_33 = nil
	if A0_26._camera_unit then
		L7_33 = A0_26._camera_unit:get_object("camera_offset"):local_position()
	else
		L7_33 = A0_26._animation_set:animation_position(A0_26:shake_animation_state(), "at_camera", A0_26._current_anim_time)
	end
	L7_33 = L7_33:rotate_with(L6_32)
	managers.worldcamera:camera_controller():set_camera_local_offset(L7_33)
	managers.worldcamera:camera_controller():set_target_local_offset(L7_33)
end
function WorldCamera.shake_animation_state(A0_34)
	local L1_35
	L1_35 = A0_34._shake_animation_state
	return L1_35
end
function WorldCamera.set_shake_animation_state(A0_36, A1_37)
	A0_36._shake_animation_state = A1_37
end
function WorldCamera.shake_animation_delay(A0_38)
	local L1_39
	L1_39 = A0_38._shake_animation_delay
	return L1_39
end
function WorldCamera.set_shake_animation_delay(A0_40, A1_41)
	A0_40._shake_animation_delay = A1_41
end
function WorldCamera.shake_animation_loop(A0_42)
	local L1_43
	L1_43 = A0_42._shake_animation_loop
	return L1_43
end
function WorldCamera.set_shake_animation_loop(A0_44, A1_45)
	A0_44._shake_animation_loop = A1_45
end
function WorldCamera.save(A0_46, A1_47, A2_48)
	CoreWorldCamera.save(A0_46, A1_47, A2_48)
	A2_48 = A2_48 .. "\t"
	A1_47:puts(save_value_string(A0_46, "_shake_animation_state", A2_48))
	A1_47:puts(save_value_string(A0_46, "_shake_animation_delay", A2_48))
	A1_47:puts(save_value_string(A0_46, "_shake_animation_loop", A2_48))
	A1_47:puts(save_value_string(A0_46, "_in_acc_type", A2_48))
	A1_47:puts(save_value_string(A0_46, "_out_acc_type", A2_48))
end
function WorldCamera.load(A0_49, A1_50)
	CoreWorldCamera.load(A0_49, A1_50)
	if not A0_49._in_acc_type then
		A0_49._in_acc_type = CoreWorldCamera.in_acc_string(A0_49)
	end
	if not A0_49._out_acc_type then
		A0_49._out_acc_type = CoreWorldCamera.out_acc_string(A0_49)
	end
end
function WorldCamera.positions_at_time(A0_51, A1_52)
	local L2_53, L3_54, L4_55, L5_56, L6_57, L7_58
	L3_54 = math
	L3_54 = L3_54.clamp
	L4_55 = A1_52
	L5_56 = 0
	L6_57 = 1
	L3_54 = L3_54(L4_55, L5_56, L6_57)
	A1_52 = L3_54
	L3_54 = A0_51._time_transform_funcs
	L4_55 = A0_51._in_acc_type
	L3_54 = L3_54[L4_55]
	L4_55 = A0_51._time_transform_funcs
	L5_56 = A0_51._out_acc_type
	L4_55 = L4_55[L5_56]
	L6_57 = A0_51
	L5_56 = A0_51.exponential_time_transform
	L7_58 = A1_52
	L5_56 = L5_56(L6_57, L7_58)
	L2_53 = L5_56
	if L3_54 ~= L4_55 then
		L5_56 = math
		L5_56 = L5_56.lerp
		L6_57 = L3_54
		L7_58 = A0_51
		L6_57 = L6_57(L7_58, A1_52)
		L7_58 = L4_55
		L7_58 = L7_58(A0_51, A1_52)
		L5_56 = L5_56(L6_57, L7_58, A1_52)
		L2_53 = L5_56
	else
		L5_56 = L3_54
		L6_57 = A0_51
		L7_58 = A1_52
		L5_56 = L5_56(L6_57, L7_58)
		L2_53 = L5_56
	end
	L5_56 = A0_51._bezier
	if not L5_56 then
		L6_57 = A0_51
		L5_56 = A0_51.bezier_function
		L5_56 = L5_56(L6_57)
	end
	if L5_56 then
		L6_57 = L5_56
		L7_58 = A0_51._positions
		L6_57 = L6_57(L7_58, L2_53)
		L7_58 = L5_56
		L7_58 = L7_58(A0_51._target_positions, L2_53)
		return L6_57, L7_58
	end
	L6_57 = A0_51._positions
	L6_57 = L6_57[1]
	L7_58 = A0_51._target_positions
	L7_58 = L7_58[1]
	return L6_57, L7_58
end
function WorldCamera.bezier_time_transform(A0_59, A1_60)
	return math.bezier({
		0,
		A0_59._in_acc,
		A0_59._out_acc,
		1
	}, A1_60)
end
function WorldCamera.exponential_time_transform(A0_61, A1_62)
	local L2_63
	if A1_62 < 0.5 then
		A1_62 = A1_62 * 2
		L2_63 = A1_62 * A1_62
		L2_63 = L2_63 * A1_62
		A1_62 = L2_63 * A1_62
		A1_62 = A1_62 * 0.5
	else
		L2_63 = A1_62 * 2
		L2_63 = L2_63 - 1
		A1_62 = 1 - L2_63
		L2_63 = A1_62 * A1_62
		L2_63 = L2_63 * A1_62
		A1_62 = L2_63 * A1_62
		L2_63 = A1_62 * 0.5
		A1_62 = 1 - L2_63
	end
	return A1_62
end
function WorldCamera.set_in_acc(A0_64, A1_65)
	CoreWorldCamera.set_in_acc(A0_64, A1_65)
	A0_64._in_acc_type = A1_65
end
function WorldCamera.set_out_acc(A0_66, A1_67)
	CoreWorldCamera.set_out_acc(A0_66, A1_67)
	A0_66._out_acc_type = A1_67
end
function WorldCamera.in_acc_string(A0_68)
	if A0_68._in_acc_type then
		return A0_68._in_acc_type
	end
	assert(false, "No camera acceleration (in) type found")
end
function WorldCamera.out_acc_string(A0_69)
	if A0_69._out_acc_type then
		return A0_69._out_acc_type
	end
	assert(false, "No camera acceleration (out) type found")
end
function WorldCamera.current_time(A0_70)
	local L1_71
	L1_71 = A0_70._timer
	return L1_71
end
