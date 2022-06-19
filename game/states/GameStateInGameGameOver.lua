if not GameStateInGameGameOver then
	GameStateInGameGameOver = class(FiniteStateMachineState)
end
GameStateInGameGameOver.init = function(l_1_0)
	l_1_0._wait_time = 0
	managers.volume:activate_set("game_over")
	l_1_0._game_over_sound = Sound:make_bank("stingers_sound", "stinger_game_over")
	l_1_0._game_over_sound:play()
end

GameStateInGameGameOver.update = function(l_2_0, l_2_1)
	l_2_0._wait_time = l_2_0._wait_time + l_2_1
end

GameStateInGameGameOver.transition = function(l_3_0)
	if l_3_0._wait_time > 5 then
		managers.game_transition:request_pause()
	end
	if managers.game_transition:wants_to_pause() then
		return GameStateInGameEnterPause
	end
end


