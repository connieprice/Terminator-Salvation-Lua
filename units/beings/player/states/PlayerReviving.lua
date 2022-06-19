require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
PlayerReviving = PlayerReviving or class(PlayerMovementState)
function PlayerReviving.init(A0_0, A1_1, A2_2)
	PlayerMovementState.init(A0_0, A1_1, "PlayerReviving")
	A0_0._player_to_revive = A2_2
end
function PlayerReviving.enter(A0_3)
	PlayerMovementState.enter(A0_3)
	if alive(A0_3._player_to_revive) then
		A0_3._player_to_revive:base():revive()
	end
end
function PlayerReviving.update(A0_4, A1_5, A2_6)
	if A0_4._base:check_fully_damaged() then
		return (A0_4._base:check_fully_damaged())
	end
	if not A0_4._player_data.reviving then
		return PlayerOnGround:new(A0_4._unit)
	end
end
