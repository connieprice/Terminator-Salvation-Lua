core:module("CoreTable")
core:require_module("CoreClass")
core:require_module("CoreDebug")
clone = function(l_1_0)
	local l_1_4, l_1_5 = nil
	res = {}
	for i_0,i_1 in pairs(l_1_0) do
		res[i_0] = i_1
	end
	setmetatable(res, getmetatable(l_1_0))
	return res
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

deep_clone = function(l_2_0)
	if type(l_2_0) == "userdata" then
		return l_2_0
	end
	local l_2_1 = {}
	local l_2_5, l_2_6 = setmetatable, l_2_1
	l_2_5(l_2_6, getmetatable(l_2_0))
	l_2_5 = pairs
	l_2_6 = l_2_0
	l_2_5 = l_2_5(l_2_6)
	for i_0,i_1 in l_2_5 do
		if type(l_2_4) == "table" then
			l_2_1[l_2_3] = deep_clone(l_2_4)
		else
			l_2_1[l_2_3] = l_2_4
		end
	end
	return l_2_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

dpairs = function(l_3_0)
	if type(table) ~= "table" then
		error("Expected table got", type(l_3_0))
	end
	do
		local l_3_1 = l_3_0
		return function()
		-- upvalues: l_3_3 , l_3_1 , l_3_2
		if l_3_3 == #l_3_1 then
			l_3_2 = l_3_2 + 1
		end
		local l_4_0 = l_3_1[l_3_2]
		if l_4_0 then
			l_3_3 = #l_3_1
			return l_3_2, l_4_0
		end
  end
	end
	 -- WARNING: undefined locals caused missing assignments!
end

table.tuple_iterator = function(l_4_0, l_4_1)
	return function()
		-- upvalues: l_4_2 , l_4_1 , l_4_3 , l_4_0
		l_4_2 = l_4_2 + l_4_1
		if l_4_2 <= l_4_3 then
			local l_5_0 = unpack
			local l_5_1 = l_4_0
			local l_5_2 = l_4_2
			local l_5_4 = l_4_2
			l_5_4 = l_5_4 + l_4_1
			l_5_4 = l_5_4 - 1
			local l_5_3 = nil
			return l_5_0(l_5_1, l_5_2, l_5_4)
		end
  end
	 -- WARNING: undefined locals caused missing assignments!
end

table.sorted_map_iterator = function(l_5_0, l_5_1)
	local l_5_2 = table.map_keys(l_5_0)
	local l_5_3 = 0
	local l_5_4 = #l_5_2
	table.sort(l_5_2, l_5_1)
	return function()
		-- upvalues: l_5_3 , l_5_4 , l_5_2 , l_5_0
		l_5_3 = l_5_3 + 1
		if l_5_3 <= l_5_4 then
			local l_6_0 = l_5_2[l_5_3]
			return l_6_0, l_5_0[l_6_0]
		end
  end
end

table.map_copy = function(l_6_0)
	local l_6_5, l_6_6 = nil
	local l_6_1 = {}
	for i_0,i_1 in pairs(l_6_0) do
		l_6_1[i_0] = i_1
	end
	return l_6_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.list_copy = function(l_7_0)
	local l_7_5, l_7_6 = nil
	local l_7_1 = {}
	for i_0,i_1 in ipairs(l_7_0) do
		l_7_1[i_0] = i_1
	end
	return l_7_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.get_vector_index = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7 = nil
	for i_0,i_1 in ipairs(l_8_0) do
		if i_1 == l_8_1 then
			return i_0
		end
	end
end

table.delete = function(l_9_0, l_9_1)
	local l_9_2 = table.get_vector_index(l_9_0, l_9_1)
	if l_9_2 then
		table.remove(l_9_0, l_9_2)
	end
end

table.exclude = function(l_10_0, l_10_1)
	local l_10_6, l_10_7, l_10_8, l_10_9, l_10_10, l_10_11 = nil
	local l_10_2 = {}
	for i_0,i_1 in ipairs(l_10_0) do
		if i_1 ~= l_10_1 then
			table.insert(l_10_2, i_1)
		end
	end
	return l_10_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.equals = function(l_11_0, l_11_1, l_11_2)
	local l_11_7, l_11_8, l_11_9 = nil
	if not l_11_2 then
		l_11_2 = function(l_12_0, l_12_1)
		return l_12_0 == l_12_1
  end
	end
	for i_0,i_1 in pairs(l_11_0) do
		local l_11_4 = 0
		l_11_4 = l_11_4 + 1
		if l_11_2(i_1, l_11_1[i_0]) == false then
			return false
		end
	end
	return l_11_4 == table.size(l_11_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.contains = function(l_12_0, l_12_1)
	local l_12_5, l_12_6 = nil
	for i_0,i_1 in ipairs(l_12_0) do
		if i_1 == l_12_1 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.index_of = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7 = nil
	for i_0,i_1 in ipairs(l_13_0) do
		if i_1 == l_13_1 then
			return i_0
		end
	end
	return -1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.get_key = function(l_14_0, l_14_1)
	local l_14_5, l_14_6, l_14_7 = nil
	for i_0,i_1 in pairs(l_14_0) do
		if i_1 == l_14_1 then
			return i_0
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.has = function(l_15_0, l_15_1)
	local l_15_5 = nil
	for i_0,i_1 in pairs(l_15_0) do
		if i_0 == l_15_1 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.size = function(l_16_0)
	for i_0,i_1 in pairs(l_16_0) do
	end
	return 0 + 1
end

table.empty = function(l_17_0)
	return not next(l_17_0)
end

table.concat_map = function(l_18_0, l_18_1, l_18_2, l_18_3, l_18_4, l_18_5)
	local l_18_11, l_18_12, l_18_13, l_18_14, l_18_17, l_18_18 = nil
	do
	end
	local l_18_6 = 0
	if (not l_18_3 and l_18_4) or not l_18_5 then
		for i_0,i_1 in pairs(l_18_0) do
			local l_18_8 = function()
		-- upvalues: l_18_2
		return l_18_2
  end
			local l_18_20 = l_18_8
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_18_1 then
				do return end
			end
			do
				local l_18_22 = nil
				local l_18_21 = tostring(l_18_19)
				l_18_22 = l_18_21
			end
			l_18_8 = function(l_20_0, l_20_1)
				-- upvalues: l_18_3 , l_18_14 , l_18_13 , l_18_5 , l_18_4
				if l_20_0 == 1 then
					return l_18_3 .. l_18_14 .. l_18_3
				elseif l_20_1 then
					return l_18_13(l_20_0 - 1, false) .. l_18_5 .. l_18_3 .. l_18_14 .. l_18_3
				else
					return l_18_13(l_20_0 - 1, false) .. l_18_4 .. l_18_3 .. l_18_14 .. l_18_3
				end
      end
			l_18_6 = l_18_6 + 1
		end
		return l_18_8(l_18_6, true)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 13 
end

table.ordering = function(l_19_0)
	return function(l_20_0, l_20_1)
		-- upvalues: l_19_0
		local l_20_2 = table.get_vector_index(l_19_0, l_20_0)
		local l_20_3 = table.get_vector_index(l_19_0, l_20_1)
		if l_20_0 >= l_20_1 then
			return l_20_2 ~= nil or l_20_3 ~= nil
		end
		do return end
		if l_20_3 ~= nil then
			return not l_20_2 and not l_20_3
		end
		do return end
		return l_20_2 < l_20_3
  end
end

table.sorted_copy = function(l_20_0, l_20_1)
	local l_20_6, l_20_7, l_20_8, l_20_9 = nil
	local l_20_2 = {}
	for i_0,i_1 in ipairs(l_20_0) do
		table.insert(l_20_2, i_1)
	end
	table.sort(l_20_2, l_20_1)
	return l_20_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.find_value = function(l_21_0, l_21_1)
	local l_21_5, l_21_6, l_21_7, l_21_8 = nil
	for i_0,i_1 in ipairs(l_21_0) do
		if l_21_1(i_1) then
			return i_1
		end
	end
end

table.find_all_values = function(l_22_0, l_22_1)
	local l_22_6, l_22_7, l_22_8, l_22_9, l_22_10, l_22_11 = nil
	local l_22_2 = {}
	for i_0,i_1 in ipairs(l_22_0) do
		if l_22_1(i_1) then
			table.insert(l_22_2, i_1)
		end
	end
	return l_22_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.true_for_all = function(l_23_0, l_23_1)
	local l_23_5, l_23_6, l_23_7 = nil
	for i_0,i_1 in pairs(l_23_0) do
		if not l_23_1(i_1, i_0) then
			return false
		end
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.collect = function(l_24_0, l_24_1)
	local l_24_6, l_24_7, l_24_8, l_24_9 = nil
	local l_24_2 = {}
	for i_0,i_1 in pairs(l_24_0) do
		l_24_2[i_0] = l_24_1(i_1)
	end
	return l_24_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.inject = function(l_25_0, l_25_1, l_25_2)
	local l_25_7, l_25_8 = nil
	local l_25_3 = l_25_1
	for i_0,i_1 in ipairs(l_25_0) do
		l_25_3 = l_25_2(l_25_3, i_1)
	end
	return l_25_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.insert_sorted = function(l_26_0, l_26_1, l_26_2)
	if l_26_1 == nil then
		return 
	end
	if not l_26_2 then
		l_26_2 = function(l_27_0, l_27_1)
		return l_27_0 < l_27_1
  end
	end
	local l_26_3 = 1
	do
		while 1 do
			local l_26_4 = l_26_0[l_26_3]
			while l_26_4 and l_26_2(l_26_4, l_26_1) do
				l_26_3 = l_26_3 + 1
				l_26_4 = l_26_0[l_26_3]
			end
			table.insert(l_26_0, l_26_3, l_26_1)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

table.for_each_value = function(l_27_0, l_27_1)
	local l_27_5, l_27_6, l_27_7, l_27_8 = nil
	for i_0,i_1 in ipairs(l_27_0) do
		l_27_1(i_1)
	end
end

table.range = function(l_28_0, l_28_1)
	local l_28_2 = {}
	for l_28_6 = l_28_0, l_28_1 do
		table.insert(l_28_2, l_28_6)
	end
	return l_28_2
end

table.unpack_sparse = function(l_29_0)
	local l_29_5 = nil
	if not table.__unpack_sparse_implementations then
		table.__unpack_sparse_implementations = {}
	end
	local l_29_1 = 0
	for i_0,i_1 in pairs(l_29_0) do
		l_29_1 = math.max(l_29_1, i_0)
	end
	if table.__unpack_sparse_implementations[l_29_1] == nil then
		local l_29_6, l_29_7 = "return function( __list__ ) return " .. table.concat(table.collect(table.range(1, l_29_1), function(l_30_0)
		return "__list__[" .. l_30_0 .. "]"
  end), ", ") .. " end"
		l_29_7 = assert
		local l_29_9, l_29_10, l_29_11 = loadstring(l_29_6), .end
		l_29_7 = l_29_7(l_29_9, l_29_10, l_29_11)
		l_29_7 = l_29_7()
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_29_8 = nil
		l_29_7[l_29_1] = l_29_7
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_29_7(l_29_0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.unpack_map = function(l_30_0)
	local l_30_1 = unpack
	local l_30_2, l_30_3 = table.map_to_list(l_30_0), .end
	return l_30_1(l_30_2, l_30_3)
end

table.map_to_list = function(l_31_0)
	local l_31_5, l_31_6, l_31_7, l_31_8, l_31_9, l_31_10, l_31_11 = nil
	local l_31_1 = {}
	for i_0,i_1 in pairs(l_31_0) do
		table.insert(l_31_1, i_0)
		table.insert(l_31_1, i_1)
	end
	return l_31_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.map_keys = function(l_32_0, l_32_1)
	local l_32_6, l_32_7, l_32_8 = nil
	local l_32_2 = {}
	for i_0,i_1 in pairs(l_32_0) do
		table.insert(l_32_2, i_0)
	end
	table.sort(l_32_2, l_32_1)
	return l_32_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.map_values = function(l_33_0, l_33_1)
	local l_33_6, l_33_7, l_33_8, l_33_9 = nil
	local l_33_2 = {}
	for i_0,i_1 in pairs(l_33_0) do
		table.insert(l_33_2, i_1)
	end
	if l_33_1 ~= nil then
		table.sort(l_33_2, l_33_1)
	end
	return l_33_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.remap = function(l_34_0, l_34_1)
	local l_34_6, l_34_7, l_34_8, l_34_9, l_34_10 = nil
	local l_34_2 = {}
	for i_0,i_1 in pairs(l_34_0) do
		result_k = l_34_1(i_0, i_1)
		l_34_2[result_k] = result_v
	end
	return l_34_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.list_add = function(...)
	local l_35_4, l_35_5, l_35_9, l_35_10 = {}, ipairs, {}, ...
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	for i_0,i_1 in l_35_5 do
		local l_35_3 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in l_35_3 do
			table.insert(l_35_4, i_1)
		end
	end
	return l_35_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

table.list_union = function(...)
	local l_36_4, l_36_5, l_36_9, l_36_10 = {}, ipairs, {}, ...
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	for i_0,i_1 in l_36_5 do
		local l_36_3 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in l_36_3 do
		end
	end
	for i_0,i_1 in pairs(l_36_4) do
		table.insert({}, i_0)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

table.print_data = function(l_37_0, l_37_1)
	local l_37_5, l_37_6, l_37_7, l_37_8, l_37_9, l_37_10, l_37_11, l_37_12, l_37_13, l_37_14, l_37_15, l_37_16, l_37_17, l_37_18, l_37_19, l_37_20, l_37_21, l_37_22 = nil
	if type(l_37_0) == "table" then
		if not l_37_1 then
			l_37_1 = ""
		end
		for i_0,i_1 in pairs(l_37_0) do
			if type(i_1) ~= "userdata" then
				CoreDebug.cat_debug("debug", l_37_1 .. tostring(i_0) .. "=" .. tostring(i_1))
			else
				CoreDebug.cat_debug("debug", l_37_1 .. tostring(i_0) .. "=" .. CoreClass.type_name(i_1))
			end
			if type(i_1) == "table" then
				table.print_data(i_1, l_37_1 .. "\t")
			end
		end
	else
		CoreDebug.cat_debug("debug", CoreClass.type_name(l_37_0), tostring(l_37_0))
	end
end

if Application:ews_enabled() then
	local l_0_0, l_0_1 = nil, nil
	do
		l_0_0 = function(l_38_0)
			local l_38_5, l_38_9 = nil
			local l_38_1 = type(l_38_0)
			if l_38_1 == "string" then
				local l_38_2 = string.format
				local l_38_3 = "%q"
				local l_38_4, l_38_8 = l_38_0
				return l_38_2(l_38_3, l_38_4)
			elseif l_38_1 == "number" or l_38_1 == "boolean" then
				local l_38_6 = tostring
				local l_38_7 = l_38_0
				return l_38_6(l_38_7)
			else
				error("Unable to generate Lua representation of type \"" .. l_38_1 .. "\".")
			end
    end
		l_0_1 = function(l_39_0, l_39_1, l_39_2)
			-- upvalues: l_0_0 , l_0_1
			local l_39_8, l_39_9, l_39_10 = nil
			if not l_39_2 then
				l_39_2 = 1
			end
			local l_39_3 = type(l_39_0)
			if l_39_3 == "table" then
				local l_39_4 = string.rep("\t", l_39_2)
				l_39_1:write("{\n")
				for i_0,i_1 in pairs(l_39_0) do
					assert(type(l_39_11) ~= "table", "Using a table for a key is unsupported.")
					l_39_1:write(l_39_4 .. "[" .. l_0_0(l_39_11) .. "] = ")
					l_0_1(i_1, l_39_1, l_39_2 + 1)
					l_39_1:write(";\n")
				end
				l_39_1:write(string.rep("\t", l_39_2 - 1) .. "}")
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			elseif l_39_3 == "string" or l_39_3 == "number" or l_39_3 == "boolean" then
				l_39_4(l_39_1, l_0_0(l_39_0))
			 -- DECOMPILER ERROR: Overwrote pending register.

			else
				l_39_4("Unable to generate Lua representation of type \"" .. l_39_3 .. "\".")
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
    end
		write_lua_representation_to_path = function(l_40_0, l_40_1)
			-- upvalues: l_0_1
			local l_40_2 = assert
			l_40_2(type(l_40_1) == "string", "Invalid path argument. Expected string.")
			l_40_2 = io
			l_40_2 = l_40_2.open
			l_40_2 = l_40_2(l_40_1, "w")
			l_40_2:write("return ")
			l_0_1(l_40_0, l_40_2)
			l_40_2:close()
    end
		read_lua_representation_from_path = function(l_41_0)
			local l_41_1 = assert
			l_41_1(type(l_41_0) == "string", "Invalid path argument. Expected string.")
			l_41_1 = io
			l_41_1 = l_41_1.open
			l_41_1 = l_41_1(l_41_0, "r")
			do
				if l_41_1 then
					l_41_1:close()
				end
				if not l_41_1:read("*a") or not loadstring(l_41_1:read("*a"))() then
					return {}
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
    end
	end
end

