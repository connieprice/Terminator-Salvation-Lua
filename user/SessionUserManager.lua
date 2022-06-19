if not SessionUserManager then
	SessionUserManager = class()
end
SessionUserManager.init = function(l_1_0, l_1_1)
	local l_1_5, l_1_6, l_1_7, l_1_8 = nil
	l_1_0._users = {}
	l_1_0._session_user_id_to_track_id = l_1_1.session_user_id_to_track_id
	for i_0,i_1 in pairs(l_1_1.users) do
		l_1_0._users[i_0] = managers.local_user:user_from_user_index(i_1)
	end
end

SessionUserManager.default_data = function(l_2_0)
	l_2_0.users = {}
	l_2_0.session_user_id_to_track_id = {}
end

SessionUserManager.save = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8 = nil
	l_3_1.session_user_id_to_track_id = l_3_0._session_user_id_to_track_id
	l_3_1.users = {}
	for i_0,i_1 in pairs(l_3_0._users) do
		l_3_1.users[i_0] = i_1:user_index()
	end
end

SessionUserManager.destroy = function(l_4_0)
	local l_4_4, l_4_5, l_4_6 = nil
	for i_0,i_1 in pairs(l_4_0._users) do
		l_4_0:remove_user(i_0)
	end
end

SessionUserManager.add_user = function(l_5_0, l_5_1, l_5_2, l_5_3)
	l_5_0._users[l_5_1] = l_5_2
	l_5_0._session_user_id_to_track_id[l_5_1] = l_5_3
	local l_5_4 = managers.player_slot:slot(l_5_3)
	local l_5_5, l_5_6 = l_5_4:set_user, l_5_4
	local l_5_7 = l_5_2
	l_5_5(l_5_6, l_5_7, l_5_3 == 1)
end

SessionUserManager.remove_user = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0._session_user_id_to_track_id[l_6_1]
	local l_6_3 = managers.player_slot:slot(l_6_2)
	assert(l_6_3)
	l_6_3:release_user()
	l_6_0._users[l_6_1] = nil
	l_6_0._session_user_id_to_track_id[l_6_1] = nil
end

SessionUserManager.update = function(l_7_0)
end

SessionUserManager.users = function(l_8_0)
	return l_8_0._users
end

SessionUserManager.has_user = function(l_9_0, l_9_1)
	return l_9_0._users[l_9_1] ~= nil
end

SessionUserManager.user = function(l_10_0, l_10_1)
	return l_10_0._users[l_10_1]
end


