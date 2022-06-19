GameStateWorldCleared = GameStateWorldCleared or class(FiniteStateMachineState)
function GameStateWorldCleared.transition(A0_0)
	if managers.game_transition:wants_to_host_session() then
		return GameStateHostGame
	elseif managers.game_transition:wants_to_join_session() then
		return GameStateJoinSession
	elseif managers.game_transition:wants_to_go_to_frontend() or managers.game_transition:wants_to_go_to_pre_frontend() then
		return GameStateWaitingForMenuSyncToFinish
	end
end
