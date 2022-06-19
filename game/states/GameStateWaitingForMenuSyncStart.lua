if not GameStateWaitingForMenuSyncStart then
	GameStateWaitingForMenuSyncStart = class(FiniteStateMachineState)
end
GameStateWaitingForMenuSyncStart.init = function(l_1_0)
	local l_1_1 = nil
	if managers.game_transition:wants_to_host_session() or managers.game_transition:wants_to_join_session() then
		l_1_1 = "to_ingame"
	else
		if managers.game_transition:wants_to_go_to_frontend() or managers.game_transition:wants_to_go_to_pre_frontend() then
			l_1_1 = "to_frontend"
		end
	end
	l_1_0.game:_request_menu_sync_start(l_1_1)
end

GameStateWaitingForMenuSyncStart.transition = function(l_2_0)
	if managers.menu:sync_started() then
		l_2_0.game:_clear_request_menu_sync_start()
		return GameStateClearWorld
	end
	return 
end


