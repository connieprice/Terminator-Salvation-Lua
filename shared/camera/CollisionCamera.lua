require("shared/camera/SharedCamera")
CollisionCamera = CollisionCamera or class(SharedCamera)
function CollisionCamera.init(A0_0, A1_1)
	local L2_2, L3_3
	L2_2 = SharedCamera
	L2_2 = L2_2.init
	L3_3 = A0_0
	L2_2(L3_3, A1_1)
	L2_2 = SmoothPopController
	L2_2 = L2_2()
	A0_0._smooth_pop_controller = L2_2
	L2_2 = 2
	L3_3 = A0_0._smooth_pop_controller
	L3_3 = L3_3.set_parameter
	L3_3(L3_3, "min_r", L2_2)
	L3_3 = 0.2
	A0_0._smooth_pop_controller:set_parameter("indent", L3_3)
	A0_0._player_down = false
end
function CollisionCamera.update(A0_4, A1_5, A2_6, A3_7)
	local L4_8, L5_9, L6_10, L7_11, L8_12, L9_13, L10_14, L11_15, L12_16, L13_17, L14_18, L15_19
	L4_8 = SharedCamera
	L4_8 = L4_8.update
	L5_9 = A0_4
	L6_10 = A1_5
	L7_11 = A2_6
	L8_12 = A3_7
	L4_8(L5_9, L6_10, L7_11, L8_12)
	L4_8 = A0_4._smooth_pop_controller
	if not L4_8 then
		return
	end
	L5_9 = A0_4
	L4_8 = A0_4._evil_player_is_down_hack
	L6_10 = A1_5
	L4_8(L5_9, L6_10)
	L4_8 = A0_4._parent_unit
	L5_9 = L4_8
	L4_8 = L4_8.position
	L4_8 = L4_8(L5_9)
	L5_9 = A0_4._root_unit
	L6_10 = L5_9
	L5_9 = L5_9.get_object
	L7_11 = "Head"
	L5_9 = L5_9(L6_10, L7_11)
	L6_10 = nil
	if not L5_9 then
		L7_11 = A0_4._root_unit
		L8_12 = L7_11
		L7_11 = L7_11.orientation_object
		L7_11 = L7_11(L8_12)
		L8_12 = L7_11
		L7_11 = L7_11.position
		L7_11 = L7_11(L8_12)
		L6_10 = L7_11
	else
		L7_11 = A0_4._root_unit
		L8_12 = L7_11
		L7_11 = L7_11.get_object
		L9_13 = "Head"
		L7_11 = L7_11(L8_12, L9_13)
		L8_12 = L7_11
		L7_11 = L7_11.position
		L7_11 = L7_11(L8_12)
		L6_10 = L7_11
	end
	L7_11 = 40
	L8_12 = Vector3
	L9_13 = 0
	L10_14 = 0
	L11_15 = L7_11
	L8_12 = L8_12(L9_13, L10_14, L11_15)
	L8_12 = L6_10 + L8_12
	L9_13 = A0_4._player_down
	if L9_13 then
		L10_14 = L4_8
		L9_13 = L4_8.with_z
		L11_15 = math
		L11_15 = L11_15.max
		L12_16 = L4_8.z
		L13_17 = L6_10.z
		L15_19 = L11_15(L12_16, L13_17)
		L9_13 = L9_13(L10_14, L11_15, L12_16, L13_17, L14_18, L15_19, L11_15(L12_16, L13_17))
		L4_8 = L9_13
	end
	L9_13 = A0_4._smooth_pop_controller
	L10_14 = L9_13
	L9_13 = L9_13.wanted_position
	L11_15 = L6_10
	L12_16 = L4_8
	L9_13 = L9_13(L10_14, L11_15, L12_16)
	L10_14 = L6_10 - L4_8
	L11_15 = L10_14
	L10_14 = L10_14.length
	L10_14 = L10_14(L11_15)
	L11_15 = L9_13 - L4_8
	L12_16 = L11_15
	L11_15 = L11_15.length
	L11_15 = L11_15(L12_16)
	L12_16 = L11_15 / L10_14
	L13_17 = cat_print
	L14_18 = "close:"
	L15_19 = L12_16
	L14_18 = L14_18 .. L15_19
	L13_17(L14_18)
	L13_17 = L8_12 - L9_13
	L14_18 = L13_17 * L12_16
	L15_19 = L9_13
	if not A0_4._player_down then
		L15_19 = L15_19 + L14_18
	end
	A0_4:set_camera_position(L15_19)
end
function CollisionCamera._evil_player_is_down_hack(A0_20, A1_21)
	local L2_22
	L2_22 = A0_20._root_unit
	L2_22 = L2_22.player_data
	L2_22 = L2_22(L2_22)
	L2_22 = L2_22.is_down
	A0_20._player_down = L2_22
	L2_22 = A0_20._player_down
	if L2_22 then
		L2_22 = 100
		A0_20._smooth_pop_controller:set_parameter("min_r", L2_22)
	else
		L2_22 = 2
		A0_20._smooth_pop_controller:set_parameter("min_r", L2_22)
	end
	L2_22 = 0.2
	A0_20._smooth_pop_controller:set_parameter("indent", L2_22)
end
function CollisionCamera._debug_draw(A0_23, A1_24, A2_25, A3_26, A4_27)
	local L5_28, L6_29, L7_30, L8_31, L9_32
	L5_28 = Draw
	L6_29 = L5_28
	L5_28 = L5_28.brush
	L5_28 = L5_28(L6_29)
	L6_29 = 10
	L7_30 = Color
	L8_31 = 0
	L9_32 = 0
	L7_30 = L7_30(L8_31, L9_32, 1)
	L9_32 = L5_28
	L8_31 = L5_28.set_color
	L8_31(L9_32, L7_30)
	L9_32 = L5_28
	L8_31 = L5_28.sphere
	L8_31(L9_32, A2_25, L6_29)
	L8_31 = Color
	L9_32 = 0
	L8_31 = L8_31(L9_32, 1, 1)
	L9_32 = L5_28.set_color
	L9_32(L5_28, L8_31)
	L9_32 = L5_28.sphere
	L9_32(L5_28, A3_26, L6_29)
	L9_32 = Color
	L9_32 = L9_32(1, 1, 1)
	L5_28:set_color(L9_32)
	L5_28:line(A1_24, A4_27)
end
