if not MultiStateRequest then
	MultiStateRequest = class()
end
MultiStateRequest.init = function(l_1_0)
	l_1_0._request_states = {}
end

MultiStateRequest.request = function(l_2_0, l_2_1, l_2_2)
	l_2_0._request_states[l_2_1] = l_2_2
end

MultiStateRequest.wants_enabled_state = function(l_3_0)
	local l_3_4, l_3_5 = nil
	for i_0,i_1 in pairs(l_3_0._request_states) do
		if i_1 == true then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MultiStateRequest.wants_disabled_state = function(l_4_0)
	local l_4_5, l_4_6, l_4_7, l_4_8 = nil
	local l_4_1 = false
	for i_0,i_1 in pairs(l_4_0._request_states) do
		if i_1 == false then
			l_4_1 = true
		elseif i_1 == true then
			return 
		end
	end
	return l_4_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


