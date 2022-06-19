GameStateInGamePause = GameStateInGamePause or class(FiniteStateMachineState)
function GameStateInGamePause.init(A0_0)
	if not A0_0.game:is_frozen() then
		Application:set_pause(true)
	end
	A0_0.game:request_pause_sounds()
	A0_0.game._is_paused = true
	A0_0.game._is_pausing = false
end
function GameStateInGamePause.exit(A0_1)
	local L1_2
end
function GameStateInGamePause.transition(A0_3)
	if managers.game_transition:wants_to_unpause() then
		return GameStateInGameLeavePause
	end
end
