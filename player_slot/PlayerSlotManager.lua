require("player_slot/PlayerSlot")
PlayerSlotManager = PlayerSlotManager or class()
function PlayerSlotManager.init(A0_0, A1_1, A2_2)
	local L4_3, L5_4, L6_5
	A0_0._slots = L4_3
	for _FORV_6_ = 1, A1_1.slot_count do
		A0_0._slots[_FORV_6_] = PlayerSlot:new(A1_1.slots[_FORV_6_])
	end
end
function PlayerSlotManager.default_data(A0_6)
	local L2_7, L3_8, L4_9
	A0_6.slot_count = 4
	A0_6.slots = L2_7
	for _FORV_4_ = 1, A0_6.slot_count do
		A0_6.slots[_FORV_4_] = {}
		PlayerSlot.default_data(A0_6.slots[_FORV_4_])
	end
end
function PlayerSlotManager.save(A0_10, A1_11)
	A1_11.slot_count = TableAlgorithms.count(A0_10._slots)
	A1_11.slots = {}
	for 