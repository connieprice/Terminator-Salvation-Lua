local L0_0
L0_0 = require
L0_0("units/beings/player/cover_data_retriever/GetAdjacentCoversOperation")
L0_0 = require
L0_0("units/beings/player/cover_data_retriever/GetQuickMoveInfosOperation")
L0_0 = require
L0_0("scheduler/RaycastOperation")
L0_0 = "get_adjacent_covers"
CoverDataRetriever = CoverDataRetriever or class()
function CoverDataRetriever.init(A0_1, A1_2)
	A0_1._scheduler = A1_2
	A0_1.left_cover = {}
	A0_1.left_cover.is_valid = false
	A0_1.right_cover = {}
	A0_1.right_cover.is_valid = false
	A0_1.quick_move_infos = {}
	A0_1.quick_move_infos.is_valid = false
	A0_1.quick_move_infos.id = 1
	A0_1.left_quick_move_infos = {}
	A0_1.left_quick_move_infos.is_valid = false
	A0_1.right_quick_move_infos = {}
	A0_1.right_quick_move_infos.is_valid = false
	A0_1.can_peek_at_left_edge = {}
	A0_1.can_peek_at_left_edge.is_valid = false
	A0_1.can_peek_at_right_edge = {}
	A0_1.can_peek_at_right_edge.is_valid = false
	A0_1.change_to_left_cover_distance = {}
	A0_1.change_to_left_cover_distance.is_valid = false
	A0_1.change_to_right_cover_distance = {}
	A0_1.change_to_right_cover_distance.is_valid = false
	A0_1.cover_line = {}
	A0_1.cover_line.is_valid = false
	A0_1.can_move_over_cover = {}
	A0_1.can_move_over_cover.is_valid = true
	A0_1._operations = {}
	A0_1._can_peek_at_edge_slot_mask = managers.slot:get_mask("statics")
end
function CoverDataRetriever.set_priorities(A0_3, A1_4, A2_5, A3_6, A4_7)
	assert(A1_4 and A1_4 > 0)
	assert(A2_5 and A2_5 > 0)
	assert(A3_6 and A3_6 > 0)
	assert(A4_7 and A4_7 > 0)
	A0_3._adjacent_covers_priority = A1_4
	A0_3._quick_move_infos_priority = A2_5
	A0_3._adjacent_quick_move_infos_priority = A3_6
	A0_3._can_peek_at_edge_priority = A4_7
end
function CoverDataRetriever.destroy(A0_8)
	A0_8:_cancel_operations()
end
function CoverDataRetriever.enter_cover(A0_9, A1_10)
	local L2_11
	L2_11 = A0_9._cancel_operations
	L2_11(A0_9)
	L2_11 = assert
	L2_11(A1_10)
	L2_11 = A0_9._cover
	A0_9._cover = A1_10
	A0_9._cover_right = A1_10:right()
	A0_9._high_cover = managers.cover_util:high_cover(A1_10)
	A0_9._left_edge_position, A0_9._right_edge_position = managers.cover_util:edge_positions(A1_10)
	A0_9:_get_adjacent_covers(A1_10)
	A0_9:_get_quick_move_infos(A1_10)
	A0_9.cover_line.value = A1_10:cover_line(tweak_data.player.cover.DISTANCE_TO, 0)
	A0_9.cover_line.is_valid = true
	A0_9.left_edge_position, A0_9.right_edge_position = A1_10:cover_line(tweak_data.player.cover.DISTANCE_TO, 0):edge_positions()
	A0_9:_get_can_move_over_cover()
	if A1_10 == A0_9.left_cover.value then
		A0_9:_set_right_cover(L2_11)
		if A0_9.change_to_left_cover_distance.is_valid then
			A0_9.change_to_right_cover_distance.value = A0_9.change_to_left_cover_distance.value
			A0_9.change_to_right_cover_distance.is_valid = true
		else
			A0_9.change_to_right_cover_distance.is_valid = false
		end
		A0_9.change_to_left_cover_distance.is_valid = false
		if A0_9.quick_move_infos.is_valid then
			A0_9:_set_right_quick_move_infos(A0_9.quick_move_infos.value)
		else
			A0_9.right_quick_move_infos.is_valid = false
		end
		if A0_9.left_quick_move_infos.is_valid then
			A0_9:_set_quick_move_infos(A0_9.left_quick_move_infos.value)
		else
			A0_9.quick_move_infos.is_valid = false
		end
		A0_9.left_quick_move_infos.is_valid = false
	elseif A1_10 == A0_9.right_cover.value then
		A0_9:_set_left_cover(L2_11)
		if A0_9.change_to_right_cover_distance.is_valid then
			A0_9.change_to_left_cover_distance.value = A0_9.change_to_right_cover_distance.value
			A0_9.change_to_left_cover_distance.is_valid = true
		else
			A0_9.change_to_left_cover_distance.is_valid = false
		end
		A0_9.change_to_right_cover_distance.is_valid = false
		if A0_9.quick_move_infos.is_valid then
			A0_9:_set_left_quick_move_infos(A0_9.quick_move_infos.value)
		else
			A0_9.left_quick_move_infos.is_valid = false
		end
		if A0_9.right_quick_move_infos.is_valid then
			A0_9:_set_quick_move_infos(A0_9.right_quick_move_infos.value)
		else
			A0_9.quick_move_infos.is_valid = false
		end
		A0_9.right_quick_move_infos.is_valid = false
	else
		A0_9.change_to_left_cover_distance.is_valid = false
		A0_9.change_to_right_cover_distance.is_valid = false
		A0_9.quick_move_infos.is_valid = false
		A0_9.left_quick_move_infos.is_valid = false
		A0_9.right_quick_move_infos.is_valid = false
	end
end
function CoverDataRetriever.leave_cover(A0_12)
	A0_12._cover = nil
	A0_12._cover_right = nil
	A0_12:_cancel_operations()
	A0_12.left_cover.is_valid = false
	A0_12.right_cover.is_valid = false
	A0_12.quick_move_infos.is_valid = false
end
function CoverDataRetriever._get_quick_move_infos(A0_13, A1_14)
	local L2_15, L3_16
	L3_16 = A0_13
	L2_15 = A0_13._cancel_and_remove_operation
	L2_15(L3_16, _UPVALUE0_)
	L2_15 = GetQuickMoveInfosOperation
	L3_16 = L2_15
	L2_15 = L2_15.new
	L2_15 = L2_15(L3_16, A1_14)
	function L3_16(A0_17)
		_UPVALUE0_:_set_quick_move_infos(A0_17.quick_move_infos)
	end
	A0_13:_insert_operation(L2_15, "GetQuickMoveInfos", A0_13._quick_move_infos_priority, L3_16)
	A0_13._operations[_UPVALUE0_] = L2_15
end
function CoverDataRetriever._get_adjacent_covers(A0_18, A1_19)
	local L2_20, L3_21
	L3_21 = A0_18
	L2_20 = A0_18._cancel_and_remove_operation
	L2_20(L3_21, _UPVALUE0_)
	L2_20 = A0_18.left_cover
	L2_20.is_valid = false
	L2_20 = A0_18.right_cover
	L2_20.is_valid = false
	L2_20 = GetAdjacentCoversOperation
	L3_21 = L2_20
	L2_20 = L2_20.new
	L2_20 = L2_20(L3_21, A1_19)
	function L3_21(A0_22)
		_UPVALUE0_:_set_adjacent_covers(A0_22.left_cover, A0_22.right_cover)
	end
	A0_18:_insert_operation(L2_20, "GetAdjacentCovers", A0_18._adjacent_covers_priority, L3_21)
	A0_18._operations[_UPVALUE0_] = L2_20
end
function CoverDataRetriever._cancel_and_remove_operation(A0_23, A1_24)
	local L2_25
	L2_25 = A0_23._operations
	L2_25 = L2_25[A1_24]
	if L2_25 then
		L2_25:cancel()
		A0_23:_remove_operation(L2_25)
		A0_23._operations[A1_24] = nil
	end
end
function CoverDataRetriever._cancel_operations(A0_26)
	local L1_27, L2_28, L3_29, L4_30, L5_31, L6_32
	L1_27 = A0_26._scheduler
	for L5_31, L6_32 in L2_28(L3_29) do
		L6_32:cancel()
		A0_26:_remove_operation(L6_32)
	end
	A0_26._operations = L2_28
end
function CoverDataRetriever._set_quick_move_infos(A0_33, A1_34)
	local L2_35, L3_36
	L2_35 = A0_33.quick_move_infos
	L2_35.value = A1_34
	L2_35 = A0_33.quick_move_infos
	L2_35.is_valid = true
	L2_35 = A0_33.quick_move_infos
	L3_36 = A0_33.quick_move_infos
	L3_36 = L3_36.id
	L3_36 = L3_36 + 1
	L2_35.id = L3_36
end
function CoverDataRetriever._set_left_cover(A0_37, A1_38)
	local L2_39
	L2_39 = A0_37.left_cover
	L2_39.value = A1_38
	L2_39 = A0_37.left_cover
	L2_39.is_valid = true
end
function CoverDataRetriever._set_right_cover(A0_40, A1_41)
	local L2_42
	L2_42 = A0_40.right_cover
	L2_42.value = A1_41
	L2_42 = A0_40.right_cover
	L2_42.is_valid = true
end
function CoverDataRetriever._set_adjacent_covers(A0_43, A1_44, A2_45)
	A0_43:_set_left_cover(A1_44)
	A0_43:_set_right_cover(A2_45)
	A0_43:_update_change_to_left_cover_distance(A1_44)
	A0_43:_update_change_to_right_cover_distance(A2_45)
	A0_43:_get_adjacent_quick_move_infos(A1_44, "left_quick_move_infos", A0_43._set_left_quick_move_infos)
	A0_43:_get_adjacent_quick_move_infos(A2_45, "right_quick_move_infos", A0_43._set_right_quick_move_infos)
	A0_43:_get_can_peek_at_left_edge(A1_44)
	A0_43:_get_can_peek_at_right_edge(A2_45)
end
function CoverDataRetriever._update_change_to_left_cover_distance(A0_46, A1_47)
	if A1_47 then
		A0_46.change_to_left_cover_distance.value = A0_46:_change_to_adjacent_cover_distance(A1_47, A0_46._cover)
	else
		A0_46.change_to_left_cover_distance.value = nil
	end
	A0_46.change_to_left_cover_distance.is_valid = true
end
function CoverDataRetriever._update_change_to_right_cover_distance(A0_48, A1_49)
	if A1_49 then
		A0_48.change_to_right_cover_distance.value = A0_48:_change_to_adjacent_cover_distance(A0_48._cover, A1_49)
	else
		A0_48.change_to_right_cover_distance.value = nil
	end
	A0_48.change_to_right_cover_distance.is_valid = true
end
function CoverDataRetriever._change_to_adjacent_cover_distance(A0_50, A1_51, A2_52)
	assert((A2_52:normal():to_polar() - A1_51:normal():to_polar()).spin <= 90)
	if (A2_52:normal():to_polar() - A1_51:normal():to_polar()).spin <= -90 then
	elseif (A2_52:normal():to_polar() - A1_51:normal():to_polar()).spin < 0 then
	else
	end
	return tweak_data.player.cover.DISTANCE_TO * math.tan((A2_52:normal():to_polar() - A1_51:normal():to_polar()).spin / 2)
end
function CoverDataRetriever._get_can_peek_at_left_edge(A0_53, A1_54)
	local L2_55, L3_56, L4_57, L5_58
	if A1_54 then
		L2_55 = A0_53._high_cover
		if L2_55 then
			L2_55 = managers
			L2_55 = L2_55.cover_util
			L3_56 = L2_55
			L2_55 = L2_55.high_cover
			L4_57 = A1_54
			L2_55 = L2_55(L3_56, L4_57)
			L2_55 = not L2_55
		elseif not L2_55 then
			L3_56 = A0_53
			L2_55 = A0_53._set_can_peek_at_left_edge
			L4_57 = false
			L2_55(L3_56, L4_57)
		end
	else
		function L2_55(A0_59)
			_UPVALUE0_:_set_can_peek_at_left_edge(A0_59.ray == nil)
		end
		L3_56 = A0_53._left_edge_position
		L4_57 = math
		L4_57 = L4_57.UP
		L4_57 = L4_57 * 50
		L3_56 = L3_56 + L4_57
		L4_57 = {
			L5_58,
			L3_56 - A0_53._cover_right * 100
		}
		L5_58 = L3_56
		L5_58 = RaycastOperation
		L5_58 = L5_58.new
		L5_58 = L5_58(L5_58, L4_57, A0_53._can_peek_at_edge_slot_mask, nil)
		A0_53:_insert_operation(L5_58, "PeekAtEdge", A0_53._can_peek_at_edge_priority, L2_55)
		A0_53._operations[_UPVALUE0_] = L5_58
	end
end
function CoverDataRetriever._set_can_peek_at_left_edge(A0_60, A1_61)
	local L2_62
	L2_62 = A0_60.can_peek_at_left_edge
	L2_62.is_valid = true
	L2_62 = A0_60.can_peek_at_left_edge
	L2_62.value = A1_61
end
function CoverDataRetriever._get_can_peek_at_right_edge(A0_63, A1_64)
	local L2_65, L3_66, L4_67, L5_68
	if A1_64 then
		L2_65 = A0_63._high_cover
		if L2_65 then
			L2_65 = managers
			L2_65 = L2_65.cover_util
			L3_66 = L2_65
			L2_65 = L2_65.high_cover
			L4_67 = A1_64
			L2_65 = L2_65(L3_66, L4_67)
			L2_65 = not L2_65
		elseif not L2_65 then
			L3_66 = A0_63
			L2_65 = A0_63._set_can_peek_at_right_edge
			L4_67 = false
			L2_65(L3_66, L4_67)
		end
	else
		function L2_65(A0_69)
			_UPVALUE0_:_set_can_peek_at_right_edge(A0_69.ray == nil)
		end
		L3_66 = A0_63._right_edge_position
		L4_67 = math
		L4_67 = L4_67.UP
		L4_67 = L4_67 * 50
		L3_66 = L3_66 + L4_67
		L4_67 = {
			L5_68,
			L3_66 + A0_63._cover_right * 100
		}
		L5_68 = L3_66
		L5_68 = RaycastOperation
		L5_68 = L5_68.new
		L5_68 = L5_68(L5_68, L4_67, A0_63._can_peek_at_edge_slot_mask, nil)
		A0_63:_insert_operation(L5_68, "PeekAtEdge", A0_63._can_peek_at_edge_priority, L2_65)
		A0_63._operations[_UPVALUE0_] = L5_68
	end
end
function CoverDataRetriever._set_can_peek_at_right_edge(A0_70, A1_71)
	local L2_72
	L2_72 = A0_70.can_peek_at_right_edge
	L2_72.is_valid = true
	L2_72 = A0_70.can_peek_at_right_edge
	L2_72.value = A1_71
end
function CoverDataRetriever._get_adjacent_quick_move_infos(A0_73, A1_74, A2_75, A3_76)
	local L4_77, L5_78
	if A1_74 then
		function L4_77(A0_79)
			_UPVALUE0_(_UPVALUE1_, A0_79.quick_move_infos)
		end
		L5_78 = GetQuickMoveInfosOperation
		L5_78 = L5_78.new
		L5_78 = L5_78(L5_78, A1_74)
		A0_73:_insert_operation(L5_78, "GetQuickMoveInfos", A0_73._adjacent_quick_move_infos_priority, L4_77)
		A0_73._operations[A2_75] = L5_78
	else
		L4_77 = A3_76
		L5_78 = A0_73
		L4_77(L5_78, {})
	end
end
function CoverDataRetriever._set_left_quick_move_infos(A0_80, A1_81)
	local L2_82
	L2_82 = A0_80.left_quick_move_infos
	L2_82.value = A1_81
	L2_82 = A0_80.left_quick_move_infos
	L2_82.is_valid = true
end
function CoverDataRetriever._set_right_quick_move_infos(A0_83, A1_84)
	local L2_85
	L2_85 = A0_83.right_quick_move_infos
	L2_85.value = A1_84
	L2_85 = A0_83.right_quick_move_infos
	L2_85.is_valid = true
end
function CoverDataRetriever._get_can_move_over_cover(A0_86)
	local L1_87, L2_88
	L2_88 = A0_86
	L1_87 = A0_86._set_can_move_over_cover
	L1_87(L2_88, managers.cover_util:_static_can_move_over_cover(A0_86._cover))
end
function CoverDataRetriever._set_can_move_over_cover(A0_89, A1_90)
	local L2_91
	L2_91 = A0_89.can_move_over_cover
	L2_91.value = A1_90
	L2_91 = A0_89.can_move_over_cover
	L2_91.is_valid = true
end
function CoverDataRetriever._insert_operation(A0_92, A1_93, A2_94, A3_95, A4_96)
	A0_92._scheduler:insert_operation(A1_93, A2_94, A3_95, A4_96)
end
function CoverDataRetriever._remove_operation(A0_97, A1_98)
	A0_97._scheduler:remove_operation(A1_98)
end
