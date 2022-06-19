if not CharacterControllerInterpreterManager then
	CharacterControllerInterpreterManager = class()
end
assert(controller_interpreter_extension_available, "Update you exe")
CharacterControllerInterpreterManager.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._current_state_interpreter = nil
	l_1_0:_create_state_interpreters()
	l_1_0._base = nil
end

CharacterControllerInterpreterManager.enable = function(l_2_0, l_2_1)
	l_2_0._controller = l_2_1
	l_2_0._base = l_2_0._unit:base()
end

CharacterControllerInterpreterManager.disable = function(l_3_0)
	l_3_0._controller = nil
	if l_3_0._current_state_interpreter and l_3_0._current_state_interpreter.deactivate then
		l_3_0._current_state_interpreter:deactivate()
	end
	l_3_0._current_state_interpreter = nil
end

CharacterControllerInterpreterManager._create_state_interpreters = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8 = nil
	l_4_0._state_interpreters = {}
	for i_0,i_1 in pairs(l_4_0.interpreters) do
		assert(_G[i_1], "Controller interpreter class not found '" .. i_1 .. "'")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		assert(_G[i_1].new, "new function missing in class '" .. i_1 .. "'")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_0._state_interpreters[l_4_9] = _G[i_1]:new(l_4_0._unit)
	end
end

CharacterControllerInterpreterManager.update = function(l_5_0, l_5_1, l_5_2, l_5_3)
	assert(l_5_0._controller)
	assert(l_5_0._base)
	local l_5_4 = l_5_0._base:current_state_name()
	assert(l_5_4, "current state-name for unit:" .. l_5_1:name() .. " is illegal")
	local l_5_5 = l_5_0._state_interpreters[l_5_4]
	assert(l_5_5, "State: '" .. l_5_4 .. "' for unit:" .. l_5_1:name() .. " is illegal")
	if l_5_5 ~= l_5_0._current_state_interpreter then
		if l_5_0._current_state_interpreter and l_5_0._current_state_interpreter.deactivate then
			l_5_0._current_state_interpreter:deactivate()
		end
		l_5_0._current_state_interpreter = l_5_5
		assert(l_5_0._current_state_interpreter)
		if l_5_0._current_state_interpreter.activate then
			l_5_0._current_state_interpreter:activate()
		end
		Application:debug("Changing controller interpreter from ", l_5_4)
	end
	assert(l_5_0._current_state_interpreter)
	l_5_0._current_state_interpreter:update(l_5_0._controller, l_5_3)
end

CharacterControllerInterpreterManager.save = function(l_6_0, l_6_1)
end

CharacterControllerInterpreterManager.load = function(l_7_0, l_7_1)
end


