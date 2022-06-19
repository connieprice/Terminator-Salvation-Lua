require("core/utils/dev/CoreLinkedStackMap")
if not CoreListenerManager then
	CoreListenerManager = class()
end
CoreListenerManager.init = function(l_1_0)
	l_1_0._set_map = {}
	l_1_0._category_map = {}
	l_1_0._listener_map = {}
	l_1_0._active_category_map = {}
	l_1_0._active_set_count_map = {}
	l_1_0._active_set_stack_map = {}
	l_1_0._activation_map = {}
	l_1_0._stack_activation_map = {}
	l_1_0._set_activation_map = {}
	l_1_0._last_activation_id = 0
	l_1_0._enabled = true
	l_1_0:add_stack("main")
end

CoreListenerManager.get_closest_listener_position = function(l_2_0, l_2_1)
	local l_2_2, l_2_3 = nil, nil
	l_2_0:callback_on_all_active_listeners(function(l_3_0)
		-- upvalues: l_2_1 , l_2_3 , l_2_2
		local l_3_1 = Sound:listener(l_3_0)
		if alive(l_3_1) then
			local l_3_2 = l_3_1:position()
			local l_3_3 = l_3_2 - l_2_1:length()
		if not l_2_3 or l_3_3 < l_2_3 then
			end
			l_2_2 = l_3_2
			l_2_3 = l_3_3
		end
  end)
	return l_2_2, l_2_3
end

CoreListenerManager.set_enabled = function(l_3_0, l_3_1)
	l_3_1 = not not l_3_1
	if l_3_0._enabled ~= l_3_1 then
		l_3_0:callback_on_all_active_listeners(function(l_4_0)
		-- upvalues: l_3_1
		Sound:set_listener_enabled(l_4_0, l_3_1)
  end)
		l_3_0._enabled = l_3_1
	end
end

CoreListenerManager.callback_on_all_active_listeners = function(l_4_0, l_4_1)
	local l_4_7, l_4_8, l_4_9, l_4_10, l_4_15, l_4_16, l_4_17, l_4_18, l_4_19, l_4_23, l_4_24, l_4_25 = nil
	local l_4_2 = {}
	do
		local l_4_3 = {}
		for i_0,i_1 in pairs(l_4_0._active_set_stack_map) do
			if i_1:top() and not l_4_2[i_1:top()] then
				for i_0,i_1 in pairs(l_4_0._set_map[i_1:top()]) do
					local l_4_13 = nil
					if not l_4_3[i_0] then
						for i_0,i_1 in pairs(i_1) do
							l_4_1(i_0)
						end
						l_4_3[l_4_22] = true
					end
				end
				l_4_2[l_4_13] = true
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreListenerManager.has_stack = function(l_5_0, l_5_1)
	return l_5_0._active_set_stack_map[l_5_1] ~= nil
end

CoreListenerManager.has_set = function(l_6_0, l_6_1)
	return l_6_0._set_map[l_6_1] ~= nil
end

CoreListenerManager.has_category = function(l_7_0, l_7_1)
	return l_7_0._category_map[l_7_1] ~= nil
end

CoreListenerManager.add_stack = function(l_8_0, l_8_1)
	if not l_8_0._active_set_stack_map[l_8_1] then
		l_8_0._active_set_stack_map[l_8_1] = CoreLinkedStackMap:new()
		l_8_0._stack_activation_map[l_8_1] = {}
	else
		Application:stack_dump_error("Stack id \"" .. tostring(l_8_1) .. "\" already exists.")
	end
end

CoreListenerManager.remove_stack = function(l_9_0, l_9_1)
	local l_9_6, l_9_7 = nil
	local l_9_2 = l_9_0._active_set_stack_map[l_9_1]
	if l_9_2 then
		l_9_0._active_set_stack_map[l_9_1] = nil
		for i_0 in pairs(l_9_0._stack_activation_map[l_9_1]) do
			l_9_0:deactivate_set(i_0)
		end
		l_9_0._stack_activation_map[l_9_1] = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		Application:stack_dump_error("Stack id \"" .. tostring(l_9_1) .. "\" doesn't exists.")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreListenerManager.add_set = function(l_10_0, l_10_1, l_10_2)
	local l_10_6, l_10_7, l_10_8, l_10_9 = nil
	if not l_10_0._set_map[l_10_1] then
		l_10_0._set_map[l_10_1] = {}
		l_10_0._set_activation_map[l_10_1] = {}
		if l_10_2 then
			for i_0,i_1 in ipairs(l_10_2) do
				l_10_0:add_set_category(l_10_1, i_1)
			end
		end
	else
		Application:stack_dump_error("Unable to add an already set id \"" .. tostring(l_10_1) .. "\"")
	end
end

CoreListenerManager.remove_set = function(l_11_0, l_11_1)
	local l_11_6, l_11_7, l_11_8, l_11_9 = nil
	local l_11_2 = l_11_0._set_map[l_11_1]
	if l_11_2 then
		for i_0 in pairs(l_11_2) do
			l_11_0:remove_set_category(l_11_1, i_0)
		end
		for i_0 in pairs(l_11_0._set_activation_map[l_11_1]) do
			l_11_0:deactivate_set(i_0)
		end
		l_11_0._set_map[l_11_1] = nil
		l_11_0._set_activation_map[l_11_1] = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		Application:stack_dump_error("Unable to remove non-existing set id \"" .. tostring(l_11_1) .. "\"")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreListenerManager.add_set_category = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = l_12_0._set_map[l_12_1]
	if l_12_3 then
		if not l_12_0._category_map[l_12_2] then
			local l_12_4, l_12_5 = {}
			l_12_5 = l_12_0._category_map
			l_12_5[l_12_2] = l_12_4
			l_12_5 = l_12_0._active_category_map
			l_12_5[l_12_2] = false
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_12_3[l_12_2] = l_12_4
	else
		Application:stack_dump_error("Unable to add a category id \"" .. tostring(l_12_2) .. "\" on non-existing set id \"" .. tostring(l_12_1) .. "\"")
	end
end

CoreListenerManager.remove_set_category = function(l_13_0, l_13_1, l_13_2)
	local l_13_3 = l_13_0._set_map[l_13_1]
	if l_13_3 then
		if l_13_3[l_13_2] then
			l_13_3[l_13_2] = nil
		else
			Application:stack_dump_error("Unable to remove non-existing category id \"" .. tostring(l_13_2) .. "\" on set id \"" .. tostring(l_13_1) .. "\"")
		end
	else
		Application:stack_dump_error("Unable to remove a category id \"" .. tostring(l_13_2) .. "\" on non-existing set id \"" .. tostring(l_13_1) .. "\"")
	end
end

CoreListenerManager.add_category = function(l_14_0, l_14_1)
	if not l_14_0._category_map[l_14_1] then
		l_14_0._category_map[l_14_1] = {}
		l_14_0._active_category_map[l_14_1] = false
	else
		Application:stack_dump_error("Unable to add already existing category id \"" .. tostring(l_14_1) .. "\"")
	end
end

CoreListenerManager.remove_category = function(l_15_0, l_15_1)
	local l_15_5, l_15_6, l_15_7, l_15_8, l_15_9 = nil
	if l_15_0._category_map[l_15_1] then
		for i_0,i_1 in pairs(l_15_0._set_map) do
			if i_1[l_15_1] then
				l_15_0:remove_set_category(i_0, l_15_1)
			end
		end
		l_15_0._category_map[l_15_1] = nil
		l_15_0._active_category_map[l_15_1] = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		Application:stack_dump_error("Unable to remove non-existing category id \"" .. tostring(l_15_1) .. "\"")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreListenerManager.add_listener = function(l_16_0, l_16_1, l_16_2, l_16_3, l_16_4, l_16_5)
	if not l_16_0._category_map[l_16_1] then
		l_16_0:add_category(l_16_1)
	end
	local l_16_6 = l_16_0._category_map[l_16_1]
	local l_16_7 = Sound:add_listener(l_16_2, l_16_3, l_16_4)
	local l_16_8 = {}
	l_16_8.category_id = l_16_1
	l_16_8.enabled = not l_16_5
	l_16_0._listener_map[l_16_7] = l_16_8
	l_16_6[l_16_7] = l_16_8
	if not l_16_0._enabled or l_16_5 or not l_16_0._active_category_map[l_16_1] then
		Sound:set_listener_enabled(l_16_7, false)
	end
	return l_16_7
end

CoreListenerManager.remove_listener = function(l_17_0, l_17_1)
	local l_17_2 = l_17_0._listener_map[l_17_1]
	if l_17_2 then
		local l_17_3 = l_17_2.category_id
		local l_17_4 = l_17_0._category_map[l_17_3]
		if l_17_4 then
			if l_17_4[l_17_1] then
				Sound:remove_listener(l_17_1)
				l_17_4[l_17_1] = nil
				l_17_0._listener_map[l_17_1] = nil
			else
				Application:stack_dump_error("Unable to remove non-existing listener id \"" .. tostring(l_17_1) .. "\" in category id \"" .. tostring(l_17_3) .. "\".")
			end
		else
			Application:stack_dump_error("Unable to remove listener id \"" .. tostring(l_17_1) .. "\" in non-existing category id \"" .. tostring(l_17_3) .. "\".")
		end
	else
		Application:stack_dump_error("Unable to remove non-existing listener id \"" .. tostring(l_17_1) .. "\".")
	end
end

CoreListenerManager.set_listener = function(l_18_0, l_18_1, l_18_2, l_18_3, l_18_4)
	local l_18_5 = l_18_0._listener_map[l_18_1]
	if l_18_5 then
		local l_18_6 = l_18_5.category_id
		local l_18_7 = l_18_0._category_map[l_18_6]
		if l_18_7 then
			if l_18_7[l_18_1] then
				Sound:set_listener(l_18_1, l_18_2, l_18_3, l_18_4)
			else
				Application:stack_dump_error("Unable to set non-existing listener id \"" .. tostring(l_18_1) .. "\" in category id \"" .. tostring(l_18_6) .. "\".")
			end
		else
			Application:stack_dump_error("Unable to set listener id \"" .. tostring(l_18_1) .. "\" in non-existing category id \"" .. tostring(l_18_6) .. "\".")
		end
	else
		Application:stack_dump_error("Unable to set non-existing listener id \"" .. tostring(l_18_1) .. "\".")
	end
end

CoreListenerManager.set_listener_enabled = function(l_19_0, l_19_1, l_19_2)
	local l_19_3 = l_19_0._listener_map[l_19_1]
	if l_19_3 then
		l_19_3.enabled = l_19_2
		if l_19_0._enabled then
			Sound:set_listener_enabled(l_19_1, not l_19_0._active_category_map[l_19_3.category_id] or l_19_2)
	else
		end
	end
	Application:stack_dump_error("Unable to set non-existing listener id \"" .. tostring(l_19_1) .. "\".")
end

CoreListenerManager.get_listener_enabled = function(l_20_0, l_20_1)
	local l_20_2 = l_20_0._listener_map[l_20_1]
	if l_20_2 then
		return l_20_2.enabled
	else
		Application:stack_dump_error("Unable to get non-existing listener id \"" .. tostring(l_20_1) .. "\".")
		return nil
	end
end

CoreListenerManager.activate_set = function(l_21_0, l_21_1, l_21_2)
	local l_21_3 = l_21_0._active_set_stack_map[l_21_1]
	if l_21_3 then
		if l_21_0._set_map[l_21_2] then
			local l_21_4 = l_21_3:top()
			if l_21_4 ~= l_21_2 then
				if l_21_4 and l_21_0._active_set_count_map[l_21_4] == 1 then
					l_21_0:_deactivate_set(l_21_4)
				end
				l_21_0:_activate_set(l_21_2)
			end
			local l_21_5 = l_21_3:add(l_21_2)
			local l_21_6 = l_21_0._last_activation_id + 1
			local l_21_7 = l_21_0._activation_map
			local l_21_8 = {}
			l_21_8.stack_id = l_21_1
			l_21_8.set_id = l_21_2
			l_21_8.link_id = l_21_5
			l_21_7[l_21_6] = l_21_8
			l_21_7 = l_21_0._stack_activation_map
			l_21_7 = l_21_7[l_21_1]
			l_21_7[l_21_6] = true
			l_21_7 = l_21_0._set_activation_map
			l_21_7 = l_21_7[l_21_2]
			l_21_7[l_21_6] = true
			l_21_0._last_activation_id = l_21_6
			return l_21_6
		else
			Application:stack_dump_error("Unable to activate non-existing set id \"" .. tostring(l_21_2) .. "\" on stack id \"" .. l_21_1 .. "\".")
		end
	else
		Application:stack_dump_error("Unable to activate set id \"" .. tostring(l_21_2) .. "\" on non-existing stack id \"" .. l_21_1 .. "\".")
	end
	return -1
end

CoreListenerManager.deactivate_set = function(l_22_0, l_22_1)
	local l_22_2 = l_22_0._activation_map[l_22_1]
	if l_22_2 then
		local l_22_3 = l_22_2.stack_id
		local l_22_4 = l_22_2.set_id
		local l_22_5 = l_22_0._active_set_stack_map[l_22_3]
		local l_22_6 = l_22_5:top()
		l_22_5:remove(l_22_2.link_id)
		local l_22_7 = l_22_5:top()
		if l_22_4 == l_22_6 and l_22_4 ~= l_22_7 then
			if l_22_7 and not l_22_0._active_set_count_map[l_22_7] then
				l_22_0:_activate_set(l_22_7)
			end
			l_22_0:_deactivate_set(l_22_4)
		end
		l_22_0._activation_map[l_22_1] = nil
		l_22_0._stack_activation_map[l_22_3][l_22_1] = nil
		l_22_0._set_activation_map[l_22_4][l_22_1] = nil
	else
		Application:stack_dump_error("Unable to deactivate non-existing activation id \"" .. tostring(l_22_1) .. "\".")
	end
end

CoreListenerManager._activate_set = function(l_23_0, l_23_1)
	local l_23_2 = l_23_0._active_set_count_map[l_23_1]
	if not l_23_2 then
		l_23_0:_set_listener_set_active(l_23_1, true)
	end
	if not l_23_2 then
		l_23_2 = 0
	end
	l_23_0._active_set_count_map[l_23_1] = l_23_2 + 1
end

CoreListenerManager._deactivate_set = function(l_24_0, l_24_1)
	if l_24_0._active_set_count_map[l_24_1] - 1 <= 0 then
		local l_24_2, l_24_3 = nil
		l_24_3(l_24_0, l_24_1, false)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_24_3[l_24_1] = l_24_2
end

CoreListenerManager._set_listener_set_active = function(l_25_0, l_25_1, l_25_2)
	local l_25_6, l_25_7, l_25_8, l_25_9, l_25_10, l_25_11, l_25_15, l_25_16, l_25_17, l_25_18, l_25_19 = nil
	for i_0,i_1 in pairs(l_25_0._set_map[l_25_1]) do
		l_25_0._active_category_map[i_0] = l_25_2
		for i_0,i_1 in pairs(i_1) do
			Sound:set_listener_enabled(i_0, not l_25_0._enabled or not i_1.enabled or l_25_2)
		end
	end
end

CoreListenerManager.debug_print = function(l_26_0)
	local l_26_4, l_26_5, l_26_6, l_26_7, l_26_8 = nil
	for i_0,i_1 in pairs(l_26_0._active_set_stack_map) do
		cat_debug("debug", tostring(i_0) .. ": " .. tostring(i_1:to_string()))
	end
end


