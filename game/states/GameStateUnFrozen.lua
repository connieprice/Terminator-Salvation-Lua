require("game/states/GameStateFreeze")
if not GameStateUnFrozen then
	GameStateUnFrozen = class(FiniteStateMachineState)
end
GameStateUnFrozen.init = function(l_1_0)
	l_1_0.game._is_frozen = false
end

GameStateUnFrozen.transition = function(l_2_0)
	if managers.game_transition:wants_to_freeze() then
		return GameStateFreeze
	end
end


