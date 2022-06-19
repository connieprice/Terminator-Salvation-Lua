if not GameStateWorldCleared then
	GameStateWorldCleared = class(FiniteStateMachineState)
end
GameStateWorldCleared.transition = function(l_1_0)
	if managers.game_transition:wants_to_host_session() then
		return GameStateHostGame
	else
		if managers.game_transition:wants_to_join_session() then
			return GameStateJoinSession
		end
	else
		if managers.game_transition:wants_to_go_to_frontend() or managers.game_transition:wants_to_go_to_pre_frontend() then
			return GameStateWaitingForMenuSyncToFinish
		end
	end
end


