MenuStateDialogControllerLost = MenuStateDialogControllerLost or class(MenuStateDialog)
function MenuStateDialogControllerLost.init(A0_0)
	A0_0._menu:gui_interface():set_dialog("controller_lost")
end
function MenuStateDialogControllerLost.exit(A0_1)
	A0_1._menu:gui_interface():remove_dialog()
end
function MenuStateDialogControllerLost.transition(A0_2)
	if A0_2._menu:disconnected_controller_index() == nil then
		return MenuStateDialogNone
	end
end
