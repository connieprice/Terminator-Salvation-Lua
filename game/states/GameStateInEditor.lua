GameStateInEditor = GameStateInEditor or class(FiniteStateMachineState)
function GameStateInEditor.init(A0_0)
	A0_0.game._is_in_editor = true
	managers.game_transition:clear_wants_to_go_to_frontend()
	A0_0.game:_request_show_menu_frontend()
end
function GameStateInEditor.transition(A0_1)
	return check_for_host_or_join_session()
end
function GameStateInEditor.exit(A0_2)
	A0_2.game._is_in_editor = false
	A0_2.game:_clear_request_show_menu_frontend()
end
