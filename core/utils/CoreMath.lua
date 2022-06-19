core:module("CoreMath")
nice = math.nice
function rgb_to_hsv(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5, L6_6, L7_7
	L3_3 = math
	L3_3 = L3_3.max
	L4_4 = A0_0
	L5_5 = A1_1
	L6_6 = A2_2
	L3_3 = L3_3(L4_4, L5_5, L6_6)
	L4_4 = math
	L4_4 = L4_4.min
	L5_5 = A0_0
	L6_6 = A1_1
	L7_7 = A2_2
	L4_4 = L4_4(L5_5, L6_6, L7_7)
	L5_5 = 0
	if L3_3 == L4_4 then
		L5_5 = 0
	elseif L3_3 == A0_0 and A2_2 <= A1_1 then
		L6_6 = A1_1 - A2_2
		L6_6 = 60 * L6_6
		L7_7 = L3_3 - L4_4
		L5_5 = L6_6 / L7_7
	elseif L3_3 == A0_0 and A1_1 < A2_2 then
		L6_6 = A1_1 - A2_2
		L6_6 = 60 * L6_6
		L7_7 = L3_3 - L4_4
		L6_6 = L6_6 / L7_7
		L5_5 = L6_6 + 360
	elseif L3_3 == A1_1 then
		L6_6 = A2_2 - A0_0
		L6_6 = 60 * L6_6
		L7_7 = L3_3 - L4_4
		L6_6 = L6_6 / L7_7
		L5_5 = L6_6 + 120
	elseif L3_3 == A2_2 then
		L6_6 = A0_0 - A1_1
		L6_6 = 60 * L6_6
		L7_7 = L3_3 - L4_4
		L6_6 = L6_6 / L7_7
		L5_5 = L6_6 + 240
	end
	L6_6 = math
	L6_6 = L6_6.fmod
	L7_7 = L5_5
	L6_6 = L6_6(L7_7, 360)
	L5_5 = L6_6
	if L3_3 == 0 then
		L6_6 = 0
	elseif not L6_6 then
		L6_6 = L4_4 / L3_3
		L6_6 = 1 - L6_6
	end
	L7_7 = L3_3
	return L5_5, L6_6, L7_7
end
function hsv_to_rgb(A0_8, A1_9, A2_10)
	local L3_11, L4_12, L5_13, L6_14, L7_15
	L3_11 = math
	L3_11 = L3_11.floor
	L4_12 = A0_8 / 60
	L3_11 = L3_11(L4_12)
	L4_12 = A0_8 / 60
	L4_12 = L4_12 - L3_11
	L5_13 = 1 - A1_9
	L5_13 = A2_10 * L5_13
	L6_14 = L4_12 * A1_9
	L6_14 = 1 - L6_14
	L6_14 = A2_10 * L6_14
	L7_15 = 1 - L4_12
	L7_15 = L7_15 * A1_9
	L7_15 = 1 - L7_15
	L7_15 = A2_10 * L7_15
	return unpack(({
		[0] = {
			A2_10,
			L7_15,
			L5_13
		},
		[1] = {
			L6_14,
			A2_10,
			L5_13
		},
		[2] = {
			L5_13,
			A2_10,
			L7_15
		},
		[3] = {
			L5_13,
			L6_14,
			A2_10
		},
		[4] = {
			L7_15,
			L5_13,
			A2_10
		},
		[5] = {
			A2_10,
			L5_13,
			L6_14
		}
	})[math.fmod(L3_11, 6)])
end
function string_to_value(A0_16, A1_17)
	if A0_16 == "number" then
		return tonumber(A1_17)
	elseif A0_16 == "boolean" then
		return toboolean(A1_17)
	elseif A0_16 == "Vector3" then
		return math.string_to_vector(A1_17)
	elseif A0_16 == "Rotation" then
		return math.string_to_rotation(A1_17)
	elseif A0_16 == "table" then
		return {}
	elseif A0_16 == "nil" then
		return nil
	end
	return A1_17
end
function vector_to_string(A0_18, A1_19)
	local L2_20, L3_21, L4_22
	if A1_19 then
		L2_20 = string
		L2_20 = L2_20.format
		L3_21 = A1_19
		L4_22 = A0_18.x
		L2_20 = L2_20(L3_21, L4_22)
		L3_21 = string
		L3_21 = L3_21.format
		L4_22 = A1_19
		L3_21 = L3_21(L4_22, A0_18.y)
		L4_22 = string
		L4_22 = L4_22.format
		L4_22 = L4_22(A1_19, A0_18.z)
		return L2_20 .. " " .. L3_21 .. " " .. L4_22
	end
	L2_20 = A0_18.x
	L3_21 = " "
	L4_22 = A0_18.y
	L2_20 = L2_20 .. L3_21 .. L4_22 .. " " .. A0_18.z
	return L2_20
end
function rotation_to_string(A0_23, A1_24)
	local L2_25, L3_26, L4_27
	if A1_24 then
		L2_25 = string
		L2_25 = L2_25.format
		L3_26 = A1_24
		L4_27 = A0_23.yaw
		L4_27 = L4_27(A0_23)
		L2_25 = L2_25(L3_26, L4_27, L4_27(A0_23))
		L3_26 = string
		L3_26 = L3_26.format
		L4_27 = A1_24
		L3_26 = L3_26(L4_27, A0_23:pitch())
		L4_27 = string
		L4_27 = L4_27.format
		L4_27 = L4_27(A1_24, A0_23:roll())
		return L2_25 .. " " .. L3_26 .. " " .. L4_27
	end
	L3_26 = A0_23
	L2_25 = A0_23.yaw
	L2_25 = L2_25(L3_26)
	L3_26 = " "
	L4_27 = A0_23.pitch
	L4_27 = L4_27(A0_23)
	L2_25 = L2_25 .. L3_26 .. L4_27 .. " " .. A0_23:roll()
	return L2_25
end
function width_mul()
	local L0_28, L1_29
	L0_28 = core_setup
	L0_28 = L0_28.aspect_ratio
	L0_28 = 0.75 * L0_28
	return L0_28
end
function wire_set_midpoint(A0_30, A1_31, A2_32, A3_33)
	local L4_34, L5_35, L6_36
	L5_35 = A0_30
	L4_34 = A0_30.get_object
	L6_36 = A1_31
	L4_34 = L4_34(L5_35, L6_36)
	L5_35 = L4_34
	L4_34 = L4_34.position
	L4_34 = L4_34(L5_35)
	L6_36 = A0_30
	L5_35 = A0_30.get_object
	L5_35 = L5_35(L6_36, A2_32)
	L6_36 = L5_35
	L5_35 = L5_35.position
	L5_35 = L5_35(L6_36)
	L6_36 = L5_35 - L4_34
	L6_36 = L6_36.normalized
	L6_36 = L6_36(L6_36)
	L6_36 = L6_36.cross
	L6_36 = L6_36(L6_36, Vector3(0, 0, 1))
	A0_30:get_object(A3_33):set_position(L4_34 + (L5_35 - L4_34) * 0.5 + (L5_35 - L4_34):normalized():cross(L6_36) * A0_30:wire_data().slack)
end
function probability(A0_37, A1_38)
	local L2_39, L3_40, L4_41
	L2_39 = math
	L2_39 = L2_39.random
	L3_40 = 100
	L2_39 = L2_39(L3_40)
	L3_40 = 0
	L4_41 = #A0_37
	for 