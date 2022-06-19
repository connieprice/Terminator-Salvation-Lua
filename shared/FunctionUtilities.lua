if not FunctionUtilities then
	FunctionUtilities = {}
end
FunctionUtilities.make_segmented_linear_function = function(l_1_0)
	return function(l_2_0)
		-- upvalues: l_1_0
		local l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14 = nil
		local l_2_1 = l_1_0
		local l_2_2, l_2_3 = nil, nil
		local l_2_4 = assert
		l_2_4(l_2_1[1][1] <= l_2_0, "x out of range!")
		l_2_4 = ipairs
		l_2_4 = l_2_4(l_2_1)
		for i_0,i_1 in l_2_4 do
			local l_2_17 = i_1[1]
			assert(not l_2_3 or l_2_2 < l_2_17)
			if l_2_3 and l_2_0 <= l_2_17 then
				local l_2_20 = i_1[2]
				local l_2_21 = (l_2_0 - l_2_2) / (l_2_17 - l_2_2)
				local l_2_22 = math.lerp
				local l_2_23 = l_2_3
				return l_2_22(l_2_23, l_2_20, l_2_21)
			end
			l_2_2 = l_2_17
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_2_3 = l_2_20
		end
		assert(false, "x out of range!")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end


