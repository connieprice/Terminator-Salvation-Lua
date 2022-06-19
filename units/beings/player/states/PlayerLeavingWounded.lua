require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
if not PlayerLeavingWounded then
	PlayerLeavingWounded = class(PlayerMovementState)
end
PlayerLeavingWounded._DURATION = 2
PlayerLeavingWounded.init = function(l_1_0, l_1_1, l_1_2)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerLeavingWounded")
	l_1_0._start_separate_distance = l_1_0._unit:separate_distance()
	l_1_0._target_separate_distance = l_1_2
	l_1_0._t = 0
	l_1_0._unit:anim_state_machine():play("weapon_pose/idle")
end

PlayerLeavingWounded.leave = function(l_2_0)
	PlayerMovementState.leave(l_2_0)
	l_2_0._unit:set_separate_distance(l_2_0._target_separate_distance)
end

PlayerLeavingWounded.update = function(l_3_0, l_3_1, l_3_2)
	local l_3_6, l_3_7 = nil
	l_3_0._t = l_3_0._t + l_3_2
	if PlayerLeavingWounded._DURATION <= l_3_0._t then
		if not l_3_0._player_data.exiting_wounded then
			local l_3_3, l_3_4 = PlayerOnGround:new, PlayerOnGround
			local l_3_5 = l_3_0._unit
			return l_3_3(l_3_4, l_3_5)
		end
	else
		return 
	end
	local l_3_8 = l_3_0._t / PlayerLeavingWounded._DURATION
	local l_3_9 = l_3_0._start_separate_distance + (l_3_0._target_separate_distance - l_3_0._start_separate_distance) * l_3_8
	l_3_0._unit:set_separate_distance(l_3_9)
end


