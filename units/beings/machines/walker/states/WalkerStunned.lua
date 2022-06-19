require("units/beings/machines/walker/states/WalkerState")
require("units/beings/machines/walker/states/WalkerOnGround")
WalkerStunned = WalkerStunned or class(WalkerState)
function WalkerStunned.init(A0_0)
	local L1_1
	L1_1 = WalkerState
	L1_1 = L1_1.init
	L1_1(A0_0)
	L1_1 = A0_0._unit
	A0_0._stun_state = StunState:new(L1_1, "exit_stun", walker_tweak_data.STUN_TIME)
	A0_0._enemy_data = L1_1:enemy_data()
	A0_0._stun_state:enter()
	A0_0._base:_set_can_move(false)
	A0_0._base:_set_can_fire(false)
end
function WalkerStunned.exit(A0_2)
	A0_2._stun_state:leave()
	A0_2._base:_set_can_move(true)
	A0_2._base:_set_can_fire(true)
end
function WalkerStunned.update(A0_3, A1_4)
	if not A0_3._stun_state:update(A1_4) then
		A0_3._stun_state_done = true
	end
end
function WalkerStunned.transition(A0_5)
	if A0_5._stun_state_done then
		return WalkerOnGround
	end
end
