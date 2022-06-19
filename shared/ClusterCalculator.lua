require("shared/DistanceMatrixCalculator")
if not ClusterCalculator then
	ClusterCalculator = class()
end
ClusterCalculator.init = function(l_1_0)
end

ClusterCalculator.calculate = function(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0._visited_items = {}
	l_2_0._clusters = {}
	l_2_0._current_cluster = 0
	l_2_0._position_function = l_2_2
	l_2_0._max_distance = l_2_3
	l_2_0._distance_matrix = DistanceMatrixCalculator.distance_matrix(l_2_1, function(l_3_0, l_3_1)
		-- upvalues: l_2_0
		local l_3_2, l_3_3 = l_2_0:_distance, l_2_0
		local l_3_4 = l_3_0
		local l_3_5 = l_3_1
		return l_3_2(l_3_3, l_3_4, l_3_5)
  end)
	l_2_0:_recursive_calculate_clusters(l_2_1, true)
end

ClusterCalculator.clusters = function(l_3_0)
	return l_3_0._clusters
end

ClusterCalculator._distance = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = l_4_0._position_function(l_4_1)
	local l_4_4 = l_4_0._position_function(l_4_2)
	local l_4_5, l_4_6 = l_4_4 - l_4_3:length, l_4_4 - l_4_3
	return l_4_5(l_4_6)
end

ClusterCalculator._recursive_calculate_clusters = function(l_5_0, l_5_1, l_5_2)
	local l_5_15, l_5_16 = nil
	for l_5_6 = 1, #l_5_1 do
		local l_5_7 = l_5_1[l_5_6]
		if not l_5_0._visited_items[l_5_7] then
			local l_5_8 = l_5_0:_neighbors(l_5_7)
			if l_5_2 then
				l_5_0._current_cluster = l_5_0._current_cluster + 1
				local l_5_9 = l_5_0._clusters
				local l_5_10 = l_5_0._current_cluster
				l_5_9[l_5_10] = {}
				l_5_9 = l_5_0._clusters
				l_5_10 = l_5_0._current_cluster
				l_5_9 = l_5_9[l_5_10]
				l_5_9.items, l_5_10 = l_5_10, {}
			end
			local l_5_11 = l_5_0._clusters[l_5_0._current_cluster]
			l_5_0._visited_items[l_5_7] = true
			for i_0,i_1 in ipairs(l_5_8) do
				l_5_11.items[i_1] = i_1
			end
			l_5_11.items[l_5_7] = l_5_7
		if #l_5_8 > 0 then
			end
			l_5_0:_recursive_calculate_clusters(l_5_8, false)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ClusterCalculator._neighbors = function(l_6_0, l_6_1)
	local l_6_7, l_6_8, l_6_9, l_6_10, l_6_11 = nil
	local l_6_2 = l_6_0._distance_matrix[l_6_1]
	if not l_6_2 then
		return {}
	end
	local l_6_3 = {}
	for i_0,i_1 in pairs(l_6_2) do
		if i_1 <= l_6_0._max_distance then
			table.insert(l_6_3, i_0)
		end
	end
	return l_6_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ClusterCalculator.calculate_number_of_items = function(l_7_0)
	local l_7_4, l_7_5, l_7_6, l_7_7 = nil
	for i_0,i_1 in ipairs(l_7_0._clusters) do
		for i_0,i_1 in pairs(i_1.items) do
		end
		i_1.number_of_items = 0 + 1
	end
end

ClusterCalculator.calculate_spheres = function(l_8_0)
	local l_8_4, l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_18, l_8_19, l_8_20, l_8_21, l_8_23, l_8_24 = nil
	for i_0,i_1 in ipairs(l_8_0._clusters) do
		i_1.center = Vector3(0, 0, 0)
		i_1.radius = 0
		for i_0,i_1 in pairs(i_1.items) do
			local l_8_16 = 0
			l_8_15.center = l_8_15.center + l_8_0._position_function(i_1)
			l_8_16 = l_8_16 + 1
		end
		local l_8_22 = l_8_15.center.x / (l_8_16)
		l_8_15.center = Vector3(l_8_22, l_8_15.center.y / (l_8_16), l_8_15.center.z / (l_8_16))
		for i_0,i_1 in pairs(l_8_22) do
			do
				if l_8_15.radius < l_8_0._position_function(i_1) - l_8_15.center:length() then
					l_8_15.radius = l_8_0._position_function(i_1) - l_8_15.center:length()
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


