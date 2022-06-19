require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
require("units/beings/machines/spider/states/SpiderEndingChargeState")
require("units/beings/machines/spider/states/SpiderChargePunchState")
SpiderChargeState = SpiderChargeState or class(SpiderState)
function SpiderChargeState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._damage = A0_0._unit:base()._charge_damage
end
function SpiderChargeState.enter(A0_2)
	A0_2:_update_damage()
end
function SpiderChargeState.leave(A0_3)
	SpiderState.leave(A0_3)
	if A0_3:_damage_enabled() then
		A0_3:_disable_damage()
	end
end
function SpiderChargeState.update(A0_4, A1_5)
	local L2_6, L3_7, L4_8, L5_9, L6_10, L7_11
	L2_6 = A0_4._base
	L3_7 = L2_6
	L2_6 = L2_6.check_fully_damaged
	L2_6 = L2_6(L3_7)
	if L2_6 then
		return L2_6
	end
	L3_7 = A0_4._enemy_data
	L3_7 = L3_7.ending_charge
	if L3_7 then
		L3_7 = SpiderEndingChargeState
		L4_8 = L3_7
		L3_7 = L3_7.new
		L5_9 = A0_4._unit
		return L3_7(L4_8, L5_9)
	else
		L3_7 = A0_4._enemy_data
		L3_7 = L3_7.charge_punch
		if L3_7 then
			L3_7 = SpiderChargePunchState
			L4_8 = L3_7
			L3_7 = L3_7.new
			L5_9 = A0_4._unit
			return L3_7(L4_8, L5_9)
		else
			L3_7 = A0_4._enemy_data
			L3_7 = L3_7.charging
			if not L3_7 then
				L3_7 = SpiderNormalState
				L4_8 = L3_7
				L3_7 = L3_7.new
				L5_9 = A0_4._unit
				return L3_7(L4_8, L5_9)
			end
		end
	end
	L3_7 = A0_4._unit
	L4_8 = L3_7
	L3_7 = L3_7.input
	L3_7 = L3_7(L4_8)
	L4_8 = L3_7
	L3_7 = L3_7.charge_direction
	L3_7 = L3_7(L4_8)
	if L3_7 then
		L4_8 = A0_4._unit
		L6_10 = L4_8
		L5_9 = L4_8.rotation
		L5_9 = L5_9(L6_10)
		L7_11 = L3_7
		L6_10 = L3_7.flat
		L6_10 = L6_10(L7_11, L5_9:z())
		L7_11 = L6_10
		L6_10 = L6_10.normalized
		L6_10 = L6_10(L7_11)
		L7_11 = Rotation
		L7_11 = L7_11(L6_10, L5_9:z())
		L5_9 = L5_9:slerp(L7_11, 6 * A1_5)
		L4_8:set_rotation(L5_9)
	end
	L5_9 = A0_4
	L4_8 = A0_4._update_damage
	L4_8(L5_9)
	L5_9 = A0_4
	L4_8 = A0_4._damage_enabled
	L4_8 = L4_8(L5_9)
	if L4_8 then
		L5_9 = A0_4
		L4_8 = A0_4._should_punch
		L4_8 = L4_8(L5_9)
		if L4_8 then
			L4_8 = A0_4._unit
			L5_9 = L4_8
			L4_8 = L4_8.play_redirect
			L6_10 = "end_charge_punch"
			L4_8(L5_9, L6_10)
		end
	else
		L4_8 = A0_4._unit
		L5_9 = L4_8
		L4_8 = L4_8.input
		L4_8 = L4_8(L5_9)
		L5_9 = L4_8
		L4_8 = L4_8.charge_direction
		L4_8 = L4_8(L5_9)
		L4_8 = L4_8 ~= nil
		if not L3_7 then
			L5_9 = A0_4._unit
			L6_10 = L5_9
			L5_9 = L5_9.play_redirect
			L7_11 = "end_charge_normal"
			L5_9(L6_10, L7_11)
		end
	end
end
function SpiderChargeState._should_punch(A0_12)
	local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21, L10_22, L11_23, L12_24, L13_25
	L1_13 = 200
	L2_14 = 100
	L3_15 = 180
	L4_16 = A0_12._unit
	L5_17 = L4_16
	L4_16 = L4_16.rotation
	L4_16 = L4_16(L5_17)
	L6_18 = L4_16
	L5_17 = L4_16.y
	L5_17 = L5_17(L6_18)
	L7_19 = L4_16
	L6_18 = L4_16.x
	L6_18 = L6_18(L7_19)
	L8_20 = L4_16
	L7_19 = L4_16.z
	L7_19 = L7_19(L8_20)
	L8_20 = A0_12._unit
	L9_21 = L8_20
	L8_20 = L8_20.position
	L8_20 = L8_20(L9_21)
	L9_21 = managers
	L9_21 = L9_21.slot
	L10_22 = L9_21
	L9_21 = L9_21.get_mask
	L11_23 = "players"
	L9_21 = L9_21(L10_22, L11_23)
	L10_22 = L5_17 * L3_15
	L10_22 = L10_22 * 0.5
	L10_22 = L8_20 + L10_22
	L11_23 = L7_19 * L2_14
	L11_23 = L11_23 * 0.5
	L10_22 = L10_22 + L11_23
	L11_23 = L6_18 * L1_13
	L11_23 = L11_23 * 0.5
	L12_24 = L5_17 * L3_15
	L12_24 = L12_24 * 0.5
	L13_25 = L7_19 * L2_14
	L13_25 = L13_25 * 0.5
	return #World:find_units("obb", L10_22, L11_23, L12_24, L13_25, L9_21) > 0
end
function SpiderChargeState.mover_collision_callback(A0_26, A1_27, A2_28, A3_29, A4_30, A5_31, A6_32)
	assert(A1_27 ~= A2_28)
	A0_26._unit:play_redirect("end_charge_punch")
end
function SpiderChargeState._update_damage(A0_33)
	if A0_33._enemy_data.enable_collision_damage then
		if not A0_33:_damage_enabled() then
			A0_33:_enable_damage()
		end
	elseif A0_33:_damage_enabled() then
		A0_33:_disable_damage()
	end
end
function SpiderChargeState._enable_damage(A0_34)
	assert(not A0_34._mover_collision_callback_id)
	A0_34._mover_collision_callback_id = A0_34._unit:damage():add_mover_collision_callback(callback(A0_34, A0_34, "mover_collision_callback"))
	assert(A0_34._mover_collision_callback_id)
end
function SpiderChargeState._disable_damage(A0_35)
	assert(A0_35._mover_collision_callback_id)
	A0_35._unit:damage():remove_mover_collision_callback(A0_35._mover_collision_callback_id)
	A0_35._mover_collision_callback_id = nil
end
function SpiderChargeState._damage_enabled(A0_36)
	return A0_36._mover_collision_callback_id ~= nil
end
