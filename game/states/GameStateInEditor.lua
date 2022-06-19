if not GameStateInEditor then
	GameStateInEditor = class(FiniteStateMachineState)
end
GameStateInEditor.init = function(l_1_0)
	l_1_0.game._is_in_editor = true
	managers.game_transition:clear_wants_to_go_to_frontend()
	l_1_0.game:_request_show_menu_frontend()
end

GameStateInEditor.transition = function(l_2_0)
	local l_2_1 = check_for_host_or_join_session
	return l_2_1()
end

GameStateInEditor.exit = function(l_3_0)
	l_3_0.game._is_in_editor = false
	l_3_0.game:_clear_request_show_menu_frontend()
end


