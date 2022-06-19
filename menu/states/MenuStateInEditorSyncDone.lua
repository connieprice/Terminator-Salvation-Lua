if not MenuStateInEditorSyncDone then
	MenuStateInEditorSyncDone = class(FiniteStateMachineState)
end
MenuStateInEditorSyncDone.init = function(l_1_0)
	l_1_0._menu:_set_frontend_ready()
end

MenuStateInEditorSyncDone.exit = function(l_2_0)
	l_2_0._menu:_clear_frontend_ready()
end

MenuStateInEditorSyncDone.transition = function(l_3_0)
	if managers.game:show_menu_frontend_requested() then
		return MenuStateInEditor
	end
end


