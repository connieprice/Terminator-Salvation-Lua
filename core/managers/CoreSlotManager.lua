if not CoreSlotManager then
	CoreSlotManager = class()
end
CoreSlotManager.init = function(l_1_0)
	local l_1_1 = World:unit_manager()
	l_1_1:set_slot_limited(0, 0)
	l_1_1:set_slot_infinite(1)
	l_1_1:set_slot_infinite(19)
	l_1_1:set_slot_infinite(35)
	l_1_0._masks = {}
	l_1_0._masks.statics = World:make_slot_mask(1)
	l_1_0._masks.surface_move = World:make_slot_mask(1, 11, 15, 20, 21, 24, 35, 38)
	l_1_0._masks.sound_layer = World:make_slot_mask(19)
	l_1_0._masks.environment_layer = World:make_slot_mask(19)
	l_1_0._masks.portal_layer = World:make_slot_mask(19)
	l_1_0._masks.dump_all = World:make_slot_mask(1)
	l_1_0._masks.wires = World:make_slot_mask(35)
end

CoreSlotManager.get_mask = function(l_2_0, ...)
	local l_2_2 = nil
	local l_2_6, l_2_7 = {}, ...
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_2_7 do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_2_0._masks[i_1] then
			if not l_2_2 then
				l_2_2 = l_2_0._masks[i_1]
			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				l_2_2 = l_2_2 + l_2_0._masks[i_1]
			end
		else
			Application:error("Invalid slotmask \"" .. tostring(l_2_8) .. "\".")
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_2_7 == 0 then
		Application:error("No parameters passed to get_mask function.")
	end
	return l_2_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSlotManager.get_mask_name = function(l_3_0, l_3_1)
	local l_3_2 = table.get_key
	local l_3_3 = l_3_0._masks
	local l_3_4 = l_3_1
	return l_3_2(l_3_3, l_3_4)
end

CoreSlotManager.get_mask_map = function(l_4_0)
	return l_4_0._masks
end


