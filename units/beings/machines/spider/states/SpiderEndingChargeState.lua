require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
if not SpiderEndingChargeState then
	SpiderEndingChargeState = class(SpiderState)
end
SpiderEndingChargeState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
end

SpiderEndingChargeState.update = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._base:check_fully_damaged()
	if l_2_2 then
		return l_2_2
	end
	if not l_2_0._enemy_data.ending_charge then
		local l_2_3, l_2_4 = SpiderNormalState:new, SpiderNormalState
		local l_2_5 = l_2_0._unit
		return l_2_3(l_2_4, l_2_5)
	end
end


