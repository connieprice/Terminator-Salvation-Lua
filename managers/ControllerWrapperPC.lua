ControllerWrapperPC = ControllerWrapperPC or class(CoreControllerWrapperPC)
function ControllerWrapperPC.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	local L8_8
	L8_8 = Input
	L8_8 = L8_8.create_virtual_controller
	L8_8 = L8_8(L8_8, "empty_gamepad")
	A0_0._input_released_cache = {}
	CoreControllerWrapperPC.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, L8_8)
end
function ControllerWrapperPC.get_modified_axis(A0_9, A1_10, A2_11, A3_12)
	if A2_11:get_controller_id() ~= "mouse" and A3_12:length() == 0 then
		A3_12 = Vector3(0, 0, 0)
		A0_9._current_lerp_axis_map[A1_10] = A3_12
		return A3_12
	else
		return CoreControllerWrapperPC.get_modified_axis(A0_9, A1_10, A2_11, A3_12)
	end
end
function ControllerWrapperPC.get_input_released(A0_13, A1_14)
	local L2_15
	L2_15 = A0_13._input_released_cache
	L2_15 = L2_15[A1_14]
	if L2_15 == nil then
		if A0_13._connection_map[A1_14] then
			L2_15 = A0_13._enabled and A0_13._virtual_controller and A0_13:get_connection_enabled(A1_14) and A0_13._virtual_controller:released(A1_14) or false
			L2_15 = not not L2_15
		else
			Application:error(A0_13:to_string() .. " No controller input binded to connection \"" .. tostring(A1_14) .. "\".")
			L2_15 = false
		end
		A0_13._input_released_cache[A1_14] = L2_15
	end
	return L2_15
end
function ControllerWrapperPC.reset_cache(A0_16, A1_17)
	if (not A1_17 or TimerManager:wall():time() > A0_16._reset_cache_time) and next(A0_16._input_released_cache) then
		A0_16._input_released_cache = {}
	end
	CoreControllerWrapper.reset_cache(A0_16, A1_17)
end
