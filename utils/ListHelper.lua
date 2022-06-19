ListHelper = ListHelper or class()
function ListHelper.concat_lists(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7
	L2_2 = {}
	for L6_6, L7_7 in L3_3(L4_4) do
		table.insert(L2_2, L7_7)
	end
	for L6_6, L7_7 in L3_3(L4_4) do
		table.insert(L2_2, L7_7)
	end
	return L2_2
end
