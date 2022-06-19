GameStateInGameLeavePause = GameStateInGameLeavePause or class(FiniteStateMachineState)
function GameStateInGameLeavePause.init(A0_0)
	A0_0.game._is_resuming = true
end
function GameStateInGameLeavePause.exit(A0_1)
	if not A0_1.game:is_frozen() then
		Application:set_pause(false)
	end
	A0_1.game._is_paused = false
	A0_1.game._is_resuming = false
	A0_1.game:request_unpause_sounds()
end
function GameStateInGameLeavePause.transition(A0_2)
	if managers.game_transition:reached_end_of_mission() then
		Sound:clear_listeners()
		return GameStateInGameEndOfMission
	elseif managers.menu:is_ready_to_resume() then
		return GameStateInGameRunning
	end
end
