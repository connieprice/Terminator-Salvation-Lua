if not WorldCamera then
	WorldCamera = class(CoreWorldCamera)
end
WorldCamera.SMOOTH_CAMERA_EXPONENT = 4.5
WorldCamera.init = function(l_1_0, l_1_1)
	CoreWorldCamera.init(l_1_0, l_1_1)
	l_1_0._in_accelerations.smooth_ease = 0.1
	l_1_0._out_accelerations.smooth_ease = 0.9
	l_1_0._animation_set_name = "world_camera_mover"
	l_1_0._animation_set = AnimationManager:animation_set(l_1_0._animation_set_name)
	assert(l_1_0._animation_set, "The animation set must exist" .. l_1_0._animation_set_name)
	l_1_0._shake_animation_state = managers.worldcamera:default_shake_animation_state()
	l_1_0._shake_animation_delay = managers.worldcamera:default_shake_animation_delay()
	l_1_0._shake_animation_loop = managers.worldcamera:default_shake_animation_loop()
	local l_1_2 = {}
	l_1_2.linear = l_1_0.bezier_time_transform
	l_1_2.fast = l_1_0.bezier_time_transform
	l_1_2.ease = l_1_0.bezier_time_transform
	l_1_2.smooth_ease = l_1_0.exponential_time_transform
	l_1_0._time_transform_funcs = l_1_2
	l_1_0._in_acc_type = "linear"
	l_1_0._out_acc_type = "linear"
end

WorldCamera.stop = function(l_2_0)
	CoreWorldCamera.stop(l_2_0)
	l_2_0._camera_unit = nil
end

WorldCamera.start_shake_animation = function(l_3_0)
	local l_3_1 = l_3_0:shake_animation_state()
	if l_3_1 == "idle" then
		l_3_0._camera_unit = managers.worldcamera:get_camera_unit()
	end
	l_3_0._total_animation_time = l_3_0._animation_set:animation_total_duration(l_3_1)
	l_3_0._current_anim_time = 0
	l_3_0._shake_animation_delay_timer = l_3_0:shake_animation_delay()
	l_3_0:_update_shake_animation(0)
end

WorldCamera.play = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if #l_4_0._positions == 0 then
		return false, "Camera " .. l_4_0._world_camera_name .. " didn't have any points."
	end
	if l_4_0._duration == 0 then
		return false, "Camera " .. l_4_0._world_camera_name .. " has duration 0, must be higher."
	end
	if not l_4_1.start then
		l_4_0._timer = managers.worldcamera:backwards() or 0
	end
	l_4_0._stop_timer = l_4_1.stop or 1
	do return end
	l_4_0._timer = l_4_1.stop or 1
	l_4_0._stop_timer = l_4_1.start or 0
	l_4_0:start_shake_animation()
	l_4_0:update(0, 0)
	l_4_0._delay_timer = 0
	l_4_0._index = 1
	l_4_0._target_point = nil
	l_4_0._playing = true
	l_4_0._bezier = l_4_0:bezier_function()
	l_4_0:set_current_fov(l_4_0:value_at_time(l_4_0._timer, "fov"))
	return true
end

WorldCamera.update = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = managers.worldcamera:backwards()
	if l_5_0:reached_end(not l_5_3) then
		if not l_5_3 then
			l_5_0._timer = l_5_0._timer + l_5_2 / l_5_0._duration
			l_5_0._timer = math.min(1, l_5_0._timer)
		else
			l_5_0._timer = l_5_0._timer - l_5_2 / l_5_0._duration
			l_5_0._timer = math.max(0, l_5_0._timer)
		end
		local l_5_4 = l_5_0._timer
		local l_5_5, l_5_6 = l_5_0:positions_at_time(l_5_4)
		l_5_0:update_camera(l_5_5, l_5_6)
		l_5_0:set_current_fov(l_5_0:value_at_time(l_5_0._timer, "fov"))
		local l_5_7 = l_5_0:value_at_time(l_5_0._timer, "near_dof")
		local l_5_8 = l_5_0:value_at_time(l_5_0._timer, "far_dof")
		l_5_0:update_dof_values(l_5_7, l_5_8, l_5_0._dof_padding, l_5_0._dof_clamp)
	elseif l_5_0._delay < 0 then
		l_5_0._delay_timer = nil
		local l_5_9 = nil
		if not l_5_3 then
			l_5_9 = l_5_0._timer + l_5_0._duration
		else
			l_5_9 = l_5_0._timer - l_5_0._duration
		end
		local l_5_10 = l_5_9
		local l_5_11, l_5_12 = l_5_0:positions_at_time(l_5_10)
		l_5_0:update_camera(l_5_11, l_5_12)
	elseif l_5_0._delay > 0 and l_5_0._delay_timer < 1 then
		l_5_0._delay_timer = l_5_0._delay_timer + l_5_2 / l_5_0._delay
	else
		managers.worldcamera:stop_world_camera()
	end
	l_5_0:_update_shake_animation(l_5_2)
end

WorldCamera.reached_end = function(l_6_0, l_6_1)
	if l_6_0._timer >= l_6_0._stop_timer then
		return not l_6_1
	end
	do return end
	return l_6_0._stop_timer < l_6_0._timer
end

WorldCamera._update_shake_animation = function(l_7_0, l_7_1)
	if l_7_0._camera_unit then
		do return end
	end
	if l_7_0._shake_animation_delay_timer > 0 then
		l_7_0._current_animation = nil
		l_7_0._shake_animation_delay_timer = l_7_0._shake_animation_delay_timer - l_7_1
	elseif l_7_0._total_animation_time > 0 then
		l_7_0._current_anim_time = l_7_0._current_anim_time + l_7_1
		if l_7_0._total_animation_time <= l_7_0._current_anim_time and not l_7_0:shake_animation_loop() then
			l_7_0._current_animation = nil
			return 
		end
		l_7_0._current_animation = l_7_0:shake_animation_state()
		l_7_0._current_anim_time = l_7_0._current_anim_time % l_7_0._total_animation_time
	end
end

WorldCamera.update_camera = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = nil
	if l_8_0._camera_unit then
		l_8_0._camera_unit:set_position(l_8_1)
		l_8_3 = l_8_0._camera_unit:get_object("camera_offset"):rotation()
	else
		l_8_3 = l_8_0._animation_set:animation_rotation(l_8_0:shake_animation_state(), "at_camera", l_8_0._current_anim_time)
	end
	local l_8_4 = Rotation:look_at(l_8_1, l_8_2, Vector3(0, 0, 1)) * l_8_3
	l_8_2 = l_8_1 + l_8_4:y() * l_8_2 - l_8_1:length()
	managers.worldcamera:camera_controller():set_camera(l_8_1)
	managers.worldcamera:camera_controller():set_target(l_8_2)
	local l_8_5 = nil
	l_8_3 = l_8_3:rotate_with(Rotation:look_at(l_8_1, l_8_2, Vector3(0, 0, 1)))
	managers.worldcamera:camera_controller():set_default_up(l_8_3:z())
	local l_8_6 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_8_0._camera_unit then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	managers.worldcamera:camera_controller():set_camera_local_offset(nil:rotate_with(l_8_6))
	 -- DECOMPILER ERROR: Confused about usage of registers!

	managers.worldcamera:camera_controller():set_target_local_offset(nil:rotate_with(l_8_6))
end

WorldCamera.shake_animation_state = function(l_9_0)
	return l_9_0._shake_animation_state
end

WorldCamera.set_shake_animation_state = function(l_10_0, l_10_1)
	l_10_0._shake_animation_state = l_10_1
end

WorldCamera.shake_animation_delay = function(l_11_0)
	return l_11_0._shake_animation_delay
end

WorldCamera.set_shake_animation_delay = function(l_12_0, l_12_1)
	l_12_0._shake_animation_delay = l_12_1
end

WorldCamera.shake_animation_loop = function(l_13_0)
	return l_13_0._shake_animation_loop
end

WorldCamera.set_shake_animation_loop = function(l_14_0, l_14_1)
	l_14_0._shake_animation_loop = l_14_1
end

WorldCamera.save = function(l_15_0, l_15_1, l_15_2)
	CoreWorldCamera.save(l_15_0, l_15_1, l_15_2)
	l_15_2 = l_15_2 .. "\t"
	l_15_1:puts(save_value_string(l_15_0, "_shake_animation_state", l_15_2))
	l_15_1:puts(save_value_string(l_15_0, "_shake_animation_delay", l_15_2))
	l_15_1:puts(save_value_string(l_15_0, "_shake_animation_loop", l_15_2))
	l_15_1:puts(save_value_string(l_15_0, "_in_acc_type", l_15_2))
	l_15_1:puts(save_value_string(l_15_0, "_out_acc_type", l_15_2))
end

WorldCamera.load = function(l_16_0, l_16_1)
	CoreWorldCamera.load(l_16_0, l_16_1)
	if not l_16_0._in_acc_type then
		l_16_0._in_acc_type = CoreWorldCamera.in_acc_string(l_16_0)
	end
	if not l_16_0._out_acc_type then
		l_16_0._out_acc_type = CoreWorldCamera.out_acc_string(l_16_0)
	end
end

WorldCamera.positions_at_time = function(l_17_0, l_17_1)
	local l_17_2 = nil
	l_17_1 = math.clamp(l_17_1, 0, 1)
	local l_17_3 = l_17_0._time_transform_funcs[l_17_0._in_acc_type]
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_17_3 ~= l_17_0._time_transform_funcs[l_17_0._out_acc_type] then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_17_0._bezier then
		local l_17_4, l_17_5, l_17_6 = , l_17_0:bezier_function()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_17_5 then
		local l_17_7 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_17_8 = nil
		return l_17_5(l_17_0._positions, l_17_2), l_17_5(l_17_0._target_positions, l_17_2)
	end
	return l_17_0._positions[1], l_17_0._target_positions[1]
end

WorldCamera.bezier_time_transform = function(l_18_0, l_18_1)
	local l_18_2 = math.bezier
	local l_18_3 = {}
	local l_18_5 = 0
	local l_18_6 = l_18_0._in_acc
	local l_18_7 = l_18_0._out_acc
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_18_4 = 1
	return l_18_2(l_18_3, l_18_5)
end

WorldCamera.exponential_time_transform = function(l_19_0, l_19_1)
	if l_19_1 < 0.5 then
		l_19_1 = l_19_1 * 2
		l_19_1 = l_19_1 * (l_19_1) * (l_19_1) * (l_19_1)
		l_19_1 = l_19_1 * 0.5
	else
		l_19_1 = 1 - (l_19_1 * 2 - 1)
		l_19_1 = (l_19_1) * (l_19_1) * (l_19_1) * (l_19_1)
		l_19_1 = 1 - l_19_1 * 0.5
	end
	return l_19_1
end

WorldCamera.set_in_acc = function(l_20_0, l_20_1)
	CoreWorldCamera.set_in_acc(l_20_0, l_20_1)
	l_20_0._in_acc_type = l_20_1
end

WorldCamera.set_out_acc = function(l_21_0, l_21_1)
	CoreWorldCamera.set_out_acc(l_21_0, l_21_1)
	l_21_0._out_acc_type = l_21_1
end

WorldCamera.in_acc_string = function(l_22_0)
	if l_22_0._in_acc_type then
		return l_22_0._in_acc_type
	end
	assert(false, "No camera acceleration (in) type found")
end

WorldCamera.out_acc_string = function(l_23_0)
	if l_23_0._out_acc_type then
		return l_23_0._out_acc_type
	end
	assert(false, "No camera acceleration (out) type found")
end

WorldCamera.current_time = function(l_24_0)
	return l_24_0._timer
end


