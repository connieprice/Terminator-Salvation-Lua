if not Menu2DManagerGuiInterface then
	Menu2DManagerGuiInterface = class()
end
Menu2DManagerGuiInterface.init = function(l_1_0, l_1_1)
	l_1_0._menu2d_manager = l_1_1
end

Menu2DManagerGuiInterface.set_state = function(l_2_0, ...)
	l_2_0._menu2d_manager:set_state(...)
end

Menu2DManagerGuiInterface.set_dialog = function(l_3_0, ...)
	l_3_0._menu2d_manager:set_dialog(...)
end

Menu2DManagerGuiInterface.remove_dialog = function(l_4_0)
	l_4_0._menu2d_manager:remove_dialog()
end

Menu2DManagerGuiInterface.page_change_completed = function(l_5_0)
	local l_5_1, l_5_2 = l_5_0._menu2d_manager:page_change_completed, l_5_0._menu2d_manager
	return l_5_1(l_5_2)
end

Menu2DManagerGuiInterface.render = function(l_6_0)
	l_6_0._menu2d_manager:render()
end

Menu2DManagerGuiInterface.sync_started = function(l_7_0, l_7_1)
	return l_7_0._menu2d_manager._sync_state.sync_started
end

Menu2DManagerGuiInterface.sync_done = function(l_8_0, l_8_1)
	return l_8_0._menu2d_manager._sync_state.sync_done
end


