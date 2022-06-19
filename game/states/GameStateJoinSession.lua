GameStateJoinSession = GameStateJoinSession or class(FiniteStateMachineState)
function GameStateJoinSession.init(A0_0)
	managers.network:peer():join_session(managers.game_transition:session_to_join())
	managers.game_transition:clear_session_to_join()
end
function GameStateJoinSession.transition(A0_1)
	if managers.network:peer():is_connected() then
		return GameStateInSession
	end
end
