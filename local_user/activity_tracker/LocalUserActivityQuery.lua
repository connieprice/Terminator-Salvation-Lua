if not LocalUserActivityQuery then
	LocalUserActivityQuery = class()
end
LocalUserActivityQuery.init = function(l_1_0, l_1_1)
	l_1_0._local_user = l_1_1
end

LocalUserActivityQuery.has_assigned_unit = function(l_2_0)
	return l_2_0._local_user:assigned_unit() ~= nil
end

LocalUserActivityQuery.is_menu_bound = function(l_3_0)
	local l_3_1 = managers.menu_input:bound_user()
	return l_3_0._local_user == l_3_1
end


