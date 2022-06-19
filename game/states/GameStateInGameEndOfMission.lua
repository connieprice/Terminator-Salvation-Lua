if not GameStateInGameEndOfMission then
	GameStateInGameEndOfMission = class(FiniteStateMachineState)
end
GameStateInGameEndOfMission.init = function(l_1_0)
	l_1_0.game._is_end_of_mission = true
	managers.game_transition:clear_reached_end_of_mission()
	l_1_0._next_level_info = l_1_0:_get_next_level_info()
	if l_1_0._next_level_info then
		managers.save:save_progress(1, l_1_0._next_level_info.id)
	end
end

GameStateInGameEndOfMission.exit = function(l_2_0)
	l_2_0.game._is_end_of_mission = nil
	if not l_2_0._next_level_info then
		managers.game_transition:exec_end_of_game()
	else
		managers.game_transition:exec_game_from_game()
	end
end

GameStateInGameEndOfMission.transition = function(l_3_0)
	if managers.menu:is_end_of_mission_done() then
		return GameStateInGameEndOfMissionDone
	end
end

GameStateInGameEndOfMission._get_next_level_info = function(l_4_0)
	local l_4_1 = managers.save:profile()
	local l_4_2 = l_4_1.current_level_id
	local l_4_3 = managers.world_info:info_from_id(l_4_2)
	if l_4_3 then
		return managers.world_info:next_world_info(l_4_3)
	end
	return nil
end


