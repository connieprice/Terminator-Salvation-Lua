MenuStateStartSyncToFrontend = MenuStateStartSyncToFrontend or class(FiniteStateMachineState)
function MenuStateStartSyncToFrontend.init(A0_0)
	A0_0._menu:gui_interface():set_state("start_sync_to_frontend")
end
function MenuStateStartSyncToFrontend.transition(A0_1)
	if A0_1._menu:gui_interface():sync_started("frontend") then
		return MenuStateSyncToFrontendStarted
	end
	return nil
end
