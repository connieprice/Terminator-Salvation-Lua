if not GameStateInGamePause then
	GameStateInGamePause = class(FiniteStateMachineState)
end
GameStateInGamePause.init = function(l_1_0)
	if not l_1_0.game:is_frozen() then
		Application:set_pause(true)
	end
	l_1_0.game:request_pause_sounds()
	l_1_0.game._is_paused = true
	l_1_0.game._is_pausing = false
end

GameStateInGamePause.exit = function(l_2_0)
end

GameStateInGamePause.transition = function(l_3_0)
	if managers.game_transition:wants_to_unpause() then
		return GameStateInGameLeavePause
	end
end


