require("network/session_finder/LanSessionFinder")
require("world/WorldLoader")
if not Peer then
	Peer = class()
end
Peer.init = function(l_1_0)
	Network:set_receiver("Peer", l_1_0)
	l_1_0:clear()
end

Peer.destroy = function(l_2_0)
end

Peer.save = function(l_3_0, l_3_1)
	l_3_1.level_unique_id = l_3_0._level_unique_id
	l_3_1.host = l_3_0._host
end

Peer.load = function(l_4_0, l_4_1)
	l_4_0._level_unique_id = l_4_1.level_unique_id
	l_4_0._host = l_4_1.host
	l_4_0._session_finder = nil
	l_4_0._session_infos = nil
end

Peer.clear = function(l_5_0)
	l_5_0._level_unique_id = 0
	l_5_0._debug_auto_spawn_position = nil
	l_5_0._debug_auto_spawn_rotation = nil
	if l_5_0._debug_unit then
		l_5_0._debug_unit:set_slot(0)
	end
	l_5_0._debug_unit = nil
end

Peer.update = function(l_6_0, l_6_1)
end

Peer.find_sessions = function(l_7_0)
	local l_7_1 = assert
	l_7_1(l_7_0._state == l_7_0.STATE_IDLE)
	l_7_1 = LanSessionFinder
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_0._session_finder = l_7_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_0._state = l_7_1
end

Peer.update_find_sessions = function(l_8_0, l_8_1)
	assert(l_8_0._session_finder)
	l_8_0._session_finder:update(l_8_1)
	if l_8_0._session_finder:is_done() then
		l_8_0._session_infos = l_8_0._session_finder:session_infos()
		l_8_0._state = l_8_0.STATE_LAN_SESSIONS_FOUND
	end
end

Peer.session_infos = function(l_9_0)
	return l_9_0._session_infos
end

Peer.join_session = function(l_10_0, l_10_1)
	if l_10_1 == Network:self() then
		l_10_0._host = Network:self()
	else
		l_10_0._host = Network:server()
	end
	l_10_0._host:session_request_join(Network:hostname())
	assert(l_10_0._host)
end

Peer.is_connected = function(l_11_0)
	return true
end

Peer.host_rpc = function(l_12_0)
	return l_12_0._host
end

Peer.peers_rpc = function(l_13_0)
	local l_13_1, l_13_2 = Network:clients, Network
	return l_13_1(l_13_2)
end

Peer.wants_to_load_world = function(l_14_0)
	return l_14_0._state == l_14_0.STATE_WAITING_FOR_LOAD
end

Peer.ack_load_world = function(l_15_0)
	l_15_0._state = l_15_0.START_LOAD
end

Peer.game_loaded = function(l_16_0)
	l_16_0._state = l_16_0.STATE_WAITING_FOR_SYNC
	l_16_0._sync_timer = 0
	l_16_0._host:game_loaded(l_16_0._level_unique_id)
end

Peer.game_synced = function(l_17_0)
	l_17_0._host:game_synced(l_17_0._level_unique_id)
	if Global.auto_spawn then
		local l_17_1 = "john_connor"
		local l_17_2 = "normal"
		l_17_0._debug_unit = World:spawn_unit(l_17_1, Global.auto_spawn.position)
		l_17_0._debug_unit:ai_nerve_system():setup(l_17_2)
		local l_17_3 = 1
		managers.player_slot:set_unit(l_17_3, l_17_0._debug_unit, l_17_1, Global.auto_spawn.position, Global.auto_spawn.rotation, true, true)
		managers.unit_scripting:register_unit(l_17_1, l_17_0._debug_unit)
		managers.unit_scripting:register_alias(l_17_1, "character_slot1")
		managers.drama_scene:set_unit_name_to_script_name(l_17_1, l_17_1)
		Global.auto_spawn = nil
	end
end

Peer.unit_save = function(l_18_0, l_18_1, l_18_2, l_18_3)
	local l_18_4 = managers.unit_control_id:unit_from_id(l_18_1)
	l_18_4:control():load_join(l_18_2)
end

Peer.save_units = function(l_19_0)
	return {}
end

Peer.load_units = function(l_20_0, l_20_1)
end

Peer.game_load = function(l_21_0, l_21_1, l_21_2, l_21_3, l_21_4)
	l_21_0._level_unique_id = l_21_1
	l_21_0._level_info = managers.world_info:info_from_name(l_21_2)
	if not l_21_0._level_info then
		print("WARNING! level " .. l_21_2 .. " has no id! Please edit levels.xml")
	end
	l_21_0._state = l_21_0.STATE_WAITING_FOR_LOAD
	managers.game_transition:request_load(l_21_2, l_21_3)
end

Peer.level_id = function(l_22_0)
	if not l_22_0._level_info then
		return nil
	end
	return l_22_0._level_info.id
end

Peer.debug_level_name = function(l_23_0)
	assert(l_23_0._level_info)
	return l_23_0._level_info.name
end

Peer.player_input = function(l_24_0, l_24_1, l_24_2, l_24_3)
	managers.replay:unit_input(l_24_1, l_24_2)
	local l_24_4 = managers.unit_control_id:unit_from_id(l_24_1)
	if not l_24_4 then
		return 
	end
	l_24_4:control():player_input(l_24_2)
end

Peer.join_game = function(l_25_0, l_25_1, l_25_2)
	l_25_0._host:join_game(l_25_1:user_index(), l_25_2)
end

Peer.leave_game = function(l_26_0, l_26_1)
	l_26_0._host:leave_game(l_26_1:user_index())
end

Peer.user_joined_game = function(l_27_0, l_27_1, l_27_2, l_27_3)
	local l_27_4 = (managers.local_user:user_from_user_index(l_27_1))
	local l_27_5 = nil
	if l_27_4 then
		managers.local_session_user:add_user(l_27_4)
		l_27_5 = l_27_4
	end
	managers.session_user:add_user(l_27_1, l_27_5, l_27_2)
end

Peer.user_left_game = function(l_28_0, l_28_1, l_28_2)
	local l_28_3 = managers.session_user:user(l_28_1)
	managers.session_user:remove_user(l_28_1)
	if managers.local_session_user:has_user(l_28_3) then
		managers.local_session_user:remove_user(l_28_3)
	end
end

Peer.arbitrate_interact = function(l_29_0, l_29_1, l_29_2, l_29_3)
	managers.replay:arbitrate_interact(l_29_1, l_29_2)
	local l_29_4 = managers.unit_control_id:unit_from_id(l_29_1)
	local l_29_5 = managers.unit_control_id:unit_from_id(l_29_2)
	l_29_4:interact():handle_rpc_arbitrate_interact(l_29_5)
end

Peer.interact = function(l_30_0, l_30_1, l_30_2, l_30_3)
	managers.replay:interact(l_30_1, l_30_2)
	local l_30_4 = managers.unit_control_id:unit_from_id(l_30_1)
	local l_30_5 = managers.unit_control_id:unit_from_id(l_30_2)
	l_30_4:interact():interact(l_30_5)
end

Peer.arbitrate_pick_up = function(l_31_0, l_31_1, l_31_2, l_31_3)
	managers.replay:arbitrate_pick_up(l_31_2, l_31_1)
	local l_31_4 = managers.unit_control_id:unit_from_id(l_31_1)
	local l_31_5 = managers.unit_control_id:unit_from_id(l_31_2)
	l_31_4:interact():arbitrate_interact(l_31_5)
end

Peer.pick_up = function(l_32_0, l_32_1, l_32_2, l_32_3)
	managers.replay:pick_up(l_32_1, l_32_2)
	local l_32_4 = managers.unit_control_id:unit_from_id(l_32_1)
	local l_32_5 = managers.unit_control_id:unit_from_id(l_32_2)
	l_32_4:pick_up_target():pick_up(l_32_5)
end


