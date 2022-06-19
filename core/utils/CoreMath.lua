core:module("CoreMath")
nice = math.nice
rgb_to_hsv = function(l_1_0, l_1_1, l_1_2)
	local l_1_3 = math.max(l_1_0, l_1_1, l_1_2)
	local l_1_4 = math.min(l_1_0, l_1_1, l_1_2)
	local l_1_5 = 0
	if l_1_3 == l_1_4 then
		l_1_5 = 0
	elseif l_1_3 == l_1_0 and l_1_2 <= l_1_1 then
		l_1_5 = 60 * (l_1_1 - l_1_2) / (l_1_3 - l_1_4)
	elseif l_1_3 == l_1_0 and l_1_1 < l_1_2 then
		l_1_5 = 60 * (l_1_1 - l_1_2) / (l_1_3 - l_1_4) + 360
	elseif l_1_3 == l_1_1 then
		l_1_5 = 60 * (l_1_2 - l_1_0) / (l_1_3 - l_1_4) + 120
	elseif l_1_3 == l_1_2 then
		l_1_5 = 60 * (l_1_0 - l_1_1) / (l_1_3 - l_1_4) + 240
	end
	l_1_5 = math.fmod(l_1_5, 360)
	if l_1_3 ~= 0 or not 0 then
		local l_1_6, l_1_7 = 1 - l_1_4 / l_1_3
	end
	local l_1_8 = nil
	return l_1_5, l_1_8, l_1_3
end

hsv_to_rgb = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = math.floor(l_2_0 / 60)
	local l_2_4 = l_2_0 / 60 - l_2_3
	local l_2_5 = l_2_2 * (1 - l_2_1)
	local l_2_6 = l_2_2 * (1 - l_2_4 * l_2_1)
	local l_2_7 = l_2_2 * (1 - (1 - l_2_4) * l_2_1)
	local l_2_8 = {}
	local l_2_9 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_8[1], l_2_9 = l_2_9, {l_2_2, l_2_7, l_2_5}
	l_2_8[2], l_2_9 = l_2_9, {l_2_5, l_2_2, l_2_7}
	l_2_8[3], l_2_9 = l_2_9, {l_2_5, l_2_6, l_2_2}
	l_2_8[4], l_2_9 = l_2_9, {l_2_7, l_2_5, l_2_2}
	l_2_8[5], l_2_9 = l_2_9, {l_2_2, l_2_5, l_2_6}
	l_2_9 = unpack
	local l_2_11 = math.fmod
	local l_2_12 = l_2_3
	l_2_11 = l_2_11(l_2_12, 6)
	l_2_11 = l_2_8[l_2_11]
	local l_2_10 = nil
	return l_2_9(l_2_11)
end

string_to_value = function(l_3_0, l_3_1)
	if l_3_0 == "number" then
		local l_3_2 = tonumber
		local l_3_3 = l_3_1
		return l_3_2(l_3_3)
	elseif l_3_0 == "boolean" then
		local l_3_4 = toboolean
		local l_3_5 = l_3_1
		return l_3_4(l_3_5)
	elseif l_3_0 == "Vector3" then
		local l_3_6 = math.string_to_vector
		local l_3_7 = l_3_1
		return l_3_6(l_3_7)
	elseif l_3_0 == "Rotation" then
		local l_3_8 = math.string_to_rotation
		local l_3_9 = l_3_1
		return l_3_8(l_3_9)
	elseif l_3_0 == "table" then
		return {}
	elseif l_3_0 == "nil" then
		return nil
	end
	return l_3_1
end

vector_to_string = function(l_4_0, l_4_1)
	if l_4_1 then
		local l_4_2 = string.format(l_4_1, l_4_0.x)
		local l_4_3 = string.format(l_4_1, l_4_0.y)
		local l_4_4 = string.format(l_4_1, l_4_0.z)
		return l_4_2 .. " " .. l_4_3 .. " " .. l_4_4
	end
	return l_4_0.x .. " " .. l_4_0.y .. " " .. l_4_0.z
end

rotation_to_string = function(l_5_0, l_5_1)
	if l_5_1 then
		local l_5_2 = string.format(l_5_1, l_5_0:yaw())
		local l_5_3 = string.format(l_5_1, l_5_0:pitch())
		local l_5_4 = string.format(l_5_1, l_5_0:roll())
		return l_5_2 .. " " .. l_5_3 .. " " .. l_5_4
	end
	return l_5_0:yaw() .. " " .. l_5_0:pitch() .. " " .. l_5_0:roll()
end

width_mul = function()
	return 0.75 * core_setup.aspect_ratio
end

wire_set_midpoint = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_4 = l_7_0:get_object(l_7_1):position()
	local l_7_5 = l_7_0:get_object(l_7_2):position()
	local l_7_6 = l_7_5 - l_7_4:normalized():cross(Vector3(0, 0, 1))
	local l_7_7 = l_7_5 - l_7_4:normalized():cross(l_7_6)
	local l_7_8 = l_7_4 + (l_7_5 - l_7_4) * 0.5
	l_7_0:get_object(l_7_3):set_position(l_7_8 + l_7_7 * l_7_0:wire_data().slack)
end

probability = function(l_8_0, l_8_1)
	local l_8_8, l_8_9, l_8_10 = nil
	local l_8_2 = math.random(100)
	local l_8_3 = 0
	local l_8_4 = #l_8_0
	for i_0,i_1 in ipairs(l_8_0) do
		l_8_3 = l_8_3 + i_1
		if l_8_2 <= l_8_3 then
			l_8_4 = i_0
	else
		end
	end
	if l_8_1 then
		return l_8_1[l_8_4]
	end
	return l_8_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

get_fit_size = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = l_9_2 / l_9_3
	local l_9_5 = l_9_0 / l_9_1
	if l_9_5 <= l_9_4 then
		return l_9_2 * l_9_5 / l_9_4, l_9_3
	else
		return l_9_2, l_9_3 * l_9_4 / l_9_5
	end
end

os.get_oldest_date = function(l_10_0, l_10_1)
	if l_10_1.year < l_10_0.year then
		return l_10_0
	end
	do return end
	if l_10_0.year < l_10_1.year then
		return l_10_1
	end
	do return end
	if l_10_1.yday < l_10_0.yday then
		return l_10_0
	end
	do return end
	if l_10_0.yday < l_10_1.yday then
		return l_10_1
	end
	do return end
	if l_10_1.hour < l_10_0.hour then
		return l_10_0
	end
	do return end
	if l_10_0.hour < l_10_1.hour then
		return l_10_1
	end
	do return end
	if l_10_1.min < l_10_0.min then
		return l_10_0
	end
	do return end
	if l_10_0.min < l_10_1.min then
		return l_10_1
	end
	do return end
	if l_10_1.sec < l_10_0.sec then
		return l_10_0
	end
	do return end
	if l_10_0.sec < l_10_1.sec then
		return l_10_1
	end
	do return end
	return nil
end

math.UP = Vector3(0, 0, 1)
math.rand = function(l_11_0, l_11_1)
	if l_11_1 then
		return math.random() * (l_11_1 - l_11_0) + l_11_0
	else
		return math.random() * l_11_0
	end
end

math.round = function(l_12_0, l_12_1)
	if not l_12_1 then
		l_12_1 = 1
	end
	return math.floor((l_12_0 + l_12_1 / 2) / l_12_1) * l_12_1
end

math.min_max = function(l_13_0, l_13_1)
	if l_13_0 < l_13_1 then
		return l_13_0, l_13_1
	else
		return l_13_1, l_13_0
	end
end

math.vector_min_max = function(l_14_0, l_14_1)
	local l_14_2, l_14_3 = math.min_max(l_14_0.x, l_14_1.x)
	local l_14_4, l_14_5 = math.min_max(l_14_0.y, l_14_1.y)
	local l_14_6, l_14_7 = math.min_max(l_14_0.z, l_14_1.z)
	local l_14_8 = Vector3(l_14_2, l_14_4, l_14_6)
	local l_14_9 = Vector3(l_14_3, l_14_5, l_14_7)
	return l_14_8, l_14_9
end

math.vector_clamp = function(l_15_0, l_15_1, l_15_2)
	if type_name(l_15_1) ~= "Vector3" then
		l_15_1 = Vector3(l_15_1, l_15_1, l_15_1)
	end
	if type_name(l_15_2) ~= "Vector3" then
		l_15_2 = Vector3(l_15_2, l_15_2, l_15_2)
	end
	local l_15_3 = Vector3
	local l_15_4 = math.clamp(l_15_0.x, l_15_1.x, l_15_2.x)
	local l_15_5 = math.clamp(l_15_0.y, l_15_1.y, l_15_2.y)
	local l_15_6, l_15_7, l_15_8, l_15_9 = math.clamp(l_15_0.z, l_15_1.z, l_15_2.z), .end
	return l_15_3(l_15_4, l_15_5, l_15_6, l_15_7, l_15_8, l_15_9)
end

math.lerp = function(l_16_0, l_16_1, l_16_2)
	return l_16_0 * (1 - l_16_2) + l_16_1 * l_16_2
end

math.string_to_rotation = function(l_17_0)
	local l_17_1 = math.string_to_vector(l_17_0)
	local l_17_2 = Rotation
	local l_17_3 = l_17_1.x
	local l_17_4 = l_17_1.y
	local l_17_5 = l_17_1.z
	return l_17_2(l_17_3, l_17_4, l_17_5)
end

math.vector_to_string = function(l_18_0)
	return tostring(l_18_0.x) .. " " .. tostring(l_18_0.y) .. " " .. tostring(l_18_0.z)
end

math.spline = function(l_19_0, l_19_1)
	local l_19_2 = l_19_1 * l_19_1
	local l_19_3 = l_19_0[4] - l_19_0[3] - l_19_0[1] + l_19_0[2]
	return l_19_3 * l_19_1 * l_19_2 + (l_19_0[1] - l_19_0[2] - l_19_3) * l_19_2 + (l_19_0[3] - l_19_0[1]) * l_19_1 + l_19_0[2]
end

math.spline_len = function(l_20_0, l_20_1)
	local l_20_2 = 0
	local l_20_3 = l_20_0[1]
	for l_20_7 = 1, l_20_1 do
		local l_20_8 = math.spline(l_20_0, l_20_7 / l_20_1)
		l_20_2 = l_20_2 + l_20_8 - l_20_3:length()
		l_20_3 = l_20_8
	end
	return l_20_2
end

math.bezier = function(l_21_0, l_21_1)
	local l_21_2 = l_21_0[1]
	local l_21_3 = l_21_0[2]
	local l_21_4 = l_21_0[3]
	local l_21_5 = l_21_0[4]
	local l_21_6 = l_21_1 * l_21_1
	return l_21_2 * ((1 - l_21_1) * (1 - l_21_1) * (1 - l_21_1)) + 3 * l_21_3 * l_21_1 * (1 - l_21_1) * (1 - l_21_1) + 3 * l_21_4 * l_21_6 * (1 - l_21_1) + l_21_5 * (l_21_6 * l_21_1)
end

math.linear_bezier = function(l_22_0, l_22_1)
	return l_22_0[1] * (1 - l_22_1) + l_22_0[2] * l_22_1
end

math.quadratic_bezier = function(l_23_0, l_23_1)
	return l_23_0[1] * ((1 - l_23_1) * (1 - l_23_1)) + l_23_0[2] * (2 * l_23_1 * (1 - l_23_1)) + l_23_0[3] * (l_23_1 * l_23_1)
end

math.bezier_len = function(l_24_0, l_24_1)
	local l_24_2 = 0
	local l_24_3 = l_24_0[1]
	for l_24_7 = 1, l_24_1 do
		local l_24_8 = math.bezier(l_24_0, l_24_7 / l_24_1)
		l_24_2 = l_24_2 + l_24_8 - l_24_3:length()
		l_24_3 = l_24_8
	end
	return l_24_2
end

math.limitangle = function(l_25_0)
	if math.fmod(l_25_0, 360) < 0 then
		local l_25_1 = math.fmod(l_25_0, 360) + 360
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_25_1
end

math.world_to_obj = function(l_26_0, l_26_1)
	if l_26_0 == nil then
		return l_26_1
	end
	local l_26_2 = l_26_1 - l_26_0:position()
	local l_26_3, l_26_4 = l_26_2:rotate_with, l_26_2
	local l_26_5, l_26_6 = l_26_0:rotation():inverse(), .end
	return l_26_3(l_26_4, l_26_5, l_26_6)
end

math.obj_to_world = function(l_27_0, l_27_1)
	if l_27_0 == nil then
		return l_27_1
	end
	return l_27_1:rotate_with(l_27_0:rotation()) + l_27_0:position()
end

math.within = function(l_28_0, l_28_1, l_28_2)
	return l_28_1 <= l_28_0 and l_28_0 <= l_28_2
end


