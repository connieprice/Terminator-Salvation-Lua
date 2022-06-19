if not ControllerWrapperPC then
	ControllerWrapperPC = class(CoreControllerWrapperPC)
end
ControllerWrapperPC.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	local l_1_8 = Input:create_virtual_controller("empty_gamepad")
	l_1_0._input_released_cache = {}
	CoreControllerWrapperPC.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_8)
end

ControllerWrapperPC.get_modified_axis = function(l_2_0, l_2_1, l_2_2, l_2_3)
	if l_2_2:get_controller_id() ~= "mouse" and l_2_3:length() == 0 then
		l_2_3 = Vector3(0, 0, 0)
		l_2_0._current_lerp_axis_map[l_2_1] = l_2_3
		return l_2_3
	else
		local l_2_4 = CoreControllerWrapperPC.get_modified_axis
		local l_2_5 = l_2_0
		local l_2_6 = l_2_1
		local l_2_7 = l_2_2
		local l_2_8 = l_2_3
		return l_2_4(l_2_5, l_2_6, l_2_7, l_2_8)
	end
end

ControllerWrapperPC.get_input_released = function(l_3_0, l_3_1)
	if l_3_0._connection_map[l_3_1] then
		if not l_3_0._enabled or not l_3_0._virtual_controller or not l_3_0:get_connection_enabled(l_3_1) or not l_3_0._virtual_controller:released(l_3_1) then
			local l_3_4 = not not (l_3_0._input_released_cache[l_3_1] ~= nil or false)
		else
			Application:error(l_3_0:to_string() .. " No controller input binded to connection \"" .. tostring(l_3_1) .. "\".")
			local l_3_5, l_3_6 = false
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_3_0._input_released_cache[l_3_1] = l_3_5
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_3_5
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 27 
end

ControllerWrapperPC.reset_cache = function(l_4_0, l_4_1)
	local l_4_2 = TimerManager:wall():time()
	if (not l_4_1 or l_4_0._reset_cache_time < l_4_2) and next(l_4_0._input_released_cache) then
		l_4_0._input_released_cache = {}
	end
	CoreControllerWrapper.reset_cache(l_4_0, l_4_1)
end


