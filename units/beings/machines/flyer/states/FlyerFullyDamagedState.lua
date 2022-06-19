require("units/beings/machines/flyer/states/FlyerState")
require("units/beings/machines/flyer/states/FlyerDeadState")
FlyerFullyDamagedState = FlyerFullyDamagedState or class(FlyerState)
function FlyerFullyDamagedState.enter(A0_0)
	local L1_1
	L1_1 = A0_0._base
	L1_1 = L1_1._disable_weapons
	L1_1(L1_1)
	L1_1 = assert
	L1_1(A0_0._base._fully_damage_to_dead_time)
	L1_1 = A0_0._base
	L1_1 = L1_1._fully_damage_to_dead_time
	A0_0._time_left = L1_1
	L1_1 = A0_0._unit
	A0_0._emitter:unit_fully_damaged(L1_1)
	L1_1:play_redirect("die")
	managers.unit_scripting:unit_dead(L1_1)
end
function FlyerFullyDamagedState.update(A0_2, A1_3)
	A0_2._time_left = A0_2._time_left - A1_3
	if A0_2._time_left <= 0 then
		return FlyerDeadState:new(A0_2._unit)
	end
end
