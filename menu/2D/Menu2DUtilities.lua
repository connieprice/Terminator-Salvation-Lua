local L0_0, L1_1
L0_0 = Menu2DUtilities
L0_0 = L0_0 or {}
Menu2DUtilities = L0_0
L0_0 = Menu2DUtilities
function L1_1(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10
	L3_5 = A1_3
	L2_4 = A1_3.world_shape
	L5_7 = L2_4(L3_5)
	L6_8 = Menu2DUtilities
	L6_8 = L6_8.is_position_over_rect
	L7_9 = A0_2
	L8_10 = L2_4
	return L6_8(L7_9, L8_10, L3_5, L4_6, L5_7)
end
L0_0.is_position_over_gui_object = L1_1
L0_0 = Menu2DUtilities
function L1_1(A0_11, A1_12, A2_13, A3_14, A4_15)
	local L5_16, L6_17
	L5_16 = A0_11.x
	L5_16 = A1_12 <= L5_16 and L5_16 <= L6_17 and A2_13 <= L5_16 and L5_16 <= L6_17
	return L5_16
end
L0_0.is_position_over_rect = L1_1
L0_0 = Menu2DUtilities
function L1_1(A0_18, A1_19)
	local L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26
	L3_21 = A1_19
	L2_20 = A1_19.world_shape
	L5_23 = L2_20(L3_21)
	L6_24 = Menu2DUtilities
	L6_24 = L6_24.position_over_rect
	L7_25 = A0_18
	L8_26 = L2_20
	return L6_24(L7_25, L8_26, L3_21, L4_22, L5_23)
end
L0_0.position_over_gui_object = L1_1
L0_0 = Menu2DUtilities
function L1_1(A0_27, A1_28, A2_29, A3_30, A4_31)
	if not Menu2DUtilities.is_position_over_rect(A0_27, A1_28, A2_29, A3_30, A4_31) then
		return nil, nil
	end
	return (A0_27.x - A1_28) / A3_30, (A0_27.y - A2_29) / A4_31
end
L0_0.position_over_rect = L1_1
