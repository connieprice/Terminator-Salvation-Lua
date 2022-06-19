if not MenuStateInEditorEndSync then
	MenuStateInEditorEndSync = class(FiniteStateMachineState)
end
MenuStateInEditorEndSync.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("end_sync_to_editor")
end

MenuStateInEditorEndSync.transition = function(l_2_0)
	if l_2_0._menu:gui_interface():sync_done("frontend") then
		return MenuStateInEditorSyncDone
	end
end


