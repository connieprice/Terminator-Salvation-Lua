CoreSlotManager = CoreSlotManager or class()
function CoreSlotManager.init(A0_0)
	World:unit_manager():set_slot_limited(0, 0)
	World:unit_manager():set_slot_infinite(1)
	World:unit_manager():set_slot_infinite(19)
	World:unit_manager():set_slot_infinite(35)
	A0_0._masks = {}
	A0_0._masks.statics = World:make_slot_mask(1)
	A0_0._masks.surface_move = World:make_slot_mask(1, 11, 15, 20, 21, 24, 35, 38)
	A0_0._masks.sound_layer = World:make_slot_mask(19)
	A0_0._masks.environment_layer = World:make_slot_mask(19)
	A0_0._masks.portal_layer = World:make_slot_mask(19)
	A0_0._masks.dump_all = World:make_slot_mask(1)
	A0_0._masks.wires = World:make_slot_mask(35)
end
function CoreSlotManager.get_mask(A0_1, ...)
	local L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9
	L3_4 = {
		[6] = ...
	}
	L8_9 = ...
	;({
		[6] = ...
	})[1] = L4_5
	;({
		[6] = ...
	})[2] = L5_6
	;({
		[6] = ...
	})[3] = L6_7
	;({
		[6] = ...
	})[4] = L7_8
	;({
		[6] = ...
	})[5] = L8_9
	for L7_8, L8_9 in L4_5(L5_6) do
		if A0_1._masks[L8_9] then
			if not L2_3 then
				L2_3 = A0_1._masks[L8_9]
			else
				L2_3 = L2_3 + A0_1._masks[L8_9]
			end
		else
			Application:error("Invalid slotmask \"" .. tostring(L8_9) .. "\".")
		end
	end
	if L4_5 == 0 then
		L4_5(L5_6, L6_7)
	end
	return L2_3
end
function CoreSlotManager.get_mask_name(A0_10, A1_11)
	return table.get_key(A0_10._masks, A1_11)
end
function CoreSlotManager.get_mask_map(A0_12)
	local L1_13
	L1_13 = A0_12._masks
	return L1_13
end
