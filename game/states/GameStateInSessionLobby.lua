if not GameStateInSessionLobby then
	GameStateInSessionLobby = class(FiniteStateMachineState)
end
GameStateInSessionLobby.transition = function(l_1_0)
	if managers.game_transition:wants_to_load() then
		return GameStateLoadWorld
	end
end


