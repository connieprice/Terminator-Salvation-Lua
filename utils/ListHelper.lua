if not ListHelper then
	ListHelper = class()
end
ListHelper.concat_lists = function(l_1_0, l_1_1)
	local l_1_6, l_1_7, l_1_8, l_1_9, l_1_10, l_1_11, l_1_12, l_1_13 = nil
	local l_1_2 = {}
	for i_0,i_1 in ipairs(l_1_0) do
		table.insert(l_1_2, i_1)
	end
	for i_0,i_1 in ipairs(l_1_1) do
		table.insert(l_1_2, i_1)
	end
	return l_1_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


