if not GameStateJoinSession then
	GameStateJoinSession = class(FiniteStateMachineState)
end
GameStateJoinSession.init = function(l_1_0)
	managers.network:peer():join_session(managers.game_transition:session_to_join())
	managers.game_transition:clear_session_to_join()
end

GameStateJoinSession.transition = function(l_2_0)
	if managers.network:peer():is_connected() then
		return GameStateInSession
	end
end


