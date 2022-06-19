require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
WalkerDead = WalkerDead or class(WalkerState)
function WalkerDead.init(A0_0)
	local L1_1, L2_2, L3_3
	L1_1 = WalkerState
	L1_1 = L1_1.init
	L2_2 = A0_0
	L1_1(L2_2)
	L1_1 = A0_0._unit
	L3_3 = L1_1
	L2_2 = L1_1.enemy_data
	L2_2 = L2_2(L3_3)
	A0_0._enemy_data = L2_2
	L2_2 = A0_0._base
	L3_3 = L2_2._set_can_move
	L3_3(L2_2, false)
	L3_3 = L2_2._set_can_fire
	L3_3(L2_2, false)
	L3_3 = L1_1.kill_mover
	L3_3(L1_1)
	L3_3 = L1_1.damage
	L3_3 = L3_3(L1_1)
	L3_3 = L3_3.fully_damaged_inflictor
	L3_3 = L3_3(L3_3)
	if alive(L3_3) then
		A0_0._emitter:unit_killed_machine(L3_3, L1_1)
	end
end
function WalkerDead.exit(A0_4)
	local L1_5
	L1_5 = A0_4._base
	L1_5:_set_can_move(true)
	L1_5:_set_can_fire(true)
	A0_4._unit:activate_mover("default")
end
function WalkerDead.transition(A0_6)
	local L1_7
end
