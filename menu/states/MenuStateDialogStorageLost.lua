if not MenuStateDialogStorageLost then
	MenuStateDialogStorageLost = class(MenuStateDialog)
end
MenuStateDialogStorageLost.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_dialog("storage_lost")
end

MenuStateDialogStorageLost.exit = function(l_2_0)
	l_2_0._menu:gui_interface():remove_dialog()
end

MenuStateDialogStorageLost.transition = function(l_3_0)
	if not l_3_0._menu:has_dialog_user() then
		return MenuStateDialogNone
	end
	if not l_3_0._menu:dialog_user_storage():waits_for_storage_lost() then
		return MenuStateDialogNone
	end
end


