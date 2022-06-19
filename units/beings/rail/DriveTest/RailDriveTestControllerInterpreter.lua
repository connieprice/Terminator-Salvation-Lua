if not RailDriveTestControllerInterpreter then
	RailDriveTestControllerInterpreter = class(DebugBasicAimStateControllerInterpreter)
end
RailDriveTestControllerInterpreter.init = function(l_1_0, l_1_1)
	DebugBasicAimStateControllerInterpreter.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._input = l_1_0._unit:input()
	l_1_0._turn = 0
end

RailDriveTestControllerInterpreter.enable = function(l_2_0, l_2_1)
	l_2_0._controller = l_2_1
end

RailDriveTestControllerInterpreter.disable = function(l_3_0)
	l_3_0._controller = nil
end

RailDriveTestControllerInterpreter.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if not l_4_0._controller then
		return 
	end
	l_4_0._input:clear()
	DebugBasicAimStateControllerInterpreter.update(l_4_0, l_4_0._controller, l_4_3)
	local l_4_4 = 0.01
	local l_4_5 = l_4_0._controller:get_input_axis("move")
	local l_4_6 = l_4_4 * (l_4_3 / l_4_4)
	local l_4_7 = l_4_0._controller:get_input_float("fire") - l_4_0._controller:get_input_float("zoom")
	local l_4_8 = l_4_0._controller:get_input_float("toggle_flashlight")
	local l_4_9 = math.lerp(l_4_0._turn, -l_4_5.x, math.min(1, 4 * l_4_3))
	l_4_0._turn = l_4_9
	local l_4_10 = Vector3(l_4_7, l_4_0._turn, l_4_8)
	l_4_0._input:set_movement(l_4_10)
end


