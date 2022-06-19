if not GameStateInEditorSimulation then
	GameStateInEditorSimulation = class(GameStateInGame)
end
GameStateInEditorSimulation.init = function(l_1_0)
	GameStateInGame.init(l_1_0)
	if not script_debug.running_simulation then
		local l_1_1 = EffectsLoader:new()
	end
	local l_1_2 = CoreEditor.run_simulation
	l_1_2(managers.editor, script_debug._with_mission)
	l_1_2 = managers
	l_1_2 = l_1_2.world
	l_1_2(l_1_2)
end


