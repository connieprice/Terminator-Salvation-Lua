if not FiniteStateMachine then
	FiniteStateMachine = class()
end
FiniteStateMachine.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._object = l_1_1
	l_1_0._object_name = l_1_2
	l_1_0:_set_state(l_1_3)
	l_1_0._debug = false
end

FiniteStateMachine.set_debug = function(l_2_0, l_2_1)
	l_2_0._debug = l_2_1
end

FiniteStateMachine.destroy = function(l_3_0)
	if l_3_0._state.exit then
		l_3_0._state:exit()
	end
end

FiniteStateMachine._set_state = function(l_4_0, l_4_1)
	if not l_4_0._debug or l_4_0._state and l_4_0._state.exit then
		l_4_0._state:exit()
		l_4_0._state = nil
	end
	local l_4_2 = l_4_1.init
	l_4_1.init = function()
  end
	l_4_0._state = l_4_1:new()
	local l_4_3 = assert
	l_4_3(l_4_0._state ~= nil)
	l_4_3 = assert
	l_4_3(l_4_0._state.update ~= FiniteStateMachine.update)
	l_4_1.init = l_4_2
	l_4_3 = l_4_0._state
	local l_4_8 = l_4_0._object_name
	l_4_3[l_4_8] = l_4_0._object
	l_4_0._state_class = l_4_1
	if l_4_2 then
		l_4_3 = l_4_0._state
		l_4_3, l_4_8 = l_4_3:init, l_4_3
		l_4_3(l_4_8)
	end
	l_4_3 = 1
end

FiniteStateMachine.update = function(l_5_0, l_5_1)
	assert(l_5_0._state)
	if l_5_0._state.pre_update_transition then
		local l_5_2 = l_5_0._state:pre_update_transition()
	if l_5_2 then
		end
		l_5_0:_set_state(l_5_2)
	end
	if l_5_0._state.update then
		l_5_0._state:update(l_5_1)
	end
	local l_5_3 = l_5_0._state:transition()
	if l_5_3 then
		l_5_0:_set_state(l_5_3)
	end
end

FiniteStateMachine._debug_state_name = function(l_6_0)
	local l_6_1 = class_name
	local l_6_2 = l_6_0._state_class
	return l_6_1(l_6_2)
end


