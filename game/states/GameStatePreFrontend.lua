if not GameStatePreFrontend then
	GameStatePreFrontend = class(FiniteStateMachineState)
end
GameStatePreFrontend.init = function(l_1_0)
	managers.game_transition:clear_wants_to_go_to_pre_frontend()
	managers.game_transition:clear_wants_to_host()
	l_1_0.game._is_in_pre_frontend = true
	local l_1_1 = GameStateWaitingForPrimaryUser
	l_1_0._machine = FiniteStateMachine:new(l_1_0.game, "game", l_1_1)
	l_1_0.game:_request_show_menu_frontend()
	l_1_0:_clear_player_slots()
end

GameStatePreFrontend._clear_player_slots = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8 = nil
	local l_2_1 = managers.local_user:users()
	for i_0,i_1 in pairs(l_2_1) do
		i_1:clear_wanted_slot_id()
	end
end

GameStatePreFrontend.exit = function(l_3_0)
	l_3_0.game:_clear_request_show_menu_frontend()
	l_3_0.game._is_in_pre_frontend = false
end

GameStatePreFrontend.update = function(l_4_0, l_4_1)
	l_4_0._machine:update(l_4_1)
end

GameStatePreFrontend.transition = function(l_5_0)
	if managers.game_transition:wants_to_go_to_pre_frontend() then
		return GameStatePreFrontend
	else
		if not managers.save:primary_profile_is_ready() then
			return 
		end
	end
	debug_set_level_to_profile()
	if Global.level_info then
		managers.game_transition:set_wants_to_host(1)
		if Global.level_info.should_cycle_levels then
			managers.game_transition:set_should_cycle_levels()
		end
		if Global.level_info.pass_through_menu then
			managers.game_transition:set_should_pass_through_menu()
			return GameStateFrontend
		else
			return GameStateWaitingForMenuSyncStart
		end
	else
		if Application:editor() then
			return GameStateInEditor
		end
	else
		return GameStateFrontend
	end
end


