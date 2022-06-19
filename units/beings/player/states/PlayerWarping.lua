require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
if not PlayerWarping then
	PlayerWarping = class(PlayerMovementState)
end
PlayerWarping.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerWarping")
	l_1_0._warp_to_position = l_1_2
	l_1_0._warp_to_rotation = l_1_3
end

PlayerWarping.enter = function(l_2_0, l_2_1, l_2_2)
	l_2_0._player_data.warping = true
	l_2_0._unit:warp_to(l_2_0._warp_to_rotation, l_2_0._warp_to_position)
end

PlayerWarping.leave = function(l_3_0, l_3_1, l_3_2)
	l_3_0._player_data.warping = false
end

PlayerWarping.update = function(l_4_0, l_4_1, l_4_2)
	if l_4_0._player_data.on_ground then
		local l_4_3, l_4_4 = PlayerOnGround:new, PlayerOnGround
		local l_4_5 = l_4_0._unit
		return l_4_3(l_4_4, l_4_5)
	end
end


