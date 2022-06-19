require("units/beings/player/states/PlayerMovementState")
PlayerGrabbed = PlayerGrabbed or class(PlayerMovementState)
function PlayerGrabbed.init(A0_0, A1_1, A2_2)
	PlayerMovementState.init(A0_0, A1_1, "PlayerGrabbed")
	A0_0._anim_state = A2_2
end
function PlayerGrabbed.enter(A0_3)
	PlayerMovementState.enter(A0_3)
	A0_3._unit:kill_mover()
	A0_3._unit:set_driving("orientation_object")
	if A0_3._anim_state then
		A0_3._unit:anim_state_machine():play(A0_3._anim_state)
	end
	managers.unit_scripting:unit_dead(A0_3._unit)
end
