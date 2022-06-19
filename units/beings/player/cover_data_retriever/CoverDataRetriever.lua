require("units/beings/player/cover_data_retriever/GetAdjacentCoversOperation")
require("units/beings/player/cover_data_retriever/GetQuickMoveInfosOperation")
require("scheduler/RaycastOperation")
local l_0_0 = "get_adjacent_covers"
local l_0_1 = "get_quick_move_infos"
local l_0_2 = "can_peek_at_left_edge"
local l_0_3 = "can_peek_at_right_edge"
if not CoverDataRetriever then
	CoverDataRetriever = class()
end
CoverDataRetriever.init = function(l_1_0, l_1_1)
	l_1_0._scheduler = l_1_1
	l_1_0.left_cover = {}
	l_1_0.left_cover.is_valid = false
	l_1_0.right_cover = {}
	l_1_0.right_cover.is_valid = false
	l_1_0.quick_move_infos = {}
	l_1_0.quick_move_infos.is_valid = false
	l_1_0.quick_move_infos.id = 1
	l_1_0.left_quick_move_infos = {}
	l_1_0.left_quick_move_infos.is_valid = false
	l_1_0.right_quick_move_infos = {}
	l_1_0.right_quick_move_infos.is_valid = false
	l_1_0.can_peek_at_left_edge = {}
	l_1_0.can_peek_at_left_edge.is_valid = false
	l_1_0.can_peek_at_right_edge = {}
	l_1_0.can_peek_at_right_edge.is_valid = false
	l_1_0.change_to_left_cover_distance = {}
	l_1_0.change_to_left_cover_distance.is_valid = false
	l_1_0.change_to_right_cover_distance = {}
	l_1_0.change_to_right_cover_distance.is_valid = false
	l_1_0.cover_line = {}
	l_1_0.cover_line.is_valid = false
	l_1_0.can_move_over_cover = {}
	l_1_0.can_move_over_cover.is_valid = true
	l_1_0._operations = {}
	l_1_0._can_peek_at_edge_slot_mask = managers.slot:get_mask("statics")
end

CoverDataRetriever.set_priorities = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4)
	local l_2_5 = assert
	do
		l_2_5(not l_2_1 or l_2_1 > 0)
		l_2_5 = assert
		l_2_5(not l_2_2 or l_2_2 > 0)
		l_2_5 = assert
		l_2_5(not l_2_3 or l_2_3 > 0)
		l_2_5 = assert
		l_2_5(not l_2_4 or l_2_4 > 0)
		l_2_0._adjacent_covers_priority = l_2_1
		l_2_0._quick_move_infos_priority = l_2_2
		l_2_0._adjacent_quick_move_infos_priority = l_2_3
		l_2_0._can_peek_at_edge_priority = l_2_4
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoverDataRetriever.destroy = function(l_3_0)
	l_3_0:_cancel_operations()
end

CoverDataRetriever.enter_cover = function(l_4_0, l_4_1)
	l_4_0:_cancel_operations()
	assert(l_4_1)
	local l_4_2 = l_4_0._cover
	local l_4_3 = nil
	if l_4_0.left_cover.is_valid then
		l_4_3 = l_4_0.left_cover.value
	end
	local l_4_4 = nil
	if l_4_0.right_cover.is_valid then
		l_4_4 = l_4_0.right_cover.value
	end
	l_4_0._cover = l_4_1
	l_4_0._cover_right = l_4_1:right()
	l_4_0._high_cover = managers.cover_util:high_cover(l_4_1)
	local l_4_5 = managers.cover_util:edge_positions(l_4_1)
	l_4_0._right_edge_position = managers.cover_util
	l_4_0._left_edge_position = l_4_5
	l_4_5(l_4_0, l_4_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_5(l_4_0, l_4_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_0.cover_line.value = l_4_5
	l_4_0.cover_line.is_valid = true
	local l_4_6 = l_4_5:edge_positions()
	l_4_0.right_edge_position = l_4_5
	l_4_0.left_edge_position = l_4_6
	l_4_6(l_4_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_1 == l_4_3 then
		l_4_6(l_4_0, l_4_2)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_4_6 then
			l_4_6.value = l_4_0.change_to_left_cover_distance.value
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_4_6.is_valid = true
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			l_4_6.is_valid = false
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_6.is_valid = false
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_4_6.is_valid then
			l_4_0:_set_right_quick_move_infos(l_4_6.value)
		else
			l_4_0.right_quick_move_infos.is_valid = false
		end
		do
			local l_4_7 = l_4_0.left_quick_move_infos
			if l_4_7.is_valid then
				l_4_0:_set_quick_move_infos(l_4_7.value)
			else
				l_4_0.quick_move_infos.is_valid = false
			end
			l_4_0.left_quick_move_infos.is_valid = false
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	elseif l_4_1 == l_4_4 then
		l_4_6(l_4_0, l_4_2)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_4_6 then
			l_4_6.value = l_4_0.change_to_right_cover_distance.value
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_4_6.is_valid = true
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			l_4_6.is_valid = false
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_6.is_valid = false
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_4_6.is_valid then
			l_4_0:_set_left_quick_move_infos(l_4_6.value)
		else
			l_4_0.left_quick_move_infos.is_valid = false
		end
		do
			local l_4_8 = l_4_0.right_quick_move_infos
			if l_4_8.is_valid then
				l_4_0:_set_quick_move_infos(l_4_8.value)
			else
				l_4_0.quick_move_infos.is_valid = false
			end
			l_4_0.right_quick_move_infos.is_valid = false
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_4_6.is_valid = false
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_6.is_valid = false
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_6.is_valid = false
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_6.is_valid = false
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_6.is_valid = false
	end
end

CoverDataRetriever.leave_cover = function(l_5_0)
	l_5_0._cover = nil
	l_5_0._cover_right = nil
	l_5_0:_cancel_operations()
	l_5_0.left_cover.is_valid = false
	l_5_0.right_cover.is_valid = false
	l_5_0.quick_move_infos.is_valid = false
end

CoverDataRetriever._get_quick_move_infos = function(l_6_0, l_6_1)
	-- upvalues: l_0_1
	l_6_0:_cancel_and_remove_operation(l_0_1)
	local l_6_2 = GetQuickMoveInfosOperation:new(l_6_1)
	do
		l_6_0:_insert_operation(l_6_2, "GetQuickMoveInfos", l_6_0._quick_move_infos_priority, function(l_7_0)
		-- upvalues: l_6_0
		l_6_0:_set_quick_move_infos(l_7_0.quick_move_infos)
  end)
		l_6_0._operations[l_0_1] = l_6_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoverDataRetriever._get_adjacent_covers = function(l_7_0, l_7_1)
	-- upvalues: l_0_0
	l_7_0:_cancel_and_remove_operation(l_0_0)
	l_7_0.left_cover.is_valid = false
	l_7_0.right_cover.is_valid = false
	local l_7_2 = GetAdjacentCoversOperation:new(l_7_1)
	do
		l_7_0:_insert_operation(l_7_2, "GetAdjacentCovers", l_7_0._adjacent_covers_priority, function(l_8_0)
		-- upvalues: l_7_0
		l_7_0:_set_adjacent_covers(l_8_0.left_cover, l_8_0.right_cover)
  end)
		l_7_0._operations[l_0_0] = l_7_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoverDataRetriever._cancel_and_remove_operation = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0._operations[l_8_1]
	if l_8_2 then
		l_8_2:cancel()
		l_8_0:_remove_operation(l_8_2)
		l_8_0._operations[l_8_1] = nil
	end
end

CoverDataRetriever._cancel_operations = function(l_9_0)
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12 = nil
	local l_9_1 = l_9_0._scheduler
	for i_0,i_1 in pairs(l_9_0._operations) do
		i_1:cancel()
		l_9_0:_remove_operation(i_1)
	end
	l_9_0._operations = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoverDataRetriever._set_quick_move_infos = function(l_10_0, l_10_1)
	l_10_0.quick_move_infos.value = l_10_1
	l_10_0.quick_move_infos.is_valid = true
	l_10_0.quick_move_infos.id = l_10_0.quick_move_infos.id + 1
end

CoverDataRetriever._set_left_cover = function(l_11_0, l_11_1)
	l_11_0.left_cover.value = l_11_1
	l_11_0.left_cover.is_valid = true
end

CoverDataRetriever._set_right_cover = function(l_12_0, l_12_1)
	l_12_0.right_cover.value = l_12_1
	l_12_0.right_cover.is_valid = true
end

CoverDataRetriever._set_adjacent_covers = function(l_13_0, l_13_1, l_13_2)
	l_13_0:_set_left_cover(l_13_1)
	l_13_0:_set_right_cover(l_13_2)
	l_13_0:_update_change_to_left_cover_distance(l_13_1)
	l_13_0:_update_change_to_right_cover_distance(l_13_2)
	l_13_0:_get_adjacent_quick_move_infos(l_13_1, "left_quick_move_infos", l_13_0._set_left_quick_move_infos)
	l_13_0:_get_adjacent_quick_move_infos(l_13_2, "right_quick_move_infos", l_13_0._set_right_quick_move_infos)
	l_13_0:_get_can_peek_at_left_edge(l_13_1)
	l_13_0:_get_can_peek_at_right_edge(l_13_2)
end

CoverDataRetriever._update_change_to_left_cover_distance = function(l_14_0, l_14_1)
	if l_14_1 then
		local l_14_2 = l_14_0:_change_to_adjacent_cover_distance(l_14_1, l_14_0._cover)
		l_14_0.change_to_left_cover_distance.value = l_14_2
	else
		l_14_0.change_to_left_cover_distance.value = nil
	end
	l_14_0.change_to_left_cover_distance.is_valid = true
end

CoverDataRetriever._update_change_to_right_cover_distance = function(l_15_0, l_15_1)
	if l_15_1 then
		local l_15_2 = l_15_0:_change_to_adjacent_cover_distance(l_15_0._cover, l_15_1)
		l_15_0.change_to_right_cover_distance.value = l_15_2
	else
		l_15_0.change_to_right_cover_distance.value = nil
	end
	l_15_0.change_to_right_cover_distance.is_valid = true
end

CoverDataRetriever._change_to_adjacent_cover_distance = function(l_16_0, l_16_1, l_16_2)
	local l_16_3 = l_16_1:normal()
	local l_16_4 = l_16_2:normal()
	local l_16_5 = l_16_4:to_polar() - l_16_3:to_polar().spin
	local l_16_6 = assert
	l_16_6(l_16_5 <= 90)
	l_16_6 = nil
	if l_16_5 <= -90 then
		l_16_6 = -tweak_data.player.cover.DISTANCE_TO - tweak_data.player.cover.DISTANCE_TO * math.tan(-90 - l_16_5)
	elseif l_16_5 < 0 then
		l_16_6 = -tweak_data.player.cover.DISTANCE_TO * math.tan(-l_16_5 / 2)
	else
		l_16_6 = tweak_data.player.cover.DISTANCE_TO * math.tan(l_16_5 / 2)
	end
	return l_16_6
end

CoverDataRetriever._get_can_peek_at_left_edge = function(l_17_0, l_17_1)
	-- upvalues: l_0_2
	if l_17_1 and (not l_17_0._high_cover or not not managers.cover_util:high_cover(l_17_1)) then
		l_17_0:_set_can_peek_at_left_edge(false)
	else
		local l_17_3 = function(l_18_0)
		-- upvalues: l_17_0
		local l_18_1, l_18_2 = l_17_0:_set_can_peek_at_left_edge, l_17_0
		l_18_1(l_18_2, l_18_0.ray == nil)
  end
		local l_17_4 = l_17_0._left_edge_position + math.UP * 50
		do
			local l_17_5 = nil
			l_17_0:_insert_operation(RaycastOperation:new({l_17_4, l_17_4 - l_17_0._cover_right * 100}, l_17_0._can_peek_at_edge_slot_mask, nil), "PeekAtEdge", l_17_0._can_peek_at_edge_priority, l_17_3)
			l_17_0._operations[l_0_2] = RaycastOperation:new({l_17_4, l_17_4 - l_17_0._cover_right * 100}, l_17_0._can_peek_at_edge_slot_mask, nil)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoverDataRetriever._set_can_peek_at_left_edge = function(l_18_0, l_18_1)
	l_18_0.can_peek_at_left_edge.is_valid = true
	l_18_0.can_peek_at_left_edge.value = l_18_1
end

CoverDataRetriever._get_can_peek_at_right_edge = function(l_19_0, l_19_1)
	-- upvalues: l_0_3
	if l_19_1 and (not l_19_0._high_cover or not not managers.cover_util:high_cover(l_19_1)) then
		l_19_0:_set_can_peek_at_right_edge(false)
	else
		local l_19_3 = function(l_20_0)
		-- upvalues: l_19_0
		local l_20_1, l_20_2 = l_19_0:_set_can_peek_at_right_edge, l_19_0
		l_20_1(l_20_2, l_20_0.ray == nil)
  end
		local l_19_4 = l_19_0._right_edge_position + math.UP * 50
		do
			local l_19_5 = nil
			l_19_0:_insert_operation(RaycastOperation:new({l_19_4, l_19_4 + l_19_0._cover_right * 100}, l_19_0._can_peek_at_edge_slot_mask, nil), "PeekAtEdge", l_19_0._can_peek_at_edge_priority, l_19_3)
			l_19_0._operations[l_0_3] = RaycastOperation:new({l_19_4, l_19_4 + l_19_0._cover_right * 100}, l_19_0._can_peek_at_edge_slot_mask, nil)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoverDataRetriever._set_can_peek_at_right_edge = function(l_20_0, l_20_1)
	l_20_0.can_peek_at_right_edge.is_valid = true
	l_20_0.can_peek_at_right_edge.value = l_20_1
end

CoverDataRetriever._get_adjacent_quick_move_infos = function(l_21_0, l_21_1, l_21_2, l_21_3)
	do
		if l_21_1 then
			local l_21_5 = function(l_22_0)
		-- upvalues: l_21_3 , l_21_0
		l_21_3(l_21_0, l_22_0.quick_move_infos)
  end
			l_21_0:_insert_operation(GetQuickMoveInfosOperation:new(l_21_1), "GetQuickMoveInfos", l_21_0._adjacent_quick_move_infos_priority, l_21_5)
			l_21_0._operations[l_21_2] = GetQuickMoveInfosOperation:new(l_21_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		l_21_3(l_21_0, {})
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoverDataRetriever._set_left_quick_move_infos = function(l_22_0, l_22_1)
	l_22_0.left_quick_move_infos.value = l_22_1
	l_22_0.left_quick_move_infos.is_valid = true
end

CoverDataRetriever._set_right_quick_move_infos = function(l_23_0, l_23_1)
	l_23_0.right_quick_move_infos.value = l_23_1
	l_23_0.right_quick_move_infos.is_valid = true
end

CoverDataRetriever._get_can_move_over_cover = function(l_24_0)
	l_24_0:_set_can_move_over_cover(managers.cover_util:_static_can_move_over_cover(l_24_0._cover))
end

CoverDataRetriever._set_can_move_over_cover = function(l_25_0, l_25_1)
	l_25_0.can_move_over_cover.value = l_25_1
	l_25_0.can_move_over_cover.is_valid = true
end

CoverDataRetriever._insert_operation = function(l_26_0, l_26_1, l_26_2, l_26_3, l_26_4)
	l_26_0._scheduler:insert_operation(l_26_1, l_26_2, l_26_3, l_26_4)
end

CoverDataRetriever._remove_operation = function(l_27_0, l_27_1)
	l_27_0._scheduler:remove_operation(l_27_1)
end


