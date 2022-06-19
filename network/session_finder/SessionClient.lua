SessionPeer = SessionPeer or class()
function SessionPeer.init(A0_0, A1_1)
	A0_0._send = A1_1
	A0_0.STATE_IDLE = 0
	A0_0.STATE_WAITING_FOR_LEVEL_LOADED = 1
	A0_0.STATE_WAITING_FOR_LEVEL_SYNCED = 2
	A0_0.STATE_DISCONNECTED = 3
	A0_0.STATE_SYNCED = 4
	A0_0._state = A0_0.STATE_IDLE
	A0_0.WAITING_FOR_LEVEL_LOADED_TIMEOUT = 120
	A0_0._timer = 0
end
function SessionPeer.save(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._send
	A1_3.send = L2_4
	L2_4 = A0_2._timer
	A1_3.timer = L2_4
	L2_4 = A0_2._state
	A1_3.state = L2_4
	L2_4 = A0_2._waiting_for_unique_id
	A1_3.waiting_for_unique_id = L2_4
end
function SessionPeer.load(A0_5, A1_6)
	local L2_7
	L2_7 = A1_6.send
	A0_5._send = L2_7
	L2_7 = A1_6.timer
	A0_5._timer = L2_7
	L2_7 = A1_6.state
	A0_5._state = L2_7
	L2_7 = A1_6.waiting_for_unique_id
	A0_5._waiting_for_unique_id = L2_7
end
function SessionPeer.update(A0_8, A1_9)
	local L2_10, L3_11
	L2_10 = A0_8._state
	L3_11 = A0_8.STATE_IDLE
	if L2_10 ~= L3_11 then
		L2_10 = A0_8._state
		L3_11 = A0_8.STATE_DISCONNECTED
	elseif L2_10 == L3_11 then
		return
	end
	L2_10 = A0_8._timer
	L2_10 = L2_10 + A1_9
	A0_8._timer = L2_10
	L2_10 = A0_8._state
	L3_11 = A0_8.STATE_WAITING_FOR_LEVEL_LOADED
	if L2_10 == L3_11 then
		L2_10 = A0_8._timer
		L3_11 = A0_8.WAITING_FOR_LEVEL_LOADED_TIMEOUT
		if L2_10 > L3_11 then
			L2_10 = A0_8.STATE_DISCONNECTED
			A0_8._state = L2_10
		end
	end
end
function SessionPeer.load_level(A0_12, A1_13, A2_14, A3_15)
	A0_12._state = A0_12.STATE_WAITING_FOR_LEVEL_LOADED
	A0_12._waiting_for_unique_id = A3_15
	A0_12._send:game_load(A3_15, A1_13, A2_14)
end
function SessionPeer.game_loaded(A0_16, A1_17)
	local L2_18
	L2_18 = A0_16._waiting_for_unique_id
	if L2_18 ~= A1_17 then
		return
	end
	L2_18 = A0_16._state
	if L2_18 ~= A0_16.STATE_WAITING_FOR_LEVEL_LOADED then
		return
	end
	L2_18 = A0_16.STATE_WAITING_FOR_LEVEL_SYNCED
	A0_16._state = L2_18
end
function SessionPeer.game_synced(A0_19, A1_20)
	local L2_21
	L2_21 = A0_19._waiting_for_unique_id
	if L2_21 ~= A1_20 then
		return
	end
	L2_21 = A0_19._state
	if L2_21 ~= A0_19.STATE_WAITING_FOR_LEVEL_SYNCED then
		return
	end
	L2_21 = A0_19.STATE_SYNCED
	A0_19._state = L2_21
end
function SessionPeer.join_game(A0_22, A1_23, A2_24)
	if managers.player_slot:is_slot_occupied(A2_24) then
		cat_print("pebj", "Slot already occupied!")
		return
	end
	A0_22._send:user_joined_game(A1_23, A2_24)
end
function SessionPeer.leave_game(A0_25, A1_26)
	A0_25._send:user_left_game(A1_26)
end
