Menu2DStateTransitionLookup = Menu2DStateTransitionLookup or class()
function Menu2DStateTransitionLookup.init(A0_0, A1_1)
	A0_0._extracted_state_transitions = {}
	A0_0:_extract_level(A1_1)
end
function Menu2DStateTransitionLookup._extract_level(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8, L7_9, L8_10
	for L6_8, L7_9 in L3_5(L4_6) do
		L8_10 = A2_4 or L7_9.state
		if L7_9.state_transition then
			A0_2._extracted_state_transitions[L7_9.state_transition] = L8_10
		else
			A0_2:_extract_level(L7_9.state_transitions, L8_10)
		end
	end
end
function Menu2DStateTransitionLookup.state(A0_11, A1_12)
	return A0_11._extracted_state_transitions[A1_12]
end
