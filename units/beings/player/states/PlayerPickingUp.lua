require("units/beings/player/states/PlayerOnGround")
require("units/beings/player/states/PlayerMovementState")
PlayerPickingUp = PlayerPickingUp or class(PlayerMovementState)
function PlayerPickingUp.init(A0_0, A1_1)
	A0_0._unit_to_pick_up = A1_1:pick_up_target():unit_to_pick_up()
	assert(A0_0._unit_to_pick_up)
	PlayerMovementState.init(A0_0, A1_1, "PlayerPickingUp")
end
function PlayerPickingUp.update(A0_2, A1_3, A2_4)
	if A0_2._base:check_fully_damaged() then
		return (A0_2._base:check_fully_damaged())
	end
	if not A0_2._player_data.picking_up then
		A0_2:_pickup_done()
		return PlayerOnGround:new(A0_2._unit)
	end
end
function PlayerPickingUp._pickup_done(A0_5)
	local L1_6
end
