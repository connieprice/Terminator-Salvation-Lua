require("shared/DistanceMatrixCalculator")
ClusterCalculator = ClusterCalculator or class()
function ClusterCalculator.init(A0_0)
	local L1_1
end
function ClusterCalculator.calculate(A0_2, A1_3, A2_4, A3_5)
	A0_2._visited_items = {}
	A0_2._clusters = {}
	A0_2._current_cluster = 0
	A0_2._position_function = A2_4
	A0_2._max_distance = A3_5
	A0_2._distance_matrix = DistanceMatrixCalculator.distance_matrix(A1_3, function(A0_6, A1_7)
		return _UPVALUE0_:_distance(A0_6, A1_7)
	end)
	A0_2:_recursive_calculate_clusters(A1_3, true)
end
function ClusterCalculator.clusters(A0_8)
	local L1_9
	L1_9 = A0_8._clusters
	return L1_9
end
function ClusterCalculator._distance(A0_10, A1_11, A2_12)
	return (A0_10._position_function(A2_12) - A0_10._position_function(A1_11)):length()
end
function ClusterCalculator._recursive_calculate_clusters(A0_13, A1_14, A2_15)
	local L3_16, L4_17, L5_18, L6_19, L7_20, L8_21
	for L6_19 = 1, #A1_14 do
		L7_20 = A1_14[L6_19]
		L8_21 = A0_13._visited_items
		L8_21 = L8_21[L7_20]
		if not L8_21 then
			L8_21 = A0_13._neighbors
			L8_21 = L8_21(A0_13, L7_20)
			if A2_15 then
				A0_13._current_cluster = A0_13._current_cluster + 1
				A0_13._clusters[A0_13._current_cluster] = {}
				A0_13._clusters[A0_13._current_cluster].items = {}
			end
			A0_13._visited_items[L7_20] = true
			for 