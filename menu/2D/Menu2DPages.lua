if not Menu2DPages then
	Menu2DPages = class()
end
Menu2DPages.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._page_types = l_1_2
	l_1_0._root_panel = l_1_3
	l_1_0:_parse_pages(l_1_1)
end

Menu2DPages.post_init = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0._pages) do
		i_1:post_init()
	end
end

Menu2DPages._parse_pages = function(l_3_0, l_3_1)
	l_3_0._pages = {}
	local l_3_2 = (File:new_parse_xml(l_3_1))
	local l_3_3, l_3_4 = nil, nil
	for l_3_8 = 0, l_3_2:num_children() - 1 do
		l_3_3 = l_3_2:child(l_3_8)
		l_3_4 = l_3_3:parameter("name")
		print("parsing " .. l_3_4)
		assert(not l_3_0._pages[l_3_4], "Page name " .. l_3_4 .. " already defined")
		local l_3_9 = l_3_3:name()
		local l_3_10 = l_3_0._page_types[l_3_9]
		assert(l_3_10, "Unknown page type " .. l_3_9)
		l_3_0._pages[l_3_4] = l_3_10:new(l_3_3, l_3_0._root_panel)
	end
end

Menu2DPages.page = function(l_4_0, l_4_1)
	return l_4_0._pages[l_4_1]
end

Menu2DPages.resolution_changed = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7, l_5_8, l_5_9, l_5_10, l_5_11, l_5_12 = nil
	for i_0,i_1 in pairs(l_5_0._pages) do
		if i_1 and i_1.set_root_panel and l_5_1 then
			i_1:set_root_panel(l_5_1)
		end
	end
end


