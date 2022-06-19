require("network/replay/WriteReplay")
require("network/replay/ReadReplay")
if not ReplayManager then
	ReplayManager = class()
end
ReplayManager.init = function(l_1_0)
end

ReplayManager.record = function(l_2_0)
	l_2_0._write_replay = WriteReplay:new()
end

ReplayManager.play = function(l_3_0)
	l_3_0._read_replay = ReadReplay:new()
end

ReplayManager.stop = function(l_4_0)
	if l_4_0._write_replay then
		l_4_0._write_replay:destroy()
		l_4_0._write_replay = nil
	end
	if l_4_0._read_replay then
		l_4_0._read_replay:destroy()
		l_4_0._read_replay = nil
	end
end

ReplayManager.update = function(l_5_0, l_5_1)
	if l_5_0._write_replay then
		l_5_0._write_replay:update(l_5_1)
	end
	if l_5_0._read_replay then
		l_5_0._read_replay:update(l_5_1)
	end
end

ReplayManager.unit_input = function(l_6_0, l_6_1, l_6_2)
	if not l_6_0._write_replay then
		return 
	end
	l_6_0._write_replay:write_input(l_6_1, l_6_2)
end

ReplayManager.user_joined_game = function(l_7_0, l_7_1, l_7_2)
	if not l_7_0._write_replay then
		return 
	end
	l_7_0._write_replay:write_user_joined_game(l_7_1, l_7_2)
end

ReplayManager.user_left_game = function(l_8_0, l_8_1)
	if not l_8_0._write_replay then
		return 
	end
	l_8_0._write_replay:write_user_left_game(l_8_1)
end

ReplayManager.arbitrate_interact = function(l_9_0, l_9_1, l_9_2)
	if not l_9_0._write_replay then
		return 
	end
	l_9_0._write_replay:write_arbitrate_interact(l_9_1, l_9_2)
end

ReplayManager.interact = function(l_10_0, l_10_1, l_10_2)
	if not l_10_0._write_replay then
		return 
	end
	l_10_0._write_replay:write_interact(l_10_1, l_10_2)
end

ReplayManager.arbitrate_interact = function(l_11_0, l_11_1, l_11_2)
	if not l_11_0._write_replay then
		return 
	end
	l_11_0._write_replay:write_arbitrate_interact(l_11_1, l_11_2)
end

ReplayManager.arbitrate_pick_up = function(l_12_0, l_12_1, l_12_2)
	if not l_12_0._write_replay then
		return 
	end
	l_12_0._write_replay:write_arbitrate_pick_up(l_12_1, l_12_2)
end

ReplayManager.pick_up = function(l_13_0, l_13_1, l_13_2)
	if not l_13_0._write_replay then
		return 
	end
	l_13_0._write_replay:write_pick_up(l_13_1, l_13_2)
end


