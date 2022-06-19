require("menu/2D/states/Menu2DState")
require("menu/2D/states/Menu2DStateStartupLegal")
require("menu/2D/states/Menu2DStateStartupMovie")
Menu2DStateEndSyncToFrontend = Menu2DStateEndSyncToFrontend or class(Menu2DState)
function Menu2DStateEndSyncToFrontend.init(A0_0)
	Menu2DState.init(A0_0, Menu2DStateEndSyncToFrontend)
	managers.sync_screen:hide_sync_screen()
end
function Menu2DStateEndSyncToFrontend.exit(A0_1)
	local L1_2
	L1_2 = A0_1._state_data
	L1_2 = L1_2.menu
	L1_2 = L1_2.sync_state
	L1_2.sync_done = nil
end
function Menu2DStateEndSyncToFrontend.update(A0_3)
	if not managers.sync_screen:is_showing_sync_screen() then
		A0_3._state_data.menu.sync_state.sync_done = "frontend"
	end
end
