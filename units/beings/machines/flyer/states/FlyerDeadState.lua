require("units/beings/machines/flyer/states/FlyerState")
FlyerDeadState = FlyerDeadState or class(FlyerState)
function FlyerDeadState.init(A0_0, A1_1)
	local L2_2, L3_3
	L2_2 = FlyerState
	L2_2 = L2_2.init
	L3_3 = A0_0
	L2_2(L3_3, A1_1)
	L2_2 = A0_0._emitter
	L3_3 = L2_2.unit_dead
	L3_3(L2_2, A1_1)
	L3_3 = A1_1.damage
	L3_3 = L3_3(A1_1)
	L3_3 = L3_3.fully_damaged_inflictor
	L3_3 = L3_3(L3_3)
	if alive(L3_3) then
		L2_2:unit_killed_machine(L3_3, A1_1)
	end
end
