if not User then
	User = class()
end
User.init = function(l_1_0, l_1_1)
	l_1_0._local_user_index = l_1_1
end

User.local_user_index = function(l_2_0)
	return l_2_0._local_user_index
end

User.set_assigned_unit = function(l_3_0, l_3_1)
	l_3_0._assigned_unit = l_3_1
end

User.release_assigned_unit = function(l_4_0)
	l_4_0._assigned_unit = nil
end

User.assigned_unit = function(l_5_0)
	if not alive(l_5_0._assigned_unit) then
		l_5_0:release_assigned_unit()
		assert(not l_5_0._assigned_unit)
	end
	return l_5_0._assigned_unit
end

User.update = function(l_6_0, l_6_1)
	if not alive(l_6_0._assigned_unit) then
		l_6_0:release_assigned_unit()
	end
end


