MenuStateDialogStorageLost = MenuStateDialogStorageLost or class(MenuStateDialog)
function MenuStateDialogStorageLost.init(A0_0)
	A0_0._menu:gui_interface():set_dialog("storage_lost")
end
function MenuStateDialogStorageLost.exit(A0_1)
	A0_1._menu:gui_interface():remove_dialog()
end
function MenuStateDialogStorageLost.transition(A0_2)
	if not A0_2._menu:has_dialog_user() then
		return MenuStateDialogNone
	end
	if not A0_2._menu:dialog_user_storage():waits_for_storage_lost() then
		return MenuStateDialogNone
	end
end
