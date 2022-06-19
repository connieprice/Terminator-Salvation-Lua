TS_StateValue = class()
TS_StateValue.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._name = l_1_1
	l_1_0._index = l_1_2
	l_1_0._value = l_1_3
	l_1_0._type = l_1_4
end

if not TableScan then
	TableScan = class()
end
TableScan.init = function(l_2_0)
	l_2_0._TSValues = {}
	l_2_0._TSValuesMap = {}
	l_2_0._table = nil
	l_2_0._list = nil
	l_2_0._anka = true
	l_2_0._ignoreclass = false
end

TableScan.GetValue = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = nil
	if type(l_3_2) == "number" then
		l_3_3 = tostring(l_3_2)
	else
		if type(l_3_2) == "string" then
			l_3_3 = tostring(l_3_2)
		end
	else
		if type(l_3_2) == "nil" then
			l_3_3 = "nil"
		end
	else
		if type(l_3_2) == "userdata" and getmetatable(l_3_2) then
			local l_3_4 = nil
			l_3_3 = getmetatable(l_3_2).tostring(l_3_2)
		end
	end
	do return end
	if type(l_3_2) == "boolean" then
		if l_3_2 then
			l_3_3 = "true"
		else
			l_3_3 = "false"
		end
	else
		if type(l_3_2) == "function" then
			l_3_3 = tostring(l_3_1) .. string.rep(" ", 30 - #tostring(l_3_1))
			if debug.getinfo(l_3_2, "S").what == "Lua" then
				l_3_3 = l_3_3 .. "(" .. debug.getinfo(l_3_2, "S").source .. ":" .. debug.getinfo(l_3_2, "S").linedefined .. ")"
			end
		else
			l_3_3 = l_3_3 .. "(C)"
		end
	else
		if type(l_3_2) == "table" then
			l_3_3 = tostring(l_3_2)
		end
	else
		l_3_3 = "Unknown Data: " .. type(l_3_2)
	end
	return l_3_3
end

TableScan.is_class = function(l_4_0, l_4_1)
	local l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13 = nil
	local l_4_2 = false
	local l_4_3 = false
	for i_0,i_1 in pairs(l_4_1) do
		if type(i_1) ~= "function" and type(i_1) == "table" and i_0 ~= "__index" then
			return false
		end
		if i_0 == "new" then
			l_4_2 = true
		end
		if i_0 == "init" then
			l_4_3 = true
		end
	end
	if l_4_2 == true and l_4_3 == true then
		return true
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableScan.is_class_instance = function(l_5_0, l_5_1)
	local l_5_2 = getmetatable(l_5_1)
	if l_5_2 == nil then
		return false
	end
	if l_5_0:is_class(l_5_2) == true then
		return true
	end
	local l_5_3, l_5_4 = l_5_0:is_class_instance, l_5_0
	local l_5_5 = l_5_2
	return l_5_3(l_5_4, l_5_5)
end

GetLuaClassType = function(l_6_0)
	local l_6_4, l_6_5, l_6_6 = nil
	for i_0,i_1 in pairs(_G) do
		if l_6_0 == i_1 then
			return i_0
		end
	end
	return "Unkown Lua class"
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableScan.get_type = function(l_7_0, l_7_1)
	local l_7_2 = nil
	l_7_2 = type(l_7_1)
	if l_7_2 == "table" then
		if l_7_0:is_class_instance(l_7_1) == true then
			l_7_2 = GetLuaClassType(getmetatable(l_7_1))
		else
			if l_7_0:is_class(l_7_1) == true then
				l_7_2 = "class " .. GetLuaClassType(l_7_1)
			end
		else
			l_7_2 = "table"
			return l_7_2
		end
		return l_7_2
		 -- WARNING: missing end command somewhere! Added here
	end
end

TableScan.clear = function(l_8_0)
	l_8_0._table = nil
end

IsUserDataWrapperTable = function(l_9_0)
	if type(l_9_0) ~= "table" then
		return false
	end
	if type(l_9_0[1]) ~= "userdata" then
		return false
	end
	return true
end

TableScan.set_table = function(l_10_0, l_10_1)
	local l_10_10, l_10_11, l_10_12, l_10_13, l_10_14, l_10_15 = nil
	local l_10_2 = {}
	local l_10_3 = nil
	if l_10_0._table ~= nil then
		return 
	end
	l_10_0._TSValues = nil
	l_10_0._TSValues = {}
	l_10_0._TSValuesMap = nil
	l_10_0._TSValuesMap = {}
	l_10_0._table = l_10_1
	l_10_0._list:clear_all()
	l_10_0._list:append_column("Name")
	l_10_0._list:append_column("Type")
	l_10_0._list:append_column("Value")
	local l_10_4 = {}
	if IsUserDataWrapperTable(l_10_1) == true then
		function(l_11_0)
		-- upvalues: l_10_3 , l_10_0 , l_10_2 , l_10_4 , l_10_5
		local l_11_4, l_11_5, l_11_6, l_11_7, l_11_8, l_11_9, l_11_10, l_11_11, l_11_12, l_11_13, l_11_14, l_11_15 = nil
		if type(l_11_0) == "table" then
			for i_0,i_1 in pairs(l_11_0) do
				l_10_3 = l_10_0:GetValue(i_0, i_1)
				l_10_2[i_0] = true
				if l_10_0:get_type(i_1) == "CLASS" and l_10_0._ignoreclass == true then
					for i_0,i_1 in l_11_1 do
					end
					table.insert(l_10_4, TS_StateValue:new(i_0, -1, l_10_3, l_10_0:get_type(i_1)))
				end
			end
			if getmetatable(l_11_0) then
				l_10_5(getmetatable(l_11_0))
			end
			 -- WARNING: missing end command somewhere! Added here
		end
  end(l_10_1)
		do
			local l_10_6 = nil
			table.sort(l_10_4, function(l_12_0, l_12_1)
			if tonumber(l_12_1._name) then
				if l_12_0._name >= l_12_1._name then
					return not tonumber(l_12_0._name)
				end
			else
				return true
			end
			do return end
			if tonumber(l_12_1._name) then
				return false
			else
				return tostring(l_12_0._name) < tostring(l_12_1._name)
			end
    end)
			for i_0,i_1 in ipairs(l_10_4) do
				local l_10_7 = nil
				i_1._index = l_10_0._list:append_item(i_1._name)
				l_10_0._list:set_item(l_10_0._list:append_item(i_1._name), 1, i_1._type)
				l_10_0._list:set_item(l_10_0._list:append_item(i_1._name), 2, i_1._value)
				l_10_0._TSValues[l_10_0._list:append_item(i_1._name)] = i_1
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 42 
end

TableScan.update = function(l_11_0)
	if l_11_0._table == nil or l_11_0._last_list then
		return 
	end
	local l_11_1 = nil
	do
		local l_11_3 = function(l_12_0)
		-- upvalues: l_11_1 , l_11_0 , l_11_2
		local l_12_4, l_12_5, l_12_6, l_12_7, l_12_8, l_12_9 = nil
		if type(l_12_0) == "table" then
			for i_0,i_1 in pairs(l_12_0) do
				l_11_1 = l_11_0:GetValue(i_0, i_1)
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: unhandled construct in 'if'

				if l_11_0._TSValuesMap[i_0] ~= nil and l_11_0._TSValuesMap[i_0]._value ~= l_11_1 then
					l_11_0._list:set_item(l_11_0._TSValuesMap[i_0]._index, 2, l_11_1)
					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_11_0._TSValuesMap[i_0]._value = l_11_1
				end
				for l_12_10,i_1 in l_12_1 do
					if l_11_0:get_type(i_1) == "CLASS" and l_11_0._ignoreclass == true then
						for l_12_10,i_1 in l_12_1 do
						end
						local l_12_12 = nil
						l_11_0._list:set_item(l_11_0._list:append_item(l_12_10), 1, l_11_0:get_type(l_12_11))
						l_11_0._list:set_item(l_11_0._list:append_item(l_12_10), 2, l_11_1)
						l_11_0._TSValues[l_11_0._list:append_item(l_12_10)] = TS_StateValue:new(l_12_10, l_11_0._list:append_item(l_12_10), l_11_1)
						l_11_0._TSValuesMap[l_12_10] = TS_StateValue:new(l_12_10, l_11_0._list:append_item(l_12_10), l_11_1)
					end
				end
				if getmetatable(l_12_0) then
					l_11_2(getmetatable(l_12_0))
				end
				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
  end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if IsUserDataWrapperTable(l_11_0._table) == true then
			l_11_3(l_11_0._table[1])
			l_11_0._list:autosize_column(0)
			l_11_0._list:autosize_column(2)
			l_11_0._last_list = l_11_0._list
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 20 
end

TableScan.set_listbox = function(l_12_0, l_12_1)
	l_12_0._list = l_12_1
end

TableScan.get_table = function(l_13_0, l_13_1)
	local l_13_6, l_13_7, l_13_12, l_13_17 = nil
	local l_13_2 = l_13_0._TSValues[l_13_1]
	if type(l_13_2) == "table" then
		local l_13_3 = l_13_0._table[l_13_2._name]
		if type(l_13_3) == "table" then
			return l_13_3
		end
		if type(l_13_3) == "function" then
			local l_13_4 = l_13_3
			local l_13_5 = l_13_0._table
			return l_13_4(l_13_5)
		end
		if type(l_13_3) == "userdata" then
			return l_13_3
		end
	else
		if type(l_13_2) == "userdata" then
			local l_13_8 = getmetatable(l_13_0._table)
			local l_13_9 = l_13_8[l_13_2._name]
			local l_13_10 = l_13_9
			local l_13_11 = l_13_0._table
			return l_13_10(l_13_11)
		end
	else
		if type(l_13_2) == "function" then
			local l_13_13 = getmetatable(l_13_0._table)
			local l_13_14 = l_13_13[l_13_2._name]
			local l_13_15 = l_13_14
			local l_13_16 = l_13_0._table
			return l_13_15(l_13_16)
		end
	else
		cat_error("debug", "Unkown get_table type: " .. type(l_13_2))
		return nil
	end
	return nil
end

TableScan.get_tablename = function(l_14_0, l_14_1)
	return l_14_0._TSValues[l_14_1]._name
end

TableScan.gettype_byindex = function(l_15_0, l_15_1)
	return l_15_0._TSValues[l_15_1]._type
end

TableScan.getvalue_byindex = function(l_16_0, l_16_1)
	return l_16_0._TSValues[l_16_1]._value
end

TableScan.toggle_byindex = function(l_17_0, l_17_1)
	local l_17_2 = l_17_0._TSValues[l_17_1]
	local l_17_3 = l_17_0._table
	local l_17_4 = l_17_2._name
	l_17_3[l_17_4] = not l_17_0._table[l_17_2._name]
end

TableScan.SetValue = function(l_18_0, l_18_1, l_18_2)
	local l_18_14, l_18_15, l_18_16, l_18_17 = nil
	local l_18_3 = l_18_0._TSValues[l_18_1]
	local l_18_4 = l_18_0._table[l_18_3._name]
	local l_18_5 = nil
	if type(l_18_4) == "number" then
		l_18_5 = tonumber(l_18_2)
	else
		if type(l_18_4) == "string" then
			l_18_5 = tostring(l_18_2)
		end
	else
		if type(l_18_4) == "nil" then
			l_18_5 = "nil"
		end
	else
		if type(l_18_4) == "boolean" then
			if l_18_3 then
				l_18_5 = "true"
			end
		else
			l_18_5 = "false"
		end
	else
		local l_18_6 = (l_18_0:GetValue("gaa", l_18_4))
		local l_18_7, l_18_8 = nil, nil
		l_18_7 = string.find(l_18_6, "Vector")
		if l_18_7 ~= nil then
			local l_18_9 = {}
			l_18_9[1] = 0
			l_18_9[2] = 0
			l_18_9[3] = 0
			local l_18_10 = 1
			cat_print("debug", "Vector IS: ")
			for i_0 in string.gmatch(l_18_2, "%d+%.?%d*") do
				l_18_9[l_18_10] = tonumber(i_0)
				l_18_10 = l_18_10 + 1
				cat_print("debug", i_0)
			end
			cat_print("debug", "EOV")
			l_18_5 = Vector3(l_18_9[1], l_18_9[2], l_18_9[3])
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_18_9 = cat_print
		l_18_10 = "debug"
		l_18_9(l_18_10, "Unkown datatype: " .. type(l_18_4) .. " - " .. l_18_6)
		l_18_5 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	if l_18_5 ~= nil then
		l_18_6 = cat_print
		l_18_7 = "debug"
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_18_9 = l_18_3._name
		l_18_10 = "] = "
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_18_6(l_18_7, l_18_8)
		l_18_6 = cat_print
		l_18_7 = "debug"
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_18_9 = tostring
		l_18_10 = l_18_0._table
		l_18_10 = l_18_10[l_18_3._name]
		l_18_9 = l_18_9(l_18_10)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_18_6(l_18_7, l_18_8)
		l_18_6 = l_18_0._table
		l_18_7 = l_18_3._name
		l_18_6[l_18_7] = l_18_5
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


