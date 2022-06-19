core:module("CoreSky")
core:require_module("CoreClass")
if not Sky then
	Sky = CoreClass.class()
end
Sky.init = function(l_1_0)
	l_1_0._params = {}
	l_1_0._name = "default"
end

Sky.set_name = function(l_2_0, l_2_1)
	l_2_0._name = l_2_1
end

Sky.set_value = function(l_3_0, l_3_1, l_3_2)
	l_3_0._params[l_3_1] = l_3_2
end

Sky.value = function(l_4_0, l_4_1)
	return l_4_0._params[l_4_1]
end

Sky.parse = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7, l_5_8 = nil
	l_5_0._params = {}
	for i_0 in l_5_1:children() do
		local l_5_10 = i_0:parameter("key")
		if l_5_9:name() == "param" and l_5_10 and l_5_10 ~= "" and l_5_9:parameter("value") and l_5_9:parameter("value") ~= "" then
			if math.string_is_good_vector(l_5_9:parameter("value")) then
				l_5_0._params[l_5_10] = math.string_to_vector(l_5_9:parameter("value"))
			end
		else
			if tonumber(l_5_9:parameter("value")) then
				l_5_0._params[l_5_10] = tonumber(l_5_9:parameter("value"))
			end
		else
			if string.sub(l_5_9:parameter("value"), 1, 1) == "#" then
				l_5_0._params[l_5_10] = l_5_0:database_lookup(string.sub(l_5_9:parameter("value"), 2))
			end
		else
			l_5_0._params[l_5_10] = tostring(l_5_9:parameter("value"))
		end
	end
end

Sky.copy = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17, l_6_18, l_6_19, l_6_20 = nil
	for i_0,i_1 in pairs(l_6_1._params) do
		if type(i_1) == "string" then
			l_6_0._params[i_0] = i_1
		else
			if type(i_1) ~= "number" then
				l_6_0._params[i_0] = Vector3(i_1.x, i_1.y, i_1.z)
			end
		else
			l_6_0._params[i_0] = i_1
		end
	end
	l_6_0._name = l_6_1._name
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Sky.interpolate = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13, l_7_14, l_7_15, l_7_16, l_7_17 = nil
	local l_7_4 = 1 - l_7_3
	for i_0,i_1 in pairs(l_7_2._params) do
		if not l_7_1._params[i_0] then
			return 
		end
		for i_0,i_1 in l_7_5 do
			if type(i_1) ~= "string" then
				l_7_0._params[i_0] = l_7_1._params[i_0] * l_7_4 + i_1 * l_7_3
			else
				l_7_0._params[i_0] = i_1
			end
		end
		l_7_0._name = l_7_2._name
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

Sky.database_lookup = function(l_8_0, l_8_1)
	local l_8_2 = string.find(l_8_1, "#")
	local l_8_3 = string.sub(l_8_1, 1, l_8_2 - 1)
	local l_8_4 = string.sub(l_8_1, l_8_2 + 1)
	local l_8_5 = assert
	l_8_5(l_8_3 == "LightIntensityDB")
	l_8_5 = LightIntensityDB
	 -- DECOMPILER ERROR: Overwrote pending register.

	assert(l_8_5)
	return l_8_5
end


