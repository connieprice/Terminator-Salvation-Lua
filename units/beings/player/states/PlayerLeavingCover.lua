require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
if not PlayerLeavingCover then
	PlayerLeavingCover = class(PlayerMovementState)
end
PlayerLeavingCover.init = function(l_1_0, l_1_1)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerLeavingCover")
	l_1_0._post_rotation = false
	local l_1_2 = l_1_0._unit:input()
	l_1_0._normalized_movement = l_1_2:normalized_movement()
end

PlayerLeavingCover.enter = function(l_2_0)
	PlayerMovementState.enter(l_2_0)
	l_2_0._player_data.leaving_cover = true
	l_2_0._player_data.global_aiming = true
end

PlayerLeavingCover.leave = function(l_3_0)
	PlayerMovementState.leave(l_3_0)
	l_3_0._unit:base():activate_mover("stand")
	l_3_0._player_data.leaving_cover = false
	l_3_0._player_data.global_aiming = false
end

PlayerLeavingCover.kill_mover = function(l_4_0)
end

PlayerLeavingCover._segment_real_time = function(l_5_0)
	local l_5_1 = "body_base"
	local l_5_2 = l_5_0._unit:anim_state_machine()
	return l_5_2:segment_real_time(l_5_1)
end

PlayerLeavingCover.begin_rotation = function(l_6_0, l_6_1, l_6_2)
end

PlayerLeavingCover.end_rotation = function(l_7_0)
	l_7_0._post_rotation = false
end

PlayerLeavingCover.update = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_0._base:check_fully_damaged()
	if l_8_3 then
		return l_8_3
	end
	if l_8_0._player_data.leaving_cover_break then
		l_8_0._unit:base():activate_mover("stand")
		l_8_0._player_data.leaving_cover_break = false
	end
	l_8_0._player_data.local_pitch_normalized = 0
	l_8_0._player_data.local_yaw_normalized = 0
	PlayerMovementState._update_aim_parameters(l_8_0, l_8_2)
	local l_8_7 = PlayerMovementState.update
	l_8_7(l_8_0, l_8_1, l_8_2)
	l_8_7 = l_8_0._player_data
	l_8_7 = l_8_7.leaving_cover
	if not l_8_7 then
		l_8_7 = PlayerOnGround
		local l_8_4, l_8_5 = l_8_7
		l_8_5 = l_8_0._unit
		local l_8_6 = nil
		return l_8_7(l_8_4, l_8_5)
	end
end


