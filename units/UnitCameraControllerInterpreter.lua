if not UnitCameraControllerInterpreter then
	UnitCameraControllerInterpreter = class()
end
UnitCameraControllerInterpreter.init = function(l_1_0, l_1_1)
end

UnitCameraControllerInterpreter.enable = function(l_2_0, l_2_1)
	l_2_0._controller = l_2_1
end

UnitCameraControllerInterpreter.disable = function(l_3_0)
	l_3_0._controller = nil
end


