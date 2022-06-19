require("network/replay/WriteReplay")
require("network/replay/ReadReplay")
ReplayManager = ReplayManager or class()
function ReplayManager.init(A0_0)
	local L1_1
end
function ReplayManager.record(A0_2)
	A0_2._write_replay = WriteReplay:new()
end
function ReplayManager.play(A0_3)
	A0_3._read_replay = ReadReplay:new()
end
function ReplayManager.stop(A0_4)
	if A0_4._write_replay then
		A0_4._write_replay:destroy()
		A0_4._write_replay = nil
	end
	if A0_4._read_replay then
		A0_4._read_replay:destroy()
		A0_4._read_replay = nil
	end
end
function ReplayManager.update(A0_5, A1_6)
	if A0_5._write_replay then
		A0_5._write_replay:update(A1_6)
	end
	if A0_5._read_replay then
		A0_5._read_replay:update(A1_6)
	end
end
function ReplayManager.unit_input(A0_7, A1_8, A2_9)
	if not A0_7._write_replay then
		return
	end
	A0_7._write_replay:write_input(A1_8, A2_9)
end
function ReplayManager.user_joined_game(A0_10, A1_11, A2_12)
	if not A0_10._write_replay then
		return
	end
	A0_10._write_replay:write_user_joined_game(A1_11, A2_12)
end
function ReplayManager.user_left_game(A0_13, A1_14)
	if not A0_13._write_replay then
		return
	end
	A0_13._write_replay:write_user_left_game(A1_14)
end
function ReplayManager.arbitrate_interact(A0_15, A1_16, A2_17)
	if not A0_15._write_replay then
		return
	end
	A0_15._write_replay:write_arbitrate_interact(A1_16, A2_17)
end
function ReplayManager.interact(A0_18, A1_19, A2_20)
	if not A0_18._write_replay then
		return
	end
	A0_18._write_replay:write_interact(A1_19, A2_20)
end
function ReplayManager.arbitrate_interact(A0_21, A1_22, A2_23)
	if not A0_21._write_replay then
		return
	end
	A0_21._write_replay:write_arbitrate_interact(A1_22, A2_23)
end
function ReplayManager.arbitrate_pick_up(A0_24, A1_25, A2_26)
	if not A0_24._write_replay then
		return
	end
	A0_24._write_replay:write_arbitrate_pick_up(A1_25, A2_26)
end
function ReplayManager.pick_up(A0_27, A1_28, A2_29)
	if not A0_27._write_replay then
		return
	end
	A0_27._write_replay:write_pick_up(A1_28, A2_29)
end
