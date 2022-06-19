require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderChargeState")
if not SpiderRotateToChargeState then
	SpiderRotateToChargeState = class(SpiderState)
end
SpiderRotateToChargeState.init = function(l_1_0, l_1_1, l_1_2)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._target_direction = l_1_2:normalized()
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0:_set_can_move(false)
	l_1_0:_set_can_rotate(false)
end

SpiderRotateToChargeState.update = function(l_2_0, l_2_1)
	local l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_17, l_2_18, l_2_19, l_2_20, l_2_21, l_2_22, l_2_23 = nil
	local l_2_2 = l_2_0._base:check_fully_damaged()
	if l_2_2 then
		return l_2_2
	end
	local l_2_3 = l_2_0._unit
	if l_2_0._enemy_data.charging then
		local l_2_4, l_2_5 = SpiderChargeState:new, SpiderChargeState
		local l_2_6 = l_2_3
		return l_2_4(l_2_5, l_2_6)
	else
		if l_2_0._enemy_data.ending_charge then
			local l_2_14, l_2_15 = SpiderEndingChargeState:new, SpiderEndingChargeState
			local l_2_16 = l_2_3
			return l_2_14(l_2_15, l_2_16)
		end
	end
	l_2_0._target_direction = l_2_0._unit:input():charge_direction()
	local l_2_24 = "end_charge_normal"
	if l_2_0._target_direction then
		local l_2_25 = 7
		local l_2_26 = l_2_3:rotation()
		local l_2_27 = l_2_26:y()
		local l_2_28 = l_2_0._target_direction:flat(l_2_26:z()):normalized()
		local l_2_29 = l_2_26:x()
		local l_2_30 = math.acos(math.dot(l_2_27, l_2_28))
		if l_2_30 <= l_2_25 then
			l_2_24 = "charge"
		end
	else
		if math.dot(l_2_29, l_2_28) > 0 then
			l_2_24 = "rotate_right"
		end
	else
		l_2_24 = "rotate_left"
	end
	l_2_3:play_redirect(l_2_24)
end


