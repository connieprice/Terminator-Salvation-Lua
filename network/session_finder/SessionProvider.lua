require("network/session_finder/SessionClient")
if not SessionProvider then
	SessionProvider = class()
end
SessionProvider.init = function(l_1_0)
	Network:bind_callback(l_1_0)
	Network:set_server(false)
	Network:set_receiver("SessionProvider", l_1_0)
	l_1_0:clear()
end

SessionProvider.destroy = function(l_2_0)
	Network:unbind_callback()
end

SessionProvider.save = function(l_3_0, l_3_1)
	local l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12 = nil
	l_3_1.level_instance_id = l_3_0._level_instance_id
	l_3_1.level_name = l_3_0._level_name
	local l_3_2 = 1
	l_3_1.session_peer_data = {}
	for i_0,i_1 in pairs(l_3_0._session_peers) do
		l_3_1.session_peer_data[i_0] = {}
		i_1:save(l_3_1.session_peer_data[i_0])
	end
end

SessionProvider.load = function(l_4_0, l_4_1)
	local l_4_5, l_4_6 = nil
	l_4_0._level_instance_id = l_4_1.level_instance_id
	l_4_0._level_name = l_4_1.level_name
	l_4_0._session_peers = {}
	for i_0,i_1 in pairs(l_4_1.session_peer_data) do
		SessionPeer:new():load(i_1)
		l_4_0._session_peers[l_4_7] = SessionPeer:new()
	end
end

SessionProvider.session_info = function(l_5_0)
	return l_5_0._session_info
end

SessionProvider.received_ownership = function(l_6_0)
	l_6_0._i_am_owner = true
end

SessionProvider.lost_ownership = function(l_7_0)
	l_7_0._i_am_owner = false
end

SessionProvider.has_ownership = function(l_8_0)
	return l_8_0._i_am_owner
end

SessionProvider.clear = function(l_9_0)
	l_9_0._level_instance_id = 0
	l_9_0._session_peers = {}
	l_9_0._session_info = {}
	l_9_0._session_info.title = tweak_data.network.TITLE
	l_9_0._session_info.version = tweak_data.network.VERSION
	l_9_0._session_info.name = Network:hostname()
	l_9_0._session_info.game_mode = "test"
	l_9_0._session_info.player_count = 0
	l_9_0._session_info.maximum_player_count = 4
end

SessionProvider.lost_peer = function(l_10_0, l_10_1)
end

SessionProvider.lost_client = function(l_11_0, l_11_1)
end

SessionProvider.lost_server = function(l_12_0, l_12_1)
end

SessionProvider.update = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7, l_13_8 = nil
	for i_0,i_1 in pairs(l_13_0._session_peers) do
		i_1:update(l_13_1)
	end
end

SessionProvider.faith_find_session = function(l_14_0, l_14_1, l_14_2)
	cat_print("pebj", "Got Session Query")
	if not l_14_0._i_am_owner then
		return 
	end
	if l_14_1 ~= tweak_data.network.VERSION then
		return 
	end
	cat_print("pebj", "Responding to session query")
	l_14_2:faith_session_info(l_14_0._session_info)
end

SessionProvider.session_request_join = function(l_15_0, l_15_1, l_15_2)
	cat_print("pebj", "'" .. l_15_1 .. "' wants to join")
	local l_15_3 = l_15_2:to_string()
	if l_15_0._session_peers[l_15_3] then
		cat_print("pebj", "'" .. l_15_1 .. "' already joined")
		return 
	end
	if l_15_0._session_info.maximum_player_count <= l_15_0._session_info.player_count then
		cat_print("pebj", "Session is full!")
		return 
	end
	l_15_0._session_info.player_count = l_15_0._session_info.player_count + 1
	Network:add_client(l_15_2)
	l_15_0._session_peers[l_15_3] = SessionPeer:new(l_15_2)
	assert(l_15_0._checkpoint_index)
	l_15_0._session_peers[l_15_3]:load_level(l_15_0._level_name, l_15_0._checkpoint_index, l_15_0._level_instance_id)
end

SessionProvider.set_level_name = function(l_16_0, l_16_1, l_16_2)
	local l_16_10, l_16_11, l_16_12, l_16_13 = nil
	local l_16_3 = assert
	l_16_3(l_16_1 ~= nil)
	l_16_3 = assert
	l_16_3(l_16_1 ~= "")
	l_16_3 = l_16_0._level_instance_id
	l_16_3 = l_16_3 + 1
	l_16_0._level_instance_id = l_16_3
	l_16_0._level_name = l_16_1
	l_16_0._checkpoint_index = l_16_2
	l_16_3 = pairs
	l_16_3 = l_16_3(l_16_0._session_peers)
	for i_0,i_1 in l_16_3 do
		i_1:load_level(l_16_0._level_name, l_16_0._checkpoint_index, l_16_0._level_instance_id)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SessionProvider.level_instance_id = function(l_17_0)
	return l_17_0._level_instance_id
end

SessionProvider.level_name = function(l_18_0)
	return l_18_0._level_name
end

SessionProvider.game_synced = function(l_19_0, l_19_1, l_19_2)
	local l_19_3 = l_19_2:to_string()
	local l_19_4 = l_19_0._session_peers[l_19_3]
	assert(l_19_4)
	l_19_4:game_synced(l_19_1)
end

SessionProvider.game_loaded = function(l_20_0, l_20_1, l_20_2)
	local l_20_3 = l_20_2:to_string()
	local l_20_4 = l_20_0._session_peers[l_20_3]
	assert(l_20_4)
	l_20_4:game_loaded(l_20_1)
end

SessionProvider.join_game = function(l_21_0, l_21_1, l_21_2, l_21_3)
	local l_21_4 = l_21_3:to_string()
	local l_21_5 = l_21_0._session_peers[l_21_4]
	l_21_5:join_game(l_21_1, l_21_2)
end

SessionProvider.leave_game = function(l_22_0, l_22_1, l_22_2)
	local l_22_3 = l_22_2:to_string()
	local l_22_4 = l_22_0._session_peers[l_22_3]
	l_22_4:leave_game(l_22_1)
end


