MenuStateIngameEndSync = MenuStateIngameEndSync or class(FiniteStateMachineState)
function MenuStateIngameEndSync.init(A0_0)
	A0_0._menu:gui_interface():set_state("end_sync_to_ingame")
end
function MenuStateIngameEndSync.transition(A0_1)
	if A0_1._menu:gui_interface():sync_done("ingame") then
		return MenuStateIngameSyncDone
	end
end
