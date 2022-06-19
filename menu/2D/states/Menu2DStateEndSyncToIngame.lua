require("menu/2D/states/Menu2DState")
if not Menu2DStateEndSyncToIngame then
	Menu2DStateEndSyncToIngame = class(Menu2DState)
end
Menu2DStateEndSyncToIngame.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateEndSyncToIngame)
	managers.sync_screen:hide_sync_screen()
end

Menu2DStateEndSyncToIngame.exit = function(l_2_0)
	l_2_0._state_data.menu.sync_state.sync_done = nil
end

Menu2DStateEndSyncToIngame.update = function(l_3_0)
	if not managers.sync_screen:is_showing_sync_screen() then
		l_3_0._state_data.menu.sync_state.sync_done = "ingame"
	end
end


