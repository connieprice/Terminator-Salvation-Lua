require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerStunned")
WalkerRequestingStun = WalkerRequestingStun or class(WalkerState)
function WalkerRequestingStun.init(A0_0)
	WalkerState.init(A0_0)
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._base:_set_can_move(false)
	A0_0._base:_set_can_fire(false)
end
function WalkerRequestingStun.exit(A0_1)
	local L1_2
	L1_2 = A0_1._base
	L1_2:_set_can_move(true)
	L1_2:_set_can_fire(true)
end
function WalkerRequestingStun.update(A0_3, A1_4)
	local L2_5
	L2_5 = A0_3._unit
	L2_5:play_redirect("stun")
	if not A0_3._enemy_data.pre_stunned then
		L2_5:play_redirect("pre_stun")
	end
end
function WalkerRequestingStun.transition(A0_6)
	if A0_6._base:check_fully_damaged() then
		return (A0_6._base:check_fully_damaged())
	end
	if not A0_6._enemy_data.pre_stunned and A0_6._enemy_data.is_stunned then
		return WalkerStunned
	end
end
