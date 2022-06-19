if not MenuStateDialogContinueWithoutSaving then
	MenuStateDialogContinueWithoutSaving = class(MenuStateDialog)
end
MenuStateDialogContinueWithoutSaving.init = function(l_1_0)
	if l_1_0._menu:dialog_user():is_signed_in() then
		l_1_0._menu:gui_interface():set_dialog("confirm_no_saving_no_storage")
	else
		l_1_0._menu:gui_interface():set_dialog("confirm_no_saving_no_profile")
	end
end

MenuStateDialogContinueWithoutSaving.exit = function(l_2_0)
	l_2_0._menu:gui_interface():remove_dialog()
end

MenuStateDialogContinueWithoutSaving.transition = function(l_3_0)
	if not l_3_0._menu:dialog_user_storage():waits_for_continue_without_saving() then
		return MenuStateDialogNone
	end
end


