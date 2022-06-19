require("core/managers/controller/CoreControllerWrapperSettings")
if not CoreControllerWrapper then
	CoreControllerWrapper = class()
end
CoreControllerWrapper.TYPE = "generic"
CoreControllerWrapper.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8)
	l_1_0._id = l_1_1
	l_1_0._name = l_1_2
	l_1_0._controller_map = l_1_3
	l_1_0._default_controller_id = l_1_4
	l_1_0._setup = l_1_5
	l_1_0._debug = l_1_6
	if not l_1_7 then
		local l_1_12, l_1_13 = Input:create_virtual_controller, Input
		l_1_12 = l_1_12(l_1_13, "ctrl_" .. tostring(l_1_0._id))
		l_1_0._virtual_controller = l_1_12
	end
	if not l_1_8 then
		l_1_0._custom_virtual_connect_func_map = {}
	end
	for i_0 in pairs(l_1_3) do
		if not l_1_0._custom_virtual_connect_func_map[i_0] then
			l_1_0._custom_virtual_connect_func_map[i_0] = {}
		end
	end
	l_1_0._connection_map = {}
	l_1_0._trigger_map = {}
	l_1_0._release_trigger_map = {}
	l_1_0._current_lerp_axis_map = {}
	l_1_0._claimed = false
	l_1_0._enabled = true
	l_1_0._delay_map = {}
	l_1_0._delay_bool_map = {}
	l_1_0._multi_input_map = {}
	l_1_0:setup(l_1_0._setup)
	l_1_0._was_connected = l_1_0:connected()
	l_1_0._reset_cache_time = -1
	l_1_0._delay_trigger_queue = {}
	l_1_0._input_pressed_cache = {}
	l_1_0._input_bool_cache = {}
	l_1_0._input_float_cache = {}
	l_1_0._input_axis_cache = {}
	l_1_0:reset_cache(false)
	l_1_0._destroy_callback_list = {}
	l_1_0._last_destroy_callback_id = 0
	l_1_0._connect_changed_callback_list = {}
	l_1_0._last_connect_changed_callback_id = 0
	l_1_0._rebind_callback_list = {}
	l_1_0._last_rebind_callback_id = 0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapper.destroy = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7, l_2_8 = nil
	for i_0,i_1 in pairs(l_2_0._destroy_callback_list) do
		i_1(l_2_0, i_0)
	end
	if alive(l_2_0._virtual_controller) then
		Input:destroy_virtual_controller(l_2_0._virtual_controller)
		l_2_0._virtual_controller = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapper.update = function(l_3_0, l_3_1, l_3_2)
	l_3_0:reset_cache(true)
	l_3_0:update_delay_trigger_queue()
	l_3_0:check_connect_changed_status()
end

CoreControllerWrapper.paused_update = function(l_4_0, l_4_1, l_4_2)
	l_4_0:reset_cache(true)
	l_4_0:update_delay_trigger_queue()
	l_4_0:check_connect_changed_status()
end

CoreControllerWrapper.reset_cache = function(l_5_0, l_5_1)
	local l_5_2 = TimerManager:wall():time()
	if not l_5_1 or l_5_0._reset_cache_time < l_5_2 then
		l_5_0._input_any_cache = nil
		l_5_0._input_any_pressed_cache = nil
		l_5_0._input_any_released_cache = nil
		if next(l_5_0._input_pressed_cache) then
			l_5_0._input_pressed_cache = {}
		end
		if next(l_5_0._input_bool_cache) then
			l_5_0._input_bool_cache = {}
		end
		if next(l_5_0._input_float_cache) then
			l_5_0._input_float_cache = {}
		end
		if next(l_5_0._input_axis_cache) then
			l_5_0._input_axis_cache = {}
		end
		l_5_0:update_multi_input()
		l_5_0:update_delay_input()
		l_5_0._reset_cache_time = l_5_2
	end
end

CoreControllerWrapper.update_delay_trigger_queue = function(l_6_0)
	local l_6_4, l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15 = nil
	if l_6_0._enabled and l_6_0._virtual_controller then
		for i_0,i_1 in pairs(l_6_0._delay_trigger_queue) do
			if not l_6_0._virtual_controller:down(i_0) then
				l_6_0._delay_trigger_queue[i_0] = nil
			else
				if l_6_0:get_input_bool(i_0) then
					l_6_0._delay_trigger_queue[i_0] = nil
					i_1.func(unpack(i_1.func_params))
				end
			end
		end
	end
end

CoreControllerWrapper.check_connect_changed_status = function(l_7_0)
	local l_7_5, l_7_6, l_7_7, l_7_8, l_7_9 = nil
	local l_7_1 = l_7_0:connected()
	if l_7_1 ~= l_7_0._was_connected then
		for i_0,i_1 in pairs(l_7_0._connect_changed_callback_list) do
			i_1(l_7_0, l_7_1, i_0)
		end
		l_7_0._was_connected = l_7_1
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapper.update_multi_input = function(l_8_0)
	local l_8_4, l_8_5, l_8_6, l_8_7, l_8_8, l_8_13, l_8_14 = nil
	if l_8_0._enabled and l_8_0._virtual_controller then
		for i_0,i_1 in pairs(l_8_0._multi_input_map) do
			if l_8_0:get_connection_enabled(i_0) then
				for i_0,i_1 in ipairs(i_1) do
					local l_8_11 = nil
					l_8_11 = l_8_0._virtual_controller:down(i_1)
					if not l_8_11 then
						do return end
					end
				end
				if l_8_11 then
					l_8_0._input_bool_cache[l_8_9] = l_8_11
				end
			else
				l_8_0._input_bool_cache[l_8_9] = false
				l_8_0._input_pressed_cache[l_8_9] = false
				l_8_0._input_float_cache[l_8_9] = 0
				l_8_0._input_axis_cache[l_8_9] = Vector3()
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
	end
end

CoreControllerWrapper.update_delay_input = function(l_9_0)
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_18, l_9_19, l_9_20, l_9_21, l_9_22, l_9_28, l_9_29 = nil
	if l_9_0._enabled and l_9_0._virtual_controller then
		local l_9_1 = TimerManager:wall():time()
		for i_0,i_1 in pairs(l_9_0._delay_map) do
			if l_9_0:get_connection_enabled(i_0) then
				local l_9_14 = i_1.delay_time_map
			if i_1.connection:get_delay() > 0 then
				end
				if not l_9_0:get_input_bool(l_9_12) then
					for i_0,i_1 in pairs(l_9_14) do
						local l_9_15, l_9_16 = nil
						if (l_9_0:get_input_bool(i_0)) then
							if not i_1 then
								do return end
							end
							if i_1 > l_9_1 or not true then
								l_9_0._input_bool_cache[i_0] = false
								l_9_0._input_pressed_cache[l_9_12] = false
								l_9_0._input_float_cache[i_0] = 0
								l_9_0._input_axis_cache[i_0] = Vector3()
							end
						elseif i_1 then
							l_9_14[i_0] = false
						end
					end
				end
			else
				for i_0,i_1 in pairs(l_9_14) do
					local l_9_25, l_9_26 = nil
					l_9_14[i_0] = l_9_1 - l_9_26
				end
			end
		end
	end
end

CoreControllerWrapper.add_destroy_callback = function(l_10_0, l_10_1)
	l_10_0._last_destroy_callback_id = l_10_0._last_destroy_callback_id + 1
	l_10_0._destroy_callback_list[l_10_0._last_destroy_callback_id] = l_10_1
	return l_10_0._last_destroy_callback_id
end

CoreControllerWrapper.remove_destroy_callback = function(l_11_0, l_11_1)
	l_11_0._destroy_callback_list[l_11_1] = nil
end

CoreControllerWrapper.add_connect_changed_callback = function(l_12_0, l_12_1)
	l_12_0._last_connect_changed_callback_id = l_12_0._last_connect_changed_callback_id + 1
	l_12_0._connect_changed_callback_list[l_12_0._last_connect_changed_callback_id] = l_12_1
	return l_12_0._last_connect_changed_callback_id
end

CoreControllerWrapper.remove_connect_changed_callback = function(l_13_0, l_13_1)
	l_13_0._connect_changed_callback_list[l_13_1] = nil
end

CoreControllerWrapper.add_rebind_callback = function(l_14_0, l_14_1)
	l_14_0._last_rebind_callback_id = l_14_0._last_rebind_callback_id + 1
	l_14_0._rebind_callback_list[l_14_0._last_rebind_callback_id] = l_14_1
	return l_14_0._last_rebind_callback_id
end

CoreControllerWrapper.remove_rebind_callback = function(l_15_0, l_15_1)
	l_15_0._rebind_callback_list[l_15_1] = nil
end

CoreControllerWrapper.rebind_connections = function(l_16_0, l_16_1, l_16_2)
	local l_16_6, l_16_7, l_16_8, l_16_9, l_16_10 = nil
	l_16_0:clear_connections(false)
	l_16_0:clear_triggers(true)
	local l_16_3, l_16_4 = l_16_0:setup, l_16_0
	if not l_16_1 then
		l_16_3(l_16_4, l_16_0._setup)
	end
	l_16_3 = l_16_0._enabled
	if l_16_3 then
		l_16_3, l_16_4 = l_16_0:restore_triggers, l_16_0
		l_16_3(l_16_4)
	end
	l_16_3 = pairs
	l_16_4 = l_16_0._rebind_callback_list
	l_16_3 = l_16_3(l_16_4)
	for i_0,i_1 in l_16_3 do
		i_1(l_16_0, i_0)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapper.setup = function(l_17_0, l_17_1)
	local l_17_6, l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_14, l_17_15 = nil
	if l_17_1 then
		l_17_0._setup = l_17_1
		local l_17_2 = l_17_1:get_connection_map()
		for i_0,i_1 in pairs(l_17_2) do
			end
			if not i_1:get_controller_id() then
				local l_17_17 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_17_0:setup_connection(l_17_17, l_17_16, l_17_0._default_controller_id, l_17_0._controller_map[l_17_0._default_controller_id])
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

CoreControllerWrapper.setup_connection = function(l_18_0, l_18_1, l_18_2, l_18_3, l_18_4)
	local l_18_9, l_18_10, l_18_11, l_18_12, l_18_13, l_18_37, l_18_38, l_18_42, l_18_43, l_18_44, l_18_45, l_18_46, l_18_47, l_18_48, l_18_49 = nil
	if l_18_0._debug or not l_18_2:get_debug() then
		local l_18_5 = l_18_2:get_input_name_list()
		for i_0,i_1 in ipairs(l_18_5) do
			local l_18_26, l_18_27, l_18_28, l_18_29 = l_18_0:connect, l_18_0
			l_18_28 = l_18_3
			local l_18_16 = nil
			l_18_29 = l_18_15
			local l_18_17 = nil
			l_18_16 = l_18_1
			local l_18_18 = nil
			l_18_17 = l_18_2
			local l_18_19 = nil
			l_18_18 = l_18_14 ~= 1
			l_18_19 = #l_18_5
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			do
				if l_18_19 > 0 then
					local l_18_22 = nil
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			else
				l_18_26(l_18_27, l_18_28, l_18_29, l_18_16, l_18_17, l_18_18, l_18_19)
			end
		end
		for i_0,i_1 in ipairs(l_18_2:get_delay_connection_list()) do
			if l_18_0._setup:get_connection(i_1:get_name()) then
				local l_18_32 = nil
				do
					local l_18_33 = nil
					 -- DECOMPILER ERROR: Overwrote pending register.

					for i_0,i_1 in ipairs(l_18_19) do
						local l_18_34, l_18_35 = , nil
						for i_0,i_1 in ipairs(l_18_5) do
							do
								if i_1 == i_1 then
									if not nil then
										{}.delay_time_map = {}
										 -- DECOMPILER ERROR: Confused about usage of registers!

										{}.connection = l_18_2
									end
									 -- DECOMPILER ERROR: Confused about usage of registers!

									({}).delay_time_map[l_18_32] = false
									l_18_0._delay_bool_map[l_18_32] = true
									l_18_35 = true
							else
								end
							end
						end
						if l_18_35 then
							for l_18_30,l_18_31 in ipairs(l_18_2:get_delay_connection_list()) do
							end
						end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

				else
					Application:error(l_18_0:to_string() .. " Unable to setup delay on non-existing connection \"" .. tostring(l_18_32) .. "\" in the \"" .. i_1 .. "\" connection.")
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_18_0._delay_map[l_18_1] = {}
		if l_18_2.IS_AXIS then
			end
			if not l_18_2:get_init_lerp_axis() and (not l_18_0._virtual_controller or not l_18_0._virtual_controller:axis(l_18_1)) then
				l_18_0._current_lerp_axis_map[l_18_1] = Vector3()
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreControllerWrapper.connect = function(l_19_0, l_19_1, l_19_2, l_19_3, l_19_4, l_19_5, l_19_6)
	local l_19_7 = l_19_0._controller_map
	do
		if not l_19_1 then
			l_19_7 = l_19_7[l_19_0._default_controller_id]
			if l_19_7 then
				if l_19_0._virtual_controller then
					if not l_19_5 and l_19_0._connection_map[l_19_3] then
						Application:error(l_19_0:to_string() .. " Controller already has a \"" .. tostring(l_19_3) .. "\" connection. Overwrites existing one.")
					end
					l_19_0:virtual_connect(l_19_1, l_19_7, l_19_2, l_19_3, l_19_4)
					l_19_0._connection_map[l_19_3] = true
					if l_19_6 then
						if not l_19_0._multi_input_map[l_19_3] then
							local l_19_9 = {}
							l_19_0:virtual_connect(l_19_1, l_19_7, l_19_2, tostring(l_19_3) .. "_for_single_input_" .. tostring(l_19_2), l_19_4)
							 -- DECOMPILER ERROR: Confused about usage of registers!

							table.insert(l_19_9, tostring(l_19_3) .. "_for_single_input_" .. tostring(l_19_2))
							l_19_0._multi_input_map[l_19_3] = l_19_9
						end
					else
						Application:stack_dump_error("Tried to connect to a destroyed virtual controller.")
					end
				else
					error("Invalid controller wrapper. Tried to connect to non-existing controller id \"" .. tostring(l_19_1) .. "\".")
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 5 44 
end

CoreControllerWrapper.virtual_connect = function(l_20_0, l_20_1, l_20_2, l_20_3, l_20_4, l_20_5)
	local l_20_6 = l_20_0._custom_virtual_connect_func_map[l_20_1][l_20_3]
	if l_20_6 then
		l_20_6(l_20_1, l_20_2, l_20_3, l_20_4, l_20_5)
	else
		l_20_0:virtual_connect2(l_20_0, l_20_1, l_20_2, l_20_3, l_20_4, l_20_5)
	end
end

CoreControllerWrapper.virtual_connect2 = function(l_21_0, l_21_1, l_21_2, l_21_3, l_21_4, l_21_5)
	local l_21_6, l_21_7, l_21_8, l_21_9 = l_21_5:get_range()
	local l_21_10 = l_21_5:get_connect_src_type()
	local l_21_11 = l_21_5:get_connect_dest_type()
	l_21_0._virtual_controller:connect(l_21_2, l_21_10, l_21_3, "range", l_21_6, l_21_7, l_21_11, l_21_4, "range", l_21_8, l_21_9)
end

CoreControllerWrapper.connected = function(l_22_0, l_22_1)
	local l_22_4, l_22_5, l_22_6, l_22_7, l_22_8, l_22_12, l_22_13 = nil
	if l_22_1 then
		local l_22_2, l_22_3 = l_22_0._controller_map[l_22_1]:connected, l_22_0._controller_map[l_22_1]
		return l_22_2(l_22_3)
	else
		for i_0,i_1 in pairs(l_22_0._controller_map) do
			if not i_1:connected() then
				return false
			end
		end
		return true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapper.get_setup = function(l_23_0)
	return l_23_0._setup
end

CoreControllerWrapper.get_connection_settings = function(l_24_0, l_24_1)
	local l_24_2, l_24_3 = l_24_0._setup:get_connection, l_24_0._setup
	local l_24_4 = l_24_1
	return l_24_2(l_24_3, l_24_4)
end

CoreControllerWrapper.get_default_controller_id = function(l_25_0)
	return l_25_0._default_controller_id
end

CoreControllerWrapper.get_type = function(l_26_0)
	return l_26_0.TYPE
end

CoreControllerWrapper.get_id = function(l_27_0)
	return l_27_0._id
end

CoreControllerWrapper.get_name = function(l_28_0)
	return l_28_0._name
end

CoreControllerWrapper.get_debug = function(l_29_0)
	return l_29_0._debug
end

CoreControllerWrapper.get_connection_map = function(l_30_0)
	return l_30_0._connection_map
end

CoreControllerWrapper.get_controller_map = function(l_31_0)
	return l_31_0._controller_map
end

CoreControllerWrapper.get_controller = function(l_32_0, l_32_1)
	local l_32_2 = l_32_0._controller_map
	do
		if not l_32_1 then
			l_32_2 = l_32_2[l_32_0._default_controller_id]
			return l_32_2
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapper.connection_exist = function(l_33_0, l_33_1)
	return l_33_0._connection_map[l_33_1] ~= nil
end

CoreControllerWrapper.set_enabled = function(l_34_0, l_34_1)
	if l_34_1 then
		l_34_0:enable()
	else
		l_34_0:disable()
	end
end

CoreControllerWrapper.enable = function(l_35_0)
	if not l_35_0._enabled then
		cat_print("controller_manager", "[ControllerManager] Enabled controller \"" .. tostring(l_35_0._name) .. "\".")
		if l_35_0._virtual_controller then
			l_35_0._virtual_controller:set_enabled(true)
		end
		l_35_0._enabled = true
		l_35_0:clear_triggers(true)
		l_35_0:restore_triggers()
		l_35_0:reset_cache(false)
	end
end

CoreControllerWrapper.disable = function(l_36_0)
	if l_36_0._enabled then
		cat_print("controller_manager", "[ControllerManager] Disabled controller \"" .. tostring(l_36_0._name) .. "\".")
		l_36_0._enabled = false
		l_36_0:clear_triggers(true)
		l_36_0:reset_cache(false)
	if l_36_0._virtual_controller then
		end
		l_36_0._virtual_controller:set_enabled(false)
	end
end

CoreControllerWrapper.enabled = function(l_37_0)
	return l_37_0._enabled
end

CoreControllerWrapper.is_claimed = function(l_38_0)
	return l_38_0._claimed
end

CoreControllerWrapper.set_claimed = function(l_39_0, l_39_1)
	l_39_0._claimed = l_39_1
end

CoreControllerWrapper.add_trigger = function(l_40_0, l_40_1, l_40_2)
	local l_40_3 = {}
	if not l_40_0._trigger_map[l_40_1] then
		l_40_0._trigger_map[l_40_1] = {}
	end
	if l_40_0._trigger_map[l_40_1][l_40_2] then
		Application:error(l_40_0:to_string() .. " Unable to register already existing trigger for function \"" .. tostring(l_40_2) .. "\" on connection \"" .. tostring(l_40_1) .. "\".")
		return 
	end
	l_40_3.original_func = l_40_2
	l_40_3.func = l_40_0:get_trigger_func(l_40_1, l_40_2)
	if l_40_0._virtual_controller and l_40_0:get_connection_enabled(l_40_1) then
		l_40_3.id = l_40_0._virtual_controller:add_trigger(l_40_1, l_40_3.func)
	end
	l_40_0._trigger_map[l_40_1][l_40_2] = l_40_3
end

CoreControllerWrapper.add_release_trigger = function(l_41_0, l_41_1, l_41_2)
	local l_41_3 = {}
	if not l_41_0._release_trigger_map[l_41_1] then
		l_41_0._release_trigger_map[l_41_1] = {}
	end
	l_41_3.original_func = l_41_2
	l_41_3.func = l_41_0:get_release_trigger_func(l_41_1, l_41_2)
	if l_41_0._virtual_controller and l_41_0:get_connection_enabled(l_41_1) then
		l_41_3.id = l_41_0._virtual_controller:add_release_trigger(l_41_1, l_41_3.func)
	end
	l_41_0._release_trigger_map[l_41_1][l_41_2] = l_41_3
end

CoreControllerWrapper.get_trigger_func = function(l_42_0, l_42_1, l_42_2)
	local l_42_3 = l_42_0
	if l_42_0._delay_bool_map[l_42_1] or l_42_0._multi_input_map[l_42_1] then
		return function(...)
		-- upvalues: l_42_3 , l_42_1 , l_42_2
		l_42_3:reset_cache(true)
		if l_42_3:get_input_bool(l_42_1) then
			l_42_2(...)
		else
			l_42_3:queue_delay_trigger(l_42_1, l_42_2, ...)
		end
  end
	else
		return function(...)
		-- upvalues: l_42_3 , l_42_2
		l_42_3:reset_cache(true)
		l_42_2(...)
  end
	end
end

CoreControllerWrapper.get_release_trigger_func = function(l_43_0, l_43_1, l_43_2)
	local l_43_3 = l_43_0
	if l_43_0._delay_bool_map[l_43_1] or l_43_0._multi_input_map[l_43_1] then
		return function(...)
		-- upvalues: l_43_3 , l_43_1 , l_43_2
		l_43_3:reset_cache(true)
		if l_43_3:get_input_bool(l_43_1) then
			l_43_2(...)
		end
  end
	else
		return function(...)
		-- upvalues: l_43_3 , l_43_2
		l_43_3:reset_cache(true)
		l_43_2(...)
  end
	end
end

CoreControllerWrapper.queue_delay_trigger = function(l_44_0, l_44_1, l_44_2, ...)
	local l_44_4 = l_44_0._delay_trigger_queue
	local l_44_5 = {func = l_44_2}
	l_44_5.func_params = {...}
	l_44_4[l_44_1] = l_44_5
end

CoreControllerWrapper.has_trigger = function(l_45_0, l_45_1, l_45_2)
	local l_45_3 = l_45_0._trigger_map[l_45_1]
	do
		if l_45_3 then
			return l_45_3[l_45_2]
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapper.has_release_trigger = function(l_46_0, l_46_1, l_46_2)
	local l_46_3 = l_46_0._release_trigger_map[l_46_1]
	do
		if l_46_3 then
			return l_46_3[l_46_2]
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapper.remove_trigger = function(l_47_0, l_47_1, l_47_2)
	local l_47_3 = l_47_0._trigger_map[l_47_1]
	if l_47_3 then
		if l_47_2 then
			local l_47_4 = l_47_3[l_47_2]
			if l_47_4 then
				local l_47_5 = l_47_0._delay_trigger_queue[l_47_1]
				if l_47_5 and l_47_4.original_func == l_47_5.func then
					l_47_0._delay_trigger_queue[l_47_1] = nil
				end
				if l_47_4.id then
					l_47_0._virtual_controller:remove_trigger(l_47_4.id)
					l_47_4.id = nil
				end
			else
				local l_47_10, l_47_12, l_47_14 = Application:error, Application, l_47_0:to_string()
				l_47_14 = l_47_14 .. " Unable to remove non-existing trigger for function \"" .. tostring(l_47_2) .. "\" on connection \"" .. tostring(l_47_1) .. "\"."
				local l_47_9, l_47_11, l_47_13 = nil
				l_47_10(l_47_12, l_47_14)
			end
		else
			l_47_0._delay_trigger_queue[l_47_1] = nil
			for i_0,i_1 in pairs(l_47_3) do
				l_47_0._virtual_controller:remove_trigger(i_1.id)
				i_1.id = nil
			end
		end
		l_47_0._trigger_map[l_47_1] = nil
	else
		Application:error(l_47_0:to_string() .. " Unable to remove trigger on non-existing connection \"" .. tostring(l_47_1) .. "\".")
	end
end

CoreControllerWrapper.remove_release_trigger = function(l_48_0, l_48_1, l_48_2)
	local l_48_3 = l_48_0._release_trigger_map[l_48_1]
	if l_48_3 then
		if l_48_2 then
			trigger = l_48_3[l_48_2]
			if trigger and trigger.id then
				l_48_0._virtual_controller:remove_trigger(trigger.id)
				trigger.id = nil
			end
			do return end
			local l_48_7, l_48_9, l_48_11 = Application:error, Application, l_48_0:to_string()
			local l_48_8, l_48_10, l_48_12 = " Unable to remove non-existing release trigger for function \"", tostring(l_48_2)
			l_48_12 = "\" on connection \""
			l_48_11 = l_48_11 .. l_48_8 .. l_48_10 .. l_48_12 .. tostring(l_48_1) .. "\"."
			l_48_7(l_48_9, l_48_11)
		else
			for i_0,i_1 in pairs(l_48_3) do
				l_48_0._virtual_controller:remove_trigger(i_1.id)
				i_1.id = nil
			end
		end
		l_48_0._release_trigger_map[l_48_1] = nil
	else
		Application:error(l_48_0:to_string() .. " Unable to remove release trigger on non-existing connection \"" .. tostring(l_48_1) .. "\".")
	end
end

CoreControllerWrapper.clear_triggers = function(l_49_0, l_49_1)
	local l_49_5, l_49_6, l_49_7, l_49_8, l_49_12, l_49_13, l_49_14, l_49_15, l_49_16, l_49_17, l_49_21, l_49_22 = nil
	if l_49_0._virtual_controller then
		l_49_0._virtual_controller:clear_triggers()
	end
	l_49_0._delay_trigger_queue = {}
	if l_49_1 then
		for i_0,i_1 in pairs(l_49_0._trigger_map) do
			for i_0,i_1 in pairs(i_1) do
				i_1.id = nil
			end
		end
		for i_0,i_1 in pairs(l_49_0._release_trigger_map) do
			for i_0,i_1 in pairs(i_1) do
				do
					i_1.id = nil
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
	else
		l_49_0._trigger_map = {}
		l_49_0._release_trigger_map = {}
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapper.restore_triggers = function(l_50_0)
	local l_50_4, l_50_5, l_50_6, l_50_7, l_50_8, l_50_9, l_50_13, l_50_14, l_50_15, l_50_16, l_50_17, l_50_18, l_50_19, l_50_20, l_50_21, l_50_22, l_50_26, l_50_27, l_50_28, l_50_29 = nil
	if l_50_0._virtual_controller then
		for i_0,i_1 in pairs(l_50_0._trigger_map) do
			for i_0,i_1 in pairs(i_1) do
				if l_50_0:get_connection_enabled(l_50_10) then
					i_1.id = l_50_0._virtual_controller:add_trigger(l_50_10, i_1.func)
				end
			end
		end
		for i_0,i_1 in pairs(l_50_0._release_trigger_map) do
			for i_0,i_1 in pairs(i_1) do
				do
					if l_50_0:get_connection_enabled(l_50_23) then
						i_1.id = l_50_0._virtual_controller:add_release_trigger(l_50_23, i_1.func)
					end
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapper.clear_connections = function(l_51_0, l_51_1)
	if l_51_0._virtual_controller then
		l_51_0._virtual_controller:clear_connections()
	end
	if not l_51_1 then
		l_51_0._connection_map = {}
		l_51_0._delay_map = {}
		l_51_0._delay_bool_map = {}
		l_51_0._multi_input_map = {}
	end
end

CoreControllerWrapper.get_any_input = function(l_52_0)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_52_0._enabled and l_52_0._virtual_controller and #l_52_0._virtual_controller:down_list() <= 0 then
		l_52_0._input_any_cache = l_52_0._input_any_cache ~= nil
		l_52_0._input_any_cache = not not l_52_0._input_any_cache
		return l_52_0._input_any_cache
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 17 
end

CoreControllerWrapper.get_any_input_pressed = function(l_53_0)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_53_0._enabled and l_53_0._virtual_controller and #l_53_0._virtual_controller:pressed_list() <= 0 then
		l_53_0._input_any_pressed_cache = l_53_0._input_any_pressed_cache ~= nil
		l_53_0._input_any_pressed_cache = not not l_53_0._input_any_pressed_cache
		return l_53_0._input_any_pressed_cache
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 17 
end

CoreControllerWrapper.get_any_input_released = function(l_54_0)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_54_0._enabled and l_54_0._virtual_controller and #l_54_0._virtual_controller:released_list() <= 0 then
		l_54_0._input_any_released_cache = l_54_0._input_any_released_cache ~= nil
		l_54_0._input_any_released_cache = not not l_54_0._input_any_released_cache
		return l_54_0._input_any_released_cache
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 17 
end

CoreControllerWrapper.get_input_pressed = function(l_55_0, l_55_1)
	if l_55_0._connection_map[l_55_1] then
		if not l_55_0._enabled or not l_55_0._virtual_controller or not l_55_0:get_connection_enabled(l_55_1) or not l_55_0._virtual_controller:pressed(l_55_1) then
			local l_55_4 = not not (l_55_0._input_pressed_cache[l_55_1] ~= nil or false)
		else
			Application:error(l_55_0:to_string() .. " No controller input binded to connection \"" .. tostring(l_55_1) .. "\".")
			local l_55_5, l_55_6 = false
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_55_0._input_pressed_cache[l_55_1] = l_55_5
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_55_5
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 27 
end

CoreControllerWrapper.get_input_bool = function(l_56_0, l_56_1)
	if l_56_0._connection_map[l_56_1] then
		if not l_56_0._enabled or not l_56_0._virtual_controller or not l_56_0:get_connection_enabled(l_56_1) or not l_56_0._virtual_controller:down(l_56_1) then
			local l_56_4 = not not (l_56_0._input_bool_cache[l_56_1] ~= nil or false)
		else
			Application:error(l_56_0:to_string() .. " No controller input binded to connection \"" .. tostring(l_56_1) .. "\".")
			local l_56_5, l_56_6 = false
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_56_0._input_bool_cache[l_56_1] = l_56_5
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_56_5
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 27 
end

CoreControllerWrapper.get_input_float = function(l_57_0, l_57_1)
	if l_57_0._connection_map[l_57_1] and (not l_57_0._enabled or not l_57_0._virtual_controller or not l_57_0:get_connection_enabled(l_57_1) or not l_57_0._virtual_controller:button(l_57_1)) then
		do return end
		Application:error(l_57_0:to_string() .. " No controller input binded to connection \"" .. tostring(l_57_1) .. "\".")
		 -- DECOMPILER ERROR: Overwrote pending register.

		do
			local l_57_4, l_57_5 = l_57_0._input_float_cache[l_57_1] ~= nil or 0
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_57_0._input_float_cache[l_57_1] = l_57_4
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_57_4
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 27 
end

CoreControllerWrapper.get_input_axis = function(l_58_0, l_58_1)
	do
		if l_58_0._input_axis_cache[l_58_1] == nil then
			if l_58_0._connection_map[l_58_1] then
				if not l_58_0._enabled or not l_58_0._virtual_controller or not l_58_0:get_connection_enabled(l_58_1) or l_58_0._virtual_controller:axis(l_58_1) then
					local l_58_3 = nil
					l_58_3 = l_58_0:get_modified_axis(l_58_1, l_58_0._setup:get_connection(l_58_1), l_58_3)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			Application:error(l_58_0:to_string() .. " No controller input binded to connection \"" .. tostring(l_58_1) .. "\".")
			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_58_5, l_58_6 = nil
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_58_5._input_axis_cache[l_58_6] = Vector3()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return Vector3()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapper.get_modified_axis = function(l_59_0, l_59_1, l_59_2, l_59_3)
	if l_59_2.get_multiplier then
		local l_59_4, l_59_5, l_59_6, l_59_7, l_59_9, l_59_11, l_59_13 = l_59_2:get_multiplier()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_59_4 then
		l_59_3 = Vector3(l_59_3.x * l_59_4.x, l_59_3.y * l_59_4.y, l_59_3.z * l_59_4.z)
	end
	if l_59_2.get_inversion then
		local l_59_8, l_59_10, l_59_12, l_59_14 = , l_59_2:get_inversion()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_59_10 then
		l_59_3 = Vector3(l_59_3.x * l_59_10.x, l_59_3.y * l_59_10.y, l_59_3.z * l_59_10.z)
	end
	local l_59_15 = nil
	local l_59_16 = nil
	local l_59_17 = l_59_0:rescale_x_axis(l_59_1, l_59_2, l_59_3.x)
	local l_59_18, l_59_19 = l_59_0:rescale_y_axis(l_59_1, l_59_2, l_59_3.y), l_59_0:rescale_z_axis(l_59_1, l_59_2, l_59_3.z)
	local l_59_20 = l_59_0:lerp_axis
	local l_59_21 = l_59_0
	local l_59_22, l_59_23, l_59_24, l_59_25 = l_59_1, l_59_2, Vector3(l_59_17, l_59_18, l_59_19), .end
	return l_59_20(l_59_21, l_59_22, l_59_23, l_59_24, l_59_25)
end

CoreControllerWrapper.lerp_axis = function(l_60_0, l_60_1, l_60_2, l_60_3)
	if l_60_2.get_lerp then
		local l_60_4 = l_60_2:get_lerp()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_60_4 then
		local l_60_5 = nil
		l_60_3 = math.lerp(l_60_0._current_lerp_axis_map[l_60_1], l_60_3, l_60_5)
		l_60_0._current_lerp_axis_map[l_60_1] = l_60_3
	end
	return l_60_3
end

CoreControllerWrapper.rescale_x_axis = function(l_61_0, l_61_1, l_61_2, l_61_3)
	local l_61_4, l_61_5 = l_61_0:rescale_axis_component, l_61_0
	local l_61_6 = l_61_1
	local l_61_7 = l_61_2
	local l_61_8 = l_61_3
	return l_61_4(l_61_5, l_61_6, l_61_7, l_61_8)
end

CoreControllerWrapper.rescale_y_axis = function(l_62_0, l_62_1, l_62_2, l_62_3)
	local l_62_4, l_62_5 = l_62_0:rescale_axis_component, l_62_0
	local l_62_6 = l_62_1
	local l_62_7 = l_62_2
	local l_62_8 = l_62_3
	return l_62_4(l_62_5, l_62_6, l_62_7, l_62_8)
end

CoreControllerWrapper.rescale_z_axis = function(l_63_0, l_63_1, l_63_2, l_63_3)
	local l_63_4, l_63_5 = l_63_0:rescale_axis_component, l_63_0
	local l_63_6 = l_63_1
	local l_63_7 = l_63_2
	local l_63_8 = l_63_3
	return l_63_4(l_63_5, l_63_6, l_63_7, l_63_8)
end

CoreControllerWrapper.rescale_axis_component = function(l_64_0, l_64_1, l_64_2, l_64_3)
	return l_64_3
end

CoreControllerWrapper.set_connection_enabled = function(l_65_0, l_65_1, l_65_2)
	local l_65_11, l_65_12, l_65_13, l_65_14, l_65_15, l_65_16, l_65_17, l_65_18, l_65_19, l_65_20, l_65_21, l_65_22, l_65_23, l_65_24, l_65_28, l_65_29, l_65_30, l_65_31, l_65_32, l_65_33, l_65_34, l_65_35, l_65_36, l_65_37, l_65_38, l_65_39, l_65_40, l_65_41, l_65_46, l_65_47, l_65_52, l_65_53, l_65_54, l_65_55, l_65_56, l_65_57, l_65_58, l_65_59, l_65_60, l_65_61, l_65_62, l_65_63, l_65_64, l_65_65, l_65_70, l_65_72, l_65_74, l_65_76, l_65_78, l_65_80, l_65_82 = nil
	if l_65_0._connection_map[l_65_1] then
		local l_65_3, l_65_4, l_65_5, l_65_6, l_65_84 = l_65_0._setup:get_connection(l_65_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_65_3 and not l_65_3:get_enabled() ~= not l_65_2 then
		l_65_3:set_enabled(l_65_2)
		local l_65_7 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_65_0._trigger_map[l_65_1] then
			for i_0,i_1 in pairs(l_65_0._trigger_map[l_65_1]) do
				local l_65_8 = nil
				if l_65_2 and not i_1.id then
					i_1.id = l_65_0._virtual_controller:add_trigger(l_65_1, i_1.func)
				end
				for i_0,i_1 in l_65_9 do
					if i_1.id then
						l_65_0._virtual_controller:remove_trigger(i_1.id)
						i_1.id = nil
					end
				end
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_65_0._release_trigger_map[l_65_1] then
				for i_0,i_1 in pairs(l_65_0._release_trigger_map[l_65_1]) do
					local l_65_25 = nil
					if l_65_2 and not i_1.id then
						i_1.id = l_65_0._virtual_controller:add_release_trigger(l_65_1, i_1.func)
					end
					for i_0,i_1 in l_65_26 do
						if i_1.id then
							l_65_0._virtual_controller:remove_trigger(i_1.id)
							i_1.id = nil
						end
					end
				end
				if not l_65_2 then
					l_65_0._delay_trigger_queue[l_65_1] = nil
				end
				local l_65_42 = nil
			if l_65_0._delay_map[l_65_1] then
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				for i_0 in pairs(l_65_0._delay_map[l_65_1].delay_time_map) do
					local l_65_43 = nil
					 -- DECOMPILER ERROR: Confused about usage of registers!

					if l_65_0._trigger_map[i_0] then
						for i_0,i_1 in pairs(l_65_0._trigger_map[i_0]) do
							local l_65_50 = nil
							i_1.func = l_65_0:get_trigger_func(l_65_49, i_1.original_func)
							if i_1.id then
								l_65_0._virtual_controller:remove_trigger(i_1.id)
								local l_65_79, l_65_81, l_65_83 = l_65_0._virtual_controller:add_trigger(l_65_49, i_1.func)
								l_65_77.id = l_65_79
							end
						end
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					local l_65_66 = nil
					 -- DECOMPILER ERROR: Confused about usage of registers!

					if l_65_0._release_trigger_map[l_65_49] then
						for i_0,i_1 in pairs(l_65_0._release_trigger_map[l_65_49]) do
							local l_65_67, l_65_68 = nil
							i_1.func = l_65_0:get_trigger_func(l_65_66, i_1.original_func)
							if i_1.id then
								l_65_0._virtual_controller:remove_trigger(i_1.id)
								i_1.id = l_65_0._virtual_controller:add_release_trigger(l_65_66, i_1.func)
							end
						end
					end
				end
				l_65_0:update_delay_trigger_queue()
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			do return end
			l_65_42 = Application
			l_65_42, l_65_43 = l_65_42:error, l_65_42
			l_65_42(l_65_43, l_65_0:to_string() .. " Controller can't enable connection \"" .. tostring(l_65_1) .. "\" because it doesn't exist.")
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreControllerWrapper.get_connection_enabled = function(l_66_0, l_66_1)
	if l_66_0._connection_map[l_66_1] then
		local l_66_2 = l_66_0._setup:get_connection(l_66_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_66_2 then
			return l_66_2:get_enabled()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapper.to_string = function(l_67_0)
	local l_67_1, l_67_2 = l_67_0:__tostring, l_67_0
	return l_67_1(l_67_2)
end

CoreControllerWrapper.__tostring = function(l_68_0)
	local l_68_1 = string.format
	local l_68_2 = "[Controller][Wrapper][ID: %s, Type: %s, Name: %s, Enabled: %s, Debug: %s]"
	local l_68_3 = tostring(l_68_0._id)
	local l_68_4 = tostring(l_68_0:get_type())
	local l_68_5 = tostring(l_68_0._name or "N/A")
	local l_68_6 = tostring(l_68_0._enabled and "Yes" or "No")
	local l_68_7, l_68_8 = tostring(l_68_0._debug and "Yes" or "No"), .end
	return l_68_1(l_68_2, l_68_3, l_68_4, l_68_5, l_68_6, l_68_7, l_68_8)
end


