if not CommonAiFindCover then
	CommonAiFindCover = class()
end
CommonAiFindCover.init_data = function(l_1_0, l_1_1)
	l_1_1._cover = {}
	l_1_1._cover.threat = nil
	l_1_1._cover.navigation_target = nil
	l_1_1._cover.hide = true
	l_1_1._cover.cover_info = nil
	l_1_1._cover.go_to = nil
end

CommonAiFindCover.logic_common_find_cover_main = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = l_2_2:ai_data()
	assert(l_2_8.graph)
	l_2_8.graph:set_max_search_nodes(tweak_data.ai.search_graph_util.FIND_COVER_MAX_SEARCH_GRAPH_NODES)
	l_2_0:_do_logic_common_find_cover_main(l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	l_2_8.graph:set_max_search_nodes(tweak_data.ai.search_graph_util.DEFAULT_MAX_SEARCH_GRAPH_NODES)
end

CommonAiFindCover._do_logic_common_find_cover_main = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	local l_3_8 = l_3_2:ai_data()
	if not l_3_8._behavior.use_covers or l_3_8._behavior.arrive_orders and not l_3_8._behavior.arrive_orders.use_covers then
		l_3_8._cover.go_to = nil
		l_3_8._cover.cover_info = nil
		return 
	end
	local l_3_9, l_3_10, l_3_11 = nil, nil, nil
	if l_3_8._cover.navigation_target and not l_3_8._behavior.navigation_target_reached then
		l_3_10 = l_3_8._cover.navigation_target.position
		l_3_9 = l_3_10 + 10000 * l_3_8._cover.navigation_target_rotation:y()
		l_3_11 = tweak_data.ai.cover.MAX_DISTANCE_TO_SCRIPT_COVER
	else
		if l_3_8._cover.threat then
			l_3_10 = l_3_2:position()
			l_3_9 = l_3_8._cover.threat:last_known_position()
			l_3_11 = tweak_data.ai.cover.MAX_DISTANCE_TO_THREAT_COVER
		if not l_3_9 then
			end
			l_3_9 = l_3_10 + 10000 * l_3_8._cover.threat:last_known_direction()
		end
	end
	if l_3_9 then
		local l_3_12 = l_3_8.output.target_cover_info
		if l_3_12 and mvector3.distance(l_3_12:closest_cover_point():position(), l_3_10) < l_3_11 and managers.cover:is_cover_from_threat(l_3_12:cover(), l_3_9, tweak_data.ai.cover.MIN_DISTANCE_TO_THREAT, tweak_data.ai.cover.MIN_THREAT_ANGLE) then
			if l_3_8.input.in_target_cover or l_3_8.input.entering_target_cover then
				l_3_8._cover.cover_info = l_3_12
				l_3_8._cover.go_to = nil
				return 
			end
		else
			if l_3_8._cover.cover_info ~= l_3_12 or l_3_8._cover.go_to == nil then
				l_3_8._cover.cover_info = l_3_12
				local l_3_13 = l_3_12:closest_cover_point():position()
				if NavigationGraphUtilities.ai_shortest_path(l_3_2, l_3_13, true) then
					l_3_8._cover.go_to = l_3_13
					return 
				end
			end
		else
			l_3_8._cover.go_to = nil
		end
		local l_3_14 = l_3_0:_find_best_cover(l_3_2, l_3_10, l_3_9, l_3_11, tweak_data.ai.cover.MIN_DISTANCE_TO_THREAT, tweak_data.ai.cover.MIN_THREAT_ANGLE, not l_3_8._cover.hide)
		if l_3_14 then
			l_3_8._cover.go_to = l_3_14.go_to
			l_3_8._cover.cover_info = l_3_14.cover_info
		end
	else
		l_3_8._cover.go_to = nil
		l_3_8._cover.cover_info = nil
	end
end

CommonAiFindCover._find_best_cover = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7, l_4_8)
	local l_4_9 = 100
	local l_4_10 = tweak_data.player.cover.DISTANCE_TO
	local l_4_11 = tweak_data.player.cover.DISTANCE_FROM_EDGE
	local l_4_12 = l_4_1:ai_data()
	local l_4_18 = managers.cover:get_covers_from_threat
	local l_4_19 = managers.cover
	l_4_18 = l_4_18(l_4_19, l_4_2, l_4_4, l_4_3, l_4_5, l_4_6)
	local l_4_13 = nil
	if not l_4_7 then
		local l_4_14 = nil
		l_4_13 = ipairs
		l_4_14 = l_4_18
		l_4_13 = l_4_13(l_4_14)
		for i_0,i_1 in l_4_13 do
			local l_4_20, l_4_21 = managers.ai.cover_manager:closest_cover_point(l_4_1, l_4_17, l_4_2, tweak_data.ai.cover.WIDTH_NEEDED, l_4_10, l_4_11)
			if l_4_20 then
				local l_4_22 = l_4_20:position()
				local l_4_23 = l_4_22 - l_4_2
				local l_4_24 = math.dot(l_4_23, l_4_23)
				if l_4_24 < l_4_9 then
					return l_4_19
					l_4_19 = {squared_distance = l_4_24, cover_info = CoverInfo:new(l_4_17, l_4_20, l_4_24), go_to = nil}
				end
			if (not l_4_19.cover_info or l_4_24 < l_4_19.cover_info:squared_distance_to_cover_position()) and (l_4_21 or not l_4_19.peek_position) then
				end
				local l_4_25 = l_4_20:position() + l_4_17:normal() * (tweak_data.ai.cover.PATH_DISTANCE_TO_COVER - tweak_data.player.cover.DISTANCE_TO)
				local l_4_26 = NavigationGraphUtilities.ai_shortest_path(l_4_1, l_4_25, true)
			if l_4_26 then
				end
				l_4_19.squared_distance = l_4_24
				l_4_19.cover_info = CoverInfo:new(l_4_17, l_4_20, l_4_24)
				l_4_19.go_to = l_4_26[#l_4_26]
				l_4_19.peek_position = l_4_21
			end
		end
		if l_4_19.cover_info == nil then
			return nil
		end
		return l_4_19
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_4_19 = nil
	return l_4_19
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


