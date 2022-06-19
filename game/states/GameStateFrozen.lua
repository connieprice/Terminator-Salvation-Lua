require("game/states/GameStateUnFrozen")
if not GameStateFrozen then
	GameStateFrozen = class(FiniteStateMachineState)
end
GameStateFrozen.init = function(l_1_0)
	l_1_0.game:request_freeze_sounds()
	managers.volume:activate_set("silence")
	if not l_1_0.game:is_paused() then
		Application:set_pause(true)
	end
	l_1_0.game._is_frozen = true
end

GameStateFrozen.exit = function(l_2_0)
	l_2_0.game:request_unfreeze_sounds()
	managers.volume:deactivate_set("silence")
	l_2_0.game._is_frozen = false
	if not l_2_0.game:is_paused() then
		Application:set_pause(false)
	end
	managers.environment._radial_blur_manager:destroy_blur(l_2_0.game._current_blur, 0.5)
end

GameStateFrozen.transition = function(l_3_0)
	if managers.game_transition:wants_to_unfreeze() then
		return GameStateUnFrozen
	end
end


