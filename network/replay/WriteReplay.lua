require("shared/TableSerializer")
require("network/replay/ReplayCommands")
WriteReplay = WriteReplay or class()
function WriteReplay.init(A0_0)
	A0_0._file = File:open("data/replays/replay.txt", "w")
	A0_0._frame = 0
	A0_0:write_keyframe()
end
function WriteReplay.write_chunk(A0_1, A1_2, A2_3)
	local L3_4, L4_5
	L3_4 = {}
	L4_5 = A0_1._frame
	L3_4.frame = L4_5
	L3_4.chunk_type = A1_2
	L3_4.data = A2_3
	L4_5 = TableSerializer
	L4_5 = L4_5.save
	L4_5 = L4_5(L3_4)
	A0_1._file:puts(L4_5)
end
function WriteReplay.update(A0_6)
	local L1_7
end
function WriteReplay.destroy(A0_8)
	local L1_9
	A0_8._file = nil
end
function WriteReplay.write_keyframe(A0_10)
	local L1_11
	L1_11 = A0_10._file
	if not L1_11 then
		return
	end
	L1_11 = Peer
	L1_11 = L1_11.save_units
	L1_11 = L1_11(L1_11)
	A0_10:write_chunk(ReplayCommands.KEY_FRAME, L1_11)
end
function WriteReplay.write_input(A0_12, A1_13, A2_14)
	local L3_15
	L3_15 = A0_12._file
	if not L3_15 then
		return
	end
	L3_15 = {}
	L3_15.id = A1_13
	L3_15.input = A2_14
	A0_12:write_chunk(ReplayCommands.CONTROL_INPUT, L3_15)
	A0_12._frame = A0_12._frame + 1
end
function WriteReplay.write_user_joined_game(A0_16, A1_17, A2_18)
	local L3_19
	L3_19 = A0_16._file
	if not L3_19 then
		return
	end
	L3_19 = {}
	L3_19.user_id = A1_17
	L3_19.slot_id = A2_18
	A0_16:write_chunk(ReplayCommands.USER_JOINED, L3_19)
end
function WriteReplay.write_user_left_game(A0_20, A1_21, A2_22)
	local L3_23
	L3_23 = A0_20._file
	if not L3_23 then
		return
	end
	L3_23 = {}
	L3_23.user_id = A1_21
	A0_20:write_chunk(ReplayCommands.USER_LEFT_GAME, L3_23)
end
function WriteReplay.write_interact(A0_24, A1_25, A2_26)
	local L3_27
	L3_27 = A0_24._file
	if not L3_27 then
		return
	end
	L3_27 = {}
	L3_27.interactable_unit_id = A1_25
	L3_27.player_unit_id = A2_26
	A0_24:write_chunk(ReplayCommands.INTERACT, L3_27)
end
function WriteReplay.write_arbitrate_interact(A0_28, A1_29, A2_30)
	local L3_31
	L3_31 = A0_28._file
	if not L3_31 then
		return
	end
	L3_31 = {}
	L3_31.interactable_unit_id = A1_29
	L3_31.player_unit_id = A2_30
	A0_28:write_chunk(ReplayCommands.ARBITRATE_INTERACT, L3_31)
end
function WriteReplay.write_arbitrate_pick_up(A0_32, A1_33, A2_34)
	local L3_35
	L3_35 = A0_32._file
	if not L3_35 then
		return
	end
	L3_35 = {}
	L3_35.player_unit_id = A1_33
	L3_35.interactable_unit_id = A2_34
	A0_32:write_chunk(ReplayCommands.ARBITRATE_PICK_UP, L3_35)
end
function WriteReplay.write_pick_up(A0_36, A1_37, A2_38)
	local L3_39
	L3_39 = A0_36._file
	if not L3_39 then
		return
	end
	L3_39 = {}
	L3_39.player_unit_id = A1_37
	L3_39.interactable_unit_id = A2_38
	A0_36:write_chunk(ReplayCommands.PICK_UP, L3_39)
end
