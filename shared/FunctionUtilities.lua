local L0_0
L0_0 = FunctionUtilities
L0_0 = L0_0 or {}
FunctionUtilities = L0_0
L0_0 = FunctionUtilities
function L0_0.make_segmented_linear_function(A0_1)
	local L1_2
	function L1_2(A0_3)
		local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14
		L1_4 = _UPVALUE0_
		L2_5, L3_6 = nil, nil
		L5_8 = A0_3 >= L5_8
		L4_7(L5_8, L6_9)
		for L7_10, L8_11 in L4_7(L5_8) do
			L9_12 = L8_11[1]
			L10_13 = L8_11[2]
			L11_14 = assert
			L11_14(not L3_6 or L2_5 < L9_12)
			if L3_6 and A0_3 <= L9_12 then
				L11_14 = A0_3 - L2_5
				L11_14 = L11_14 / (L9_12 - L2_5)
				return math.lerp(L3_6, L10_13, L11_14)
			end
			L2_5 = L9_12
			L3_6 = L10_13
		end
		L4_7(L5_8, L6_9)
	end
	return L1_2
end
