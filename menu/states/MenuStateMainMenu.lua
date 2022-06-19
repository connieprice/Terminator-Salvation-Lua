if not MenuStateMainMenu then
	MenuStateMainMenu = class(FiniteStateMachineState)
end
MenuStateMainMenu.init = function(l_1_0)
	assert(managers.save:profile())
	l_1_0._menu:gui_interface():set_state("main_menu")
end

MenuStateMainMenu.exit = function(l_2_0)
end

MenuStateMainMenu.update = function(l_3_0, l_3_1)
end

MenuStateMainMenu.transition = function(l_4_0)
end


