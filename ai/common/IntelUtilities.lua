IntelUtilities = IntelUtilities or class()
function IntelUtilities.find_targets(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15
	L3_3 = {}
	if not A1_1 then
		return L3_3
	end
	L4_4 = nil
	for L8_8, L9_9 in L5_5(L6_6) do
		L10_10 = L9_9.position
		if L10_10 then
			if L4_4 then
				L10_10 = L9_9.range
			elseif L4_4 < L10_10 then
				L4_4 = L9_9.range
			end
		end
	end
	if not L4_4 then
		return L3_3
	end
	L8_8 = "sphere"
	L9_9 = L5_5
	L10_10 = L4_4
	L11_11 = managers
	L11_11 = L11_11.slot
	L12_12 = L11_11
	L11_11 = L11_11.get_mask
	L13_13 = A2_2
	L15_15 = L11_11(L12_12, L13_13)
	L8_8, L9_9, L10_10, L11_11, L12_12 = nil, nil, nil, nil, nil
	L14_14 = A0_0
	L13_13 = A0_0.visibility_query
	L13_13 = L13_13(L14_14)
	L14_14 = IntelUtilities
	L15_15 = IntelUtilities
	L15_15 = L15_15.world_slot_mask
	if not L15_15 then
		L15_15 = managers
		L15_15 = L15_15.slot
		L15_15 = L15_15.get_mask
		L15_15 = L15_15(L15_15, "visibility_blockers")
	end
	L14_14.world_slot_mask = L15_15
	L14_14 = math
	L14_14 = L14_14.UP
	L15_15 = nil
	for 