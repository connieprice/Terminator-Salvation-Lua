if not MenuStateDialogControllerLost then
	MenuStateDialogControllerLost = class(MenuStateDialog)
end
MenuStateDialogControllerLost.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_dialog("controller_lost")
end

MenuStateDialogControllerLost.exit = function(l_2_0)
	l_2_0._menu:gui_interface():remove_dialog()
end

MenuStateDialogControllerLost.transition = function(l_3_0)
	if l_3_0._menu:disconnected_controller_index() == nil then
		return MenuStateDialogNone
	end
end


