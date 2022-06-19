require("units/beings/machines/flyer/states/FlyerState")
require("units/beings/machines/flyer/states/FlyerDeadState")
if not FlyerFullyDamagedState then
	FlyerFullyDamagedState = class(FlyerState)
end
FlyerFullyDamagedState.enter = function(l_1_0)
	l_1_0._base:_disable_weapons()
	assert(l_1_0._base._fully_damage_to_dead_time)
	l_1_0._time_left = l_1_0._base._fully_damage_to_dead_time
	local l_1_1 = l_1_0._unit
	l_1_0._emitter:unit_fully_damaged(l_1_1)
	l_1_1:play_redirect("die")
	managers.unit_scripting:unit_dead(l_1_1)
end

FlyerFullyDamagedState.update = function(l_2_0, l_2_1)
	l_2_0._time_left = l_2_0._time_left - l_2_1
	if l_2_0._time_left <= 0 then
		local l_2_2, l_2_3 = FlyerDeadState:new, FlyerDeadState
		local l_2_4 = l_2_0._unit
		return l_2_2(l_2_3, l_2_4)
	end
end


