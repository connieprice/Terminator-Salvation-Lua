local L0_0, L1_1
L0_0 = {}
ArrayAlgorithms = L0_0
L0_0 = ArrayAlgorithms
function L1_1(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8
	for L5_7, L6_8 in L2_4(L3_5) do
		table.insert(A0_2, L6_8)
	end
end
L0_0.insert = L1_1
L0_0 = ArrayAlgorithms
function L1_1(A0_9, A1_10)
	local L2_11, L3_12, L4_13, L5_14, L6_15, L7_16
	L2_11 = {}
	for L6_15, L7_16 in L3_12(L4_13) do
		table.insert(L2_11, L7_16)
	end
	for L6_15, L7_16 in L3_12(L4_13) do
		table.insert(L2_11, L7_16)
	end
	return L2_11
end
L0_0.concatenate = L1_1
L0_0 = ArrayAlgorithms
function L1_1(A0_17, A1_18)
	local L2_19
	L2_19 = #A0_17
	assert(A1_18 <= L2_19)
	for _FORV_6_ = A1_18, L2_19 do
		A0_17[_FORV_6_] = nil
	end
end
L0_0.erase_from_index = L1_1
L0_0 = ArrayAlgorithms
function L1_1(A0_20, A1_21)
	local L2_22, L3_23, L4_24, L5_25, L6_26
	for L5_25, L6_26 in L2_22(L3_23) do
		if A1_21(L6_26) then
			return L5_25
		end
	end
end
L0_0.find_first_match = L1_1
L0_0 = ArrayAlgorithms
function L1_1(A0_27, A1_28)
	local L2_29
	L2_29 = A0_27 < A1_28
	return L2_29
end
L0_0.insert_sorted_comparator_func_default = L1_1
L0_0 = ArrayAlgorithms
function L1_1(A0_30, A1_31, A2_32)
	local L3_33, L4_34, L5_35, L6_36, L7_37
	if not A2_32 then
		L3_33 = ArrayAlgorithms
		A2_32 = L3_33.insert_sorted_comparator_func_default
	end
	L3_33 = 1
	L4_34 = #A0_30
	L5_35 = 1
	L6_36 = 0
	while L3_33 <= L4_34 do
		L7_37 = math
		L7_37 = L7_37.floor
		L7_37 = L7_37((L3_33 + L4_34) / 2)
		L5_35 = L7_37
		L7_37 = A2_32
		L7_37 = L7_37(A1_31, A0_30[L5_35])
		if L7_37 then
			L7_37 = L5_35 - 1
			L6_36 = 0
			L4_34 = L7_37
		else
			L7_37 = L5_35 + 1
			L6_36 = 1
			L3_33 = L7_37
		end
	end
	L7_37 = L5_35 + L6_36
	table.insert(A0_30, L7_37, A1_31)
	return L7_37
end
L0_0.insert_sorted = L1_1
