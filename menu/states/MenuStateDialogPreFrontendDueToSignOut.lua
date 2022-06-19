MenuStateDialogPreFrontendDueToSignOut = MenuStateDialogPreFrontendDueToSignOut or class(MenuStateDialog)
function MenuStateDialogPreFrontendDueToSignOut.init(A0_0)
	A0_0._menu:set_waits_for_pre_frontend_due_to_sign_out()
	managers.game_transition:clear_pre_frontend_due_to_sign_out()
	A0_0._menu:gui_interface():set_dialog("signed_out")
end
function MenuStateDialogPreFrontendDueToSignOut.exit(A0_1)
	A0_1._menu:gui_interface():remove_dialog()
end
function MenuStateDialogPreFrontendDueToSignOut.transition(A0_2)
	if not A0_2._menu:waits_for_pre_frontend_due_to_sign_out() then
		return MenuStateDialogNone
	end
end
