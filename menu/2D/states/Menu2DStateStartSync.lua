require("menu/2D/states/Menu2DState")
Menu2DStateStartSync = Menu2DStateStartSync or class(Menu2DState)
function Menu2DStateStartSync.init(A0_0, A1_1, A2_2)
	Menu2DState.init(A0_0, A2_2)
	A0_0._state_data.menu.components.island = nil
	A0_0._state_data.menu.components.effects:fade_down(nil, 5)
	A0_0._started = false
	A0_0._sync_type = A1_1
end
function Menu2DStateStartSync.exit(A0_3)
	local L1_4
	L1_4 = A0_3._state_data
	L1_4 = L1_4.menu
	L1_4 = L1_4.sync_state
	L1_4.sync_started = nil
end
function Menu2DStateStartSync.update(A0_5)
	local L1_6
	L1_6 = A0_5._state_data
	L1_6 = L1_6.menu
	L1_6 = L1_6.components
	if L1_6.effects:is_fade_down_done() and L1_6.page_flipper:page_change_completed() and not A0_5._started then
		A0_5:_setup_sync_screen()
		A0_5._state_data.menu.sync_state.sync_started = A0_5._sync_type
		A0_5._started = true
	end
end
