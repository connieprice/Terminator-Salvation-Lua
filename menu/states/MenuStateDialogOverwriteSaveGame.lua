if not MenuStateDialogOverwriteSaveGame then
	MenuStateDialogOverwriteSaveGame = class(MenuStateDialog)
end
MenuStateDialogOverwriteSaveGame.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_dialog("confirm_overwrite_device")
end

MenuStateDialogOverwriteSaveGame.exit = function(l_2_0)
	l_2_0._menu:gui_interface():remove_dialog()
end

MenuStateDialogOverwriteSaveGame.transition = function(l_3_0)
	if not l_3_0._menu:dialog_user_storage():waits_for_overwrite_confirmation() then
		return MenuStateDialogNone
	end
end


