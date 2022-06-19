require("units/beings/player/states/PlayerOnGround")
require("units/beings/player/states/PlayerMovementState")
if not PlayerPickingUp then
	PlayerPickingUp = class(PlayerMovementState)
end
PlayerPickingUp.init = function(l_1_0, l_1_1)
	l_1_0._unit_to_pick_up = l_1_1:pick_up_target():unit_to_pick_up()
	assert(l_1_0._unit_to_pick_up)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerPickingUp")
end

PlayerPickingUp.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = l_2_0._base:check_fully_damaged()
	if l_2_3 then
		return l_2_3
	end
	if not l_2_0._player_data.picking_up then
		l_2_0:_pickup_done()
		local l_2_4, l_2_5 = PlayerOnGround:new, PlayerOnGround
		local l_2_6 = l_2_0._unit
		return l_2_4(l_2_5, l_2_6)
	end
end

PlayerPickingUp._pickup_done = function(l_3_0)
end


