if not GameStateFrontend then
	GameStateFrontend = class(FiniteStateMachineState)
end
GameStateFrontend.init = function(l_1_0)
	l_1_0.game._is_in_frontend = true
	managers.game_transition:clear_wants_to_go_to_frontend()
end

GameStateFrontend.exit = function(l_2_0)
	l_2_0.game._is_in_frontend = false
end

GameStateFrontend.transition = function(l_3_0)
	local l_3_2 = managers.game_transition:wants_to_go_to_pre_frontend
	l_3_2 = l_3_2(managers.game_transition)
	if l_3_2 then
		l_3_2 = GameStatePreFrontend
		return l_3_2
	end
	l_3_2 = check_for_host_or_join_session
	local l_3_1 = nil
	return l_3_2()
end


