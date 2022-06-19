if not MenuStateIngamePausedGameOver then
	MenuStateIngamePausedGameOver = class(FiniteStateMachineState)
end
MenuStateIngamePausedGameOver.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("game_over")
end

MenuStateIngamePausedGameOver.update = function(l_2_0, l_2_1)
end

MenuStateIngamePausedGameOver.exit = function(l_3_0)
end

MenuStateIngamePausedGameOver.transition = function(l_4_0)
end


