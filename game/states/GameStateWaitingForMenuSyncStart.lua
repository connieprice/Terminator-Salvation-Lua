GameStateWaitingForMenuSyncStart = GameStateWaitingForMenuSyncStart or class(FiniteStateMachineState)
function GameStateWaitingForMenuSyncStart.init(A0_0)
	local L1_1
	if managers.game_transition:wants_to_host_session() or managers.game_transition:wants_to_join_session() then
		L1_1 = "to_ingame"
	elseif managers.game_transition:wants_to_go_to_frontend() or managers.game_transition:wants_to_go_to_pre_frontend() then
		L1_1 = "to_frontend"
	end
	A0_0.game:_request_menu_sync_start(L1_1)
end
function GameStateWaitingForMenuSyncStart.transition(A0_2)
	if managers.menu:sync_started() then
		A0_2.game:_clear_request_menu_sync_start()
		return GameStateClearWorld
	end
	return
end
