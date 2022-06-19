GameStateInGameEndOfMission = GameStateInGameEndOfMission or class(FiniteStateMachineState)
function GameStateInGameEndOfMission.init(A0_0)
	A0_0.game._is_end_of_mission = true
	managers.game_transition:clear_reached_end_of_mission()
	A0_0._next_level_info = A0_0:_get_next_level_info()
	if A0_0._next_level_info then
		managers.save:save_progress(1, A0_0._next_level_info.id)
	end
end
function GameStateInGameEndOfMission.exit(A0_1)
	A0_1.game._is_end_of_mission = nil
	if not A0_1._next_level_info then
		managers.game_transition:exec_end_of_game()
	else
		managers.game_transition:exec_game_from_game()
	end
end
function GameStateInGameEndOfMission.transition(A0_2)
	if managers.menu:is_end_of_mission_done() then
		return GameStateInGameEndOfMissionDone
	end
end
function GameStateInGameEndOfMission._get_next_level_info(A0_3)
	local L1_4, L2_5, L3_6
	L1_4 = managers
	L1_4 = L1_4.save
	L2_5 = L1_4
	L1_4 = L1_4.profile
	L1_4 = L1_4(L2_5)
	L2_5 = L1_4.current_level_id
	L3_6 = managers
	L3_6 = L3_6.world_info
	L3_6 = L3_6.info_from_id
	L3_6 = L3_6(L3_6, L2_5)
	if L3_6 then
		return (managers.world_info:next_world_info(L3_6))
	end
	return nil
end
