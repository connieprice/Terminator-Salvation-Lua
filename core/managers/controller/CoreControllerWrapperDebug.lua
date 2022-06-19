require("core/managers/controller/CoreControllerWrapper")
if not CoreControllerWrapperDebug then
	CoreControllerWrapperDebug = class(CoreControllerWrapper)
end
CoreControllerWrapperDebug.TYPE = "debug"
CoreControllerWrapperDebug.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5)
	l_1_0._controller_wrapper_list = l_1_1
	l_1_0._default_controller_wrapper = l_1_4
	local l_1_6 = get_core_or_local("ControllerWrapper").init
	local l_1_7 = l_1_0
	local l_1_8 = l_1_2
	local l_1_9 = l_1_3
	local l_1_10 = {}
	if l_1_4 then
		l_1_6(l_1_7, l_1_8, l_1_9, l_1_10, l_1_4:get_default_controller_id(), l_1_5, true, true)
		l_1_6 = ipairs
		l_1_7 = l_1_1
		l_1_6 = l_1_6(l_1_7)
		for l_1_9,l_1_10 in l_1_6 do
			local l_1_14, l_1_15 = pairs, l_1_10:get_controller_map()
			l_1_14 = l_1_14(l_1_15)
			for i_0,i_1 in l_1_14 do
				l_1_0._controller_map[l_1_13] = i_1
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

CoreControllerWrapperDebug.destroy = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	get_core_or_local("ControllerWrapper").destroy(l_2_0)
	for i_0,i_1 in ipairs(l_2_0._controller_wrapper_list) do
		i_1:destroy()
	end
end

CoreControllerWrapperDebug.update = function(l_3_0, l_3_1, l_3_2)
	local l_3_7, l_3_8 = nil
	local l_3_6 = get_core_or_local("ControllerWrapper").update
	l_3_6(l_3_0, l_3_1, l_3_2)
	l_3_6 = ipairs
	l_3_6 = l_3_6(l_3_0._controller_wrapper_list)
	for i_0,i_1 in l_3_6 do
		i_1:update(l_3_1, l_3_2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.paused_update = function(l_4_0, l_4_1, l_4_2)
	local l_4_7, l_4_8 = nil
	local l_4_6 = get_core_or_local("ControllerWrapper").paused_update
	l_4_6(l_4_0, l_4_1, l_4_2)
	l_4_6 = ipairs
	l_4_6 = l_4_6(l_4_0._controller_wrapper_list)
	for i_0,i_1 in l_4_6 do
		i_1:paused_update(l_4_1, l_4_2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.rebind_connections = function(l_5_0, l_5_1, l_5_2)
	local l_5_6, l_5_7, l_5_8, l_5_9, l_5_10, l_5_11 = nil
	get_core_or_local("ControllerWrapper").rebind_connections(l_5_0)
	for i_0,i_1 in ipairs(l_5_0._controller_wrapper_list) do
		i_1:rebind_connections(l_5_2[i_1:get_type()], l_5_2)
	end
end

CoreControllerWrapperDebug.setup = function(l_6_0, ...)
end

CoreControllerWrapperDebug.get_any_input = function(l_7_0, ...)
	local l_7_4, l_7_5 = nil
	for i_0,i_1 in ipairs(l_7_0._controller_wrapper_list) do
		if i_1:get_any_input(...) then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.get_input_pressed = function(l_8_0, ...)
	local l_8_4, l_8_5, l_8_6, l_8_7 = nil
	for i_0,i_1 in ipairs(l_8_0._controller_wrapper_list) do
		if i_1:connection_exist(...) and i_1:get_input_pressed(...) then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.get_input_bool = function(l_9_0, ...)
	local l_9_4, l_9_5, l_9_6, l_9_7 = nil
	for i_0,i_1 in ipairs(l_9_0._controller_wrapper_list) do
		if i_1:connection_exist(...) and i_1:get_input_bool(...) then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.get_input_float = function(l_10_0, ...)
	local l_10_5, l_10_6, l_10_7, l_10_8 = nil
	for i_0,i_1 in ipairs(l_10_0._controller_wrapper_list) do
		local l_10_2 = 0
		if i_1:connection_exist(...) then
			l_10_2 = math.max(l_10_2, i_1:get_input_float(...))
		end
	end
	return l_10_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.get_input_axis = function(l_11_0, ...)
	local l_11_5, l_11_6, l_11_7, l_11_8, l_11_9, l_11_10 = nil
	for i_0,i_1 in ipairs(l_11_0._controller_wrapper_list) do
		local l_11_2 = Vector3(0, 0, 0)
		if i_1:connection_exist(...) and l_11_2:length() < i_1:get_input_axis(...):length() then
			l_11_2 = i_1:get_input_axis(...)
		end
	end
	return l_11_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.get_connection_map = function(l_12_0, ...)
	local l_12_5, l_12_6, l_12_7, l_12_8 = nil
	for i_0,i_1 in ipairs(l_12_0._controller_wrapper_list) do
		local l_12_2 = {}
		for i_0,i_1 in pairs(i_1:get_connection_map(...)) do
			local l_12_10 = nil
			l_12_2[i_0] = i_1
		end
	end
	return l_12_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.connection_exist = function(l_13_0, ...)
	local l_13_4, l_13_5 = nil
	for i_0,i_1 in ipairs(l_13_0._controller_wrapper_list) do
		if i_1:connection_exist(...) then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.set_enabled = function(l_14_0, ...)
	local l_14_4, l_14_5, l_14_6, l_14_7 = nil
	for i_0,i_1 in ipairs(l_14_0._controller_wrapper_list) do
		i_1:set_enabled(...)
	end
end

CoreControllerWrapperDebug.enable = function(l_15_0, ...)
	local l_15_4, l_15_5, l_15_6, l_15_7 = nil
	for i_0,i_1 in ipairs(l_15_0._controller_wrapper_list) do
		i_1:enable(...)
	end
	l_15_0._enabled = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.disable = function(l_16_0, ...)
	local l_16_4, l_16_5, l_16_6, l_16_7 = nil
	for i_0,i_1 in ipairs(l_16_0._controller_wrapper_list) do
		i_1:disable(...)
	end
	l_16_0._enabled = false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.add_trigger = function(l_17_0, ...)
	local l_17_4, l_17_5, l_17_6, l_17_7, l_17_8, l_17_9 = nil
	for i_0,i_1 in ipairs(l_17_0._controller_wrapper_list) do
		if i_1:connection_exist(...) then
			i_1:add_trigger(...)
		end
	end
end

CoreControllerWrapperDebug.add_release_trigger = function(l_18_0, ...)
	local l_18_4, l_18_5, l_18_6, l_18_7, l_18_8, l_18_9 = nil
	for i_0,i_1 in ipairs(l_18_0._controller_wrapper_list) do
		if i_1:connection_exist(...) then
			i_1:add_release_trigger(...)
		end
	end
end

CoreControllerWrapperDebug.clear_triggers = function(l_19_0, ...)
	local l_19_4, l_19_5, l_19_6, l_19_7 = nil
	for i_0,i_1 in ipairs(l_19_0._controller_wrapper_list) do
		i_1:clear_triggers(...)
	end
end

CoreControllerWrapperDebug.reset_cache = function(l_20_0, ...)
	local l_20_4, l_20_5, l_20_6, l_20_7 = nil
	for i_0,i_1 in ipairs(l_20_0._controller_wrapper_list) do
		i_1:reset_cache(...)
	end
end

CoreControllerWrapperDebug.restore_triggers = function(l_21_0, ...)
	local l_21_4, l_21_5, l_21_6, l_21_7 = nil
	for i_0,i_1 in ipairs(l_21_0._controller_wrapper_list) do
		i_1:restore_triggers(...)
	end
end

CoreControllerWrapperDebug.clear_connections = function(l_22_0, ...)
	local l_22_4, l_22_5, l_22_6, l_22_7 = nil
	for i_0,i_1 in ipairs(l_22_0._controller_wrapper_list) do
		i_1:clear_connections(...)
	end
end

CoreControllerWrapperDebug.get_setup = function(l_23_0, ...)
	if l_23_0._default_controller_wrapper then
		return l_23_0._default_controller_wrapper:get_setup(...)
	end
end

CoreControllerWrapperDebug.get_connection_settings = function(l_24_0, ...)
	if l_24_0._default_controller_wrapper then
		return l_24_0._default_controller_wrapper:get_connection_settings(...)
	end
end

CoreControllerWrapperDebug.get_connection_enabled = function(l_25_0, ...)
	local l_25_4, l_25_5 = nil
	for i_0,i_1 in ipairs(l_25_0._controller_wrapper_list) do
		if i_1:get_connection_enabled(...) then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperDebug.set_connection_enabled = function(l_26_0, ...)
	local l_26_4, l_26_5, l_26_6, l_26_7 = nil
	for i_0,i_1 in ipairs(l_26_0._controller_wrapper_list) do
		i_1:set_connection_enabled(...)
	end
end


