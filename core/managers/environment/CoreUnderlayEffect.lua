core:module("CoreUnderlayEffect")
core:require_module("CoreClass")
if not UnderlayMaterial then
	UnderlayMaterial = CoreClass.class()
end
UnderlayMaterial.init = function(l_1_0)
	l_1_0._params = {}
end

UnderlayMaterial.add = function(l_2_0, l_2_1)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17, l_2_18 = nil
	for i_0,i_1 in pairs(l_2_1._params) do
		if l_2_0._params[i_0] then
			l_2_0._params[i_0] = l_2_0._params[i_0] + l_2_1._params[i_0]
		else
			if type(l_2_1._params[i_0]) ~= "number" then
				l_2_0._params[i_0] = Vector3(l_2_1._params[i_0].x, l_2_1._params[i_0].y, l_2_1._params[i_0].z)
			end
		else
			l_2_0._params[i_0] = l_2_1._params[i_0]
		end
	end
end

UnderlayMaterial.scale = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7 = nil
	for i_0,i_1 in pairs(l_3_0._params) do
		l_3_0._params[i_0] = l_3_0._params[i_0] * l_3_1
	end
end

UnderlayMaterial.copy = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13, l_4_14, l_4_15, l_4_16 = nil
	for i_0,i_1 in pairs(l_4_1._params) do
		if type(i_1) ~= "number" then
			l_4_0._params[i_0] = Vector3(i_1.x, i_1.y, i_1.z)
		else
			l_4_0._params[i_0] = i_1
		end
	end
end

UnderlayMaterial.interpolate = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_7, l_5_8, l_5_9, l_5_10, l_5_11, l_5_12, l_5_13 = nil
	for i_0,i_1 in pairs(l_5_1._params) do
		if not l_5_2._params[i_0] then
			l_5_0._params[i_0] = nil
		else
			l_5_0._params[l_5_14] = l_5_1._params[l_5_14] * (1 - l_5_3) + l_5_2._params[l_5_14] * l_5_3
		end
	end
end

UnderlayMaterial.interpolate_value = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	if not l_6_2._params[l_6_3] or not l_6_1._params[l_6_3] then
		return 
	end
	do return end
	local l_6_5 = 1 - l_6_4
	l_6_0._params[l_6_3] = l_6_1._params[l_6_3] * l_6_5 + l_6_2._params[l_6_3] * l_6_4
end

UnderlayMaterial.parse = function(l_7_0, l_7_1)
	local l_7_5, l_7_6, l_7_7, l_7_8 = nil
	l_7_0._params = {}
	for i_0 in l_7_1:children() do
		local l_7_10 = i_0:parameter("key")
		if l_7_9:name() == "param" and l_7_10 and l_7_10 ~= "" and l_7_9:parameter("value") and l_7_9:parameter("value") ~= "" then
			if math.string_is_good_vector(l_7_9:parameter("value")) then
				l_7_0._params[l_7_10] = math.string_to_vector(l_7_9:parameter("value"))
			end
		else
			if tonumber(l_7_9:parameter("value")) then
				l_7_0._params[l_7_10] = tonumber(l_7_9:parameter("value"))
			end
		else
			if string.sub(l_7_9:parameter("value"), 1, 1) == "#" then
				l_7_0._params[l_7_10] = l_7_0:database_lookup(string.sub(l_7_9:parameter("value"), 2))
			end
		else
			l_7_0._params[l_7_10] = tostring(l_7_9:parameter("value"))
		end
	end
end

UnderlayMaterial.set_value = function(l_8_0, l_8_1, l_8_2)
	l_8_0._params[l_8_1] = l_8_2
end

UnderlayMaterial.value = function(l_9_0, l_9_1)
	return l_9_0._params[l_9_1]
end

UnderlayMaterial.database_lookup = function(l_10_0, l_10_1)
	local l_10_2 = string.find(l_10_1, "#")
	local l_10_3 = string.sub(l_10_1, 1, l_10_2 - 1)
	local l_10_4 = string.sub(l_10_1, l_10_2 + 1)
	local l_10_5 = assert
	l_10_5(l_10_3 == "LightIntensityDB")
	l_10_5 = LightIntensityDB
	 -- DECOMPILER ERROR: Overwrote pending register.

	assert(l_10_5)
	return l_10_5
end

if not UnderlayEffect then
	UnderlayEffect = CoreClass.class()
end
UnderlayEffect.init = function(l_11_0)
	l_11_0:set_default()
end

UnderlayEffect.set_default = function(l_12_0)
	l_12_0._materials = {}
	l_12_0._name = "default"
end

UnderlayEffect.set_name = function(l_13_0, l_13_1)
	l_13_0._name = l_13_1
end

UnderlayEffect.add = function(l_14_0, l_14_1)
	local l_14_5, l_14_6, l_14_7, l_14_8, l_14_9, l_14_10, l_14_11, l_14_12 = nil
	for i_0,i_1 in pairs(l_14_1._materials) do
		if not l_14_0._materials[i_0] then
			l_14_0._materials[i_0] = UnderlayMaterial:new()
		end
		i_1:add(l_14_1._materials[i_0])
	end
end

UnderlayEffect.scale = function(l_15_0, l_15_1)
	local l_15_5, l_15_6, l_15_7, l_15_8 = nil
	for i_0,i_1 in pairs(l_15_0._materials) do
		i_1:scale(l_15_1)
	end
end

UnderlayEffect.copy = function(l_16_0, l_16_1)
	local l_16_5, l_16_6, l_16_7, l_16_8, l_16_9, l_16_10, l_16_11, l_16_12 = nil
	for i_0,i_1 in pairs(l_16_1._materials) do
		if not l_16_0._materials[i_0] then
			l_16_0._materials[i_0] = UnderlayMaterial:new()
		end
		l_16_0._materials[i_0]:copy(i_1)
	end
	l_16_0._name = l_16_1._name
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnderlayEffect.interpolate = function(l_17_0, l_17_1, l_17_2, l_17_3)
	local l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_13, l_17_14, l_17_15, l_17_16, l_17_17, l_17_18, l_17_19, l_17_20, l_17_21, l_17_22, l_17_23, l_17_24 = nil
	for i_0,i_1 in pairs(l_17_1._materials) do
		if not l_17_2._materials[i_0] then
			l_17_2._materials[i_0] = UnderlayMaterial:new()
		end
		if not l_17_0._materials[i_0] then
			l_17_0._materials[i_0] = UnderlayMaterial:new()
		end
	end
	for i_0,i_1 in pairs(l_17_2._materials) do
		if not l_17_1._materials[i_0] then
			l_17_1._materials[i_0] = UnderlayMaterial:new()
		end
		if not l_17_0._materials[i_0] then
			l_17_0._materials[i_0] = UnderlayMaterial:new()
		end
	end
	for i_0,i_1 in pairs(l_17_0._materials) do
		i_1:interpolate(l_17_1._materials[i_0], l_17_2._materials[i_0], l_17_3)
	end
	l_17_0._name = l_17_1._name
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UnderlayEffect.interpolate_value = function(l_18_0, l_18_1, l_18_2, l_18_3, l_18_4, l_18_5)
	if not l_18_2._materials[l_18_3] or not l_18_1._materials[l_18_3] then
		return 
	end
	if not l_18_0._materials[l_18_3] then
		l_18_0._materials[l_18_3] = UnderlayMaterial:new()
	end
	l_18_0._name = l_18_1._name
	l_18_0._materials[l_18_3]:interpolate_value(l_18_1._materials[l_18_3], l_18_2._materials[l_18_3], l_18_4, l_18_5)
end

UnderlayEffect.parse = function(l_19_0, l_19_1)
	local l_19_5, l_19_6, l_19_7 = nil
	for i_0 in l_19_1:children() do
		if l_19_8:name() == "material" and i_0:parameter("name") and i_0:parameter("name") ~= "" then
			if not l_19_0._materials[i_0:parameter("name")] then
				l_19_0._materials[i_0:parameter("name")] = UnderlayMaterial:new()
			end
			l_19_0._materials[i_0:parameter("name")]:parse(l_19_8)
		end
	end
end

UnderlayEffect.set_value = function(l_20_0, l_20_1, l_20_2, l_20_3)
	if not l_20_0._materials[l_20_1] then
		l_20_0._materials[l_20_1] = UnderlayMaterial:new()
	end
	l_20_0._materials[l_20_1]:set_value(l_20_2, l_20_3)
end

UnderlayEffect.value = function(l_21_0, l_21_1, l_21_2)
	if l_21_0._materials[l_21_1] then
		local l_21_3, l_21_4 = l_21_0._materials[l_21_1]:value, l_21_0._materials[l_21_1]
		local l_21_5 = l_21_2
		return l_21_3(l_21_4, l_21_5)
	else
		return nil
	end
end


