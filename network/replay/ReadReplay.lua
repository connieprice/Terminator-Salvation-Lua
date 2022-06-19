require("shared/TableSerializer")
require("network/replay/ReplayCommands")
if not ReadReplay then
	ReadReplay = class()
end
ReadReplay.init = function(l_1_0)
	l_1_0.TYPE_KEY_FRAME = "k"
	l_1_0.TYPE_CONTROL_INPUT = "c"
	l_1_0._file = File:open("data/replays/replay.txt", "r")
	l_1_0._frame = 0
	l_1_0.STATE_DONE = 2
	l_1_0.STATE_PLAYING = 3
	l_1_0._state = l_1_0.STATE_PLAYING
end

ReadReplay.read_chunk_ex = function(l_2_0)
	local l_2_1 = l_2_0._file:gets()
	l_2_1 = String.strip(l_2_1)
	if not l_2_1 or l_2_1 == "" then
		return nil
	end
	local l_2_2 = TableSerializer.load(l_2_1)
	assert(l_2_2.chunk_type)
	return l_2_2
end

ReadReplay.read_chunk = function(l_3_0)
	if l_3_0._state == l_3_0.STATE_DONE then
		return 
	end
	local l_3_1 = l_3_0:read_chunk_ex()
	if not l_3_1 then
		l_3_0._state = l_3_0.STATE_DONE
		return 
	end
	if l_3_1.chunk_type == ReplayCommands.KEY_FRAME then
		l_3_0:read_keyframe(l_3_1.data)
		l_3_1 = l_3_0:read_chunk_ex()
	else
		if l_3_1.chunk_type == ReplayCommands.CONTROL_INPUT then
			l_3_0:read_input(l_3_1.data)
		end
	else
		if l_3_1.chunk_type == ReplayCommands.USER_JOINED_GAME then
			l_3_0:read_user_joined_game(l_3_1.data)
		end
	else
		if l_3_1.chunk_type == ReplayCommands.USER_LEFT_GAME then
			l_3_0:read_user_left_game(l_3_1.data)
		end
	else
		if l_3_1.chunk_type == ReplayCommands.ARBITRATE_INTERACT then
			l_3_0:read_arbitrate_interact(l_3_1.data)
		end
	else
		if l_3_1.chunk_type == ReplayCommands.INTERACT then
			l_3_0:read_interact(l_3_1.data)
		end
	else
		if l_3_1.chunk_type == ReplayCommands.ARBITRATE_PICKUP then
			l_3_0:read_arbitrate_pickup(l_3_1.data)
		end
	else
		if l_3_1.chunk_type == ReplayCommands.PICKUP then
			l_3_0:read_pickup(l_3_1.data)
		end
	end
end

ReadReplay.update = function(l_4_0)
	if l_4_0._state == l_4_0.STATE_DONE then
		return 
	end
	l_4_0:read_chunk()
end

ReadReplay.destroy = function(l_5_0)
	l_5_0._state = l_5_0.STATE_DONE
	l_5_0._file = nil
end

ReadReplay.read_keyframe = function(l_6_0, l_6_1)
	managers.network:peer():load_units(l_6_1)
end

ReadReplay.read_input = function(l_7_0, l_7_1)
	local l_7_2 = nil
	managers.network:peer():player_input(l_7_1.id, l_7_1.input, l_7_2)
end

ReadReplay.read_user_joined_game = function(l_8_0, l_8_1)
	managers.network:peer():user_joined_game(l_8_1.user_id, l_8_1.slot_id)
end

ReadReplay.read_user_left_game = function(l_9_0, l_9_1)
	managers.network:peer():user_left_game(l_9_1.user_id)
end

ReadReplay.read_interact = function(l_10_0, l_10_1)
	managers.network:peer():interact(l_10_1.interactable_unit_id, l_10_1.player_unit_id)
end

ReadReplay.read_arbitrate_interact = function(l_11_0, l_11_1)
	managers.network:peer():arbitrate_interact(l_11_1.interactable_unit_id, l_11_1.player_unit_id)
end

ReadReplay.read_arbitrate_pick_up = function(l_12_0, l_12_1)
	managers.network:peer():arbitrate_pick_up(l_12_1.player_unit_id, l_12_1.interactable_unit_id)
end

ReadReplay.read_pick_up = function(l_13_0, l_13_1, l_13_2)
	managers.network:peer():pick_up(input_data.player_unit_id, input_data.interactable_unit_id)
end


