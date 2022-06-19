require("game/states/GameStateInGameEnterPause")
require("game/states/GameStateInGameLeavePause")
require("game/states/GameStateInGamePause")
require("game/states/GameStateInGameRunning")
require("game/states/GameStateInGameEndOfMission")
require("game/states/GameStateInGameEndOfMissionDone")
if not GameStateInGame then
	GameStateInGame = class(FiniteStateMachineState)
end
GameStateInGame.init = function(l_1_0)
	l_1_0._paused_state = FiniteStateMachine:new(l_1_0.game, "game", GameStateInGameRunning)
	l_1_0._paused_state:set_debug(true)
	if not Application:editor() then
		managers.world:post_sync_stage_activation()
	end
	managers.network:peer():game_synced()
	managers.user_viewport:enable_viewport_creation()
	l_1_0.game._is_in_game = true
	managers.game_rules = GameRulesManager:new()
	managers.game:_request_show_menu_ingame()
end

GameStateInGame.exit = function(l_2_0)
	managers.game:_clear_request_show_menu_ingame()
end

GameStateInGame.update = function(l_3_0, l_3_1)
	managers.game_rules:update(l_3_1)
	l_3_0._paused_state:update(l_3_1)
	if not l_3_0._time_ingame then
		l_3_0._time_ingame = (not managers.game_transition:should_cycle_levels() or 0) + l_3_1
		if l_3_0._time_ingame > 30 then
			l_3_0:_start_next_level()
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 20 
end

GameStateInGame.exit = function(l_4_0)
	l_4_0.game._is_in_game = false
	Global.level_info = nil
	managers.game_transition:clear_game_over()
end

GameStateInGame.transition = function(l_5_0)
end

GameStateInGame._start_next_level = function(l_6_0)
	local l_6_1 = managers.save:profile()
	local l_6_2 = l_6_1.current_level_id
	assert(l_6_2)
	local l_6_3 = managers.world_info:info_from_id(l_6_2)
	if not managers.world_info:next_world_info(l_6_3) then
		local l_6_4 = managers.world_info:info_from_id(1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_6_2 = l_6_4.id
	local l_6_5 = nil
	local l_6_6 = 1
	local l_6_7 = nil
	managers.save:set_level_data_to_profiles(l_6_2, l_6_6, l_6_7, false)
	managers.game_transition:exec_game_from_game()
end


