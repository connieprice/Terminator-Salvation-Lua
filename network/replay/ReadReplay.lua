require("shared/TableSerializer")
require("network/replay/ReplayCommands")
ReadReplay = ReadReplay or class()
function ReadReplay.init(A0_0)
	A0_0.TYPE_KEY_FRAME = "k"
	A0_0.TYPE_CONTROL_INPUT = "c"
	A0_0._file = File:open("data/replays/replay.txt", "r")
	A0_0._frame = 0
	A0_0.STATE_DONE = 2
	A0_0.STATE_PLAYING = 3
	A0_0._state = A0_0.STATE_PLAYING
end
function ReadReplay.read_chunk_ex(A0_1)
	local L1_2
	L1_2 = A0_1._file
	L1_2 = L1_2.gets
	L1_2 = L1_2(L1_2)
	L1_2 = String.strip(L1_2)
	if not L1_2 or L1_2 == "" then
		return nil
	end
	assert(TableSerializer.load(L1_2).chunk_type)
	return (TableSerializer.load(L1_2))
end
function ReadReplay.read_chunk(A0_3)
	local L1_4
	L1_4 = A0_3._state
	if L1_4 == A0_3.STATE_DONE then
		return
	end
	L1_4 = A0_3.read_chunk_ex
	L1_4 = L1_4(A0_3)
	if not L1_4 then
		A0_3._state = A0_3.STATE_DONE
		return
	end
	if L1_4.chunk_type == ReplayCommands.KEY_FRAME then
		A0_3:read_keyframe(L1_4.data)
		L1_4 = A0_3:read_chunk_ex()
	elseif L1_4.chunk_type == ReplayCommands.CONTROL_INPUT then
		A0_3:read_input(L1_4.data)
	elseif L1_4.chunk_type == ReplayCommands.USER_JOINED_GAME then
		A0_3:read_user_joined_game(L1_4.data)
	elseif L1_4.chunk_type == ReplayCommands.USER_LEFT_GAME then
		A0_3:read_user_left_game(L1_4.data)
	elseif L1_4.chunk_type == ReplayCommands.ARBITRATE_INTERACT then
		A0_3:read_arbitrate_interact(L1_4.data)
	elseif L1_4.chunk_type == ReplayCommands.INTERACT then
		A0_3:read_interact(L1_4.data)
	elseif L1_4.chunk_type == ReplayCommands.ARBITRATE_PICKUP then
		A0_3:read_arbitrate_pickup(L1_4.data)
	elseif L1_4.chunk_type == ReplayCommands.PICKUP then
		A0_3:read_pickup(L1_4.data)
	end
end
function ReadReplay.update(A0_5)
	if A0_5._state == A0_5.STATE_DONE then
		return
	end
	A0_5:read_chunk()
end
function ReadReplay.destroy(A0_6)
	A0_6._state = A0_6.STATE_DONE
	A0_6._file = nil
end
function ReadReplay.read_keyframe(A0_7, A1_8)
	managers.network:peer():load_units(A1_8)
end
function ReadReplay.read_input(A0_9, A1_10)
	local L2_11
	managers.network:peer():player_input(A1_10.id, A1_10.input, L2_11)
end
function ReadReplay.read_user_joined_game(A0_12, A1_13)
	managers.network:peer():user_joined_game(A1_13.user_id, A1_13.slot_id)
end
function ReadReplay.read_user_left_game(A0_14, A1_15)
	managers.network:peer():user_left_game(A1_15.user_id)
end
function ReadReplay.read_interact(A0_16, A1_17)
	managers.network:peer():interact(A1_17.interactable_unit_id, A1_17.player_unit_id)
end
function ReadReplay.read_arbitrate_interact(A0_18, A1_19)
	managers.network:peer():arbitrate_interact(A1_19.interactable_unit_id, A1_19.player_unit_id)
end
function ReadReplay.read_arbitrate_pick_up(A0_20, A1_21)
	managers.network:peer():arbitrate_pick_up(A1_21.player_unit_id, A1_21.interactable_unit_id)
end
function ReadReplay.read_pick_up(A0_22, A1_23, A2_24)
	managers.network:peer():pick_up(input_data.player_unit_id, input_data.interactable_unit_id)
end
