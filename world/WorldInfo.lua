WorldInfo = WorldInfo or class()
function WorldInfo.init(A0_0, A1_1, A2_2, A3_3)
	assert(A3_3)
	A0_0.id = A1_1
	A0_0.name = A2_2
	A0_0.chapter_id = A3_3
end
function WorldInfo.get_localized_chapter_names(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9, L6_10, L7_11
	L1_5 = A0_4.id
	for L5_9 = L1_5, 1, -1 do
		L6_10 = Localizer
		L7_11 = L6_10
		L6_10 = L6_10.lookup
		L6_10 = L6_10(L7_11, "chapter_line_" .. tostring(L5_9))
		L7_11 = Localizer
		L7_11 = L7_11.lookup
		L7_11 = L7_11(L7_11, "chapter_head_" .. tostring(L5_9))
		if L7_11 and L7_11 ~= "" then
			assert(L6_10)
			return L7_11, L6_10
		end
	end
end
