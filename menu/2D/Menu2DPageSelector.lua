if not Menu2DPageSelector then
	Menu2DPageSelector = class()
end
Menu2DPageSelector.init = function(l_1_0, l_1_1)
	l_1_0._components = l_1_1
	l_1_0._requested_dialog_page_name = nil
end

Menu2DPageSelector.set_dialog = function(l_2_0, l_2_1)
	l_2_0._requested_dialog_page_name = l_2_1
end

Menu2DPageSelector.can_go_back = function(l_3_0)
	local l_3_1 = l_3_0._components.page_flipper
	if not l_3_1:page_change_completed() then
		return false
	end
	local l_3_2 = l_3_1:current_page()
	local l_3_3 = l_3_2:can_go_back()
	if l_3_3 ~= nil then
		return l_3_3
	end
	local l_3_4 = l_3_0._components.island
	if not l_3_4 then
		return false
	end
	local l_3_5, l_3_6 = l_3_4:can_go_back, l_3_4
	return l_3_5(l_3_6)
end

Menu2DPageSelector.confirm_mode = function(l_4_0)
	local l_4_1 = l_4_0._components.page_flipper
	if not l_4_1:page_change_completed() then
		return nil
	end
	local l_4_2 = l_4_1:current_page()
	local l_4_3, l_4_4 = l_4_2:confirm_mode, l_4_2
	return l_4_3(l_4_4)
end

Menu2DPageSelector.update = function(l_5_0, l_5_1)
	local l_5_2 = l_5_0._components.island
	local l_5_3, l_5_4 = nil, nil
	if l_5_2 then
		local l_5_5 = l_5_2:page_state()
		l_5_3 = l_5_5.page_name
		l_5_4 = l_5_5.backwards
	end
	if l_5_0._requested_dialog_page_name then
		l_5_3 = l_5_0._requested_dialog_page_name
		l_5_4 = false
	end
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_5_3 and l_5_3 ~= l_5_0._page_name then
		l_5_0._components.page_flipper:change_page(l_5_3, l_5_4)
		l_5_0._page_name = l_5_3
	if l_5_4 then
		end
		l_5_0._components.sound:play("menu_back")
	end
	do return end
	if l_5_0._page_name then
		l_5_0._components.page_flipper:close()
		l_5_0._page_name = nil
	end
end


