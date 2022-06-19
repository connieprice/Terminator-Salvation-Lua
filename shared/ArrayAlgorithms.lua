ArrayAlgorithms = {}
ArrayAlgorithms.insert = function(l_1_0, l_1_1)
	local l_1_5, l_1_6, l_1_7, l_1_8 = nil
	for i_0,i_1 in ipairs(l_1_1) do
		table.insert(l_1_0, i_1)
	end
end

ArrayAlgorithms.concatenate = function(l_2_0, l_2_1)
	local l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13 = nil
	local l_2_2 = {}
	for i_0,i_1 in ipairs(l_2_0) do
		table.insert(l_2_2, i_1)
	end
	for i_0,i_1 in ipairs(l_2_1) do
		table.insert(l_2_2, i_1)
	end
	return l_2_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ArrayAlgorithms.erase_from_index = function(l_3_0, l_3_1)
	local l_3_2 = #l_3_0
	local l_3_3 = assert
	l_3_3(l_3_1 <= l_3_2)
	l_3_3 = l_3_1
	for i = l_3_3, l_3_2 do
		l_3_0[l_3_8] = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ArrayAlgorithms.find_first_match = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7 = nil
	for i_0,i_1 in ipairs(l_4_0) do
		if l_4_1(i_1) then
			return i_0
		end
	end
end

ArrayAlgorithms.insert_sorted_comparator_func_default = function(l_5_0, l_5_1)
	return l_5_0 < l_5_1
end

ArrayAlgorithms.insert_sorted = function(l_6_0, l_6_1, l_6_2)
	if not l_6_2 then
		l_6_2 = ArrayAlgorithms.insert_sorted_comparator_func_default
	end
	local l_6_3 = 1
	local l_6_4 = #l_6_0
	local l_6_5 = 1
	while 1 do
		local l_6_6 = 0
		while 1 do
			while l_6_3 <= l_6_4 do
				l_6_5 = math.floor((l_6_3 + l_6_4) / 2)
				if l_6_2(l_6_1, l_6_0[l_6_5]) then
					l_6_4 = l_6_5 - 1
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_6_3 = l_6_5 + 1
			end
			do
				local l_6_7 = l_6_5 + l_6_6
				table.insert(l_6_0, l_6_7, l_6_1)
				return l_6_7
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end


