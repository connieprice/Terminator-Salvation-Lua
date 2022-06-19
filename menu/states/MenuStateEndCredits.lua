MenuStateEndCredits = MenuStateEndCredits or class(FiniteStateMachineState)
function MenuStateEndCredits.init(A0_0)
	A0_0._menu:gui_interface():set_state("credits")
end
function MenuStateEndCredits.exit(A0_1)
	local L1_2
end
function MenuStateEndCredits.update(A0_3, A1_4)
end
function MenuStateEndCredits.transition(A0_5)
	if (managers.menu2d:is_credits_done() or A0_5._menu:user_wants_to_skip()) and not managers.game:is_in_frontend() then
		return MenuStateMainMenuTitle
	end
end
