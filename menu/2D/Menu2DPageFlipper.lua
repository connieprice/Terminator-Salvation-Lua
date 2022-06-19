require("menu/2D/Menu2DPages")
require("menu/2D/pages/Menu2DPageTypes")
Menu2DPageFlipper = Menu2DPageFlipper or class()
Menu2DPageFlipper._pages_file_path = "data/menu/Menu2DPages.xml"
function Menu2DPageFlipper.init(A0_0, A1_1, A2_2)
	A0_0._components = A1_1
	A0_0._settings = A2_2
	A0_0._page_change_callbacks = CallbacksList:new()
	A0_0._changing_resolution_callbacks = CallbacksList:new()
	A0_0._resolution_changed_callbacks = CallbacksList:new()
	A0_0._pages = Menu2DPages:new(A0_0._pages_file_path, Menu2DPageTypes, A0_0._components.root_panel)
	A0_0._changing_page = false
end
function Menu2DPageFlipper.post_init(A0_3)
	A0_3._pages:post_init()
end
function Menu2DPageFlipper.destroy(A0_4)
	if A0_4._current_page then
		A0_4._current_page:destroy()
		A0_4._current_page = nil
	end
end
function Menu2DPageFlipper.page_change_completed(A0_5)
	if not A0_5._current_page then
		return true
	end
	if A0_5._current_page:transition_active() then
		return false
	end
	return true
end
function Menu2DPageFlipper.change_page(A0_6, A1_7, A2_8)
	cat_print("menu", "Showing page " .. A1_7)
	if not A0_6._current_page then
		A0_6._components.root_panel:show()
		A0_6:_activate_page(A1_7, A2_8)
		A0_6._page_change_callbacks:call(nil, A1_7, A2_8)
	else
		A0_6._page_change_callbacks:call(A0_6._current_page:name(), A1_7, A2_8)
		A0_6._queued_page = {page_name = A1_7, backwards = A2_8}
		A0_6._current_page:set_transition(not A2_8)
		A0_6._changing_page = true
	end
end
function Menu2DPageFlipper.close(A0_9)
	if not A0_9._current_page then
		return
	end
	A0_9._current_page:set_transition(true)
	A0_9._changing_page = true
end
function Menu2DPageFlipper._activate_page(A0_10, A1_11, A2_12)
	local L3_13
	L3_13 = managers
	L3_13 = L3_13.menu_input
	L3_13 = L3_13.reset_cache
	L3_13(L3_13)
	L3_13 = A0_10._pages
	L3_13 = L3_13.page
	L3_13 = L3_13(L3_13, A1_11)
	assert(L3_13)
	L3_13:open(A0_10._settings.safe_rect, not A2_12, tweak_data.menu2d.layer_normal)
	A0_10._current_page = L3_13
end
function Menu2DPageFlipper.has_active_page(A0_14)
	return A0_14._current_page ~= nil
end
function Menu2DPageFlipper.current_page(A0_15)
	local L1_16
	L1_16 = A0_15._current_page
	return L1_16
end
function Menu2DPageFlipper.page_change_callbacks(A0_17)
	return A0_17._page_change_callbacks:public_interface()
end
function Menu2DPageFlipper.changing_resolution_callbacks(A0_18)
	return A0_18._changing_resolution_callbacks:public_interface()
end
function Menu2DPageFlipper.resolution_changed_callbacks(A0_19)
	return A0_19._resolution_changed_callbacks:public_interface()
end
function Menu2DPageFlipper.changing_resolution(A0_20)
	A0_20._changing_resolution_callbacks:call()
	if A0_20._current_page then
		A0_20._current_page:close()
	end
end
function Menu2DPageFlipper.resolution_changed(A0_21)
	A0_21._resolution_changed_callbacks:call()
	A0_21._pages:resolution_changed(A0_21._components.root_panel, A0_21._settings)
	if A0_21._current_page then
		A0_21._current_page:reopen(A0_21._components.root_panel, A0_21._settings.safe_rect)
	end
end
function Menu2DPageFlipper.input(A0_22, A1_23, A2_24)
	if A0_22:has_active_page() and not A0_22._changing_page and not A0_22._current_page:transition_active() then
		A0_22._current_page:input(A1_23, A2_24)
	end
end
function Menu2DPageFlipper.update(A0_25, A1_26)
	if not A0_25._current_page then
		return
	end
	A0_25._current_page:update(A1_26)
	if A0_25._changing_page and not A0_25._current_page:transition_active() then
		A0_25._changing_page = false
		A0_25._current_page:close()
		if A0_25._queued_page then
			A0_25:_activate_page(A0_25._queued_page.page_name, A0_25._queued_page.backwards)
			A0_25._queued_page = nil
		else
			A0_25._components.root_panel:hide()
			A0_25._page_active = false
			A0_25._current_page = nil
		end
	end
end
