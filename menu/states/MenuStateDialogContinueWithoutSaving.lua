MenuStateDialogContinueWithoutSaving = MenuStateDialogContinueWithoutSaving or class(MenuStateDialog)
function MenuStateDialogContinueWithoutSaving.init(A0_0)
	if A0_0._menu:dialog_user():is_signed_in() then
		A0_0._menu:gui_interface():set_dialog("confirm_no_saving_no_storage")
	else
		A0_0._menu:gui_interface():set_dialog("confirm_no_saving_no_profile")
	end
end
function MenuStateDialogContinueWithoutSaving.exit(A0_1)
	A0_1._menu:gui_interface():remove_dialog()
end
function MenuStateDialogContinueWithoutSaving.transition(A0_2)
	if not A0_2._menu:dialog_user_storage():waits_for_continue_without_saving() then
		return MenuStateDialogNone
	end
end
