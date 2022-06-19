require("game/states/GameStateInGameEnterPause")
require("game/states/GameStateInGameLeavePause")
require("game/states/GameStateInGamePause")
require("game/states/GameStateInGameRunning")
require("game/states/GameStateInGameEndOfMission")
require("game/states/GameStateInGameEndOfMissionDone")
GameStateInGame = GameStateInGame or class(FiniteStateMachineState)
function GameStateInGame.init(A0_0)
	A0_0._paused_state = FiniteStateMachine:new(A0_0.game, "game", GameStateInGameRunning)
	A0_0._paused_state:set_debug(true)
	if not Application:editor() then
		managers.world:post_sync_stage_activation()
	end
	managers.network:peer():game_synced()
	managers.user_viewport:enable_viewport_creation()
	A0_0.game._is_in_game = true
	managers.game_rules = GameRulesManager:new()
	managers.game:_request_show_menu_ingame()
end
function GameStateInGame.exit(A0_1)
	managers.game:_clear_request_show_menu_ingame()
end
function GameStateInGame.update(A0_2, A1_3)
	managers.game_rules:update(A1_3)
	A0_2._paused_state:update(A1_3)
	if managers.game_transition:should_cycle_levels() then
		A0_2._time_ingame = (A0_2._time_ingame or 0) + A1_3
		if A0_2._time_ingame > 30 then
			A0_2:_start_next_level()
		end
	end
end
function GameStateInGame.exit(A0_4)
	A0_4.game._is_in_game = false
	Global.level_info = nil
	managers.game_transition:clear_game_over()
end
function GameStateInGame.transition(A0_5)
	local L1_6
end
function GameStateInGame._start_next_level(A0_7)
	local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14
	L1_8 = managers
	L1_8 = L1_8.save
	L2_9 = L1_8
	L1_8 = L1_8.profile
	L1_8 = L1_8(L2_9)
	L2_9 = L1_8.current_level_id
	L3_10 = assert
	L4_11 = L2_9
	L3_10(L4_11)
	L3_10 = managers
	L3_10 = L3_10.world_info
	L4_11 = L3_10
	L3_10 = L3_10.info_from_id
	L5_12 = L2_9
	L3_10 = L3_10(L4_11, L5_12)
	L4_11 = managers
	L4_11 = L4_11.world_info
	L5_12 = L4_11
	L4_11 = L4_11.next_world_info
	L6_13 = L3_10
	L4_11 = L4_11(L5_12, L6_13)
	if not L4_11 then
		L5_12 = managers
		L5_12 = L5_12.world_info
		L6_13 = L5_12
		L5_12 = L5_12.info_from_id
		L7_14 = 1
		L5_12 = L5_12(L6_13, L7_14)
		L4_11 = L5_12
	end
	L2_9 = L4_11.id
	L5_12 = 1
	L6_13 = nil
	L7_14 = false
	managers.save:set_level_data_to_profiles(L2_9, L5_12, L6_13, L7_14)
	managers.game_transition:exec_game_from_game()
end
