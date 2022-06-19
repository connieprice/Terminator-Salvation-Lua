if not LocalSessionUserManager then
	LocalSessionUserManager = class()
end
LocalSessionUserManager.init = function(l_1_0, l_1_1)
	local l_1_5, l_1_6, l_1_7, l_1_8 = nil
	l_1_0._users = {}
	for i_0,i_1 in pairs(l_1_1.users) do
		l_1_0._users[managers.local_user:user_from_user_index(i_1)] = managers.local_user:user_from_user_index(i_1)
	end
end

LocalSessionUserManager.default_data = function(l_2_0)
	l_2_0.users = {}
end

LocalSessionUserManager.save = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10 = nil
	l_3_1.users = {}
	for i_0,i_1 in pairs(l_3_0._users) do
		l_3_1.users[i_1:user_index()] = l_3_12:user_index()
	end
end

LocalSessionUserManager.destroy = function(l_4_0)
	l_4_0._users = {}
end

LocalSessionUserManager.add_user = function(l_5_0, l_5_1)
	l_5_0._users[l_5_1] = l_5_1
end

LocalSessionUserManager.remove_user = function(l_6_0, l_6_1)
	l_6_0._users[l_6_1] = nil
end

LocalSessionUserManager.update = function(l_7_0)
end

LocalSessionUserManager.users = function(l_8_0)
	return l_8_0._users
end

LocalSessionUserManager.has_user = function(l_9_0, l_9_1)
	return l_9_0._users[l_9_1] ~= nil
end


