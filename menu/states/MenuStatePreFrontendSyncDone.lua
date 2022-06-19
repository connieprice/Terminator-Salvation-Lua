MenuStatePreFrontendSyncDone = MenuStatePreFrontendSyncDone or class(FiniteStateMachineState)
function MenuStatePreFrontendSyncDone.init(A0_0)
	A0_0._menu:_set_frontend_ready()
end
function MenuStatePreFrontendSyncDone.exit(A0_1)
	A0_1._menu:_clear_frontend_ready()
end
function MenuStatePreFrontendSyncDone.transition(A0_2)
	local L1_3
	L1_3 = managers
	L1_3 = L1_3.game
	L1_3 = L1_3.show_menu_frontend_requested
	L1_3 = L1_3(L1_3)
	if L1_3 then
		L1_3 = A0_2._menu
		L1_3 = L1_3.has_shown_pre_frontend_once
		L1_3 = L1_3(L1_3)
		if not L1_3 then
			L1_3 = MenuStatePreFrontendOnce
			return L1_3
		else
			L1_3 = MenuStatePreFrontend
			return L1_3
		end
	end
	L1_3 = managers
	L1_3 = L1_3.game
	L1_3 = L1_3.requested_menu_sync_start
	L1_3 = L1_3(L1_3)
	if L1_3 then
		L1_3 = managers
		L1_3 = L1_3.game
		L1_3 = L1_3.requested_menu_sync_type
		L1_3 = L1_3(L1_3)
		return MenuStateSyncTypes.get_sync_type_class(L1_3)
	end
end
