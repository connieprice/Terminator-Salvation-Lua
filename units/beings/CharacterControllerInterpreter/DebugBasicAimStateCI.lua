local L0_0
L0_0 = require
L0_0("units/beings/player/look/PlayerLook")
L0_0 = DebugBasicAimStateControllerInterpreter
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
DebugBasicAimStateControllerInterpreter = L0_0
L0_0 = "look"
function DebugBasicAimStateControllerInterpreter.init(A0_1, A1_2)
	A0_1._unit = A1_2
	A0_1._look = A0_1._unit:look()
	A0_1._acc_time = 0
	A0_1._player_data = A1_2:player_data()
	A0_1._reset_constraints = true
end
function DebugBasicAimStateControllerInterpreter.update(A0_3, A1_4, A2_5)
	local L3_6, L4_7, L5_8, L6_9, L7_10, L8_11
	L3_6 = assert
	L4_7 = A0_3._look
	L3_6(L4_7)
	L3_6 = A0_3._look
	L4_7 = L3_6
	L3_6 = L3_6.eye_position
	L3_6 = L3_6(L4_7)
	L4_7 = assert
	L5_8 = A2_5
	L4_7(L5_8)
	L5_8 = A0_3
	L4_7 = A0_3._update_look
	L6_9 = A1_4
	L7_10 = A2_5
	L4_7(L5_8, L6_9, L7_10)
	L4_7 = A0_3._look
	L5_8 = L4_7
	L4_7 = L4_7.eye_target_position
	L4_7 = L4_7(L5_8)
	L5_8 = A0_3._input
	L6_9 = L5_8
	L5_8 = L5_8.set_eye_target_position
	L7_10 = L4_7
	L5_8(L6_9, L7_10)
	L5_8 = A0_3._unit
	L6_9 = L5_8
	L5_8 = L5_8.camera_data
	L5_8 = L5_8(L6_9)
	L5_8 = L5_8.camera_position
	L6_9 = A0_3._unit
	L7_10 = L6_9
	L6_9 = L6_9.camera_data
	L6_9 = L6_9(L7_10)
	L6_9 = L6_9.camera_position
	L7_10 = A0_3._unit
	L8_11 = L7_10
	L7_10 = L7_10.camera_data
	L7_10 = L7_10(L8_11)
	L7_10 = L7_10.camera_rotation
	L8_11 = L7_10
	L7_10 = L7_10.y
	L7_10 = L7_10(L8_11)
	L7_10 = L7_10 * 100000
	L6_9 = L6_9 + L7_10
	L7_10 = L3_6 - L5_8
	L8_11 = L6_9 - L5_8
	L5_8 = L5_8 + A0_3._unit:camera_data().camera_rotation:y() * (L7_10:dot(L8_11) / L8_11:length() + tweak_data.player.aim.CAMERA_AIM_TARGET_RAY_OFFSET)
	A0_3:_update_aim(L5_8, L6_9)
end
function DebugBasicAimStateControllerInterpreter.disable(A0_12)
	local L1_13
	A0_12._controller = nil
end
function DebugBasicAimStateControllerInterpreter._invert_look(A0_14, A1_15)
	if A0_14._player_data then
		A1_15 = A1_15 * A0_14._player_data.sensitivity
		if A0_14._player_data.invert_y then
			A1_15 = -A1_15:with_x(-A1_15.x)
		end
	end
	return A1_15
end
function DebugBasicAimStateControllerInterpreter._adjust_aiming(A0_16, A1_17)
	local L2_18, L3_19
	L2_18 = _UPVALUE0_
	L3_19 = A1_17.x
	L2_18 = L2_18(L3_19, A0_16._aiming_x_dead_zone, A0_16._aiming_x_start_value, A0_16._aiming_x_coefficient, A0_16._aiming_x_exponent)
	L3_19 = _UPVALUE0_
	L3_19 = L3_19(A1_17.y, A0_16._aiming_y_dead_zone, A0_16._aiming_y_start_value, A0_16._aiming_y_coefficient, A0_16._aiming_y_exponent)
	return Vector3(L2_18, L3_19, A1_17.z)
end
function DebugBasicAimStateControllerInterpreter._adjust_acceleration(A0_20, A1_21, A2_22)
	local L3_23
	L3_23 = A0_20._acc_time
	L3_23 = L3_23 / A0_20._aiming_acceleration_time
	L3_23 = L3_23 * A1_21
	L3_23 = L3_23 * A0_20._aiming_acceleration_factor
	return Vector3(A2_22.x + L3_23.x * A0_20._aiming_x_coefficient, A2_22.y + L3_23.y * A0_20._aiming_y_coefficient, A2_22.z)
end
function DebugBasicAimStateControllerInterpreter._update_acceleration(A0_24, A1_25, A2_26)
	if A1_25:length() >= A0_24._aiming_acceleration_threshold then
		A0_24._acc_time = math.clamp(A0_24._acc_time + A2_26, 0, A0_24._aiming_acceleration_time)
		A0_24._last_acc_direction = A1_25
	else
		A0_24._acc_time = math.clamp(A0_24._acc_time - A2_26, 0, A0_24._aiming_acceleration_time)
	end
	if A1_25:length() > 0 and A0_24._last_acc_direction and A0_24._last_acc_direction:angle(A1_25) > 90 then
		A0_24._acc_time = 0
	end
end
function DebugBasicAimStateControllerInterpreter._adjust_look(A0_27, A1_28, A2_29, A3_30)
	local L4_31
	L4_31 = A0_27._adjust_aiming
	L4_31 = L4_31(A0_27, A1_28)
	if A3_30 then
		A0_27:_update_acceleration(A1_28, A2_29)
		L4_31 = A0_27:_adjust_acceleration(A1_28, L4_31)
	else
		A0_27._acc_time = 0
	end
	return A0_27:_invert_look(L4_31)
end
function DebugBasicAimStateControllerInterpreter._update_look(A0_32, A1_33, A2_34)
	local L3_35, L4_36, L5_37
	L4_36 = A1_33
	L3_35 = A1_33.get_input_axis
	L5_37 = _UPVALUE0_
	L3_35 = L3_35(L4_36, L5_37)
	L5_37 = A1_33
	L4_36 = A1_33.get_connection_settings
	L4_36 = L4_36(L5_37, _UPVALUE0_)
	L5_37 = L4_36
	L4_36 = L4_36.get_no_limit
	L4_36 = L4_36(L5_37)
	L4_36 = not L4_36
	L5_37 = A0_32._adjust_look
	L5_37 = L5_37(A0_32, L3_35, A2_34, L4_36)
	A0_32:update_constraints(A2_34)
	A0_32._look:set_look_input(L5_37)
end
function DebugBasicAimStateControllerInterpreter.update_constraints(A0_38, A1_39)
	local L2_40, L3_41, L4_42, L5_43
	L5_43 = A0_38._unit
	L5_43 = L5_43.camera
	L5_43 = L5_43(L5_43)
	L5_43 = L5_43.active_camera
	L5_43 = L5_43(L5_43)
	if L5_43 then
		L5_43 = A0_38._unit
		L5_43 = L5_43.camera
		L5_43 = L5_43(L5_43)
		L5_43 = L5_43.camera_constraints
		L3_41, L4_42, L5_43 = L5_43, nil, L5_43(L5_43)
		L2_40 = L5_43
	end
	if L2_40 and L3_41 and L4_42 then
		L5_43 = L2_40.roll
		L5_43 = L5_43(L2_40)
		A0_38._look:set_pitch_constraints(L2_40:yaw() - L4_42, L2_40:yaw() + L4_42)
		A0_38._look:set_yaw_constraints(L5_43, L3_41, L3_41)
	else
		L5_43 = A0_38._reset_constraints
		if L5_43 then
			L5_43 = A0_38._look
			L5_43 = L5_43.reset_constraints
			L5_43(L5_43)
		end
	end
end
function DebugBasicAimStateControllerInterpreter.input(A0_44)
	local L1_45
	L1_45 = A0_44._input
	return L1_45
end
function DebugBasicAimStateControllerInterpreter._debug_render_eye_target(A0_46, A1_47, A2_48, A3_49)
	local L4_50, L5_51, L6_52, L7_53, L8_54
	L4_50 = Draw
	L5_51 = L4_50
	L4_50 = L4_50.brush
	L4_50 = L4_50(L5_51)
	L5_51 = 5
	L6_52 = Color
	L7_53 = 0
	L8_54 = 0
	L6_52 = L6_52(L7_53, L8_54, 1)
	L7_53 = Color
	L8_54 = 1
	L7_53 = L7_53(L8_54, 0, 0)
	L8_54 = Color
	L8_54 = L8_54(1, 1, 1)
	L4_50:set_color(L6_52)
	L4_50:sphere(A0_46._input:eye_target_position(), L5_51)
	L4_50:set_color(L8_54)
	L4_50:line(A1_47, A0_46._input:eye_target_position())
	L4_50:set_color(L8_54)
	L4_50:set_color(L7_53)
	L4_50:sphere(A0_46._input:aim_target_position(), L5_51)
	L4_50:set_color(Color(1, 1, 0))
	L4_50:sphere(A2_48, L5_51)
	L4_50:set_color(Color(0, 1, 1))
	L4_50:sphere(A3_49, L5_51)
end
function DebugBasicAimStateControllerInterpreter._update_aim(A0_55, A1_56, A2_57)
	local L3_58, L4_59, L5_60
	L3_58 = managers
	L3_58 = L3_58.slot
	L4_59 = L3_58
	L3_58 = L3_58.get_mask
	L5_60 = "shootable_wo_adr_shield"
	L3_58 = L3_58(L4_59, L5_60)
	L4_59 = A0_55._unit
	L5_60 = L4_59
	L4_59 = L4_59.raycast
	L4_59 = L4_59(L5_60, "ray", A1_56, A2_57, "slot_mask", L3_58)
	L5_60 = nil
	if L4_59 then
		L5_60 = L4_59.position
	else
		L5_60 = A2_57
	end
	A0_55._input:set_aim_target_position(L5_60)
	if A0_55._unit:player_data() then
		A0_55._unit:player_data().aim_target_position = L5_60
		A0_55._unit:player_data().aim_target_unit = nil
		A0_55._unit:player_data().aim_target_body = nil
	end
end
function DebugBasicAimStateControllerInterpreter._set_aiming_values(A0_61, A1_62, A2_63, A3_64, A4_65, A5_66, A6_67, A7_68, A8_69)
	A0_61._aiming_x_coefficient = A1_62
	A0_61._aiming_x_exponent = A2_63
	A0_61._aiming_x_dead_zone = A3_64
	A0_61._aiming_x_start_value = A4_65
	A0_61._aiming_y_coefficient = A5_66
	A0_61._aiming_y_exponent = A6_67
	A0_61._aiming_y_dead_zone = A7_68
	A0_61._aiming_y_start_value = A8_69
end
function DebugBasicAimStateControllerInterpreter._set_aiming_acceleration_enabled(A0_70, A1_71)
	A0_70._aiming_acceleration_enabled = A1_71
end
function DebugBasicAimStateControllerInterpreter._set_aiming_acceleration_values(A0_72, A1_73, A2_74, A3_75)
	A0_72._aiming_acceleration_threshold = A1_73
	A0_72._aiming_acceleration_time = A2_74
	A0_72._aiming_acceleration_factor = A3_75
end
