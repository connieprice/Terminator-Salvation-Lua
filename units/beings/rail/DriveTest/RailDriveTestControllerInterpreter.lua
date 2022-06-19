RailDriveTestControllerInterpreter = RailDriveTestControllerInterpreter or class(DebugBasicAimStateControllerInterpreter)
function RailDriveTestControllerInterpreter.init(A0_0, A1_1)
	DebugBasicAimStateControllerInterpreter.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._input = A0_0._unit:input()
	A0_0._turn = 0
end
function RailDriveTestControllerInterpreter.enable(A0_2, A1_3)
	A0_2._controller = A1_3
end
function RailDriveTestControllerInterpreter.disable(A0_4)
	local L1_5
	A0_4._controller = nil
end
function RailDriveTestControllerInterpreter.update(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11, L6_12, L7_13, L8_14, L9_15, L10_16
	L4_10 = A0_6._controller
	if not L4_10 then
		return
	end
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
	L4_10 = 0.01
	L5_11 = A0_6._controller
	L6_12 = L5_11
	L5_11 = L5_11.get_input_axis
	L7_13 = "move"
	L5_11 = L5_11(L6_12, L7_13)
	L6_12 = A3_9 / L4_10
	L6_12 = L4_10 * L6_12
	L7_13 = A0_6._controller
	L8_14 = L7_13
	L7_13 = L7_13.get_input_float
	L9_15 = "fire"
	L7_13 = L7_13(L8_14, L9_15)
	L8_14 = A0_6._controller
	L9_15 = L8_14
	L8_14 = L8_14.get_input_float
	L10_16 = "zoom"
	L8_14 = L8_14(L9_15, L10_16)
	L7_13 = L7_13 - L8_14
	L8_14 = A0_6._controller
	L9_15 = L8_14
	L8_14 = L8_14.get_input_float
	L10_16 = "toggle_flashlight"
	L8_14 = L8_14(L9_15, L10_16)
	L9_15 = math
	L9_15 = L9_15.lerp
	L10_16 = A0_6._turn
	L9_15 = L9_15(L10_16, -L5_11.x, math.min(1, 4 * A3_9))
	A0_6._turn = L9_15
	L10_16 = Vector3
	L10_16 = L10_16(L7_13, A0_6._turn, L8_14)
	A0_6._input:set_movement(L10_16)
end
