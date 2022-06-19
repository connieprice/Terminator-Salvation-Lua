if not SessionPeer then
	SessionPeer = class()
end
SessionPeer.init = function(l_1_0, l_1_1)
	l_1_0._send = l_1_1
	l_1_0.STATE_IDLE = 0
	l_1_0.STATE_WAITING_FOR_LEVEL_LOADED = 1
	l_1_0.STATE_WAITING_FOR_LEVEL_SYNCED = 2
	l_1_0.STATE_DISCONNECTED = 3
	l_1_0.STATE_SYNCED = 4
	l_1_0._state = l_1_0.STATE_IDLE
	l_1_0.WAITING_FOR_LEVEL_LOADED_TIMEOUT = 120
	l_1_0._timer = 0
end

SessionPeer.save = function(l_2_0, l_2_1)
	l_2_1.send = l_2_0._send
	l_2_1.timer = l_2_0._timer
	l_2_1.state = l_2_0._state
	l_2_1.waiting_for_unique_id = l_2_0._waiting_for_unique_id
end

SessionPeer.load = function(l_3_0, l_3_1)
	l_3_0._send = l_3_1.send
	l_3_0._timer = l_3_1.timer
	l_3_0._state = l_3_1.state
	l_3_0._waiting_for_unique_id = l_3_1.waiting_for_unique_id
end

SessionPeer.update = function(l_4_0, l_4_1)
	if l_4_0._state == l_4_0.STATE_IDLE or l_4_0._state == l_4_0.STATE_DISCONNECTED then
		return 
	end
	l_4_0._timer = l_4_0._timer + l_4_1
	if l_4_0._state == l_4_0.STATE_WAITING_FOR_LEVEL_LOADED and l_4_0.WAITING_FOR_LEVEL_LOADED_TIMEOUT < l_4_0._timer then
		l_4_0._state = l_4_0.STATE_DISCONNECTED
	end
end

SessionPeer.load_level = function(l_5_0, l_5_1, l_5_2, l_5_3)
	l_5_0._state = l_5_0.STATE_WAITING_FOR_LEVEL_LOADED
	l_5_0._waiting_for_unique_id = l_5_3
	l_5_0._send:game_load(l_5_3, l_5_1, l_5_2)
end

SessionPeer.game_loaded = function(l_6_0, l_6_1)
	if l_6_0._waiting_for_unique_id ~= l_6_1 then
		return 
	end
	if l_6_0._state ~= l_6_0.STATE_WAITING_FOR_LEVEL_LOADED then
		return 
	end
	l_6_0._state = l_6_0.STATE_WAITING_FOR_LEVEL_SYNCED
end

SessionPeer.game_synced = function(l_7_0, l_7_1)
	if l_7_0._waiting_for_unique_id ~= l_7_1 then
		return 
	end
	if l_7_0._state ~= l_7_0.STATE_WAITING_FOR_LEVEL_SYNCED then
		return 
	end
	l_7_0._state = l_7_0.STATE_SYNCED
end

SessionPeer.join_game = function(l_8_0, l_8_1, l_8_2)
	if managers.player_slot:is_slot_occupied(l_8_2) then
		cat_print("pebj", "Slot already occupied!")
		return 
	end
	l_8_0._send:user_joined_game(l_8_1, l_8_2)
end

SessionPeer.leave_game = function(l_9_0, l_9_1)
	l_9_0._send:user_left_game(l_9_1)
end


