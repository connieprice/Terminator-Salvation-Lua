require("menu/2D/states/Menu2DState")
require("menu/2D/states/Menu2DStateStartupLegal")
require("menu/2D/states/Menu2DStateStartupMovie")
if not Menu2DStateEndSyncToFrontend then
	Menu2DStateEndSyncToFrontend = class(Menu2DState)
end
Menu2DStateEndSyncToFrontend.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateEndSyncToFrontend)
	managers.sync_screen:hide_sync_screen()
end

Menu2DStateEndSyncToFrontend.exit = function(l_2_0)
	l_2_0._state_data.menu.sync_state.sync_done = nil
end

Menu2DStateEndSyncToFrontend.update = function(l_3_0)
	if not managers.sync_screen:is_showing_sync_screen() then
		l_3_0._state_data.menu.sync_state.sync_done = "frontend"
	end
end


