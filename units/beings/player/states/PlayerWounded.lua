require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerLeavingWounded")
PlayerWounded = PlayerWounded or class(PlayerMovementState)
function PlayerWounded.init(A0_0, A1_1)
	PlayerMovementState.init(A0_0, A1_1, "PlayerWounded")
	A0_0._base = A0_0._unit:base()
	A0_0._killed_mover = false
	A0_0._emitter = managers.action_event:create_emitter()
end
function PlayerWounded.enter(A0_2)
	PlayerMovementState.enter(A0_2)
	A0_2._unit:play_redirect("wounded")
	A0_2._previous_separate_distance = A0_2._unit:separate_distance()
	A0_2._unit:set_separate_distance(20)
	A0_2._dead_timer = 0
	A0_2._player_data.wounded = true
	A0_2._base:_set_down(true)
	A0_2._stand_mover_activated = false
	A0_2._emitter:unit_revive_help(A0_2._unit)
end
function PlayerWounded.leave(A0_3)
	PlayerMovementState.leave(A0_3)
	A0_3._unit:set_separate_distance(A0_3._previous_separate_distance)
	A0_3._base:_set_down(false)
	A0_3._unit:damage():revive()
	A0_3._emitter:unit_revive_thanks(A0_3._unit)
	A0_3._emitter:destroy()
end
function PlayerWounded.update(A0_4, A1_5, A2_6)
	local L3_7
	L3_7 = A0_4._player_data
	if not L3_7.entering_wounded and not L3_7.wounded then
		A0_4._base:activate_mover("stand")
		return PlayerLeavingWounded:new(A0_4._unit, A0_4._previous_separate_distance)
	end
	if not A0_4._killed_mover then
		if not L3_7.entering_wounded and L3_7.wounded then
			A0_4._unit:kill_mover()
			A0_4._killed_mover = true
		elseif not A0_4._stand_mover_activated and L3_7.enter_wounded_use_stand_cover then
			A0_4._base:activate_mover("stand")
			A0_4._stand_mover_activated = true
		end
	end
end
