require("units/beings/machines/flyer/states/FlyerState")
if not FlyerDeadState then
	FlyerDeadState = class(FlyerState)
end
FlyerDeadState.init = function(l_1_0, l_1_1)
	FlyerState.init(l_1_0, l_1_1)
	local l_1_2 = l_1_0._emitter
	l_1_2:unit_dead(l_1_1)
	local l_1_3 = l_1_1:damage():fully_damaged_inflictor()
	if alive(l_1_3) then
		l_1_2:unit_killed_machine(l_1_3, l_1_1)
	end
end


