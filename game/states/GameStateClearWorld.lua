require("menu/Menu")
GameStateClearWorld = GameStateClearWorld or class(FiniteStateMachineState)
function GameStateClearWorld.init(A0_0)
	A0_0._num_updates = 0
	managers.worldcamera:stop_simulation()
	managers.world:stop_simulation()
	managers.game_transition:clear_wants_to_show_cutscene()
	managers.game_transition:clear_reached_end_of_mission()
end
function GameStateClearWorld._handle_editor(A0_1)
	if script_debug.running_simulation then
		CoreEditor.run_simulation(managers.editor, script_debug._with_mission)
		script_debug._freeflight = nil
		TimerManager:ramp_multiplier(TimerManager:game(), 1, 0.1, TimerManager:pausable())
		TimerManager:ramp_multiplier(TimerManager:game_animation(), 1, 0.1, TimerManager:pausable())
	end
end
function GameStateClearWorld.update(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._num_updates
	L2_4 = L2_4 + 1
	A0_2._num_updates = L2_4
end
function GameStateClearWorld.transition(A0_5)
	if not managers.save:is_busy() and A0_5._num_updates >= 4 then
		if Application:editor() then
			A0_5:_handle_editor()
		else
			managers.game_transition:request_exec()
		end
		return GameStateWorldCleared
	end
end
