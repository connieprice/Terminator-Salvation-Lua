DualSphereSmoothPopController = DualSphereSmoothPopController or class()
function DualSphereSmoothPopController.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._min_r = A1_1
	A0_0._indent = A2_2
	A0_0._ignore_unit = A3_3
end
function DualSphereSmoothPopController.wanted_position(A0_4, A1_5, A2_6, A3_7)
	local L4_8, L5_9, L6_10, L7_11, L8_12, L9_13, L10_14, L11_15, L12_16, L13_17, L14_18, L15_19, L16_20, L17_21, L18_22, L19_23, L20_24, L21_25, L22_26, L23_27, L24_28, L25_29, L26_30, L27_31
	L4_8 = 0.01
	L5_9, L6_10 = nil, nil
	L7_11 = A2_6 - A1_5
	L9_13 = L7_11
	L8_12 = L7_11.length
	L8_12 = L8_12(L9_13)
	if L4_8 >= L8_12 then
		return A1_5
	end
	L9_13 = 20
	L10_14 = 40
	L11_15 = L7_11 / L8_12
	L12_16 = 0
	L13_17 = L11_15 * L12_16
	L13_17 = A1_5 - L13_17
	L14_18 = A2_6
	L15_19 = {
		L16_20,
		L17_21,
		L18_22,
		L19_23,
		L20_24,
		L21_25,
		L22_26
	}
	L16_20 = "ray"
	L17_21 = L13_17
	L18_22 = L14_18
	L19_23 = "ray_type"
	L20_24 = "camera"
	L21_25 = "sphere_cast_radius"
	L22_26 = L9_13
	L16_20 = A0_4._ignore_unit
	if L16_20 then
		L16_20 = table
		L16_20 = L16_20.insert
		L17_21 = L15_19
		L18_22 = "ignore_unit"
		L16_20(L17_21, L18_22)
		L16_20 = table
		L16_20 = L16_20.insert
		L17_21 = L15_19
		L18_22 = A0_4._ignore_unit
		L16_20(L17_21, L18_22)
	end
	L16_20 = World
	L17_21 = L16_20
	L16_20 = L16_20.raycast
	L18_22 = unpack
	L19_23 = L15_19
	L27_31 = L18_22(L19_23)
	L16_20 = L16_20(L17_21, L18_22, L19_23, L20_24, L21_25, L22_26, L23_27, L24_28, L25_29, L26_30, L27_31, L18_22(L19_23))
	L17_21 = 0
	L18_22 = L11_15 * L17_21
	L18_22 = A1_5 - L18_22
	L19_23 = A2_6
	L20_24 = {
		L21_25,
		L22_26,
		L23_27,
		L24_28,
		L25_29,
		L26_30,
		L27_31
	}
	L21_25 = "ray"
	L22_26 = L18_22
	L23_27 = L19_23
	L24_28 = "ray_type"
	L25_29 = "camera"
	L26_30 = "sphere_cast_radius"
	L27_31 = L10_14
	L21_25 = A0_4._ignore_unit
	if L21_25 then
		L21_25 = table
		L21_25 = L21_25.insert
		L22_26 = L20_24
		L23_27 = "ignore_unit"
		L21_25(L22_26, L23_27)
		L21_25 = table
		L21_25 = L21_25.insert
		L22_26 = L20_24
		L23_27 = A0_4._ignore_unit
		L21_25(L22_26, L23_27)
	end
	L21_25 = World
	L22_26 = L21_25
	L21_25 = L21_25.raycast
	L23_27 = unpack
	L24_28 = L20_24
	L27_31 = L23_27(L24_28)
	L21_25 = L21_25(L22_26, L23_27, L24_28, L25_29, L26_30, L27_31, L23_27(L24_28))
	if L21_25 then
		L22_26 = nil
		if L16_20 then
			L23_27 = L16_20.distance
			L22_26 = L23_27 - L12_16
		else
			L22_26 = L8_12
		end
		L23_27 = L21_25.hit_position
		L24_28 = L21_25.position
		L23_27 = L23_27 - L24_28
		L25_29 = L7_11
		L24_28 = L7_11.angle
		L26_30 = L23_27
		L24_28 = L24_28(L25_29, L26_30)
		L25_29 = assert
		L26_30 = L24_28 >= 0 and L24_28 <= 90
		L27_31 = L24_28
		L25_29(L26_30, L27_31)
		L25_29 = L21_25.distance
		L25_29 = L25_29 - L17_21
		L25_29 = L25_29 + L10_14
		L26_30 = L24_28 / 90
		L27_31 = L26_30 * L8_12
		L27_31 = L27_31 + (1 - L26_30) * L25_29
		L27_31 = math.clamp(L27_31, 0, L22_26)
		L6_10 = A1_5 + L27_31 * L11_15
	else
		L6_10 = A2_6
	end
	A0_4._last_distance = L5_9
	return L6_10
end
