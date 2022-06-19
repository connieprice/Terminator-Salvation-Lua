if not CoreControllerWrapperSettings then
	CoreControllerWrapperSettings = class()
end
CoreControllerWrapperSettings.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_7, l_1_8, l_1_9, l_1_14, l_1_15, l_1_16, l_1_17, l_1_23, l_1_24, l_1_25, l_1_26, l_1_32, l_1_33, l_1_34, l_1_35 = nil
	l_1_0._wrapper_type = l_1_1
	l_1_0._connection_map = {}
	l_1_0._editable_connection_map = {}
	l_1_0._unselectable_input_map = {}
	if l_1_2 then
		for i_0 in l_1_2:children() do
			if i_0:name() == "connections" then
				for i_0 in l_1_10:children() do
					local l_1_11 = nil
					if not l_1_0:get_node_parameter(i_0, "name") then
						Application:error(l_1_0:get_origin(l_1_19) .. " controller \"" .. tostring(i_0:name()) .. "\" input had no name attribute.")
					elseif i_0:name() == "button" then
						if l_1_0._connection_map[l_1_0:get_node_parameter(i_0, "name")] then
							Application:error(l_1_0:get_origin(l_1_19) .. " Duplicate controller button connection (name: \"" .. tostring(l_1_0:get_node_parameter(i_0, "name")) .. "\"). Overwriting existing one.")
						end
						l_1_0:set_connection(l_1_0:get_node_parameter(i_0, "name"), get_core_or_local("ControllerWrapperButton"):new(l_1_19))
					elseif i_0:name() == "axis" then
						if l_1_0._connection_map[l_1_0:get_node_parameter(i_0, "name")] then
							Application:error(l_1_0:get_origin(l_1_19) .. " Duplicate controller axis connection (name: \"" .. tostring(l_1_0:get_node_parameter(i_0, "name")) .. "\"). Overwriting existing one.")
						end
						l_1_0:set_connection(l_1_0:get_node_parameter(i_0, "name"), get_core_or_local("ControllerWrapperAxis"):new(l_1_19))
					else
						Application:error(l_1_0:get_origin(l_1_19) .. " Invalid element \"" .. tostring(i_0:name()) .. "\" inside \"connections\" element.")
					end
				end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			elseif l_1_11 == "editable" then
				for i_0 in l_1_10:children() do
					local l_1_20 = nil
					if i_0:name() == "connection" then
						if not l_1_0:get_node_parameter(i_0, "name") then
							Application:error(l_1_0:get_origin(l_1_28) .. " Editable input element had no name attribute.")
						else
							if l_1_0._editable_connection_map[l_1_0:get_node_parameter(i_0, "name")] then
								Application:error(l_1_0:get_origin(l_1_28) .. " Duplicate controller editable connection (name: \"" .. tostring(l_1_0:get_node_parameter(i_0, "name")) .. "\"). Overwriting existing one.")
							end
							l_1_0:set_editable_connection(l_1_0:get_node_parameter(i_0, "name"), get_core_or_local("ControllerWrapperEditable"):new(l_1_28))
						end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					else
						Application:error(l_1_0:get_origin(l_1_28) .. " Invalid element \"" .. tostring(i_0:name()) .. "\" inside \"editable\" element.")
					end
				end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			elseif l_1_20 == "unselectable" then
				for i_0 in l_1_10:children() do
					local l_1_29 = nil
					if i_0:name() == "input" then
						if not l_1_0:get_node_parameter(i_0, "name") then
							Application:error(l_1_0:get_origin(l_1_37) .. " Unselectable input element had no name attribute.")
						else
							if l_1_0._unselectable_input_map[l_1_0:get_node_parameter(i_0, "name")] then
								Application:error(l_1_0:get_origin(l_1_37) .. " Duplicate controller unselectable connection (name: \"" .. tostring(l_1_0:get_node_parameter(i_0, "name")) .. "\"). Overwriting existing one.")
							end
							l_1_0:set_unselectable_input(l_1_0:get_node_parameter(i_0, "name"), get_core_or_local("ControllerWrapperUnselectable"):new(l_1_37))
						end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					else
						Application:error(l_1_0:get_origin(l_1_37) .. " Invalid element \"" .. tostring(i_0:name()) .. "\" inside \"unselectable\" element.")
					end
				end
			else
				Application:error(l_1_0:get_origin(l_1_10) .. " Invalid element \"" .. tostring(name) .. "\" inside \"" .. tostring(l_1_0._wrapper_type) .. "\" element.")
			end
		end
	end
	if l_1_3 then
		l_1_0:merge(l_1_3, false)
	end
	l_1_0:validate()
end

CoreControllerWrapperSettings.merge = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7 = pairs, l_2_1:get_connection_map()
	l_2_6 = l_2_6(l_2_7)
	for i_0,i_1 in l_2_6 do
		do
			if l_2_2 or not l_2_0._connection_map[l_2_4] then
				l_2_0._connection_map[l_2_4] = l_2_5
			end
		end
		for i_0,i_1 in pairs(l_2_1:get_editable_connection_map()) do
			if l_2_2 or not l_2_0._editable_connection_map[i_0] then
				l_2_0._editable_connection_map[i_0] = i_1
			end
		end
		for i_0,i_1 in pairs(l_2_1:get_unselectable_input_map()) do
			if l_2_2 or not l_2_0._unselectable_input_map[i_0] then
				l_2_0._unselectable_input_map[i_0] = i_1
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperSettings.validate = function(l_3_0)
	local l_3_4, l_3_5, l_3_6 = nil
	for i_0,i_1 in pairs(l_3_0._editable_connection_map) do
		if not l_3_0._connection_map[i_0] then
			l_3_0._editable_connection_map[l_3_7] = nil
			local l_3_14 = nil
			do
				local l_3_13, l_3_15 = Application:error, Application
				l_3_13(l_3_15, tostring(i_1) .. " Connection \"" .. tostring(l_3_7) .. "\" that was supposed to be editable did not exist. It is no longer editable.")
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			local l_3_8 = nil
			for i_0,i_1 in ipairs(l_3_14:get_input_name_list()) do
				local l_3_9, l_3_10 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_3_0._unselectable_input_map[i_1] then
					if #l_3_10 > 1 and not l_3_9:get_any_input() then
						do return end
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Overwrote pending register.

				if nil then
					end
					l_3_0._editable_connection_map[l_3_7] = nil
					 -- DECOMPILER ERROR: Confused about usage of registers!

					Application:error(tostring(l_3_0._unselectable_input_map[i_1]) .. " Connection \"" .. tostring(l_3_7) .. "\" was editable but its input \"" .. tostring(i_1) .. "\" is unselectable. It is no longer editable.")
				end
			end
		end
	end
end

CoreControllerWrapperSettings.print_output_to_string = function(l_4_0, l_4_1, l_4_2)
	local l_4_7, l_4_8, l_4_9 = nil
	local l_4_6 = l_4_1
	l_4_1 = l_4_6 .. string.rep("\t", l_4_2) .. "<connections>"
	l_4_6 = pairs
	l_4_6 = l_4_6(l_4_0._connection_map)
	for i_0,i_1 in l_4_6 do
		l_4_1 = i_1:print_output_to_string(l_4_1, l_4_2 + 1)
	end
	l_4_1 = l_4_1 .. string.rep("\t", l_4_2) .. "</connections>"
	l_4_1 = l_4_1 .. string.rep("\t", l_4_2) .. "<editable>"
	for i_0,i_1 in pairs(l_4_0._editable_connection_map) do
		l_4_1 = i_1:print_output_to_string(l_4_1, l_4_2 + 1)
	end
	l_4_1 = l_4_1 .. string.rep("\t", l_4_2) .. "</editable>"
	l_4_1 = l_4_1 .. string.rep("\t", l_4_2) .. "<unselectable>"
	for i_0,i_1 in pairs(l_4_0._unselectable_input_map) do
		l_4_1 = i_1:print_output_to_string(l_4_1, l_4_2 + 1)
	end
	l_4_1 = l_4_1 .. string.rep("\t", l_4_2) .. "</unselectable>"
	return l_4_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperSettings.print_output = function(l_5_0, l_5_1, l_5_2)
	local l_5_7 = l_5_1:puts
	local l_5_6 = l_5_1
	l_5_7(l_5_6, string.rep("\t", l_5_2) .. "<connections>")
	l_5_7 = pairs
	l_5_6 = l_5_0._connection_map
	l_5_7 = l_5_7(l_5_6)
	for i_0,i_1 in l_5_7 do
		l_5_5:print_output(l_5_1, l_5_2 + 1)
	end
	l_5_1:puts(string.rep("\t", l_5_2) .. "</connections>")
	l_5_1:puts(string.rep("\t", l_5_2) .. "<editable>")
	for i_0,i_1 in pairs(l_5_0._editable_connection_map) do
		i_1:print_output(l_5_1, l_5_2 + 1)
	end
	l_5_1:puts(string.rep("\t", l_5_2) .. "</editable>")
	l_5_1:puts(string.rep("\t", l_5_2) .. "<unselectable>")
	for i_0,i_1 in pairs(l_5_0._unselectable_input_map) do
		i_1:print_output(l_5_1, l_5_2 + 1)
	end
	l_5_1:puts(string.rep("\t", l_5_2) .. "</unselectable>")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperSettings.wrapper_type = function(l_6_0)
	return l_6_0._wrapper_type
end

CoreControllerWrapperSettings.get_connection_map = function(l_7_0)
	return l_7_0._connection_map
end

CoreControllerWrapperSettings.get_connection = function(l_8_0, l_8_1)
	return l_8_0._connection_map[l_8_1]
end

CoreControllerWrapperSettings.set_connection = function(l_9_0, l_9_1, l_9_2)
	l_9_0._connection_map[l_9_1] = l_9_2
end

CoreControllerWrapperSettings.get_editable_connection_map = function(l_10_0)
	return l_10_0._editable_connection_map
end

CoreControllerWrapperSettings.get_editable_connection = function(l_11_0, l_11_1)
	return l_11_0._editable_connection_map[l_11_1]
end

CoreControllerWrapperSettings.set_editable_connection = function(l_12_0, l_12_1, l_12_2)
	l_12_0._editable_connection_map[l_12_1] = l_12_2
end

CoreControllerWrapperSettings.get_unselectable_input_map = function(l_13_0)
	return l_13_0._unselectable_input_map
end

CoreControllerWrapperSettings.get_unselectable_input = function(l_14_0, l_14_1)
	return l_14_0._unselectable_input_map[l_14_1]
end

CoreControllerWrapperSettings.set_unselectable_input = function(l_15_0, l_15_1, l_15_2)
	l_15_0._unselectable_input_map[l_15_1] = l_15_2
end

CoreControllerWrapperSettings.get_origin = function(l_16_0, l_16_1)
	if l_16_1 then
		local l_16_2 = string.format
		local l_16_3 = "[File: %s, Line: %s]"
		local l_16_4 = tostring(l_16_0:get_file(l_16_1))
		local l_16_5, l_16_6, l_16_7, l_16_8 = tostring(l_16_0:get_line(l_16_1)), .end
		return l_16_2(l_16_3, l_16_4, l_16_5, l_16_6, l_16_7, l_16_8)
	else
		return "[No xml file]"
	end
end

CoreControllerWrapperSettings.get_file = function(l_17_0, l_17_1)
	return l_17_1 and l_17_1.file and l_17_1:file() or nil
end

CoreControllerWrapperSettings.get_line = function(l_18_0, l_18_1)
	do
		local l_18_2, l_18_3 = l_18_1 and l_18_1.line and l_18_1:line() or nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_18_2 and l_18_2 > 0 and l_18_2 < 10000000 or "<cannot retrieve line nr from a .xmb file>"
end

CoreControllerWrapperSettings.get_node_parameter = function(l_19_0, l_19_1, l_19_2)
	if l_19_1:has_parameter(l_19_2) then
		local l_19_3, l_19_4 = l_19_1:parameter, l_19_1
		local l_19_5 = l_19_2
		return l_19_3(l_19_4, l_19_5)
	else
		return nil
	end
end

if not CoreControllerWrapperConnection then
	CoreControllerWrapperConnection = class()
end
CoreControllerWrapperConnection.TYPE = "generic"
CoreControllerWrapperConnection.DEFAULT_MIN_SRC_RANGE = 0
CoreControllerWrapperConnection.DEFAULT_MAX_SRC_RANGE = 1
CoreControllerWrapperConnection.DEFAULT_MIN_DEST_RANGE = 0
CoreControllerWrapperConnection.DEFAULT_MAX_DEST_RANGE = 1
CoreControllerWrapperConnection.DEFAULT_CONNECT_SRC_TYPE = "button"
CoreControllerWrapperConnection.DEFAULT_CONNECT_DEST_TYPE = "button"
CoreControllerWrapperConnection.init = function(l_20_0, l_20_1)
	if l_20_1 then
		l_20_0._name = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "name")
		local l_20_2 = nil
		local l_20_3 = "input"
		local l_20_4 = 1
		repeat
			l_20_2 = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, l_20_3)
			if l_20_2 then
				if not l_20_0._input_name_list then
					l_20_0._input_name_list = {}
				end
				table.insert(l_20_0._input_name_list, l_20_2)
				l_20_4 = l_20_4 + 1
				l_20_3 = "input" .. l_20_4
			end
		until not l_20_2
		l_20_0._controller_id = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "controller")
		if get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "debug") == "true" then
			l_20_0._debug = true
		end
		if get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "enabled") == "false" then
			l_20_0._disabled = true
		end
		if get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "any_input") == "false" then
			l_20_0._single_input = true
		end
		l_20_0._delay = tonumber(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "delay"))
		l_20_0._min_src_range = tonumber(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "min_src_range"))
		l_20_0._max_src_range = tonumber(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "max_src_range"))
		l_20_0._min_dest_range = tonumber(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "min_dest_range"))
		local l_20_8 = tonumber
		l_20_8 = l_20_8(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_20_1, "max_dest_range"))
		l_20_0._max_dest_range = l_20_8
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_20_8 do
			local l_20_9 = l_20_7:name()
			if l_20_9 == CoreControllerWrapperDelayConnection.TYPE then
				local l_20_10 = get_core_or_local("ControllerWrapperDelayConnection"):new(l_20_7)
				if not l_20_0._delay_connection_list then
					l_20_0._delay_connection_list = {}
				end
				table.insert(l_20_0._delay_connection_list, l_20_10)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapperConnection.set_name = function(l_21_0, l_21_1)
	l_21_0._name = l_21_1
end

CoreControllerWrapperConnection.get_name = function(l_22_0)
	return l_22_0._name
end

CoreControllerWrapperConnection.set_input_name_list = function(l_23_0, l_23_1)
	if l_23_0._input_name_list and next(l_23_0._input_name_list) then
		l_23_0._input_name_list = l_23_1
	else
		l_23_0._input_name_list = nil
	end
end

CoreControllerWrapperConnection.get_input_name_list = function(l_24_0)
	if not l_24_0._input_name_list then
		return {}
	end
end

CoreControllerWrapperConnection.get_controller_id = function(l_25_0)
	return l_25_0._controller_id
end

CoreControllerWrapperConnection.set_controller_id = function(l_26_0, l_26_1)
	l_26_0._controller_id = l_26_1
end

CoreControllerWrapperConnection.set_debug = function(l_27_0, l_27_1)
	if l_27_1 then
		l_27_0._debug = true
	else
		l_27_0._debug = nil
	end
end

CoreControllerWrapperConnection.get_debug = function(l_28_0)
	return l_28_0._debug
end

CoreControllerWrapperConnection.set_enabled = function(l_29_0, l_29_1)
	if not l_29_1 then
		l_29_0._disabled = true
	else
		l_29_0._disabled = nil
	end
end

CoreControllerWrapperConnection.get_enabled = function(l_30_0)
	return not l_30_0._disabled
end

CoreControllerWrapperConnection.set_any_input = function(l_31_0, l_31_1)
	if not l_31_1 then
		l_31_0._single_input = true
	else
		l_31_0._single_input = nil
	end
end

CoreControllerWrapperConnection.get_any_input = function(l_32_0)
	return not l_32_0._single_input
end

CoreControllerWrapperConnection.set_delay = function(l_33_0, l_33_1)
	if l_33_0._delay ~= 0 then
		l_33_0._delay = l_33_1
	else
		l_33_0._delay = nil
	end
end

CoreControllerWrapperConnection.get_delay = function(l_34_0)
	return l_34_0._delay or 0
end

CoreControllerWrapperConnection.set_delay_connection_list = function(l_35_0, l_35_1)
	if l_35_0._delay_connection_list and next(l_35_0._delay_connection_list) then
		l_35_0._delay_connection_list = l_35_1
	else
		l_35_0._delay_connection_list = nil
	end
end

CoreControllerWrapperConnection.get_delay_connection_list = function(l_36_0)
	if not l_36_0._delay_connection_list then
		return {}
	end
end

CoreControllerWrapperConnection.set_range = function(l_37_0, l_37_1, l_37_2, l_37_3, l_37_4)
	if l_37_1 ~= l_37_0.DEFAULT_MIN_SRC_RANGE then
		l_37_0._min_src_range = l_37_1
	else
		l_37_0._min_src_range = nil
	end
	if l_37_2 ~= l_37_0.DEFAULT_MAX_SRC_RANGE then
		l_37_0._max_src_range = l_37_2
	else
		l_37_0._max_src_range = nil
	end
	if l_37_3 ~= l_37_0.DEFAULT_MIN_DEST_RANGE then
		l_37_0._min_dest_range = l_37_3
	else
		l_37_0._min_dest_range = nil
	end
	if l_37_4 ~= l_37_0.DEFAULT_MAX_DEST_RANGE then
		l_37_0._max_dest_range = l_37_4
	else
		l_37_0._max_dest_range = nil
	end
end

CoreControllerWrapperConnection.get_range = function(l_38_0)
	if ((l_38_0._min_src_range or not l_38_0._max_src_range) and l_38_0._min_dest_range) or not l_38_0._max_dest_range then
		return l_38_0.DEFAULT_MIN_SRC_RANGE, l_38_0.DEFAULT_MAX_SRC_RANGE, l_38_0.DEFAULT_MIN_DEST_RANGE, l_38_0.DEFAULT_MAX_DEST_RANGE
	end
end

CoreControllerWrapperConnection.set_connect_src_type = function(l_39_0, l_39_1)
	if l_39_0._connect_src_type ~= l_39_0.DEFAULT_CONNECT_SRC_TYPE then
		l_39_0._connect_src_type = l_39_1
	else
		l_39_0._connect_src_type = nil
	end
end

CoreControllerWrapperConnection.get_connect_src_type = function(l_40_0)
	if not l_40_0._connect_src_type then
		return l_40_0.DEFAULT_CONNECT_SRC_TYPE
	end
end

CoreControllerWrapperConnection.set_connect_dest_type = function(l_41_0, l_41_1)
	if l_41_0._connect_dest_type ~= l_41_0.DEFAULT_CONNECT_DEST_TYPE then
		l_41_0._connect_dest_type = l_41_1
	else
		l_41_0._connect_dest_type = nil
	end
end

CoreControllerWrapperConnection.get_connect_dest_type = function(l_42_0)
	if not l_42_0._connect_dest_type then
		return l_42_0.DEFAULT_CONNECT_DEST_TYPE
	end
end

CoreControllerWrapperConnection.print_output_to_string = function(l_43_0, l_43_1, l_43_2)
	l_43_1 = l_43_1 .. string.rep("\t", l_43_2) .. "<" .. l_43_0.TYPE .. l_43_0:get_output_attributes() .. ""
	if l_43_0:has_children() then
		l_43_1 = l_43_1 .. ">"
		l_43_1 = l_43_0:print_output_children_to_string(l_43_1, l_43_2 + 1)
		l_43_1 = l_43_1 .. string.rep("\t", l_43_2) .. "</" .. l_43_0.TYPE .. ">"
	else
		l_43_1 = l_43_1 .. "/>"
	end
	return l_43_1
end

CoreControllerWrapperConnection.print_output = function(l_44_0, l_44_1, l_44_2)
	l_44_1:print(string.rep("\t", l_44_2) .. "<" .. l_44_0.TYPE .. l_44_0:get_output_attributes() .. "")
	if l_44_0:has_children() then
		l_44_1:puts(">")
		l_44_0:print_output_children(l_44_1, l_44_2 + 1)
		l_44_1:puts(string.rep("\t", l_44_2) .. "</" .. l_44_0.TYPE .. ">")
	else
		l_44_1:puts("/>")
	end
end

CoreControllerWrapperConnection.has_children = function(l_45_0)
	return not l_45_0._delay_connection_list or #l_45_0._delay_connection_list > 0
end

CoreControllerWrapperConnection.print_output_children_to_string = function(l_46_0, l_46_1, l_46_2)
	local l_46_6, l_46_7 = nil
	if l_46_0._delay_connection_list then
		for i_0,i_1 in ipairs(l_46_0._delay_connection_list) do
			l_46_1 = i_1:print_output_to_string(l_46_1, l_46_2)
		end
	end
	return l_46_1
end

CoreControllerWrapperConnection.print_output_children = function(l_47_0, l_47_1, l_47_2)
	local l_47_6, l_47_7, l_47_8, l_47_9 = nil
	if l_47_0._delay_connection_list then
		for i_0,i_1 in ipairs(l_47_0._delay_connection_list) do
			i_1:print_output(l_47_1, l_47_2)
		end
	end
end

CoreControllerWrapperConnection.get_output_attributes = function(l_48_0)
	local l_48_7, l_48_13 = nil
	local l_48_1 = ""
	if l_48_0._controller_id then
		l_48_1 = l_48_1 .. " controller=\"" .. tostring(l_48_0._controller_id) .. "\""
	end
	if l_48_0._debug then
		l_48_1 = l_48_1 .. " debug=\"" .. tostring(not not l_48_0._debug) .. "\""
	end
	if l_48_0._disabled then
		l_48_1 = l_48_1 .. " enabled=\"" .. tostring(not l_48_0._disabled) .. "\""
	end
	if l_48_0._single_input then
		l_48_1 = l_48_1 .. " any_input=\"" .. tostring(not l_48_0._single_input) .. "\""
	end
	if l_48_0._delay then
		l_48_1 = l_48_1 .. string.format(" delay=\"%g\"", l_48_0._delay)
	end
	if l_48_0._min_src_range then
		l_48_1 = l_48_1 .. string.format(" min_src_range=\"%g\"", l_48_0._min_src_range)
	end
	if l_48_0._max_src_range then
		l_48_1 = l_48_1 .. string.format(" max_src_range=\"%g\"", l_48_0._max_src_range)
	end
	if l_48_0._min_dest_range then
		l_48_1 = l_48_1 .. string.format(" min_dest_range=\"%g\"", l_48_0._min_dest_range)
	end
	if l_48_0._max_dest_range then
		l_48_1 = l_48_1 .. string.format(" max_dest_range=\"%g\"", l_48_0._max_dest_range)
	end
	if l_48_0._connect_src_type then
		l_48_1 = l_48_1 .. string.format(" connect_src_type=\"%s\"", l_48_0._connect_src_type)
	end
	if l_48_0._connect_dest_type then
		local l_48_5, l_48_6 = l_48_1, string.format
		l_48_6 = l_48_6(" connect_dest_type=\"%s\"", l_48_0._connect_dest_type)
		l_48_1 = l_48_5 .. l_48_6
	end
	if l_48_0._input_name_list then
		for i_0,i_1 in ipairs(l_48_0._input_name_list) do
			if l_48_8 > 1 then
				local l_48_15 = "input" .. l_48_8
			end
			local l_48_16 = l_48_1
			local l_48_17 = " "
			local l_48_18 = l_48_15
			local l_48_19 = "=\""
			local l_48_20 = tostring(l_48_14)
			l_48_1 = l_48_16 .. l_48_17 .. l_48_18 .. l_48_19 .. l_48_20 .. "\""
		end
	end
	local l_48_9 = string.format
	local l_48_10 = " name=\"%s\"%s"
	do
		local l_48_11 = l_48_0._name or ""
	end
	local l_48_12 = nil
	return l_48_9(l_48_10, l_48_12, l_48_1)
end

CoreControllerWrapperConnection.__tostring = function(l_49_0, l_49_1)
	local l_49_2 = string.format
	local l_49_3 = "[Controller][Connection][Type: %s, Name: %s, Input: %s, Controller: %s, Debug: %s, Enabled: %s, Any input: %s, Delay: %s%s, File: \"%s\", Line: %s]"
	local l_49_4 = tostring(l_49_0.TYPE)
	local l_49_5 = tostring(l_49_0._name)
	do
		local l_49_6 = l_49_0._input_name_list and table.concat_map(l_49_0._input_name_list, true, "N/A") or ""
	end
	local l_49_7 = nil
	local l_49_8 = tostring(l_49_0._controller_id)
	local l_49_9 = tostring(l_49_0._debug)
	local l_49_10 = tostring(not l_49_0._disabled)
	local l_49_12 = tostring(l_49_1 or "")
	local l_49_13 = tostring(not l_49_0._single_input)
	do
		local l_49_14, l_49_15 = tostring(l_49_0._delay), tostring(l_49_0._file)
		return l_49_2(l_49_3, l_49_4, l_49_5, l_49_7, l_49_8, l_49_9, l_49_10, l_49_12, l_49_13, l_49_14, l_49_15, tostring(l_49_0._line))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not CoreControllerWrapperButton then
	CoreControllerWrapperButton = class(CoreControllerWrapperConnection)
end
CoreControllerWrapperButton.TYPE = "button"
CoreControllerWrapperButton.init = function(l_50_0, l_50_1)
	get_core_or_local("ControllerWrapperConnection").init(l_50_0, l_50_1)
end

CoreControllerWrapperButton.__tostring = function(l_51_0, l_51_1)
	local l_51_2 = get_core_or_local("ControllerWrapperConnection").__tostring
	local l_51_3 = l_51_0
	local l_51_4 = l_51_1
	return l_51_2(l_51_3, l_51_4)
end

if not CoreControllerWrapperAxis then
	CoreControllerWrapperAxis = class(CoreControllerWrapperConnection)
end
CoreControllerWrapperAxis.TYPE = "axis"
CoreControllerWrapperAxis.IS_AXIS = true
CoreControllerWrapperAxis.DEFAULT_MIN_SRC_RANGE = -1
CoreControllerWrapperAxis.DEFAULT_MAX_SRC_RANGE = 1
CoreControllerWrapperAxis.DEFAULT_MIN_DEST_RANGE = -1
CoreControllerWrapperAxis.DEFAULT_MAX_DEST_RANGE = 1
CoreControllerWrapperAxis.DEFAULT_CONNECT_SRC_TYPE = "axis"
CoreControllerWrapperAxis.DEFAULT_CONNECT_DEST_TYPE = "axis"
CoreControllerWrapperAxis.ONE_VECTOR = Vector3(1, 1, 1)
CoreControllerWrapperAxis.init = function(l_52_0, l_52_1)
	get_core_or_local("ControllerWrapperConnection").init(l_52_0, l_52_1)
	l_52_0._multiplier = l_52_0.ONE_VECTOR
	l_52_0._inversion = l_52_0.ONE_VECTOR
	if l_52_1 then
		local l_52_2 = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_52_1, "multiplier")
		if math.string_is_good_vector(l_52_2) then
			l_52_0:set_multiplier(math.string_to_vector(l_52_2))
		end
		l_52_0:set_lerp(tonumber(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_52_1, "lerp")))
		local l_52_3 = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_52_1, "init_lerp_axis")
		if math.string_is_good_vector(l_52_3) then
			l_52_0:set_init_lerp_axis(math.string_to_vector(l_52_3))
		end
		l_52_0:set_pad_bottom(tonumber(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_52_1, "pad_bottom")))
		l_52_0:set_pad_top(tonumber(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_52_1, "pad_top")))
		l_52_0:set_soft_top(tonumber(get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_52_1, "soft_top")))
		if get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_52_1, "no_limit") == "true" then
			l_52_0._no_limit = true
		end
		local l_52_4 = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_52_1, "inversion")
	if math.string_is_good_vector(l_52_4) then
		end
		l_52_0:set_inversion(math.string_to_vector(l_52_4))
	end
	if l_52_1 then
		l_52_0._btn_connections = {}
		l_52_0:read_axis_btns(l_52_1)
	end
end

CoreControllerWrapperAxis.read_axis_btns = function(l_53_0, l_53_1)
	local l_53_5, l_53_6 = nil
	for i_0 in l_53_1:children() do
		if (i_0:name() == "button" or i_0:name() == "axis") and l_53_7:has_parameter("name") and l_53_7:has_parameter("input") then
			local l_53_8 = nil
			local l_53_9 = l_53_0._btn_connections
			local l_53_10 = l_53_7:parameter("name")
			l_53_9[l_53_10] = {type = l_53_8, name = l_53_7:parameter("input")}
			l_53_9, l_53_10 = l_53_7:has_parameter, l_53_7
			l_53_9 = l_53_9(l_53_10, "dir")
			if l_53_9 then
				l_53_9 = l_53_0._btn_connections
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_53_9 = l_53_9[l_53_10]
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_53_9.dir = l_53_10
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_53_9 = l_53_7:has_parameter
			l_53_9 = l_53_9(l_53_10, "range1")
			if l_53_9 then
				l_53_9 = l_53_0._btn_connections
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_53_9 = l_53_9[l_53_10]
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_53_9.range1 = l_53_10
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_53_9 = l_53_7:has_parameter
			l_53_9 = l_53_9(l_53_10, "range2")
		if l_53_9 then
			end
			l_53_9 = l_53_0._btn_connections
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_53_9 = l_53_9[l_53_10]
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_53_9.range2 = l_53_10
		end
	end
end

CoreControllerWrapperAxis.print_output_to_string = function(l_54_0, l_54_1, l_54_2)
	l_54_1 = l_54_1 .. string.rep("\t", l_54_2) .. "<" .. l_54_0.TYPE .. l_54_0:get_output_attributes() .. ""
	if l_54_0:has_children() then
		l_54_1 = l_54_1 .. ">"
		l_54_1 = l_54_0:print_output_children_to_string(l_54_1, l_54_2 + 1)
		l_54_1 = l_54_1 .. string.rep("\t", l_54_2) .. "</" .. l_54_0.TYPE .. ">"
	elseif l_54_0._btn_connections then
		l_54_1 = l_54_1 .. ">"
		l_54_1 = l_54_0:print_output_axis_btns_to_string(l_54_1, l_54_2 + 1)
		l_54_1 = l_54_1 .. string.rep("\t", l_54_2) .. "</" .. l_54_0.TYPE .. ">"
	else
		l_54_1 = l_54_1 .. "/>"
	end
	return l_54_1
end

CoreControllerWrapperAxis.print_output = function(l_55_0, l_55_1, l_55_2)
	l_55_1:print(string.rep("\t", l_55_2) .. "<" .. l_55_0.TYPE .. l_55_0:get_output_attributes() .. "")
	if l_55_0:has_children() then
		l_55_1:puts(">")
		l_55_0:print_output_children(l_55_1, l_55_2 + 1)
		l_55_1:puts(string.rep("\t", l_55_2) .. "</" .. l_55_0.TYPE .. ">")
	elseif l_55_0._btn_connections then
		l_55_1:puts(">")
		l_55_0:print_output_axis_btns(l_55_1, l_55_2 + 1)
		l_55_1:puts(string.rep("\t", l_55_2) .. "</" .. l_55_0.TYPE .. ">")
	else
		l_55_1:puts("/>")
	end
end

CoreControllerWrapperAxis.print_output_axis_btns_to_string = function(l_56_0, l_56_1, l_56_2)
	local l_56_6, l_56_7, l_56_8, l_56_9, l_56_10, l_56_11, l_56_12, l_56_13, l_56_14, l_56_15, l_56_16, l_56_17, l_56_18, l_56_19, l_56_20, l_56_21, l_56_22, l_56_23, l_56_24, l_56_25 = nil
	for i_0,i_1 in pairs(l_56_0._btn_connections) do
		if i_1.type == "button" then
			l_56_1 = l_56_1 .. string.rep("\t", l_56_2) .. string.format("<%s name=\"%s\" input=\"%s\"/>", i_1.type, i_0, i_1.name)
		elseif i_1.type == "axis" then
			l_56_1 = l_56_1 .. string.rep("\t", l_56_2) .. string.format("<%s name=\"%s\" input=\"%s\" dir=\"%s\" range1=\"%s\" range2=\"%s\"/>", i_1.type, i_0, i_1.name, i_1.dir, i_1.range1, i_1.range2)
		end
	end
	return l_56_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreControllerWrapperAxis.print_output_axis_btns = function(l_57_0, l_57_1, l_57_2)
	local l_57_6, l_57_7, l_57_8, l_57_9, l_57_10, l_57_11, l_57_12, l_57_13, l_57_14, l_57_15, l_57_16, l_57_17, l_57_18, l_57_19, l_57_20, l_57_21, l_57_22, l_57_23, l_57_24, l_57_25, l_57_26, l_57_27, l_57_28, l_57_29 = nil
	for i_0,i_1 in pairs(l_57_0._btn_connections) do
		if i_1.type == "button" then
			l_57_1:puts(string.rep("\t", l_57_2) .. string.format("<%s name=\"%s\" input=\"%s\"/>", i_1.type, i_0, i_1.name))
		elseif i_1.type == "axis" then
			l_57_1:puts(string.rep("\t", l_57_2) .. string.format("<%s name=\"%s\" input=\"%s\" dir=\"%s\" range1=\"%s\" range2=\"%s\"/>", i_1.type, i_0, i_1.name, i_1.dir, i_1.range1, i_1.range2))
		end
	end
end

CoreControllerWrapperAxis.set_multiplier = function(l_58_0, l_58_1)
	do
		if not l_58_1 then
			l_58_0._multiplier = l_58_0.ONE_VECTOR
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapperAxis.get_multiplier = function(l_59_0)
	return l_59_0._multiplier
end

CoreControllerWrapperAxis.set_lerp = function(l_60_0, l_60_1)
	do
		if l_60_1 then
			l_60_0._lerp = math.clamp(l_60_1, 0, 1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapperAxis.get_lerp = function(l_61_0)
	return l_61_0._lerp
end

CoreControllerWrapperAxis.set_init_lerp_axis = function(l_62_0, l_62_1)
	l_62_0._init_lerp_axis = l_62_1
end

CoreControllerWrapperAxis.get_init_lerp_axis = function(l_63_0)
	return l_63_0._init_lerp_axis
end

CoreControllerWrapperAxis.set_pad_bottom = function(l_64_0, l_64_1)
	do
		if l_64_1 then
			l_64_0._pad_bottom = math.clamp(l_64_1, 0, 1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapperAxis.get_pad_bottom = function(l_65_0)
	return l_65_0._pad_bottom
end

CoreControllerWrapperAxis.set_pad_top = function(l_66_0, l_66_1)
	do
		if l_66_1 then
			l_66_0._pad_top = math.clamp(l_66_1, 0, 1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapperAxis.get_pad_top = function(l_67_0)
	return l_67_0._pad_top
end

CoreControllerWrapperAxis.set_soft_top = function(l_68_0, l_68_1)
	do
		if l_68_1 then
			l_68_0._soft_top = math.clamp(l_68_1, 0, 1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapperAxis.get_soft_top = function(l_69_0)
	return l_69_0._soft_top
end

CoreControllerWrapperAxis.set_no_limit = function(l_70_0, l_70_1)
	if l_70_1 then
		l_70_0._no_limit = true
	else
		l_70_0._no_limit = nil
	end
end

CoreControllerWrapperAxis.get_no_limit = function(l_71_0)
	return l_71_0._no_limit
end

CoreControllerWrapperAxis.set_inversion = function(l_72_0, l_72_1)
	do
		if not l_72_1 then
			l_72_0._inversion = l_72_0.ONE_VECTOR
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapperAxis.get_inversion = function(l_73_0)
	return l_73_0._inversion
end

CoreControllerWrapperAxis.get_output_attributes = function(l_74_0)
	local l_74_1 = ""
	if l_74_0._multiplier and (l_74_0._multiplier.x ~= 1 or l_74_0._multiplier.y ~= 1 or l_74_0._multiplier.z ~= 1) then
		l_74_1 = l_74_1 .. string.format(" multiplier=\"%g %g %g\"", l_74_0._multiplier.x, l_74_0._multiplier.y, l_74_0._multiplier.z)
	end
	if l_74_0._lerp then
		l_74_1 = l_74_1 .. string.format(" lerp=\"%g\"", l_74_0._lerp)
	if l_74_0._init_lerp_axis then
		end
	if l_74_0._init_lerp_axis.x ~= 1 or l_74_0._init_lerp_axis.y ~= 1 or l_74_0._init_lerp_axis.z ~= 1 then
		end
		l_74_1 = l_74_1 .. string.format(" init_lerp_axis=\"%g %g %g\"", l_74_0._init_lerp_axis.x, l_74_0._init_lerp_axis.y, l_74_0._init_lerp_axis.z)
	end
	if l_74_0._pad_bottom and l_74_0._pad_bottom ~= 0 then
		l_74_1 = l_74_1 .. string.format(" pad_bottom=\"%g\"", l_74_0._pad_bottom)
	end
	if l_74_0._pad_top and l_74_0._pad_top ~= 0 then
		l_74_1 = l_74_1 .. string.format(" pad_top=\"%g\"", l_74_0._pad_top)
	end
	if l_74_0._soft_top and l_74_0._soft_top ~= 0 then
		l_74_1 = l_74_1 .. string.format(" soft_top=\"%g\"", l_74_0._soft_top)
	end
	if l_74_0._no_limit then
		l_74_1 = l_74_1 .. string.format(" no_limit=\"%s\"", tostring(not not l_74_0._no_limit))
	end
	if l_74_0._inversion and (l_74_0._inversion.x ~= 1 or l_74_0._inversion.y ~= 1 or l_74_0._inversion.z ~= 1) then
		l_74_1 = l_74_1 .. string.format(" inversion=\"%g %g %g\"", l_74_0._inversion.x, l_74_0._inversion.y, l_74_0._inversion.z)
	end
	return get_core_or_local("ControllerWrapperConnection").get_output_attributes(l_74_0) .. l_74_1
end

CoreControllerWrapperAxis.__tostring = function(l_75_0, l_75_1)
	local l_75_2 = get_core_or_local("ControllerWrapperConnection").__tostring
	local l_75_3 = l_75_0
	local l_75_4 = tostring
	l_75_4 = l_75_4(l_75_1 or "")
	local l_75_6 = ", Multiplier: "
	local l_75_7 = tostring(l_75_0._multiplier)
	local l_75_8 = ", Lerp: "
	local l_75_9 = tostring(l_75_0._lerp)
	local l_75_10 = ", Initial lerp axis: "
	local l_75_11 = tostring(l_75_0._init_lerp_axis)
	local l_75_12 = ", Pad bottom: "
	local l_75_13 = tostring(l_75_0._pad_bottom)
	local l_75_14 = ", Pad top: "
	local l_75_15 = tostring(l_75_0._pad_top)
	local l_75_16 = ", Soft top: "
	local l_75_17 = tostring(l_75_0._soft_top)
	local l_75_18 = ", No limit: "
	local l_75_19 = tostring(l_75_0._no_limit)
	do
		local l_75_21 = ", Inversion: "
		local l_75_20 = tostring(l_75_0._inversion)
		l_75_4 = l_75_4 .. l_75_6 .. l_75_7 .. l_75_8 .. l_75_9 .. l_75_10 .. l_75_11 .. l_75_12 .. l_75_13 .. l_75_14 .. l_75_15 .. l_75_16 .. l_75_17 .. l_75_18 .. l_75_19 .. l_75_21 .. l_75_20
		return l_75_2(l_75_3, l_75_4)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not CoreControllerWrapperDelayConnection then
	CoreControllerWrapperDelayConnection = class()
end
CoreControllerWrapperDelayConnection.TYPE = "delay"
CoreControllerWrapperDelayConnection.init = function(l_76_0, l_76_1)
	if l_76_1 then
		l_76_0._name = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_76_1, "name")
	end
end

CoreControllerWrapperDelayConnection.set_name = function(l_77_0, l_77_1)
	l_77_0._name = l_77_1
end

CoreControllerWrapperDelayConnection.get_name = function(l_78_0)
	return l_78_0._name
end

CoreControllerWrapperDelayConnection.print_output_to_string = function(l_79_0, l_79_1, l_79_2)
	l_79_1 = l_79_1 .. string.rep("\t", l_79_2) .. string.format("<%s name=\"%s\"/>", l_79_0.TYPE, l_79_0._name)
	return l_79_1
end

CoreControllerWrapperDelayConnection.print_output = function(l_80_0, l_80_1, l_80_2)
	l_80_1:puts(string.rep("\t", l_80_2) .. string.format("<%s name=\"%s\"/>", l_80_0.TYPE, l_80_0._name))
end

CoreControllerWrapperDelayConnection.__tostring = function(l_81_0, l_81_1)
	local l_81_2 = string.format
	local l_81_3 = "[Controller][DelayConnection][Name: %s%s, File: \"%s\", Line: %s]"
	local l_81_4 = tostring(l_81_0._name)
	local l_81_5 = tostring(l_81_1)
	local l_81_6 = tostring(l_81_0._file)
	local l_81_7, l_81_8 = tostring(l_81_0._line), .end
	return l_81_2(l_81_3, l_81_4, l_81_5, l_81_6, l_81_7, l_81_8)
end

if not CoreControllerWrapperEditable then
	CoreControllerWrapperEditable = class()
end
CoreControllerWrapperEditable.init = function(l_82_0, l_82_1)
	l_82_0._connection_name = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_82_1, "name")
	if not get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_82_1, "caption") then
		l_82_0._caption = l_82_0._connection_name
	end
	l_82_0._locale_id = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_82_1, "locale_id")
end

CoreControllerWrapperEditable.get_connection_name = function(l_83_0)
	return l_83_0._connection_name
end

CoreControllerWrapperEditable.set_connection_name = function(l_84_0, l_84_1)
	l_84_0._connection_name = l_84_1
end

CoreControllerWrapperEditable.get_caption = function(l_85_0)
	return l_85_0._caption
end

CoreControllerWrapperEditable.set_caption = function(l_86_0, l_86_1)
	do
		if not l_86_1 then
			l_86_0._caption = l_86_0._connection_name
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreControllerWrapperEditable.get_locale_id = function(l_87_0)
	return l_87_0._locale_id
end

CoreControllerWrapperEditable.set_locale_id = function(l_88_0, l_88_1)
	l_88_0._locale_id = l_88_1
end

CoreControllerWrapperEditable.print_output_to_string = function(l_89_0, l_89_1, l_89_2)
	local l_89_3 = ""
	if l_89_0._locale_id then
		l_89_3 = l_89_3 .. " locale_id=\"" .. tostring(l_89_0._locale_id) .. "\""
	end
	l_89_1 = l_89_1 .. string.format(string.rep("\t", l_89_2) .. "<connection name=\"%s\" caption=\"%s\"%s/>", tostring(l_89_0._connection_name), tostring(l_89_0._caption), l_89_3)
	return l_89_1
end

CoreControllerWrapperEditable.print_output = function(l_90_0, l_90_1, l_90_2)
	local l_90_3 = ""
	if l_90_0._locale_id then
		l_90_3 = l_90_3 .. " locale_id=\"" .. tostring(l_90_0._locale_id) .. "\""
	end
	l_90_1:puts(string.format(string.rep("\t", l_90_2) .. "<connection name=\"%s\" caption=\"%s\"%s/>", tostring(l_90_0._connection_name), tostring(l_90_0._caption), l_90_3))
end

CoreControllerWrapperEditable.__tostring = function(l_91_0, l_91_1)
	local l_91_2 = string.format
	local l_91_3 = "[Editable connection name: %s, Caption: %s, Locale id: %s, File: \"%s\", Line: %s]"
	local l_91_4 = tostring(l_91_0._connection_name)
	local l_91_5 = tostring(l_91_0._caption)
	local l_91_6 = tostring(l_91_0._locale_id)
	local l_91_7 = tostring(l_91_0._file)
	local l_91_8, l_91_9 = tostring(l_91_0._line), .end
	return l_91_2(l_91_3, l_91_4, l_91_5, l_91_6, l_91_7, l_91_8, l_91_9)
end

if not CoreControllerWrapperUnselectable then
	CoreControllerWrapperUnselectable = class()
end
CoreControllerWrapperUnselectable.init = function(l_92_0, l_92_1)
	l_92_0._input_name = get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_92_1, "name")
	if get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_92_1, "single") ~= "false" then
		l_92_0._single = true
	end
	if get_core_or_local("ControllerWrapperSettings"):get_node_parameter(l_92_1, "multi") ~= "false" then
		l_92_0._multi = true
	end
end

CoreControllerWrapperUnselectable.get_input_name = function(l_93_0)
	return l_93_0._input_name
end

CoreControllerWrapperUnselectable.set_input_name = function(l_94_0, l_94_1)
	l_94_0._input_name = l_94_1
end

CoreControllerWrapperUnselectable.get_single = function(l_95_0)
	return l_95_0._single
end

CoreControllerWrapperUnselectable.set_single = function(l_96_0, l_96_1)
	if l_96_1 then
		l_96_0._single = true
	else
		l_96_0._single = nil
	end
end

CoreControllerWrapperUnselectable.get_multi = function(l_97_0)
	return l_97_0._multi
end

CoreControllerWrapperUnselectable.set_multi = function(l_98_0, l_98_1)
	if l_98_1 then
		l_98_0._multi = true
	else
		l_98_0._multi = nil
	end
end

CoreControllerWrapperUnselectable.print_output_to_string = function(l_99_0, l_99_1, l_99_2)
	local l_99_3 = ""
	if not l_99_0._single then
		l_99_3 = string.format(" single=\"%s\"", tostring(not not l_99_0._single))
	end
	if not l_99_0._multi then
		l_99_3 = string.format(" multi=\"%s\"", tostring(not not l_99_0._multi))
	end
	l_99_1 = l_99_1 .. string.format(string.rep("\t", l_99_2) .. "<input name=\"%s\"%s/>", tostring(l_99_0._input_name), l_99_3)
	return l_99_1
end

CoreControllerWrapperUnselectable.print_output = function(l_100_0, l_100_1, l_100_2)
	local l_100_3 = ""
	if not l_100_0._single then
		l_100_3 = string.format(" single=\"%s\"", tostring(not not l_100_0._single))
	end
	if not l_100_0._multi then
		l_100_3 = string.format(" multi=\"%s\"", tostring(not not l_100_0._multi))
	end
	l_100_1:puts(string.format(string.rep("\t", l_100_2) .. "<input name=\"%s\"%s/>", tostring(l_100_0._input_name), l_100_3))
end

CoreControllerWrapperUnselectable.__tostring = function(l_101_0, l_101_1)
	local l_101_2 = string.format
	local l_101_3 = "[Unselectable input name: \"%s\", File: \"%s\", Line: %s]"
	local l_101_4 = tostring(l_101_0._input_name)
	local l_101_5 = tostring(l_101_0._file)
	local l_101_6, l_101_7 = tostring(l_101_0._line), .end
	return l_101_2(l_101_3, l_101_4, l_101_5, l_101_6, l_101_7)
end


