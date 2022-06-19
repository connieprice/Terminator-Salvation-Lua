if not MenuStateDialogRetrySave then
	MenuStateDialogRetrySave = class(MenuStateDialog)
end
MenuStateDialogRetrySave.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_dialog("save_error")
end

MenuStateDialogRetrySave.exit = function(l_2_0)
	l_2_0._menu:gui_interface():remove_dialog()
end

MenuStateDialogRetrySave.transition = function(l_3_0)
	if not l_3_0._menu:dialog_user_storage():waits_for_retry_saving() then
		return MenuStateDialogNone
	end
end


