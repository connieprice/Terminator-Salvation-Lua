require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
if not PlayerReviving then
	PlayerReviving = class(PlayerMovementState)
end
PlayerReviving.init = function(l_1_0, l_1_1, l_1_2)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerReviving")
	l_1_0._player_to_revive = l_1_2
end

PlayerReviving.enter = function(l_2_0)
	PlayerMovementState.enter(l_2_0)
	if alive(l_2_0._player_to_revive) then
		l_2_0._player_to_revive:base():revive()
	end
end

PlayerReviving.update = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_0._base:check_fully_damaged()
	if l_3_3 then
		return l_3_3
	end
	if not l_3_0._player_data.reviving then
		local l_3_4, l_3_5 = PlayerOnGround:new, PlayerOnGround
		local l_3_6 = l_3_0._unit
		return l_3_4(l_3_5, l_3_6)
	end
end


