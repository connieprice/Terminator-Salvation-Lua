require("units/beings/player/states/PlayerMovementState")
if not PlayerInactiveState then
	PlayerInactiveState = class(PlayerMovementState)
end
PlayerInactiveState.init = function(l_1_0, l_1_1)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerInactiveState")
end


