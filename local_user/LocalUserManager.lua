require("local_user/LocalUser")
if not LocalUserManager then
	LocalUserManager = class()
end
LocalUserManager.init = function(l_1_0, l_1_1)
	local l_1_5, l_1_6, l_1_7, l_1_8 = nil
	l_1_0._users = {}
	for i_0,i_1 in pairs(l_1_1.user_indexes) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_1_0._users[l_1_10] = LocalUser:new(l_1_1.users[l_1_10], l_1_10, managers.controller:create_controller(nil, l_1_1.controller_index[i_1]), l_1_1.controller_index[i_1])
	end
	l_1_0._user_index_to_player_slot_id = l_1_1.user_index_to_player_slot_id
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

LocalUserManager.default_data = function(l_2_0)
	l_2_0.user_indexes = {}
	l_2_0.user_index_to_player_slot_id = {}
	l_2_0.users = {}
end

LocalUserManager.save = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17 = nil
	l_3_1.user_index_to_player_slot_id = l_3_0._user_index_to_player_slot_id
	l_3_1.user_indexes = {}
	l_3_1.users = {}
	l_3_1.controller_index = {}
	for i_0,i_1 in pairs(l_3_0._users) do
		l_3_1.user_indexes[i_0] = i_0
		l_3_1.users[i_0] = {}
		l_3_1.controller_index[i_0] = i_1:get_controller_index()
		i_1:save(l_3_1.users[i_0])
	end
end

LocalUserManager.set_user_index_to_player_slot_id = function(l_4_0, l_4_1, l_4_2)
	l_4_0._user_index_to_player_slot_id[l_4_1] = l_4_2
end

LocalUserManager.add_user = function(l_5_0, l_5_1, l_5_2, l_5_3)
	print("adding user at index:" .. l_5_1)
	local l_5_4 = {}
	LocalUser.default_data(l_5_4)
	local l_5_5 = LocalUser:new(l_5_4, l_5_1, l_5_2, l_5_3)
	local l_5_6 = l_5_0._user_index_to_player_slot_id[l_5_1]
	if l_5_6 then
		l_5_5:set_wanted_player_slot_id(l_5_6)
	end
	l_5_0._users[l_5_1] = l_5_5
end

LocalUserManager.remove_user = function(l_6_0, l_6_1)
	l_6_0._users[l_6_1] = nil
end

LocalUserManager.users = function(l_7_0)
	return l_7_0._users
end

LocalUserManager.user_from_user_index = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8 = nil
	for i_0,i_1 in pairs(l_8_0._users) do
		if i_1:user_index() == l_8_1 then
			return i_1
		end
	end
end

LocalUserManager.update = function(l_9_0, l_9_1)
	local l_9_5, l_9_6, l_9_7, l_9_8 = nil
	for i_0,i_1 in pairs(l_9_0._users) do
		i_1:update(l_9_1)
	end
end

LocalUserManager.has_any_user = function(l_10_0)
	local l_10_1, l_10_2 = next(l_10_0._users, nil)
	return l_10_2 ~= nil
end


