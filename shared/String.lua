local L0_0, L1_1
L0_0 = String
L0_0 = L0_0 or {}
String = L0_0
L0_0 = String
function L1_1(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7
	L2_4 = {}
	A1_3 = A1_3 or "[ ]"
	L3_5 = 1
	L4_6 = string
	L4_6 = L4_6.find
	L5_7 = A0_2
	L5_7 = L4_6(L5_7, A1_3, L3_5)
	while L4_6 do
		table.insert(L2_4, string.sub(A0_2, L3_5, L4_6 - 1))
		L3_5 = L5_7 + 1
		L4_6, L5_7 = string.find(A0_2, A1_3, L3_5)
	end
	table.insert(L2_4, string.sub(A0_2, L3_5))
	return L2_4
end
L0_0.split = L1_1
L0_0 = String
function L1_1(A0_8)
	local L1_9, L2_10, L3_11, L4_12, L5_13, L6_14
	L1_9 = ""
	for L5_13 = 1, #A0_8 do
		L6_14 = string
		L6_14 = L6_14.sub
		L6_14 = L6_14(A0_8, L5_13, L5_13)
		if string.byte(L6_14) > 31 then
			L1_9 = L1_9 .. L6_14
		end
	end
	return L1_9
end
L0_0.strip = L1_1
