require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
if not WalkerDead then
	WalkerDead = class(WalkerState)
end
WalkerDead.init = function(l_1_0)
	WalkerState.init(l_1_0)
	local l_1_1 = l_1_0._unit
	l_1_0._enemy_data = l_1_1:enemy_data()
	local l_1_2 = l_1_0._base
	l_1_2:_set_can_move(false)
	l_1_2:_set_can_fire(false)
	l_1_1:kill_mover()
	local l_1_3 = l_1_1:damage():fully_damaged_inflictor()
	if alive(l_1_3) then
		l_1_0._emitter:unit_killed_machine(l_1_3, l_1_1)
	end
end

WalkerDead.exit = function(l_2_0)
	local l_2_1 = l_2_0._base
	l_2_1:_set_can_move(true)
	l_2_1:_set_can_fire(true)
	local l_2_2 = l_2_0._unit
	l_2_2:activate_mover("default")
end

WalkerDead.transition = function(l_3_0)
end


