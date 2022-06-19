CommonAiFindCover = CommonAiFindCover or class()
function CommonAiFindCover.init_data(A0_0, A1_1)
	local L2_2
	L2_2 = {}
	A1_1._cover = L2_2
	L2_2 = A1_1._cover
	L2_2.threat = nil
	L2_2 = A1_1._cover
	L2_2.navigation_target = nil
	L2_2 = A1_1._cover
	L2_2.hide = true
	L2_2 = A1_1._cover
	L2_2.cover_info = nil
	L2_2 = A1_1._cover
	L2_2.go_to = nil
end
function CommonAiFindCover.logic_common_find_cover_main(A0_3, A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	assert(A2_5:ai_data().graph)
	A2_5:ai_data().graph:set_max_search_nodes(tweak_data.ai.search_graph_util.FIND_COVER_MAX_SEARCH_GRAPH_NODES)
	A0_3:_do_logic_common_find_cover_main(A1_4, A2_5, A3_6, A4_7, A5_8, A6_9, A7_10)
	A2_5:ai_data().graph:set_max_search_nodes(tweak_data.ai.search_graph_util.DEFAULT_MAX_SEARCH_GRAPH_NODES)
end
function CommonAiFindCover._do_logic_common_find_cover_main(A0_11, A1_12, A2_13, A3_14, A4_15, A5_16, A6_17, A7_18)
	local L8_19, L9_20, L10_21, L11_22, L12_23, L13_24
	L9_20 = A2_13
	L8_19 = A2_13.ai_data
	L8_19 = L8_19(L9_20)
	L9_20 = L8_19._behavior
	L9_20 = L9_20.use_covers
	if L9_20 then
		L9_20 = L8_19._behavior
		L9_20 = L9_20.arrive_orders
		if L9_20 then
			L9_20 = L8_19._behavior
			L9_20 = L9_20.arrive_orders
			L9_20 = L9_20.use_covers
		end
	elseif not L9_20 then
		L9_20 = L8_19._cover
		L9_20.go_to = nil
		L9_20 = L8_19._cover
		L9_20.cover_info = nil
		return
	end
	L9_20, L10_21, L11_22 = nil, nil, nil
	L12_23 = L8_19._cover
	L12_23 = L12_23.navigation_target
	if L12_23 then
		L12_23 = L8_19._behavior
		L12_23 = L12_23.navigation_target_reached
		if not L12_23 then
			L12_23 = L8_19._cover
			L12_23 = L12_23.navigation_target
			L10_21 = L12_23.position
			L12_23 = L8_19._cover
			L12_23 = L12_23.navigation_target_rotation
			L13_24 = L12_23
			L12_23 = L12_23.y
			L12_23 = L12_23(L13_24)
			L12_23 = 10000 * L12_23
			L9_20 = L10_21 + L12_23
			L12_23 = tweak_data
			L12_23 = L12_23.ai
			L12_23 = L12_23.cover
			L11_22 = L12_23.MAX_DISTANCE_TO_SCRIPT_COVER
		end
	else
		L12_23 = L8_19._cover
		L12_23 = L12_23.threat
		if L12_23 then
			L13_24 = A2_13
			L12_23 = A2_13.position
			L12_23 = L12_23(L13_24)
			L10_21 = L12_23
			L12_23 = L8_19._cover
			L12_23 = L12_23.threat
			L13_24 = L12_23
			L12_23 = L12_23.last_known_position
			L12_23 = L12_23(L13_24)
			L9_20 = L12_23
			L12_23 = tweak_data
			L12_23 = L12_23.ai
			L12_23 = L12_23.cover
			L11_22 = L12_23.MAX_DISTANCE_TO_THREAT_COVER
			if not L9_20 then
				L12_23 = L8_19._cover
				L12_23 = L12_23.threat
				L13_24 = L12_23
				L12_23 = L12_23.last_known_direction
				L12_23 = L12_23(L13_24)
				L12_23 = 10000 * L12_23
				L9_20 = L10_21 + L12_23
			end
		end
	end
	if L9_20 then
		L12_23 = L8_19.output
		L12_23 = L12_23.target_cover_info
		if L12_23 then
			L13_24 = mvector3
			L13_24 = L13_24.distance
			L13_24 = L13_24(L12_23:closest_cover_point():position(), L10_21)
			if L11_22 > L13_24 then
				L13_24 = managers
				L13_24 = L13_24.cover
				L13_24 = L13_24.is_cover_from_threat
				L13_24 = L13_24(L13_24, L12_23:cover(), L9_20, tweak_data.ai.cover.MIN_DISTANCE_TO_THREAT, tweak_data.ai.cover.MIN_THREAT_ANGLE)
				if L13_24 then
					L13_24 = L8_19.input
					L13_24 = L13_24.in_target_cover
					if not L13_24 then
						L13_24 = L8_19.input
						L13_24 = L13_24.entering_target_cover
					else
						if L13_24 then
							L13_24 = L8_19._cover
							L13_24.cover_info = L12_23
							L13_24 = L8_19._cover
							L13_24.go_to = nil
							return
					end
					else
						L13_24 = L8_19._cover
						L13_24 = L13_24.cover_info
						if L13_24 == L12_23 then
							L13_24 = L8_19._cover
							L13_24 = L13_24.go_to
						elseif L13_24 == nil then
							L13_24 = L8_19._cover
							L13_24.cover_info = L12_23
							L13_24 = L12_23.closest_cover_point
							L13_24 = L13_24(L12_23)
							L13_24 = L13_24.position
							L13_24 = L13_24(L13_24)
							if NavigationGraphUtilities.ai_shortest_path(A2_13, L13_24, true) then
								L8_19._cover.go_to = L13_24
								return
							else
								L8_19._cover.go_to = nil
							end
						end
					end
				end
			end
		end
		L13_24 = A0_11._find_best_cover
		L13_24 = L13_24(A0_11, A2_13, L10_21, L9_20, L11_22, tweak_data.ai.cover.MIN_DISTANCE_TO_THREAT, tweak_data.ai.cover.MIN_THREAT_ANGLE, not L8_19._cover.hide)
		if L13_24 then
			L8_19._cover.go_to = L13_24.go_to
			L8_19._cover.cover_info = L13_24.cover_info
		else
			L8_19._cover.go_to = nil
			L8_19._cover.cover_info = nil
		end
	end
end
function CommonAiFindCover._find_best_cover(A0_25, A1_26, A2_27, A3_28, A4_29, A5_30, A6_31, A7_32, A8_33)
	local L9_34, L10_35, L11_36, L12_37, L13_38, L14_39, L15_40, L16_41, L17_42, L18_43, L19_44, L20_45, L21_46, L22_47, L23_48, L24_49, L25_50
	L9_34 = 100
	L10_35 = tweak_data
	L10_35 = L10_35.player
	L10_35 = L10_35.cover
	L10_35 = L10_35.DISTANCE_TO
	L11_36 = tweak_data
	L11_36 = L11_36.player
	L11_36 = L11_36.cover
	L11_36 = L11_36.DISTANCE_FROM_EDGE
	L13_38 = A1_26
	L12_37 = A1_26.ai_data
	L12_37 = L12_37(L13_38)
	L13_38 = managers
	L13_38 = L13_38.cover
	L14_39 = L13_38
	L13_38 = L13_38.get_covers_from_threat
	L18_43 = A5_30
	L19_44 = A6_31
	L13_38 = L13_38(L14_39, L15_40, L16_41, L17_42, L18_43, L19_44)
	if not A7_32 then
		L14_39 = {}
		for L18_43, L19_44 in L15_40(L16_41) do
			L20_45 = managers
			L20_45 = L20_45.ai
			L20_45 = L20_45.cover_manager
			L21_46 = L20_45
			L20_45 = L20_45.closest_cover_point
			L22_47 = A1_26
			L23_48 = L19_44
			L24_49 = A2_27
			L25_50 = tweak_data
			L25_50 = L25_50.ai
			L25_50 = L25_50.cover
			L25_50 = L25_50.WIDTH_NEEDED
			L21_46 = L20_45(L21_46, L22_47, L23_48, L24_49, L25_50, L10_35, L11_36)
			if L20_45 then
				L23_48 = L20_45
				L22_47 = L20_45.position
				L22_47 = L22_47(L23_48)
				L23_48 = L22_47 - A2_27
				L24_49 = math
				L24_49 = L24_49.dot
				L25_50 = L23_48
				L24_49 = L24_49(L25_50, L23_48)
				if L9_34 > L24_49 then
					L14_39.squared_distance = L24_49
					L25_50 = CoverInfo
					L25_50 = L25_50.new
					L25_50 = L25_50(L25_50, L19_44, L20_45, L24_49)
					L14_39.cover_info = L25_50
					L14_39.go_to = nil
					return L14_39
				end
				L25_50 = L14_39.cover_info
				if L25_50 then
					L25_50 = L14_39.cover_info
					L25_50 = L25_50.squared_distance_to_cover_position
					L25_50 = L25_50(L25_50)
				elseif L24_49 < L25_50 then
					if not L21_46 then
						L25_50 = L14_39.peek_position
					elseif not L25_50 then
						L25_50 = L20_45.position
						L25_50 = L25_50(L20_45)
						L25_50 = L25_50 + L19_44:normal() * (tweak_data.ai.cover.PATH_DISTANCE_TO_COVER - tweak_data.player.cover.DISTANCE_TO)
						if NavigationGraphUtilities.ai_shortest_path(A1_26, L25_50, true) then
							L14_39.squared_distance = L24_49
							L14_39.cover_info = CoverInfo:new(L19_44, L20_45, L24_49)
							L14_39.go_to = NavigationGraphUtilities.ai_shortest_path(A1_26, L25_50, true)[#NavigationGraphUtilities.ai_shortest_path(A1_26, L25_50, true)]
							L14_39.peek_position = L21_46
						end
					end
				end
			end
		end
		if L15_40 == nil then
			return L15_40
		end
		return L14_39
	end
	L14_39 = nil
	return L14_39
end
