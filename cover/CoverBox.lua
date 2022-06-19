CoverBox = CoverBox or class()
function CoverBox.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12
	L4_4 = {}
	A0_0._cover_planes = L4_4
	L5_5 = A2_2
	L4_4 = A2_2.x
	L4_4 = L4_4(L5_5)
	L6_6 = A2_2
	L5_5 = A2_2.y
	L5_5 = L5_5(L6_6)
	L7_7 = A2_2
	L6_6 = A2_2.z
	L6_6 = L6_6(L7_7)
	L7_7 = A3_3.x
	L8_8 = A3_3.y
	L9_9 = A3_3.z
	L10_10 = math
	L10_10 = L10_10.dot
	L11_11 = L6_6
	L12_12 = math
	L12_12 = L12_12.UP
	L10_10 = L10_10(L11_11, L12_12)
	L11_11 = 0.95
	L12_12 = math
	L12_12 = L12_12.dot
	L12_12 = L12_12(L4_4, math.UP)
	if L11_11 <= L12_12 then
		L12_12 = Application
		L12_12 = L12_12.error
		L12_12(L12_12, "Not implemented yet")
	else
		L12_12 = math
		L12_12 = L12_12.dot
		L12_12 = L12_12(L5_5, math.UP)
		if L11_11 <= L12_12 then
			L12_12 = Application
			L12_12 = L12_12.error
			L12_12(L12_12, "Not implemented yet")
		else
			L12_12 = math
			L12_12 = L12_12.dot
			L12_12 = L12_12(L6_6, math.UP)
			if L11_11 <= L12_12 then
				L12_12 = L8_8 * 2
				if L12_12 >= tweak_data.cover.MIN_COVER_WIDTH then
					L12_12 = CoverPlane
					L12_12 = L12_12.new
					L12_12 = L12_12(L12_12, A1_1 + L4_4 * L7_7, L4_4, L8_8 * 2, L9_9 * 2)
				end
				L12_12 = L7_7 * 2
				if L12_12 >= tweak_data.cover.MIN_COVER_WIDTH then
					L12_12 = CoverPlane
					L12_12 = L12_12.new
					L12_12 = L12_12(L12_12, A1_1 + L5_5 * L8_8, L5_5, L7_7 * 2, L9_9 * 2)
					table.insert(A0_0._cover_planes, L12_12)
				end
			else
				L12_12 = Application
				L12_12 = L12_12.error
				L12_12(L12_12, "Not implemented yet")
			end
		end
	end
end
function CoverBox.get_covers(A0_13)
	local L1_14
	L1_14 = A0_13._cover_planes
	return L1_14
end
function CoverBox.register(A0_15, A1_16, A2_17)
	local L3_18, L4_19, L5_20, L6_21, L7_22
	for L6_21, L7_22 in L3_18(L4_19) do
		A1_16:register_cover(L7_22, A2_17)
	end
end
function CoverBox.unregister(A0_23, A1_24)
	local L2_25, L3_26, L4_27, L5_28, L6_29
	for L5_28, L6_29 in L2_25(L3_26) do
		A1_24:unregister_cover(L6_29)
	end
end
