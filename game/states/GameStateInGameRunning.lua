require("game/states/GameStateInGameGameOver")
GameStateInGameRunning = GameStateInGameRunning or class(FiniteStateMachineState)
function GameStateInGameRunning.init(A0_0)
	local L1_1
end
function GameStateInGameRunning.transition(A0_2)
	if managers.game_transition:wants_to_pause() then
		return GameStateInGameEnterPause
	elseif managers.game_transition:is_game_over() then
		return GameStateInGameGameOver
	elseif managers.game_transition:reached_end_of_mission() then
		return GameStateInGameEndOfMission
	end
end
