if not CoreEnvironmentEffectsManager then
	CoreEnvironmentEffectsManager = class()
end
CoreEnvironmentEffectsManager.init = function(l_1_0)
	l_1_0._effects = {}
	l_1_0._current_effects = {}
	l_1_0._mission_effects = {}
end

CoreEnvironmentEffectsManager.add_effect = function(l_2_0, l_2_1, l_2_2)
	l_2_0._effects[l_2_1] = l_2_2
	if l_2_2:default() then
		l_2_0:use(l_2_1)
	end
end

CoreEnvironmentEffectsManager.effect = function(l_3_0, l_3_1)
	return l_3_0._effects[l_3_1]
end

CoreEnvironmentEffectsManager.effects = function(l_4_0)
	return l_4_0._effects
end

CoreEnvironmentEffectsManager.effects_names = function(l_5_0)
	local l_5_5, l_5_6, l_5_7, l_5_8, l_5_9 = nil
	local l_5_1 = {}
	for i_0,i_1 in pairs(l_5_0._effects) do
		if not i_1:default() then
			table.insert(l_5_1, i_0)
		end
	end
	table.sort(l_5_1)
	return l_5_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreEnvironmentEffectsManager.use = function(l_6_0, l_6_1)
	if l_6_0._effects[l_6_1] and not table.contains(l_6_0._current_effects, l_6_0._effects[l_6_1]) then
		l_6_0._effects[l_6_1]:load_effects()
		l_6_0._effects[l_6_1]:start()
		table.insert(l_6_0._current_effects, l_6_0._effects[l_6_1])
	end
	do return end
	Application:error("No effect named, " .. l_6_1 .. " availible to use")
end

CoreEnvironmentEffectsManager.load_effects = function(l_7_0, l_7_1)
	if l_7_0._effects[l_7_1] then
		l_7_0._effects[l_7_1]:load_effects()
	end
end

CoreEnvironmentEffectsManager.stop = function(l_8_0, l_8_1)
	if l_8_0._effects[l_8_1] then
		l_8_0._effects[l_8_1]:stop()
		table.delete(l_8_0._current_effects, l_8_0._effects[l_8_1])
	end
end

CoreEnvironmentEffectsManager.stop_all = function(l_9_0)
	local l_9_4, l_9_5, l_9_6, l_9_7 = nil
	for i_0,i_1 in ipairs(l_9_0._current_effects) do
		i_1:stop()
	end
	l_9_0._current_effects = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreEnvironmentEffectsManager.update = function(l_10_0, l_10_1, l_10_2)
	local l_10_6, l_10_7, l_10_8, l_10_9 = nil
	for i_0,i_1 in ipairs(l_10_0._current_effects) do
		i_1:update(l_10_1, l_10_2)
	end
end

CoreEnvironmentEffectsManager.gravity_and_wind_dir = function(l_11_0)
	return Vector3(0, 0, -982) + Wind:wind_at(Vector3()) * 0.5
end

CoreEnvironmentEffectsManager.spawn_mission_effect = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = World:effect_manager():spawn(l_12_2)
	if not l_12_0._mission_effects[l_12_1] then
		l_12_0._mission_effects[l_12_1] = {}
	end
	table.insert(l_12_0._mission_effects[l_12_1], l_12_3)
end

CoreEnvironmentEffectsManager.kill_all_mission_effects = function(l_13_0)
	local l_13_4, l_13_5, l_13_6, l_13_7, l_13_11, l_13_12, l_13_13, l_13_14 = nil
	for i_0,i_1 in pairs(l_13_0._mission_effects) do
		for i_0,i_1 in ipairs(i_1) do
			World:effect_manager():kill(i_1)
		end
	end
	l_13_0._mission_effects = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreEnvironmentEffectsManager.kill_mission_effect = function(l_14_0, l_14_1)
	local l_14_6, l_14_7, l_14_8, l_14_9 = nil
	local l_14_2 = l_14_0._mission_effects[l_14_1]
	if not l_14_2 then
		return 
	end
	for i_0,i_1 in ipairs(l_14_2) do
		World:effect_manager():kill(i_1)
	end
	l_14_0._mission_effects[l_14_1] = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreEnvironmentEffectsManager.fade_kill_mission_effect = function(l_15_0, l_15_1)
	local l_15_6, l_15_7, l_15_8, l_15_9 = nil
	local l_15_2 = l_15_0._mission_effects[l_15_1]
	if not l_15_2 then
		return 
	end
	for i_0,i_1 in ipairs(l_15_2) do
		World:effect_manager():fade_kill(i_1)
	end
	l_15_0._mission_effects[l_15_1] = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not EnvironmentEffect then
	EnvironmentEffect = class()
end
EnvironmentEffect.init = function(l_16_0, l_16_1)
	l_16_0._default = l_16_1
end

EnvironmentEffect.load_effects = function(l_17_0)
end

EnvironmentEffect.update = function(l_18_0, l_18_1, l_18_2)
end

EnvironmentEffect.start = function(l_19_0)
end

EnvironmentEffect.stop = function(l_20_0)
end

EnvironmentEffect.default = function(l_21_0)
	return l_21_0._default
end


