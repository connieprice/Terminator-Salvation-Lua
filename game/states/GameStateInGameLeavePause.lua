if not GameStateInGameLeavePause then
	GameStateInGameLeavePause = class(FiniteStateMachineState)
end
GameStateInGameLeavePause.init = function(l_1_0)
	l_1_0.game._is_resuming = true
end

GameStateInGameLeavePause.exit = function(l_2_0)
	if not l_2_0.game:is_frozen() then
		Application:set_pause(false)
	end
	l_2_0.game._is_paused = false
	l_2_0.game._is_resuming = false
	l_2_0.game:request_unpause_sounds()
end

GameStateInGameLeavePause.transition = function(l_3_0)
	if managers.game_transition:reached_end_of_mission() then
		Sound:clear_listeners()
		return GameStateInGameEndOfMission
	else
		if managers.menu:is_ready_to_resume() then
			return GameStateInGameRunning
		end
	end
end


