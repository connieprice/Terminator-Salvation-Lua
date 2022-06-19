require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
require("units/beings/machines/walker/states/WalkerDead")
WalkerFullyDamagedState = WalkerFullyDamagedState or class(WalkerState)
function WalkerFullyDamagedState.init(A0_0)
	local L1_1
	L1_1 = WalkerState
	L1_1 = L1_1.init
	L1_1(A0_0)
	L1_1 = A0_0._unit
	A0_0._enemy_data = L1_1:enemy_data()
	L1_1:play_redirect("die")
	A0_0._base:_set_can_move(false)
	A0_0._base:_set_can_fire(false)
	managers.unit_scripting:unit_dead(L1_1)
	A0_0._emitter:unit_fully_damaged(L1_1)
end
function WalkerFullyDamagedState.exit(A0_2)
	local L1_3
	L1_3 = A0_2._base
	L1_3:_set_can_move(true)
	L1_3:_set_can_fire(true)
end
function WalkerFullyDamagedState.transition(A0_4)
	local L1_5
	L1_5 = A0_4._enemy_data
	L1_5 = L1_5.death_animation_done
	if L1_5 then
		L1_5 = WalkerDead
		return L1_5
	end
end
