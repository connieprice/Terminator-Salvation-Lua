MenuStateStartSyncToIngame = MenuStateStartSyncToIngame or class(FiniteStateMachineState)
function MenuStateStartSyncToIngame.init(A0_0)
	A0_0._menu:gui_interface():set_state("start_sync_to_ingame")
end
function MenuStateStartSyncToIngame.transition(A0_1)
	if A0_1._menu:gui_interface():sync_started("ingame") then
		return MenuStateSyncToIngameStarted
	end
	return nil
end
