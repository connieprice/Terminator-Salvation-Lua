Menu2DPageSelector = Menu2DPageSelector or class()
function Menu2DPageSelector.init(A0_0, A1_1)
	A0_0._components = A1_1
	A0_0._requested_dialog_page_name = nil
end
function Menu2DPageSelector.set_dialog(A0_2, A1_3)
	A0_2._requested_dialog_page_name = A1_3
end
function Menu2DPageSelector.can_go_back(A0_4)
	local L1_5
	L1_5 = A0_4._components
	L1_5 = L1_5.page_flipper
	if not L1_5:page_change_completed() then
		return false
	end
	if L1_5:current_page():can_go_back() ~= nil then
		return (L1_5:current_page():can_go_back())
	end
	if not A0_4._components.island then
		return false
	end
	return A0_4._components.island:can_go_back()
end
function Menu2DPageSelector.confirm_mode(A0_6)
	local L1_7
	L1_7 = A0_6._components
	L1_7 = L1_7.page_flipper
	if not L1_7:page_change_completed() then
		return nil
	end
	return L1_7:current_page():confirm_mode()
end
function Menu2DPageSelector.update(A0_8, A1_9)
	local L2_10, L3_11, L4_12
	L2_10 = A0_8._components
	L2_10 = L2_10.island
	L3_11, L4_12 = nil, nil
	if L2_10 then
		L3_11 = L2_10:page_state().page_name
		L4_12 = L2_10:page_state().backwards
	end
	if A0_8._requested_dialog_page_name then
		L3_11 = A0_8._requested_dialog_page_name
		L4_12 = false
	end
	if L3_11 then
		if L3_11 ~= A0_8._page_name then
			A0_8._components.page_flipper:change_page(L3_11, L4_12)
			A0_8._page_name = L3_11
			if L4_12 then
				A0_8._components.sound:play("menu_back")
			end
		end
	elseif A0_8._page_name then
		A0_8._components.page_flipper:close()
		A0_8._page_name = nil
	end
end
