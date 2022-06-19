if not MenuStatePreFrontendEndSync then
	MenuStatePreFrontendEndSync = class(FiniteStateMachineState)
end
MenuStatePreFrontendEndSync.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("end_sync_to_frontend")
end

MenuStatePreFrontendEndSync.transition = function(l_2_0)
	if l_2_0._menu:gui_interface():sync_done("frontend") then
		return MenuStatePreFrontendSyncDone
	end
end


