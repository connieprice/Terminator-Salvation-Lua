Menu2DIsland = Menu2DIsland or class()
function Menu2DIsland.init(A0_0)
	A0_0._page_stack = Stack:new()
	A0_0._island_data = {}
end
function Menu2DIsland.can_go_back(A0_1)
	if A0_1._page_stack:size() < 2 then
		return false
	end
	return true
end
function Menu2DIsland.go_back(A0_2)
	if not A0_2:can_go_back() then
		return
	end
	A0_2._page_stack:pop()
	A0_2:_change_page(A0_2._page_stack:pop().page_name)
	A0_2._movement_back = true
end
function Menu2DIsland.change_page(A0_3, A1_4)
	A0_3:_change_page(A1_4)
	A0_3._movement_back = false
end
function Menu2DIsland._change_page(A0_5, A1_6)
	local L2_7
	L2_7 = {}
	L2_7.page_name = A1_6
	A0_5._page_stack:push(L2_7)
end
function Menu2DIsland.island_data(A0_8)
	local L1_9
	L1_9 = A0_8._island_data
	return L1_9
end
function Menu2DIsland.page_state(A0_10)
	local L1_11
	L1_11 = {}
	L1_11.page_name = A0_10._page_stack:top().page_name
	L1_11.backwards = A0_10._movement_back
	return L1_11
end
