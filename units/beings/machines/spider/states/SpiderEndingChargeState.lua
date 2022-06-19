require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
SpiderEndingChargeState = SpiderEndingChargeState or class(SpiderState)
function SpiderEndingChargeState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
end
function SpiderEndingChargeState.update(A0_2, A1_3)
	if A0_2._base:check_fully_damaged() then
		return (A0_2._base:check_fully_damaged())
	end
	if not A0_2._enemy_data.ending_charge then
		return SpiderNormalState:new(A0_2._unit)
	end
end
