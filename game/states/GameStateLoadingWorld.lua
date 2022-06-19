if not GameStateLoadingWorld then
	GameStateLoadingWorld = class(FiniteStateMachineState)
end
GameStateLoadingWorld.init = function(l_1_0)
	l_1_0.game._level_name = managers.game_transition:level_name()
	l_1_0.game._checkpoint_index = managers.game_transition:checkpoint_index()
	assert(l_1_0.game._checkpoint_index)
	if not managers.game_transition:ignore_level_load() then
		managers.world = WorldManager:new()
		l_1_0._world_loader = WorldLoader:new((managers.game_transition:level_name()), nil)
	end
	managers.save:check_for_mission_objective()
	managers.game_transition:clear_wants_to_load()
end

GameStateLoadingWorld.exit = function(l_2_0)
	managers.network:peer():game_loaded()
	l_2_0.game._is_loading_done = true
end

GameStateLoadingWorld.transition = function(l_3_0)
	if managers.game_transition:ignore_level_load() or l_3_0._world_loader:is_done() then
		return GameStateWaitingForMenuSyncToFinish
	end
end


