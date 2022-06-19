GameStateInEditorSimulation = GameStateInEditorSimulation or class(GameStateInGame)
function GameStateInEditorSimulation.init(A0_0)
	GameStateInGame.init(A0_0)
	CoreEditor.run_simulation(managers.editor, script_debug._with_mission)
	managers.world:post_sync_stage_activation()
end
