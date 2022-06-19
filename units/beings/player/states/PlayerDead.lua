require("units/beings/player/states/PlayerMovementState")
if not PlayerDead then
	PlayerDead = class(PlayerMovementState)
end
PlayerDead.init = function(l_1_0, l_1_1)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerDead")
	l_1_0._unit:anim_state_machine():play("weapon_pose/idle")
end

PlayerDead.enter = function(l_2_0)
	PlayerMovementState.enter(l_2_0)
	if managers.player:is_human_player(l_2_0._unit) then
		managers.drama_scene:stop_scene()
	end
	l_2_0._unit:set_slot(6)
	l_2_0._base:ragdoll()
	l_2_0._emitter = managers.action_event:create_emitter(l_2_0._unit)
	l_2_0._emitter:unit_player_dead(l_2_0._unit)
	l_2_0._emitter:destroy()
	managers.unit_scripting:unit_dead(l_2_0._unit)
end


