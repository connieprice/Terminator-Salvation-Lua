AimPoseHelper = AimPoseHelper or class()
function AimPoseHelper.delta_yaw_and_pitch(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5, L6_6, L7_7
	L3_3 = A2_2 - A0_0
	L5_5 = L3_3
	L4_4 = L3_3.flat
	L7_7 = A1_1
	L6_6 = A1_1.z
	L7_7 = L6_6(L7_7)
	L4_4 = L4_4(L5_5, L6_6, L7_7, L6_6(L7_7))
	L5_5 = L4_4
	L4_4 = L4_4.normalized
	L4_4 = L4_4(L5_5)
	L5_5 = math
	L5_5 = L5_5.acos
	L7_7 = L4_4
	L6_6 = L4_4.dot
	L7_7 = L6_6(L7_7, A1_1:y())
	L5_5 = L5_5(L6_6, L7_7, L6_6(L7_7, A1_1:y()))
	L7_7 = L4_4
	L6_6 = L4_4.dot
	L6_6 = L6_6(L7_7, A1_1:x())
	if L6_6 < 0 then
		L5_5 = -L5_5
	end
	L7_7 = L3_3
	L6_6 = L3_3.flat
	L6_6 = L6_6(L7_7, A1_1:x())
	L7_7 = L6_6
	L6_6 = L6_6.normalized
	L6_6 = L6_6(L7_7)
	L7_7 = math
	L7_7 = L7_7.acos
	L7_7 = L7_7(L6_6:dot(A1_1:y()))
	if L6_6:dot(A1_1:z()) < 0 then
		L7_7 = -L7_7
	end
	return L5_5, L7_7
end
function AimPoseHelper.update_yaw_and_pitch(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13, A6_14)
	local L7_15, L8_16, L9_17, L10_18
	L7_15 = math
	L7_15 = L7_15.clamp
	L8_16 = A1_9
	L9_17 = -A3_11
	L10_18 = A3_11
	L7_15 = L7_15(L8_16, L9_17, L10_18)
	A1_9 = L7_15 / A3_11
	L7_15 = math
	L7_15 = L7_15.clamp
	L8_16 = A2_10
	L9_17 = -A4_12
	L10_18 = A4_12
	L7_15 = L7_15(L8_16, L9_17, L10_18)
	A2_10 = L7_15 / A4_12
	L8_16 = A0_8
	L7_15 = A0_8.get_global
	L9_17 = A5_13
	L7_15 = L7_15(L8_16, L9_17)
	L9_17 = A0_8
	L8_16 = A0_8.get_global
	L10_18 = A6_14
	L8_16 = L8_16(L9_17, L10_18)
	L9_17 = math
	L9_17 = L9_17.clamp
	L10_18 = L7_15 + A1_9
	L9_17 = L9_17(L10_18, -1, 1)
	L10_18 = math
	L10_18 = L10_18.clamp
	L10_18 = L10_18(L8_16 + A2_10, -1, 1)
	A0_8:set_global(A5_13, L9_17)
	A0_8:set_global(A6_14, L10_18)
end
function AimPoseHelper.update(A0_19, A1_20, A2_21, A3_22, A4_23, A5_24, A6_25, A7_26, A8_27, A9_28, A10_29)
	local L11_30, L12_31, L13_32, L14_33, L15_34, L16_35, L17_36, L18_37, L19_38, L20_39, L21_40, L22_41, L23_42, L24_43, L25_44, L26_45, L27_46, L28_47, L29_48, L30_49, L31_50, L32_51
	L12_31 = A0_19
	L11_30 = A0_19.get_global
	L13_32 = A5_24
	L11_30 = L11_30(L12_31, L13_32)
	L13_32 = A0_19
	L12_31 = A0_19.get_global
	L14_33 = A4_23
	L12_31 = L12_31(L13_32, L14_33)
	L14_33 = A2_21
	L13_32 = A2_21.x
	L13_32 = L13_32(L14_33)
	L15_34 = A2_21
	L14_33 = A2_21.y
	L14_33 = L14_33(L15_34)
	L16_35 = A2_21
	L15_34 = A2_21.z
	L15_34 = L15_34(L16_35)
	L16_35 = A3_22 - A1_20
	L17_36 = math
	L17_36 = L17_36.UP
	L19_38 = L16_35
	L18_37 = L16_35.cross
	L20_39 = L17_36
	L18_37 = L18_37(L19_38, L20_39)
	L19_38 = L18_37
	L18_37 = L18_37.normalized
	L18_37 = L18_37(L19_38)
	L20_39 = L17_36
	L19_38 = L17_36.cross
	L21_40 = L18_37
	L19_38 = L19_38(L20_39, L21_40)
	L21_40 = L14_33
	L20_39 = L14_33.with_z
	L22_41 = 0
	L20_39 = L20_39(L21_40, L22_41)
	L21_40 = L20_39
	L20_39 = L20_39.normalized
	L20_39 = L20_39(L21_40)
	L22_41 = L19_38
	L21_40 = L19_38.dot
	L23_42 = L20_39
	L21_40 = L21_40(L22_41, L23_42)
	L22_41 = math
	L22_41 = L22_41.acos
	L23_42 = L21_40
	L22_41 = L22_41(L23_42)
	L24_43 = L18_37
	L23_42 = L18_37.dot
	L25_44 = L20_39
	L23_42 = L23_42(L24_43, L25_44)
	if L23_42 > 0 then
		L22_41 = -L22_41
	end
	L24_43 = L16_35
	L23_42 = L16_35.rotate_with
	L25_44 = Rotation
	L26_45 = L17_36
	L27_46 = L22_41
	L32_51 = L25_44(L26_45, L27_46)
	L23_42 = L23_42(L24_43, L25_44, L26_45, L27_46, L28_47, L29_48, L30_49, L31_50, L32_51, L25_44(L26_45, L27_46))
	L25_44 = L23_42
	L24_43 = L23_42.flat
	L26_45 = L13_32
	L24_43 = L24_43(L25_44, L26_45)
	L25_44 = L24_43
	L24_43 = L24_43.normalized
	L24_43 = L24_43(L25_44)
	L26_45 = L24_43
	L25_44 = L24_43.dot
	L27_46 = L14_33
	L25_44 = L25_44(L26_45, L27_46)
	L26_45 = math
	L26_45 = L26_45.acos
	L27_46 = L25_44
	L26_45 = L26_45(L27_46)
	L28_47 = L24_43
	L27_46 = L24_43.dot
	L29_48 = L15_34
	L27_46 = L27_46(L28_47, L29_48)
	if L27_46 < 0 then
		L26_45 = -L26_45
	end
	L28_47 = L16_35
	L27_46 = L16_35.flat
	L29_48 = L15_34
	L27_46 = L27_46(L28_47, L29_48)
	L28_47 = L27_46
	L27_46 = L27_46.normalized
	L27_46 = L27_46(L28_47)
	L28_47 = math
	L28_47 = L28_47.acos
	L30_49 = L27_46
	L29_48 = L27_46.dot
	L31_50 = L14_33
	L32_51 = L29_48(L30_49, L31_50)
	L28_47 = L28_47(L29_48, L30_49, L31_50, L32_51, L29_48(L30_49, L31_50))
	L30_49 = L27_46
	L29_48 = L27_46.dot
	L31_50 = L13_32
	L29_48 = L29_48(L30_49, L31_50)
	if L29_48 < 0 then
		L28_47 = -L28_47
	end
	L29_48 = nil
	if L11_30 < 0 then
		L29_48 = L11_30 * A8_27
	else
		L29_48 = L11_30 * A9_28
	end
	L30_49 = nil
	if L12_31 < 0 then
		L30_49 = L12_31 * A6_25
	else
		L30_49 = L12_31 * A7_26
	end
	if A10_29 then
		L31_50 = math
		L31_50 = L31_50.sqrt
		L32_51 = L28_47 * L28_47
		L32_51 = L32_51 + L26_45 * L26_45
		L31_50 = L31_50(L32_51)
		if A10_29 < L31_50 then
			L32_51 = A10_29 / L31_50
			L28_47 = L28_47 * L32_51
			L26_45 = L26_45 * L32_51
		end
	end
	L26_45 = L29_48 + L26_45
	L28_47 = L30_49 + L28_47
	L31_50 = nil
	if L26_45 < 0 then
		L32_51 = math
		L32_51 = L32_51.clamp
		L32_51 = L32_51(L26_45, -A8_27, 0)
		L31_50 = L32_51 / A8_27
	else
		L32_51 = math
		L32_51 = L32_51.clamp
		L32_51 = L32_51(L26_45, 0, A9_28)
		L31_50 = L32_51 / A9_28
	end
	L32_51 = nil
	if L28_47 < 0 then
		L32_51 = math.clamp(L28_47, -A6_25, 0) / A6_25
	else
		L32_51 = math.clamp(L28_47, 0, A7_26) / A7_26
	end
	A0_19:set_global(A5_24, L31_50)
	A0_19:set_global(A4_23, L32_51)
end
function AimPoseHelper.update2(A0_52, A1_53, A2_54, A3_55, A4_56, A5_57, A6_58, A7_59, A8_60, A9_61, A10_62, A11_63, A12_64, A13_65, A14_66, A15_67)
	local L16_68, L17_69, L18_70, L19_71, L20_72, L21_73, L22_74, L23_75, L24_76, L25_77
	L16_68 = A4_56 - A2_54
	L18_70 = L16_68
	L17_69 = L16_68.to_polar_with_reference
	L20_72 = A3_55
	L19_71 = A3_55.y
	L19_71 = L19_71(L20_72)
	L21_73 = A3_55
	L20_72 = A3_55.z
	L25_77 = L20_72(L21_73)
	L17_69 = L17_69(L18_70, L19_71, L20_72, L21_73, L22_74, L23_75, L24_76, L25_77, L20_72(L21_73))
	L18_70 = L17_69.pitch
	L19_71 = L17_69.spin
	L19_71 = -L19_71
	if A11_63 then
		L20_72 = math
		L20_72 = L20_72.sqrt
		L21_73 = L19_71 * L19_71
		L22_74 = L18_70 * L18_70
		L21_73 = L21_73 + L22_74
		L20_72 = L20_72(L21_73)
		if A11_63 < L20_72 then
			L21_73 = A11_63 / L20_72
			L19_71 = L19_71 * L21_73
			L18_70 = L18_70 * L21_73
		end
	else
		L20_72 = 100 * A0_52
		L21_73 = math
		L21_73 = L21_73.clamp
		L22_74 = L18_70
		L23_75 = -L20_72
		L24_76 = L20_72
		L21_73 = L21_73(L22_74, L23_75, L24_76)
		L22_74 = math
		L22_74 = L22_74.clamp
		L23_75 = L19_71
		L24_76 = -L20_72
		L25_77 = L20_72
		L22_74 = L22_74(L23_75, L24_76, L25_77)
	end
	L21_73 = A1_53
	L20_72 = A1_53.get_global
	L22_74 = A6_58
	L20_72 = L20_72(L21_73, L22_74)
	L22_74 = A1_53
	L21_73 = A1_53.get_global
	L23_75 = A5_57
	L21_73 = L21_73(L22_74, L23_75)
	L22_74 = iff
	L23_75 = L20_72 < 0
	L24_76 = L20_72 * A9_61
	L25_77 = L20_72 * A10_62
	L22_74 = L22_74(L23_75, L24_76, L25_77)
	L23_75 = iff
	L24_76 = L21_73 < 0
	L25_77 = L21_73 * A7_59
	L23_75 = L23_75(L24_76, L25_77, L21_73 * A8_60)
	L18_70 = L22_74 + L18_70
	L19_71 = L23_75 + L19_71
	L24_76 = math
	L24_76 = L24_76.clamp
	L25_77 = L19_71
	L24_76 = L24_76(L25_77, A12_64 or -180, A13_65 or 180)
	L19_71 = L24_76
	L24_76 = math
	L24_76 = L24_76.clamp
	L25_77 = L18_70
	L24_76 = L24_76(L25_77, A14_66 or -180, A15_67 or 180)
	L18_70 = L24_76
	L24_76 = math
	L24_76 = L24_76.clamp
	L25_77 = iff
	L25_77 = L25_77(L18_70 < 0, A9_61, A10_62)
	L25_77 = L18_70 / L25_77
	L24_76 = L24_76(L25_77, -1, 1)
	L25_77 = math
	L25_77 = L25_77.clamp
	L25_77 = L25_77(L19_71 / iff(L19_71 < 0, A7_59, A8_60), -1, 1)
	A1_53:set_global(A6_58, L24_76)
	A1_53:set_global(A5_57, L25_77)
end
TestAimPoseHelper = TestAimPoseHelper or class()
function TestAimPoseHelper.test_sign(A0_78)
	A0_78:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(1, 0, 0), 45, 45, 45, 45, 10)
	A0_78:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(0, 1, 0), 45, 45, 45, 45, 10)
	A0_78:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(1, 1, 0), 45, 45, 45, 45, 10)
	A0_78:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(1, 0, 1), 45, 45, 45, 45, 10)
	A0_78:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(0, 1, 1), 45, 45, 45, 45, 10)
	A0_78:compare_results(0, 0, Vector3(0, 0, 0), Rotation(0, 0, 0), Vector3(1, 1, 1), 45, 45, 45, 45, 10)
end
function TestAimPoseHelper.compare_results(A0_79, A1_80, A2_81, A3_82, A4_83, A5_84, A6_85, A7_86, A8_87, A9_88, A10_89)
	local L11_90, L12_91
	L11_90 = {}
	function L12_91(A0_92, A1_93)
		local L2_94
		L2_94 = A0_92[A1_93]
		return L2_94
	end
	L11_90.get_global = L12_91
	function L12_91(A0_95, A1_96, A2_97)
		A0_95[A1_96] = A2_97
	end
	L11_90.set_global = L12_91
	L11_90.pitch = A1_80
	L11_90.yaw = A2_81
	L12_91 = TableAlgorithms
	L12_91 = L12_91.copy
	L12_91 = L12_91(L11_90)
	AimPoseHelper.update(L11_90, A3_82, A4_83, A5_84, "yaw", "pitch", A6_85, A7_86, A8_87, A9_88, A10_89)
	AimPoseHelper.update2(L12_91, A3_82, A4_83, A5_84, "yaw", "pitch", A6_85, A7_86, A8_87, A9_88, A10_89)
	print("---")
	print(L12_91.pitch .. " " .. L11_90.pitch)
	print(L12_91.yaw .. " " .. L11_90.yaw)
end
