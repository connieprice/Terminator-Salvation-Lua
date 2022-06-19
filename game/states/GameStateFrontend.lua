GameStateFrontend = GameStateFrontend or class(FiniteStateMachineState)
function GameStateFrontend.init(A0_0)
	A0_0.game._is_in_frontend = true
	managers.game_transition:clear_wants_to_go_to_frontend()
end
function GameStateFrontend.exit(A0_1)
	A0_1.game._is_in_frontend = false
end
function GameStateFrontend.transition(A0_2)
	if managers.game_transition:wants_to_go_to_pre_frontend() then
		return GameStatePreFrontend
	end
	return check_for_host_or_join_session()
end
