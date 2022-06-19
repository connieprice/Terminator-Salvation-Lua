if not PlayerInventory then
	PlayerInventory = class()
end
PlayerInventory.init = function(l_1_0, l_1_1, l_1_2)
	local l_1_6, l_1_7 = nil
	l_1_0._unit = l_1_1
	l_1_0._player_data = l_1_1:player_data()
	l_1_0._inventory = {}
	for i_0,i_1 in pairs(l_1_2) do
		local l_1_10 = table.insert
		l_1_10(l_1_0._inventory, {item_type = l_1_9, item = nil})
	end
	l_1_0._player_data.current_weapon_slot = 1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerInventory.destroy = function(l_2_0)
end

PlayerInventory.insert_item = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_0._inventory[l_3_2]
	local l_3_5 = assert
	l_3_5(l_3_4 ~= nil and l_3_4.item == nil and l_3_4.item_type == l_3_3)
	l_3_4.item = l_3_1
end

PlayerInventory.remove_item = function(l_4_0, l_4_1)
	local l_4_2 = assert
	l_4_2(l_4_0._inventory[l_4_1] ~= nil)
	l_4_2 = l_4_0._inventory
	l_4_2 = l_4_2[l_4_1]
	l_4_2.item = nil
end

PlayerInventory.find_slot_index = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7 = nil
	for i_0,i_1 in ipairs(l_5_0._inventory) do
		if i_1.item == l_5_1 then
			return i_0
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerInventory.find_free_slot = function(l_6_0, l_6_1)
	local l_6_2, l_6_5, l_6_6, l_6_7, l_6_8, l_6_9 = nil
	for i_0,i_1 in pairs(l_6_0._inventory) do
		if i_1.item == nil and (l_6_1 == nil or i_1.item_type == l_6_1) then
			l_6_2 = i_0
	else
		end
	end
	return l_6_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerInventory.find_first_item = function(l_7_0, l_7_1)
	local l_7_2, l_7_5, l_7_6, l_7_7, l_7_8, l_7_9 = nil
	for i_0,i_1 in pairs(l_7_0._inventory) do
		if i_1.item ~= nil and (l_7_1 == nil or i_1.item_type == l_7_1) then
			l_7_2 = i_0
	else
		end
	end
	return l_7_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerInventory.find_next_item = function(l_8_0, l_8_1, l_8_2)
	local l_8_3, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11 = nil
	for i_0,i_1 in pairs(l_8_0._inventory) do
		if i_1.item ~= nil and (l_8_2 == nil or i_1.item_type == l_8_2) and (l_8_1 < i_0 or l_8_3 == nil) then
			l_8_3 = i_0
		end
	end
	return l_8_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerInventory.all_items = function(l_9_0)
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10 = nil
	local l_9_1 = {}
	for i_0,i_1 in pairs(l_9_0._inventory) do
		if i_1.item then
			table.insert(l_9_1, i_1.item)
		end
	end
	return l_9_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerInventory.clear = function(l_10_0)
	local l_10_4, l_10_5 = nil
	for i_0,i_1 in pairs(l_10_0._inventory) do
		i_1.item = nil
	end
end

PlayerInventory.is_owner = function(l_11_0)
	return true
end

PlayerInventory.item_by_index = function(l_12_0, l_12_1)
	assert(l_12_0._inventory[l_12_1])
	return l_12_0._inventory[l_12_1].item
end

PlayerInventory.slot_type_by_index = function(l_13_0, l_13_1)
	assert(l_13_0._inventory[l_13_1])
	return l_13_0._inventory[l_13_1].item_type
end

PlayerInventory.item = function(l_14_0, l_14_1)
	local l_14_5, l_14_6, l_14_7, l_14_8, l_14_9, l_14_10 = nil
	for i_0,i_1 in ipairs(l_14_0._inventory) do
		if i_1.item and i_1.item:name() == l_14_1 then
			return i_1.item
		end
	end
end


