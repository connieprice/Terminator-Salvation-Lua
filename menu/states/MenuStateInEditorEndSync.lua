MenuStateInEditorEndSync = MenuStateInEditorEndSync or class(FiniteStateMachineState)
function MenuStateInEditorEndSync.init(A0_0)
	A0_0._menu:gui_interface():set_state("end_sync_to_editor")
end
function MenuStateInEditorEndSync.transition(A0_1)
	if A0_1._menu:gui_interface():sync_done("frontend") then
		return MenuStateInEditorSyncDone
	end
end
