if not SharedMath then
	SharedMath = class()
end
SharedMath.sign = function(l_1_0, l_1_1)
	if l_1_1 < 0 then
		return -1
	elseif l_1_1 > 0 then
		return 1
	end
	return 0
end

SharedMath.intersect_ray_sphere = function(l_2_0, l_2_1, l_2_2, l_2_3)
	local l_2_4 = l_2_2 - l_2_0
	local l_2_5 = l_2_3 - l_2_2
	local l_2_6 = l_2_5:dot(l_2_5)
	if l_2_6 == 0 then
		return 
	end
	local l_2_7 = 2 * l_2_4:dot(l_2_5)
	local l_2_8 = l_2_4:dot(l_2_4) - l_2_1 * l_2_1
	local l_2_9 = -l_2_7 / (2 * l_2_6)
	local l_2_10 = l_2_7 * l_2_7 - 4 * l_2_6 * l_2_8
	if l_2_10 < 0 then
		return 
	end
	local l_2_11 = math.sqrt(l_2_10) / (2 * l_2_6)
	local l_2_12, l_2_13 = nil, nil
	if l_2_11 > 0 then
		l_2_12 = l_2_9 - l_2_11
		l_2_13 = l_2_9 + l_2_11
	else
		l_2_12 = l_2_9 + l_2_11
		l_2_13 = l_2_9 - l_2_11
	end
	if l_2_12 < 0 or l_2_12 > 1 then
		if l_2_13 < 0 or l_2_13 > 1 then
			return 
		end
		do return end
		return l_2_13
	elseif l_2_13 < 0 or l_2_13 > 1 then
		return l_2_12
	end
	do return end
	if l_2_12 == l_2_13 then
		return l_2_12
	end
	do return end
	return l_2_12, l_2_13
end

SharedMath.intersect_ray_plane = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_1:dot(l_3_3 - l_3_2)
	if l_3_4 == 0 then
		return 
	end
	local l_3_5 = l_3_1:dot(l_3_0 - l_3_2) / l_3_4
	if l_3_5 < 0 or l_3_5 > 1 then
		return 
	end
	return l_3_5
end

SharedMath.intersect_ray_disk = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
	local l_4_5 = SharedMath.intersect_ray_plane(l_4_0, l_4_2, l_4_3, l_4_4)
	if not l_4_5 then
		return 
	end
	if l_4_1 < l_4_3 + l_4_5 * (l_4_4 - l_4_3) - l_4_0:length() then
		return 
	end
	return l_4_5
end

SharedMath.is_inside_sphere = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_0 - l_5_1:length()
	return l_5_3 <= l_5_2
end

SharedMath.distance_point_to_line = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = assert
	l_6_3(l_6_1 ~= l_6_2)
	l_6_3 = l_6_2 - l_6_1
	local l_6_6 = l_6_1 - l_6_0
	if l_6_3:dot(l_6_6) > 0 then
		return l_6_6:length(), 0
	end
	local l_6_7 = l_6_0 - l_6_2
	if l_6_3:dot(l_6_7) > 0 then
		return l_6_7:length(), 1
	end
	local l_6_8 = l_6_3:cross(l_6_6):length() / l_6_3:length()
	return l_6_8, 2
end

SharedMath.point_on_ellipse = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = assert
	l_7_3(l_7_1 <= l_7_0)
	l_7_3 = assert
	l_7_3(l_7_2 >= -180 and l_7_2 <= 180)
	l_7_3 = math
	l_7_3 = l_7_3.cos
	l_7_3 = l_7_3(l_7_2)
	l_7_3 = l_7_0 * l_7_3
	local l_7_8 = l_7_1 * math.sin(l_7_2)
	return l_7_3, l_7_8
end

SharedMath.normalized_rand = function(l_8_0, l_8_1)
	if not l_8_0 then
		l_8_0 = 0
	end
	if not l_8_1 then
		l_8_1 = 1
	end
	local l_8_2 = math.random()
	return l_8_1 * (math.sqrt(-2 * math.log(l_8_2)) * math.cos(2 * math.pi * math.random())) + l_8_0
end

SharedMath.line_segment_intersection_2d = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, l_9_5, l_9_6, l_9_7)
	local l_9_8 = SharedMath.line_segment_intersection_2d_denominators(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, l_9_5, l_9_6, l_9_7)
	if not l_9_8 then
		return 
	end
	local l_9_9 = l_9_8.d1
	local l_9_10 = l_9_8.d2
	if l_9_8.d1 < 0 or l_9_8.d1 > 0 or l_9_8.d2 < 0 or l_9_8.d2 > 0 then
		return 
	end
	local l_9_11 = {}
	l_9_11.x = l_9_0 + (line_1_x2 - line_1_x1) * l_9_9
	l_9_11.y = l_9_1 + (l_9_3 - l_9_1) * l_9_9
	l_9_11.d1 = l_9_9
	l_9_11.d2 = l_9_10
	return l_9_11
end

SharedMath.lambda_line_segment_intersection_2d = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5, l_10_6, l_10_7)
	local l_10_8 = l_10_0
	local l_10_9 = l_10_1
	local l_10_10 = l_10_2
	local l_10_11 = l_10_3
	local l_10_12 = l_10_4
	local l_10_13 = l_10_5
	local l_10_14 = l_10_6
	local l_10_15 = l_10_7
	local l_10_16 = (l_10_15 - l_10_13) * (l_10_10 - l_10_8) - (l_10_14 - l_10_12) * (l_10_11 - l_10_9)
	if l_10_16 == 0 then
		return 
	end
	local l_10_17 = (l_10_14 - l_10_12) * (l_10_9 - l_10_13) - (l_10_15 - l_10_13) * (l_10_8 * l_10_12)
	local l_10_18 = (l_10_10 - l_10_8) * (l_10_9 - l_10_13) - (l_10_11 - l_10_9) * (l_10_8 - l_10_12)
	local l_10_19 = 1 / l_10_16
	local l_10_20 = l_10_17 * l_10_19
	local l_10_21 = l_10_18 * l_10_19
	local l_10_22 = {}
	l_10_22.d1 = l_10_20
	l_10_22.d2 = l_10_21
	return l_10_22
end

SharedMath.bounding_sphere_from_positions = function(l_11_0)
	local l_11_8, l_11_9, l_11_11, l_11_12, l_11_13, l_11_14 = nil
	local l_11_1 = #l_11_0
	local l_11_2 = assert
	l_11_2(l_11_1 > 0)
	l_11_2 = Vector3
	l_11_2 = l_11_2()
	for i_0,i_1 in ipairs(l_11_0) do
		l_11_2 = l_11_2 + i_1
	end
	l_11_2 = (l_11_2) / l_11_1
	for i_0,i_1 in ipairs(l_11_0) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	if 0 < math.dot(l_11_2 - i_1, l_11_2 - i_1) then
		end
		return {center = l_11_2, radius = math.sqrt(math.dot(l_11_2 - i_1, l_11_2 - i_1))}
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 32 
end

SharedMath.distance_point_plane = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = math.dot
	local l_12_4 = l_12_0 - l_12_1
	local l_12_5 = l_12_2
	return l_12_3(l_12_4, l_12_5)
end


