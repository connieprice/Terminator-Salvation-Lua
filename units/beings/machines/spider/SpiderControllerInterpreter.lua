require("units/beings/CharacterControllerInterpreter/DebugBasicAimStateCI")
SpiderControllerInterpreter = SpiderControllerInterpreter or class(DebugBasicAimStateControllerInterpreter)
function SpiderControllerInterpreter.init(A0_0, A1_1)
	DebugBasicAimStateControllerInterpreter.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._input = A0_0._unit:input()
end
function SpiderControllerInterpreter.enable(A0_2, A1_3)
	A0_2._controller = A1_3
end
function SpiderControllerInterpreter.disable(A0_4)
	local L1_5
	A0_4._controller = nil
end
function SpiderControllerInterpreter.update(A0_6, A1_7, A2_8, A3_9)
	local L4_10, L5_11, L6_12, L7_13, L8_14, L9_15
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
	L4_10 = A0_6._unit
	L5_11 = L4_10
	L4_10 = L4_10.camera_data
	L4_10 = L4_10(L5_11)
	L4_10 = L4_10.camera_rotation
	L5_11 = L4_10
	L4_10 = L4_10.x
	L4_10 = L4_10(L5_11)
	L5_11 = A0_6._unit
	L6_12 = L5_11
	L5_11 = L5_11.camera_data
	L5_11 = L5_11(L6_12)
	L5_11 = L5_11.camera_rotation
	L6_12 = L5_11
	L5_11 = L5_11.y
	L5_11 = L5_11(L6_12)
	L6_12 = A0_6._controller
	L7_13 = L6_12
	L6_12 = L6_12.get_input_axis
	L8_14 = "move"
	L6_12 = L6_12(L7_13, L8_14)
	L7_13 = L6_12.x
	L9_15 = L4_10
	L8_14 = L4_10.flat
	L8_14 = L8_14(L9_15, math.UP)
	L9_15 = L8_14
	L8_14 = L8_14.normalized
	L8_14 = L8_14(L9_15)
	L7_13 = L7_13 * L8_14
	L8_14 = L6_12.y
	L9_15 = L5_11.flat
	L9_15 = L9_15(L5_11, math.UP)
	L9_15 = L9_15.normalized
	L9_15 = L9_15(L9_15)
	L8_14 = L8_14 * L9_15
	L9_15 = L7_13 + L8_14
	A0_6._input:set_movement(L9_15)
	if A0_6._controller:get_input_bool("fire") then
		A0_6._input:set_fire()
	end
	if A0_6._controller:get_input_bool("zoom") then
		A0_6._input:set_charge_direction(L5_11)
	end
	A0_6._input:set_is_scanning(A0_6._controller:get_input_bool("enter_cover"))
end
