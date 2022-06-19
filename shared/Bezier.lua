Bezier = Bezier or class()
function Bezier.init(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10
	A0_0._current_bezier_point_index = 1
	L3_3 = {}
	A0_0._bezier_curve = L3_3
	L3_3 = 1
	L4_4 = {}
	L5_5 = {}
	L6_6(L7_7, L8_8)
	while true do
		if L3_3 < L6_6 then
			L9_9 = A1_1
			L3_3 = L7_7
			L4_4 = L6_6
			L9_9 = A2_2
			L5_5 = L6_6
			for L9_9, L10_10 in L6_6(L7_7) do
				table.insert(A0_0._bezier_curve, L10_10)
			end
		end
	end
end
function Bezier.get_curve_points(A0_11)
	local L1_12
	L1_12 = A0_11._bezier_curve
	return L1_12
end
function Bezier._get_next_mainpoints(A0_13, A1_14, A2_15)
	local L3_16, L4_17, L6_18, L7_19
	L3_16 = A1_14 + 3
	L4_17 = {}
	if L3_16 > L6_18 then
		L3_16 = #A2_15
	end
	for _FORV_8_ = A1_14, L3_16 do
		table.insert(L4_17, A2_15[_FORV_8_])
	end
	return L6_18, L7_19
end
function Bezier._get_bezier_patch_curve(A0_20, A1_21, A2_22)
	local L3_23, L4_24, L5_25, L6_26, L7_27
	L4_24 = {}
	L5_25 = #A1_21
	if L5_25 == 2 then
		L5_25 = math
		L3_23 = L5_25.linear_bezier
	else
		L5_25 = #A1_21
		if L5_25 == 3 then
			L5_25 = math
			L3_23 = L5_25.quadratic_bezier
		else
			L5_25 = #A1_21
			if L5_25 == 4 then
				L5_25 = math
				L3_23 = L5_25.bezier
			end
		end
	end
	if L3_23 then
		L5_25 = 1
		L6_26 = 0
		L7_27 = L3_23
		L7_27 = L7_27(A1_21, L6_26)
		for _FORV_11_ = 1, A2_22 do
			L6_26 = 1 / A2_22 * _FORV_11_
			L7_27 = L3_23(A1_21, L6_26)
			table.insert(L4_24, L7_27)
		end
	end
	return L4_24
end
function Bezier.get_next_bezier_point(A0_28)
	local L2_29, L3_30
	L2_29 = A0_28._current_bezier_point_index
	L3_30 = A0_28._current_bezier_point_index
	if L3_30 <= #A0_28._bezier_curve then
		L3_30 = A0_28._current_bezier_point_index
		L3_30 = L3_30 + 1
		A0_28._current_bezier_point_index = L3_30
	else
		L3_30 = nil
		return L3_30
	end
	L3_30 = A0_28._bezier_curve
	L3_30 = L3_30[L2_29]
	return L3_30
end
