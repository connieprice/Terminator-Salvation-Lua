MenuStateDialogRetryLoad = MenuStateDialogRetryLoad or class(MenuStateDialog)
function MenuStateDialogRetryLoad.init(A0_0)
	A0_0._menu:gui_interface():set_dialog("load_error")
end
function MenuStateDialogRetryLoad.exit(A0_1)
	A0_1._menu:gui_interface():remove_dialog()
end
function MenuStateDialogRetryLoad.transition(A0_2)
	if not A0_2._menu:dialog_user_storage():waits_for_retry_loading() then
		return MenuStateDialogNone
	end
end
