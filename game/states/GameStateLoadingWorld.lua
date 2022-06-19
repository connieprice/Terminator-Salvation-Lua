GameStateLoadingWorld = GameStateLoadingWorld or class(FiniteStateMachineState)
function GameStateLoadingWorld.init(A0_0)
	A0_0.game._level_name = managers.game_transition:level_name()
	A0_0.game._checkpoint_index = managers.game_transition:checkpoint_index()
	assert(A0_0.game._checkpoint_index)
	if not managers.game_transition:ignore_level_load() then
		managers.world = WorldManager:new()
		A0_0._world_loader = WorldLoader:new(managers.game_transition:level_name(), nil)
	end
	managers.save:check_for_mission_objective()
	managers.game_transition:clear_wants_to_load()
end
function GameStateLoadingWorld.exit(A0_1)
	managers.network:peer():game_loaded()
	A0_1.game._is_loading_done = true
end
function GameStateLoadingWorld.transition(A0_2)
	if managers.game_transition:ignore_level_load() or A0_2._world_loader:is_done() then
		return GameStateWaitingForMenuSyncToFinish
	end
end
