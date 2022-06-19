SharedMath = SharedMath or class()
function SharedMath.sign(A0_0, A1_1)
	local L2_2
	if A1_1 < 0 then
		L2_2 = -1
		return L2_2
	elseif A1_1 > 0 then
		L2_2 = 1
		return L2_2
	end
	L2_2 = 0
	return L2_2
end
function SharedMath.intersect_ray_sphere(A0_3, A1_4, A2_5, A3_6)
	local L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14, L12_15, L13_16
	L4_7 = A2_5 - A0_3
	L5_8 = A3_6 - A2_5
	L7_10 = L5_8
	L6_9 = L5_8.dot
	L8_11 = L5_8
	L6_9 = L6_9(L7_10, L8_11)
	if L6_9 == 0 then
		return
	end
	L8_11 = L4_7
	L7_10 = L4_7.dot
	L9_12 = L5_8
	L7_10 = L7_10(L8_11, L9_12)
	L7_10 = 2 * L7_10
	L9_12 = L4_7
	L8_11 = L4_7.dot
	L10_13 = L4_7
	L8_11 = L8_11(L9_12, L10_13)
	L9_12 = A1_4 * A1_4
	L8_11 = L8_11 - L9_12
	L9_12 = -L7_10
	L10_13 = 2 * L6_9
	L9_12 = L9_12 / L10_13
	L10_13 = L7_10 * L7_10
	L11_14 = 4 * L6_9
	L11_14 = L11_14 * L8_11
	L10_13 = L10_13 - L11_14
	if L10_13 < 0 then
		return
	end
	L11_14 = math
	L11_14 = L11_14.sqrt
	L12_15 = L10_13
	L11_14 = L11_14(L12_15)
	L12_15 = 2 * L6_9
	L11_14 = L11_14 / L12_15
	L12_15, L13_16 = nil, nil
	if L11_14 > 0 then
		L12_15 = L9_12 - L11_14
		L13_16 = L9_12 + L11_14
	else
		L12_15 = L9_12 + L11_14
		L13_16 = L9_12 - L11_14
	end
	if L12_15 < 0 or L12_15 > 1 then
		if L13_16 < 0 or L13_16 > 1 then
			return
		else
			return L13_16
		end
	elseif L13_16 < 0 or L13_16 > 1 then
		return L12_15
	elseif L12_15 == L13_16 then
		return L12_15
	else
		return L12_15, L13_16
	end
end
function SharedMath.intersect_ray_plane(A0_17, A1_18, A2_19, A3_20)
	if A1_18:dot(A3_20 - A2_19) == 0 then
		return
	end
	if A1_18:dot(A0_17 - A2_19) / A1_18:dot(A3_20 - A2_19) < 0 or A1_18:dot(A0_17 - A2_19) / A1_18:dot(A3_20 - A2_19) > 1 then
		return
	end
	return A1_18:dot(A0_17 - A2_19) / A1_18:dot(A3_20 - A2_19)
end
function SharedMath.intersect_ray_disk(A0_21, A1_22, A2_23, A3_24, A4_25)
	if not SharedMath.intersect_ray_plane(A0_21, A2_23, A3_24, A4_25) then
		return
	end
	if A1_22 < (A3_24 + SharedMath.intersect_ray_plane(A0_21, A2_23, A3_24, A4_25) * (A4_25 - A3_24) - A0_21):length() then
		return
	end
	return (SharedMath.intersect_ray_plane(A0_21, A2_23, A3_24, A4_25))
end
function SharedMath.is_inside_sphere(A0_26, A1_27, A2_28)
	return A2_28 >= (A0_26 - A1_27):length()
end
function SharedMath.distance_point_to_line(A0_29, A1_30, A2_31)
	local L3_32, L4_33, L5_34, L6_35
	L3_32 = assert
	L4_33 = A1_30 ~= A2_31
	L3_32(L4_33)
	L3_32 = A2_31 - A1_30
	L4_33 = A1_30 - A0_29
	L6_35 = L3_32
	L5_34 = L3_32.dot
	L5_34 = L5_34(L6_35, L4_33)
	if L5_34 > 0 then
		L6_35 = L4_33
		L5_34 = L4_33.length
		L5_34 = L5_34(L6_35)
		L6_35 = 0
		return L5_34, L6_35
	end
	L5_34 = A0_29 - A2_31
	L6_35 = L3_32.dot
	L6_35 = L6_35(L3_32, L5_34)
	if L6_35 > 0 then
		L6_35 = L5_34.length
		L6_35 = L6_35(L5_34)
		return L6_35, 1
	end
	L6_35 = L3_32.cross
	L6_35 = L6_35(L3_32, L4_33)
	L6_35 = L6_35.length
	L6_35 = L6_35(L6_35)
	L6_35 = L6_35 / L3_32:length()
	return L6_35, 2
end
function SharedMath.point_on_ellipse(A0_36, A1_37, A2_38)
	local L3_39, L4_40
	L3_39 = assert
	L4_40 = A1_37 <= A0_36
	L3_39(L4_40)
	L3_39 = assert
	L4_40 = A2_38 >= -180 and A2_38 <= 180
	L3_39(L4_40)
	L3_39 = math
	L3_39 = L3_39.cos
	L4_40 = A2_38
	L3_39 = L3_39(L4_40)
	L3_39 = A0_36 * L3_39
	L4_40 = math
	L4_40 = L4_40.sin
	L4_40 = L4_40(A2_38)
	L4_40 = A1_37 * L4_40
	return L3_39, L4_40
end
function SharedMath.normalized_rand(A0_41, A1_42)
	local L2_43
	A0_41 = A0_41 or 0
	A1_42 = A1_42 or 1
	L2_43 = math
	L2_43 = L2_43.random
	L2_43 = L2_43()
	return A1_42 * (math.sqrt(-2 * math.log(L2_43)) * math.cos(2 * math.pi * math.random())) + A0_41
end
function SharedMath.line_segment_intersection_2d(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51)
	if not SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51) then
		return
	end
	if SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51).d1 < 0 or SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51).d1 > 0 or SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51).d2 < 0 or SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51).d2 > 0 then
		return
	end
	return {
		x = A0_44 + (line_1_x2 - line_1_x1) * SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51).d1,
		y = A1_45 + (A3_47 - A1_45) * SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51).d1,
		d1 = SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51).d1,
		d2 = SharedMath.line_segment_intersection_2d_denominators(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49, A6_50, A7_51).d2
	}
end
function SharedMath.lambda_line_segment_intersection_2d(A0_52, A1_53, A2_54, A3_55, A4_56, A5_57, A6_58, A7_59)
	local L8_60, L9_61, L10_62, L11_63, L12_64, L13_65, L14_66, L15_67, L16_68, L17_69, L18_70, L19_71, L20_72, L21_73, L22_74
	L8_60 = A0_52
	L9_61 = A1_53
	L10_62 = A2_54
	L11_63 = A3_55
	L12_64 = A4_56
	L13_65 = A5_57
	L14_66 = A6_58
	L15_67 = A7_59
	L16_68 = L15_67 - L13_65
	L17_69 = L10_62 - L8_60
	L16_68 = L16_68 * L17_69
	L17_69 = L14_66 - L12_64
	L18_70 = L11_63 - L9_61
	L17_69 = L17_69 * L18_70
	L16_68 = L16_68 - L17_69
	if L16_68 == 0 then
		return
	end
	L17_69 = L14_66 - L12_64
	L18_70 = L9_61 - L13_65
	L17_69 = L17_69 * L18_70
	L18_70 = L15_67 - L13_65
	L19_71 = L8_60 * L12_64
	L18_70 = L18_70 * L19_71
	L17_69 = L17_69 - L18_70
	L18_70 = L10_62 - L8_60
	L19_71 = L9_61 - L13_65
	L18_70 = L18_70 * L19_71
	L19_71 = L11_63 - L9_61
	L20_72 = L8_60 - L12_64
	L19_71 = L19_71 * L20_72
	L18_70 = L18_70 - L19_71
	L19_71 = 1 / L16_68
	L20_72 = L17_69 * L19_71
	L21_73 = L18_70 * L19_71
	L22_74 = {}
	L22_74.d1 = L20_72
	L22_74.d2 = L21_73
	return L22_74
end
function SharedMath.bounding_sphere_from_positions(A0_75)
	local L1_76, L2_77, L3_78, L4_79, L5_80, L6_81, L7_82, L8_83, L9_84
	L1_76 = #A0_75
	L2_77 = assert
	L3_78 = L1_76 > 0
	L2_77(L3_78)
	L2_77 = Vector3
	L2_77 = L2_77()
	for L6_81, L7_82 in L3_78(L4_79) do
		L2_77 = L2_77 + L7_82
	end
	L2_77 = L2_77 / L1_76
	for L7_82, L8_83 in L4_79(L5_80) do
		L9_84 = L2_77 - L8_83
	end
	L5_80.center = L2_77
	L5_80.radius = L4_79
	return L5_80
end
function SharedMath.distance_point_plane(A0_85, A1_86, A2_87)
	return math.dot(A0_85 - A1_86, A2_87)
end
