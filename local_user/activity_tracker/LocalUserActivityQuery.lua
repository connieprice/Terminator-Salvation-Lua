LocalUserActivityQuery = LocalUserActivityQuery or class()
function LocalUserActivityQuery.init(A0_0, A1_1)
	A0_0._local_user = A1_1
end
function LocalUserActivityQuery.has_assigned_unit(A0_2)
	return A0_2._local_user:assigned_unit() ~= nil
end
function LocalUserActivityQuery.is_menu_bound(A0_3)
	return A0_3._local_user == managers.menu_input:bound_user()
end
