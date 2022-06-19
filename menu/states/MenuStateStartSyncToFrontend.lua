if not MenuStateStartSyncToFrontend then
	MenuStateStartSyncToFrontend = class(FiniteStateMachineState)
end
MenuStateStartSyncToFrontend.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("start_sync_to_frontend")
end

MenuStateStartSyncToFrontend.transition = function(l_2_0)
	if l_2_0._menu:gui_interface():sync_started("frontend") then
		return MenuStateSyncToFrontendStarted
	end
	return nil
end


