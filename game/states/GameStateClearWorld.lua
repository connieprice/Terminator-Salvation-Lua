require("menu/Menu")
if not GameStateClearWorld then
	GameStateClearWorld = class(FiniteStateMachineState)
end
GameStateClearWorld.init = function(l_1_0)
	l_1_0._num_updates = 0
	managers.worldcamera:stop_simulation()
	managers.world:stop_simulation()
	managers.game_transition:clear_wants_to_show_cutscene()
	managers.game_transition:clear_reached_end_of_mission()
end

GameStateClearWorld._handle_editor = function(l_2_0)
	if script_debug.running_simulation then
		CoreEditor.run_simulation(managers.editor, script_debug._with_mission)
		script_debug._freeflight = nil
		TimerManager:ramp_multiplier(TimerManager:game(), 1, 0.1, TimerManager:pausable())
		TimerManager:ramp_multiplier(TimerManager:game_animation(), 1, 0.1, TimerManager:pausable())
	end
end

GameStateClearWorld.update = function(l_3_0, l_3_1)
	l_3_0._num_updates = l_3_0._num_updates + 1
end

GameStateClearWorld.transition = function(l_4_0)
	if not managers.save:is_busy() and l_4_0._num_updates >= 4 then
		if Application:editor() then
			l_4_0:_handle_editor()
		else
			managers.game_transition:request_exec()
		end
		return GameStateWorldCleared
	end
end


