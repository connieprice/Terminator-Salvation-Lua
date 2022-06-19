require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
if not WalkerStunned then
	WalkerStunned = class(WalkerState)
end
WalkerStunned.init = function(l_1_0)
	WalkerState.init(l_1_0)
	local l_1_1 = l_1_0._unit
	l_1_0._stun_state = StunState:new(l_1_1, "exit_stun", walker_tweak_data.STUN_TIME)
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_0._stun_state:enter()
	local l_1_2 = l_1_0._base
	l_1_2:_set_can_move(false)
	l_1_2:_set_can_fire(false)
end

WalkerStunned.exit = function(l_2_0)
	l_2_0._stun_state:leave()
	local l_2_1 = l_2_0._base
	l_2_1:_set_can_move(true)
	l_2_1:_set_can_fire(true)
end

WalkerStunned.update = function(l_3_0, l_3_1)
	if not l_3_0._stun_state:update(l_3_1) then
		l_3_0._stun_state_done = true
	end
end

WalkerStunned.transition = function(l_4_0)
	if l_4_0._stun_state_done then
		return WalkerOnGround
	end
end


