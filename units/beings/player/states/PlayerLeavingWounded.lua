require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
PlayerLeavingWounded = PlayerLeavingWounded or class(PlayerMovementState)
PlayerLeavingWounded._DURATION = 2
function PlayerLeavingWounded.init(A0_0, A1_1, A2_2)
	PlayerMovementState.init(A0_0, A1_1, "PlayerLeavingWounded")
	A0_0._start_separate_distance = A0_0._unit:separate_distance()
	A0_0._target_separate_distance = A2_2
	A0_0._t = 0
	A0_0._unit:anim_state_machine():play("weapon_pose/idle")
end
function PlayerLeavingWounded.leave(A0_3)
	PlayerMovementState.leave(A0_3)
	A0_3._unit:set_separate_distance(A0_3._target_separate_distance)
end
function PlayerLeavingWounded.update(A0_4, A1_5, A2_6)
	local L3_7, L4_8
	L3_7 = A0_4._t
	L3_7 = L3_7 + A2_6
	A0_4._t = L3_7
	L3_7 = A0_4._t
	L4_8 = PlayerLeavingWounded
	L4_8 = L4_8._DURATION
	if L3_7 >= L4_8 then
		L3_7 = A0_4._player_data
		L3_7 = L3_7.exiting_wounded
		if not L3_7 then
			L3_7 = PlayerOnGround
			L4_8 = L3_7
			L3_7 = L3_7.new
			return L3_7(L4_8, A0_4._unit)
		else
			return
		end
	end
	L3_7 = A0_4._t
	L4_8 = PlayerLeavingWounded
	L4_8 = L4_8._DURATION
	L3_7 = L3_7 / L4_8
	L4_8 = A0_4._start_separate_distance
	L4_8 = L4_8 + (A0_4._target_separate_distance - A0_4._start_separate_distance) * L3_7
	A0_4._unit:set_separate_distance(L4_8)
end
