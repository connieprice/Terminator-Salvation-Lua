local L0_0, L1_1
function L0_0()
	local L0_2, L1_3
	L0_2 = assert
	L1_3 = managers
	L1_3 = L1_3.user_viewport
	L0_2(L1_3)
	L0_2 = next
	L1_3 = managers
	L1_3 = L1_3.user_viewport
	L1_3 = L1_3.viewports
	L1_3 = L1_3(L1_3)
	L1_3 = L0_2(L1_3, nil)
	return L0_2, L1_3
end
function L1_1(A0_4)
	local L1_5
	L1_5 = _UPVALUE0_
	L1_5 = L1_5()
	assert(L1_5)
	L1_5:control_unit(A0_4)
end
control_unit = L1_1
function L1_1(A0_6)
	local L1_7, L2_8
	L1_7 = _UPVALUE0_
	L2_8 = L1_7()
	assert(L2_8)
	L2_8:view_unit(A0_6)
end
view_unit = L1_1
function L1_1()
	local L0_9, L1_10, L2_11, L3_12
	L0_9 = _UPVALUE0_
	L1_10 = L0_9()
	L2_11 = assert
	L3_12 = L0_9
	L2_11(L3_12)
	L2_11 = assert
	L3_12 = L1_10
	L2_11(L3_12)
	L3_12 = L0_9
	L2_11 = L0_9.assigned_unit
	L2_11 = L2_11(L3_12)
	L3_12 = L0_9.control_unit
	L3_12(L0_9, L2_11)
	L3_12 = L1_10.view_unit
	L3_12(L1_10, L2_11)
end
reset_view_and_control = L1_1
function L1_1()
	local L0_13, L1_14, L2_15, L3_16, L4_17, L5_18, L6_19, L7_20, L8_21, L9_22, L10_23, L11_24, L12_25
	L0_13 = 10
	L1_14 = _UPVALUE0_
	L2_15 = L1_14()
	L3_16 = assert
	L4_17 = L2_15
	L3_16(L4_17)
	L4_17 = L2_15
	L3_16 = L2_15.engine_camera
	L3_16 = L3_16(L4_17)
	L4_17 = assert
	L5_18 = L3_16
	L4_17(L5_18)
	L5_18 = L3_16
	L4_17 = L3_16.position
	L4_17 = L4_17(L5_18)
	L6_19 = L3_16
	L5_18 = L3_16.new_rotation
	L5_18 = L5_18(L6_19)
	L6_19 = L5_18
	L5_18 = L5_18.y
	L5_18 = L5_18(L6_19)
	L7_20 = L3_16
	L6_19 = L3_16.far_range
	L6_19 = L6_19(L7_20)
	L7_20 = managers
	L7_20 = L7_20.slot
	L8_21 = L7_20
	L7_20 = L7_20.get_mask
	L9_22 = "players"
	L10_23 = "friends"
	L11_24 = "enemies"
	L7_20 = L7_20(L8_21, L9_22, L10_23, L11_24)
	L9_22 = L2_15
	L8_21 = L2_15.viewed_unit
	L8_21 = L8_21(L9_22)
	L9_22 = math
	L9_22 = L9_22.sin
	L10_23 = L0_13
	L9_22 = L9_22(L10_23)
	L9_22 = L9_22 * L6_19
	L10_23 = World
	L11_24 = L10_23
	L10_23 = L10_23.find_units
	L12_25 = "cone"
	L10_23 = L10_23(L11_24, L12_25, L4_17, L4_17 + L6_19 * L5_18, L9_22, L7_20)
	L11_24, L12_25 = nil, nil
	for 