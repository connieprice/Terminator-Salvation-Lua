require("units/beings/player/look/PlayerLook")
require("units/beings/CharacterControllerInterpreter/DebugBasicAimStateCI")
FlyerControllerInterpreter = FlyerControllerInterpreter or class(DebugBasicAimStateControllerInterpreter)
function FlyerControllerInterpreter.init(A0_0, A1_1)
	DebugBasicAimStateControllerInterpreter.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._input = A0_0._unit:input()
	A0_0._chassi_body = A1_1:body("default_body")
	A0_0._prev_xy_acceleration = Vector3(0, 0, 0)
end
function FlyerControllerInterpreter.enable(A0_2, A1_3)
	A0_2._controller = A1_3
end
function FlyerControllerInterpreter.disable(A0_4)
	local L1_5
	A0_4._controller = nil
end
function FlyerControllerInterpreter.update(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11, L6_12, L7_13, L8_14, L9_15, L10_16, L11_17, L12_18
	L4_10 = assert
	L5_11 = A0_6._controller
	L4_10(L5_11)
	L4_10 = A0_6._input
	L5_11 = L4_10
	L4_10 = L4_10.clear
	L4_10(L5_11)
	L4_10 = DebugBasicAimStateControllerInterpreter
	L4_10 = L4_10.update
	L5_11 = A0_6
	L6_12 = A0_6._controller
	L7_13 = A3_9
	L4_10(L5_11, L6_12, L7_13)
	L5_11 = A1_7
	L4_10 = A1_7.camera_data
	L4_10 = L4_10(L5_11)
	L5_11 = A0_6._controller
	L6_12 = L5_11
	L5_11 = L5_11.get_input_axis
	L7_13 = "move"
	L5_11 = L5_11(L6_12, L7_13)
	L6_12 = L5_11.x
	L7_13 = L4_10.camera_rotation
	L8_14 = L7_13
	L7_13 = L7_13.x
	L7_13 = L7_13(L8_14)
	L6_12 = L6_12 * L7_13
	L7_13 = L5_11.y
	L8_14 = L4_10.camera_rotation
	L9_15 = L8_14
	L8_14 = L8_14.y
	L8_14 = L8_14(L9_15)
	L7_13 = L7_13 * L8_14
	L6_12 = L6_12 + L7_13
	L8_14 = L6_12
	L7_13 = L6_12.with_z
	L9_15 = math
	L9_15 = L9_15.min
	L10_16 = L6_12.z
	L10_16 = 4 * L10_16
	L11_17 = 1
	L12_18 = L9_15(L10_16, L11_17)
	L7_13(L8_14, L9_15, L10_16, L11_17, L12_18, L9_15(L10_16, L11_17))
	L7_13, L8_14 = nil, nil
	L10_16 = A0_6
	L9_15 = A0_6._update_movement
	L11_17 = L6_12
	L12_18 = A3_9
	L10_16 = L9_15(L10_16, L11_17, L12_18)
	L8_14 = L10_16
	L7_13 = L9_15
	L9_15 = A0_6._input
	L10_16 = L9_15
	L9_15 = L9_15.set_acceleration
	L11_17 = L7_13
	L9_15(L10_16, L11_17)
	L9_15 = A0_6._input
	L10_16 = L9_15
	L9_15 = L9_15.set_angular_acceleration
	L11_17 = L8_14
	L9_15(L10_16, L11_17)
	L9_15 = A0_6._unit
	L10_16 = L9_15
	L9_15 = L9_15.camera_data
	L9_15 = L9_15(L10_16)
	L9_15 = L9_15.camera_position
	L10_16 = A0_6._unit
	L11_17 = L10_16
	L10_16 = L10_16.camera_data
	L10_16 = L10_16(L11_17)
	L10_16 = L10_16.camera_rotation
	L11_17 = L10_16
	L10_16 = L10_16.y
	L10_16 = L10_16(L11_17)
	L11_17 = A0_6._look
	L12_18 = L11_17
	L11_17 = L11_17.eye_target_position
	L11_17 = L11_17(L12_18)
	L12_18 = A0_6._input
	L12_18 = L12_18.set_eye_target_position
	L12_18(L12_18, L11_17)
	L12_18 = A0_6._look
	L12_18 = L12_18.eye_target_position
	L12_18 = L12_18(L12_18)
	A0_6._input:set_aim_target_position(L12_18)
	if A0_6._controller:get_input_bool("fire") then
		A0_6._input:set_fire()
	end
	A0_6._input:set_defensive(A0_6._controller:get_input_bool("zoom"))
	if A0_6._controller:get_input_pressed("enter_cover") then
		A0_6._input:set_self_destroy()
	end
end
function FlyerControllerInterpreter._update_movement(A0_19, A1_20, A2_21)
	local L3_22, L4_23, L5_24, L6_25, L7_26, L8_27, L9_28, L10_29, L11_30, L12_31, L13_32, L14_33, L15_34, L16_35, L17_36, L18_37, L19_38, L20_39, L21_40, L22_41, L23_42, L24_43, L25_44, L26_45, L27_46, L28_47, L29_48, L30_49, L31_50, L32_51, L33_52, L34_53, L35_54, L36_55, L37_56, L38_57, L39_58
	L3_22 = A0_19._chassi_body
	L4_23 = L3_22
	L3_22 = L3_22.center_of_mass
	L3_22 = L3_22(L4_23)
	L4_23 = math
	L4_23 = L4_23.UP
	L5_24 = A0_19._chassi_body
	L6_25 = L5_24
	L5_24 = L5_24.rotation
	L5_24 = L5_24(L6_25)
	L6_25 = L5_24
	L5_24 = L5_24.y
	L5_24 = L5_24(L6_25)
	L6_25 = A0_19._chassi_body
	L7_26 = L6_25
	L6_25 = L6_25.rotation
	L6_25 = L6_25(L7_26)
	L7_26 = L6_25
	L6_25 = L6_25.z
	L6_25 = L6_25(L7_26)
	L7_26 = A0_19._chassi_body
	L8_27 = L7_26
	L7_26 = L7_26.velocity
	L7_26 = L7_26(L8_27)
	L8_27 = A0_19._chassi_body
	L9_28 = L8_27
	L8_27 = L8_27.angular_velocity
	L8_27 = L8_27(L9_28)
	L9_28 = 10
	L10_29 = 700
	L11_30 = 70
	L12_31 = 5
	L13_32 = 60
	L14_33 = 2
	L15_34 = 5
	L16_35 = 10
	L17_36 = A1_20
	L19_38 = L17_36
	L18_37 = L17_36.with_z
	L20_39 = 0
	L18_37 = L18_37(L19_38, L20_39)
	L19_38 = math
	L19_38 = L19_38.lerp
	L20_39 = L14_33
	L21_40 = L15_34
	L22_41 = math
	L22_41 = L22_41.min
	L24_43 = L7_26
	L23_42 = L7_26.length
	L23_42 = L23_42(L24_43)
	L24_43 = L10_29
	L22_41 = L22_41(L23_42, L24_43)
	L22_41 = L22_41 / L10_29
	L19_38 = L19_38(L20_39, L21_40, L22_41)
	L21_40 = L7_26
	L20_39 = L7_26.with_z
	L22_41 = 0
	L20_39 = L20_39(L21_40, L22_41)
	L21_40 = L10_29
	L23_42 = L18_37
	L22_41 = L18_37.normalized
	L22_41 = L22_41(L23_42)
	L22_41 = L22_41 * L21_40
	L23_42 = L22_41 - L20_39
	L25_44 = L23_42
	L24_43 = L23_42.normalized
	L24_43 = L24_43(L25_44)
	L25_44 = math
	L25_44 = L25_44.min
	L27_46 = L23_42
	L26_45 = L23_42.length
	L26_45 = L26_45(L27_46)
	L27_46 = L10_29
	L25_44 = L25_44(L26_45, L27_46)
	L24_43 = L24_43 * L25_44
	L24_43 = L24_43 * L19_38
	L25_44 = math
	L25_44 = L25_44.lerp
	L26_45 = A0_19._prev_xy_acceleration
	L27_46 = L24_43
	L28_47 = math
	L28_47 = L28_47.min
	L29_48 = L9_28 * A2_21
	L30_49 = 1
	L39_58 = L28_47(L29_48, L30_49)
	L25_44 = L25_44(L26_45, L27_46, L28_47, L29_48, L30_49, L31_50, L32_51, L33_52, L34_53, L35_54, L36_55, L37_56, L38_57, L39_58, L28_47(L29_48, L30_49))
	L24_43 = L25_44
	A0_19._prev_xy_acceleration = L24_43
	L25_44 = L17_36.z
	L25_44 = L10_29 * L25_44
	L26_45 = math
	L26_45 = L26_45.UP
	L27_46 = math
	L27_46 = L27_46.clamp
	L28_47 = L7_26.z
	L29_48 = -L10_29
	L30_49 = L10_29
	L27_46 = L27_46(L28_47, L29_48, L30_49)
	L27_46 = L25_44 - L27_46
	L26_45 = L26_45 * L27_46
	L26_45 = L26_45 * L16_35
	L27_46 = World
	L28_47 = L27_46
	L27_46 = L27_46.gravity
	L27_46 = L27_46(L28_47)
	L27_46 = -0.5 * L27_46
	L27_46 = L27_46 + L24_43
	L27_46 = L27_46 + L26_45
	L28_47 = L19_38 * L10_29
	L30_49 = L24_43
	L29_48 = L24_43.length
	L29_48 = L29_48(L30_49)
	L29_48 = L29_48 / L28_47
	L30_49 = math
	L30_49 = L30_49.lerp
	L31_50 = 0
	L32_51 = L11_30
	L33_52 = L29_48
	L30_49 = L30_49(L31_50, L32_51, L33_52)
	L32_51 = L4_23
	L31_50 = L4_23.rotate_with
	L33_52 = Rotation
	L35_54 = L4_23
	L34_53 = L4_23.cross
	L36_55 = L24_43
	L34_53 = L34_53(L35_54, L36_55)
	L35_54 = L30_49
	L39_58 = L33_52(L34_53, L35_54)
	L31_50 = L31_50(L32_51, L33_52, L34_53, L35_54, L36_55, L37_56, L38_57, L39_58, L33_52(L34_53, L35_54))
	L4_23 = L31_50
	A0_19._prev_wanted_up = L4_23
	L31_50 = 5
	L32_51 = 3
	L33_52 = 30
	L34_53 = A0_19._chassi_body
	L35_54 = L34_53
	L34_53 = L34_53.position
	L34_53 = L34_53(L35_54)
	L36_55 = L6_25
	L35_54 = L6_25.dot
	L37_56 = L4_23
	L35_54 = L35_54(L36_55, L37_56)
	L37_56 = L6_25
	L36_55 = L6_25.cross
	L38_57 = L4_23
	L36_55 = L36_55(L37_56, L38_57)
	L37_56 = L36_55
	L36_55 = L36_55.normalized
	L36_55 = L36_55(L37_56)
	L37_56 = math
	L37_56 = L37_56.lerp
	L38_57 = L31_50
	L39_58 = 0
	L37_56 = L37_56(L38_57, L39_58, math.pow(L35_54, 20))
	L36_55 = L36_55 * L37_56
	L37_56 = A0_19._look
	L38_57 = L37_56
	L37_56 = L37_56.eye_target_position
	L37_56 = L37_56(L38_57)
	L38_57 = math
	L38_57 = L38_57.clamp
	L39_58 = L37_56 - L34_53
	L39_58 = L39_58.to_polar_with_reference
	L39_58 = L39_58(L39_58, L5_24, L6_25)
	L39_58 = L39_58.spin
	L38_57 = L38_57(L39_58, -L33_52, L33_52)
	L39_58 = math
	L39_58 = L39_58.lerp
	L39_58 = L39_58(L31_50, -L31_50, (L33_52 - L38_57) / (2 * L33_52))
	L39_58 = L6_25 * L39_58
	L36_55 = L36_55 + L39_58
	L39_58 = L8_27.normalized
	L39_58 = L39_58(L8_27)
	L39_58 = L39_58 * math.min(L8_27:length(), L31_50)
	L39_58 = L36_55 - L39_58
	L39_58 = L39_58 * L32_51
	return L27_46, L39_58
end
