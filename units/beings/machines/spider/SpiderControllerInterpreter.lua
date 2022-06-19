require("units/beings/CharacterControllerInterpreter/DebugBasicAimStateCI")
if not SpiderControllerInterpreter then
	SpiderControllerInterpreter = class(DebugBasicAimStateControllerInterpreter)
end
SpiderControllerInterpreter.init = function(l_1_0, l_1_1)
	DebugBasicAimStateControllerInterpreter.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._input = l_1_0._unit:input()
end

SpiderControllerInterpreter.enable = function(l_2_0, l_2_1)
	l_2_0._controller = l_2_1
end

SpiderControllerInterpreter.disable = function(l_3_0)
	l_3_0._controller = nil
end

SpiderControllerInterpreter.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	assert(l_4_0._controller)
	l_4_0._input:clear()
	DebugBasicAimStateControllerInterpreter.update(l_4_0, l_4_0._controller, l_4_3)
	local l_4_4 = l_4_0._unit:camera_data().camera_rotation:x()
	local l_4_5 = l_4_0._unit:camera_data().camera_rotation:y()
	local l_4_6 = l_4_0._controller:get_input_axis("move")
	local l_4_7 = l_4_6.x * l_4_4:flat(math.UP):normalized()
	local l_4_8 = l_4_6.y * l_4_5:flat(math.UP):normalized()
	local l_4_9 = l_4_7 + l_4_8
	l_4_0._input:set_movement(l_4_9)
	if l_4_0._controller:get_input_bool("fire") then
		l_4_0._input:set_fire()
	end
	if l_4_0._controller:get_input_bool("zoom") then
		l_4_0._input:set_charge_direction(l_4_5)
	end
	l_4_0._input:set_is_scanning(l_4_0._controller:get_input_bool("enter_cover"))
end


