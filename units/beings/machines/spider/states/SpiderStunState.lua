require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/states/StunState")
if not SpiderStunState then
	SpiderStunState = class(SpiderState)
end
SpiderStunState.init = function(l_1_0, l_1_1, l_1_2)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._stun_state = StunState:new(l_1_1, l_1_2, tweak_data.enemy.spider.STUN_TIME)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
end

SpiderStunState.enter = function(l_2_0)
	l_2_0._stun_state:enter()
	l_2_0:_set_can_move(false)
	l_2_0:_set_can_rotate(false)
end

SpiderStunState.leave = function(l_3_0)
	SpiderState.leave(l_3_0)
	l_3_0._stun_state:leave()
	l_3_0._enemy_data.stunned_sound = nil
end

SpiderStunState.update = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	local l_4_3 = l_4_0._stun_state:update(l_4_1)
	if not l_4_3 then
		local l_4_4, l_4_5 = SpiderNormalState:new, SpiderNormalState
		local l_4_6 = l_4_0._unit
		return l_4_4(l_4_5, l_4_6)
	end
end


