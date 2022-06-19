require("game/states/GameStateFreeze")
GameStateUnFrozen = GameStateUnFrozen or class(FiniteStateMachineState)
function GameStateUnFrozen.init(A0_0)
	A0_0.game._is_frozen = false
end
function GameStateUnFrozen.transition(A0_1)
	if managers.game_transition:wants_to_freeze() then
		return GameStateFreeze
	end
end
