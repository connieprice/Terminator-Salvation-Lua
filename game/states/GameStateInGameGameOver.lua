GameStateInGameGameOver = GameStateInGameGameOver or class(FiniteStateMachineState)
function GameStateInGameGameOver.init(A0_0)
	A0_0._wait_time = 0
	managers.volume:activate_set("game_over")
	A0_0._game_over_sound = Sound:make_bank("stingers_sound", "stinger_game_over")
	A0_0._game_over_sound:play()
end
function GameStateInGameGameOver.update(A0_1, A1_2)
	local L2_3
	L2_3 = A0_1._wait_time
	L2_3 = L2_3 + A1_2
	A0_1._wait_time = L2_3
end
function GameStateInGameGameOver.transition(A0_4)
	if A0_4._wait_time > 5 then
		managers.game_transition:request_pause()
	end
	if managers.game_transition:wants_to_pause() then
		return GameStateInGameEnterPause
	end
end
