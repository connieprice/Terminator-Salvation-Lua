require("menu/2D/Menu2DPages")
require("menu/2D/pages/Menu2DPageTypes")
if not Menu2DPageFlipper then
	Menu2DPageFlipper = class()
end
Menu2DPageFlipper._pages_file_path = "data/menu/Menu2DPages.xml"
Menu2DPageFlipper.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._components = l_1_1
	l_1_0._settings = l_1_2
	l_1_0._page_change_callbacks = CallbacksList:new()
	l_1_0._changing_resolution_callbacks = CallbacksList:new()
	l_1_0._resolution_changed_callbacks = CallbacksList:new()
	l_1_0._pages = Menu2DPages:new(l_1_0._pages_file_path, Menu2DPageTypes, l_1_0._components.root_panel)
	l_1_0._changing_page = false
end

Menu2DPageFlipper.post_init = function(l_2_0)
	l_2_0._pages:post_init()
end

Menu2DPageFlipper.destroy = function(l_3_0)
	if l_3_0._current_page then
		l_3_0._current_page:destroy()
		l_3_0._current_page = nil
	end
end

Menu2DPageFlipper.page_change_completed = function(l_4_0)
	if not l_4_0._current_page then
		return true
	end
	if l_4_0._current_page:transition_active() then
		return false
	end
	return true
end

Menu2DPageFlipper.change_page = function(l_5_0, l_5_1, l_5_2)
	cat_print("menu", "Showing page " .. l_5_1)
	if not l_5_0._current_page then
		l_5_0._components.root_panel:show()
		l_5_0:_activate_page(l_5_1, l_5_2)
		l_5_0._page_change_callbacks:call(nil, l_5_1, l_5_2)
	else
		l_5_0._page_change_callbacks:call(l_5_0._current_page:name(), l_5_1, l_5_2)
		local l_5_3 = {}
		l_5_3.page_name = l_5_1
		l_5_3.backwards = l_5_2
		l_5_0._queued_page = l_5_3
		l_5_3 = l_5_0._current_page
		l_5_3(l_5_3, not l_5_2)
		l_5_0._changing_page = true
	end
end

Menu2DPageFlipper.close = function(l_6_0)
	if not l_6_0._current_page then
		return 
	end
	l_6_0._current_page:set_transition(true)
	l_6_0._changing_page = true
end

Menu2DPageFlipper._activate_page = function(l_7_0, l_7_1, l_7_2)
	managers.menu_input:reset_cache()
	local l_7_3 = l_7_0._pages:page(l_7_1)
	assert(l_7_3)
	l_7_3:open(l_7_0._settings.safe_rect, not l_7_2, tweak_data.menu2d.layer_normal)
	l_7_0._current_page = l_7_3
end

Menu2DPageFlipper.has_active_page = function(l_8_0)
	return l_8_0._current_page ~= nil
end

Menu2DPageFlipper.current_page = function(l_9_0)
	return l_9_0._current_page
end

Menu2DPageFlipper.page_change_callbacks = function(l_10_0)
	local l_10_1, l_10_2 = l_10_0._page_change_callbacks:public_interface, l_10_0._page_change_callbacks
	return l_10_1(l_10_2)
end

Menu2DPageFlipper.changing_resolution_callbacks = function(l_11_0)
	local l_11_1, l_11_2 = l_11_0._changing_resolution_callbacks:public_interface, l_11_0._changing_resolution_callbacks
	return l_11_1(l_11_2)
end

Menu2DPageFlipper.resolution_changed_callbacks = function(l_12_0)
	local l_12_1, l_12_2 = l_12_0._resolution_changed_callbacks:public_interface, l_12_0._resolution_changed_callbacks
	return l_12_1(l_12_2)
end

Menu2DPageFlipper.changing_resolution = function(l_13_0)
	l_13_0._changing_resolution_callbacks:call()
	if l_13_0._current_page then
		l_13_0._current_page:close()
	end
end

Menu2DPageFlipper.resolution_changed = function(l_14_0)
	l_14_0._resolution_changed_callbacks:call()
	l_14_0._pages:resolution_changed(l_14_0._components.root_panel, l_14_0._settings)
	if l_14_0._current_page then
		l_14_0._current_page:reopen(l_14_0._components.root_panel, l_14_0._settings.safe_rect)
	end
end

Menu2DPageFlipper.input = function(l_15_0, l_15_1, l_15_2)
	if l_15_0:has_active_page() and not l_15_0._changing_page and not l_15_0._current_page:transition_active() then
		l_15_0._current_page:input(l_15_1, l_15_2)
	end
end

Menu2DPageFlipper.update = function(l_16_0, l_16_1)
	if not l_16_0._current_page then
		return 
	end
	l_16_0._current_page:update(l_16_1)
	if l_16_0._changing_page and not l_16_0._current_page:transition_active() then
		l_16_0._changing_page = false
		l_16_0._current_page:close()
		if l_16_0._queued_page then
			l_16_0:_activate_page(l_16_0._queued_page.page_name, l_16_0._queued_page.backwards)
			l_16_0._queued_page = nil
		end
	else
		l_16_0._components.root_panel:hide()
		l_16_0._page_active = false
		l_16_0._current_page = nil
	end
end


