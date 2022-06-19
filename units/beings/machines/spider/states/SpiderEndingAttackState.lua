require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
require("units/beings/machines/spider/states/SpiderStunState")
if not SpiderEndingAttackState then
	SpiderEndingAttackState = class(SpiderState)
end
SpiderEndingAttackState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
end

SpiderEndingAttackState.update = function(l_2_0, l_2_1)
	local l_2_6 = nil
	local l_2_2 = l_2_0._base:check_fully_damaged()
	if l_2_2 then
		return l_2_2
	end
	if not l_2_0._enemy_data.ending_attack then
		local l_2_3, l_2_4 = SpiderNormalState:new, SpiderNormalState
		local l_2_5 = l_2_0._unit
		return l_2_3(l_2_4, l_2_5)
	else
		if l_2_0._enemy_data.is_stunned then
			local l_2_7, l_2_8 = SpiderStunState:new, SpiderStunState
			local l_2_9 = l_2_0._unit
			local l_2_10 = "normal"
			return l_2_7(l_2_8, l_2_9, l_2_10)
		end
	end
	if l_2_0._enemy_data.stun_requested then
		l_2_0:_request_stun()
	end
end


