require("shared/FiniteStateMachine")
if not Menu2DState then
	Menu2DState = class(FiniteStateMachineState)
end
Menu2DState.init = function(l_1_0, l_1_1)
	l_1_0._self_class = l_1_1
	l_1_0._state_transition_lookup = Menu2DStateTransitionLookup:new(l_1_0._state_data.state_transitions)
end

Menu2DState.transition = function(l_2_0)
	local l_2_1 = l_2_0._state_data.menu.state_transition_data.requested_state
	local l_2_2 = l_2_0._state_transition_lookup:state(l_2_1)
	if l_2_2 == l_2_0._self_class then
		return nil
	else
		return l_2_2
	end
end


