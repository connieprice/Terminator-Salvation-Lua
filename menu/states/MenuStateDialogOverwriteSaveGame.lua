MenuStateDialogOverwriteSaveGame = MenuStateDialogOverwriteSaveGame or class(MenuStateDialog)
function MenuStateDialogOverwriteSaveGame.init(A0_0)
	A0_0._menu:gui_interface():set_dialog("confirm_overwrite_device")
end
function MenuStateDialogOverwriteSaveGame.exit(A0_1)
	A0_1._menu:gui_interface():remove_dialog()
end
function MenuStateDialogOverwriteSaveGame.transition(A0_2)
	if not A0_2._menu:dialog_user_storage():waits_for_overwrite_confirmation() then
		return MenuStateDialogNone
	end
end
