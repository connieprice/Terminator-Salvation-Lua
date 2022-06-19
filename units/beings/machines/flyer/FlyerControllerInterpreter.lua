require("units/beings/player/look/PlayerLook")
require("units/beings/CharacterControllerInterpreter/DebugBasicAimStateCI")
if not FlyerControllerInterpreter then
	FlyerControllerInterpreter = class(DebugBasicAimStateControllerInterpreter)
end
FlyerControllerInterpreter.init = function(l_1_0, l_1_1)
	DebugBasicAimStateControllerInterpreter.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._input = l_1_0._unit:input()
	l_1_0._chassi_body = l_1_1:body("default_body")
	l_1_0._prev_xy_acceleration = Vector3(0, 0, 0)
end

FlyerControllerInterpreter.enable = function(l_2_0, l_2_1)
	l_2_0._controller = l_2_1
end

FlyerControllerInterpreter.disable = function(l_3_0)
	l_3_0._controller = nil
end

FlyerControllerInterpreter.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	assert(l_4_0._controller)
	l_4_0._input:clear()
	DebugBasicAimStateControllerInterpreter.update(l_4_0, l_4_0._controller, l_4_3)
	local l_4_4 = l_4_1:camera_data()
	local l_4_5 = l_4_0._controller:get_input_axis("move")
	local l_4_6 = l_4_5.x * l_4_4.camera_rotation:x() + l_4_5.y * l_4_4.camera_rotation:y()
	l_4_6:with_z(math.min(4 * l_4_6.z, 1))
	local l_4_7, l_4_8 = nil, nil
	l_4_7 = l_4_0:_update_movement(l_4_6, l_4_3)
	l_4_0._input:set_acceleration(l_4_7)
	l_4_0._input:set_angular_acceleration(l_4_8)
	local l_4_9 = l_4_0._unit:camera_data().camera_position
	local l_4_10 = l_4_0._unit:camera_data().camera_rotation:y()
	local l_4_11 = l_4_0._look:eye_target_position()
	l_4_0._input:set_eye_target_position(l_4_11)
	local l_4_12 = l_4_0._look:eye_target_position()
	l_4_0._input:set_aim_target_position(l_4_12)
	local l_4_13 = l_4_0._unit:position()
	if l_4_0._controller:get_input_bool("fire") then
		l_4_0._input:set_fire()
	end
	l_4_0._input:set_defensive(l_4_0._controller:get_input_bool("zoom"))
	if l_4_0._controller:get_input_pressed("enter_cover") then
		l_4_0._input:set_self_destroy()
	end
end

FlyerControllerInterpreter._update_movement = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_0._chassi_body:center_of_mass()
	local l_5_4 = math.UP
	local l_5_5 = l_5_0._chassi_body:rotation():y()
	local l_5_6 = l_5_0._chassi_body:rotation():z()
	local l_5_7 = l_5_0._chassi_body:velocity()
	local l_5_8 = l_5_0._chassi_body:angular_velocity()
	local l_5_9 = 10
	local l_5_10 = 700
	local l_5_11 = 70
	local l_5_12 = 5
	local l_5_13 = 60
	local l_5_14 = 2
	local l_5_15 = 5
	local l_5_16 = 10
	local l_5_17 = l_5_1
	local l_5_18 = l_5_17:with_z(0)
	local l_5_19 = math.lerp(l_5_14, l_5_15, math.min(l_5_7:length(), l_5_10) / l_5_10)
	local l_5_20 = l_5_7:with_z(0)
	local l_5_21 = l_5_10
	local l_5_22 = l_5_18:normalized() * l_5_21
	local l_5_23 = l_5_22 - l_5_20
	local l_5_24 = l_5_23:normalized() * math.min(l_5_23:length(), l_5_10) * l_5_19
	l_5_24 = math.lerp(l_5_0._prev_xy_acceleration, l_5_24, math.min(l_5_9 * l_5_2, 1))
	l_5_0._prev_xy_acceleration = l_5_24
	local l_5_25 = l_5_10 * l_5_17.z
	local l_5_26 = math.UP * (l_5_25 - math.clamp(l_5_7.z, -l_5_10, l_5_10)) * l_5_16
	local l_5_27 = -0.5 * World:gravity() + l_5_24 + l_5_26
	local l_5_28 = l_5_19 * l_5_10
	local l_5_29 = l_5_24:length() / l_5_28
	local l_5_30 = math.lerp(0, l_5_11, l_5_29)
	l_5_4 = l_5_4:rotate_with(Rotation(l_5_4:cross(l_5_24), l_5_30))
	l_5_0._prev_wanted_up = l_5_4
	local l_5_31 = 5
	local l_5_32 = 3
	local l_5_33 = 30
	local l_5_34 = l_5_0._chassi_body:position()
	local l_5_35 = l_5_6:dot(l_5_4)
	local l_5_37 = l_5_6:cross(l_5_4):normalized() * math.lerp(l_5_31, 0, math.pow(l_5_35, 20))
	local l_5_38 = nil
	l_5_37 = l_5_37 + l_5_6 * math.lerp(l_5_31, -l_5_31, (l_5_33 - math.clamp(l_5_0._look:eye_target_position() - l_5_34:to_polar_with_reference(l_5_5, l_5_6).spin, -l_5_33, l_5_33)) / (2 * l_5_33))
	local l_5_36 = nil
	local l_5_39 = (l_5_37 - l_5_8:normalized() * math.min(l_5_8:length(), l_5_31)) * l_5_32
	return l_5_27, l_5_39
end


