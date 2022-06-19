core:module("CorePostEffect")
core:require_module("CoreClass")
if not PostEffectModifier then
	PostEffectModifier = CoreClass.class()
end
PostEffectModifier.init = function(l_1_0)
	l_1_0._params = {}
end

PostEffectModifier.add = function(l_2_0, l_2_1)
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

PostEffectModifier.scale = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7 = nil
	for i_0,i_1 in pairs(l_3_0._params) do
		l_3_0._params[i_0] = l_3_0._params[i_0] * l_3_1
	end
end

PostEffectModifier.copy = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13, l_4_14, l_4_15, l_4_16 = nil
	for i_0,i_1 in pairs(l_4_1._params) do
		if type(i_1) ~= "number" then
			l_4_0._params[i_0] = Vector3(i_1.x, i_1.y, i_1.z)
		else
			l_4_0._params[i_0] = i_1
		end
	end
end

PostEffectModifier.interpolate = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_7, l_5_8, l_5_9, l_5_10, l_5_11 = nil
	for i_0,i_1 in pairs(l_5_1._params) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if type(i_1) ~= "string" and type(l_5_2._params[i_0]) ~= "string" then
			if not l_5_2._params[i_0] then
				l_5_0._params[l_5_12] = nil
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_5_0._params[l_5_12] = l_5_13 * (1 - l_5_3) + l_5_2._params[i_0] * l_5_3
		end
	end
end

PostEffectModifier.interpolate_value = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	if not l_6_2._params[l_6_3] or not l_6_1._params[l_6_3] then
		return 
	end
	do return end
	local l_6_5 = 1 - l_6_4
	l_6_0._params[l_6_3] = l_6_1._params[l_6_3] * l_6_5 + l_6_2._params[l_6_3] * l_6_4
end

PostEffectModifier.parse = function(l_7_0, l_7_1)
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

PostEffectModifier.set_value = function(l_8_0, l_8_1, l_8_2)
	l_8_0._params[l_8_1] = l_8_2
end

PostEffectModifier.value = function(l_9_0, l_9_1)
	return l_9_0._params[l_9_1]
end

PostEffectModifier.database_lookup = function(l_10_0, l_10_1)
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

if not PostProcessor then
	PostProcessor = CoreClass.class()
end
PostProcessor.init = function(l_11_0)
	l_11_0._modifiers = {}
end

PostProcessor.add = function(l_12_0, l_12_1)
	local l_12_5, l_12_6, l_12_7, l_12_8, l_12_9, l_12_10, l_12_11, l_12_12 = nil
	for i_0,i_1 in pairs(l_12_1._modifiers) do
		if not l_12_0._modifiers[i_0] then
			l_12_0._modifiers[i_0] = PostEffectModifier:new()
		end
		i_1:add(l_12_1._modifiers[i_0])
	end
end

PostProcessor.scale = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7, l_13_8 = nil
	for i_0,i_1 in pairs(l_13_0._modifiers) do
		i_1:scale(l_13_1)
	end
end

PostProcessor.copy = function(l_14_0, l_14_1)
	local l_14_5, l_14_6, l_14_7, l_14_8, l_14_9, l_14_10, l_14_11, l_14_12 = nil
	for i_0,i_1 in pairs(l_14_1._modifiers) do
		if not l_14_0._modifiers[i_0] then
			l_14_0._modifiers[i_0] = PostEffectModifier:new()
		end
		l_14_0._modifiers[i_0]:copy(i_1)
	end
end

PostProcessor.interpolate = function(l_15_0, l_15_1, l_15_2, l_15_3)
	local l_15_7, l_15_8, l_15_9, l_15_10, l_15_11, l_15_12, l_15_13, l_15_14, l_15_15, l_15_16, l_15_17, l_15_18, l_15_19, l_15_20, l_15_21, l_15_22, l_15_23, l_15_24 = nil
	for i_0,i_1 in pairs(l_15_1._modifiers) do
		if not l_15_2._modifiers[i_0] then
			l_15_2._modifiers[i_0] = PostEffectModifier:new()
		end
		if not l_15_0._modifiers[i_0] then
			l_15_0._modifiers[i_0] = PostEffectModifier:new()
		end
	end
	for i_0,i_1 in pairs(l_15_2._modifiers) do
		if not l_15_1._modifiers[i_0] then
			l_15_1._modifiers[i_0] = PostEffectModifier:new()
		end
		if not l_15_0._modifiers[i_0] then
			l_15_0._modifiers[i_0] = PostEffectModifier:new()
		end
	end
	for i_0,i_1 in pairs(l_15_0._modifiers) do
		i_1:interpolate(l_15_1._modifiers[i_0], l_15_2._modifiers[i_0], l_15_3)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PostProcessor.interpolate_value = function(l_16_0, l_16_1, l_16_2, l_16_3, l_16_4, l_16_5)
	if not l_16_2._modifiers[l_16_3] or not l_16_1._modifiers[l_16_3] then
		return 
	end
	if not l_16_0._modifiers[l_16_3] then
		l_16_0._modifiers[l_16_3] = PostEffectModifier:new()
	end
	l_16_0._modifiers[l_16_3]:interpolate_value(l_16_1._modifiers[l_16_3], l_16_2._modifiers[l_16_3], l_16_4, l_16_5)
end

PostProcessor.parse = function(l_17_0, l_17_1)
	local l_17_5, l_17_6, l_17_7 = nil
	for i_0 in l_17_1:children() do
		if l_17_8:name() == "modifier" and i_0:parameter("name") and i_0:parameter("name") ~= "" then
			if not l_17_0._modifiers[i_0:parameter("name")] then
				l_17_0._modifiers[i_0:parameter("name")] = PostEffectModifier:new()
			end
			l_17_0._modifiers[i_0:parameter("name")]:parse(l_17_8)
		end
	end
end

PostProcessor.set_value = function(l_18_0, l_18_1, l_18_2, l_18_3)
	if not l_18_0._modifiers[l_18_1] then
		l_18_0._modifiers[l_18_1] = PostEffectModifier:new()
	end
	l_18_0._modifiers[l_18_1]:set_value(l_18_2, l_18_3)
end

PostProcessor.value = function(l_19_0, l_19_1, l_19_2)
	if l_19_0._modifiers[l_19_1] then
		local l_19_3, l_19_4 = l_19_0._modifiers[l_19_1]:value, l_19_0._modifiers[l_19_1]
		local l_19_5 = l_19_2
		return l_19_3(l_19_4, l_19_5)
	else
		return nil
	end
end

if not PostEffect then
	PostEffect = CoreClass.class()
end
PostEffect.init = function(l_20_0)
	l_20_0:set_default()
end

PostEffect.set_name = function(l_21_0, l_21_1)
	l_21_0._name = l_21_1
end

PostEffect.set_default = function(l_22_0)
	l_22_0._post_processors = {}
	l_22_0._name = "default"
end

PostEffect.add = function(l_23_0, l_23_1)
	local l_23_5, l_23_6, l_23_7, l_23_8, l_23_9, l_23_10, l_23_11, l_23_12, l_23_13, l_23_14, l_23_15, l_23_16, l_23_17 = nil
	for i_0,i_1 in pairs(l_23_1._post_processors) do
		if not l_23_0._post_processors[i_0] then
			l_23_0._post_processors[i_0] = PostProcessor:new()
			l_23_0._post_processors[i_0]._effect = i_1._effect
		end
		i_1:add(l_23_1._post_processors[i_0])
	end
end

PostEffect.scale = function(l_24_0, l_24_1)
	local l_24_5, l_24_6, l_24_7, l_24_8 = nil
	for i_0,i_1 in pairs(l_24_0._post_processors) do
		i_1:scale(l_24_1)
	end
end

PostEffect.copy = function(l_25_0, l_25_1)
	local l_25_5, l_25_6, l_25_7, l_25_8, l_25_9, l_25_10, l_25_11, l_25_12, l_25_13, l_25_14, l_25_15, l_25_16, l_25_17 = nil
	for i_0,i_1 in pairs(l_25_1._post_processors) do
		if not l_25_0._post_processors[i_0] then
			l_25_0._post_processors[i_0] = PostProcessor:new()
			l_25_0._post_processors[i_0]._effect = i_1._effect
		end
		l_25_0._post_processors[i_0]:copy(i_1)
	end
	l_25_0._name = l_25_1._name
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PostEffect.interpolate = function(l_26_0, l_26_1, l_26_2, l_26_3)
	local l_26_7, l_26_8, l_26_9, l_26_10, l_26_11, l_26_12, l_26_13, l_26_14, l_26_15, l_26_16, l_26_17, l_26_18, l_26_19, l_26_20, l_26_21, l_26_22, l_26_23, l_26_24, l_26_25, l_26_26, l_26_27, l_26_28, l_26_29, l_26_30, l_26_31, l_26_32, l_26_33, l_26_34, l_26_35, l_26_36, l_26_37, l_26_38, l_26_39, l_26_40, l_26_41, l_26_42, l_26_43, l_26_44 = nil
	for i_0,i_1 in pairs(l_26_1._post_processors) do
		if not l_26_2._post_processors[i_0] then
			l_26_2._post_processors[i_0] = PostProcessor:new()
			l_26_2._post_processors[i_0]._effect = i_1._effect
		end
		if not l_26_0._post_processors[i_0] then
			l_26_0._post_processors[i_0] = PostProcessor:new()
			l_26_0._post_processors[i_0]._effect = i_1._effect
		end
	end
	for i_0,i_1 in pairs(l_26_2._post_processors) do
		if not l_26_1._post_processors[i_0] then
			l_26_1._post_processors[i_0] = PostProcessor:new()
			l_26_1._post_processors[i_0]._effect = i_1._effect
		end
		if not l_26_0._post_processors[i_0] then
			l_26_0._post_processors[i_0] = PostProcessor:new()
			l_26_0._post_processors[i_0]._effect = i_1._effect
		end
	end
	for i_0,i_1 in pairs(l_26_0._post_processors) do
		i_1:interpolate(l_26_1._post_processors[i_0], l_26_2._post_processors[i_0], l_26_3)
	end
	l_26_0._name = l_26_1._name
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PostEffect.interpolate_value = function(l_27_0, l_27_1, l_27_2, l_27_3, l_27_4, l_27_5, l_27_6)
	if not l_27_2._post_processors[l_27_3] or not l_27_1._post_processors[l_27_3] then
		return 
	end
	if not l_27_0._post_processors[l_27_3] then
		l_27_0._post_processors[l_27_3] = PostProcessor:new()
		l_27_0._post_processors[l_27_3]._effect = l_27_3._effect
	end
	l_27_0._name = l_27_1._name
	l_27_0._post_processors[l_27_3]:interpolate_value(l_27_1._post_processors[l_27_3], l_27_2._post_processors[l_27_3], l_27_4, l_27_5, l_27_6)
end

PostEffect.parse = function(l_28_0, l_28_1)
	local l_28_5, l_28_6, l_28_7, l_28_8 = nil
	for i_0 in l_28_1:children() do
		local l_28_10 = i_0:parameter("name")
		if l_28_9:name() == "post_processor" and l_28_10 and l_28_10 ~= "" and l_28_9:parameter("effect") and l_28_9:parameter("effect") ~= "" then
			if not l_28_0._post_processors[l_28_10] then
				l_28_0._post_processors[l_28_10] = PostProcessor:new()
			end
			l_28_0._post_processors[l_28_10]._effect = l_28_9:parameter("effect")
			l_28_0._post_processors[l_28_10]:parse(l_28_9)
		end
	end
end

PostEffect.set_value = function(l_29_0, l_29_1, l_29_2, l_29_3, l_29_4)
	if not l_29_0._post_processors[l_29_1] then
		l_29_0._post_processors[l_29_1] = PostProcessor:new()
	end
	l_29_0._post_processors[l_29_1]:set_value(l_29_2, l_29_3, l_29_4)
end

PostEffect.value = function(l_30_0, l_30_1, l_30_2, l_30_3)
	if l_30_0._post_processors[l_30_1] then
		local l_30_4, l_30_5 = l_30_0._post_processors[l_30_1]:value, l_30_0._post_processors[l_30_1]
		local l_30_6 = l_30_2
		local l_30_7 = l_30_3
		return l_30_4(l_30_5, l_30_6, l_30_7)
	else
		return nil
	end
end


