require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
require("units/beings/machines/spider/states/SpiderEndingChargeState")
require("units/beings/machines/spider/states/SpiderChargePunchState")
if not SpiderChargeState then
	SpiderChargeState = class(SpiderState)
end
SpiderChargeState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._damage = l_1_0._unit:base()._charge_damage
end

SpiderChargeState.enter = function(l_2_0)
	l_2_0:_update_damage()
end

SpiderChargeState.leave = function(l_3_0)
	SpiderState.leave(l_3_0)
	if l_3_0:_damage_enabled() then
		l_3_0:_disable_damage()
	end
end

SpiderChargeState.update = function(l_4_0, l_4_1)
	local l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_15, l_4_16, l_4_17, l_4_18, l_4_19, l_4_20, l_4_24, l_4_25, l_4_26, l_4_27, l_4_28, l_4_29 = nil
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	if l_4_0._enemy_data.ending_charge then
		local l_4_3, l_4_4 = SpiderEndingChargeState:new, SpiderEndingChargeState
		local l_4_5 = l_4_0._unit
		return l_4_3(l_4_4, l_4_5)
	else
		if l_4_0._enemy_data.charge_punch then
			local l_4_12, l_4_13 = SpiderChargePunchState:new, SpiderChargePunchState
			local l_4_14 = l_4_0._unit
			return l_4_12(l_4_13, l_4_14)
		end
	else
		if not l_4_0._enemy_data.charging then
			local l_4_21, l_4_22 = SpiderNormalState:new, SpiderNormalState
			local l_4_23 = l_4_0._unit
			return l_4_21(l_4_22, l_4_23)
		end
	end
	local l_4_30 = l_4_0._unit:input():charge_direction()
	if l_4_30 then
		local l_4_31 = l_4_0._unit
		local l_4_32 = l_4_31:rotation()
		local l_4_33 = l_4_30:flat(l_4_32:z()):normalized()
		local l_4_34 = Rotation(l_4_33, l_4_32:z())
		l_4_32 = l_4_32:slerp(l_4_34, 6 * l_4_1)
		l_4_31:set_rotation(l_4_32)
	end
	l_4_0:_update_damage()
	if l_4_0:_damage_enabled() and l_4_0:_should_punch() then
		l_4_0._unit:play_redirect("end_charge_punch")
	else
	if not l_4_30 then
		end
		l_4_0._unit:play_redirect("end_charge_normal")
	end
	 -- WARNING: undefined locals caused missing assignments!
end

SpiderChargeState._should_punch = function(l_5_0)
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
	local l_5_14 = World:find_units("obb", l_5_10, l_5_11, l_5_12, l_5_13, l_5_9)
	return #l_5_14 > 0
end

SpiderChargeState.mover_collision_callback = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6)
	local l_6_7 = assert
	l_6_7(l_6_1 ~= l_6_2)
	l_6_7 = l_6_0._unit
	l_6_7(l_6_7, "end_charge_punch")
end

SpiderChargeState._update_damage = function(l_7_0)
	if l_7_0._enemy_data.enable_collision_damage and not l_7_0:_damage_enabled() then
		l_7_0:_enable_damage()
	end
	do return end
	if l_7_0:_damage_enabled() then
		l_7_0:_disable_damage()
	end
end

SpiderChargeState._enable_damage = function(l_8_0)
	assert(not l_8_0._mover_collision_callback_id)
	l_8_0._mover_collision_callback_id = l_8_0._unit:damage():add_mover_collision_callback(callback(l_8_0, l_8_0, "mover_collision_callback"))
	assert(l_8_0._mover_collision_callback_id)
end

SpiderChargeState._disable_damage = function(l_9_0)
	assert(l_9_0._mover_collision_callback_id)
	l_9_0._unit:damage():remove_mover_collision_callback(l_9_0._mover_collision_callback_id)
	l_9_0._mover_collision_callback_id = nil
end

SpiderChargeState._damage_enabled = function(l_10_0)
	return l_10_0._mover_collision_callback_id ~= nil
end


