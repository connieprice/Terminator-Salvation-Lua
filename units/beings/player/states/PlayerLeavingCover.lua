require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
PlayerLeavingCover = PlayerLeavingCover or class(PlayerMovementState)
function PlayerLeavingCover.init(A0_0, A1_1)
	PlayerMovementState.init(A0_0, A1_1, "PlayerLeavingCover")
	A0_0._post_rotation = false
	A0_0._normalized_movement = A0_0._unit:input():normalized_movement()
end
function PlayerLeavingCover.enter(A0_2)
	PlayerMovementState.enter(A0_2)
	A0_2._player_data.leaving_cover = true
	A0_2._player_data.global_aiming = true
end
function PlayerLeavingCover.leave(A0_3)
	PlayerMovementState.leave(A0_3)
	A0_3._unit:base():activate_mover("stand")
	A0_3._player_data.leaving_cover = false
	A0_3._player_data.global_aiming = false
end
function PlayerLeavingCover.kill_mover(A0_4)
	local L1_5
end
function PlayerLeavingCover._segment_real_time(A0_6)
	local L1_7
	L1_7 = "body_base"
	return (A0_6._unit:anim_state_machine():segment_real_time(L1_7))
end
function PlayerLeavingCover.begin_rotation(A0_8, A1_9, A2_10)
end
function PlayerLeavingCover.end_rotation(A0_11)
	local L1_12
	A0_11._post_rotation = false
end
function PlayerLeavingCover.update(A0_13, A1_14, A2_15)
	if A0_13._base:check_fully_damaged() then
		return (A0_13._base:check_fully_damaged())
	end
	if A0_13._player_data.leaving_cover_break then
		A0_13._unit:base():activate_mover("stand")
		A0_13._player_data.leaving_cover_break = false
	end
	A0_13._player_data.local_pitch_normalized = 0
	A0_13._player_data.local_yaw_normalized = 0
	PlayerMovementState._update_aim_parameters(A0_13, A2_15)
	PlayerMovementState.update(A0_13, A1_14, A2_15)
	if not A0_13._player_data.leaving_cover then
		return PlayerOnGround:new(A0_13._unit)
	end
end
