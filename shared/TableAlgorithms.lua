TableAlgorithms = {}
TableAlgorithms.is_empty = function(l_1_0)
	for i_0,i_1 in pairs(l_1_0) do
		return false
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.count = function(l_2_0)
	for i_0,i_1 in pairs(l_2_0) do
	end
	return 0 + 1
end

TableAlgorithms.count_from = function(l_3_0, l_3_1)
	while 1 do
		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_1 then
		end
	end
	return 0 + 1
end

TableAlgorithms.count_to = function(l_4_0, l_4_1)
	local l_4_6 = nil
	for i_0,i_1 in pairs(l_4_0) do
		local l_4_3 = 0
		l_4_3 = l_4_3 + 1
		end
		if i_0 == l_4_1 then
			do return end
		end
	end
	return l_4_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.count_if = function(l_5_0, l_5_1)
	local l_5_6, l_5_7 = nil
	local l_5_2 = 0
	for i_0,i_1 in pairs(l_5_0) do
		if l_5_1(i_1) then
			l_5_2 = l_5_2 + 1
		end
	end
	return l_5_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.find_value = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7 = nil
	for i_0,i_1 in pairs(l_6_1) do
		if l_6_0 == i_1 then
			return i_0
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.merge = function(l_7_0, l_7_1)
	local l_7_5, l_7_6 = nil
	for i_0,i_1 in pairs(l_7_1) do
		l_7_0[i_0] = i_1
	end
end

TableAlgorithms.recursive_merge = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14, l_8_15, l_8_16 = nil
	for i_0,i_1 in pairs(l_8_1) do
		if type(i_1) == "table" then
			if not l_8_0[i_0] then
				l_8_0[i_0] = {}
			end
			TableAlgorithms.recursive_merge(l_8_0[i_0], i_1)
		else
			l_8_0[i_0] = i_1
		end
	end
end

TableAlgorithms.append = function(l_9_0, l_9_1)
	local l_9_5, l_9_6, l_9_7, l_9_8 = nil
	for i_0,i_1 in pairs(l_9_1) do
		table.insert(l_9_0, i_1)
	end
end

TableAlgorithms.merge_except_functions = function(l_10_0, l_10_1)
	local l_10_5, l_10_6, l_10_7, l_10_8, l_10_9, l_10_10 = nil
	if not l_10_1 then
		return 
	end
	for i_0,i_1 in pairs(l_10_1) do
		if type(i_1) ~= "function" and type(i_1) ~= "userdata" then
			l_10_0[i_0] = i_1
		end
	end
end

TableAlgorithms.copy = function(l_11_0)
	local l_11_5, l_11_6 = nil
	local l_11_1 = {}
	for i_0,i_1 in pairs(l_11_0) do
		l_11_1[i_0] = i_1
	end
	return l_11_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.recursive_copy = function(l_12_0)
	local l_12_5, l_12_6, l_12_7, l_12_8, l_12_9, l_12_10, l_12_11, l_12_12 = nil
	local l_12_1 = {}
	for i_0,i_1 in pairs(l_12_0) do
		if type(i_1) == "table" then
			l_12_1[i_0] = TableAlgorithms.recursive_copy(i_1)
		else
			l_12_1[i_0] = i_1
		end
	end
	return l_12_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.copy_if = function(l_13_0, l_13_1)
	local l_13_6, l_13_7, l_13_8, l_13_9 = nil
	local l_13_2 = {}
	for i_0,i_1 in pairs(l_13_0) do
		if l_13_1(i_1) then
			l_13_2[i_0] = i_1
		end
	end
	return l_13_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.copy_if_key = function(l_14_0, l_14_1)
	local l_14_6, l_14_7, l_14_8, l_14_9, l_14_10 = nil
	local l_14_2 = {}
	for i_0,i_1 in pairs(l_14_0) do
		if l_14_1(i_0, i_1) then
			l_14_2[i_0] = i_1
		end
	end
	return l_14_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.remove = function(l_15_0, l_15_1)
	TableAlgorithms.remove_if(l_15_0, function(l_16_0)
		-- upvalues: l_15_1
		return l_15_1 == l_16_0
  end)
end

TableAlgorithms.remove_if = function(l_16_0, l_16_1)
	local l_16_2, l_16_3 = nil, nil
	l_16_2 = next(l_16_0, l_16_2)
	while 1 do
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_16_2 and l_16_1(l_16_3) then
			l_16_0[l_16_2] = nil
		end
	end
end

TableAlgorithms.remove_if_key = function(l_17_0, l_17_1)
	local l_17_2, l_17_3 = nil, nil
	l_17_2 = next(l_17_0, l_17_2)
	while 1 do
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_17_2 and l_17_1(l_17_2) then
		end
	end
	 -- WARNING: undefined locals caused missing assignments!
end

TableAlgorithms.indexed_remove_if = function(l_18_0, l_18_1)
	do
		while 1 do
			local l_18_2 = 1
			while 1 do
				while l_18_2 <= #l_18_0 do
					if l_18_1(l_18_0[l_18_2]) then
						table.remove(l_18_0, l_18_2)
					end
					l_18_2 = l_18_2 + 1
				end
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

TableAlgorithms.is_equal = function(l_19_0, l_19_1)
	if TableAlgorithms.is_subset(l_19_0, l_19_1) then
		return TableAlgorithms.is_subset(l_19_1, l_19_0)
	end
end

TableAlgorithms.is_subset = function(l_20_0, l_20_1)
	local l_20_5, l_20_6, l_20_7 = nil
	for i_0,i_1 in pairs(l_20_1) do
		if l_20_0[i_0] ~= i_1 then
			return false
		end
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.value_at_offset = function(l_21_0, l_21_1)
	local l_21_6, l_21_7 = nil
	local l_21_2 = 1
	for i_0,i_1 in pairs(l_21_0) do
		if l_21_2 == l_21_1 then
			return i_1
		end
		l_21_2 = l_21_2 + 1
	end
end

TableAlgorithms.max_index = function(l_22_0)
	local l_22_5, l_22_6, l_22_7 = nil
	local l_22_1 = 0
	for i_0,i_1 in pairs(l_22_0) do
		assert(type(l_22_8) == "number")
		if l_22_1 < l_22_8 then
			l_22_1 = l_22_8
		end
	end
	return l_22_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TableAlgorithms.restore_indices = function(l_23_0)
	local l_23_1 = {}
	local l_23_2 = TableAlgorithms.max_index(l_23_0)
	for l_23_6 = 1, l_23_2 do
		local l_23_7 = l_23_0[l_23_6]
		if l_23_7 then
			table.insert(l_23_1, l_23_7)
		end
	end
	return l_23_1
end

TableAlgorithms.shuffle = function(l_24_0)
	do
		while 1 do
			local l_24_1 = #l_24_0
			while l_24_1 > 1 do
				local l_24_2 = math.random(1, l_24_1)
				l_24_1 = l_24_1 - 1
				local l_24_3 = l_24_0[l_24_1]
				l_24_0[l_24_1] = l_24_0[l_24_2]
				l_24_0[l_24_2] = l_24_3
			end
			return l_24_0
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


