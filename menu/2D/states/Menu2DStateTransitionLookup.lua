if not Menu2DStateTransitionLookup then
	Menu2DStateTransitionLookup = class()
end
Menu2DStateTransitionLookup.init = function(l_1_0, l_1_1)
	l_1_0._extracted_state_transitions = {}
	l_1_0:_extract_level(l_1_1)
end

Menu2DStateTransitionLookup._extract_level = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_1) do
		if l_2_2 or i_1.state_transition then
			l_2_0._extracted_state_transitions[i_1.state_transition] = i_1.state
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_2_0:_extract_level(i_1.state_transitions, i_1.state)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DStateTransitionLookup.state = function(l_3_0, l_3_1)
	return l_3_0._extracted_state_transitions[l_3_1]
end


