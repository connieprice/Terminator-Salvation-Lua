require("shared/FiniteStateMachine")
Menu2DState = Menu2DState or class(FiniteStateMachineState)
function Menu2DState.init(A0_0, A1_1)
	A0_0._self_class = A1_1
	A0_0._state_transition_lookup = Menu2DStateTransitionLookup:new(A0_0._state_data.state_transitions)
end
function Menu2DState.transition(A0_2)
	local L1_3
	L1_3 = A0_2._state_data
	L1_3 = L1_3.menu
	L1_3 = L1_3.state_transition_data
	L1_3 = L1_3.requested_state
	if A0_2._state_transition_lookup:state(L1_3) == A0_2._self_class then
		return nil
	else
		return (A0_2._state_transition_lookup:state(L1_3))
	end
end
