if not CoreGenericStateManager then
	CoreGenericStateManager = class()
end
CoreGenericStateManager.init = function(l_1_0, l_1_1)
	local l_1_6, l_1_7, l_1_8, l_1_9 = nil
	l_1_0._states = {}
	l_1_0._slave_states = {}
	l_1_0._instances = {}
	l_1_0._updating_instances = {}
	l_1_0._paused_updating_instances = {}
	l_1_0._state_order = {}
	if l_1_1 then
		l_1_0._name = l_1_1
		local l_1_2 = File:parse_xml(l_1_1)
		for i_0 in l_1_2:children() do
			i_0:for_each("state", callback(l_1_0, l_1_0, "parse_state"))
			i_0:for_each("instance", callback(l_1_0, l_1_0, "parse_instance"))
		end
	else
		l_1_0._name = "UNINITIALIZED"
	end
end

CoreGenericStateManager.destroy = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0._instances) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if i_1.instance.destroy then
			i_1.instance:destroy()
		end
		i_1.instance = nil
	end
end

CoreGenericStateManager.set_slave = function(l_3_0, l_3_1)
	l_3_0._slave = l_3_1
end

CoreGenericStateManager.get_name = function(l_4_0)
	return l_4_0._name .. " state manager"
end

CoreGenericStateManager.save = function(l_5_0, l_5_1)
	l_5_1:save("state_manager_" .. l_5_0._name, l_5_0:current())
end

CoreGenericStateManager.load = function(l_6_0, l_6_1)
	l_6_0:clear()
	local l_6_2 = l_6_1:load("state_manager_" .. l_6_0._name)
	if l_6_2 then
		l_6_0:goto(l_6_2)
	end
end

CoreGenericStateManager.exceptional_case_that_allows_me_to_lock = function(l_7_0)
	cat_debug("goblin", "GenericStateManager::exceptional_case_that_allows_me_to_lock() someone has LOCKED " .. l_7_0:get_name() .. " so be extra careful")
	l_7_0._locked = true
end

CoreGenericStateManager.unlock_the_exceptional_case = function(l_8_0)
	if l_8_0._locked then
		cat_debug("goblin", "GenericStateManager::unlock_the_exceptional_case() now everything is back to normal without any lock in " .. l_8_0:get_name())
		l_8_0._locked = false
	end
end

CoreGenericStateManager.parse_state = function(l_9_0, l_9_1)
	local l_9_7, l_9_8, l_9_9, l_9_11, l_9_12, l_9_13, l_9_14 = nil
	local l_9_2 = l_9_1:parameter("name")
	local l_9_3 = {}
	for i_0 in l_9_1:children() do
		if i_0:name() == "on" and i_0:parameter("goto") and not table.contains(l_9_3, i_0:parameter("goto")) then
			table.insert(l_9_3, i_0:parameter("goto"))
		end
		for i_0 in l_9_4 do
			if i_0:name() == "param" and i_0:parameter("name") == "slave_state" and i_0:parameter("value") then
				l_9_0._slave_states[l_9_2] = i_0:parameter("value")
			end
		end
		l_9_0._states[l_9_2] = l_9_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreGenericStateManager.parse_instance = function(l_10_0, l_10_1)
	local l_10_7, l_10_8, l_10_9, l_10_10 = nil
	local l_10_2 = l_10_1:parameter("name")
	local l_10_3 = {}
	for i_0 in l_10_1:children() do
		if i_0:name() == "param" and i_0:parameter("value") ~= "" then
			l_10_3[l_10_11:parameter("name")] = i_0:parameter("value")
		end
	end
	if not l_10_3.address then
		Application:throw_exception("Could not find 'address' parameter in '" .. l_10_1:parameter("name") .. "'.")
	end
	l_10_0._instances[l_10_2] = l_10_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreGenericStateManager.goto = function(l_11_0, l_11_1)
	local l_11_6, l_11_7, l_11_8, l_11_9, l_11_12, l_11_14, l_11_16, l_11_18, l_11_20, l_11_23, l_11_25 = nil
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_11_0._states[l_11_1] and l_11_1 ~= l_11_0:current() then
		if not l_11_0._locked then
			local l_11_2 = l_11_0._states[l_11_1]
			l_11_0._updating_instances = {}
			l_11_0._paused_updating_instances = {}
			for i_0,i_1 in ipairs(l_11_2) do
				local l_11_15, l_11_17, l_11_19, l_11_21 = l_11_0._instances[i_1]
				if l_11_15 then
					l_11_17 = l_11_15.update
					if l_11_17 then
						l_11_17 = table
						l_11_17 = l_11_17.insert
						l_11_19 = l_11_0._updating_instances
						l_11_21 = l_11_15
						l_11_17(l_11_19, l_11_21)
					end
					l_11_17 = l_11_15.paused_update
					if l_11_17 then
						l_11_17 = table
						l_11_17 = l_11_17.insert
						l_11_19 = l_11_0._paused_updating_instances
						l_11_21 = l_11_15
						l_11_17(l_11_19, l_11_21)
					end
				else
					l_11_17 = Application
					l_11_17, l_11_19 = l_11_17:throw_exception, l_11_17
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_11_17(l_11_19, l_11_21)
				end
			end
			if #l_11_0._state_order > 0 then
				for i_0,i_1 in ipairs(l_11_0._states[l_11_0._state_order[1]]) do
					 -- DECOMPILER ERROR: Overwrote pending register.

					if table.contains(l_11_2, l_11_21) then
						table.delete(l_11_2, l_11_24)
					else
						l_11_0:deactivate(l_11_0._instances[l_11_24])
					end
				end
			end
			for i_0,i_1 in ipairs(l_11_2) do
				l_11_0:activate(l_11_0._instances[i_1])
			end
			if table.contains(l_11_0._state_order, l_11_1) then
				l_11_0._delete_state_name = l_11_1
				l_11_0:delete_state_from_state_order(l_11_0._state_order)
			end
			table.insert(l_11_0._state_order, 1, l_11_1)
		if l_11_0._slave then
			end
		if l_11_0._slave_states[l_11_1] then
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if not l_11_0._slave._states[l_11_0._slave_states[l_11_1]] then
				Application:throw_exception(l_11_0:get_name() .. " - Trying to set slave state, but slave manager (" .. l_11_0._slave.get_name() .. ") does not contain the state " .. l_11_0._slave_states[l_11_1])
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_11_0._slave:goto(l_11_0._slave_states[l_11_1])
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_11_2 = current
		l_11_2 = l_11_2()
		local l_11_26 = nil
	if l_11_2 then
		end
		l_11_0._delete_state_name = l_11_2
		l_11_0:delete_state_from_state_order(l_11_26)
		l_11_0._delete_state_name = l_11_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_11_0:delete_state_from_state_order(l_11_26)
		 -- DECOMPILER ERROR: Overwrote pending register.

		table.insert(l_11_0._state_order, l_11_26, l_11_1)
		 -- DECOMPILER ERROR: Overwrote pending register.

		table.insert(l_11_0._state_order, l_11_26, l_11_2)
	end
	do return end
	l_11_2 = Application
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_11_2(l_11_2, get_name() .. l_11_26 .. l_11_1 .. " exists")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreGenericStateManager.goto_previous = function(l_12_0)
	l_12_0:remove(l_12_0:current())
end

CoreGenericStateManager.toggle = function(l_13_0, l_13_1)
	if l_13_0:current() ~= l_13_1 then
		l_13_0:goto(l_13_1)
		return true
	else
		l_13_0:remove(l_13_1)
	end
	return false
end

CoreGenericStateManager.clear = function(l_14_0)
	local l_14_6, l_14_7, l_14_8, l_14_9 = nil
	local l_14_1 = l_14_0:current()
	if l_14_1 then
		local l_14_2 = l_14_0._states[l_14_1]
		for i_0,i_1 in ipairs(l_14_2) do
			l_14_0:deactivate(l_14_0._instances[i_1])
		end
		l_14_0._updating_instances = nil
		l_14_0._paused_updating_instances = nil
		l_14_0._state_order = {}
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreGenericStateManager.debug_print_state_order = function(l_15_0)
	local l_15_1 = l_15_0._state_order
	cat_debug("debug", l_15_0:get_name() .. ": GOTO Order/History:")
	while #l_15_1 > 0 do
		cat_debug("debug", l_15_0:get_name() .. ": " .. l_15_1[1])
		table.remove(l_15_1, 1)
	end
end

CoreGenericStateManager.remove = function(l_16_0, l_16_1)
	local l_16_2 = l_16_0:current()
	if l_16_2 == l_16_1 then
		if not l_16_0._locked then
			if #l_16_0._state_order > 1 then
				l_16_0._delete_state_name = l_16_2
				l_16_0:delete_state_from_state_order(l_16_0._state_order)
				local l_16_3 = l_16_0:current()
				table.insert(l_16_0._state_order, 1, l_16_2)
				l_16_0:goto(l_16_3)
			end
		else
			l_16_0:clear()
		end
	else
		return 
	end
	l_16_0._delete_state_name = l_16_1
	l_16_0:delete_state_from_state_order(l_16_0._state_order)
end

CoreGenericStateManager.delete_state_from_state_order = function(l_17_0, l_17_1)
	local l_17_5, l_17_6, l_17_7, l_17_8, l_17_9 = nil
	for i_0,i_1 in ipairs(l_17_1) do
		if i_1 == l_17_0._delete_state_name then
			table.remove(l_17_1, i_0)
			return 
		end
	end
end

CoreGenericStateManager.get_instance = function(l_18_0, l_18_1)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_18_0._instances[l_18_1] then
		local l_18_2, l_18_3, l_18_4 = l_18_0._instances[l_18_1].instance
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_18_2 then
		Application:throw_exception("Unable to find instance " .. l_18_1 .. " (state=" .. l_18_0:current() .. " name=" .. l_18_0:get_name() .. ")")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_18_2
end

CoreGenericStateManager.current = function(l_19_0)
	return l_19_0._state_order[1]
end

CoreGenericStateManager.activate = function(l_20_0, l_20_1)
	if not l_20_1.instance then
		l_20_0:initiate_instance(l_20_1)
	end
	if l_20_1.activate then
		l_20_1.instance[l_20_0:get_instance_member("activate", l_20_1)](l_20_1.instance)
	end
end

CoreGenericStateManager.deactivate = function(l_21_0, l_21_1)
	if l_21_1.deactivate then
		l_21_1.instance[l_21_0:get_instance_member("deactivate", l_21_1)](l_21_1.instance)
	end
end

CoreGenericStateManager.update = function(l_22_0, l_22_1, l_22_2)
	local l_22_6, l_22_7, l_22_8, l_22_9, l_22_10, l_22_11, l_22_12, l_22_13 = nil
	if l_22_0._updating_instances then
		for i_0,i_1 in ipairs(l_22_0._updating_instances) do
			i_1.instance[l_22_0:get_instance_member("update", i_1)](i_1.instance, l_22_1, l_22_2)
		end
	end
end

CoreGenericStateManager.paused_update = function(l_23_0, l_23_1, l_23_2)
	local l_23_6, l_23_7, l_23_8, l_23_9, l_23_10, l_23_11, l_23_12, l_23_13 = nil
	if l_23_0._paused_updating_instances then
		for i_0,i_1 in ipairs(l_23_0._paused_updating_instances) do
			i_1.instance[l_23_0:get_instance_member("paused_update", i_1)](i_1.instance, l_23_1, l_23_2)
		end
	end
end

CoreGenericStateManager.initiate_instance = function(l_24_0, l_24_1)
	local l_24_2 = nil
	if l_24_1.address then
		l_24_2 = loadstring("return " .. l_24_1.address)
	end
	if l_24_2 then
		l_24_1.instance = l_24_2()
	else
		Application:throw_exception(l_24_0:get_name() .. " - Unable to initiate instance with address " .. l_24_1.address)
	end
end

CoreGenericStateManager.get_instance_member = function(l_25_0, l_25_1, l_25_2)
	local l_25_3 = l_25_2.instance
	if l_25_3 then
		local l_25_4 = l_25_2[l_25_1]
		if l_25_4 then
			return l_25_4
		end
		do return end
		Application:throw_exception(l_25_0:get_instance_info(l_25_2) .. " do not contain param " .. l_25_1)
	else
		Application:throw_exception(l_25_0:get_instance_info(l_25_2) .. " has not been initialized")
	end
end

CoreGenericStateManager.get_instance_info = function(l_26_0, l_26_1)
	return l_26_0:get_name() .. " - Location Instance from address " .. l_26_1.address
end


