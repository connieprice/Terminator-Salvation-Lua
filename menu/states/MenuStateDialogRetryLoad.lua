if not MenuStateDialogRetryLoad then
	MenuStateDialogRetryLoad = class(MenuStateDialog)
end
MenuStateDialogRetryLoad.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_dialog("load_error")
end

MenuStateDialogRetryLoad.exit = function(l_2_0)
	l_2_0._menu:gui_interface():remove_dialog()
end

MenuStateDialogRetryLoad.transition = function(l_3_0)
	if not l_3_0._menu:dialog_user_storage():waits_for_retry_loading() then
		return MenuStateDialogNone
	end
end


