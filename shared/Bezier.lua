if not Bezier then
	Bezier = class()
end
Bezier.init = function(l_1_0, l_1_1, l_1_2)
	local l_1_10, l_1_11 = nil
	l_1_0._current_bezier_point_index = 1
	l_1_0._bezier_curve = {}
	local l_1_3 = 1
	local l_1_4 = {}
	local l_1_5 = {}
	table.insert(l_1_0._bezier_curve, l_1_1[1])
	while l_1_3 < #l_1_1 do
		l_1_4 = l_1_0:_get_next_mainpoints(l_1_3, l_1_1)
		local l_1_9 = l_1_0:_get_bezier_patch_curve
		l_1_9 = l_1_9(l_1_0, l_1_4, l_1_2)
		l_1_5 = l_1_9
		l_1_9 = pairs
		l_1_9 = l_1_9(l_1_5)
		for i_0,i_1 in l_1_9 do
			table.insert(l_1_0._bezier_curve, i_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Bezier.get_curve_points = function(l_2_0)
	return l_2_0._bezier_curve
end

Bezier._get_next_mainpoints = function(l_3_0, l_3_1, l_3_2)
	local l_3_5 = l_3_1 + 3
	if #l_3_2 < l_3_5 then
		l_3_5 = #l_3_2
		local l_3_3, l_3_4 = {}
	end
	for l_3_9 = l_3_1, l_3_5 do
		local l_3_6 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert(l_3_6, l_3_2[R8_PC13])
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_3_6, l_3_5
end

Bezier._get_bezier_patch_curve = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = nil
	if #l_4_1 == 2 then
		l_4_3 = math.linear_bezier
	elseif #l_4_1 == 3 then
		l_4_3 = math.quadratic_bezier
	elseif #l_4_1 == 4 then
		l_4_3 = math.bezier
	end
	if l_4_3 then
		local l_4_4 = {}
		local l_4_5 = 1
		local l_4_6 = nil
		for l_4_10 = 1, l_4_2 do
			local l_4_7 = l_4_3(l_4_1, 0)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_4_6 = 1 / l_4_2 * R11_PC31
			l_4_7 = l_4_3(l_4_1, l_4_6)
			table.insert(l_4_4, l_4_7)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_4_4
end

Bezier.get_next_bezier_point = function(l_5_0)
	local l_5_1 = l_5_0._current_bezier_point_index
	if l_5_0._current_bezier_point_index <= #l_5_0._bezier_curve then
		l_5_0._current_bezier_point_index = l_5_0._current_bezier_point_index + 1
	else
		return nil
	end
	return l_5_0._bezier_curve[l_5_1]
end


