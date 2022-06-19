require("units/beings/player/states/PlayerMovementState")
PlayerDead = PlayerDead or class(PlayerMovementState)
function PlayerDead.init(A0_0, A1_1)
	PlayerMovementState.init(A0_0, A1_1, "PlayerDead")
	A0_0._unit:anim_state_machine():play("weapon_pose/idle")
end
function PlayerDead.enter(A0_2)
	PlayerMovementState.enter(A0_2)
	if managers.player:is_human_player(A0_2._unit) then
		managers.drama_scene:stop_scene()
	end
	A0_2._unit:set_slot(6)
	A0_2._base:ragdoll()
	A0_2._emitter = managers.action_event:create_emitter(A0_2._unit)
	A0_2._emitter:unit_player_dead(A0_2._unit)
	A0_2._emitter:destroy()
	managers.unit_scripting:unit_dead(A0_2._unit)
end
