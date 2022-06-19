core:module("CoreKeywordArguments")
core:require_module("CoreClass")
function parse_kwargs(A0_0, ...)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12
	L2_2 = assert
	L3_3 = #A0_0
	L3_3 = L3_3 == 1
	L2_2(L3_3)
	L2_2 = assert
	L3_3 = type
	L3_3 = L3_3(L4_4)
	L3_3 = L3_3 == "table"
	L2_2(L3_3)
	L2_2 = A0_0[1]
	L3_3 = {}
	L12_12 = ...
	;({
		[8] = ...
	})[1] = L6_6
	;({
		[8] = ...
	})[2] = L7_7
	;({
		[8] = ...
	})[3] = L8_8
	;({
		[8] = ...
	})[4] = L9_9
	;({
		[8] = ...
	})[5] = L10_10
	;({
		[8] = ...
	})[6] = L11_11
	;({
		[8] = ...
	})[7] = L12_12
	for L7_7, L8_8 in L4_4(L5_5) do
		L9_9 = string
		L9_9 = L9_9.find
		L10_10 = L8_8
		L11_11 = ":"
		L9_9 = L9_9(L10_10, L11_11)
		L10_10 = string
		L10_10 = L10_10.sub
		L11_11 = L8_8
		L12_12 = 1
		L10_10 = L10_10(L11_11, L12_12, L9_9 - 1)
		L11_11 = string
		L11_11 = L11_11.sub
		L12_12 = L8_8
		L11_11 = L11_11(L12_12, L9_9 + 1)
		L12_12 = L2_2[L11_11]
		assert(type(L12_12) == L10_10, string.format("For value='%s' wanted type is '%s', received '%s'", L11_11, L10_10, type(L12_12)))
		table.insert(L3_3, L12_12)
		L2_2[L11_11] = nil
	end
	for L7_7, L8_8 in L4_4(L5_5) do
		L9_9 = assert
		L10_10 = L7_7
		L9_9(L10_10)
	end
	return L4_4(L5_5)
end
KeywordArguments = KeywordArguments or CoreClass.class()
function KeywordArguments.init(A0_13, ...)
	local L2_15
	L2_15 = {
		...
	}
	assert(#L2_15 == 1, "must be called with one argument only (a table with keyword arguments)")
	assert(type(L2_15[1]) == "table", "must be called with table as first argument")
	A0_13._kwargs = L2_15[1]
	A0_13._unconsumed_kwargs = {}
	for 