require("shared/TableSerializer")
require("network/replay/ReplayCommands")
if not WriteReplay then
	WriteReplay = class()
end
WriteReplay.init = function(l_1_0)
	l_1_0._file = File:open("data/replays/replay.txt", "w")
	l_1_0._frame = 0
	l_1_0:write_keyframe()
end

WriteReplay.write_chunk = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = {}
	l_2_3.frame = l_2_0._frame
	l_2_3.chunk_type = l_2_1
	l_2_3.data = l_2_2
	local l_2_4 = TableSerializer.save(l_2_3)
	l_2_0._file:puts(l_2_4)
end

WriteReplay.update = function(l_3_0)
end

WriteReplay.destroy = function(l_4_0)
	l_4_0._file = nil
end

WriteReplay.write_keyframe = function(l_5_0)
	if not l_5_0._file then
		return 
	end
	local l_5_1 = Peer:save_units()
	l_5_0:write_chunk(ReplayCommands.KEY_FRAME, l_5_1)
end

WriteReplay.write_input = function(l_6_0, l_6_1, l_6_2)
	if not l_6_0._file then
		return 
	end
	local l_6_3 = {}
	l_6_3.id = l_6_1
	l_6_3.input = l_6_2
	l_6_0:write_chunk(ReplayCommands.CONTROL_INPUT, l_6_3)
	l_6_0._frame = l_6_0._frame + 1
end

WriteReplay.write_user_joined_game = function(l_7_0, l_7_1, l_7_2)
	if not l_7_0._file then
		return 
	end
	local l_7_3 = {}
	l_7_3.user_id = l_7_1
	l_7_3.slot_id = l_7_2
	l_7_0:write_chunk(ReplayCommands.USER_JOINED, l_7_3)
end

WriteReplay.write_user_left_game = function(l_8_0, l_8_1, l_8_2)
	if not l_8_0._file then
		return 
	end
	local l_8_3 = {}
	l_8_3.user_id = l_8_1
	l_8_0:write_chunk(ReplayCommands.USER_LEFT_GAME, l_8_3)
end

WriteReplay.write_interact = function(l_9_0, l_9_1, l_9_2)
	if not l_9_0._file then
		return 
	end
	local l_9_3 = {}
	l_9_3.interactable_unit_id = l_9_1
	l_9_3.player_unit_id = l_9_2
	l_9_0:write_chunk(ReplayCommands.INTERACT, l_9_3)
end

WriteReplay.write_arbitrate_interact = function(l_10_0, l_10_1, l_10_2)
	if not l_10_0._file then
		return 
	end
	local l_10_3 = {}
	l_10_3.interactable_unit_id = l_10_1
	l_10_3.player_unit_id = l_10_2
	l_10_0:write_chunk(ReplayCommands.ARBITRATE_INTERACT, l_10_3)
end

WriteReplay.write_arbitrate_pick_up = function(l_11_0, l_11_1, l_11_2)
	if not l_11_0._file then
		return 
	end
	local l_11_3 = {}
	l_11_3.player_unit_id = l_11_1
	l_11_3.interactable_unit_id = l_11_2
	l_11_0:write_chunk(ReplayCommands.ARBITRATE_PICK_UP, l_11_3)
end

WriteReplay.write_pick_up = function(l_12_0, l_12_1, l_12_2)
	if not l_12_0._file then
		return 
	end
	local l_12_3 = {}
	l_12_3.player_unit_id = l_12_1
	l_12_3.interactable_unit_id = l_12_2
	l_12_0:write_chunk(ReplayCommands.PICK_UP, l_12_3)
end


