if not GameStateInSession then
	GameStateInSession = class(FiniteStateMachineState)
end
GameStateInSession.init = function(l_1_0)
	local l_1_5, l_1_6, l_1_7, l_1_8, l_1_9, l_1_10, l_1_11, l_1_12 = nil
	l_1_0.game:_set_is_in_session(true)
	local l_1_1 = managers.local_user:users()
	for i_0,i_1 in pairs(l_1_1) do
		if i_1:wants_to_play() then
			managers.network:peer():join_game(i_1, i_1:wanted_player_slot_id())
		end
	end
	l_1_0._session_state = FiniteStateMachine:new(l_1_0.game, "game", GameStateInSessionLobby)
	l_1_0._session_state:set_debug(true)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

GameStateInSession.update = function(l_2_0, l_2_1)
	l_2_0._session_state:update(l_2_1)
end

GameStateInSession.exit = function(l_3_0)
	l_3_0.game:_set_is_in_session(false)
	managers.game_transition:clear_wants_to_quit_session()
	l_3_0._session_state:destroy()
end

GameStateInSession.transition = function(l_4_0)
	if managers.menu:is_in_dialog() then
		return 
	end
	if managers.game_transition:wants_to_quit_session() or managers.game_transition:wants_to_go_to_pre_frontend() then
		return GameStateWaitingForMenuSyncStart
	end
end


