if not MenuStateDialogPreFrontendDueToSignOut then
	MenuStateDialogPreFrontendDueToSignOut = class(MenuStateDialog)
end
MenuStateDialogPreFrontendDueToSignOut.init = function(l_1_0)
	l_1_0._menu:set_waits_for_pre_frontend_due_to_sign_out()
	managers.game_transition:clear_pre_frontend_due_to_sign_out()
	l_1_0._menu:gui_interface():set_dialog("signed_out")
end

MenuStateDialogPreFrontendDueToSignOut.exit = function(l_2_0)
	l_2_0._menu:gui_interface():remove_dialog()
end

MenuStateDialogPreFrontendDueToSignOut.transition = function(l_3_0)
	if not l_3_0._menu:waits_for_pre_frontend_due_to_sign_out() then
		return MenuStateDialogNone
	end
end


