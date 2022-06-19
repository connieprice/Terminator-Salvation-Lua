if not CoreEnvironmentAreaManager then
	CoreEnvironmentAreaManager = class()
end
CoreEnvironmentAreaManager.init = function(l_1_0)
	l_1_0._areas = {}
	l_1_0._current_area = nil
	l_1_0._area_iterator = 1
	l_1_0._areas_per_frame = 1
	l_1_0._blocks = 0
	l_1_0.GAME_DEFAULT_ENVIRONMENT = "default"
	l_1_0._default_environment = l_1_0.GAME_DEFAULT_ENVIRONMENT
	l_1_0._current_environment = l_1_0.GAME_DEFAULT_ENVIRONMENT
	l_1_0:set_to_default()
	l_1_0._environments = l_1_0:_environments()
	l_1_0._environment_changed_callback = {}
	l_1_0:set_default_transition_time(0.1)
	l_1_0.POSITION_OFFSET = 50
end

CoreEnvironmentAreaManager.set_default_transition_time = function(l_2_0, l_2_1)
	l_2_0._default_transition_time = l_2_1
end

CoreEnvironmentAreaManager.default_transition_time = function(l_3_0)
	return l_3_0._default_transition_time
end

CoreEnvironmentAreaManager.areas = function(l_4_0)
	return l_4_0._areas
end

CoreEnvironmentAreaManager._environments = function(l_5_0)
	local l_5_1 = managers.environment:getall()
	table.sort(l_5_1)
	return l_5_1
end

CoreEnvironmentAreaManager.environments = function(l_6_0)
	return l_6_0._environments
end

CoreEnvironmentAreaManager.game_default_environment = function(l_7_0)
	return l_7_0.GAME_DEFAULT_ENVIRONMENT
end

CoreEnvironmentAreaManager.default_environment = function(l_8_0)
	return l_8_0._default_environment
end

CoreEnvironmentAreaManager.set_default_environment = function(l_9_0, l_9_1, l_9_2, l_9_3)
	l_9_0._default_environment = l_9_1
	if not l_9_0._current_area then
		if not l_9_3 then
			local l_9_7, l_9_8 = ipairs, managers.viewport:viewports()
			l_9_7 = l_9_7(l_9_8)
			for i_0,i_1 in l_9_7 do
				l_9_0:_set_environment(l_9_0._default_environment, l_9_2, l_9_6)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_9_0:_set_environment(l_9_0._default_environment, l_9_2, l_9_3)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreEnvironmentAreaManager.set_to_current_environment = function(l_10_0, l_10_1)
	l_10_0:_set_environment(l_10_0._current_environment, nil, l_10_1)
end

CoreEnvironmentAreaManager._set_environment = function(l_11_0, l_11_1, l_11_2, l_11_3)
	l_11_0._current_environment = l_11_1
	l_11_3:set_environment(l_11_1, l_11_2)
end

CoreEnvironmentAreaManager.current_environment = function(l_12_0)
	return l_12_0._current_environment
end

CoreEnvironmentAreaManager.set_to_default = function(l_13_0)
	local l_13_5, l_13_6, l_13_7, l_13_8 = nil
	local l_13_1 = managers.viewport:active_viewports()
	for i_0,i_1 in ipairs(l_13_1) do
		l_13_0:set_default_environment(l_13_0.GAME_DEFAULT_ENVIRONMENT, nil, i_1)
	end
end

CoreEnvironmentAreaManager.add_area = function(l_14_0, l_14_1)
	local l_14_2 = EnvironmentArea:new(l_14_1)
	table.insert(l_14_0._areas, l_14_2)
	return l_14_2
end

CoreEnvironmentAreaManager.remove_area = function(l_15_0, l_15_1)
	if l_15_1 == l_15_0._current_area then
		l_15_0:_leave_current_area(l_15_0._current_area:transition_time())
	end
	table.delete(l_15_0._areas, l_15_1)
	l_15_0._area_iterator = 1
end

CoreEnvironmentAreaManager.update = function(l_16_0, l_16_1, l_16_2)
	local l_16_7, l_16_8, l_16_9, l_16_10 = nil
	local l_16_3 = managers.viewport:active_viewports()
	for i_0,i_1 in ipairs(l_16_3) do
		if not i_1:camera() then
			return 
		end
		if l_16_0._blocks > 0 then
			return 
		end
		local l_16_13 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_16_0._current_area then
			if nil then
				return 
			end
			local l_16_14 = nil
			l_16_0:_check_inside(l_16_14, l_16_12)
			if l_16_0._current_area then
				return 
			end
			l_16_0:_leave_current_area(l_16_0._current_area:transition_time(), l_16_12)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_16_0:_check_inside(l_16_14, l_16_12)
	end
end

CoreEnvironmentAreaManager._check_inside = function(l_17_0, l_17_1, l_17_2)
	if #l_17_0._areas > 0 then
		for l_17_6 = 1, l_17_0._areas_per_frame do
			local l_17_7 = l_17_0._areas[l_17_0._area_iterator]
			l_17_0._area_iterator = math.mod(l_17_0._area_iterator, #l_17_0._areas) + 1
			if l_17_7:is_inside(l_17_1) then
				if l_17_7:environment() ~= l_17_0._current_environment then
					local l_17_8 = l_17_7:transition_time()
					if l_17_7:permanent() then
						l_17_0:set_default_environment(l_17_7:environment(), l_17_8, l_17_2)
						return 
					end
				else
					l_17_0:_set_environment(l_17_7:environment(), l_17_8, l_17_2)
				end
				l_17_0._current_area = l_17_7
			end
			do break end
		end
	end
end

CoreEnvironmentAreaManager._leave_current_area = function(l_18_0, l_18_1, l_18_2)
	l_18_0._current_area = nil
	if l_18_0._default_environment ~= l_18_0._current_environment then
		l_18_0:_set_environment(l_18_0._default_environment, l_18_1, l_18_2)
	end
end

CoreEnvironmentAreaManager.environment_at_position = function(l_19_0, l_19_1)
	local l_19_6, l_19_7, l_19_8, l_19_9 = nil
	local l_19_2 = l_19_0._default_environment
	for i_0,i_1 in ipairs(l_19_0._areas) do
		if i_1:is_inside(l_19_1) then
			l_19_2 = i_1:environment()
	else
		end
	end
	return l_19_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreEnvironmentAreaManager.add_block = function(l_20_0)
	l_20_0._blocks = l_20_0._blocks + 1
end

CoreEnvironmentAreaManager.remove_block = function(l_21_0)
	l_21_0._blocks = l_21_0._blocks - 1
end

CoreEnvironmentAreaManager.add_environment_changed_callback = function(l_22_0, l_22_1)
	table.insert(l_22_0._environment_changed_callback, l_22_1)
end

CoreEnvironmentAreaManager.remove_environment_changed_callback = function(l_23_0, l_23_1)
	table.delete(l_23_0._environment_changed_callback, l_23_1)
end

if not EnvironmentArea then
	EnvironmentArea = class(CoreShapeBox)
end
EnvironmentArea.init = function(l_24_0, l_24_1)
	l_24_1.type = "box"
	CoreShapeBox.init(l_24_0, l_24_1)
	if not l_24_1.environment then
		l_24_0._properties.environment = managers.environment_area:game_default_environment()
	end
	l_24_0._properties.permanent = l_24_1.permanent or false
	if not l_24_1.transition_time then
		l_24_0._properties.transition_time = managers.environment_area:default_transition_time()
	end
	managers.environment:preload_environment(l_24_0._properties.environment)
	if managers.environment:exists_on_disk(l_24_0._properties.environment .. "_uw") then
		managers.environment:preload_environment(l_24_0._properties.environment .. "_uw")
	end
end

EnvironmentArea.name = function(l_25_0)
	if not l_25_0._unit or not l_25_0._unit:unit_data().name_id then
		return l_25_0._name
	end
end

EnvironmentArea.environment = function(l_26_0)
	local l_26_1, l_26_2 = l_26_0:property, l_26_0
	local l_26_3 = "environment"
	return l_26_1(l_26_2, l_26_3)
end

EnvironmentArea.set_environment = function(l_27_0, l_27_1)
	l_27_0:set_property_string("environment", l_27_1)
end

EnvironmentArea.permanent = function(l_28_0)
	local l_28_1, l_28_2 = l_28_0:property, l_28_0
	local l_28_3 = "permanent"
	return l_28_1(l_28_2, l_28_3)
end

EnvironmentArea.set_permanent = function(l_29_0, l_29_1)
	l_29_0._properties.permanent = l_29_1
end

EnvironmentArea.transition_time = function(l_30_0)
	local l_30_1, l_30_2 = l_30_0:property, l_30_0
	local l_30_3 = "transition_time"
	return l_30_1(l_30_2, l_30_3)
end

EnvironmentArea.set_transition_time = function(l_31_0, l_31_1)
	l_31_0._properties.transition_time = l_31_1
end


