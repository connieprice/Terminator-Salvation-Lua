MenuStateMainMenu = MenuStateMainMenu or class(FiniteStateMachineState)
function MenuStateMainMenu.init(A0_0)
	assert(managers.save:profile())
	A0_0._menu:gui_interface():set_state("main_menu")
end
function MenuStateMainMenu.exit(A0_1)
	local L1_2
end
function MenuStateMainMenu.update(A0_3, A1_4)
end
function MenuStateMainMenu.transition(A0_5)
	local L1_6
end
