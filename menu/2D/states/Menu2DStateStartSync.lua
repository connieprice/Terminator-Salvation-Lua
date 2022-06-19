require("menu/2D/states/Menu2DState")
if not Menu2DStateStartSync then
	Menu2DStateStartSync = class(Menu2DState)
end
Menu2DStateStartSync.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DState.init(l_1_0, l_1_2)
	l_1_0._state_data.menu.components.island = nil
	l_1_0._state_data.menu.components.effects:fade_down(nil, 5)
	l_1_0._started = false
	l_1_0._sync_type = l_1_1
end

Menu2DStateStartSync.exit = function(l_2_0)
	l_2_0._state_data.menu.sync_state.sync_started = nil
end

Menu2DStateStartSync.update = function(l_3_0)
	local l_3_1 = l_3_0._state_data.menu.components
	if l_3_1.effects:is_fade_down_done() and l_3_1.page_flipper:page_change_completed() and not l_3_0._started then
		l_3_0:_setup_sync_screen()
		l_3_0._state_data.menu.sync_state.sync_started = l_3_0._sync_type
		l_3_0._started = true
	end
end


