if not MenuStateIngameEndSync then
	MenuStateIngameEndSync = class(FiniteStateMachineState)
end
MenuStateIngameEndSync.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("end_sync_to_ingame")
end

MenuStateIngameEndSync.transition = function(l_2_0)
	if l_2_0._menu:gui_interface():sync_done("ingame") then
		return MenuStateIngameSyncDone
	end
end


