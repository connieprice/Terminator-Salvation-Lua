require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
PlayerWarping = PlayerWarping or class(PlayerMovementState)
function PlayerWarping.init(A0_0, A1_1, A2_2, A3_3)
	PlayerMovementState.init(A0_0, A1_1, "PlayerWarping")
	A0_0._warp_to_position = A2_2
	A0_0._warp_to_rotation = A3_3
end
function PlayerWarping.enter(A0_4, A1_5, A2_6)
	A0_4._player_data.warping = true
	A0_4._unit:warp_to(A0_4._warp_to_rotation, A0_4._warp_to_position)
end
function PlayerWarping.leave(A0_7, A1_8, A2_9)
	A0_7._player_data.warping = false
end
function PlayerWarping.update(A0_10, A1_11, A2_12)
	if A0_10._player_data.on_ground then
		return PlayerOnGround:new(A0_10._unit)
	end
end
