if not MenuStateEndCredits then
	MenuStateEndCredits = class(FiniteStateMachineState)
end
MenuStateEndCredits.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("credits")
end

MenuStateEndCredits.exit = function(l_2_0)
end

MenuStateEndCredits.update = function(l_3_0, l_3_1)
end

MenuStateEndCredits.transition = function(l_4_0)
	if (managers.menu2d:is_credits_done() or l_4_0._menu:user_wants_to_skip()) and not managers.game:is_in_frontend() then
		return MenuStateMainMenuTitle
	end
end


