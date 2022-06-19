local L0_0
L0_0 = require
L0_0("shared/SharedMath")
L0_0 = NavigationGraphUtilities
L0_0 = L0_0 or {}
NavigationGraphUtilities = L0_0
L0_0 = NavigationGraphUtilities
L0_0._dynamic_aigraphs = NavigationGraphUtilities._dynamic_aigraphs or {
	surface_human = Search:nav("surface_human"),
	surface_t100 = Search:nav("surface_t100")
}
L0_0 = NavigationGraphUtilities
function L0_0.ai_waypoint_path(A0_1, A1_2, A2_3, A3_4)
	local L4_5
	L4_5 = A0_1.ai_data
	L4_5 = L4_5(A0_1)
	assert(L4_5)
	assert(L4_5.graph)
	assert(L4_5.stay_on_ground ~= nil)
	return NavigationGraphUtilities.waypoint_path(A0_1, L4_5.graph, A0_1:position(), A1_2, A2_3, not L4_5.stay_on_ground, A3_4, nil)
end
L0_0 = NavigationGraphUtilities
function L0_0.waypoint_path(A0_6, A1_7, A2_8, A3_9, A4_10, A5_11, A6_12, A7_13)
	local L8_14, L9_15, L10_16, L11_17, L12_18, L13_19, L14_20, L15_21, L16_22
	if A3_9 then
		L8_14 = #A3_9
	elseif L8_14 == 0 then
		L8_14 = nil
		return L8_14
	end
	L8_14 = NavigationGraphUtilities
	L8_14 = L8_14.find_best_waypoint_index
	L9_15 = A2_8
	L10_16 = A3_9
	L8_14 = L8_14(L9_15, L10_16, L11_17)
	L9_15 = {}
	L10_16 = nil
	L14_20 = 0
	L14_20 = A2_8
	L15_21 = 0
	L16_22 = L13_19(L14_20, L15_21)
	if L11_17 < 10 then
		if L11_17 == 1 then
			L14_20 = A2_8
			L15_21 = A3_9[L8_14]
			L15_21 = L15_21.position
			L16_22 = A5_11
			return L11_17(L12_18, L13_19, L14_20, L15_21, L16_22, nil, A6_12, A7_13)
		end
		L10_16 = A3_9[L8_14]
		L8_14 = L8_14 + 1
	else
		L11_17.position = A2_8
		L10_16 = L11_17
	end
	for L14_20 = L8_14, #A3_9 do
		L15_21 = A3_9[L14_20]
		L16_22 = nil
		if L10_16.options and L10_16.options.follow_path and L10_16.options.follow_path == "force_waypoint_path" then
			L16_22 = {
				L10_16.position,
				L15_21.position
			}
		else
			L16_22 = NavigationGraphUtilities.shortest_path(A0_6, A1_7, L10_16.position, L15_21.position, A5_11, nil, A6_12, A7_13)
		end
		if not L16_22 then
			return nil
		end
		L9_15 = ListHelper.concat_lists(L9_15, L16_22)
		L10_16 = L15_21
	end
	if A4_10 then
		if L11_17 > 1 then
			for L14_20 = 1, L8_14 do
				L15_21 = A3_9[L14_20]
				L16_22 = nil
				if L10_16.options and L10_16.options.follow_path and L10_16.options.follow_path == "force_waypoint_path" then
					L16_22 = {
						L10_16.position,
						L15_21.position
					}
				else
					L16_22 = NavigationGraphUtilities.shortest_path(A0_6, A1_7, L10_16.position, L15_21.position, A5_11, nil, A6_12, A7_13)
				end
				if not L16_22 then
					return nil
				end
				L9_15 = ListHelper.concat_lists(L9_15, L16_22)
				L10_16 = L15_21
			end
		end
	end
	if L11_17 == 0 then
		return L11_17
	end
	return L9_15
end
L0_0 = NavigationGraphUtilities
function L0_0.ai_shortest_path(A0_23, A1_24, A2_25)
	local L3_26
	L3_26 = A0_23.ai_data
	L3_26 = L3_26(A0_23)
	assert(L3_26)
	assert(L3_26.graph)
	assert(L3_26.stay_on_ground ~= nil)
	return NavigationGraphUtilities.shortest_path(A0_23, L3_26.graph, A0_23:position(), A1_24, not L3_26.stay_on_ground, L3_26:path(), A2_25, nil)
end
L0_0 = NavigationGraphUtilities
function L0_0.shortest_path(A0_27, A1_28, A2_29, A3_30, A4_31, A5_32, A6_33, A7_34)
	local L8_35, L9_36, L10_37, L11_38, L12_39, L13_40, L14_41
	L8_35 = assert
	L9_36 = A1_28
	L8_35(L9_36)
	L8_35 = assert
	L9_36 = A2_29
	L8_35(L9_36)
	L8_35 = assert
	L9_36 = A3_30
	L8_35(L9_36)
	L8_35 = {}
	L9_36 = A3_30
	if not A4_31 then
		L10_37 = NavigationGraphUtilities
		L10_37 = L10_37.get_on_ground_position
		L11_38 = A3_30
		L10_37 = L10_37(L11_38)
		L9_36 = L10_37
		if L9_36 == nil then
			L10_37 = nil
			return L10_37
		end
	end
	L10_37 = NavigationGraphUtilities
	L10_37 = L10_37._prepare_move_check_data
	L11_38 = A0_27
	L10_37 = L10_37(L11_38)
	L11_38, L12_39 = nil, nil
	if not A6_33 then
		L13_40 = NavigationGraphUtilities
		L13_40 = L13_40.check_can_move_there
		L14_41 = A0_27
		L14_41 = L13_40(L14_41, L10_37, A2_29, L9_36, A4_31, A7_34, nil, true)
		L12_39 = L14_41
		L11_38 = L13_40
		if L11_38 then
			L13_40 = table
			L13_40 = L13_40.insert
			L14_41 = L8_35
			L13_40(L14_41, L9_36)
			return L8_35
		end
	end
	L13_40 = nil
	if A6_33 then
		L14_41 = NavigationGraphUtilities
		L14_41 = L14_41._find_close
		L14_41 = L14_41(A0_27, A1_28, A2_29, A4_31)
		L13_40 = L14_41
	else
		L14_41 = NavigationGraphUtilities
		L14_41 = L14_41.find_best_neighbor
		L14_41 = L14_41(A0_27, A1_28, A2_29, L9_36, A4_31, A7_34)
		L13_40 = L14_41
	end
	if L13_40 == nil then
		L14_41 = nil
		return L14_41
	end
	L14_41 = A1_28.search
	L14_41 = L14_41(A1_28, L13_40, L9_36)
	if #L14_41 == 0 then
		if A5_32 then
			if A0_27:ai_data() and A5_32 == A0_27:ai_data():path() then
				return MovementPathUtilities.remaining_path(A0_27)
			else
				if #A5_32 == 0 then
					return nil
				end
				return A5_32
			end
		end
		if L12_39 == nil then
			return nil
		end
		if A4_31 then
			L9_36 = L12_39
		else
			L9_36 = NavigationGraphUtilities.get_on_ground_position(L12_39)
			if L9_36 == nil then
				return nil
			end
		end
		L14_41 = A1_28:search(L13_40, L9_36)
		if #L14_41 == 0 then
			L9_36 = L13_40
		end
	end
	table.insert(L14_41, L9_36)
	NavigationGraphUtilities.debug_path(A2_29, L14_41)
	if A6_33 then
		return L14_41
	end
	NavigationGraphUtilities.build_shortcut_path(L8_35, A0_27, L14_41, A2_29, A4_31, true, A7_34)
	if #L8_35 == 0 then
		return nil
	end
	return L8_35
end
L0_0 = NavigationGraphUtilities
function L0_0.find_best_neighbor(A0_42, A1_43, A2_44, A3_45, A4_46, A5_47)
	local L6_48, L7_49, L8_50, L9_51, L10_52, L11_53, L12_54, L13_55, L14_56, L15_57, L16_58
	L7_49 = A1_43
	L6_48 = A1_43.find_sphere
	L8_50 = A2_44
	L9_51 = A0_42.oobb
	L9_51 = L9_51(L10_52)
	L9_51 = L9_51.size
	L9_51 = L9_51(L10_52)
	L9_51 = L9_51.y
	L9_51 = 1.5 * L9_51
	L6_48 = L6_48(L7_49, L8_50, L9_51)
	L7_49 = #L6_48
	if L7_49 == 0 then
		L7_49 = NavigationGraphUtilities
		L7_49 = L7_49._find_close
		L8_50 = A0_42
		L9_51 = A1_43
		L7_49 = L7_49(L8_50, L9_51, L10_52, L11_53)
		if not L7_49 then
			L8_50 = Application
			L9_51 = L8_50
			L8_50 = L8_50.error
			L8_50(L9_51, L10_52)
			L8_50 = nil
			return L8_50
		end
		L9_51 = A1_43
		L8_50 = A1_43.neighbors
		L8_50 = L8_50(L9_51, L10_52)
		L6_48 = L8_50
		L8_50 = table
		L8_50 = L8_50.insert
		L9_51 = L6_48
		L8_50(L9_51, L10_52)
	end
	L7_49 = A3_45 - A2_44
	L8_50 = nil
	L9_51 = 9999
	for L13_55, L14_56 in L10_52(L11_53) do
		L15_57 = NavigationGraphUtilities
		L15_57 = L15_57.debug_line
		L16_58 = A2_44
		L15_57(L16_58, L14_56, 2, Color(0, 1, 1))
	end
	for L15_57, L16_58 in L12_54(L13_55) do
		if A1_43:enabled(L16_58) and A1_43:connected(L16_58) then
			if L9_51 > L11_53 and NavigationGraphUtilities.check_can_move_there(A0_42, L10_52, A2_44, L16_58, A4_46, A5_47, nil) then
				L9_51 = L11_53
				L8_50 = L16_58
			end
		end
	end
	return L8_50
end
function L0_0(A0_59, A1_60)
	return math.abs(A0_59.y - A1_60.y) < 300
end
NavigationGraphUtilities._find_close_distances = {
	250,
	500,
	1000
}
function NavigationGraphUtilities._find_close(A0_61, A1_62, A2_63, A3_64)
	local L4_65, L5_66, L6_67, L7_68, L8_69, L9_70, L10_71
	L5_66 = _UPVALUE0_
	if A3_64 then
		L5_66 = nil
	end
	for L9_70, L10_71 in L6_67(L7_68) do
		L4_65 = A1_62:find_close(A2_63, true, A0_61, "radius", L10_71, L5_66)
		if L4_65 then
			return L4_65
		end
	end
	return L6_67
end
function NavigationGraphUtilities.get_on_ground_position(A0_72)
	local L1_73
	L1_73 = managers
	L1_73 = L1_73.slot
	L1_73 = L1_73.get_mask
	L1_73 = L1_73(L1_73, tweak_data.ai.search_graph_util.GROUND_SLOT_MASK)
	if NavigationGraphUtilities.slam_ray(A0_72, L1_73, tweak_data.ai.search_graph_util.SHORTCUT_MAX_HEIGHT_DIFFERENCE, 2000) == nil then
		return nil
	end
	return NavigationGraphUtilities.slam_ray(A0_72, L1_73, tweak_data.ai.search_graph_util.SHORTCUT_MAX_HEIGHT_DIFFERENCE, 2000).position
end
function NavigationGraphUtilities.build_shortcut_path(A0_74, A1_75, A2_76, A3_77, A4_78, A5_79, A6_80)
	local L7_81, L8_82, L9_83
	L7_81 = 0.1
	L8_82 = A3_77
	L9_83 = 0
	while L9_83 < #A2_76 do
		if L9_83 == 0 or L7_81 < mvector3.distance(L8_82, A2_76[L9_83]) then
			if not A5_79 and #A0_74 > 0 then
				L8_82 = A2_76[L9_83]
				table.insert(A0_74, L8_82)
			else
				if not (L9_83 == 0) then
					L8_82 = A2_76[L9_83]
				end
				if NavigationGraphUtilities.reverse_find_shortcut(A1_75, L9_83, L8_82, A2_76, A4_78, A6_80) then
					if not (L9_83 == 0) then
						table.insert(A0_74, L8_82)
					end
					table.insert(A0_74, A2_76[NavigationGraphUtilities.reverse_find_shortcut(A1_75, L9_83, L8_82, A2_76, A4_78, A6_80)])
					L9_83 = NavigationGraphUtilities.reverse_find_shortcut(A1_75, L9_83, L8_82, A2_76, A4_78, A6_80) - 1
				elseif not (L9_83 == 0) then
					table.insert(A0_74, L8_82)
				end
			end
		end
		L9_83 = L9_83 + 1
	end
	if #A0_74 == 0 or L7_81 < mvector3.distance(A0_74[#A0_74], A2_76[#A2_76]) then
		table.insert(A0_74, A2_76[#A2_76])
	end
end
function NavigationGraphUtilities.reverse_find_shortcut(A0_84, A1_85, A2_86, A3_87, A4_88, A5_89)
	local L6_90, L7_91, L8_92, L9_93, L10_94, L11_95, L12_96, L13_97
	L6_90 = #A3_87
	L7_91 = math
	L7_91 = L7_91.sign
	L8_92 = A1_85
	L7_91 = L7_91(L8_92)
	L7_91 = L7_91 - 1
	L6_90 = L6_90 + L7_91
	L7_91 = A1_85 + 2
	L8_92 = NavigationGraphUtilities
	L8_92 = L8_92._prepare_move_check_data
	L8_92 = L8_92(L9_93)
	for L12_96 = L6_90, L7_91, -1 do
		L13_97 = A3_87[L12_96]
		if NavigationGraphUtilities.check_can_move_there(A0_84, L8_92, A2_86, L13_97, A4_88, A5_89, nil, true) then
			return L12_96
		end
	end
	return L9_93
end
NavigationGraphUtilities._move_there_check_counter = 0
function NavigationGraphUtilities.reset_counter()
	local L1_98
	L1_98 = NavigationGraphUtilities
	L1_98._move_there_check_counter = 0
end
function NavigationGraphUtilities.is_nice_to_check_move_there()
	local L0_99, L1_100
	L0_99 = NavigationGraphUtilities
	L0_99 = L0_99._move_there_check_counter
	L0_99 = L0_99 < 4
	return L0_99
end
function NavigationGraphUtilities.ai_check_can_move_there(A0_101, A1_102, A2_103, A3_104, A4_105)
	local L5_106, L6_107
	L6_107 = A0_101
	L5_106 = A0_101.ai_data
	L5_106 = L5_106(L6_107)
	L6_107 = assert
	L6_107(L5_106)
	L6_107 = assert
	L6_107(L5_106.stay_on_ground ~= nil)
	L6_107 = NavigationGraphUtilities
	L6_107 = L6_107._prepare_move_check_data
	L6_107 = L6_107(A0_101)
	return NavigationGraphUtilities.check_can_move_there(A0_101, L6_107, A0_101:position(), A1_102, not L5_106.stay_on_ground, A2_103, A3_104, A4_105)
end
function NavigationGraphUtilities._prepare_move_check_data(A0_108)
	local L1_109
	L1_109 = {}
	if A0_108:ai_data().input.collision_slotmask then
		L1_109.slotmask = A0_108:ai_data().input.collision_slotmask
	else
		L1_109.slotmask = managers.slot:get_mask(tweak_data.ai.search_graph_util.DEFAULT_COLLISION_SLOT_MASK)
	end
	if A0_108:ai_data().input.quick_collision_slotmask then
		L1_109.quick_slotmask = A0_108:ai_data().input.quick_collision_slotmask
	else
		L1_109.quick_slotmask = managers.slot:get_mask(tweak_data.ai.search_graph_util.DEFAULT_QUICK_COLLISION_SLOT_MASK)
	end
	if A0_108:ai_data().radius then
		L1_109.radius = A0_108:ai_data().radius
		if A0_108:ai_data().height then
			L1_109.height = A0_108:ai_data().height
		else
			L1_109.height = 2 * A0_108:ai_data().radius
		end
	elseif A0_108:mover() then
		L1_109.radius = 1.2 * A0_108:mover():radius()
		L1_109.height = A0_108:mover():height() + 2 * A0_108:mover():radius()
	else
		L1_109.radius = A0_108:bounding_sphere_radius()
		L1_109.height = 2 * L1_109.radius
		L1_109.offset = A0_108:oobb():center() - Vector3(0, 0, L1_109.radius) - A0_108:position()
	end
	L1_109.max_slope_angle = A0_108:ai_data().max_slope_angle
	return L1_109
end
function NavigationGraphUtilities.check_can_move_there(A0_110, A1_111, A2_112, A3_113, A4_114, A5_115, A6_116, A7_117)
	local L8_118, L9_119, L10_120, L11_121, L12_122, L13_123, L14_124, L15_125, L16_126, L17_127, L18_128, L19_129
	if A6_116 then
		L9_119 = NavigationGraphUtilities
		L9_119 = L9_119.is_inside_area_restriction
		L10_120 = A2_112
		L11_121 = A3_113
		L12_122 = A6_116
		L9_119 = L9_119(L10_120, L11_121, L12_122)
		if not L9_119 then
			L9_119 = false
			L10_120 = nil
			return L9_119, L10_120
		end
	end
	if A4_114 then
		L8_118 = A3_113
	else
		L9_119 = NavigationGraphUtilities
		L9_119 = L9_119.slam_ray
		L10_120 = A3_113
		L11_121 = A1_111.slotmask
		L12_122 = tweak_data
		L12_122 = L12_122.ai
		L12_122 = L12_122.search_graph_util
		L12_122 = L12_122.SHORTCUT_MAX_HEIGHT_DIFFERENCE
		L13_123 = tweak_data
		L13_123 = L13_123.ai
		L13_123 = L13_123.search_graph_util
		L13_123 = L13_123.SHORTCUT_SLAM_RAY_DEPTH
		L9_119 = L9_119(L10_120, L11_121, L12_122, L13_123)
		if L9_119 then
			L8_118 = L9_119.position
		else
			L8_118 = A3_113
		end
	end
	L9_119 = NavigationGraphUtilities
	L10_120 = NavigationGraphUtilities
	L10_120 = L10_120._move_there_check_counter
	L10_120 = L10_120 + 1
	L9_119._move_there_check_counter = L10_120
	if L8_118 then
		L9_119 = A1_111.slotmask
		L10_120 = A1_111.ray_type
		L11_121 = A1_111.height
		L12_122 = A1_111.radius
		L13_123 = 1.5 * L12_122
		L14_124 = A1_111.offset
		if not L14_124 then
			L14_124 = Vector3
			L15_125 = 0
			L16_126 = 0
			L17_127 = 0
			L14_124 = L14_124(L15_125, L16_126, L17_127)
		end
		L15_125 = mvector3
		L15_125 = L15_125.distance
		L16_126 = A2_112
		L17_127 = L8_118
		L15_125 = L15_125(L16_126, L17_127)
		if L15_125 > 1000 then
			L15_125 = Vector3
			L16_126 = 0
			L17_127 = 0
			L18_128 = 0.5 * L11_121
			L15_125 = L15_125(L16_126, L17_127, L18_128)
			L15_125 = L15_125 + L14_124
			L16_126 = NavigationGraphUtilities
			L16_126 = L16_126.ray_cast
			L17_127 = A0_110
			L18_128 = A2_112 + L15_125
			L19_129 = L8_118 + L15_125
			L16_126 = L16_126(L17_127, L18_128, L19_129, 0, L9_119, L10_120, A5_115)
			if L16_126 ~= nil then
				if A7_117 then
					L17_127 = NavigationGraphUtilities
					L17_127 = L17_127.debug_line
					L18_128 = A2_112 + L15_125
					L19_129 = L8_118 + L15_125
					L17_127(L18_128, L19_129, 5, Color(0.5, 1, 0, 0), L16_126)
				end
				L17_127 = false
				L18_128 = L16_126.position
				L19_129 = L16_126.unit
				return L17_127, L18_128, L19_129
			end
		end
		L15_125 = A1_111.quick_slotmask
		if L15_125 then
			L15_125 = Vector3
			L16_126 = 0
			L17_127 = 0
			L18_128 = 0.5 * L11_121
			L15_125 = L15_125(L16_126, L17_127, L18_128)
			L15_125 = L15_125 + L14_124
			L16_126 = NavigationGraphUtilities
			L16_126 = L16_126.ray_cast
			L17_127 = A0_110
			L18_128 = A2_112 + L15_125
			L19_129 = L8_118 + L15_125
			L16_126 = L16_126(L17_127, L18_128, L19_129, 0, A1_111.quick_slotmask, L10_120, A5_115)
			if L16_126 ~= nil then
				if A7_117 then
					L17_127 = NavigationGraphUtilities
					L17_127 = L17_127.debug_line
					L18_128 = A2_112 + L15_125
					L19_129 = L8_118 + L15_125
					L17_127(L18_128, L19_129, 5, Color(0.5, 1, 0, 0), L16_126)
				end
				L17_127 = false
				L18_128 = L16_126.position
				L19_129 = L16_126.unit
				return L17_127, L18_128, L19_129
			end
		end
		L15_125 = Vector3
		L16_126 = 0
		L17_127 = 0
		L18_128 = L13_123
		L15_125 = L15_125(L16_126, L17_127, L18_128)
		L15_125 = L15_125 + L14_124
		L16_126 = NavigationGraphUtilities
		L16_126 = L16_126.ray_cast
		L17_127 = A0_110
		L18_128 = A2_112 + L15_125
		L19_129 = L8_118 + L15_125
		L16_126 = L16_126(L17_127, L18_128, L19_129, L12_122, L9_119, L10_120, A5_115)
		if L16_126 ~= nil then
			if A7_117 then
				L17_127 = NavigationGraphUtilities
				L17_127 = L17_127.debug_line
				L18_128 = A2_112 + L15_125
				L19_129 = L8_118 + L15_125
				L17_127(L18_128, L19_129, 2 * L12_122, Color(0.5, 1, 0, 0), L16_126)
			end
			L17_127 = false
			L18_128 = L16_126.position
			L19_129 = L16_126.unit
			return L17_127, L18_128, L19_129
		end
		if not A4_114 then
			L17_127 = NavigationGraphUtilities
			L17_127 = L17_127.on_ground
			L18_128 = A2_112
			L19_129 = A3_113
			L18_128 = L17_127(L18_128, L19_129, L12_122, A1_111.max_slope_angle)
			if not L17_127 then
				if A7_117 then
					L19_129 = NavigationGraphUtilities
					L19_129 = L19_129.debug_line
					L19_129(A2_112 + L15_125, L8_118 + L15_125, 2 * L12_122, Color(0.5, 1, 0, 0))
				end
				L19_129 = false
				return L19_129, L18_128, nil
			end
		end
		if A7_117 then
			L17_127 = NavigationGraphUtilities
			L17_127 = L17_127.debug_line
			L18_128 = A2_112 + L15_125
			L19_129 = L8_118 + L15_125
			L17_127(L18_128, L19_129, 2 * L12_122, Color(0.5, 0, 1, 0))
		end
		L17_127 = L11_121 - L12_122
		L18_128 = 1.1 * L13_123
		if L17_127 < L18_128 then
			L18_128 = true
			L19_129 = A3_113
			return L18_128, L19_129
		end
		L18_128 = Vector3
		L19_129 = 0
		L18_128 = L18_128(L19_129, 0, 0.5 * L11_121)
		L18_128 = L18_128 + L14_124
		L19_129 = NavigationGraphUtilities
		L19_129 = L19_129.ray_cast
		L19_129 = L19_129(A0_110, A2_112 + L18_128, L8_118 + L18_128, L12_122, L9_119, L10_120, A5_115)
		if L19_129 == nil then
			NavigationGraphUtilities.debug_line(A2_112 + L18_128, L8_118 + L18_128, 2 * L12_122, Color(0.5, 0, 1, 0))
			return true, A3_113, nil
		end
		NavigationGraphUtilities.debug_line(A2_112 + L18_128, L8_118 + L18_128, 2 * L12_122, Color(0.5, 1, 0, 0), L19_129)
		return false, L19_129.position, L19_129.unit
	end
	L9_119 = false
	L10_120, L11_121 = nil, nil
	return L9_119, L10_120, L11_121
end
function NavigationGraphUtilities.ray_cast(A0_130, A1_131, A2_132, A3_133, A4_134, A5_135, A6_136)
	local L7_137, L8_138
	A5_135 = A5_135 or "low_quality_collision"
	L7_137 = nil
	L8_138 = A0_130 or World
	if A3_133 == 0 then
		if A6_136 then
			L7_137 = L8_138:raycast("ray", A1_131, A2_132, "ray_type", A5_135, "slot_mask", A4_134, "ignore_unit", A6_136)
		else
			L7_137 = L8_138:raycast("ray", A1_131, A2_132, "ray_type", A5_135, "slot_mask", A4_134)
		end
	elseif A6_136 then
		L7_137 = L8_138:raycast("ray", A1_131, A2_132, "sphere_cast_radius", A3_133, "ray_type", A5_135, "slot_mask", A4_134, "ignore_unit", A6_136)
	else
		L7_137 = L8_138:raycast("ray", A1_131, A2_132, "sphere_cast_radius", A3_133, "ray_type", A5_135, "slot_mask", A4_134)
	end
	return L7_137
end
function NavigationGraphUtilities.on_ground(A0_139, A1_140, A2_141, A3_142)
	local L4_143, L5_144, L6_145, L7_146, L8_147, L9_148, L10_149, L11_150, L12_151, L13_152
	L5_144 = tweak_data
	L5_144 = L5_144.ai
	L5_144 = L5_144.search_graph_util
	L5_144 = L5_144.SHORTCUT_HOLE_CHECK_STEP
	L6_145 = math
	L6_145 = L6_145.tan
	L7_146 = A3_142
	L6_145 = L6_145(L7_146)
	L6_145 = L6_145 * L5_144
	L7_146 = A0_139
	L8_147 = L5_144
	L9_148 = managers
	L9_148 = L9_148.slot
	L10_149 = L9_148
	L9_148 = L9_148.get_mask
	L11_150 = tweak_data
	L11_150 = L11_150.ai
	L11_150 = L11_150.search_graph_util
	L11_150 = L11_150.GROUND_SLOT_MASK
	L9_148 = L9_148(L10_149, L11_150)
	L10_149 = Vector3
	L11_150 = 0
	L12_151 = 0
	L13_152 = 0
	L10_149 = L10_149(L11_150, L12_151, L13_152)
	L11_150 = false
	while true do
		L12_151 = mvector3
		L12_151 = L12_151.distance
		L13_152 = L7_146
		L12_151 = L12_151(L13_152, A1_140)
		if L5_144 < L12_151 then
			L12_151 = math
			L12_151 = L12_151.step
			L13_152 = A0_139
			L12_151 = L12_151(L13_152, A1_140, L8_147)
			L7_146 = L12_151
			L12_151 = L7_146 + L10_149
			L13_152 = NavigationGraphUtilities
			L13_152 = L13_152.slam_ray
			L13_152 = L13_152(L12_151, L9_148, 2 * L6_145, 2 * L6_145)
			if L13_152 == nil then
				return false, L4_143
			elseif L6_145 < L13_152.position.z - L12_151.z then
				return false, L4_143
			end
			if L11_150 then
				L13_152 = NavigationGraphUtilities.slam_ray(L7_146 - L10_149, L9_148, tweak_data.ai.search_graph_util.SHORTCUT_MAX_HEIGHT_DIFFERENCE, tweak_data.ai.search_graph_util.SHORTCUT_SLAM_RAY_DEPTH)
				if L13_152 == nil then
					return false, L4_143
				end
			end
			L4_143 = L13_152.position
			L8_147 = L8_147 + L5_144
		end
	end
	L12_151 = true
	L13_152 = L4_143
	return L12_151, L13_152
end
function NavigationGraphUtilities.slam_ray(A0_153, A1_154, A2_155, A3_156)
	assert(A1_154, "slotmask not set")
	return World:raycast("ray", A0_153 + Vector3(0, 0, A2_155), A0_153 + Vector3(0, 0, -A3_156), "slot_mask", A1_154)
end
function NavigationGraphUtilities.is_dynamic_graph(A0_157)
	for 