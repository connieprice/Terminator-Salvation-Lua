require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
require("units/beings/machines/walker/states/WalkerDead")
if not WalkerFullyDamagedState then
	WalkerFullyDamagedState = class(WalkerState)
end
WalkerFullyDamagedState.init = function(l_1_0)
	WalkerState.init(l_1_0)
	local l_1_1 = l_1_0._unit
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_1:play_redirect("die")
	local l_1_2 = l_1_0._base
	l_1_2:_set_can_move(false)
	l_1_2:_set_can_fire(false)
	managers.unit_scripting:unit_dead(l_1_1)
	l_1_0._emitter:unit_fully_damaged(l_1_1)
end

WalkerFullyDamagedState.exit = function(l_2_0)
	local l_2_1 = l_2_0._base
	l_2_1:_set_can_move(true)
	l_2_1:_set_can_fire(true)
end

WalkerFullyDamagedState.transition = function(l_3_0)
	if l_3_0._enemy_data.death_animation_done then
		return WalkerDead
	end
end


