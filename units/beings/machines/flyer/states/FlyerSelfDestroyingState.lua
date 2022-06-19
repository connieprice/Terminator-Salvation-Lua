require("units/beings/machines/flyer/states/FlyerState")
require("units/beings/machines/flyer/states/FlyerDeadState")
FlyerSelfDestroyingState = FlyerSelfDestroyingState or class(FlyerState)
function FlyerSelfDestroyingState.init(A0_0, A1_1)
	FlyerState.init(A0_0, A1_1)
	A0_0._enemy_data = A1_1:enemy_data()
	A0_0._time_out = tweak_data.enemy.flyer.SELF_DESTROY_TIME
end
function FlyerSelfDestroyingState.enter(A0_2)
	A0_2._emitter:unit_self_destroying(A0_2._unit)
	managers.unit_scripting:unit_dead(A0_2._unit)
end
function FlyerSelfDestroyingState.leave(A0_3)
	A0_3._emitter:unit_self_destroyed(A0_3._unit)
end
function FlyerSelfDestroyingState.update(A0_4, A1_5)
	A0_4._time_out = A0_4._time_out - A1_5
	if A0_4._time_out < 0 then
		return FlyerDeadState:new(A0_4._unit)
	end
end
