require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderNormalState")
SpiderChargePunchState = SpiderChargePunchState or class(SpiderState)
function SpiderChargePunchState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
end
function SpiderChargePunchState.enter(A0_2)
	local L1_3
end
function SpiderChargePunchState.leave(A0_4)
	SpiderState.leave(A0_4)
	A0_4._enemy_data.charge_punch_hit = false
end
function SpiderChargePunchState.update(A0_5, A1_6)
	if A0_5._base:check_fully_damaged() then
		return (A0_5._base:check_fully_damaged())
	end
	if A0_5._enemy_data.charge_punch_hit then
		A0_5:_punch()
		A0_5._enemy_data.charge_punch_hit = false
	elseif not A0_5._enemy_data.charge_punch then
		return SpiderNormalState:new(A0_5._unit)
	end
end
function SpiderChargePunchState._punch(A0_7)
	local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L15_22, L16_23, L17_24, L18_25, L19_26
	L1_8 = 200
	L2_9 = 100
	L3_10 = 180
	L4_11 = A0_7._unit
	L5_12 = L4_11
	L4_11 = L4_11.rotation
	L4_11 = L4_11(L5_12)
	L6_13 = L4_11
	L5_12 = L4_11.y
	L5_12 = L5_12(L6_13)
	L7_14 = L4_11
	L6_13 = L4_11.x
	L6_13 = L6_13(L7_14)
	L8_15 = L4_11
	L7_14 = L4_11.z
	L7_14 = L7_14(L8_15)
	L8_15 = A0_7._unit
	L9_16 = L8_15
	L8_15 = L8_15.position
	L8_15 = L8_15(L9_16)
	L9_16 = managers
	L9_16 = L9_16.slot
	L10_17 = L9_16
	L9_16 = L9_16.get_mask
	L11_18 = "players"
	L9_16 = L9_16(L10_17, L11_18)
	L10_17 = L5_12 * L3_10
	L10_17 = L10_17 * 0.5
	L10_17 = L8_15 + L10_17
	L11_18 = L7_14 * L2_9
	L11_18 = L11_18 * 0.5
	L10_17 = L10_17 + L11_18
	L11_18 = L6_13 * L1_8
	L11_18 = L11_18 * 0.5
	L12_19 = L5_12 * L3_10
	L12_19 = L12_19 * 0.5
	L13_20 = L7_14 * L2_9
	L13_20 = L13_20 * 0.5
	L14_21 = World
	L14_21 = L14_21.find_units
	L18_25 = L11_18
	L19_26 = L12_19
	L14_21 = L14_21(L15_22, L16_23, L17_24, L18_25, L19_26, L13_20, L9_16)
	for L18_25, L19_26 in L15_22(L16_23) do
		A0_7:_apply_punch_damage(L19_26)
	end
end
function SpiderChargePunchState._apply_punch_damage(A0_27, A1_28)
	local L2_29, L3_30, L4_31, L5_32, L6_33, L7_34, L8_35
	L2_29 = A1_28.damage
	if not L2_29 then
		return
	end
	L3_30 = A1_28
	L2_29 = A1_28.position
	L2_29 = L2_29(L3_30)
	L4_31 = A1_28
	L3_30 = A1_28.rotation
	L3_30 = L3_30(L4_31)
	L4_31 = A0_27._unit
	L5_32 = L4_31
	L4_31 = L4_31.position
	L4_31 = L4_31(L5_32)
	L4_31 = L4_31 - L2_29
	L6_33 = L4_31
	L5_32 = L4_31.length
	L5_32 = L5_32(L6_33)
	if L5_32 > 0 then
		L6_33 = L4_31
		L5_32 = L4_31.normalized
		L5_32 = L5_32(L6_33)
		L4_31 = L5_32
	else
		L6_33 = L3_30
		L5_32 = L3_30.y
		L5_32 = L5_32(L6_33)
		L4_31 = L5_32
	end
	L6_33 = A1_28
	L5_32 = A1_28.separate_distance
	L5_32 = L5_32(L6_33)
	L5_32 = L4_31 * L5_32
	L5_32 = L2_29 + L5_32
	L6_33 = 1000
	L7_34 = 1000
	L8_35 = -L4_31
	A1_28:damage():damage_collision(A0_27._unit, nil, L4_31, L5_32, L8_35, L7_34, L6_33)
end
