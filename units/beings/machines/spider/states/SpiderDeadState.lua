require("units/beings/machines/spider/states/SpiderState")
if not SpiderDeadState then
	SpiderDeadState = class(SpiderState)
end
SpiderDeadState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	local l_1_2 = l_1_0._unit:damage():fully_damaged_inflictor()
	if alive(l_1_2) then
		l_1_0._emitter:unit_killed_machine(l_1_2, l_1_0._unit)
	end
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._enemy_data.dead = true
end


