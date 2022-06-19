local L0_0
L0_0 = DistanceMatrixCalculator
L0_0 = L0_0 or {}
DistanceMatrixCalculator = L0_0
L0_0 = DistanceMatrixCalculator
function L0_0.distance_matrix(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14
	L2_3 = #A0_1
	L3_4 = {}
	for L7_8 = 1, L2_3 do
		for L11_12 = L7_8 + 1, L2_3 do
			L12_13 = A0_1[L7_8]
			L13_14 = A0_1[L11_12]
			L3_4[L12_13] = L3_4[L12_13] or {}
			L3_4[L12_13][L13_14] = A1_2(L12_13, L13_14)
			L3_4[L13_14] = L3_4[L13_14] or {}
			L3_4[L13_14][L12_13] = A1_2(L12_13, L13_14)
		end
	end
	return L3_4
end
