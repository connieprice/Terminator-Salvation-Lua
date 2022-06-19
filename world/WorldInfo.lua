if not WorldInfo then
	WorldInfo = class()
end
WorldInfo.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	assert(l_1_3)
	l_1_0.id = l_1_1
	l_1_0.name = l_1_2
	l_1_0.chapter_id = l_1_3
end

WorldInfo.get_localized_chapter_names = function(l_2_0)
	local l_2_1 = l_2_0.id
	for l_2_5 = l_2_1, 1, -1 do
		local l_2_6 = Localizer:lookup("chapter_line_" .. tostring(l_2_5))
		local l_2_7 = Localizer:lookup("chapter_head_" .. tostring(l_2_5))
		if l_2_7 and l_2_7 ~= "" then
			assert(l_2_6)
			return l_2_7, l_2_6
		end
	end
end


