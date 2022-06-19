require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
if not SpiderChargePunchState then
	SpiderChargePunchState = class(SpiderState)
end
SpiderChargePunchState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
end

SpiderChargePunchState.enter = function(l_2_0)
end

SpiderChargePunchState.leave = function(l_3_0)
	SpiderState.leave(l_3_0)
	l_3_0._enemy_data.charge_punch_hit = false
end

SpiderChargePunchState.update = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	if l_4_0._enemy_data.charge_punch_hit then
		l_4_0:_punch()
		l_4_0._enemy_data.charge_punch_hit = false
	else
		if not l_4_0._enemy_data.charge_punch then
			local l_4_3, l_4_4 = SpiderNormalState:new, SpiderNormalState
			local l_4_5 = l_4_0._unit
			return l_4_3(l_4_4, l_4_5)
		end
	end
end

SpiderChargePunchState._punch = function(l_5_0)
	local l_5_1 = 200
	local l_5_2 = 100
	local l_5_3 = 180
	local l_5_4 = l_5_0._unit:rotation()
	local l_5_5 = l_5_4:y()
	local l_5_6 = l_5_4:x()
	local l_5_7 = l_5_4:z()
	local l_5_8 = l_5_0._unit:position()
	local l_5_9 = managers.slot:get_mask("players")
	local l_5_10 = l_5_8 + l_5_5 * l_5_3 * 0.5 + l_5_7 * l_5_2 * 0.5
	local l_5_11 = l_5_6 * l_5_1 * 0.5
	local l_5_12 = l_5_5 * l_5_3 * 0.5
	local l_5_13 = l_5_7 * l_5_2 * 0.5
	local l_5_18 = World:find_units
	local l_5_19 = World
	l_5_18 = l_5_18(l_5_19, "obb", l_5_10, l_5_11, l_5_12, l_5_13, l_5_9)
	local l_5_14 = nil
	l_5_19 = pairs
	l_5_14 = l_5_18
	l_5_19 = l_5_19(l_5_14)
	for i_0,i_1 in l_5_19 do
		l_5_0:_apply_punch_damage(l_5_17)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SpiderChargePunchState._apply_punch_damage = function(l_6_0, l_6_1)
	if not l_6_1.damage then
		return 
	end
	local l_6_2 = l_6_1:position()
	local l_6_3 = l_6_1:rotation()
	local l_6_4 = l_6_0._unit:position() - l_6_2
	if l_6_4:length() > 0 then
		l_6_4 = l_6_4:normalized()
	else
		l_6_4 = l_6_3:y()
	end
	local l_6_5 = l_6_2 + l_6_4 * l_6_1:separate_distance()
	local l_6_6 = 1000
	local l_6_7 = 1000
	local l_6_8 = -l_6_4
	l_6_1:damage():damage_collision(l_6_0._unit, nil, l_6_4, l_6_5, l_6_8, l_6_7, l_6_6)
end


