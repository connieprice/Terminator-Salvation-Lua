GameStateWaitingForMenuSyncToFinish = GameStateWaitingForMenuSyncToFinish or class(FiniteStateMachineState)
function GameStateWaitingForMenuSyncToFinish.init(A0_0)
	if A0_0:_wants_to_go_to_frontend() then
		A0_0.game:_request_menu_frontend()
	else
		A0_0.game:_request_menu_ingame()
	end
end
function GameStateWaitingForMenuSyncToFinish.exit(A0_1)
	if A0_1:_wants_to_go_to_frontend() then
		A0_1.game:_clear_request_menu_frontend()
	else
		A0_1.game:_clear_request_menu_ingame()
	end
end
function GameStateWaitingForMenuSyncToFinish._wants_to_go_to_frontend(A0_2)
	return managers.game_transition:wants_to_go_to_frontend() or managers.game_transition:wants_to_go_to_pre_frontend()
end
function GameStateWaitingForMenuSyncToFinish.transition(A0_3)
	if not managers.menu:is_ingame_ready() and not managers.menu:is_frontend_ready() then
		return
	end
	if managers.game_transition:wants_to_go_to_frontend() or managers.game_transition:wants_to_go_to_pre_frontend() then
		if Application:editor() then
			return GameStateInEditor
		else
			return GameStatePreFrontend
		end
	elseif Application:editor() then
		return GameStateInEditorSimulation
	else
		return GameStateInGame
	end
end
