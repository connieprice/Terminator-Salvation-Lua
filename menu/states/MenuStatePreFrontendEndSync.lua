MenuStatePreFrontendEndSync = MenuStatePreFrontendEndSync or class(FiniteStateMachineState)
function MenuStatePreFrontendEndSync.init(A0_0)
	A0_0._menu:gui_interface():set_state("end_sync_to_frontend")
end
function MenuStatePreFrontendEndSync.transition(A0_1)
	if A0_1._menu:gui_interface():sync_done("frontend") then
		return MenuStatePreFrontendSyncDone
	end
end
