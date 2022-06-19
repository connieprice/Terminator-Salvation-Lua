core:module("CoreString")
function string.begins(A0_0, A1_1)
	if A0_0 and A1_1 then
		return A0_0:sub(1, #A1_1) == A1_1
	end
	return false
end
function string.ends(A0_2, A1_3)
	if A0_2 and A1_3 then
		return #A1_3 == 0 or A0_2:sub(-#A1_3) == A1_3
	end
	return false
end
function string.case_insensitive_compare(A0_4, A1_5)
	return string.lower(A0_4) < string.lower(A1_5)
end
function string.split(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11, L6_12, L7_13
	L4_10 = {}
	L5_11 = "(.-)"
	L6_12 = A1_7
	L7_13 = "()"
	L5_11 = L5_11 .. L6_12 .. L7_13
	L6_12 = 0
	L7_13 = 0
	for 