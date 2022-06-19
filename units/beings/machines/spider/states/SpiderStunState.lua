require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/states/StunState")
SpiderStunState = SpiderStunState or class(SpiderState)
function SpiderStunState.init(A0_0, A1_1, A2_2)
	SpiderState.init(A0_0, A1_1)
	A0_0._stun_state = StunState:new(A1_1, A2_2, tweak_data.enemy.spider.STUN_TIME)
	A0_0._enemy_data = A0_0._unit:enemy_data()
end
function SpiderStunState.enter(A0_3)
	A0_3._stun_state:enter()
	A0_3:_set_can_move(false)
	A0_3:_set_can_rotate(false)
end
function SpiderStunState.leave(A0_4)
	SpiderState.leave(A0_4)
	A0_4._stun_state:leave()
	A0_4._enemy_data.stunned_sound = nil
end
function SpiderStunState.update(A0_5, A1_6)
	if A0_5._base:check_fully_damaged() then
		return (A0_5._base:check_fully_damaged())
	end
	if not A0_5._stun_state:update(A1_6) then
		return SpiderNormalState:new(A0_5._unit)
	end
end
