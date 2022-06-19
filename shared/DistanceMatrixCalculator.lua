if not DistanceMatrixCalculator then
	DistanceMatrixCalculator = {}
end
DistanceMatrixCalculator.distance_matrix = function(l_1_0, l_1_1)
	local l_1_2 = #l_1_0
	local l_1_3 = {}
	for l_1_7 = 1, l_1_2 do
		for l_1_11 = l_1_7 + 1, l_1_2 do
			local l_1_12 = l_1_0[l_1_7]
			local l_1_13 = l_1_0[l_1_11]
			local l_1_14 = l_1_1(l_1_12, l_1_13)
			if not l_1_3[l_1_12] then
				l_1_3[l_1_12] = {}
			end
			l_1_3[l_1_12][l_1_13] = l_1_14
			if not l_1_3[l_1_13] then
				l_1_3[l_1_13] = {}
			end
			l_1_3[l_1_13][l_1_12] = l_1_14
		end
	end
	return l_1_3
end


