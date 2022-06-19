MenuStateSyncStarted = MenuStateSyncStarted or class(FiniteStateMachineState)
function MenuStateSyncStarted.init(A0_0)
	A0_0._menu:_set_sync_started()
end
function MenuStateSyncStarted.exit(A0_1)
	A0_1._menu:_clear_sync_started()
end
function MenuStateSyncStarted.transition(A0_2)
	local L1_3
	L1_3 = managers
	L1_3 = L1_3.game
	L1_3 = L1_3.menu_frontend_requested
	L1_3 = L1_3(L1_3)
	if L1_3 then
		L1_3 = managers
		L1_3 = L1_3.game
		L1_3 = L1_3.menu_frontend_type
		L1_3 = L1_3(L1_3)
		return A0_2._menu:_frontend_end_sync_state(L1_3)
	end
	L1_3 = managers
	L1_3 = L1_3.game
	L1_3 = L1_3.menu_ingame_requested
	L1_3 = L1_3(L1_3)
	if L1_3 then
		L1_3 = MenuStateIngame
		return L1_3
	end
end
