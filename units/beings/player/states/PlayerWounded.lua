require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerLeavingWounded")
if not PlayerWounded then
	PlayerWounded = class(PlayerMovementState)
end
PlayerWounded.init = function(l_1_0, l_1_1)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerWounded")
	l_1_0._base = l_1_0._unit:base()
	l_1_0._killed_mover = false
	l_1_0._emitter = managers.action_event:create_emitter()
end

PlayerWounded.enter = function(l_2_0)
	PlayerMovementState.enter(l_2_0)
	l_2_0._unit:play_redirect("wounded")
	l_2_0._previous_separate_distance = l_2_0._unit:separate_distance()
	l_2_0._unit:set_separate_distance(20)
	l_2_0._dead_timer = 0
	l_2_0._player_data.wounded = true
	l_2_0._base:_set_down(true)
	l_2_0._stand_mover_activated = false
	l_2_0._emitter:unit_revive_help(l_2_0._unit)
end

PlayerWounded.leave = function(l_3_0)
	PlayerMovementState.leave(l_3_0)
	l_3_0._unit:set_separate_distance(l_3_0._previous_separate_distance)
	l_3_0._base:_set_down(false)
	l_3_0._unit:damage():revive()
	l_3_0._emitter:unit_revive_thanks(l_3_0._unit)
	l_3_0._emitter:destroy()
end

PlayerWounded.update = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = l_4_0._player_data
	if not l_4_3.entering_wounded and not l_4_3.wounded then
		l_4_0._base:activate_mover("stand")
		local l_4_4, l_4_5 = PlayerLeavingWounded:new, PlayerLeavingWounded
		local l_4_6 = l_4_0._unit
		local l_4_7 = l_4_0._previous_separate_distance
		return l_4_4(l_4_5, l_4_6, l_4_7)
	end
	if not l_4_0._killed_mover then
		if not l_4_3.entering_wounded and l_4_3.wounded then
			l_4_0._unit:kill_mover()
			l_4_0._killed_mover = true
		end
	elseif not l_4_0._stand_mover_activated and l_4_3.enter_wounded_use_stand_cover then
		l_4_0._base:activate_mover("stand")
		l_4_0._stand_mover_activated = true
	end
end


