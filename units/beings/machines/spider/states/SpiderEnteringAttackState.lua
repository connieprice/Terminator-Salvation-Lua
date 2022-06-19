require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderAttackingState")
if not SpiderEnteringAttackState then
	SpiderEnteringAttackState = class(SpiderState)
end
SpiderEnteringAttackState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
end

SpiderEnteringAttackState.enter = function(l_2_0)
	l_2_0._unit:play_redirect("enter_attack")
	l_2_0._enemy_data.preparing_to_fire = true
	l_2_0:_set_can_move(false)
	l_2_0:_set_can_rotate(false)
end

SpiderEnteringAttackState.leave = function(l_3_0)
	SpiderState.leave(l_3_0)
	l_3_0._enemy_data.preparing_to_fire = false
end

SpiderEnteringAttackState.update = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	if l_4_0._enemy_data.is_stunned then
		local l_4_3, l_4_4 = SpiderStunState:new, SpiderStunState
		local l_4_5 = l_4_0._unit
		local l_4_6, l_4_10 = "attack"
		return l_4_3(l_4_4, l_4_5, l_4_6)
	else
		if l_4_0._enemy_data.attacking then
			local l_4_7, l_4_8 = SpiderAttackingState:new, SpiderAttackingState
			local l_4_9 = l_4_0._unit
			return l_4_7(l_4_8, l_4_9)
		end
	end
	if l_4_0._enemy_data.stun_requested then
		l_4_0:_request_stun()
	end
end


