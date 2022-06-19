if not GameStateInGameEnterPause then
	GameStateInGameEnterPause = class(FiniteStateMachineState)
end
GameStateInGameEnterPause.init = function(l_1_0)
	l_1_0.game._is_pausing = true
end

GameStateInGameEnterPause.exit = function(l_2_0)
end

GameStateInGameEnterPause.update = function(l_3_0, l_3_1)
end

GameStateInGameEnterPause.transition = function(l_4_0)
	if managers.menu:is_ingame_paused() then
		return GameStateInGamePause
	end
end


