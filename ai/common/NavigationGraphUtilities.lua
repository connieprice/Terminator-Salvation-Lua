require("shared/SharedMath")
if not NavigationGraphUtilities then
	NavigationGraphUtilities = {}
end
local l_0_0 = NavigationGraphUtilities
if not NavigationGraphUtilities._dynamic_aigraphs then
	local l_0_1, l_0_2 = {}
	l_0_2 = Search
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_0_1.surface_human = l_0_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_0_1.surface_t100 = l_0_2
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0._dynamic_aigraphs = l_0_1
l_0_0 = NavigationGraphUtilities
l_0_0.ai_waypoint_path = function(l_1_0, l_1_1, l_1_2, l_1_3)
	local l_1_4 = l_1_0:ai_data()
	assert(l_1_4)
	assert(l_1_4.graph)
	local l_1_5 = assert
	l_1_5(l_1_4.stay_on_ground ~= nil)
	l_1_5 = NavigationGraphUtilities
	l_1_5 = l_1_5.waypoint_path
	local l_1_8 = l_1_0
	local l_1_9 = l_1_4.graph
	local l_1_10 = l_1_0:position()
	local l_1_11 = l_1_1
	local l_1_12 = l_1_2
	local l_1_13 = not l_1_4.stay_on_ground
	local l_1_14 = l_1_3
	local l_1_15 = nil
	return l_1_5(l_1_8, l_1_9, l_1_10, l_1_11, l_1_12, l_1_13, l_1_14, l_1_15)
end

l_0_0 = NavigationGraphUtilities
l_0_0.waypoint_path = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	if not l_2_3 or #l_2_3 == 0 then
		return nil
	end
	local l_2_8 = NavigationGraphUtilities.find_best_waypoint_index(l_2_2, l_2_3, l_2_4)
	local l_2_9 = {}
	local l_2_10 = nil
	do
		local l_2_20, l_2_21, l_2_22, l_2_23, l_2_24, l_2_25 = mvector3.distance, l_2_3[l_2_8].position:with_z(0), l_2_2:with_z(0), .end
		l_2_20 = l_2_20(l_2_21, l_2_22, l_2_23, l_2_24, l_2_25)
		if l_2_20 < 10 then
			l_2_20 = #l_2_3
			if l_2_20 == 1 then
				l_2_20 = NavigationGraphUtilities
				l_2_20 = l_2_20.shortest_path
				local l_2_11 = nil
				l_2_21 = l_2_0
				local l_2_12 = nil
				l_2_22 = l_2_1
				local l_2_13 = nil
				l_2_23 = l_2_2
				local l_2_14 = nil
				l_2_24 = l_2_3[l_2_8]
				l_2_24 = l_2_24.position
				local l_2_15 = nil
				l_2_25 = l_2_5
				local l_2_16 = nil
				l_2_11 = nil
				local l_2_17 = nil
				l_2_12 = l_2_6
				local l_2_18 = nil
				l_2_13 = l_2_7
				local l_2_19 = nil
				return l_2_20(l_2_21, l_2_22, l_2_23, l_2_24, l_2_25, l_2_11, l_2_12, l_2_13)
			end
			l_2_10 = l_2_3[l_2_8]
			l_2_8 = l_2_8 + 1
		else
			l_2_10, l_2_20 = l_2_20, {position = l_2_2}
		end
		l_2_20 = l_2_8
		l_2_21 = #l_2_3
		l_2_22 = 1
		for l_2_23 = l_2_20, l_2_21, l_2_22 do
			l_2_24 = l_2_3[l_2_23]
			l_2_25 = nil
			if l_2_10.options and l_2_10.options.follow_path and l_2_10.options.follow_path == "force_waypoint_path" then
				l_2_25 = {l_2_10.position, l_2_24.position}
			else
				l_2_25 = NavigationGraphUtilities.shortest_path(l_2_0, l_2_1, l_2_10.position, l_2_24.position, l_2_5, nil, l_2_6, l_2_7)
			end
			if not l_2_25 then
				return nil
			end
			l_2_9 = ListHelper.concat_lists(l_2_9, l_2_25)
			l_2_10 = l_2_24
		end
		if l_2_4 and #l_2_3 > 1 then
			for i = 1, l_2_8 do
				l_2_24 = l_2_3[i]
				l_2_25 = nil
				if l_2_10.options and l_2_10.options.follow_path and l_2_10.options.follow_path == "force_waypoint_path" then
					l_2_25 = {l_2_10.position, l_2_24.position}
				else
					l_2_25 = NavigationGraphUtilities.shortest_path(l_2_0, l_2_1, l_2_10.position, l_2_24.position, l_2_5, nil, l_2_6, l_2_7)
				end
				if not l_2_25 then
					return nil
				end
				l_2_9 = ListHelper.concat_lists(l_2_9, l_2_25)
				l_2_10 = l_2_24
			end
		end
		if #l_2_9 == 0 then
			return nil
		end
		return l_2_9
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = NavigationGraphUtilities
l_0_0.ai_shortest_path = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_0:ai_data()
	assert(l_3_3)
	assert(l_3_3.graph)
	local l_3_4 = assert
	l_3_4(l_3_3.stay_on_ground ~= nil)
	l_3_4 = NavigationGraphUtilities
	l_3_4 = l_3_4.shortest_path
	local l_3_7 = l_3_0
	local l_3_8 = l_3_3.graph
	local l_3_9 = l_3_0:position()
	local l_3_10 = l_3_1
	local l_3_11 = not l_3_3.stay_on_ground
	local l_3_12 = l_3_3:path()
	local l_3_13 = l_3_2
	local l_3_14 = nil
	return l_3_4(l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14)
end

l_0_0 = NavigationGraphUtilities
l_0_0.shortest_path = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5, l_4_6, l_4_7)
	local l_4_22 = nil
	assert(l_4_1)
	assert(l_4_2)
	assert(l_4_3)
	local l_4_8 = {}
	local l_4_9 = l_4_3
	if not l_4_4 then
		l_4_9 = NavigationGraphUtilities.get_on_ground_position(l_4_3)
	if l_4_9 == nil then
		end
		return nil
	end
	local l_4_10 = (NavigationGraphUtilities._prepare_move_check_data(l_4_0))
	local l_4_11, l_4_12 = nil, nil
	if not l_4_6 then
		local l_4_21 = NavigationGraphUtilities.check_can_move_there
		l_4_21 = l_4_21(l_4_0, l_4_10, l_4_2, l_4_9, l_4_4, l_4_7, nil, true)
		l_4_12 = 
		l_4_11 = l_4_21
	if l_4_11 then
		end
		l_4_21 = table
		l_4_21 = l_4_21.insert
		l_4_21(l_4_8, l_4_9)
		return l_4_8
	end
	local l_4_13 = nil
	if l_4_6 then
		l_4_13 = NavigationGraphUtilities._find_close(l_4_0, l_4_1, l_4_2, l_4_4)
	else
		local l_4_18 = NavigationGraphUtilities.find_best_neighbor
		local l_4_19 = l_4_0
		local l_4_20 = l_4_1
		l_4_18 = l_4_18(l_4_19, l_4_20, l_4_2, l_4_9, l_4_4, l_4_7)
		l_4_13 = l_4_18
	end
	if l_4_13 == nil then
		return nil
	end
	local l_4_17 = l_4_1:search
	l_4_17 = l_4_17(l_4_1, l_4_13, l_4_9)
	local l_4_14 = nil
	l_4_14 = #l_4_17
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_14 == 0 then
		if l_4_5 then
			if l_4_14 and l_4_5 == l_4_14 then
				local l_4_15 = nil
				l_4_15 = l_4_0
				local l_4_16 = nil
				return l_4_14(l_4_15)
			end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		elseif l_4_14 == 0 then
			return l_4_14
		end
		return l_4_5
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_4_12 == nil then
			return l_4_14
		end
		if l_4_4 then
			l_4_9 = l_4_12
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			l_4_9 = l_4_14
			 -- DECOMPILER ERROR: Overwrote pending register.

		if l_4_9 == nil then
			end
			return l_4_14
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_17 = l_4_14
		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_14 == 0 then
		end
		l_4_9 = l_4_13
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_14(l_4_17, l_4_9)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_14(l_4_2, l_4_17)
	if l_4_6 then
		return l_4_17
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_14(l_4_8, l_4_0, l_4_17, l_4_2, l_4_4, true, l_4_7)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_4_14 == 0 then
		return l_4_14
	end
	return l_4_8
end

l_0_0 = NavigationGraphUtilities
l_0_0.find_best_neighbor = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5)
	local l_5_14, l_5_15, l_5_16, l_5_17 = nil
	local l_5_6 = l_5_1:find_sphere(l_5_2, 1.5 * l_5_0:oobb():size().y)
	if #l_5_6 == 0 then
		local l_5_7 = NavigationGraphUtilities._find_close(l_5_0, l_5_1, l_5_2, l_5_4)
		if not l_5_7 then
			Application:error("Pathfinding for unit '" .. l_5_0:name() .. "' couldn't find visible navigation graph node.")
			return nil
		end
		l_5_6 = l_5_1:neighbors(l_5_7)
		table.insert(l_5_6, l_5_7)
	end
	local l_5_8 = l_5_3 - l_5_2
	local l_5_9 = nil
	local l_5_10 = 9999
	for i_0,i_1 in pairs(l_5_6) do
		local l_5_24, l_5_26, l_5_28 = NavigationGraphUtilities.debug_line
		l_5_26 = l_5_2
		local l_5_21, l_5_23, l_5_25, l_5_27, l_5_29 = nil
		l_5_28 = l_5_22
		l_5_21 = 2
		l_5_23 = Color
		l_5_25 = 0
		l_5_27 = 1
		l_5_29 = 1
		l_5_25, l_5_23 = .end, l_5_23(l_5_25, l_5_27, l_5_29)
		l_5_24(l_5_26, l_5_28, l_5_21, l_5_23, l_5_25, l_5_27, l_5_29)
	end
	for i_0,i_1 in pairs(l_5_6) do
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_5_1:enabled(i_1) and l_5_1:connected(i_1) and nil < l_5_10 and NavigationGraphUtilities.check_can_move_there(l_5_0, (NavigationGraphUtilities._prepare_move_check_data(l_5_0)), l_5_2, i_1, l_5_4, l_5_5, nil) then
			l_5_10 = nil
			l_5_9 = i_1
		end
	end
	return l_5_9
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = function(l_6_0, l_6_1)
	return math.abs(l_6_0.y - l_6_1.y) < 300
end

local l_0_3 = NavigationGraphUtilities
do
	local l_0_4 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

end
 -- WARNING: undefined locals caused missing assignments!

