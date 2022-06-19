require("game/states/GameStateInGameGameOver")
if not GameStateInGameRunning then
	GameStateInGameRunning = class(FiniteStateMachineState)
end
GameStateInGameRunning.init = function(l_1_0)
end

GameStateInGameRunning.transition = function(l_2_0)
	if managers.game_transition:wants_to_pause() then
		return GameStateInGameEnterPause
	else
		if managers.game_transition:is_game_over() then
			return GameStateInGameGameOver
		end
	else
		if managers.game_transition:reached_end_of_mission() then
			return GameStateInGameEndOfMission
		end
	end
end


