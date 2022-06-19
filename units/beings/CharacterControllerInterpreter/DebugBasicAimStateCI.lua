require("units/beings/player/look/PlayerLook")
if not DebugBasicAimStateControllerInterpreter then
	DebugBasicAimStateControllerInterpreter = class()
end
local l_0_0 = "look"
local l_0_1 = "move"
DebugBasicAimStateControllerInterpreter.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._look = l_1_0._unit:look()
	l_1_0._acc_time = 0
	l_1_0._player_data = l_1_1:player_data()
	l_1_0._reset_constraints = true
end

DebugBasicAimStateControllerInterpreter.update = function(l_2_0, l_2_1, l_2_2)
	assert(l_2_0._look)
	local l_2_3 = l_2_0._look:eye_position()
	assert(l_2_2)
	l_2_0:_update_look(l_2_1, l_2_2)
	local l_2_4 = l_2_0._look:eye_target_position()
	l_2_0._input:set_eye_target_position(l_2_4)
	local l_2_5 = l_2_0._unit:camera_data().camera_position
	local l_2_6 = l_2_0._unit:camera_data().camera_position + l_2_0._unit:camera_data().camera_rotation:y() * 100000
	local l_2_7 = l_2_3 - l_2_5
	local l_2_8 = l_2_6 - l_2_5
	local l_2_9 = l_2_7:dot(l_2_8)
	local l_2_10 = l_2_9 / l_2_8:length() + tweak_data.player.aim.CAMERA_AIM_TARGET_RAY_OFFSET
	l_2_5 = l_2_5 + l_2_0._unit:camera_data().camera_rotation:y() * l_2_10
	l_2_0:_update_aim(l_2_5, l_2_6)
end

DebugBasicAimStateControllerInterpreter.disable = function(l_3_0)
	l_3_0._controller = nil
end

DebugBasicAimStateControllerInterpreter._invert_look = function(l_4_0, l_4_1)
	if l_4_0._player_data then
		l_4_1 = l_4_1 * l_4_0._player_data.sensitivity
	if l_4_0._player_data.invert_y then
		end
		l_4_1 = -l_4_1:with_x(-l_4_1.x)
	end
	return l_4_1
end

local l_0_2 = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4)
	if l_5_1 < l_5_0 then
		local l_5_5 = l_5_2 + l_5_3 * l_5_0 - l_5_1 ^ l_5_4
	elseif l_5_0 < -l_5_1 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	return -l_5_2 - l_5_3 * (-l_5_0 - l_5_1) ^ l_5_4
end

DebugBasicAimStateControllerInterpreter._adjust_aiming = function(l_6_0, l_6_1)
	-- upvalues: l_0_2
	local l_6_2 = l_0_2(l_6_1.x, l_6_0._aiming_x_dead_zone, l_6_0._aiming_x_start_value, l_6_0._aiming_x_coefficient, l_6_0._aiming_x_exponent)
	local l_6_8 = l_0_2
	l_6_8 = l_6_8(l_6_1.y, l_6_0._aiming_y_dead_zone, l_6_0._aiming_y_start_value, l_6_0._aiming_y_coefficient, l_6_0._aiming_y_exponent)
	local l_6_3 = nil
	l_6_3 = Vector3
	local l_6_4 = nil
	l_6_4 = l_6_2
	local l_6_5 = nil
	l_6_5 = l_6_8
	local l_6_6 = nil
	l_6_6 = l_6_1.z
	local l_6_7 = nil
	return l_6_3(l_6_4, l_6_5, l_6_6)
end

DebugBasicAimStateControllerInterpreter._adjust_acceleration = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_0._acc_time / l_7_0._aiming_acceleration_time * l_7_1 * l_7_0._aiming_acceleration_factor
	local l_7_4 = Vector3
	local l_7_5 = l_7_2.x + l_7_3.x * l_7_0._aiming_x_coefficient
	local l_7_8 = l_7_2.y
	l_7_8 = l_7_8 + l_7_3.y * l_7_0._aiming_y_coefficient
	local l_7_6 = nil
	l_7_6 = l_7_2.z
	local l_7_7 = nil
	return l_7_4(l_7_5, l_7_8, l_7_6)
end

DebugBasicAimStateControllerInterpreter._update_acceleration = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_1:length()
	if l_8_0._aiming_acceleration_threshold <= l_8_3 then
		l_8_0._acc_time = math.clamp(l_8_0._acc_time + l_8_2, 0, l_8_0._aiming_acceleration_time)
		l_8_0._last_acc_direction = l_8_1
	else
		l_8_0._acc_time = math.clamp(l_8_0._acc_time - l_8_2, 0, l_8_0._aiming_acceleration_time)
	end
	if l_8_3 > 0 and l_8_0._last_acc_direction and l_8_0._last_acc_direction:angle(l_8_1) > 90 then
		l_8_0._acc_time = 0
	end
end

DebugBasicAimStateControllerInterpreter._adjust_look = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = l_9_0:_adjust_aiming(l_9_1)
	if l_9_3 then
		l_9_0:_update_acceleration(l_9_1, l_9_2)
		local l_9_8 = l_9_0:_adjust_acceleration
		l_9_8 = l_9_8(l_9_0, l_9_1, l_9_4)
		l_9_4 = l_9_8
	else
		l_9_0._acc_time = 0
	end
	local l_9_5, l_9_6 = l_9_0:_invert_look, l_9_0
	local l_9_7 = l_9_4
	return l_9_5(l_9_6, l_9_7)
end

DebugBasicAimStateControllerInterpreter._update_look = function(l_10_0, l_10_1, l_10_2)
	-- upvalues: l_0_0
	local l_10_3 = l_10_1:get_input_axis(l_0_0)
	local l_10_4 = not l_10_1:get_connection_settings(l_0_0):get_no_limit()
	local l_10_5 = (l_10_0:_adjust_look(l_10_3, l_10_2, l_10_4))
	local l_10_6, l_10_7, l_10_8 = nil, nil, nil
	l_10_0:update_constraints(l_10_2)
	l_10_0._look:set_look_input(l_10_5)
end

DebugBasicAimStateControllerInterpreter.update_constraints = function(l_11_0, l_11_1)
	local l_11_2, l_11_3, l_11_4 = nil, nil, nil
	if l_11_0._unit:camera():active_camera() then
		l_11_2 = l_11_0._unit:camera():camera_constraints()
	end
	if l_11_2 and l_11_3 and l_11_4 then
		l_11_0._look:set_pitch_constraints(l_11_2:yaw() - l_11_4, l_11_2:yaw() + l_11_4)
		l_11_0._look:set_yaw_constraints(l_11_2:roll(), l_11_3, l_11_3)
	elseif l_11_0._reset_constraints then
		l_11_0._look:reset_constraints()
	end
end

DebugBasicAimStateControllerInterpreter.input = function(l_12_0)
	return l_12_0._input
end

DebugBasicAimStateControllerInterpreter._debug_render_eye_target = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_4 = Draw:brush()
	local l_13_5 = 5
	local l_13_6 = Color(0, 0, 1)
	local l_13_7 = Color(1, 0, 0)
	local l_13_8 = Color(1, 1, 1)
	l_13_4:set_color(l_13_6)
	l_13_4:sphere(l_13_0._input:eye_target_position(), l_13_5)
	l_13_4:set_color(l_13_8)
	l_13_4:line(l_13_1, l_13_0._input:eye_target_position())
	l_13_4:set_color(l_13_8)
	l_13_4:set_color(l_13_7)
	l_13_4:sphere(l_13_0._input:aim_target_position(), l_13_5)
	l_13_4:set_color(Color(1, 1, 0))
	l_13_4:sphere(l_13_2, l_13_5)
	l_13_4:set_color(Color(0, 1, 1))
	l_13_4:sphere(l_13_3, l_13_5)
end

DebugBasicAimStateControllerInterpreter._update_aim = function(l_14_0, l_14_1, l_14_2)
	local l_14_3 = managers.slot:get_mask("shootable_wo_adr_shield")
	local l_14_4 = (l_14_0._unit:raycast("ray", l_14_1, l_14_2, "slot_mask", l_14_3))
	local l_14_5, l_14_6, l_14_7 = nil, nil, nil
	if l_14_4 then
		l_14_5 = l_14_4.position
		l_14_6 = l_14_4.unit
		l_14_7 = l_14_4.body
	else
		l_14_5 = l_14_2
		l_14_7, l_14_6 = nil
	end
	l_14_0._input:set_aim_target_position(l_14_5)
	if l_14_0._unit:player_data() then
		l_14_0._unit:player_data().aim_target_position = l_14_5
		l_14_0._unit:player_data().aim_target_unit = l_14_6
		l_14_0._unit:player_data().aim_target_body = l_14_7
	end
end

DebugBasicAimStateControllerInterpreter._set_aiming_values = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4, l_15_5, l_15_6, l_15_7, l_15_8)
	l_15_0._aiming_x_coefficient = l_15_1
	l_15_0._aiming_x_exponent = l_15_2
	l_15_0._aiming_x_dead_zone = l_15_3
	l_15_0._aiming_x_start_value = l_15_4
	l_15_0._aiming_y_coefficient = l_15_5
	l_15_0._aiming_y_exponent = l_15_6
	l_15_0._aiming_y_dead_zone = l_15_7
	l_15_0._aiming_y_start_value = l_15_8
end

DebugBasicAimStateControllerInterpreter._set_aiming_acceleration_enabled = function(l_16_0, l_16_1)
	l_16_0._aiming_acceleration_enabled = l_16_1
end

DebugBasicAimStateControllerInterpreter._set_aiming_acceleration_values = function(l_17_0, l_17_1, l_17_2, l_17_3)
	l_17_0._aiming_acceleration_threshold = l_17_1
	l_17_0._aiming_acceleration_time = l_17_2
	l_17_0._aiming_acceleration_factor = l_17_3
end


