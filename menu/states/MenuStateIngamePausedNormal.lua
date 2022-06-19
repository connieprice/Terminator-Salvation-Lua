if not MenuStateIngamePausedNormal then
	MenuStateIngamePausedNormal = class(FiniteStateMachineState)
end
MenuStateIngamePausedNormal.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("paused")
end

MenuStateIngamePausedNormal.update = function(l_2_0, l_2_1)
end

MenuStateIngamePausedNormal.exit = function(l_3_0)
end

MenuStateIngamePausedNormal.transition = function(l_4_0)
	if managers.game_transition:is_game_over() then
		return MenuStateIngamePausedGameOver
	else
		if managers.game_transition:wants_to_show_cutscene() then
			return MenuStateIngamePausedCutscene
		end
	end
end


