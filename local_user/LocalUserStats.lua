if not LocalUserStats then
	LocalUserStats = class()
end
LocalUserStats.init = function(l_1_0)
end

LocalUserStats.destroy = function(l_2_0)
end

LocalUserStats.set_assigned_unit_and_stats = function(l_3_0, l_3_1, l_3_2)
	assert(l_3_2)
	if l_3_0._listener then
		managers.action_event:unregister_listener(l_3_0)
	end
	l_3_0._listener = managers.action_event:register_listener(l_3_0, nil, nil)
	l_3_0._stats = l_3_2
	l_3_0._unit = l_3_1
end


