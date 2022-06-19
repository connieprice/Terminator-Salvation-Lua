require("units/beings/player/states/PlayerMovementState")
PlayerInactiveState = PlayerInactiveState or class(PlayerMovementState)
function PlayerInactiveState.init(A0_0, A1_1)
	PlayerMovementState.init(A0_0, A1_1, "PlayerInactiveState")
end
