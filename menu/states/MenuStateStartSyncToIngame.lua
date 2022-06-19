if not MenuStateStartSyncToIngame then
	MenuStateStartSyncToIngame = class(FiniteStateMachineState)
end
MenuStateStartSyncToIngame.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("start_sync_to_ingame")
end

MenuStateStartSyncToIngame.transition = function(l_2_0)
	if l_2_0._menu:gui_interface():sync_started("ingame") then
		return MenuStateSyncToIngameStarted
	end
	return nil
end


