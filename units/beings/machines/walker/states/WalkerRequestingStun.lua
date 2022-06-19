require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerStunned")
if not WalkerRequestingStun then
	WalkerRequestingStun = class(WalkerState)
end
WalkerRequestingStun.init = function(l_1_0)
	WalkerState.init(l_1_0)
	local l_1_1 = l_1_0._unit
	l_1_0._enemy_data = l_1_1:enemy_data()
	local l_1_2 = l_1_0._base
	l_1_2:_set_can_move(false)
	l_1_2:_set_can_fire(false)
end

WalkerRequestingStun.exit = function(l_2_0)
	local l_2_1 = l_2_0._base
	l_2_1:_set_can_move(true)
	l_2_1:_set_can_fire(true)
end

WalkerRequestingStun.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._unit
	l_3_2:play_redirect("stun")
	if not l_3_0._enemy_data.pre_stunned then
		l_3_2:play_redirect("pre_stun")
	end
end

WalkerRequestingStun.transition = function(l_4_0)
	local l_4_1 = l_4_0._base:check_fully_damaged()
	if l_4_1 then
		return l_4_1
	end
	local l_4_2 = l_4_0._enemy_data
	if not l_4_2.pre_stunned and l_4_2.is_stunned then
		return WalkerStunned
	end
end


