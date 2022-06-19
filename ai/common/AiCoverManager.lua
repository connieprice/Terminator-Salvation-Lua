if not AiCoverManager then
	AiCoverManager = class()
end
AI_DISTANCE_TO_COVER = tweak_data.player.cover.DISTANCE_TO
AiCoverManager.init = function(l_1_0)
	l_1_0._reserved_world = {}
	l_1_0._reserved_covers = {}
	l_1_0._player_reserved_covers = {}
	l_1_0._all_covers = nil
end

AiCoverManager.reserve_cover = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = {}
	l_2_4.position = l_2_2
	l_2_4.radius = l_2_3
	if l_2_0._reserved_world[l_2_1] then
		l_2_0:_release_cover_space(l_2_1)
	end
	l_2_0._reserved_world[l_2_1] = l_2_4
	l_2_0:_reserve_cover_space(l_2_1, l_2_4)
	l_2_0:_sort_reserved_cover_infos()
end

AiCoverManager.release_cover = function(l_3_0, l_3_1)
	if l_3_0._reserved_world[l_3_1] then
		l_3_0:_release_cover_space(l_3_1)
		l_3_0._reserved_world[l_3_1] = nil
	end
end

AiCoverManager.get_reserved_position = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._reserved_world[l_4_1]
	if l_4_2 then
		return l_4_2.position
	end
	return nil
end

AiCoverManager.anyone_else_at_cover = function(l_5_0, l_5_1, l_5_2)
	local l_5_7, l_5_8 = nil
	local l_5_3 = l_5_0._reserved_covers[l_5_2:key()]
	if not l_5_3 then
		return false
	end
	for i_0,i_1 in pairs(l_5_3) do
		if i_1.unit ~= l_5_1 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiCoverManager.closest_cover_point = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6)
	if not l_6_4 then
		l_6_4 = tweak_data.ai.cover.WIDTH_NEEDED
	end
	if not l_6_5 then
		l_6_5 = tweak_data.player.cover.DISTANCE_TO
	end
	if not l_6_6 then
		l_6_6 = tweak_data.player.cover.DISTANCE_FROM_EDGE
	end
	local l_6_7 = managers.cover_util:high_cover(l_6_2)
	if not l_6_0:anyone_else_at_cover(l_6_1, l_6_2) and not l_6_7 then
		return l_6_2:closest_cover_point(l_6_3, l_6_5, l_6_6), true
	end
	local l_6_8 = l_6_0:_distance_along_cover(l_6_2, l_6_3)
	local l_6_9 = true
	if l_6_7 then
		local l_6_10 = l_6_2:width()
		local l_6_11 = l_6_2:normal()
		local l_6_12 = l_6_2:right()
		local l_6_13 = l_6_2:edge_positions(l_6_5, l_6_6)
		if l_6_8 < 0.5 * l_6_10 then
			if ScriptCoverUtils.can_peek_around_cover_edge(l_6_13.left, l_6_11, l_6_12, "left") then
				l_6_8 = l_6_6
			end
		else
			if ScriptCoverUtils.can_peek_around_cover_edge(l_6_13.right, l_6_11, l_6_12, "right") then
				l_6_8 = l_6_10 - l_6_6
			end
		else
			l_6_9 = false
		end
	else
		if ScriptCoverUtils.can_peek_around_cover_edge(l_6_13.right, l_6_11, l_6_12, "right") then
			l_6_8 = l_6_10 - l_6_6
		end
	else
		if ScriptCoverUtils.can_peek_around_cover_edge(l_6_13.left, l_6_11, l_6_12, "left") then
			l_6_8 = l_6_6
		end
	else
		l_6_9 = false
	end
	local l_6_14 = l_6_0:_find_best_distance_along_cover(l_6_1, l_6_2, l_6_3, l_6_8, l_6_4, l_6_6)
	if not l_6_14 then
		return nil, false
	end
	if l_6_7 and l_6_14 ~= l_6_8 then
		l_6_9 = false
	end
	local l_6_15 = l_6_2:left_edge() + l_6_2:right() * l_6_14
	local l_6_16 = l_6_2:closest_cover_point(l_6_15, l_6_5, l_6_6)
	return l_6_16, l_6_9
end

AiCoverManager._distance_along_cover = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_1:left_edge()
	local l_7_4 = l_7_1:right_edge()
	local l_7_5 = l_7_4 - l_7_3
	local l_7_6 = l_7_2 - l_7_3
	local l_7_7 = math.dot(l_7_5, l_7_5)
	local l_7_8 = math.dot(l_7_6, l_7_5) / l_7_7
	return l_7_1:width() * math.max(0, math.min(l_7_8, 1))
end

AiCoverManager.update = function(l_8_0, l_8_1, l_8_2)
	local l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14 = nil
	local l_8_3 = managers.player:players()
	for i_0,i_1 in pairs(l_8_3) do
		if managers.player:is_human_player(i_1) then
			local l_8_17 = l_8_0:get_reserved_position(i_1)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if i_1:player_data().cover_point then
				local l_8_18 = nil
			if not l_8_17 or 0.1 * tweak_data.ai.humans.human_player.RESERVE_COVER_WIDTH < l_8_17 - i_1:player_data().cover_point:position():length() then
				end
				l_8_0:reserve_cover(l_8_16, i_1:player_data().cover_point:position(), 0.5 * tweak_data.ai.humans.human_player.RESERVE_COVER_WIDTH)
			end
		elseif l_8_17 then
			l_8_0:release_cover(l_8_16)
		end
	end
	l_8_0:_debug_draw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiCoverManager._reserve_cover_space = function(l_9_0, l_9_1, l_9_2)
	local l_9_3, l_9_4, l_9_5, l_9_6, l_9_7, l_9_8 = nil, nil, nil, nil, nil, nil
	if Application:editor() then
		do return end
	end
	if not l_9_0._all_covers then
		for i_0,i_1 in pairs(l_9_0._all_covers) do
			if l_9_4 > 0 and l_9_4 < l_9_2.radius + AI_DISTANCE_TO_COVER and l_9_5 + l_9_2.radius > 0 and l_9_5 - l_9_2.radius < i_1:width() then
				if managers.player:is_human_player(l_9_1) then
					if not l_9_0._player_reserved_covers[l_9_8] then
						l_9_0._player_reserved_covers[l_9_8] = {}
					end
					l_9_7 = l_9_0._player_reserved_covers[l_9_8]
				else
					if not l_9_0._reserved_covers[l_9_8] then
						l_9_0._reserved_covers[l_9_8] = {}
					end
					l_9_7 = l_9_0._reserved_covers[l_9_8]
				end
				table.insert(l_9_7, l_9_6)
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 24 
end

AiCoverManager._sort_reserved_cover_infos = function(l_10_0)
	local l_10_4, l_10_5, l_10_6, l_10_7 = nil
	for i_0,i_1 in pairs(l_10_0._reserved_covers) do
		table.sort(i_1, function(l_11_0, l_11_1)
			return l_11_0.left < l_11_1.left
    end)
	end
end

AiCoverManager._release_cover_space = function(l_11_0, l_11_1)
	local l_11_6, l_11_7, l_11_8, l_11_9, l_11_10, l_11_11, l_11_12 = nil
	local l_11_2 = iff(managers.player:is_human_player(l_11_1), l_11_0._player_reserved_covers, l_11_0._reserved_covers)
	for i_0,i_1 in pairs(l_11_2) do
		TableAlgorithms.indexed_remove_if(i_1, function(l_12_0)
			-- upvalues: l_11_1
			return l_12_0.unit == l_11_1
    end)
		if #i_1 == 0 then
			l_11_2[i_0] = nil
		end
	end
end

AiCoverManager._find_best_distance_along_cover = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4, l_12_5, l_12_6)
	local l_12_15, l_12_16, l_12_17, l_12_18, l_12_19, l_12_20 = nil
	local l_12_7 = l_12_0._reserved_covers[l_12_2:key()]
	if not l_12_7 then
		return l_12_4
	end
	local l_12_8 = nil
	local l_12_9 = false
	local l_12_10 = l_12_6 - 0.5 * l_12_5
	local l_12_11 = nil
	for i_0,i_1 in ipairs(l_12_7) do
		if i_1.unit ~= l_12_1 then
			l_12_11 = i_1.left
			l_12_9 = l_12_0:_try_hole(l_12_8, l_12_10, l_12_11, l_12_4, l_12_5)
			if l_12_9 then
				return l_12_8
			end
			l_12_10 = i_1.right
		end
	end
	if not l_12_11 then
		return l_12_4
	end
	l_12_11 = l_12_2:width() - (l_12_6 - 0.5 * l_12_5)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_12_9 = l_12_0:_try_hole(l_12_8, l_12_10, l_12_11, l_12_4, l_12_5)
	return l_12_8
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiCoverManager._try_hole = function(l_13_0, l_13_1, l_13_2, l_13_3, l_13_4, l_13_5)
	do
		if l_13_5 <= l_13_3 - l_13_2 then
			local l_13_6 = 0.5 * l_13_5
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_13_4 < l_13_2 and (not l_13_1 or l_13_2 + l_13_6 - l_13_4 < l_13_1) then
			end
			l_13_1 = l_13_2 + l_13_6
		end
	end
	return false, l_13_1
end

AiCoverManager._overlaps = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_9, l_14_10, l_14_11, l_14_12 = nil
	local l_14_4 = l_14_3 - 0.5 * l_14_2
	local l_14_5 = l_14_3 + 0.5 * l_14_2
	for i_0,i_1 in ipairs(l_14_1) do
		if l_14_5 >= i_1.left and i_1.right >= l_14_4 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiCoverManager.reserved_overlaps_human_player = function(l_15_0, l_15_1)
	local l_15_5, l_15_6, l_15_7, l_15_8, l_15_12, l_15_13, l_15_14, l_15_15, l_15_16, l_15_17, l_15_18, l_15_19, l_15_20, l_15_21, l_15_22, l_15_23, l_15_24, l_15_25 = nil
	for i_0,i_1 in pairs(l_15_0._reserved_covers) do
		for i_0,i_1 in pairs(i_1) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if i_1.unit == l_15_1 and l_15_0._player_reserved_covers[i_1.cover:key()] and l_15_0:_overlaps(l_15_0._player_reserved_covers[i_1.cover:key()], i_1.right - i_1.left, (i_1.left + i_1.right) / 2) then
				return true
			end
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiCoverManager.overlaps_human_player = function(l_16_0, l_16_1, l_16_2, l_16_3)
	local l_16_4 = l_16_0._player_reserved_covers[l_16_1:key()]
	if not l_16_4 then
		return false
	end
	if not l_16_3 then
		l_16_3 = tweak_data.ai.cover.WIDTH_NEEDED
	end
	local l_16_5 = l_16_0:_distance_along_cover(l_16_1, l_16_2)
	local l_16_6, l_16_7 = l_16_0:_overlaps, l_16_0
	local l_16_8 = l_16_4
	local l_16_9 = l_16_3
	local l_16_10 = l_16_5
	return l_16_6(l_16_7, l_16_8, l_16_9, l_16_10)
end

AiCoverManager.is_cover_reserved = function(l_17_0, l_17_1, l_17_2, l_17_3)
	local l_17_4 = l_17_0._player_reserved_covers[l_17_1:key()]
	local l_17_5 = l_17_0._reserved_covers[l_17_1:key()]
	if not l_17_4 and not l_17_5 then
		return false
	end
	if not l_17_3 then
		l_17_3 = tweak_data.ai.cover.WIDTH_NEEDED
	end
	local l_17_6 = l_17_0:_distance_along_cover(l_17_1, l_17_2)
	if l_17_4 and l_17_0:_overlaps(l_17_4, l_17_3, l_17_6) then
		return true
	end
	do
		if l_17_5 then
			return l_17_0:_overlaps(l_17_5, l_17_3, l_17_6)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

AiCoverManager._debug_draw = function(l_18_0)
	local l_18_6, l_18_7, l_18_8, l_18_9, l_18_10, l_18_11, l_18_12, l_18_13, l_18_14, l_18_15, l_18_16, l_18_17, l_18_18, l_18_19, l_18_20, l_18_25, l_18_27 = nil
	if Global.category_debug_render["ai.cover"] then
		local l_18_1 = Draw:pen()
		local l_18_2 = Draw:brush()
		for i_0,i_1 in pairs(l_18_0._reserved_world) do
			l_18_1:sphere(i_1.position, i_1.radius)
			l_18_2:line(i_0:position(), i_1.position)
		end
		for i_0,i_1 in pairs(l_18_0._reserved_covers) do
			for i_0,i_1 in pairs(i_1) do
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_18_2:quad(i_1.cover:left_edge() + i_1.cover:right() * i_1.left + i_1.cover:normal(), i_1.cover:left_edge() + i_1.cover:right() * i_1.left + i_1.cover:normal() + Vector3(0, 0, i_1.cover:height()), i_1.cover:left_edge() + i_1.cover:right() * i_1.right + i_1.cover:normal() + Vector3(0, 0, i_1.cover:height()), i_1.cover:left_edge() + i_1.cover:right() * i_1.right + i_1.cover:normal())
			end
		end
		local l_18_32, l_18_33, l_18_37, l_18_38 = .end
		l_18_2:set_color(Color(1, 0, 0), l_18_32, l_18_33, l_18_37, l_18_38)
		for l_18_32,l_18_33 in pairs(l_18_0._player_reserved_covers) do
			l_18_37 = pairs
			l_18_38 = l_18_33
			l_18_37 = l_18_37(l_18_38)
			for i_0,i_1 in l_18_37 do
				local l_18_39 = l_18_36.cover
				local l_18_40 = Vector3(0, 0, l_18_39:height())
				local l_18_41 = l_18_39:left_edge() + l_18_39:right() * l_18_36.left + l_18_39:normal()
				local l_18_42 = l_18_39:left_edge() + l_18_39:right() * l_18_36.right + l_18_39:normal()
				l_18_2:quad(l_18_41, l_18_41 + l_18_40, l_18_42 + l_18_40, l_18_42)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


