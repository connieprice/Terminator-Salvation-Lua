if not Menu2DIsland then
	Menu2DIsland = class()
end
Menu2DIsland.init = function(l_1_0)
	l_1_0._page_stack = Stack:new()
	l_1_0._island_data = {}
end

Menu2DIsland.can_go_back = function(l_2_0)
	if l_2_0._page_stack:size() < 2 then
		return false
	end
	return true
end

Menu2DIsland.go_back = function(l_3_0)
	if not l_3_0:can_go_back() then
		return 
	end
	l_3_0._page_stack:pop()
	local l_3_1 = l_3_0._page_stack:pop()
	l_3_0:_change_page(l_3_1.page_name)
	l_3_0._movement_back = true
end

Menu2DIsland.change_page = function(l_4_0, l_4_1)
	l_4_0:_change_page(l_4_1)
	l_4_0._movement_back = false
end

Menu2DIsland._change_page = function(l_5_0, l_5_1)
	local l_5_2 = {}
	l_5_2.page_name = l_5_1
	l_5_0._page_stack:push(l_5_2)
end

Menu2DIsland.island_data = function(l_6_0)
	return l_6_0._island_data
end

Menu2DIsland.page_state = function(l_7_0)
	local l_7_1 = {}
	l_7_1.page_name = l_7_0._page_stack:top().page_name
	l_7_1.backwards = l_7_0._movement_back
	return l_7_1
end


