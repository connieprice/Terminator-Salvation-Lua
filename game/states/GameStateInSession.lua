GameStateInSession = GameStateInSession or class(FiniteStateMachineState)
function GameStateInSession.init(A0_0)
	local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6
	L1_1 = A0_0.game
	L1_1 = L1_1._set_is_in_session
	L1_1(L2_2, L3_3)
	L1_1 = managers
	L1_1 = L1_1.local_user
	L1_1 = L1_1.users
	L1_1 = L1_1(L2_2)
	for L5_5, L6_6 in L2_2(L3_3) do
		if L6_6:wants_to_play() then
			managers.network:peer():join_game(L6_6, L6_6:wanted_player_slot_id())
		end
	end
	L5_5 = A0_0.game
	L6_6 = "game"
	A0_0._session_state = L3_3
	L5_5 = true
	L3_3(L4_4, L5_5)
end
function GameStateInSession.update(A0_7, A1_8)
	A0_7._session_state:update(A1_8)
end
function GameStateInSession.exit(A0_9)
	A0_9.game:_set_is_in_session(false)
	managers.game_transition:clear_wants_to_quit_session()
	A0_9._session_state:destroy()
end
function GameStateInSession.transition(A0_10)
	if managers.menu:is_in_dialog() then
		return
	end
	if managers.game_transition:wants_to_quit_session() or managers.game_transition:wants_to_go_to_pre_frontend() then
		return GameStateWaitingForMenuSyncStart
	end
end
