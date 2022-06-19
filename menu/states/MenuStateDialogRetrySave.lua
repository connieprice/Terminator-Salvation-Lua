MenuStateDialogRetrySave = MenuStateDialogRetrySave or class(MenuStateDialog)
function MenuStateDialogRetrySave.init(A0_0)
	A0_0._menu:gui_interface():set_dialog("save_error")
end
function MenuStateDialogRetrySave.exit(A0_1)
	A0_1._menu:gui_interface():remove_dialog()
end
function MenuStateDialogRetrySave.transition(A0_2)
	if not A0_2._menu:dialog_user_storage():waits_for_retry_saving() then
		return MenuStateDialogNone
	end
end
