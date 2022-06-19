require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderPreAttackState")
require("units/beings/machines/spider/states/SpiderScanState")
require("units/beings/machines/spider/states/SpiderRotateToChargeState")
require("units/beings/machines/spider/states/SpiderStunState")
SpiderNormalState = SpiderNormalState or class(SpiderState)
function SpiderNormalState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._input = A0_0._unit:input()
	A0_0._base = A0_0._unit:base()
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._was_scanning = A0_0._input:is_scanning()
end
function SpiderNormalState.update(A0_2, A1_3)
	if A0_2._base:check_fully_damaged() then
		return (A0_2._base:check_fully_damaged())
	end
	if A0_2._enemy_data.is_stunned then
		return SpiderStunState:new(A0_2._unit, "normal")
	elseif A0_2._input:attack_mode() or A0_2._input:fire() then
		return SpiderPreAttackState:new(A0_2._unit)
	elseif A0_2._enemy_data.scanning then
		return SpiderScanState:new(A0_2._unit)
	elseif A0_2._enemy_data.preparing_charge then
		return SpiderRotateToChargeState:new(A0_2._unit, A0_2._charge_direction)
	end
	if A0_2._enemy_data.stun_requested then
		A0_2:_request_stun()
	elseif A0_2._input:charge_direction() then
		A0_2._unit:play_redirect("rotate_to_charge")
		A0_2._charge_direction = A0_2._input:charge_direction()
	elseif A0_2._input:is_scanning() and not A0_2._was_scanning then
		A0_2:_request_scan()
	end
	A0_2._was_scanning = A0_2._input:is_scanning()
end
