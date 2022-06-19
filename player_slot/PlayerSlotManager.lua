require("player_slot/PlayerSlot")
if not PlayerSlotManager then
	PlayerSlotManager = class()
end
PlayerSlotManager.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._slots = {}
	for l_1_6 = 1, l_1_1.slot_count do
		l_1_0._slots[l_1_6] = PlayerSlot:new(l_1_1.slots[l_1_6])
	end
end

PlayerSlotManager.default_data = function(l_2_0)
	l_2_0.slot_count = 4
	l_2_0.slots = {}
	for l_2_4 = 1, l_2_0.slot_count do
		l_2_0.slots[l_2_4] = {}
		PlayerSlot.default_data(l_2_0.slots[l_2_4])
	end
end

PlayerSlotManager.save = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11 = nil
	l_3_1.slot_count = TableAlgorithms.count(l_3_0._slots)
	l_3_1.slots = {}
	for i_0,i_1 in ipairs(l_3_0._slots) do
		l_3_1.slots[i_0] = {}
		i_1:save(l_3_1.slots[i_0])
	end
end

PlayerSlotManager.update = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7 = nil
	for i_0,i_1 in ipairs(l_4_0._slots) do
		i_1:update()
	end
end

PlayerSlotManager.slot = function(l_5_0, l_5_1)
	assert(l_5_0._slots[l_5_1])
	return l_5_0._slots[l_5_1]
end

PlayerSlotManager.slots = function(l_6_0)
	return l_6_0._slots
end

PlayerSlotManager.is_slot_occupied = function(l_7_0, l_7_1)
	local l_7_2, l_7_3 = l_7_0._slots[l_7_1]:is_occupied, l_7_0._slots[l_7_1]
	return l_7_2(l_7_3)
end

PlayerSlotManager.number_of_occupied_slots = function(l_8_0)
	local l_8_1 = TableAlgorithms.count_if
	local l_8_2 = l_8_0._slots
	local l_8_3 = function(l_9_0)
		local l_9_1, l_9_2 = l_9_0:is_occupied, l_9_0
		return l_9_1(l_9_2)
  end
	return l_8_1(l_8_2, l_8_3)
end

PlayerSlotManager.set_unit = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10)
	local l_9_11 = l_9_0._slots[l_9_1]
	assert(l_9_11)
	l_9_11:set_unit(l_9_2, l_9_3, l_9_4, l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10)
end

PlayerSlotManager.set_spawn_point = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5, l_10_6, l_10_7, l_10_8, l_10_9)
	local l_10_10 = l_10_0._slots[l_10_1]
	assert(l_10_10)
	l_10_10:set_spawn_point(l_10_2, l_10_3, l_10_4, l_10_5, l_10_6, l_10_7, l_10_8, l_10_9)
end

PlayerSlotManager.find_first_free_slot_id = function(l_11_0)
	local l_11_4, l_11_5, l_11_6 = nil
	for i_0,i_1 in ipairs(l_11_0._slots) do
		if not i_1:is_occupied() then
			return i_0
		end
	end
end


