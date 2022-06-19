GameStateInSessionLobby = GameStateInSessionLobby or class(FiniteStateMachineState)
function GameStateInSessionLobby.transition(A0_0)
	if managers.game_transition:wants_to_load() then
		return GameStateLoadWorld
	end
end
