MenuStateInEditorSyncDone = MenuStateInEditorSyncDone or class(FiniteStateMachineState)
function MenuStateInEditorSyncDone.init(A0_0)
	A0_0._menu:_set_frontend_ready()
end
function MenuStateInEditorSyncDone.exit(A0_1)
	A0_1._menu:_clear_frontend_ready()
end
function MenuStateInEditorSyncDone.transition(A0_2)
	if managers.game:show_menu_frontend_requested() then
		return MenuStateInEditor
	end
end
