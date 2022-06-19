UnitCameraControllerInterpreter = UnitCameraControllerInterpreter or class()
function UnitCameraControllerInterpreter.init(A0_0, A1_1)
end
function UnitCameraControllerInterpreter.enable(A0_2, A1_3)
	A0_2._controller = A1_3
end
function UnitCameraControllerInterpreter.disable(A0_4)
	local L1_5
	A0_4._controller = nil
end
