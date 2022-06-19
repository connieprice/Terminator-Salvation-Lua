if not GameStateWaitingForMenuSyncToFinish then
	GameStateWaitingForMenuSyncToFinish = class(FiniteStateMachineState)
end
GameStateWaitingForMenuSyncToFinish.init = function(l_1_0)
	if l_1_0:_wants_to_go_to_frontend() then
		l_1_0.game:_request_menu_frontend()
	else
		l_1_0.game:_request_menu_ingame()
	end
end

GameStateWaitingForMenuSyncToFinish.exit = function(l_2_0)
	if l_2_0:_wants_to_go_to_frontend() then
		l_2_0.game:_clear_request_menu_frontend()
	else
		l_2_0.game:_clear_request_menu_ingame()
	end
end

GameStateWaitingForMenuSyncToFinish._wants_to_go_to_frontend = function(l_3_0)
	if not managers.game_transition:wants_to_go_to_frontend() then
		return managers.game_transition:wants_to_go_to_pre_frontend()
	end
end

GameStateWaitingForMenuSyncToFinish.transition = function(l_4_0)
	if not managers.menu:is_ingame_ready() and not managers.menu:is_frontend_ready() then
		return 
	end
	if managers.game_transition:wants_to_go_to_frontend() or managers.game_transition:wants_to_go_to_pre_frontend() then
		if Application:editor() then
			return GameStateInEditor
		else
			return GameStatePreFrontend
		end
	else
		if Application:editor() then
			return GameStateInEditorSimulation
		end
	else
		return GameStateInGame
	end
end


