require("units/beings/machines/spider/states/SpiderState")
SpiderDeadState = SpiderDeadState or class(SpiderState)
function SpiderDeadState.init(A0_0, A1_1)
	local L2_2
	L2_2 = SpiderState
	L2_2 = L2_2.init
	L2_2(A0_0, A1_1)
	L2_2 = A0_0._unit
	L2_2 = L2_2.damage
	L2_2 = L2_2(L2_2)
	L2_2 = L2_2.fully_damaged_inflictor
	L2_2 = L2_2(L2_2)
	if alive(L2_2) then
		A0_0._emitter:unit_killed_machine(L2_2, A0_0._unit)
	end
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._enemy_data.dead = true
end
