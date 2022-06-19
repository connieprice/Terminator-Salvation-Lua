CharacterControllerInterpreterManager = CharacterControllerInterpreterManager or class()
assert(controller_interpreter_extension_available, "Update you exe")
function CharacterControllerInterpreterManager.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._current_state_interpreter = nil
	A0_0:_create_state_interpreters()
	A0_0._base = nil
end
function CharacterControllerInterpreterManager.enable(A0_2, A1_3)
	A0_2._controller = A1_3
	A0_2._base = A0_2._unit:base()
end
function CharacterControllerInterpreterManager.disable(A0_4)
	A0_4._controller = nil
	if A0_4._current_state_interpreter and A0_4._current_state_interpreter.deactivate then
		A0_4._current_state_interpreter:deactivate()
	end
	A0_4._current_state_interpreter = nil
end
function CharacterControllerInterpreterManager._create_state_interpreters(A0_5, A1_6)
	local L2_7, L3_8, L4_9, L5_10, L6_11, L7_12
	A0_5._state_interpreters = L2_7
	for L5_10, L6_11 in L2_7(L3_8) do
		L7_12 = _G
		L7_12 = L7_12[L6_11]
		assert(L7_12, "Controller interpreter class not found '" .. L6_11 .. "'")
		assert(L7_12.new, "new function missing in class '" .. L6_11 .. "'")
		A0_5._state_interpreters[L5_10] = L7_12:new(A0_5._unit)
	end
end
function CharacterControllerInterpreterManager.update(A0_13, A1_14, A2_15, A3_16)
	local L4_17, L5_18
	L4_17 = assert
	L5_18 = A0_13._controller
	L4_17(L5_18)
	L4_17 = assert
	L5_18 = A0_13._base
	L4_17(L5_18)
	L4_17 = A0_13._base
	L5_18 = L4_17
	L4_17 = L4_17.current_state_name
	L4_17 = L4_17(L5_18)
	L5_18 = assert
	L5_18(L4_17, "current state-name for unit:" .. A1_14:name() .. " is illegal")
	L5_18 = A0_13._state_interpreters
	L5_18 = L5_18[L4_17]
	assert(L5_18, "State: '" .. L4_17 .. "' for unit:" .. A1_14:name() .. " is illegal")
	if L5_18 ~= A0_13._current_state_interpreter then
		if A0_13._current_state_interpreter and A0_13._current_state_interpreter.deactivate then
			A0_13._current_state_interpreter:deactivate()
		end
		A0_13._current_state_interpreter = L5_18
		assert(A0_13._current_state_interpreter)
		if A0_13._current_state_interpreter.activate then
			A0_13._current_state_interpreter:activate()
		end
		Application:debug("Changing controller interpreter from ", L4_17)
	end
	assert(A0_13._current_state_interpreter)
	A0_13._current_state_interpreter:update(A0_13._controller, A3_16)
end
function CharacterControllerInterpreterManager.save(A0_19, A1_20)
end
function CharacterControllerInterpreterManager.load(A0_21, A1_22)
end
