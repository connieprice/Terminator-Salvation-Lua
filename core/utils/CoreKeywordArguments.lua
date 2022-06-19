core:module("CoreKeywordArguments")
core:require_module("CoreClass")
parse_kwargs = function(l_1_0, ...)
	assert(#l_1_0 == 1)
	assert(type(l_1_0[1]) == "table")
	local l_1_6 = l_1_0[1]
	local l_1_10, l_1_11 = {}, ipairs
	l_1_11 = l_1_11({...})
	for i_0,i_1 in l_1_11 do
		local l_1_13 = nil
		local l_1_14, l_1_21 = string.sub(l_1_12, 1, string.find(i_1, ":") - 1), string.sub(l_1_12, l_1_13 + 1)
		local l_1_15, l_1_22 = l_1_6[l_1_21]
		l_1_22 = assert
		local l_1_16, l_1_23 = nil
		l_1_16 = type
		l_1_23 = l_1_15
		l_1_16 = l_1_16(l_1_23)
		l_1_16 = l_1_16 == l_1_14
		l_1_23 = string
		l_1_23 = l_1_23.format
		local l_1_26, l_1_27, l_1_28, l_1_29, l_1_30 = .end
		l_1_22(l_1_16, l_1_23, l_1_26, l_1_27, l_1_28, l_1_29, l_1_30)
		l_1_22 = table
		l_1_22 = l_1_22.insert
		l_1_16 = l_1_10
		local l_1_24 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_1_25 = nil
		l_1_22(l_1_16, l_1_23)
		l_1_6[l_1_21] = nil
	end
	for i_0,i_1 in pairs(l_1_6) do
		local l_1_20 = assert
		l_1_20(i_0)
	end
	return unpack(l_1_10)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not KeywordArguments then
	KeywordArguments = CoreClass.class()
end
KeywordArguments.init = function(l_2_0, ...)
	local l_2_9, l_2_10 = {}, ...
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_2_2 = .end
	l_2_2 = #l_2_9
	l_2_2 = l_2_2 == 1
	l_2_10(l_2_2, "must be called with one argument only (a table with keyword arguments)")
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_2 = type
	l_2_2 = l_2_2(l_2_9[1])
	l_2_2 = l_2_2 == "table"
	l_2_10(l_2_2, "must be called with table as first argument")
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._kwargs = l_2_10
	l_2_0._unconsumed_kwargs, l_2_10 = l_2_10, {}
	l_2_10 = pairs
	l_2_2 = l_2_0._kwargs
	l_2_10 = l_2_10(l_2_2)
	for i_0,i_1 in l_2_10 do
		l_2_0._unconsumed_kwargs[l_2_8] = l_2_8
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.assert_all_consumed = function(l_3_0)
	local l_3_1 = assert
	l_3_1(table.size(l_3_0._unconsumed_kwargs) == 0, "unknown keyword argument(s): " .. string.join(", ", l_3_0._unconsumed_kwargs))
end

KeywordArguments.mandatory = function(l_4_0, ...)
	local l_4_5, l_4_6 = {}, ipairs
	l_4_6 = l_4_6({...})
	for i_0,i_1 in l_4_6 do
		local l_4_11 = l_4_0._kwargs[i_1]
		local l_4_8, l_4_12 = assert
		l_4_12 = l_4_11 ~= nil
		local l_4_15 = "a mandatory keyword argument ("
		local l_4_16 = l_4_7
		l_4_15 = l_4_15 .. l_4_16 .. ") is missing"
		l_4_8(l_4_12, l_4_15)
		l_4_8 = table
		l_4_8 = l_4_8.insert
		l_4_12 = l_4_5
		local l_4_13 = nil
		l_4_15 = l_4_11
		local l_4_14 = nil
		l_4_8(l_4_12, l_4_15)
		l_4_8 = l_4_0._unconsumed_kwargs
		l_4_8[l_4_7] = nil
	end
	return unpack(l_4_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.mandatory_string = function(l_5_0, ...)
	local l_5_5, l_5_6 = {}, ipairs
	l_5_6 = l_5_6({...})
	for i_0,i_1 in l_5_6 do
		local l_5_13 = l_5_0._kwargs[i_1]
		local l_5_8, l_5_14 = assert
		l_5_14 = l_5_13 ~= nil
		l_5_8(l_5_14, "a mandatory keyword argument (" .. l_5_7 .. ") is missing")
		l_5_8 = assert
		l_5_14 = type
		l_5_14 = l_5_14(l_5_13)
		l_5_14 = l_5_14 == "string"
		local l_5_17 = "keyword argument is not a string ("
		local l_5_18 = l_5_7
		local l_5_19 = "="
		local l_5_20 = tostring(l_5_13)
		l_5_17 = l_5_17 .. l_5_18 .. l_5_19 .. l_5_20 .. ")"
		l_5_8(l_5_14, l_5_17)
		l_5_8 = table
		l_5_8 = l_5_8.insert
		l_5_14 = l_5_5
		local l_5_15 = nil
		l_5_17 = l_5_13
		local l_5_16 = nil
		l_5_8(l_5_14, l_5_17)
		l_5_8 = l_5_0._unconsumed_kwargs
		l_5_8[l_5_7] = nil
	end
	return unpack(l_5_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.mandatory_number = function(l_6_0, ...)
	local l_6_5, l_6_6 = {}, ipairs
	l_6_6 = l_6_6({...})
	for i_0,i_1 in l_6_6 do
		local l_6_13 = l_6_0._kwargs[i_1]
		local l_6_8, l_6_14 = assert
		l_6_14 = l_6_13 ~= nil
		l_6_8(l_6_14, "a mandatory keyword argument (" .. l_6_7 .. ") is missing")
		l_6_8 = assert
		l_6_14 = type
		l_6_14 = l_6_14(l_6_13)
		l_6_14 = l_6_14 == "number"
		local l_6_17 = "keyword argument is not a number ("
		local l_6_18 = l_6_7
		local l_6_19 = "="
		local l_6_20 = tostring(l_6_13)
		l_6_17 = l_6_17 .. l_6_18 .. l_6_19 .. l_6_20 .. ")"
		l_6_8(l_6_14, l_6_17)
		l_6_8 = table
		l_6_8 = l_6_8.insert
		l_6_14 = l_6_5
		local l_6_15 = nil
		l_6_17 = l_6_13
		local l_6_16 = nil
		l_6_8(l_6_14, l_6_17)
		l_6_8 = l_6_0._unconsumed_kwargs
		l_6_8[l_6_7] = nil
	end
	return unpack(l_6_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.mandatory_table = function(l_7_0, ...)
	local l_7_5, l_7_6 = {}, ipairs
	l_7_6 = l_7_6({...})
	for i_0,i_1 in l_7_6 do
		local l_7_13 = l_7_0._kwargs[i_1]
		local l_7_8, l_7_14 = assert
		l_7_14 = l_7_13 ~= nil
		l_7_8(l_7_14, "a mandatory keyword argument (" .. l_7_7 .. ") is missing")
		l_7_8 = assert
		l_7_14 = type
		l_7_14 = l_7_14(l_7_13)
		l_7_14 = l_7_14 == "table"
		local l_7_17 = "keyword argument is not a table ("
		local l_7_18 = l_7_7
		local l_7_19 = "="
		local l_7_20 = tostring(l_7_13)
		l_7_17 = l_7_17 .. l_7_18 .. l_7_19 .. l_7_20 .. ")"
		l_7_8(l_7_14, l_7_17)
		l_7_8 = table
		l_7_8 = l_7_8.insert
		l_7_14 = l_7_5
		local l_7_15 = nil
		l_7_17 = l_7_13
		local l_7_16 = nil
		l_7_8(l_7_14, l_7_17)
		l_7_8 = l_7_0._unconsumed_kwargs
		l_7_8[l_7_7] = nil
	end
	return unpack(l_7_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.mandatory_function = function(l_8_0, ...)
	local l_8_5, l_8_6 = {}, ipairs
	l_8_6 = l_8_6({...})
	for i_0,i_1 in l_8_6 do
		local l_8_13 = l_8_0._kwargs[i_1]
		local l_8_8, l_8_14 = assert
		l_8_14 = l_8_13 ~= nil
		l_8_8(l_8_14, "a mandatory keyword argument (" .. l_8_7 .. ") is missing")
		l_8_8 = assert
		l_8_14 = type
		l_8_14 = l_8_14(l_8_13)
		l_8_14 = l_8_14 == "function"
		local l_8_17 = "keyword argument is not a function ("
		local l_8_18 = l_8_7
		local l_8_19 = "="
		local l_8_20 = tostring(l_8_13)
		l_8_17 = l_8_17 .. l_8_18 .. l_8_19 .. l_8_20 .. ")"
		l_8_8(l_8_14, l_8_17)
		l_8_8 = table
		l_8_8 = l_8_8.insert
		l_8_14 = l_8_5
		local l_8_15 = nil
		l_8_17 = l_8_13
		local l_8_16 = nil
		l_8_8(l_8_14, l_8_17)
		l_8_8 = l_8_0._unconsumed_kwargs
		l_8_8[l_8_7] = nil
	end
	return unpack(l_8_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.mandatory_object = function(l_9_0, ...)
	local l_9_5, l_9_6 = {}, ipairs
	l_9_6 = l_9_6({...})
	for i_0,i_1 in l_9_6 do
		local l_9_13 = l_9_0._kwargs[i_1]
		local l_9_8, l_9_14 = assert
		l_9_14 = l_9_13 ~= nil
		l_9_8(l_9_14, "a mandatory keyword argument (" .. l_9_7 .. ") is missing")
		l_9_8 = assert
		l_9_14 = type
		l_9_14 = l_9_14(l_9_13)
		if l_9_14 ~= "table" then
			l_9_14 = type
			l_9_14 = l_9_14(l_9_13)
		end
		l_9_14 = l_9_14 == "userdata"
		local l_9_17 = "keyword argument is not a table or userdata ("
		local l_9_18 = l_9_7
		local l_9_19 = "="
		local l_9_20 = tostring(l_9_13)
		l_9_17 = l_9_17 .. l_9_18 .. l_9_19 .. l_9_20 .. ")"
		l_9_8(l_9_14, l_9_17)
		l_9_8 = table
		l_9_8 = l_9_8.insert
		l_9_14 = l_9_5
		local l_9_15 = nil
		l_9_17 = l_9_13
		local l_9_16 = nil
		l_9_8(l_9_14, l_9_17)
		l_9_8 = l_9_0._unconsumed_kwargs
		l_9_8[l_9_7] = nil
	end
	return unpack(l_9_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.optional = function(l_10_0, ...)
	local l_10_5, l_10_6 = {}, ipairs
	l_10_6 = l_10_6({...})
	for i_0,i_1 in l_10_6 do
		local l_10_9 = table.insert
		l_10_9(l_10_5, l_10_0._kwargs[l_10_8])
		l_10_9 = l_10_0._unconsumed_kwargs
		local l_10_7 = nil
		l_10_9[l_10_8] = nil
	end
	return unpack(l_10_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.optional_string = function(l_11_0, ...)
	local l_11_5, l_11_6 = {}, ipairs
	l_11_6 = l_11_6({...})
	for i_0,i_1 in l_11_6 do
		local l_11_11 = l_11_0._kwargs[i_1]
		local l_11_8, l_11_12 = assert
		if l_11_11 ~= nil then
			l_11_12 = type
			l_11_12 = l_11_12(l_11_11)
		end
		l_11_12 = l_11_12 == "string"
		local l_11_15 = "keyword argument is not a string ("
		local l_11_16 = l_11_7
		local l_11_17 = "="
		local l_11_18 = tostring(l_11_11)
		l_11_15 = l_11_15 .. l_11_16 .. l_11_17 .. l_11_18 .. ")"
		l_11_8(l_11_12, l_11_15)
		l_11_8 = table
		l_11_8 = l_11_8.insert
		l_11_12 = l_11_5
		local l_11_13 = nil
		l_11_15 = l_11_11
		local l_11_14 = nil
		l_11_8(l_11_12, l_11_15)
		l_11_8 = l_11_0._unconsumed_kwargs
		l_11_8[l_11_7] = nil
	end
	return unpack(l_11_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.optional_number = function(l_12_0, ...)
	local l_12_5, l_12_6 = {}, ipairs
	l_12_6 = l_12_6({...})
	for i_0,i_1 in l_12_6 do
		local l_12_11 = l_12_0._kwargs[i_1]
		local l_12_8, l_12_12 = assert
		if l_12_11 ~= nil then
			l_12_12 = type
			l_12_12 = l_12_12(l_12_11)
		end
		l_12_12 = l_12_12 == "number"
		local l_12_15 = "keyword argument is not a number ("
		local l_12_16 = l_12_7
		local l_12_17 = "="
		local l_12_18 = tostring(l_12_11)
		l_12_15 = l_12_15 .. l_12_16 .. l_12_17 .. l_12_18 .. ")"
		l_12_8(l_12_12, l_12_15)
		l_12_8 = table
		l_12_8 = l_12_8.insert
		l_12_12 = l_12_5
		local l_12_13 = nil
		l_12_15 = l_12_11
		local l_12_14 = nil
		l_12_8(l_12_12, l_12_15)
		l_12_8 = l_12_0._unconsumed_kwargs
		l_12_8[l_12_7] = nil
	end
	return unpack(l_12_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.optional_table = function(l_13_0, ...)
	local l_13_5, l_13_6 = {}, ipairs
	l_13_6 = l_13_6({...})
	for i_0,i_1 in l_13_6 do
		local l_13_11 = l_13_0._kwargs[i_1]
		local l_13_8, l_13_12 = assert
		if l_13_11 ~= nil then
			l_13_12 = type
			l_13_12 = l_13_12(l_13_11)
		end
		l_13_12 = l_13_12 == "table"
		local l_13_15 = "keyword argument is not a table or userdata ("
		local l_13_16 = l_13_7
		local l_13_17 = "="
		local l_13_18 = tostring(l_13_11)
		l_13_15 = l_13_15 .. l_13_16 .. l_13_17 .. l_13_18 .. ")"
		l_13_8(l_13_12, l_13_15)
		l_13_8 = table
		l_13_8 = l_13_8.insert
		l_13_12 = l_13_5
		local l_13_13 = nil
		l_13_15 = l_13_11
		local l_13_14 = nil
		l_13_8(l_13_12, l_13_15)
		l_13_8 = l_13_0._unconsumed_kwargs
		l_13_8[l_13_7] = nil
	end
	return unpack(l_13_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.optional_function = function(l_14_0, ...)
	local l_14_5, l_14_6 = {}, ipairs
	l_14_6 = l_14_6({...})
	for i_0,i_1 in l_14_6 do
		local l_14_11 = l_14_0._kwargs[i_1]
		local l_14_8, l_14_12 = assert
		if l_14_11 ~= nil then
			l_14_12 = type
			l_14_12 = l_14_12(l_14_11)
		end
		l_14_12 = l_14_12 == "function"
		local l_14_15 = "keyword argument is not a function ("
		local l_14_16 = l_14_7
		local l_14_17 = "="
		local l_14_18 = tostring(l_14_11)
		l_14_15 = l_14_15 .. l_14_16 .. l_14_17 .. l_14_18 .. ")"
		l_14_8(l_14_12, l_14_15)
		l_14_8 = table
		l_14_8 = l_14_8.insert
		l_14_12 = l_14_5
		local l_14_13 = nil
		l_14_15 = l_14_11
		local l_14_14 = nil
		l_14_8(l_14_12, l_14_15)
		l_14_8 = l_14_0._unconsumed_kwargs
		l_14_8[l_14_7] = nil
	end
	return unpack(l_14_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

KeywordArguments.optional_object = function(l_15_0, ...)
	local l_15_5, l_15_6 = {}, ipairs
	l_15_6 = l_15_6({...})
	for i_0,i_1 in l_15_6 do
		local l_15_11 = l_15_0._kwargs[i_1]
		local l_15_8, l_15_12 = assert
		if l_15_11 ~= nil then
			l_15_12 = type
			l_15_12 = l_15_12(l_15_11)
		if l_15_12 ~= "table" then
			end
			l_15_12 = type
			l_15_12 = l_15_12(l_15_11)
		end
		l_15_12 = l_15_12 == "userdata"
		local l_15_15 = "keyword argument is not a table or userdata ("
		local l_15_16 = l_15_7
		local l_15_17 = "="
		local l_15_18 = tostring(l_15_11)
		l_15_15 = l_15_15 .. l_15_16 .. l_15_17 .. l_15_18 .. ")"
		l_15_8(l_15_12, l_15_15)
		l_15_8 = table
		l_15_8 = l_15_8.insert
		l_15_12 = l_15_5
		local l_15_13 = nil
		l_15_15 = l_15_11
		local l_15_14 = nil
		l_15_8(l_15_12, l_15_15)
		l_15_8 = l_15_0._unconsumed_kwargs
		l_15_8[l_15_7] = nil
	end
	return unpack(l_15_5)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


