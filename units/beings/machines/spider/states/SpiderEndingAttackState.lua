require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
require("units/beings/machines/spider/states/SpiderStunState")
SpiderEndingAttackState = SpiderEndingAttackState or class(SpiderState)
function SpiderEndingAttackState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
end
function SpiderEndingAttackState.update(A0_2, A1_3)
	if A0_2._base:check_fully_damaged() then
		return (A0_2._base:check_fully_damaged())
	end
	if not A0_2._enemy_data.ending_attack then
		return SpiderNormalState:new(A0_2._unit)
	elseif A0_2._enemy_data.is_stunned then
		return SpiderStunState:new(A0_2._unit, "normal")
	end
	if A0_2._enemy_data.stun_requested then
		A0_2:_request_stun()
	end
end
