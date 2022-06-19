if not PcUserId then
	PcUserId = class()
end
PcUserId._next_id = 0
PcUserId.init = function(l_1_0, l_1_1)
	if l_1_1 then
		l_1_0.user_id = l_1_1
	else
		PcUserId._next_id = PcUserId._next_id + 1
		l_1_0.user_id = PcUserId._next_id
	end
end

PcUserId.key = function(l_2_0)
	return l_2_0.user_id
end


