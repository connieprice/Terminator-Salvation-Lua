require("network/session_finder/LanSessionFinder")
require("world/WorldLoader")
Peer = Peer or class()
function Peer.init(A0_0)
	Network:set_receiver("Peer", A0_0)
	A0_0:clear()
end
function Peer.destroy(A0_1)
	local L1_2
end
function Peer.save(A0_3, A1_4)
	local L2_5
	L2_5 = A0_3._level_unique_id
	A1_4.level_unique_id = L2_5
	L2_5 = A0_3._host
	A1_4.host = L2_5
end
function Peer.load(A0_6, A1_7)
	local L2_8
	L2_8 = A1_7.level_unique_id
	A0_6._level_unique_id = L2_8
	L2_8 = A1_7.host
	A0_6._host = L2_8
	A0_6._session_finder = nil
	A0_6._session_infos = nil
end
function Peer.clear(A0_9)
	A0_9._level_unique_id = 0
	A0_9._debug_auto_spawn_position = nil
	A0_9._debug_auto_spawn_rotation = nil
	if A0_9._debug_unit then
		A0_9._debug_unit:set_slot(0)
	end
	A0_9._debug_unit = nil
end
function Peer.update(A0_10, A1_11)
end
function Peer.find_sessions(A0_12)
	assert(A0_12._state == A0_12.STATE_IDLE)
	A0_12._session_finder = LanSessionFinder:new()
	A0_12._state = A0_12.STATE_LAN_SEARCHING_FOR_SESSIONS
end
function Peer.update_find_sessions(A0_13, A1_14)
	assert(A0_13._session_finder)
	A0_13._session_finder:update(A1_14)
	if A0_13._session_finder:is_done() then
		A0_13._session_infos = A0_13._session_finder:session_infos()
		A0_13._state = A0_13.STATE_LAN_SESSIONS_FOUND
	end
end
function Peer.session_infos(A0_15)
	local L1_16
	L1_16 = A0_15._session_infos
	return L1_16
end
function Peer.join_session(A0_17, A1_18)
	if A1_18 == Network:self() then
		A0_17._host = Network:self()
	else
		A0_17._host = Network:server()
	end
	A0_17._host:session_request_join(Network:hostname())
	assert(A0_17._host)
end
function Peer.is_connected(A0_19)
	local L1_20
	L1_20 = true
	return L1_20
end
function Peer.host_rpc(A0_21)
	local L1_22
	L1_22 = A0_21._host
	return L1_22
end
function Peer.peers_rpc(A0_23)
	return Network:clients()
end
function Peer.wants_to_load_world(A0_24)
	return A0_24._state == A0_24.STATE_WAITING_FOR_LOAD
end
function Peer.ack_load_world(A0_25)
	A0_25._state = A0_25.START_LOAD
end
function Peer.game_loaded(A0_26)
	A0_26._state = A0_26.STATE_WAITING_FOR_SYNC
	A0_26._sync_timer = 0
	A0_26._host:game_loaded(A0_26._level_unique_id)
end
function Peer.game_synced(A0_27)
	local L1_28, L2_29, L3_30
	L1_28 = A0_27._host
	L2_29 = L1_28
	L1_28 = L1_28.game_synced
	L3_30 = A0_27._level_unique_id
	L1_28(L2_29, L3_30)
	L1_28 = Global
	L1_28 = L1_28.auto_spawn
	if L1_28 then
		L1_28 = "john_connor"
		L2_29 = "normal"
		L3_30 = World
		L3_30 = L3_30.spawn_unit
		L3_30 = L3_30(L3_30, L1_28, Global.auto_spawn.position)
		A0_27._debug_unit = L3_30
		L3_30 = A0_27._debug_unit
		L3_30 = L3_30.ai_nerve_system
		L3_30 = L3_30(L3_30)
		L3_30 = L3_30.setup
		L3_30(L3_30, L2_29)
		L3_30 = 1
		managers.player_slot:set_unit(L3_30, A0_27._debug_unit, L1_28, Global.auto_spawn.position, Global.auto_spawn.rotation, true, true)
		managers.unit_scripting:register_unit(L1_28, A0_27._debug_unit)
		managers.unit_scripting:register_alias(L1_28, "character_slot1")
		managers.drama_scene:set_unit_name_to_script_name(L1_28, L1_28)
		Global.auto_spawn = nil
	end
end
function Peer.unit_save(A0_31, A1_32, A2_33, A3_34)
	managers.unit_control_id:unit_from_id(A1_32):control():load_join(A2_33)
end
function Peer.save_units(A0_35)
	local L1_36
	L1_36 = {}
	return L1_36
end
function Peer.load_units(A0_37, A1_38)
end
function Peer.game_load(A0_39, A1_40, A2_41, A3_42, A4_43)
	A0_39._level_unique_id = A1_40
	A0_39._level_info = managers.world_info:info_from_name(A2_41)
	if not A0_39._level_info then
		print("WARNING! level " .. A2_41 .. " has no id! Please edit levels.xml")
	end
	A0_39._state = A0_39.STATE_WAITING_FOR_LOAD
	managers.game_transition:request_load(A2_41, A3_42)
end
function Peer.level_id(A0_44)
	local L1_45
	L1_45 = A0_44._level_info
	if not L1_45 then
		L1_45 = nil
		return L1_45
	end
	L1_45 = A0_44._level_info
	L1_45 = L1_45.id
	return L1_45
end
function Peer.debug_level_name(A0_46)
	assert(A0_46._level_info)
	return A0_46._level_info.name
end
function Peer.player_input(A0_47, A1_48, A2_49, A3_50)
	managers.replay:unit_input(A1_48, A2_49)
	if not managers.unit_control_id:unit_from_id(A1_48) then
		return
	end
	managers.unit_control_id:unit_from_id(A1_48):control():player_input(A2_49)
end
function Peer.join_game(A0_51, A1_52, A2_53)
	A0_51._host:join_game(A1_52:user_index(), A2_53)
end
function Peer.leave_game(A0_54, A1_55)
	local L3_56
	L3_56 = A0_54._host
	L3_56 = L3_56.leave_game
	L3_56(L3_56, A1_55:user_index())
end
function Peer.user_joined_game(A0_57, A1_58, A2_59, A3_60)
	local L4_61, L5_62
	L4_61 = managers
	L4_61 = L4_61.local_user
	L5_62 = L4_61
	L4_61 = L4_61.user_from_user_index
	L4_61 = L4_61(L5_62, A1_58)
	L5_62 = nil
	if L4_61 then
		managers.local_session_user:add_user(L4_61)
		L5_62 = L4_61
	else
	end
	managers.session_user:add_user(A1_58, L5_62, A2_59)
end
function Peer.user_left_game(A0_63, A1_64, A2_65)
	local L3_66
	L3_66 = managers
	L3_66 = L3_66.session_user
	L3_66 = L3_66.user
	L3_66 = L3_66(L3_66, A1_64)
	managers.session_user:remove_user(A1_64)
	if managers.local_session_user:has_user(L3_66) then
		managers.local_session_user:remove_user(L3_66)
	end
end
function Peer.arbitrate_interact(A0_67, A1_68, A2_69, A3_70)
	local L4_71, L5_72
	L4_71 = managers
	L4_71 = L4_71.replay
	L5_72 = L4_71
	L4_71 = L4_71.arbitrate_interact
	L4_71(L5_72, A1_68, A2_69)
	L4_71 = managers
	L4_71 = L4_71.unit_control_id
	L5_72 = L4_71
	L4_71 = L4_71.unit_from_id
	L4_71 = L4_71(L5_72, A1_68)
	L5_72 = managers
	L5_72 = L5_72.unit_control_id
	L5_72 = L5_72.unit_from_id
	L5_72 = L5_72(L5_72, A2_69)
	L4_71:interact():handle_rpc_arbitrate_interact(L5_72)
end
function Peer.interact(A0_73, A1_74, A2_75, A3_76)
	local L4_77, L5_78
	L4_77 = managers
	L4_77 = L4_77.replay
	L5_78 = L4_77
	L4_77 = L4_77.interact
	L4_77(L5_78, A1_74, A2_75)
	L4_77 = managers
	L4_77 = L4_77.unit_control_id
	L5_78 = L4_77
	L4_77 = L4_77.unit_from_id
	L4_77 = L4_77(L5_78, A1_74)
	L5_78 = managers
	L5_78 = L5_78.unit_control_id
	L5_78 = L5_78.unit_from_id
	L5_78 = L5_78(L5_78, A2_75)
	L4_77:interact():interact(L5_78)
end
function Peer.arbitrate_pick_up(A0_79, A1_80, A2_81, A3_82)
	local L4_83, L5_84
	L4_83 = managers
	L4_83 = L4_83.replay
	L5_84 = L4_83
	L4_83 = L4_83.arbitrate_pick_up
	L4_83(L5_84, A2_81, A1_80)
	L4_83 = managers
	L4_83 = L4_83.unit_control_id
	L5_84 = L4_83
	L4_83 = L4_83.unit_from_id
	L4_83 = L4_83(L5_84, A1_80)
	L5_84 = managers
	L5_84 = L5_84.unit_control_id
	L5_84 = L5_84.unit_from_id
	L5_84 = L5_84(L5_84, A2_81)
	L4_83:interact():arbitrate_interact(L5_84)
end
function Peer.pick_up(A0_85, A1_86, A2_87, A3_88)
	local L4_89, L5_90
	L4_89 = managers
	L4_89 = L4_89.replay
	L5_90 = L4_89
	L4_89 = L4_89.pick_up
	L4_89(L5_90, A1_86, A2_87)
	L4_89 = managers
	L4_89 = L4_89.unit_control_id
	L5_90 = L4_89
	L4_89 = L4_89.unit_from_id
	L4_89 = L4_89(L5_90, A1_86)
	L5_90 = managers
	L5_90 = L5_90.unit_control_id
	L5_90 = L5_90.unit_from_id
	L5_90 = L5_90(L5_90, A2_87)
	L4_89:pick_up_target():pick_up(L5_90)
end
