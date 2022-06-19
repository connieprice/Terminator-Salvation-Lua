GameStateInGameEnterPause = GameStateInGameEnterPause or class(FiniteStateMachineState)
function GameStateInGameEnterPause.init(A0_0)
	A0_0.game._is_pausing = true
end
function GameStateInGameEnterPause.exit(A0_1)
	local L1_2
end
function GameStateInGameEnterPause.update(A0_3, A1_4)
end
function GameStateInGameEnterPause.transition(A0_5)
	local L1_6
	L1_6 = {}
	if managers.menu:is_ingame_paused() then
		return GameStateInGamePause
	end
end
