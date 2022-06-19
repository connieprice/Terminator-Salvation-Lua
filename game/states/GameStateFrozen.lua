require("game/states/GameStateUnFrozen")
GameStateFrozen = GameStateFrozen or class(FiniteStateMachineState)
function GameStateFrozen.init(A0_0)
	A0_0.game:request_freeze_sounds()
	managers.volume:activate_set("silence")
	if not A0_0.game:is_paused() then
		Application:set_pause(true)
	end
	A0_0.game._is_frozen = true
end
function GameStateFrozen.exit(A0_1)
	A0_1.game:request_unfreeze_sounds()
	managers.volume:deactivate_set("silence")
	A0_1.game._is_frozen = false
	if not A0_1.game:is_paused() then
		Application:set_pause(false)
	end
	managers.environment._radial_blur_manager:destroy_blur(A0_1.game._current_blur, 0.5)
end
function GameStateFrozen.transition(A0_2)
	if managers.game_transition:wants_to_unfreeze() then
		return GameStateUnFrozen
	end
end
