require("units/beings/machines/flyer/states/FlyerState")
require("units/beings/machines/flyer/states/FlyerDeadState")
if not FlyerSelfDestroyingState then
	FlyerSelfDestroyingState = class(FlyerState)
end
FlyerSelfDestroyingState.init = function(l_1_0, l_1_1)
	FlyerState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_0._time_out = tweak_data.enemy.flyer.SELF_DESTROY_TIME
end

FlyerSelfDestroyingState.enter = function(l_2_0)
	l_2_0._emitter:unit_self_destroying(l_2_0._unit)
	managers.unit_scripting:unit_dead(l_2_0._unit)
end

FlyerSelfDestroyingState.leave = function(l_3_0)
	l_3_0._emitter:unit_self_destroyed(l_3_0._unit)
end

FlyerSelfDestroyingState.update = function(l_4_0, l_4_1)
	l_4_0._time_out = l_4_0._time_out - l_4_1
	if l_4_0._time_out < 0 then
		local l_4_2, l_4_3 = FlyerDeadState:new, FlyerDeadState
		local l_4_4 = l_4_0._unit
		return l_4_2(l_4_3, l_4_4)
	end
end


