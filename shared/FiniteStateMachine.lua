FiniteStateMachine = FiniteStateMachine or class()
function FiniteStateMachine.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._object = A1_1
	A0_0._object_name = A2_2
	A0_0:_set_state(A3_3)
	A0_0._debug = false
end
function FiniteStateMachine.set_debug(A0_4, A1_5)
	A0_4._debug = A1_5
end
function FiniteStateMachine.destroy(A0_6)
	if A0_6._state.exit then
		A0_6._state:exit()
	end
end
function FiniteStateMachine._set_state(A0_7, A1_8)
	if A0_7._debug then
	end
	if A0_7._state and A0_7._state.exit then
		A0_7._state:exit()
		A0_7._state = nil
	end
	function A1_8.init()
		local L0_9, L1_10
	end
	A0_7._state = A1_8:new()
	assert(A0_7._state ~= nil)
	assert(A0_7._state.update ~= FiniteStateMachine.update)
	A1_8.init = A1_8.init
	A0_7._state[A0_7._object_name] = A0_7._object
	A0_7._state_class = A1_8
	if A1_8.init then
		A0_7._state:init()
	end
end
function FiniteStateMachine.update(A0_11, A1_12)
	local L2_13
	L2_13 = assert
	L2_13(A0_11._state)
	L2_13 = A0_11._state
	L2_13 = L2_13.pre_update_transition
	if L2_13 then
		L2_13 = A0_11._state
		L2_13 = L2_13.pre_update_transition
		L2_13 = L2_13(L2_13)
		if L2_13 then
			A0_11:_set_state(L2_13)
		end
	end
	L2_13 = A0_11._state
	L2_13 = L2_13.update
	if L2_13 then
		L2_13 = A0_11._state
		L2_13 = L2_13.update
		L2_13(L2_13, A1_12)
	end
	L2_13 = A0_11._state
	L2_13 = L2_13.transition
	L2_13 = L2_13(L2_13)
	if L2_13 then
		A0_11:_set_state(L2_13)
	end
end
function FiniteStateMachine._debug_state_name(A0_14)
	return class_name(A0_14._state_class)
end
