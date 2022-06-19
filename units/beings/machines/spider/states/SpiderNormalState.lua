require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderPreAttackState")
require("units/beings/machines/spider/states/SpiderScanState")
require("units/beings/machines/spider/states/SpiderRotateToChargeState")
require("units/beings/machines/spider/states/SpiderStunState")
if not SpiderNormalState then
	SpiderNormalState = class(SpiderState)
end
SpiderNormalState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._input = l_1_0._unit:input()
	l_1_0._base = l_1_0._unit:base()
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._was_scanning = l_1_0._input:is_scanning()
end

SpiderNormalState.update = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._base:check_fully_damaged()
	if l_2_2 then
		return l_2_2
	end
	if l_2_0._enemy_data.is_stunned then
		local l_2_3, l_2_4 = SpiderStunState:new, SpiderStunState
		local l_2_5 = l_2_0._unit
		local l_2_6, l_2_10, l_2_14 = "normal"
		return l_2_3(l_2_4, l_2_5, l_2_6)
	else
		if l_2_0._input:attack_mode() or l_2_0._input:fire() then
			local l_2_7, l_2_8 = SpiderPreAttackState:new, SpiderPreAttackState
			local l_2_9 = l_2_0._unit
			return l_2_7(l_2_8, l_2_9)
		end
	else
		if l_2_0._enemy_data.scanning then
			local l_2_11, l_2_12 = SpiderScanState:new, SpiderScanState
			local l_2_13 = l_2_0._unit
			return l_2_11(l_2_12, l_2_13)
		end
	else
		if l_2_0._enemy_data.preparing_charge then
			local l_2_15, l_2_16 = SpiderRotateToChargeState:new, SpiderRotateToChargeState
			local l_2_17 = l_2_0._unit
			local l_2_18 = l_2_0._charge_direction
			return l_2_15(l_2_16, l_2_17, l_2_18)
		end
	end
	if l_2_0._enemy_data.stun_requested then
		l_2_0:_request_stun()
	else
		if l_2_0._input:charge_direction() then
			l_2_0._unit:play_redirect("rotate_to_charge")
			l_2_0._charge_direction = l_2_0._input:charge_direction()
		end
	else
		if l_2_0._input:is_scanning() and not l_2_0._was_scanning then
			l_2_0:_request_scan()
		end
	end
	l_2_0._was_scanning = l_2_0._input:is_scanning()
end


