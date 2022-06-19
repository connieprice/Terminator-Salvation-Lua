require("units/beings/player/states/PlayerMovementState")
if not PlayerGrabbed then
	PlayerGrabbed = class(PlayerMovementState)
end
PlayerGrabbed.init = function(l_1_0, l_1_1, l_1_2)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerGrabbed")
	l_1_0._anim_state = l_1_2
end

PlayerGrabbed.enter = function(l_2_0)
	PlayerMovementState.enter(l_2_0)
	l_2_0._unit:kill_mover()
	l_2_0._unit:set_driving("orientation_object")
	if l_2_0._anim_state then
		l_2_0._unit:anim_state_machine():play(l_2_0._anim_state)
	end
	managers.unit_scripting:unit_dead(l_2_0._unit)
end


