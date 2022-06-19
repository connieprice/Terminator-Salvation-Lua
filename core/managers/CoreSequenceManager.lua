if not CoreSequenceManager then
	CoreSequenceManager = class()
end
CoreSequenceManager.GLOBAL_CORE_SEQUENCE_PATH = "\\core\\settings\\core_sequence_manager.xml"
CoreSequenceManager.GLOBAL_SEQUENCE_PATH = "\\data\\settings\\sequence_manager.xml"
CoreSequenceManager.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._area_damage_mask = l_1_1
	l_1_0._target_world_mask = l_1_2
	l_1_0._beings_mask = l_1_3
	l_1_0._event_element_class_map = {}
	l_1_0:register_event_element_class(get_core_or_local("AnimationGroupElement"))
	l_1_0:register_event_element_class(get_core_or_local("AreaDamageElement"))
	l_1_0:register_event_element_class(get_core_or_local("BodyElement"))
	l_1_0:register_event_element_class(get_core_or_local("ConstraintElement"))
	l_1_0:register_event_element_class(get_core_or_local("DebugElement"))
	l_1_0:register_event_element_class(get_core_or_local("DecalMeshElement"))
	l_1_0:register_event_element_class(get_core_or_local("EffectElement"))
	l_1_0:register_event_element_class(get_core_or_local("EffectSpawnerElement"))
	l_1_0:register_event_element_class(get_core_or_local("EffectSurfaceElement"))
	l_1_0:register_event_element_class(get_core_or_local("EnemyKilledElement"))
	l_1_0:register_event_element_class(get_core_or_local("FunctionElement"))
	l_1_0:register_event_element_class(get_core_or_local("GraphicGroupElement"))
	l_1_0:register_event_element_class(get_core_or_local("LightElement"))
	l_1_0:register_event_element_class(get_core_or_local("ObjectElement"))
	l_1_0:register_event_element_class(get_core_or_local("MaterialConfigElement"))
	l_1_0:register_event_element_class(get_core_or_local("MaterialElement"))
	l_1_0:register_event_element_class(get_core_or_local("MorphExpressionElement"))
	l_1_0:register_event_element_class(get_core_or_local("MorphExpressionMovieElement"))
	l_1_0:register_event_element_class(get_core_or_local("PhantomElement"))
	l_1_0:register_event_element_class(get_core_or_local("PhysicEffectElement"))
	l_1_0:register_event_element_class(get_core_or_local("PostEffectElement"))
	l_1_0:register_event_element_class(get_core_or_local("ProjectDecalElement"))
	l_1_0:register_event_element_class(get_core_or_local("RemoveStartTimeElement"))
	l_1_0:register_event_element_class(get_core_or_local("RunSequenceElement"))
	l_1_0:register_event_element_class(get_core_or_local("RunSpawnSystemSequenceElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetDamageElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetExtensionVarElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetGlobalVariableElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetGlobalVariablesElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetInflictElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetPhysicEffectElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetProximityElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetSaveDataElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetSpawnSystemUnitEnabledElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetVariableElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetVariablesElement"))
	l_1_0:register_event_element_class(get_core_or_local("SetWaterElement"))
	l_1_0:register_event_element_class(get_core_or_local("ShakeCameraElement"))
	l_1_0:register_event_element_class(get_core_or_local("SlotElement"))
	l_1_0:register_event_element_class(get_core_or_local("SoundElement"))
	l_1_0:register_event_element_class(get_core_or_local("SpawnUnitElement"))
	l_1_0:register_event_element_class(get_core_or_local("StopPhysicEffectElement"))
	l_1_0:register_event_element_class(get_core_or_local("TriggerElement"))
	l_1_0:register_event_element_class(get_core_or_local("VolumeSetElement"))
	l_1_0:register_event_element_class(get_core_or_local("WheelRadiusElement"))
	l_1_0._filter_element_class_map = {}
	l_1_0:register_filter_element_class(get_core_or_local("CheckFilterElement"))
	l_1_0:register_filter_element_class(get_core_or_local("SideFilterElement"))
	l_1_0:register_filter_element_class(get_core_or_local("ZoneFilterElement"))
	l_1_0._inflict_element_class_map = {}
	l_1_0:register_inflict_element_class(get_core_or_local("InflictElectricityElement"))
	local l_1_7 = l_1_0:register_inflict_element_class
	l_1_7(l_1_0, get_core_or_local("InflictFireElement"))
	l_1_0._unit_elements, l_1_7 = l_1_7, {}
	l_1_0._unit_element_file_map, l_1_7 = l_1_7, {}
	l_1_0._sequence_file_map, l_1_7 = l_1_7, {}
	l_1_7 = get_core_or_local
	l_1_7 = l_1_7("LinkedStackMap")
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._time_callback_map = l_1_7
	l_1_0._retry_callback_list, l_1_7 = l_1_7, {}
	l_1_0._retry_callback_indices, l_1_7 = l_1_7, {}
	l_1_0._callback_map, l_1_7 = l_1_7, {}
	l_1_0._last_callback_id = 0
	local l_1_4 = nil
	l_1_0._inflict_updator_damage_type_map, l_1_7 = l_1_7, {fire = true}
	l_1_0._inflict_updator_body_map, l_1_7 = l_1_7, {}
	l_1_0._inflict_updator_body_count, l_1_7 = l_1_7, {}
	l_1_7 = pairs
	l_1_4 = l_1_0._inflict_updator_damage_type_map
	l_1_7 = l_1_7(l_1_4)
	for i_0 in l_1_7 do
		l_1_0._inflict_updator_body_map[l_1_6] = {}
		l_1_0._inflict_updator_body_count[l_1_6] = {}
	end
	l_1_0._proximity_masks = {}
	l_1_0._collisions_enabled = true
	l_1_0._proximity_enabled = true
	l_1_0._global_unit_element = nil
	l_1_0._global_core_unit_element = nil
	l_1_0._area_damage_callback_map = {}
	l_1_0._last_area_damage_callback_id = 0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceManager.register_event_element_class = function(l_2_0, l_2_1)
	if not l_2_0._event_element_class_map[l_2_1.NAME] then
		l_2_0._event_element_class_map[l_2_1.NAME] = l_2_1
	else
		Application:error("Unable to register event element class \"" .. tostring(class_name(l_2_1)) .. "\" since there already exists an element with the same name \"" .. tostring(l_2_1.NAME) .. "\" in class \"" .. tostring(class_name(l_2_0._event_element_class_map[l_2_1.NAME])) .. "\".")
	end
end

CoreSequenceManager.get_event_element_class_map = function(l_3_0)
	return l_3_0._event_element_class_map
end

CoreSequenceManager.register_filter_element_class = function(l_4_0, l_4_1)
	if not l_4_0._filter_element_class_map[l_4_1.NAME] then
		l_4_0._filter_element_class_map[l_4_1.NAME] = l_4_1
	else
		Application:error("Unable to register filter element class \"" .. tostring(class_name(l_4_1)) .. "\" since there already exists an element with the same name \"" .. tostring(l_4_1.NAME) .. "\" in class \"" .. tostring(class_name(l_4_0._filter_element_class_map[l_4_1.NAME])) .. "\".")
	end
end

CoreSequenceManager.get_filter_element_class_map = function(l_5_0)
	return l_5_0._filter_element_class_map
end

CoreSequenceManager.register_inflict_element_class = function(l_6_0, l_6_1)
	if not l_6_0._inflict_element_class_map[l_6_1.NAME] then
		l_6_0._inflict_element_class_map[l_6_1.NAME] = l_6_1
	else
		Application:error("Unable to register inflict element class \"" .. tostring(class_name(l_6_1)) .. "\" since there already exists an element with the same name \"" .. tostring(l_6_1.NAME) .. "\" in class \"" .. tostring(class_name(l_6_0._inflict_element_class_map[l_6_1.NAME])) .. "\".")
	end
end

CoreSequenceManager.get_inflict_element_class_map = function(l_7_0)
	return l_7_0._inflict_element_class_map
end

CoreSequenceManager.get_inflict_updator_unit_map = function(l_8_0, l_8_1)
	return l_8_0._inflict_updator_body_map[l_8_1]
end

CoreSequenceManager.get_inflict_updator_body_map = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = l_9_0._inflict_updator_body_map[l_9_1]
	if l_9_3 then
		return l_9_3[l_9_2]
	else
		Application:stack_dump_error("Invalid inflict updator damage type \"" .. tostring(l_9_3) .. "\". Valid values: " .. CoreSequenceManager:get_keys_as_string(l_9_0._inflict_updator_body_map, "", true, false))
	end
end

CoreSequenceManager.add_inflict_updator_body = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4)
	local l_10_5 = l_10_0._inflict_updator_body_map[l_10_1]
	if l_10_5 then
		if not l_10_5[l_10_2] then
			local l_10_6, l_10_7, l_10_9 = {}
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_10_5[l_10_2] = l_10_6
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if not l_10_6[l_10_3] then
			local l_10_8 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_10_0._inflict_updator_body_count[l_10_1][l_10_3] = (l_10_0._inflict_updator_body_count[l_10_1][l_10_3] or 0) + 1
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_10_8[l_10_3] = l_10_4
	else
		Application:stack_dump_error("Invalid inflict updator damage type \"" .. tostring(l_10_1) .. "\". Valid values: " .. CoreSequenceManager:get_keys_as_string(l_10_0._inflict_updator_body_map, "", true, false))
	end
end

CoreSequenceManager.remove_inflict_updator_body = function(l_11_0, l_11_1, l_11_2, l_11_3)
	local l_11_4 = l_11_0._inflict_updator_body_map[l_11_1]
	if l_11_4 then
		local l_11_5 = l_11_4[l_11_2]
		if l_11_5 and l_11_5[l_11_3] then
			l_11_5[l_11_3] = nil
			local l_11_6 = l_11_0._inflict_updator_body_count[l_11_1]
			local l_11_7 = l_11_6[l_11_3] - 1
			l_11_6[l_11_3] = l_11_7
		if l_11_7 == 0 then
			end
			l_11_4[l_11_2] = nil
			l_11_6[l_11_3] = nil
		end
	else
		Application:stack_dump_error("Invalid inflict updator damage type \"" .. tostring(l_11_1) .. "\". Valid values: " .. CoreSequenceManager:get_keys_as_string(l_11_0._inflict_updator_body_map, "", true, false))
	end
end

CoreSequenceManager.remove_inflict_updator_body_map = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = l_12_0._inflict_updator_body_map[l_12_1]
	if l_12_3 then
		l_12_3[l_12_2] = nil
	else
		Application:stack_dump_error("Invalid inflict updator damage type \"" .. tostring(l_12_1) .. "\". Valid values: " .. CoreSequenceManager:get_keys_as_string(l_12_0._inflict_updator_body_map, "", true, false))
	end
end

CoreSequenceManager.get_global_core_unit_element = function(l_13_0)
	return l_13_0._global_core_unit_element
end

CoreSequenceManager.get_global_unit_element = function(l_14_0)
	return l_14_0._global_unit_element
end

CoreSequenceManager.get_global_sequence = function(l_15_0, l_15_1)
	if (not l_15_0._global_unit_element or not l_15_0._global_unit_element._sequence_elements[l_15_1]) and l_15_0._global_core_unit_element then
		return l_15_0._global_core_unit_element._sequence_elements[l_15_1]
	end
end

CoreSequenceManager.get_global_sequence_map = function(l_16_0)
	if (not l_16_0._global_unit_element or not l_16_0._global_unit_element._sequence_elements) and (not l_16_0._global_core_unit_element or not l_16_0._global_core_unit_element._sequence_elements) then
		return {}
	end
end

CoreSequenceManager.get_global_filter = function(l_17_0, l_17_1)
	if (not l_17_0._global_unit_element or not l_17_0._global_unit_element._filters[l_17_1]) and l_17_0._global_core_unit_element then
		return l_17_0._global_core_unit_element._filters[l_17_1]
	end
end

CoreSequenceManager.set_collisions_enabled = function(l_18_0, l_18_1)
	l_18_0._collisions_enabled = l_18_1
end

CoreSequenceManager.is_collisions_enabled = function(l_19_0)
	return l_19_0._collisions_enabled
end

CoreSequenceManager.set_proximity_enabled = function(l_20_0, l_20_1)
	l_20_0._proximity_enabled = l_20_1
end

CoreSequenceManager.is_proximity_enabled = function(l_21_0)
	return l_21_0._proximity_enabled
end

CoreSequenceManager.editor_info = function(l_22_0, l_22_1)
	local l_22_8, l_22_9, l_22_10, l_22_11, l_22_16, l_22_17, l_22_18, l_22_29, l_22_30 = nil
	local l_22_2 = l_22_0:get(l_22_1, true)
	local l_22_3 = {}
	if l_22_2 then
		local l_22_4 = l_22_2:get_body_element_list()
		for i_0,i_1 in pairs(l_22_4) do
			for l_22_26,l_22_27 in pairs(i_1:get_first_endurance_element_list()) do
				local l_22_13 = nil
				local l_22_31 = (l_22_3[l_22_27] or 0) + 1
				l_22_3[l_22_27] = l_22_31
			end
		end
	end
	local l_22_19, l_22_20 = l_22_0:get_keys_as_string, l_22_0
	local l_22_21 = l_22_3
	local l_22_22 = "[None]"
	local l_22_23 = true
	local l_22_24 = false
	return l_22_19(l_22_20, l_22_21, l_22_22, l_22_23, l_22_24)
end

CoreSequenceManager.get_proximity_mask = function(l_23_0, l_23_1)
	return l_23_0._proximity_masks[l_23_1]
end

CoreSequenceManager.get_proximity_mask_map = function(l_24_0)
	return l_24_0._proximity_masks
end

CoreSequenceManager.get_keys_as_string = function(l_25_0, l_25_1, l_25_2, l_25_3, l_25_4)
	local l_25_10, l_25_11, l_25_14, l_25_15 = nil
	local l_25_5 = 0
	for i_0,i_1 in pairs(l_25_1) do
		local l_25_7 = function()
		-- upvalues: l_25_2
		return l_25_2
  end
		do
			local l_25_17 = l_25_7
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_25_4 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

		end
	end
	return l_25_7(l_25_5, true)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

CoreSequenceManager.has = function(l_26_0, l_26_1)
	local l_26_7 = nil
	if l_26_0._unit_elements[l_26_1] then
		return true
	end
	local l_26_2 = UnitDatabase:get_unit_data(l_26_1)
	if l_26_2 then
		local l_26_3 = l_26_2:model_script_data()
	if l_26_3 then
		end
		for i_0 in l_26_3:children() do
			if i_0:name() == "sequence_manager" then
				return true
			end
		end
	end
	return false
end

CoreSequenceManager.get = function(l_27_0, l_27_1, l_27_2, l_27_3)
	local l_27_4 = l_27_0._unit_elements[l_27_1]
	if l_27_4 == nil then
		local l_27_5 = UnitDatabase:get_unit_data(l_27_1)
	if l_27_5 == nil and not l_27_2 then
		end
		local l_27_10, l_27_11, l_27_12 = Application:throw_exception, Application, "The unit \""
		l_27_12 = l_27_12 .. tostring(l_27_1) .. "\" does not exist."
		l_27_10(l_27_11, l_27_12)
	end
	do return end
	local l_27_6 = l_27_5:model_script_data()
	if l_27_6 then
		for i_0 in l_27_6:children() do
			if i_0:name() == "sequence_manager" then
				if i_0:parameter("file") then
					l_27_4 = l_27_0._unit_element_file_map[i_0:parameter("file")]
					if l_27_4 then
						return l_27_4
					end
				end
				do return end
				if File:config_exists(i_0:parameter("file")) then
					l_27_0._sequence_file_map[l_27_1] = i_0:parameter("file")
					l_27_13 = File:parse_xml(i_0:parameter("file"))
				else
					local l_27_17, l_27_18, l_27_19, l_27_20 = , Application:error, Application, "Unit \""
					l_27_20 = l_27_20 .. tostring(l_27_1) .. "\" refers to the external sequence manager file \"" .. tostring(l_27_17) .. "\", but it doesn't exist."
					l_27_18(l_27_19, l_27_20)
				end
			if l_27_13 then
				end
				for i_0 in l_27_13:children() do
					local l_27_14 = nil
					if i_0:name() == "unit" then
						l_27_4 = get_core_or_local("UnitElement"):new(i_0, l_27_1)
						l_27_0._unit_elements[l_27_1] = l_27_4
						if l_27_14 then
							l_27_0._unit_element_file_map[l_27_14] = l_27_4
						end
						return l_27_4
					end
				end
			end
		end
		if l_27_3 then
			l_27_4 = get_core_or_local("UnitElement"):new(nil, l_27_1)
			l_27_0._unit_elements[l_27_1] = l_27_4
		elseif not l_27_2 then
			Application:throw_exception("The unit \"" .. tostring(l_27_1) .. "\" does not have a \"sequence_manager\" element with a \"unit\" element in it within its object xml file.")
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	elseif not l_27_2 then
		Application:throw_exception("Unable to retrieve model-xml-file for unit \"" .. tostring(l_27_1) .. "\".")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	return l_27_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceManager.get_sequence_file = function(l_28_0, l_28_1)
	return l_28_0._sequence_file_map[l_28_1]
end

CoreSequenceManager.parse_event = function(l_29_0, l_29_1, l_29_2)
	local l_29_8, l_29_9, l_29_10, l_29_11 = nil
	local l_29_3 = l_29_0._event_element_class_map[l_29_1:name()]
	if l_29_3 ~= nil then
		local l_29_4, l_29_5 = l_29_3:new, l_29_3
		local l_29_6 = l_29_1
		local l_29_7 = l_29_2
		return l_29_4(l_29_5, l_29_6, l_29_7)
	else
		if l_29_1:name() == "xdefine" or #l_29_1:name() == 0 then
			return nil
		end
	else
		Application:throw_exception("Unit \"" .. tostring(l_29_2._name) .. "\" has an invalid element \"" .. tostring(l_29_1:name()) .. "\".")
	end
end

CoreSequenceManager.run_sequence_simple = function(l_30_0, l_30_1, l_30_2, l_30_3)
	l_30_0:run_sequence_simple2(l_30_0, l_30_1, "", l_30_2, l_30_3)
end

CoreSequenceManager.run_sequence_simple2 = function(l_31_0, l_31_1, l_31_2, l_31_3, l_31_4)
	l_31_0:run_sequence_simple3(l_31_0, l_31_1, l_31_2, l_31_3, l_31_3, l_31_4)
end

CoreSequenceManager.run_sequence_simple3 = function(l_32_0, l_32_1, l_32_2, l_32_3, l_32_4, l_32_5)
	if alive(l_32_4) then
		l_32_0:run_sequence(l_32_1, l_32_2, l_32_3, l_32_4, nil, math.UP, l_32_4:position(), -math.UP, 0, Vector3(), l_32_5)
	end
end

CoreSequenceManager.run_sequence = function(l_33_0, l_33_1, l_33_2, l_33_3, l_33_4, l_33_5, l_33_6, l_33_7, l_33_8, l_33_9, l_33_10, l_33_11)
	if alive(l_33_4) then
		local l_33_12 = l_33_0:get(l_33_4:name(), true)
	if l_33_12 then
		end
		l_33_12:run_sequence(l_33_1, l_33_2, l_33_3, l_33_4, l_33_5, l_33_6, l_33_7, l_33_8, l_33_9, l_33_10, l_33_11)
	end
end

CoreSequenceManager.get_body_param = function(l_34_0, l_34_1, l_34_2, l_34_3)
	do
		local l_34_4 = l_34_0:get(l_34_1, true)
		if l_34_4 then
			local l_34_5 = l_34_4._bodies[l_34_2]
			if l_34_5 then
				return l_34_5:get_body_param(l_34_3)
		else
			end
		end
		return nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceManager.add_time_callback = function(l_35_0, l_35_1, l_35_2, l_35_3, ...)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	{func = l_35_1, delay = tonumber(l_35_2) or 0}.time = TimerManager:game():time() + ({func = l_35_1, delay = tonumber(l_35_2) or 0}).delay
	 -- DECOMPILER ERROR: Confused about usage of registers!

	{func = l_35_1, delay = tonumber(l_35_2) or 0}.repeat_nr = tonumber(l_35_3) or 1
	local l_35_5 = nil
	l_35_5.params = {...}
	local l_35_6 = l_35_0._time_callback_map:add
	local l_35_7 = l_35_0._time_callback_map
	return l_35_6(l_35_7, l_35_5)
end

CoreSequenceManager.remove_time_callback = function(l_36_0, l_36_1)
	l_36_0._time_callback_map:remove(l_36_1)
end

CoreSequenceManager.add_retry_callback = function(l_37_0, l_37_1, l_37_2, l_37_3)
	if not l_37_3 or not l_37_2() then
		if not l_37_0._retry_callback_list[l_37_1] then
			l_37_0._retry_callback_list[l_37_1] = {}
			l_37_0._retry_callback_indices[l_37_1] = 0
		end
		if l_37_0._retry_callback_indices[l_37_1] - 1 < 1 then
			local l_37_4, l_37_5, l_37_6 = 1
			l_37_5 = l_37_0._retry_callback_indices
			l_37_5[l_37_1] = 1
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		table.insert(l_37_0._retry_callback_list[l_37_1], l_37_4, l_37_2)
	end
end

CoreSequenceManager.add_callback = function(l_38_0, l_38_1)
	l_38_0._last_callback_id = l_38_0._last_callback_id + 1
	l_38_0._callback_map[l_38_0._last_callback_id] = l_38_1
	return l_38_0._last_callback_id
end

CoreSequenceManager.remove_callback = function(l_39_0, l_39_1)
	l_39_0._callback_map[l_39_1] = nil
end

CoreSequenceManager.update = function(l_40_0, l_40_1, l_40_2)
	local l_40_3, l_40_6, l_40_7, l_40_8, l_40_9, l_40_10, l_40_11, l_40_12, l_40_13, l_40_14, l_40_15, l_40_16, l_40_17, l_40_18, l_40_19, l_40_20, l_40_21, l_40_22, l_40_23, l_40_24, l_40_25, l_40_26, l_40_27, l_40_28, l_40_29, l_40_30, l_40_31, l_40_32, l_40_33, l_40_34, l_40_35, l_40_36, l_40_37, l_40_38, l_40_39, l_40_41, l_40_42, l_40_43, l_40_44, l_40_45, l_40_46 = nil
	for i_0,i_1 in l_40_0._time_callback_map:bottom_top_iterator() do
		if i_1.time <= l_40_1 then
			if i_1.params then
				i_1.func(unpack(i_1.params))
			end
			if i_1.repeat_nr > 1 then
				i_1.time = l_40_1 + i_1.delay + (l_40_1 - i_1.time)
				i_1.repeat_nr = i_1.repeat_nr - 1
			end
		elseif not l_40_3 then
			l_40_3 = {}
		end
		table.insert(l_40_3, i_0)
	end
	if l_40_3 then
		for i_0,i_1 in ipairs(l_40_3) do
			l_40_0._time_callback_map:remove(i_1)
		end
	end
	for i_0,i_1 in pairs(l_40_0._retry_callback_list) do
		if #l_40_0._retry_callback_list[i_0] > 0 then
			if l_40_0._retry_callback_list[i_0][l_40_0._retry_callback_indices[i_0]]() then
				table.remove(l_40_0._retry_callback_list[i_0], l_40_0._retry_callback_indices[i_0])
				l_40_0._retry_callback_indices[i_0] = l_40_0._retry_callback_indices[i_0] - 1
			end
			l_40_0._retry_callback_indices[i_0] = l_40_0._retry_callback_indices[i_0] + 1
			if #l_40_0._retry_callback_list[i_0] < l_40_0._retry_callback_indices[i_0] then
				l_40_0._retry_callback_indices[i_0] = 1
			end
		else
			l_40_0._retry_callback_list[i_0] = nil
		end
	end
	for i_0,i_1 in pairs(l_40_0._callback_map) do
		i_1(l_40_1, l_40_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceManager.preload = function(l_41_0)
	local l_41_5, l_41_6, l_41_7, l_41_8, l_41_9, l_41_10 = nil
	local l_41_1 = UnitDatabase:get_loaded_unit_data()
	for i_0,i_1 in ipairs(l_41_1) do
		if i_1:preloaded() and l_41_0:has(i_1:name()) then
			l_41_0:get(i_1:name(), true)
		end
	end
end

CoreSequenceManager.reload = function(l_42_0)
	local l_42_5, l_42_6, l_42_7 = nil
	local l_42_1 = l_42_0._unit_elements
	l_42_0:clear_cache()
	for i_0,i_1 in pairs(l_42_1) do
		World:reload_unit(i_0)
	end
end

CoreSequenceManager.clear_cache = function(l_43_0)
	l_43_0:internal_load()
	l_43_0._unit_elements = {}
	l_43_0._unit_element_file_map = {}
end

CoreSequenceManager.reload_unit = function(l_44_0, l_44_1, l_44_2)
	local l_44_3 = l_44_1:name()
	l_44_0:remove_cache(l_44_3)
	if not l_44_2 then
		World:reload_unit(l_44_3)
		Application:reload_material_config(l_44_1:material_config())
	end
end

CoreSequenceManager.remove_cache = function(l_45_0, l_45_1)
	local l_45_7, l_45_8, l_45_9 = nil
	l_45_0._unit_elements[l_45_1] = nil
	local l_45_2 = UnitDatabase:get_unit_data(l_45_1)
	local l_45_3 = l_45_2:model_script_data()
	if l_45_3 then
		for i_0 in l_45_3:children() do
		if i_0:name() == "sequence_manager" and i_0:parameter("file") then
			end
			l_45_0._unit_element_file_map[i_0:parameter("file")] = nil
		end
		do return end
	end
end

CoreSequenceManager.test = function(l_46_0, l_46_1, l_46_2, l_46_3)
	local l_46_8, l_46_9, l_46_15, l_46_16, l_46_17, l_46_18 = nil
	local l_46_4 = {}
	if l_46_1 then
		for i_0,i_1 in ipairs(l_46_1) do
			l_46_4[i_1] = true
		end
	end
	local l_46_10 = UnitDatabase:get_all_unit_data()
	local l_46_11 = 0
	for i_0,i_1 in ipairs(l_46_10) do
		if l_46_0:has(i_1:name()) and not l_46_4[i_1:name()] then
			cat_debug("debug", "Testing unit: " .. i_1:name())
			if l_46_0:get(i_1:name()) then
				l_46_0:test_unit_by_name(i_1:name(), l_46_2, l_46_3)
			end
			l_46_11 = l_46_11 + 1
		end
	end
	cat_debug("debug", "Test done! " .. l_46_11 .. " units tested.")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceManager.test_unit_by_name = function(l_47_0, l_47_1, l_47_2, l_47_3)
	do
		if l_47_2 or not l_47_3 then
			local l_47_6 = nil
			l_47_0:test_unit_variations(World:spawn_unit(l_47_1, Vector3(math.random(-5000, 5000), math.random(-5000, 5000), math.random(-5000, 5000)), Rotation()))
			if alive(World:spawn_unit(l_47_1, Vector3(math.random(-5000, 5000), math.random(-5000, 5000), math.random(-5000, 5000)), Rotation())) then
				World:spawn_unit(l_47_1, Vector3(math.random(-5000, 5000), math.random(-5000, 5000), math.random(-5000, 5000)), Rotation()):set_slot(0)
			end
			l_47_0:test_unit_damage(World:spawn_unit(l_47_1, l_47_6, Rotation()))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if alive(World:spawn_unit(l_47_1, l_47_6, Rotation())) then
				World:spawn_unit(l_47_1, l_47_6, Rotation()):set_slot(0)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 24 
end

CoreSequenceManager.test_unit_variations = function(l_48_0, l_48_1)
	if alive(l_48_1) and l_48_1:damage() then
		local l_48_2 = l_48_0._unit_elements[l_48_1:name()]
		local l_48_3 = l_48_2:get_parameter_sequence_name_list("editable_state", true)
	if #l_48_3 > 0 then
		end
		local l_48_4 = l_48_2:get_parameter_sequence_name_list("reset_editable_state", true)
		if #l_48_4 == 0 then
			Application:error("Unit had " .. #l_48_3 .. " sequences with the attribute \"editable_state\" set to true but no sequence with the attribute \"reset_editable_state\" set to true.")
		elseif #l_48_4 > 1 then
			Application:error("Too many sequences with the attribute \"reset_editable_state\". Found " .. #l_48_4 .. ", should only be 1.")
		end
		local l_48_5 = {}
		local l_48_9 = "change_state"
		local l_48_10 = l_48_1
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0,i_1 in l_48_9 do
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_48_1:position()(-math.UP, 0, (Vector3())(nil))
			if #l_48_4 > 0 then
				l_48_2:run_sequence(l_48_4[1], unpack(l_48_5))
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreSequenceManager.test_unit_damage = function(l_49_0, l_49_1)
	local l_49_6, l_49_7, l_49_8, l_49_9, l_49_10, l_49_14, l_49_15 = nil
	if alive(l_49_1) and l_49_1:damage() then
		local l_49_2 = l_49_0._unit_elements[l_49_1:name()]
		for i_0,i_1 in pairs(l_49_2._bodies) do
		if alive(l_49_1) then
			end
			for i_0,i_1 in pairs(i_1._first_endurance) do
				if alive(l_49_1:body(l_49_11)) then
					cat_debug("debug", "-Damaging endurance_type: " .. i_0 .. ", on body:" .. l_49_11)
					if l_49_1:body(l_49_11):extension().damage["damage_" .. i_0] then
						for l_49_22 = 1, 10 do
							local l_49_20, l_49_21, l_49_22 = , 0.5
							l_49_21(l_49_20:extension().damage, l_49_1, Vector3(0, 0, 1), l_49_20:position(), Vector3(0, 0, -1), l_49_22, Vector3(0, 0, 10000))
							l_49_22 = l_49_22 * 2
						end
					end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				else
					Application:error("Invalid endurance_type \"" .. l_49_18 .. "\"!")
				end
			end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		else
			do return end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceManager.load_element_data = function(l_50_0, l_50_1, l_50_2, l_50_3)
	l_50_0._event_element_class_map[l_50_2].load(l_50_1, l_50_3)
end

CoreSequenceManager.save = function(l_51_0, l_51_1)
	local l_51_8, l_51_9 = nil
	local l_51_2 = {}
	local l_51_3 = l_51_0:save_global_save_data(l_51_2)
	local l_51_4 = {}
	for i_0,i_1 in pairs(l_51_0._unit_elements) do
	if not i_1:save(l_51_4) then
		end
	end
	if l_51_3 then
		l_51_2.unit_element_map = l_51_4
		l_51_1.CoreSequenceManager = l_51_2
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceManager.load = function(l_52_0, l_52_1)
	local l_52_6, l_52_7, l_52_8 = nil
	local l_52_2 = l_52_1.CoreSequenceManager
	if l_52_2 then
		if l_52_2.unit_element_map then
			for i_0,i_1 in pairs(l_52_2.unit_element_map) do
				if l_52_0:get(i_0, true) then
					l_52_0:get(i_0, true):load(l_52_2)
				end
			end
		end
		l_52_0:load_global_save_data(l_52_2)
	end
end

CoreSequenceManager.save_global_save_data = function(l_53_0, l_53_1)
	if next(SequenceEnvironment.g_save_data) then
		local l_53_2 = {}
		l_53_2.g_save_data = table.map_copy(SequenceEnvironment.g_save_data)
		l_53_1.SequenceEnvironment = l_53_2
		return true
	else
		return false
	end
end

CoreSequenceManager.load_global_save_data = function(l_54_0, l_54_1)
	local l_54_2 = l_54_1.SequenceEnvironment
	if l_54_2 then
		SequenceEnvironment.g_save_data = table.map_copy(l_54_2.g_save_data)
		return true
	else
		return false
	end
end

CoreSequenceManager.internal_load = function(l_55_0)
	if File:config_exists(l_55_0.GLOBAL_CORE_SEQUENCE_PATH) then
		local l_55_1 = File:parse_xml(l_55_0.GLOBAL_CORE_SEQUENCE_PATH)
	if l_55_1 then
		end
	if l_55_1:name() == "sequence_manager" then
		end
		SequenceEnvironment:init_static_env()
		l_55_0._global_core_unit_element = get_core_or_local("UnitElement"):new(l_55_1, "[Global core sequence]", true)
		l_55_0._global_core_unit_element.get_sequence_element = managers.sequence.get_global_sequence
	end
	if File:config_exists(l_55_0.GLOBAL_SEQUENCE_PATH) then
		local l_55_2 = File:parse_xml(l_55_0.GLOBAL_SEQUENCE_PATH)
	if l_55_2 then
		end
	if l_55_2:name() == "sequence_manager" then
		end
		SequenceEnvironment:init_static_env()
		l_55_0._global_unit_element = get_core_or_local("UnitElement"):new(l_55_2, "[Global sequence]", true)
	end
	SequenceEnvironment:init_static_env()
end

CoreSequenceManager.add_area_damage_callback = function(l_56_0, l_56_1)
	l_56_0._last_area_damage_callback_id = l_56_0._last_area_damage_callback_id + 1
	l_56_0._area_damage_callback_map[l_56_0._last_area_damage_callback_id] = l_56_1
	return l_56_0._last_area_damage_callback_id
end

CoreSequenceManager.remove_area_damage_callback = function(l_57_0, l_57_1)
	l_57_0._area_damage_callback_map[l_57_1] = nil
end

CoreSequenceManager.do_area_damage = function(l_58_0, l_58_1, l_58_2, l_58_3, l_58_4, l_58_5, l_58_6, l_58_7, l_58_8, l_58_9, l_58_10, l_58_11, l_58_12, l_58_13)
	local l_58_14 = {}
	local l_58_15 = {}
	local l_58_16 = {}
	local l_58_17 = {}
	local l_58_18 = {}
	local l_58_19 = {}
	local l_58_20 = {}
	local l_58_21, l_58_22 = nil, nil
	if alive(l_58_9) then
		l_58_21 = l_58_2
		l_58_22 = l_58_9:key()
	else
		l_58_9 = l_58_2
		l_58_21 = World
	end
	local l_58_27 = l_58_2:find_bodies
	local l_58_28 = l_58_2
	l_58_27 = l_58_27(l_58_28, "intersect", "sphere", l_58_3, l_58_4, l_58_0._area_damage_mask - l_58_11)
	local l_58_23 = nil
	l_58_28 = ipairs
	l_58_23 = l_58_27
	l_58_28 = l_58_28(l_58_23)
	for i_0,i_1 in l_58_28 do
		if alive(l_58_26) then
			local l_58_29 = l_58_26:unit()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if (not l_58_29 or l_58_29) and l_58_29:key() ~= l_58_22 then
			if l_58_26:extension() then
				local l_58_31, l_58_32 = nil
			end
		if l_58_26:extension().damage then
			end
			local l_58_33 = nil
			local l_58_34 = nil
			local l_58_35 = nil
			local l_58_36 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_58_12 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_58_5 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_58_0:do_area_damage_on_body(l_58_33, l_58_26, l_58_35, l_58_1, l_58_2, -l_58_26:center_of_mass() - l_58_3:normalized(), l_58_3, l_58_26:center_of_mass() - l_58_3:normalized(), nil, l_58_13, l_58_9, l_58_10)
		if not l_58_14[l_58_34] then
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_58_37, l_58_38 = nil
			if l_58_0 then
				if type(R39_PC135) ~= "number" then
					Application:error("Unit \"" .. tostring(l_58_33:name()) .. "\" has an invalid damage extension \"" .. tostring(class_name(getmetatable(l_58_38))) .. "\", its \"damage_" .. tostring(l_58_1) .. "\"-function returned the invalid values \"" .. tostring(l_58_0:do_area_damage_on_unit(l_58_33, l_58_26, (l_58_33:damage()), l_58_1, l_58_2, -l_58_26:center_of_mass() - l_58_3:normalized(), l_58_3, l_58_26:center_of_mass() - l_58_3:normalized(), nil, l_58_13, l_58_13, l_58_9, l_58_10)) .. ", " .. tostring(R50_PC164) .. R50_PC164)
				end
			elseif l_58_0 > 0 then
				l_58_15[l_58_34] = l_58_33
			if l_58_0:do_area_damage_on_unit(l_58_33, l_58_26, (l_58_33:damage()), l_58_1, l_58_2, -l_58_26:center_of_mass() - l_58_3:normalized(), l_58_3, l_58_26:center_of_mass() - l_58_3:normalized(), nil, l_58_13, l_58_13, l_58_9, l_58_10) then
				end
				l_58_16[l_58_34] = l_58_33
			end
			l_58_14[l_58_34] = true
		end
	end
	local l_58_39 = l_58_4
	for l_58_39,i_1 in ipairs(l_58_2:find_units("sphere", l_58_3, l_58_39, l_58_0._beings_mask - l_58_11)) do
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if ((alive(i_1) and not i_1:key()) or i_1:key()) and i_1:key() ~= l_58_22 and not l_58_14[i_1:key()] and l_58_40:damage() then
			local l_58_42, l_58_43 = nil
		if l_58_0:is_hit_by_area_damage(l_58_40, l_58_3, l_58_21, l_58_9) then
			end
			local l_58_44 = nil
			local l_58_45 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_58_12 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_58_5 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_58_46, l_58_47 = nil
		if l_58_0 then
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if type(R39_PC135) ~= "number" then
				Application:error(R40_PC240)
			end
		elseif l_58_0 > 0 then
			l_58_18[l_58_43] = l_58_42
		if l_58_0:do_area_damage_on_unit(l_58_42, R39_PC135, R40_PC240, l_58_1, l_58_2, -(l_58_42:position() - l_58_3:normalized()), l_58_3, (l_58_42:position() - l_58_3:normalized()), nil, l_58_13, l_58_9, l_58_10) then
			end
			l_58_19[l_58_43] = l_58_42
		end
	end
	if l_58_7 then
		if l_58_8 then
			World:play_physic_effect(l_58_7, l_58_3, l_58_4, l_58_8)
		end
	else
		World:play_physic_effect(l_58_7, l_58_3, l_58_4)
	end
	for i_0,i_1 in pairs(l_58_0._area_damage_callback_map) do
		i_1(i_0, l_58_19, l_58_18, l_58_16, l_58_15, l_58_20, l_58_17)
	end
	return l_58_19, l_58_18, l_58_16, l_58_15, l_58_20, l_58_17
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceManager.do_area_damage_on_body = function(l_59_0, l_59_1, l_59_2, l_59_3, l_59_4, l_59_5, l_59_6, l_59_7, l_59_8, l_59_9, l_59_10, l_59_11, l_59_12)
	local l_59_13, l_59_14 = l_59_3:damage_by_area, l_59_3
	local l_59_15 = l_59_4
	local l_59_16 = l_59_5
	local l_59_17 = l_59_6
	local l_59_18 = l_59_7
	local l_59_19 = l_59_8
	local l_59_20 = l_59_9
	do
		if not l_59_10 then
			return l_59_13(l_59_14, l_59_15, l_59_16, l_59_17, l_59_18, l_59_19, l_59_20, Vector3())
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 12 
end

CoreSequenceManager.do_area_damage_on_unit = function(l_60_0, l_60_1, l_60_2, l_60_3, l_60_4, l_60_5, l_60_6, l_60_7, l_60_8, l_60_9, l_60_10, l_60_11, l_60_12)
	l_60_3:set_direct_attack_unit(l_60_12)
	local l_60_13 = {}
	local l_60_14, l_60_15 = l_60_3:damage_by_area, l_60_3
	local l_60_16 = l_60_4
	local l_60_17 = l_60_5
	local l_60_18 = l_60_2
	local l_60_19 = l_60_6
	local l_60_20 = l_60_7
	local l_60_21 = l_60_8
	local l_60_22 = l_60_9
	do
		if not l_60_10 then
			l_60_15, l_60_14 = .end, l_60_14(l_60_15, l_60_16, l_60_17, l_60_18, l_60_19, l_60_20, l_60_21, l_60_22, Vector3())
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		end
		l_60_14, l_60_15 = l_60_3:set_direct_attack_unit, l_60_3
		l_60_16 = nil
		l_60_14(l_60_15, l_60_16)
		l_60_14 = unpack
		l_60_15 = l_60_13
		return l_60_14(l_60_15)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceManager.is_hit_by_area_damage = function(l_61_0, l_61_1, l_61_2, l_61_3, l_61_4)
	local l_61_5, l_61_9, l_61_10, l_61_11, l_61_12 = nil
	if l_61_1:unit_data() and l_61_1:unit_data().target_objects then
		for i_0,i_1 in pairs(l_61_1:unit_data().target_objects) do
			local l_61_6 = false
			l_61_6 = true
			local l_61_16 = l_61_3:raycast
			local l_61_17 = l_61_3
			local l_61_18 = "ray"
			local l_61_19 = l_61_15:position()
			local l_61_20 = l_61_2
			local l_61_21 = "slot_mask"
			l_61_16 = l_61_16(l_61_17, l_61_18, l_61_19, l_61_20, l_61_21, l_61_0._target_world_mask, "ignore_unit", {l_61_1, l_61_4})
			l_61_5 = l_61_16
			if not l_61_5 then
				l_61_16 = true
				l_61_17, l_61_18 = l_61_15:position, l_61_15
				l_61_18, l_61_17 = .end, l_61_17(l_61_18)
				return l_61_16, l_61_17, l_61_18, l_61_19, l_61_20, l_61_21
			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_61_6 then
		local l_61_22, l_61_23 = , l_61_3:raycast
		local l_61_24 = l_61_3
		local l_61_25 = "ray"
		local l_61_26 = l_61_1:position()
		local l_61_27 = l_61_2
		local l_61_28 = "slot_mask"
		local l_61_29 = l_61_0._target_world_mask
		local l_61_30 = "ignore_unit"
		l_61_23 = l_61_23(l_61_24, l_61_25, l_61_26, l_61_27, l_61_28, l_61_29, l_61_30, {l_61_1, l_61_4})
		l_61_5 = l_61_23
	if not l_61_5 then
		end
		l_61_23 = true
		l_61_24, l_61_25 = l_61_1:position, l_61_1
		l_61_25, l_61_24 = .end, l_61_24(l_61_25)
		return l_61_23, l_61_24, l_61_25, l_61_26, l_61_27, l_61_28, l_61_29, l_61_30
	end
	return false
end

CoreSequenceManager.get_editable_state_sequence_list = function(l_62_0, l_62_1)
	local l_62_2, l_62_3 = l_62_0:get_sequence_list, l_62_0
	local l_62_4 = l_62_1
	local l_62_5 = "editable_state"
	local l_62_6 = true
	return l_62_2(l_62_3, l_62_4, l_62_5, l_62_6)
end

CoreSequenceManager.get_reset_editable_state_sequence_list = function(l_63_0, l_63_1)
	local l_63_2, l_63_3 = l_63_0:get_sequence_list, l_63_0
	local l_63_4 = l_63_1
	local l_63_5 = "reset_editable_state"
	local l_63_6 = true
	return l_63_2(l_63_3, l_63_4, l_63_5, l_63_6)
end

CoreSequenceManager.get_triggable_sequence_list = function(l_64_0, l_64_1)
	local l_64_2, l_64_3 = l_64_0:get_sequence_list, l_64_0
	local l_64_4 = l_64_1
	local l_64_5 = "triggable"
	local l_64_6 = true
	return l_64_2(l_64_3, l_64_4, l_64_5, l_64_6)
end

CoreSequenceManager.get_trigger_list = function(l_65_0, l_65_1)
	local l_65_5 = l_65_0:get
	l_65_5 = l_65_5(l_65_0, l_65_1, true)
	local l_65_2 = nil
	if l_65_5 then
		local l_65_3, l_65_4 = l_65_5
		return l_65_2(l_65_3)
	else
		return l_65_2
		l_65_2 = {}
	end
end

CoreSequenceManager.get_trigger_map = function(l_66_0, l_66_1)
	local l_66_5 = l_66_0:get
	l_66_5 = l_66_5(l_66_0, l_66_1, true)
	local l_66_2 = nil
	if l_66_5 then
		local l_66_3, l_66_4 = l_66_5
		return l_66_2(l_66_3)
	else
		return l_66_2
		l_66_2 = {}
	end
end

CoreSequenceManager.get_sequence_list = function(l_67_0, l_67_1, l_67_2, l_67_3)
	local l_67_4 = {}
	local l_67_5 = l_67_0:get(l_67_1, true)
	if l_67_5 then
		if l_67_2 then
			l_67_4 = l_67_5:get_parameter_sequence_name_list(l_67_2, l_67_3)
		end
	else
		l_67_4 = l_67_5:get_sequence_name_list()
	end
	return l_67_4
end

CoreSequenceManager.has_sequence_name = function(l_68_0, l_68_1, l_68_2, l_68_3)
	local l_68_4 = l_68_0:get(l_68_1, l_68_3)
	if l_68_4 then
		local l_68_5, l_68_6 = l_68_4:has_sequence_name, l_68_4
		local l_68_7 = l_68_2
		return l_68_5(l_68_6, l_68_7)
	end
	return false
end

CoreSequenceManager.get_unit_count = function(l_69_0)
	for i_0 in pairs(l_69_0._unit_elements) do
	end
	return 0 + 1
end

CoreSequenceManager.set_effect_spawner_enabled = function(l_70_0, l_70_1)
	if l_70_1 then
		l_70_0:activate()
	else
		local l_70_2 = l_70_0:effect_id()
		if l_70_2 ~= -1 then
			l_70_0:kill_effect()
		end
	else
		return false
	end
	return true
end

if not CoreSequenceEnvironment then
	CoreSequenceEnvironment = class()
end
if not SequenceEnvironment then
	SequenceEnvironment = class(CoreSequenceEnvironment)
end
if not CoreSequenceEnvironment.self then
	CoreSequenceEnvironment.self = {}
end
if not CoreSequenceEnvironment.g_save_data then
	CoreSequenceEnvironment.g_save_data = {}
end
rawset(CoreSequenceEnvironment, "str", tostring)
rawset(CoreSequenceEnvironment, "nr", tonumber)
rawset(CoreSequenceEnvironment, "v", Vector3)
rawset(CoreSequenceEnvironment, "rot", Rotation)
rawset(CoreSequenceEnvironment, "print", callback(nil, _G, "cat_print", "sequence"))
rawset(CoreSequenceEnvironment, "alive", alive)
rawset(CoreSequenceEnvironment, "clamp", math.clamp)
rawset(CoreSequenceEnvironment, "rand", math.random)
rawset(CoreSequenceEnvironment, "string", string)
rawset(CoreSequenceEnvironment, "stack_dump", Application.stack_dump)
CoreSequenceEnvironment.init = function(l_71_0, l_71_1, l_71_2, l_71_3, l_71_4, l_71_5, l_71_6, l_71_7, l_71_8, l_71_9, l_71_10, l_71_11, l_71_12)
	l_71_0.damage_type = l_71_1
	l_71_0.src_unit = l_71_2
	l_71_0.dest_body = l_71_4
	l_71_0.dest_normal = l_71_5
	l_71_0.pos = l_71_6
	l_71_0.dir = l_71_7
	l_71_0.damage = l_71_8
	l_71_0.velocity = l_71_9
	l_71_0.g_vars = l_71_11._global_vars
	do
		if not l_71_10 then
			l_71_0.params = {}
		end
		l_71_0.__run_params = clone(l_71_0.params)
		l_71_0.dest_unit = l_71_3
		if l_71_12 or l_71_3:damage() then
			l_71_0.vars = l_71_3:damage()._variables
		else
			SequenceEnvironment.self = l_71_0
			SequenceEnvironment.element = l_71_11
			l_71_0:print_vars()
			Application:error("Unit doesn't have a damage extension.")
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.init_static_env = function(l_72_0)
	l_72_0.damage_type = "init"
	l_72_0.src_unit = nil
	l_72_0.dest_body = nil
	l_72_0.dest_normal = Vector3(0, 0, 1)
	l_72_0.pos = Vector3()
	l_72_0.dir = Vector3(0, 0, -1)
	l_72_0.damage = 0
	l_72_0.velocity = Vector3()
	local l_72_1 = managers.sequence:get_global_core_unit_element()
	if l_72_1 then
		l_72_0.g_vars = table.map_copy(l_72_1:get_global_set_var_map())
		l_72_0.vars = table.map_copy(l_72_1:get_set_var_map())
	end
	local l_72_2 = managers.sequence:get_global_unit_element()
	if l_72_2 then
		l_72_0.g_vars = table.map_copy(l_72_2:get_global_set_var_map())
		l_72_0.vars = table.map_copy(l_72_2:get_set_var_map())
	end
	l_72_0.params = {}
	l_72_0.__run_params = clone(l_72_0.params)
	l_72_0.dest_unit = nil
end

CoreSequenceEnvironment.src_unit_pos = function()
	local l_73_0, l_73_1 = SequenceEnvironment.self.src_unit:position, SequenceEnvironment.self.src_unit
	return l_73_0(l_73_1)
end

CoreSequenceEnvironment.src_unit_rot = function()
	local l_74_0, l_74_1 = SequenceEnvironment.self.src_unit:rotation, SequenceEnvironment.self.src_unit
	return l_74_0(l_74_1)
end

CoreSequenceEnvironment.dest_unit_pos = function()
	local l_75_0, l_75_1 = SequenceEnvironment.self.dest_unit:position, SequenceEnvironment.self.dest_unit
	return l_75_0(l_75_1)
end

CoreSequenceEnvironment.dest_unit_rot = function()
	local l_76_0, l_76_1 = SequenceEnvironment.self.dest_unit:rotation, SequenceEnvironment.self.dest_unit
	return l_76_0(l_76_1)
end

CoreSequenceEnvironment.dest_body_pos = function()
	local l_77_0, l_77_1 = SequenceEnvironment.self.dest_body:position, SequenceEnvironment.self.dest_body
	return l_77_0(l_77_1)
end

CoreSequenceEnvironment.dest_body_rot = function()
	local l_78_0, l_78_1 = SequenceEnvironment.self.dest_body:rotation, SequenceEnvironment.self.dest_body
	return l_78_0(l_78_1)
end

CoreSequenceEnvironment.object = function(l_79_0)
	do
		if l_79_0 then
			return SequenceEnvironment.self.dest_unit:get_object(l_79_0)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.body = function(l_80_0)
	do
		if l_80_0 then
			return SequenceEnvironment.self.dest_unit:body(l_80_0)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_pos = function(l_81_0)
	local l_81_4, l_81_5, l_81_6 = nil
	if not l_81_0 or SequenceEnvironment.self.dest_unit:get_object(l_81_0) then
		local l_81_2, l_81_3 = , SequenceEnvironment.self.dest_unit:get_object(l_81_0):position
		return l_81_3(SequenceEnvironment.self.dest_unit:get_object(l_81_0))
	else
		local l_81_8 = nil
		local l_81_9 = SequenceEnvironment.element:print_error
		local l_81_10 = SequenceEnvironment.element
		do
			local l_81_11 = "Invalid object name \"" .. tostring(l_81_0) .. "\" in domain function \"object_pos\"."
			l_81_9(l_81_10, l_81_11, true, SequenceEnvironment.self)
			l_81_9 = Vector3
			local l_81_7 = nil
			return l_81_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_rot = function(l_82_0)
	local l_82_4, l_82_5, l_82_6 = nil
	if not l_82_0 or SequenceEnvironment.self.dest_unit:get_object(l_82_0) then
		local l_82_2, l_82_3 = , SequenceEnvironment.self.dest_unit:get_object(l_82_0):rotation
		return l_82_3(SequenceEnvironment.self.dest_unit:get_object(l_82_0))
	else
		local l_82_8 = nil
		local l_82_9 = SequenceEnvironment.element:print_error
		local l_82_10 = SequenceEnvironment.element
		do
			local l_82_11 = "Invalid object name \"" .. tostring(l_82_0) .. "\" in domain function \"object_rot\"."
			l_82_9(l_82_10, l_82_11, true, SequenceEnvironment.self)
			l_82_9 = Rotation
			local l_82_7 = nil
			return l_82_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_rot_x = function(l_83_0)
	local l_83_4, l_83_5, l_83_6 = nil
	if not l_83_0 or SequenceEnvironment.self.dest_unit:get_object(l_83_0) then
		local l_83_2, l_83_3 = , SequenceEnvironment.self.dest_unit:get_object(l_83_0):rotation():x
		return l_83_3(SequenceEnvironment.self.dest_unit:get_object(l_83_0):rotation())
	else
		local l_83_8 = nil
		local l_83_9 = SequenceEnvironment.element:print_error
		local l_83_10 = SequenceEnvironment.element
		do
			local l_83_11 = "Invalid object name \"" .. tostring(l_83_0) .. "\" in domain function \"object_rot_x\"."
			l_83_9(l_83_10, l_83_11, true, SequenceEnvironment.self)
			l_83_9 = Vector3
			local l_83_7 = nil
			return l_83_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_rot_y = function(l_84_0)
	local l_84_4, l_84_5, l_84_6 = nil
	if not l_84_0 or SequenceEnvironment.self.dest_unit:get_object(l_84_0) then
		local l_84_2, l_84_3 = , SequenceEnvironment.self.dest_unit:get_object(l_84_0):rotation():y
		return l_84_3(SequenceEnvironment.self.dest_unit:get_object(l_84_0):rotation())
	else
		local l_84_8 = nil
		local l_84_9 = SequenceEnvironment.element:print_error
		local l_84_10 = SequenceEnvironment.element
		do
			local l_84_11 = "Invalid object name \"" .. tostring(l_84_0) .. "\" in domain function \"object_rot_y\"."
			l_84_9(l_84_10, l_84_11, true, SequenceEnvironment.self)
			l_84_9 = Vector3
			local l_84_7 = nil
			return l_84_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_rot_z = function(l_85_0)
	local l_85_4, l_85_5, l_85_6 = nil
	if not l_85_0 or SequenceEnvironment.self.dest_unit:get_object(l_85_0) then
		local l_85_2, l_85_3 = , SequenceEnvironment.self.dest_unit:get_object(l_85_0):rotation():z
		return l_85_3(SequenceEnvironment.self.dest_unit:get_object(l_85_0):rotation())
	else
		local l_85_8 = nil
		local l_85_9 = SequenceEnvironment.element:print_error
		local l_85_10 = SequenceEnvironment.element
		do
			local l_85_11 = "Invalid object name \"" .. tostring(l_85_0) .. "\" in domain function \"object_rot_z\"."
			l_85_9(l_85_10, l_85_11, true, SequenceEnvironment.self)
			l_85_9 = Vector3
			local l_85_7 = nil
			return l_85_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_local_pos = function(l_86_0)
	local l_86_4, l_86_5, l_86_6 = nil
	if not l_86_0 or SequenceEnvironment.self.dest_unit:get_object(l_86_0) then
		local l_86_2, l_86_3 = , SequenceEnvironment.self.dest_unit:get_object(l_86_0):local_position
		return l_86_3(SequenceEnvironment.self.dest_unit:get_object(l_86_0))
	else
		local l_86_8 = nil
		local l_86_9 = SequenceEnvironment.element:print_error
		local l_86_10 = SequenceEnvironment.element
		do
			local l_86_11 = "Invalid object name \"" .. tostring(l_86_0) .. "\" in domain function \"object_local_pos\"."
			l_86_9(l_86_10, l_86_11, true, SequenceEnvironment.self)
			l_86_9 = Vector3
			local l_86_7 = nil
			return l_86_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_local_rot = function(l_87_0)
	local l_87_4, l_87_5, l_87_6 = nil
	if not l_87_0 or SequenceEnvironment.self.dest_unit:get_object(l_87_0) then
		local l_87_2, l_87_3 = , SequenceEnvironment.self.dest_unit:get_object(l_87_0):local_rotation
		return l_87_3(SequenceEnvironment.self.dest_unit:get_object(l_87_0))
	else
		local l_87_8 = nil
		local l_87_9 = SequenceEnvironment.element:print_error
		local l_87_10 = SequenceEnvironment.element
		do
			local l_87_11 = "Invalid object name \"" .. tostring(l_87_0) .. "\" in domain function \"object_local_rot\"."
			l_87_9(l_87_10, l_87_11, true, SequenceEnvironment.self)
			l_87_9 = Rotation
			local l_87_7 = nil
			return l_87_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_local_rot_x = function(l_88_0)
	local l_88_4, l_88_5, l_88_6 = nil
	if not l_88_0 or SequenceEnvironment.self.dest_unit:get_object(l_88_0) then
		local l_88_2, l_88_3 = , SequenceEnvironment.self.dest_unit:get_object(l_88_0):local_rotation():x
		return l_88_3(SequenceEnvironment.self.dest_unit:get_object(l_88_0):local_rotation())
	else
		local l_88_8 = nil
		local l_88_9 = SequenceEnvironment.element:print_error
		local l_88_10 = SequenceEnvironment.element
		do
			local l_88_11 = "Invalid object name \"" .. tostring(l_88_0) .. "\" in domain function \"object_local_rot_x\"."
			l_88_9(l_88_10, l_88_11, true, SequenceEnvironment.self)
			l_88_9 = Vector3
			local l_88_7 = nil
			return l_88_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_local_rot_y = function(l_89_0)
	local l_89_4, l_89_5, l_89_6 = nil
	if not l_89_0 or SequenceEnvironment.self.dest_unit:get_object(l_89_0) then
		local l_89_2, l_89_3 = , SequenceEnvironment.self.dest_unit:get_object(l_89_0):local_rotation():y
		return l_89_3(SequenceEnvironment.self.dest_unit:get_object(l_89_0):local_rotation())
	else
		local l_89_8 = nil
		local l_89_9 = SequenceEnvironment.element:print_error
		local l_89_10 = SequenceEnvironment.element
		do
			local l_89_11 = "Invalid object name \"" .. tostring(l_89_0) .. "\" in domain function \"object_local_rot_y\"."
			l_89_9(l_89_10, l_89_11, true, SequenceEnvironment.self)
			l_89_9 = Vector3
			local l_89_7 = nil
			return l_89_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.object_local_rot_z = function(l_90_0)
	local l_90_4, l_90_5, l_90_6 = nil
	if not l_90_0 or SequenceEnvironment.self.dest_unit:get_object(l_90_0) then
		local l_90_2, l_90_3 = , SequenceEnvironment.self.dest_unit:get_object(l_90_0):local_rotation():z
		return l_90_3(SequenceEnvironment.self.dest_unit:get_object(l_90_0):local_rotation())
	else
		local l_90_8 = nil
		local l_90_9 = SequenceEnvironment.element:print_error
		local l_90_10 = SequenceEnvironment.element
		do
			local l_90_11 = "Invalid object name \"" .. tostring(l_90_0) .. "\" in domain function \"object_local_rot_z\"."
			l_90_9(l_90_10, l_90_11, true, SequenceEnvironment.self)
			l_90_9 = Vector3
			local l_90_7 = nil
			return l_90_9()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSequenceEnvironment.pick = function(...)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return ({...})[math.random(1, #{...})]
end

CoreSequenceEnvironment.rot_sum = function(...)
	local l_92_5, l_92_6 = {}, ...
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_92_1 = .end
	l_92_1 = ipairs
	l_92_1 = l_92_1(l_92_5)
	for i_0,i_1 in l_92_1 do
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	return l_92_6
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceEnvironment.rot_mul = function(l_93_0, l_93_1)
	local l_93_2 = Rotation
	local l_93_3 = l_93_0:yaw() * l_93_1
	local l_93_4 = l_93_0:pitch() * l_93_1
	local l_93_6 = l_93_0:roll
	l_93_6 = l_93_6(l_93_0)
	l_93_6 = l_93_6 * l_93_1
	local l_93_5 = nil
	return l_93_2(l_93_3, l_93_4, l_93_6)
end

CoreSequenceEnvironment.rot_div = function(l_94_0, l_94_1)
	if l_94_1 ~= 0 then
		local l_94_2 = Rotation
		local l_94_3 = l_94_0:yaw() / l_94_1
		local l_94_4 = l_94_0:pitch() / l_94_1
		local l_94_6 = l_94_0:roll
		l_94_6 = l_94_6(l_94_0)
		l_94_6 = l_94_6 / l_94_1
		local l_94_5 = nil
		return l_94_2(l_94_3, l_94_4, l_94_6)
	else
		local l_94_8 = SequenceEnvironment.element:print_error
		local l_94_9 = SequenceEnvironment.element
		local l_94_10 = "The rotation \"" .. tostring(object_name) .. "\" was divided by zero in domain function \"rot_div\"."
		local l_94_11 = true
		l_94_8(l_94_9, l_94_10, l_94_11, SequenceEnvironment.self)
		l_94_8 = Rotation
		local l_94_7 = nil
		return l_94_8()
	end
end

CoreSequenceEnvironment.t = function()
	local l_95_0, l_95_1 = TimerManager:game():time, TimerManager:game()
	return l_95_0(l_95_1)
end

CoreSequenceEnvironment.print_vars = function()
	cat_print("debug", "damage_type: " .. tostring(SequenceEnvironment.self.damage_type))
	cat_print("debug", "src_unit: " .. tostring(SequenceEnvironment.self.src_unit))
	cat_print("debug", "dest_unit: " .. tostring(SequenceEnvironment.self.dest_unit))
	if alive(SequenceEnvironment.self.dest_body) then
		local l_96_5, l_96_6, l_96_7, l_96_8, l_96_9, l_96_10, l_96_11, l_96_12, l_96_13, l_96_14, l_96_15, l_96_16 = cat_print, "debug", "dest_body: ", tostring, SequenceEnvironment.self.dest_body:name(), .end
		l_96_8 = l_96_8(l_96_9, l_96_10, l_96_11, l_96_12, l_96_13, l_96_14, l_96_15, l_96_16)
		l_96_7 = l_96_7 .. l_96_8
		l_96_5(l_96_6, l_96_7)
	else
		cat_print("debug", "dest_body: " .. tostring(SequenceEnvironment.self.dest_body))
	end
	cat_print("debug", "dest_normal: " .. tostring(SequenceEnvironment.self.dest_normal))
	cat_print("debug", "pos: " .. tostring(SequenceEnvironment.self.pos))
	cat_print("debug", "dir: " .. tostring(SequenceEnvironment.self.dir))
	cat_print("debug", "damage: " .. tostring(SequenceEnvironment.self.damage))
	local l_96_4 = cat_print
	l_96_4("debug", "velocity: " .. tostring(SequenceEnvironment.self.velocity))
	l_96_4 = true
	local l_96_0 = nil
	l_96_0 = pairs
	l_96_0 = l_96_0(SequenceEnvironment.self.params)
	for i_0,i_1 in l_96_0 do
		if l_96_4 then
			cat_print("debug", "Parameters:")
			l_96_4 = false
		end
		cat_print("debug", "  params." .. tostring(l_96_3) .. "=" .. tostring(i_1))
	end
	l_96_4 = true
	for i_0,i_1 in pairs(SequenceEnvironment.self.__run_params) do
		if l_96_4 then
			cat_print("debug", "Original parameters:")
			l_96_4 = false
		end
		cat_print("debug", "  params." .. tostring(i_0) .. "=" .. tostring(i_1))
	end
	l_96_4 = true
	for i_0,i_1 in pairs(SequenceEnvironment.self.vars) do
		if l_96_4 then
			cat_print("debug", "Local variables:")
			l_96_4 = false
		end
		cat_print("debug", "  vars." .. tostring(i_0) .. "=" .. tostring(i_1))
	end
	l_96_4 = true
	for i_0,i_1 in pairs(SequenceEnvironment.self.g_vars) do
		if l_96_4 then
			cat_print("debug", "Global variables:")
			l_96_4 = false
		end
		cat_print("debug", "  g_vars." .. tostring(i_0) .. "=" .. tostring(i_1))
	end
	cat_print("debug", SequenceEnvironment.element:get_xml_origin())
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSequenceEnvironment.angle = function(l_97_0, l_97_1, l_97_2)
	if l_97_2 then
		local l_97_3 = math.cross(l_97_0, l_97_2)
		if math.dot(l_97_1, l_97_3) >= 0 then
			local l_97_4, l_97_5 = l_97_0:angle, l_97_0
			local l_97_6 = l_97_1
			return l_97_4(l_97_5, l_97_6)
		else
			local l_97_10 = l_97_0:angle
			l_97_10 = l_97_10(l_97_0, l_97_1)
			l_97_10 = l_97_10 + 180
			return l_97_10
		end
	else
		local l_97_7, l_97_8 = l_97_0:angle, l_97_0
		local l_97_9 = l_97_1
		return l_97_7(l_97_8, l_97_9)
	end
end

CoreSequenceEnvironment.pos_side = function(l_98_0, l_98_1)
	local l_98_2 = l_98_1 - l_98_0:position():normalized()
	local l_98_3 = SequenceEnvironment.dir_side
	local l_98_4 = l_98_0
	local l_98_5 = l_98_2
	return l_98_3(l_98_4, l_98_5)
end

CoreSequenceEnvironment.dir_side = function(l_99_0, l_99_1)
	local l_99_2 = -l_99_1:rotate_with(l_99_0:rotation())
	local l_99_3 = math.abs(l_99_2.x)
	local l_99_4 = math.abs(l_99_2.y)
	local l_99_5 = math.abs(l_99_2.z)
	if l_99_4 <= l_99_3 and l_99_5 <= l_99_3 then
		if l_99_2.x > 0 then
			return "right"
		else
			return "left"
		end
	elseif l_99_5 <= l_99_4 then
		if l_99_2.y > 0 then
			return "front"
		else
			return "back"
		end
	elseif l_99_2.z > 0 then
		return "up"
	else
		return "down"
	end
end

CoreSequenceEnvironment.within_box = function(l_100_0, l_100_1, l_100_2)
	return ((l_100_1.x <= l_100_2.x and l_100_1.x <= l_100_0.x and l_100_0.x <= l_100_1.x) or l_100_2.x <= l_100_0.x) and l_100_1.y <= l_100_2.y and l_100_1.y <= l_100_0.x and l_100_0.x > l_100_1.y and l_100_1.z <= l_100_2.z and l_100_1.z <= l_100_0.z and l_100_0.z <= l_100_1.z or (l_100_2.z <= l_100_0.z and l_100_0.z <= l_100_2.z)
end

CoreSequenceEnvironment.light_mul = function(l_101_0)
	local l_101_4, l_101_5, l_101_6 = nil
	local l_101_1 = SequenceEnvironment.self.dest_unit:get_object(l_101_0)
	if l_101_1 and l_101_1.multiplier then
		local l_101_2, l_101_3 = l_101_1:multiplier, l_101_1
		return l_101_2(l_101_3)
	else
		SequenceEnvironment.element:print_error("Invalid light object name \"" .. tostring(l_101_0) .. "\" in domain function \"light_mul\".", true, SequenceEnvironment.self)
		return 0
	end
end

CoreSequenceEnvironment.light_color = function(l_102_0)
	local l_102_4, l_102_5, l_102_6 = nil
	local l_102_1 = SequenceEnvironment.self.dest_unit:get_object(l_102_0)
	if l_102_1 and l_102_1.color then
		local l_102_2, l_102_3 = l_102_1:color, l_102_1
		return l_102_2(l_102_3)
	else
		local l_102_8 = SequenceEnvironment.element:print_error
		local l_102_9 = SequenceEnvironment.element
		local l_102_10 = "Invalid light object name \"" .. tostring(l_102_0) .. "\" in domain function \"light_color\"."
		local l_102_11 = true
		l_102_8(l_102_9, l_102_10, l_102_11, SequenceEnvironment.self)
		l_102_8 = Vector3
		local l_102_7 = nil
		return l_102_8()
	end
end

CoreSequenceEnvironment.light_far_range = function(l_103_0)
	local l_103_4, l_103_5, l_103_6 = nil
	local l_103_1 = SequenceEnvironment.self.dest_unit:get_object(l_103_0)
	if l_103_1 and l_103_1.far_range then
		local l_103_2, l_103_3 = l_103_1:far_range, l_103_1
		return l_103_2(l_103_3)
	else
		SequenceEnvironment.element:print_error("Invalid light object name \"" .. tostring(l_103_0) .. "\" in domain function \"light_far_range\".", true, SequenceEnvironment.self)
		return 0
	end
end

CoreSequenceEnvironment.light_spot_angle_start = function(l_104_0)
	local l_104_4, l_104_5, l_104_6 = nil
	local l_104_1 = SequenceEnvironment.self.dest_unit:get_object(l_104_0)
	if l_104_1 and l_104_1.spot_angle_start then
		local l_104_2, l_104_3 = l_104_1:spot_angle_start, l_104_1
		return l_104_2(l_104_3)
	else
		SequenceEnvironment.element:print_error("Invalid light object name \"" .. tostring(l_104_0) .. "\" in domain function \"light_spot_angle_start\".", true, SequenceEnvironment.self)
		return 0
	end
end

CoreSequenceEnvironment.light_spot_angle_end = function(l_105_0)
	local l_105_4, l_105_5, l_105_6 = nil
	local l_105_1 = SequenceEnvironment.self.dest_unit:get_object(l_105_0)
	if l_105_1 and l_105_1.spot_angle_end then
		local l_105_2, l_105_3 = l_105_1:spot_angle_end, l_105_1
		return l_105_2(l_105_3)
	else
		SequenceEnvironment.element:print_error("Invalid light object name \"" .. tostring(l_105_0) .. "\" in domain function \"light_spot_angle_start\".", true, SequenceEnvironment.self)
		return 0
	end
end

CoreSequenceEnvironment.get_unique_save_data = function(l_106_0)
	return SequenceEnvironment.g_save_data[SequenceEnvironment.get_unique_save_data_id(l_106_0)]
end

CoreSequenceEnvironment.set_unique_save_data = function(l_107_0, l_107_1)
	local l_107_2 = SequenceEnvironment.get_unique_save_data_id(l_107_0)
	SequenceEnvironment.g_save_data[l_107_2] = l_107_1
end

CoreSequenceEnvironment.get_unique_save_data_id = function(l_108_0)
	local l_108_1 = string.format
	local l_108_2 = "%s_%s"
	if alive(SequenceEnvironment.self.dest_unit) then
		local l_108_3 = tostring(SequenceEnvironment.self.dest_unit:editor_id())
	end
	local l_108_4, l_108_5 = tostring(l_108_0), .end
	return l_108_1(l_108_2, l_108_3, l_108_4, l_108_5)
end

CoreSequenceEnvironment.get_camera_pos = function(l_109_0)
	local l_109_1 = managers.viewport:get_active_vp(l_109_0)
	if l_109_1 then
		local l_109_2, l_109_3, l_109_5 = l_109_1:camera():position, l_109_1:camera()
		return l_109_2(l_109_3)
	else
		local l_109_4 = Vector3
		return l_109_4()
	end
end

CoreSequenceEnvironment.get_camera_rot = function(l_110_0)
	local l_110_1 = managers.viewport:get_active_vp(l_110_0)
	if l_110_1 then
		local l_110_2, l_110_3, l_110_5 = l_110_1:camera():new_rotation, l_110_1:camera()
		return l_110_2(l_110_3)
	else
		local l_110_4 = Rotation
		return l_110_4()
	end
end

if not CoreBaseElement then
	CoreBaseElement = class()
end
local l_0_0 = CoreBaseElement
if not CoreBaseElement.BASE_ATTRIBUTE_MAP then
	local l_0_1, l_0_2 = {}
	l_0_1.start_time = true
	l_0_1.repeat_nr = true
	l_0_1.filter = true
	l_0_1.delayed_filter = true
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0.BASE_ATTRIBUTE_MAP = l_0_1
l_0_0 = CoreBaseElement
l_0_0.SAVE_STATE = false
l_0_0 = BaseElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
BaseElement = l_0_0
l_0_0 = CoreBaseElement
l_0_0.init = function(l_111_0, l_111_1, l_111_2)
	l_111_0._unit_element = l_111_2
	local l_111_3, l_111_4 = nil, nil
	if l_111_1 then
		l_111_0._element_name = l_111_1:name()
		l_111_0._node_file = l_111_0:retrieve_node_file(l_111_1)
		l_111_0._node_line = l_111_0:retrieve_node_line(l_111_1)
		if not l_111_1.parameter_map or not l_111_1:parameter_map() then
			l_111_0._parameters = l_111_1:parameters()
		end
		l_111_0._start_time = l_111_0:get("start_time")
		l_111_0._start_time_var = l_111_0:get("start_time_id_var")
		l_111_0._repeat_nr = l_111_0:get("repeat_nr")
		l_111_3 = l_111_0:get("filter")
		l_111_4 = l_111_0:get("delayed_filter")
	else
		l_111_0._parameters = {}
	end
	if l_111_3 ~= nil and l_111_2 then
		l_111_0._is_allowed_func = function(l_112_0, l_112_1)
		-- upvalues: l_111_3 , l_111_2
		local l_112_2 = l_112_0:run_parsed_func(l_112_1, l_111_3)
		do
			if not l_112_2 or l_111_2:get_filter(l_112_2) then
				local l_112_4, l_112_5 = , l_111_2:get_filter(l_112_2):is_allowed
				local l_112_6 = l_111_2:get_filter(l_112_2)
				return l_112_5(l_112_6, l_112_1)
			else
				return l_112_2
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
	end
	if l_111_4 ~= nil and l_111_2 then
		l_111_0._delayed_is_allowed_func = function(l_113_0, l_113_1)
		-- upvalues: l_111_4 , l_111_2
		local l_113_2 = l_113_0:run_parsed_func(l_113_1, l_111_4)
		local l_113_3 = l_111_2:get_filter(l_113_2)
		if l_113_3 then
			local l_113_4, l_113_5 = l_113_3:is_allowed, l_113_3
			local l_113_6 = l_113_1
			return l_113_4(l_113_5, l_113_6)
		else
			return l_113_2
		end
  end
	end
end

l_0_0 = CoreBaseElement
l_0_0.retrieve_node_file = function(l_112_0, l_112_1)
	return l_112_1.file and l_112_1:file() or nil
end

l_0_0 = CoreBaseElement
l_0_0.retrieve_node_line = function(l_113_0, l_113_1)
	do
		local l_113_2, l_113_3, l_113_4 = l_113_1.line and l_113_1:line() or nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_113_2 and (l_113_2 <= 0 or l_113_2 >= 276577824) then
		return nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		return l_113_2
	end
end

l_0_0 = CoreBaseElement
l_0_0.get = function(l_114_0, l_114_1, l_114_2)
	local l_114_3, l_114_4 = l_114_0:get_static, l_114_0
	local l_114_5 = l_114_1
	local l_114_6 = l_114_0._parameters[l_114_1]
	local l_114_7 = l_114_2
	return l_114_3(l_114_4, l_114_5, l_114_6, l_114_7)
end

l_0_0 = CoreBaseElement
l_0_0.get_static = function(l_115_0, l_115_1, l_115_2, l_115_3, l_115_4)
	local l_115_5 = nil
	if l_115_2 ~= nil and #l_115_2 > 0 then
		local l_115_6 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_115_6 then
			if l_115_3 then
				return function(l_116_0, ...)
			-- upvalues: l_115_5 , l_115_3 , l_115_0
			setfenv(l_115_5, l_116_0)
			l_115_3(l_115_0, l_116_0, l_115_5(), ...)
    end
			end
		else
			return function(l_117_0, ...)
			-- upvalues: l_115_5
			setfenv(l_115_5, l_117_0)
			local l_117_2 = l_115_5
			local l_117_3 = l_117_0
			return l_117_2(l_117_3, ...)
    end
		end
	else
		l_115_0:print_error("Unable to parse " .. tostring(l_115_1) .. "=\"" .. tostring(l_115_2) .. "\".\n" .. tostring(nil), true, nil, l_115_4)
	end
	return nil
end

l_0_0 = CoreBaseElement
l_0_0.run_parsed_func = function(l_116_0, l_116_1, l_116_2)
	if l_116_2 ~= nil then
		local l_116_3 = l_116_2
		local l_116_4 = l_116_1
		return l_116_3(l_116_4)
	else
		return nil
	end
end

l_0_0 = CoreBaseElement
l_0_0.run_parsed_func_list = function(l_117_0, l_117_1, l_117_2)
	local l_117_7, l_117_8, l_117_9, l_117_10 = nil
	local l_117_3 = {}
	for i_0,i_1 in ipairs(l_117_2) do
		table.insert(l_117_3, l_117_0:run_parsed_func(l_117_1, i_1))
	end
	return l_117_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreBaseElement
l_0_0.run_parsed_func_map = function(l_118_0, l_118_1, l_118_2)
	local l_118_7, l_118_8, l_118_9, l_118_10 = nil
	local l_118_3 = {}
	for i_0,i_1 in ipairs(l_118_2) do
		l_118_3[i_0] = l_118_0:run_parsed_func(l_118_1, i_1)
	end
	return l_118_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreBaseElement
l_0_0.activate = function(l_119_0, l_119_1)
	SequenceEnvironment.self = l_119_1
	SequenceEnvironment.element = l_119_0
	if not l_119_0:run_parsed_func(l_119_1, l_119_0._start_time) then
		local l_119_2, l_119_8, l_119_10 = not alive(l_119_1.dest_unit) or not l_119_0:filter_callback(l_119_1) or 0
	end
	do
		local l_119_3, l_119_9, l_119_11 = , l_119_0:run_parsed_func(l_119_1, l_119_0._repeat_nr) or 1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_119_3 > 0 then
		local l_119_4 = nil
		do
			local l_119_5 = nil
			local l_119_7 = l_119_1.params
			if l_119_0:run_parsed_func(l_119_1, l_119_0._start_time_var) then
				l_119_1.vars[l_119_0:run_parsed_func(l_119_1, l_119_0._start_time_var)] = managers.sequence:add_time_callback(function()
				-- upvalues: l_119_0 , l_119_1 , l_119_4
				if l_119_0:delayed_filter_callback(l_119_1) and alive(l_119_1.dest_unit) then
					l_119_1.params = l_119_4
					SequenceEnvironment.self = l_119_1
					SequenceEnvironment.element = l_119_0
					l_119_0:activate_callback(l_119_1)
				end
      end, l_119_4, l_119_5)
			end
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		for l_119_15 = 1, l_119_5 do
			local l_119_12, l_119_13, l_119_14 = nil
		if alive(l_119_12.dest_unit) then
			end
			SequenceEnvironment.self = l_119_12
			SequenceEnvironment.element = l_119_0
			l_119_0:activate_callback(l_119_12)
		else
			do break end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreBaseElement
l_0_0.filter_callback = function(l_120_0, l_120_1)
	if l_120_0._is_allowed_func then
		local l_120_2 = l_120_0:_is_allowed_func(l_120_1)
		l_120_2 = l_120_2
		return l_120_2
	end
end

l_0_0 = CoreBaseElement
l_0_0.delayed_filter_callback = function(l_121_0, l_121_1)
	if l_121_0._delayed_is_allowed_func then
		local l_121_2 = l_121_0:_delayed_is_allowed_func(l_121_1)
		l_121_2 = l_121_2
		return l_121_2
	end
end

l_0_0 = CoreBaseElement
l_0_0.activate_callback = function(l_122_0, l_122_1)
end

l_0_0 = CoreBaseElement
l_0_0.set_state = function(l_123_0, l_123_1, l_123_2)
	local l_123_3 = l_123_1:damage()
	if l_123_3 then
		if not l_123_3._state then
			l_123_3._state = {}
		end
		l_123_3._state[l_123_0.NAME] = l_123_2
	end
end

l_0_0 = CoreBaseElement
l_0_0.set_cat_state = function(l_124_0, l_124_1, l_124_2, l_124_3)
	local l_124_4 = l_124_1:damage()
	if l_124_4 then
		if not l_124_4._state then
			l_124_4._state = {}
		end
		if not l_124_4._state[l_124_0.NAME] then
			local l_124_5 = {}
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_124_5[l_124_2] = l_124_3
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_124_4._state[l_124_0.NAME] = l_124_5
	end
end

l_0_0 = CoreBaseElement
l_0_0.set_cat_state2 = function(l_125_0, l_125_1, l_125_2, l_125_3, l_125_4)
	local l_125_5 = l_125_1:damage()
	if l_125_5 then
		if not l_125_5._state then
			l_125_5._state = {}
		end
		if not l_125_5._state[l_125_0.NAME] then
			local l_125_6, l_125_7, l_125_8, l_125_9 = {}
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if not l_125_6[l_125_2] then
			l_125_6[l_125_2] = {}
			 -- DECOMPILER ERROR: Confused about usage of registers!

		end
		l_125_6[l_125_2][l_125_3] = l_125_4
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_125_5._state[l_125_0.NAME] = l_125_6
	end
end

l_0_0 = CoreBaseElement
l_0_0.check_invalid_node = function(l_126_0, l_126_1, l_126_2)
	if (not l_126_0._unit_element or not l_126_0._unit_element._name) and not l_126_0._name then
		local l_126_3, l_126_4 = not l_126_0:is_valid_xml_node(l_126_1) or "[None]"
	end
	local l_126_5, l_126_6 = , Application:error
	local l_126_7 = Application
	local l_126_8 = "\""
	local l_126_9 = tostring(l_126_1:name())
	local l_126_10 = "\" elements for unit \""
	local l_126_11 = tostring(l_126_5)
	local l_126_12 = "\" are not supported in the \""
	local l_126_13 = tostring(l_126_0._element_name)
	local l_126_14, l_126_15 = "\" elements, only the following are allowed: ", CoreSequenceManager:get_keys_as_string
	local l_126_16 = CoreSequenceManager
	local l_126_17 = l_126_2
	local l_126_18 = "[None]"
	l_126_15 = l_126_15(l_126_16, l_126_17, l_126_18, true, #l_126_2 > 0)
	l_126_16 = " "
	l_126_17, l_126_18 = l_126_0:get_xml_origin, l_126_0
	l_126_17 = l_126_17(l_126_18)
	l_126_8 = l_126_8 .. l_126_9 .. l_126_10 .. l_126_11 .. l_126_12 .. l_126_13 .. l_126_14 .. l_126_15 .. l_126_16 .. l_126_17
	l_126_6(l_126_7, l_126_8)
end

l_0_0 = CoreBaseElement
l_0_0.is_valid_xml_node = function(l_127_0, l_127_1)
	return #l_127_1:name() ~= 0 and l_127_1:name() ~= "xdefine" and l_127_1:name() ~= "#text"
end

l_0_0 = CoreBaseElement
l_0_0.print_attribute_error = function(l_128_0, l_128_1, l_128_2, l_128_3, l_128_4, l_128_5, l_128_6)
	local l_128_7 = string.format("Attribute \"%s\" evaluated to the invalid value \"%s\".", l_128_1, tostring(l_128_2))
	if l_128_3 then
		l_128_7 = l_128_7 .. " Valid values: " .. l_128_3
	end
	l_128_0:print_error(l_128_7, l_128_4, l_128_5, l_128_6)
end

l_0_0 = CoreBaseElement
l_0_0.print_error = function(l_129_0, l_129_1, l_129_2, l_129_3, l_129_4)
	if l_129_3 then
		l_129_3.print_vars()
	else
		cat_print("debug", l_129_0:get_xml_origin(l_129_4))
	end
	local l_129_5 = "Error: " .. l_129_1 .. "\n"
	if l_129_2 then
		Application:stack_dump_error(l_129_5)
	else
		Application:throw_exception(l_129_5)
	end
end

l_0_0 = CoreBaseElement
l_0_0.get_xml_origin = function(l_130_0, l_130_1)
	if not l_130_1 or not l_130_0:retrieve_node_file(l_130_1) then
		local l_130_2 = l_130_0:get_model_xml_file()
	end
	if not l_130_1 or not l_130_0:retrieve_node_line(l_130_1) then
		local l_130_4 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_130_3 = string.gsub(tostring(Application:base_path()) .. tostring(l_130_4), "(.-)[/\\]+(.-)", "%1\\%2")
	local l_130_5 = l_130_0._node_line
	local l_130_6 = "File: \""
	local l_130_8 = tostring(l_130_3 or "N/A")
	do
		l_130_6 = l_130_6 .. l_130_8 .. "\" (Line: " .. tostring(l_130_5 or "N/A, remove .xmb file") .. ")\nUnit: \"" .. tostring(l_130_0._unit_element and l_130_0._unit_element:get_name() or "[None]") .. "\"\nElement: " .. l_130_0:get_xml_element_string(l_130_1)
		return l_130_6
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreBaseElement
l_0_0.get_model_xml_file = function(l_131_0)
	if l_131_0._node_file then
		return l_131_0._node_file
	elseif l_131_0._unit_element then
		local l_131_4 = UnitDatabase:get_unit_data
		l_131_4 = l_131_4(UnitDatabase, l_131_0._unit_element:get_name())
		local l_131_1 = nil
	if l_131_4 then
		end
		local l_131_2, l_131_3 = l_131_4
		return l_131_1(l_131_2)
	end
	return nil
end

l_0_0 = CoreBaseElement
l_0_0.get_xml_element_string = function(l_132_0, l_132_1)
	local l_132_10, l_132_11, l_132_12 = nil
	if not l_132_1 or not l_132_1:name() then
		local l_132_2, l_132_3 = l_132_0._element_name
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_132_4 = nil
	if (not l_132_1 or (l_132_1.parameter_map and l_132_1:parameter_map()) or not l_132_1:parameters()) then
		local l_132_5, l_132_6 = "<" .. tostring(l_132_2), l_132_0._parameters
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	for i_0,i_1 in pairs(l_132_6) do
		local l_132_7, l_132_8 = nil
		l_132_7 = l_132_7 .. " " .. i_0 .. "=\"" .. tostring(i_1) .. "\""
	end
	return l_132_7 .. "/>"
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreUnitElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreUnitElement = l_0_0
l_0_0 = CoreUnitElement
l_0_0.init = function(l_133_0, l_133_1, l_133_2, l_133_3)
	CoreBaseElement.init(l_133_0, l_133_1, l_133_0)
	l_133_0._name = l_133_2
	l_133_0._global_vars = {}
	l_133_0._set_global_vars = {}
	l_133_0._set_variables = {}
	if not l_133_3 then
		local l_133_4 = managers.sequence:get_global_core_unit_element()
		if l_133_4 then
			l_133_0._set_global_vars = table.map_copy(l_133_4:get_global_set_var_map())
			l_133_0._set_variables = table.map_copy(l_133_4:get_set_var_map())
		end
		local l_133_5 = managers.sequence:get_global_unit_element()
	if l_133_5 then
		end
		l_133_0._set_global_vars = table.map_copy(l_133_5:get_global_set_var_map())
		local l_133_10, l_133_11, l_133_12, l_133_17, l_133_18, l_133_19, l_133_24, l_133_25, l_133_26 = table.map_copy, l_133_5:get_set_var_map(), .end
		l_133_10 = l_133_10(l_133_11, l_133_12, l_133_17, l_133_18, l_133_19, l_133_24, l_133_25, l_133_26)
		l_133_0._set_variables = l_133_10
	end
	local l_133_6 = l_133_0:get("endurance")
	l_133_6 = not l_133_6 or l_133_6(SequenceEnvironment) or 0
	do return end
	l_133_6 = 0
	l_133_0._global_vars.endurance = l_133_6
	l_133_0._triggers = {}
	l_133_0._filters = {}
	l_133_0._sequence_elements = {}
	l_133_0._bodies = {}
	l_133_0._proximity_element = nil
	if l_133_1 then
		for i_0 in l_133_1:children() do
			if i_0:name() == "variables" then
				for i_0 in l_133_13:children() do
					local l_133_14 = nil
					l_133_0._set_variables[i_0:name()] = l_133_0:get_static("value", (i_0:parameter("value")), nil, l_133_13)
					if l_133_0._set_variables[i_0:name()] then
						l_133_0._set_variables[i_0:name()] = l_133_0._set_variables[i_0:name()](SequenceEnvironment)
					end
				end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			elseif l_133_14 == "global_variables" then
				for l_133_31 in l_133_13:children() do
					do
						local l_133_21, l_133_33, l_133_42, l_133_44, l_133_46, l_133_48, l_133_51, l_133_53, l_133_56 = nil
						l_133_33, l_133_42 = l_133_32:name, l_133_32
						l_133_33 = l_133_33(l_133_42)
						local l_133_27 = nil
						l_133_42 = l_133_0._global_vars
						l_133_44, l_133_46 = l_133_0:get_static, l_133_0
						l_133_48 = "value"
						l_133_51, l_133_53 = l_133_32:parameter, l_133_32
						l_133_56 = "value"
						l_133_51 = (l_133_51(l_133_53, l_133_56))
						l_133_53 = nil
						l_133_56 = l_133_13
						l_133_44 = l_133_44(l_133_46, l_133_48, l_133_51, l_133_53, l_133_56)
						l_133_42[l_133_33] = l_133_44
						l_133_42 = l_133_0._global_vars
						l_133_42 = l_133_42[l_133_33]
						if l_133_42 then
							l_133_42 = l_133_0._global_vars
							l_133_44 = l_133_0._global_vars
							l_133_44 = l_133_44[l_133_33]
							l_133_46 = SequenceEnvironment
							l_133_44 = l_133_44(l_133_46)
							l_133_42[l_133_33] = l_133_44
						end
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		for i_0 in l_133_1:children() do
			do
				local l_133_28, l_133_29, l_133_30 = nil
				local l_133_34, l_133_43, l_133_45, l_133_47, l_133_49, l_133_52, l_133_54, l_133_57 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				if i_0:name() == "trigger" then
					l_133_29 = "TriggerDeclarationElement"
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_133_29 = l_133_28
					l_133_30 = 
					l_133_34 = l_133_0
					 -- DECOMPILER ERROR: Overwrote pending register.

					do
						local l_133_35 = nil
						l_133_29 = l_133_0._triggers
						l_133_30 = l_133_28._name
						l_133_29[l_133_30] = l_133_28
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				elseif i_0:name() == "filter" then
					l_133_29 = "FilterElement"
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					l_133_29 = l_133_28
					l_133_30 = 
					l_133_34 = l_133_0
					 -- DECOMPILER ERROR: Overwrote pending register.

					do
						local l_133_36 = nil
						l_133_29 = l_133_0._filters
						l_133_30 = l_133_28._name
						l_133_29[l_133_30] = l_133_28
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				elseif i_0:name() == "sequence" then
					l_133_29 = l_133_0
					l_133_30 = "name"
					l_133_34, l_133_43 = i_0:parameter, i_0
					l_133_45 = "name"
					l_133_34 = (l_133_34(l_133_43, l_133_45))
					l_133_43 = nil
					l_133_45 = 
					 -- DECOMPILER ERROR: Overwrote pending register.

					do
						local l_133_37 = nil
						if l_133_28 then
							l_133_29 = l_133_28
							l_133_30 = SequenceEnvironment
							l_133_29 = l_133_29(l_133_30)
							 -- DECOMPILER ERROR: Overwrote pending register.

						end
						if not l_133_28 then
							l_133_29, l_133_30 = l_133_0:print_attribute_error, l_133_0
							l_133_34 = "name"
							l_133_43 = l_133_28
							l_133_45 = nil
							l_133_47 = false
							l_133_49 = nil
							l_133_52 = 
							l_133_29(l_133_30, l_133_34, l_133_43, l_133_45, l_133_47, l_133_49, l_133_52)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				elseif i_0:name() == "body" then
					l_133_29 = 
					l_133_30 = 
					l_133_28(l_133_29, l_133_30)
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				elseif i_0:name() == "water" then
					l_133_29 = 
					l_133_30 = 
					l_133_28(l_133_29, l_133_30)
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				elseif i_0:name() == "proximities" then
					if not l_133_28 then
						l_133_29 = "ProximityElement"
						 -- DECOMPILER ERROR: Overwrote pending register.

						 -- DECOMPILER ERROR: Overwrote pending register.

						l_133_29 = l_133_28
						l_133_30 = 
						l_133_34 = l_133_0
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_133_0._proximity_element = l_133_28
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					else
						l_133_29 = l_133_28
						l_133_30 = "\""
						l_133_34 = tostring
						l_133_43, l_133_45 = l_133_1:name, l_133_1
						l_133_45, l_133_43 = .end, l_133_43(l_133_45)
						l_133_34 = l_133_34(l_133_43, l_133_45, l_133_47, l_133_49, l_133_52, l_133_54, l_133_57)
						l_133_43 = "\" element for unit \""
						l_133_45 = tostring
						l_133_47 = unit_element
						l_133_47 = l_133_47._name
						l_133_45 = l_133_45(l_133_47)
						l_133_47 = "\" has more than one \"proximity\" element."
						l_133_30 = l_133_30 .. l_133_34 .. l_133_43 .. l_133_45 .. l_133_47
						l_133_28(l_133_29, l_133_30)
					end
				 -- DECOMPILER ERROR: Overwrote pending register.

				elseif i_0:name() ~= "variables" and i_0:name() ~= "global_variables" then
					l_133_29 = l_133_0
					local l_133_38, l_133_39 = nil
					l_133_30 = 
					local l_133_40 = nil
					local l_133_41 = nil
					l_133_43 = "trigger"
					l_133_45 = "filter"
					l_133_47 = "sequence"
					l_133_49 = "body"
					l_133_52 = "proximities"
					l_133_28(l_133_29, l_133_30, l_133_34)
					l_133_34 = {l_133_43, l_133_45, l_133_47, l_133_49, l_133_52}
				end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			for i_0,i_1 in pairs(l_133_21) do
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_133_29 = get_core_or_local
				l_133_30 = "SequenceElement"
				l_133_29 = l_133_29(l_133_30)
				l_133_29, l_133_30 = l_133_29:new, l_133_29
				l_133_29 = l_133_29(l_133_30, i_1, l_133_0, nil, nil)
				l_133_28[i_0] = l_133_29
			end
			for i_0,i_1 in ipairs(R9_PC286) do
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_133_29 = "WaterElement"
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_133_29 = l_133_28
				l_133_30 = i_1
				 -- DECOMPILER ERROR: Overwrote pending register.

				local l_133_50 = nil
				l_133_29 = l_133_0._water_element_map
				if l_133_29 then
					l_133_29 = l_133_0._water_element_map
					l_133_30 = l_133_28._name
					l_133_29 = l_133_29[l_133_30]
				if l_133_29 then
					end
					l_133_29 = error
					l_133_30 = "Duplicate "
					l_133_50 = l_133_28._element_name
					l_133_30 = l_133_30 .. l_133_50 .. " element \"" .. tostring(l_133_28._name) .. "\" in unit \"" .. tostring(l_133_0._name) .. "\"."
					l_133_29(l_133_30)
				else
					l_133_29, l_133_30 = l_133_28:is_empty, l_133_28
					l_133_29 = l_133_29(l_133_30)
				if not l_133_29 then
					end
					l_133_29 = l_133_28._name
				if l_133_29 then
					end
					l_133_29 = l_133_0._water_element_map
					if not l_133_29 then
						l_133_0._water_element_map, l_133_29 = l_133_29, {}
					end
					l_133_29 = l_133_0._water_element_map
					l_133_30 = l_133_28._name
					l_133_29[l_133_30] = l_133_28
				end
			end
			for i_0,i_1 in ipairs(R9_PC337) do
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_133_29 = "RootBodyElement"
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_133_29 = l_133_28
				l_133_30 = i_1
				 -- DECOMPILER ERROR: Overwrote pending register.

				local l_133_55 = nil
				l_133_29 = l_133_0._bodies
				l_133_30 = l_133_28._name
				l_133_29 = l_133_29[l_133_30]
				if l_133_29 then
					l_133_29 = error
					l_133_30 = "Duplicate "
					l_133_55 = l_133_28._element_name
					l_133_30 = l_133_30 .. l_133_55 .. " element \"" .. tostring(l_133_28._name) .. "\" in unit \"" .. tostring(l_133_0._name) .. "\"."
					l_133_29(l_133_30)
				else
					l_133_29 = l_133_0._bodies
					l_133_30 = l_133_28._name
					l_133_29[l_133_30] = l_133_28
				end
			end
			for i_0,i_1 in pairs(l_133_0._global_vars) do
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_133_28[i_0] = i_1
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0 = CoreUnitElement
l_0_0.get_startup_sequence_map = function(l_134_0, l_134_1, l_134_2)
	local l_134_3, l_134_4, l_134_6, l_134_7, l_134_8, l_134_9 = nil, nil
	for i_0,i_1 in pairs(l_134_0._sequence_elements) do
		if i_1._startup then
			if not l_134_3 then
				l_134_3 = SequenceEnvironment:new("startup", l_134_1, l_134_1, nil, math.UP, Vector3(), -math.UP, 0, (Vector3()), nil, l_134_0, l_134_2)
				SequenceEnvironment.self = l_134_3
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if i_1:run_parsed_func(l_134_3, i_1._startup) and not l_134_4 then
				l_134_4 = {}
			end
			l_134_4[i_0] = true
		end
	end
	return l_134_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreUnitElement
l_0_0.get_editor_startup_sequence_map = function(l_135_0, l_135_1, l_135_2)
	local l_135_3, l_135_4, l_135_6, l_135_7, l_135_8, l_135_9 = nil, nil
	for i_0,i_1 in pairs(l_135_0._sequence_elements) do
		if i_1._editor_startup then
			if not l_135_3 then
				l_135_3 = SequenceEnvironment:new("editor_startup", l_135_1, l_135_1, nil, math.UP, Vector3(), -math.UP, 0, (Vector3()), nil, l_135_0, l_135_2)
				SequenceEnvironment.self = l_135_3
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if i_1:run_parsed_func(l_135_3, i_1._editor_startup) and not l_135_4 then
				l_135_4 = {}
			end
			l_135_4[i_0] = true
		end
	end
	return l_135_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreUnitElement
l_0_0.get_name = function(l_136_0)
	return l_136_0._name
end

l_0_0 = CoreUnitElement
l_0_0.get_global_set_var_map = function(l_137_0)
	return l_137_0._set_global_vars
end

l_0_0 = CoreUnitElement
l_0_0.get_set_var_map = function(l_138_0)
	return l_138_0._set_variables
end

l_0_0 = CoreUnitElement
l_0_0.get_body_element = function(l_139_0, l_139_1)
	return l_139_0._bodies[l_139_1]
end

l_0_0 = CoreUnitElement
l_0_0.get_trigger_name_list = function(l_140_0)
	local l_140_5, l_140_6, l_140_7 = nil
	local l_140_1 = {}
	for i_0,i_1 in pairs(l_140_0._triggers) do
		table.insert(l_140_1, i_0)
	end
	return l_140_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreUnitElement
l_0_0.has_trigger_name = function(l_141_0, l_141_1)
	return l_141_0._triggers[l_141_1] ~= nil
end

l_0_0 = CoreUnitElement
l_0_0.get_trigger_name_map = function(l_142_0)
	return l_142_0._triggers
end

l_0_0 = CoreUnitElement
l_0_0.get_sequence_name_list = function(l_143_0)
	local l_143_5, l_143_6, l_143_7 = nil
	local l_143_1 = {}
	for i_0,i_1 in pairs(l_143_0._sequence_elements) do
		table.insert(l_143_1, i_0)
	end
	local l_143_8, l_143_9 = nil
	for l_143_8,l_143_9 in pairs(managers.sequence:get_global_sequence_map()) do
		table.insert(l_143_1, l_143_8)
	end
	return l_143_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreUnitElement
l_0_0.get_parameter_sequence_name_list = function(l_144_0, l_144_1, l_144_2)
	local l_144_7, l_144_8, l_144_9, l_144_10 = nil
	local l_144_3 = {}
	for i_0,i_1 in pairs(l_144_0._sequence_elements) do
		if i_1:get(l_144_1) and i_1:get(l_144_1)(SequenceEnvironment) == l_144_2 then
			table.insert(l_144_3, l_144_11)
		end
	end
	return l_144_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreUnitElement
l_0_0.has_sequence_name = function(l_145_0, l_145_1)
	return l_145_0._sequence_elements[l_145_1] ~= nil
end

l_0_0 = CoreUnitElement
l_0_0.get_body_element = function(l_146_0, l_146_1)
	return l_146_0._bodies[l_146_1]
end

l_0_0 = CoreUnitElement
l_0_0.get_body_element_list = function(l_147_0)
	return l_147_0._bodies
end

l_0_0 = CoreUnitElement
l_0_0.get_endurance = function(l_148_0)
	return l_148_0._global_vars.endurance
end

l_0_0 = CoreUnitElement
l_0_0.set_endurance = function(l_149_0, l_149_1)
	l_149_0._global_vars.endurance = l_149_1
end

l_0_0 = CoreUnitElement
l_0_0.reset_damage = function(l_150_0, l_150_1)
	local l_150_5, l_150_6, l_150_7, l_150_8, l_150_9, l_150_10, l_150_15, l_150_16, l_150_17, l_150_18 = nil
	for i_0,i_1 in pairs(l_150_0._bodies) do
		for i_0,i_1 in pairs(i_1._first_endurance) do
			local l_150_13 = l_150_1:body(i_1._name):extension().damage
			l_150_13._endurance[i_0] = i_1
			l_150_13._damage[i_0] = 0
		end
	end
	l_150_1:damage()._damage = 0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreUnitElement
l_0_0.run_sequence = function(l_151_0, l_151_1, l_151_2, l_151_3, l_151_4, l_151_5, l_151_6, l_151_7, l_151_8, l_151_9, l_151_10, l_151_11)
	local l_151_12 = l_151_0:get_sequence_element(l_151_1)
	local l_151_13 = SequenceEnvironment:new(l_151_2, l_151_3, l_151_4, l_151_5, l_151_6, l_151_7, l_151_8, l_151_9, l_151_10, l_151_11, l_151_0)
	if l_151_12 then
		l_151_12:activate(l_151_13)
	else
		SequenceEnvironment.self = l_151_13
		SequenceEnvironment.element = l_151_0
		local l_151_14 = CoreSequenceManager:get_keys_as_string(l_151_0:get_sequence_name_list(), "", true, true)
		l_151_0:print_error("Unable to run non-existing sequence \"" .. tostring(l_151_1) .. "\" on unit \"" .. tostring(l_151_0._name) .. "\". Available sequences: " .. tostring(l_151_14), true, l_151_13)
	end
end

l_0_0 = CoreUnitElement
l_0_0.has_sequence = function(l_152_0, l_152_1)
	return l_152_0:get_sequence_element(l_152_1) ~= nil
end

l_0_0 = CoreUnitElement
l_0_0.get_sequence_element = function(l_153_0, l_153_1)
	if not l_153_0._sequence_elements[l_153_1] then
		return managers.sequence:get_global_sequence(l_153_1)
	end
end

l_0_0 = CoreUnitElement
l_0_0.get_proximity_element_map = function(l_154_0)
	if l_154_0._proximity_element then
		local l_154_1, l_154_2 = l_154_0._proximity_element:get_proximity_element_map, l_154_0._proximity_element
		return l_154_1(l_154_2)
	else
		return {}
	end
end

l_0_0 = CoreUnitElement
l_0_0.save_by_unit = function(l_155_0, l_155_1, l_155_2)
	local l_155_8 = nil
	local l_155_3 = {}
	local l_155_4 = false
	for i_0,i_1 in pairs(l_155_0._bodies) do
	if not l_155_1:body(i_0):extension().damage:save(l_155_3) then
		end
	end
	if l_155_4 then
		l_155_2.CoreUnitElement = l_155_3
	end
	return l_155_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreUnitElement
l_0_0.load_by_unit = function(l_156_0, l_156_1, l_156_2)
	local l_156_7, l_156_8, l_156_9 = nil
	local l_156_3 = l_156_2.CoreUnitElement
	if l_156_3 then
		for i_0,i_1 in pairs(l_156_0._bodies) do
			l_156_1:body(i_0):extension().damage:load(l_156_3)
		end
	end
end

l_0_0 = CoreUnitElement
l_0_0.get_filter = function(l_157_0, l_157_1)
	if not l_157_0._filters[l_157_1] then
		return managers.sequence:get_global_filter(l_157_1)
	end
end

l_0_0 = CoreUnitElement
l_0_0.get_water_element_map = function(l_158_0)
	return l_158_0._water_element_map
end

l_0_0 = CoreUnitElement
l_0_0.save = function(l_159_0, l_159_1)
	local l_159_7, l_159_8, l_159_9, l_159_10, l_159_11 = nil
	local l_159_2 = {}
	local l_159_3 = false
	for i_0,i_1 in pairs(l_159_0._global_vars) do
		if l_159_0._set_global_vars[i_0] ~= i_1 then
			l_159_2.global_vars = table.map_copy(l_159_0._global_vars)
			l_159_3 = true
	else
		end
	end
	if l_159_3 then
		l_159_1[l_159_0._name] = l_159_2
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0 = CoreUnitElement
l_0_0.load = function(l_160_0, l_160_1)
	local l_160_2 = l_160_1[l_160_0._name]
	if l_160_2 then
		l_160_0._global_vars = table.map_copy(l_160_2.global_vars)
	end
end

l_0_0 = CoreTriggerDeclarationElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreTriggerDeclarationElement = l_0_0
l_0_0 = CoreTriggerDeclarationElement
l_0_0.init = function(l_161_0, l_161_1, l_161_2)
	CoreBaseElement.init(l_161_0, l_161_1, l_161_2)
	l_161_0._name = l_161_0:get("name")
	if l_161_0._name then
		l_161_0._name = l_161_0._name(SequenceEnvironment)
	end
	if l_161_0._name == nil then
		Application:throw_exception("Unit \"" .. tostring(l_161_2._name) .. "\" has an invalid trigger element name \"" .. tostring(l_161_0._parameters.name) .. "\".")
	end
end

l_0_0 = CoreFilterElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreFilterElement = l_0_0
l_0_0 = CoreFilterElement
l_0_0.init = function(l_162_0, l_162_1, l_162_2)
	CoreBaseElement.init(l_162_0, l_162_1, l_162_2)
	l_162_0._name = l_162_0:get("name")
	if l_162_0._name then
		l_162_0._name = l_162_0._name(SequenceEnvironment)
	end
	if l_162_0._name == nil then
		local l_162_7, l_162_8 = Application:throw_exception, Application
		l_162_7(l_162_8, "Unit \"" .. tostring(l_162_2._name) .. "\" has an invalid filter element name \"" .. tostring(l_162_0._parameters.name) .. "\".")
	end
	l_162_0._allow = l_162_0:get("allow")
	l_162_0._check_all = l_162_0:get("check_all")
	l_162_0._elements = {}
	local l_162_3 = managers.sequence:get_filter_element_class_map()
	for i_0 in l_162_1:children() do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_162_3[i_0:name()] then
			local l_162_10 = nil
			table.insert(l_162_0._elements, l_162_3[i_0:name()]:new(l_162_9, l_162_2))
		else
			l_162_0:check_invalid_node(l_162_9, l_162_3)
		end
	end
end

l_0_0 = CoreFilterElement
l_0_0.is_allowed = function(l_163_0, l_163_1)
	local l_163_8, l_163_9 = nil
	do
		local l_163_2 = l_163_0:run_parsed_func(l_163_1, l_163_0._allow) or true
	do
		end
		local l_163_3 = nil
	end
	local l_163_4 = nil
	for i_0,i_1 in ipairs(l_163_0._elements) do
		local l_163_5, l_163_6 = l_163_0:run_parsed_func(l_163_1, l_163_0._check_all) or true, true
		l_163_6 = i_1:is_allowed(l_163_1) == l_163_4
		if l_163_5 and not l_163_6 then
			do return end
		end
		for i_0,i_1 in l_163_7 do
			if not l_163_5 and l_163_6 then
				do return end
			end
		end
		return l_163_6
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

l_0_0 = CoreCheckFilterElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreCheckFilterElement = l_0_0
l_0_0 = CoreCheckFilterElement
l_0_0.NAME = "check"
l_0_0 = CoreCheckFilterElement
l_0_0.init = function(l_164_0, l_164_1, l_164_2)
	CoreBaseElement.init(l_164_0, l_164_1, l_164_2)
	l_164_0._value = l_164_0:get("value")
	if l_164_0._value == nil then
		Application:throw_exception("\"" .. tostring(l_164_1:name()) .. "\" element for unit \"" .. tostring(l_164_2._name) .. "\" defined an invalid value \"" .. tostring(l_164_0._value) .. "\".")
	end
end

l_0_0 = CoreCheckFilterElement
l_0_0.is_allowed = function(l_165_0, l_165_1)
	return l_165_0:run_parsed_func(l_165_1, l_165_0._value) == true
end

l_0_0 = CoreSideFilterElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreSideFilterElement = l_0_0
l_0_0 = CoreSideFilterElement
l_0_0.NAME = "side"
l_0_0 = CoreSideFilterElement
l_0_0.init = function(l_166_0, l_166_1, l_166_2)
	CoreBaseElement.init(l_166_0, l_166_1, l_166_2)
	l_166_0._axis = l_166_0:get("axis")
	if l_166_0._axis then
		l_166_0._axis = l_166_0._axis(SequenceEnvironment)
	end
	if l_166_0._axis == nil then
		l_166_0._axis = "y"
	else
		if l_166_0._axis:sub(1, 1) == "-" then
			l_166_0._axis = l_166_0._axis:sub(2)
			l_166_0._multiplier = -1
		else
			l_166_0._multiplier = 1
		end
	if l_166_0._axis ~= "x" then
		end
	if l_166_0._axis ~= "y" then
		end
	if l_166_0._axis ~= "z" then
		end
		Application:throw_exception("\"" .. tostring(l_166_1:name()) .. "\" element for unit \"" .. tostring(l_166_2._name) .. "\" defined an invalid axis \"" .. tostring(l_166_0._axis) .. "\".")
	end
end

l_0_0 = CoreSideFilterElement
l_0_0.is_allowed = function(l_167_0, l_167_1)
	if alive(l_167_1.dest_body) then
		local l_167_2 = l_167_1.dest_body:rotation()
		local l_167_3 = math.dot(l_167_1.dest_normal, l_167_0._multiplier * l_167_2[l_167_0._axis](l_167_2))
		return l_167_3 > 0.9
	else
		l_167_0:print_error("Unable to use filter on destroyed dest_body. This is probably because a scripter didn't specify a body when a sequence was executed or if it was executed from a sequence that had \"startup\" attribute set to true or if the sequence was triggered from a water element.", true, l_167_1)
		return false
	end
end

l_0_0 = CoreZoneFilterElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreZoneFilterElement = l_0_0
l_0_0 = CoreZoneFilterElement
l_0_0.NAME = "zone"
l_0_0 = CoreZoneFilterElement
l_0_0.init = function(l_168_0, l_168_1, l_168_2)
	CoreBaseElement.init(l_168_0, l_168_1, l_168_2)
	local l_168_3 = l_168_0:get("name")
	if l_168_3 then
		l_168_3 = l_168_3(SequenceEnvironment)
	end
	l_168_0._ref_object = l_168_0:get("ref_object")
	if l_168_0._ref_object == nil then
		Application:throw_exception("\"" .. tostring(l_168_1:name()) .. "\" element for unit \"" .. tostring(l_168_2._name) .. "\" defined an invalid \"ref_object\" in zone \"" .. tostring(l_168_3) .. "\".")
	end
	l_168_0._func_list = {}
	local l_168_4 = false
	for l_168_8 = 1, #l_168_3 do
		local l_168_9 = string.sub(l_168_3, l_168_8, l_168_8)
		do
			if l_168_9 == "-" then
				l_168_4 = true
			elseif l_168_9 == "x" or l_168_9 == "y" or l_168_9 == "z" then
				local l_168_10 = nil
				if l_168_4 then
					l_168_10 = function(l_169_0)
					-- upvalues: l_168_9
					return l_169_0[l_168_9] < 0
        end
				else
					l_168_10 = function(l_170_0)
					-- upvalues: l_168_9
					return l_170_0[l_168_9] >= 0
        end
				end
				table.insert(l_168_0._func_list, l_168_10)
				l_168_4 = false
			end
		end
	end
	if #l_168_0._func_list == 0 then
		Application:throw_exception("\"" .. tostring(l_168_1:name()) .. "\" element for unit \"" .. tostring(l_168_2._name) .. "\" defined an invalid name \"" .. tostring(l_168_3) .. "\".")
	end
end

l_0_0 = CoreZoneFilterElement
l_0_0.is_allowed = function(l_169_0, l_169_1)
	local l_169_2 = l_169_1.dest_unit:get_object(l_169_0:run_parsed_func(l_169_1, l_169_0._ref_object))
	if l_169_2 then
		local l_169_8, l_169_9 = l_169_1.pos - l_169_2:position():rotate_with, l_169_1.pos - l_169_2:position()
		l_169_8 = l_169_8(l_169_9, l_169_2:rotation():inverse())
		local l_169_3 = nil
		l_169_9 = true
		local l_169_4 = nil
		l_169_3 = ipairs
		l_169_4 = l_169_0._func_list
		l_169_3 = l_169_3(l_169_4)
		for i_0,i_1 in l_169_3 do
			l_169_9 = l_169_7(l_169_8)
			if not l_169_9 then
				do return end
			end
		end
		return l_169_9
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_169_8, l_169_9 = l_169_0:print_attribute_error, l_169_0
		l_169_8(l_169_9, "ref_object", l_169_2, nil, true, l_169_1, nil)
		l_169_8 = false
		return l_169_8
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0 = CoreSequenceElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreSequenceElement = l_0_0
l_0_0 = CoreSequenceElement
l_0_0.init = function(l_170_0, l_170_1, l_170_2)
	CoreBaseElement.init(l_170_0, l_170_1, l_170_2)
	l_170_0._name = l_170_0:get("name")
	if l_170_0._name then
		l_170_0._name = l_170_0._name(SequenceEnvironment)
	else
		local l_170_6, l_170_7, l_170_8, l_170_9 = Application:throw_exception, Application, "\"", tostring(l_170_1:name())
		l_170_8 = l_170_8 .. l_170_9 .. "\" element for unit \"" .. tostring(l_170_2._name) .. "\" doesn't have a name."
		l_170_6(l_170_7, l_170_8)
	end
	l_170_0._activate_once = l_170_0:get("once")
	l_170_0._startup = l_170_0:get("startup")
	l_170_0._editor_startup = l_170_0:get("editor_startup")
	l_170_0._elements = {}
	for i_0 in l_170_1:children() do
		if l_170_0:is_valid_xml_node(l_170_10) then
			local l_170_11 = i_0:name()
			if managers.sequence:parse_event(l_170_10, l_170_2) then
				table.insert(l_170_0._elements, managers.sequence:parse_event(l_170_10, l_170_2))
			end
		else
			l_170_0:check_invalid_node(l_170_10, managers.sequence:get_event_element_class_map())
		end
	end
end

l_0_0 = CoreSequenceElement
l_0_0.activate_callback = function(l_171_0, l_171_1)
	local l_171_7, l_171_8 = nil
	local l_171_2 = l_171_1.dest_unit:damage()
	if not l_171_2._runned_sequences or not l_171_2._runned_sequences[l_171_0._name] then
		local l_171_6 = l_171_0:run_parsed_func
		l_171_6 = l_171_6(l_171_0, l_171_1, l_171_0._activate_once)
		if l_171_6 then
			l_171_6 = l_171_2._runned_sequences
			if not l_171_6 then
				l_171_2._runned_sequences, l_171_6 = l_171_6, {}
			end
			l_171_6 = l_171_2._runned_sequences
			l_171_6[l_171_0._name] = true
		end
		l_171_6 = ipairs
		l_171_6 = l_171_6(l_171_0._elements)
		for i_0,i_1 in l_171_6 do
			i_1:activate(l_171_1)
		end
		managers.world:runned_unit_sequence(l_171_1.dest_unit, l_171_0._name)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0 = CoreProximityElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreProximityElement = l_0_0
l_0_0 = CoreProximityElement
l_0_0.init = function(l_172_0, l_172_1, l_172_2)
	local l_172_6 = CoreBaseElement.init
	l_172_6(l_172_0, l_172_1, l_172_2)
	l_172_0._element_map, l_172_6 = l_172_6, {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_172_6 do
		if l_172_5:name() == "proximity" then
			local l_172_7 = get_core_or_local("ProximityTypeElement"):new(l_172_5, l_172_2)
			local l_172_8 = l_172_7:get_name()
			if not l_172_0._element_map[l_172_8] then
				l_172_0._element_map[l_172_8] = l_172_7
			else
				l_172_7:print_error("Proximity with name \"" .. tostring(l_172_8) .. "\" has already been defined.", false, nil)
			end
		else
			local l_172_9, l_172_10 = l_172_0:check_invalid_node, l_172_0
			local l_172_11 = l_172_5
			local l_172_12 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			l_172_9(l_172_10, l_172_11, l_172_12)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreProximityElement
l_0_0.get_proximity_element_map = function(l_173_0)
	return l_173_0._element_map
end

l_0_0 = CoreProximityTypeElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreProximityTypeElement = l_0_0
l_0_0 = CoreProximityTypeElement
l_0_0.MIN_INTERVAL = 0.2
l_0_0 = CoreProximityTypeElement
l_0_0.init = function(l_174_0, l_174_1, l_174_2)
	CoreBaseElement.init(l_174_0, l_174_1, l_174_2)
	l_174_0._name = l_174_0:get("name")
	if l_174_0._name then
		l_174_0._name = l_174_0._name(SequenceEnvironment)
	end
	if not l_174_0._name then
		l_174_0:print_attribute_error("name", l_174_0._name, nil, false, nil)
	end
	local l_174_3 = l_174_0:get("type")
	if l_174_3 then
		l_174_3 = l_174_3(SequenceEnvironment)
	end
	if l_174_3 then
		l_174_0._slotmask = managers.sequence:get_proximity_mask(l_174_3)
	end
	if not l_174_0._slotmask then
		l_174_0:print_attribute_error("type", l_174_3, CoreSequenceManager:get_keys_as_string(managers.sequence:get_proximity_mask_map(), "", true, false), false, nil)
		return 
	end
	l_174_0._ref_object = l_174_0:get("ref_object")
	if l_174_0._ref_object then
		l_174_0._ref_object = l_174_0._ref_object(SequenceEnvironment)
	end
	l_174_0._enabled = l_174_0:get("enabled")
	if l_174_0._enabled then
		l_174_0._enabled = l_174_0._enabled(SequenceEnvironment)
	else
		l_174_0._enabled = true
	end
	l_174_0._interval = l_174_0:get("interval")
	if l_174_0._interval then
		local l_174_7, l_174_8, l_174_9 = tonumber, l_174_0._interval(SequenceEnvironment), .end
		l_174_7 = l_174_7(l_174_8, l_174_9)
	end
	l_174_0._interval = l_174_7
	l_174_0._interval = math.min(tonumber(l_174_0._interval) or 0, l_174_0.MIN_INTERVAL)
	l_174_0._quick = l_174_0:get("quick")
	l_174_0._quick = l_174_0._quick and l_174_0._quick(SequenceEnvironment) or true
	l_174_0._start_within = l_174_0:get("start_within")
	if l_174_0._start_within then
		l_174_0._start_within = l_174_0._quick(SequenceEnvironment)
	end
	if l_174_0._start_within == nil then
		l_174_0._start_within = false
	end
	l_174_0._within_element = nil
	l_174_0._outside_element = nil
	for i_0 in l_174_1:children() do
		if i_0:name() == "within" then
			if not l_174_0._within_element then
				l_174_0._within_element = get_core_or_local("ProximityRangeElement"):new(i_0, l_174_2, true)
			else
				Application:throw_exception("Unit \"" .. tostring(l_174_2._name) .. "\" have defined more than one \"within\" element.")
			end
		elseif i_0:name() == "outside" then
			if not l_174_0._outside_element then
				l_174_0._outside_element = get_core_or_local("ProximityRangeElement"):new(i_0, l_174_2, false)
			else
				Application:throw_exception("Unit \"" .. tostring(l_174_2._name) .. "\" have defined more than one \"outside\" element.")
			end
		else
			local l_174_12 = nil
			local l_174_13 = l_174_0:check_invalid_node
			local l_174_14 = l_174_0
			l_174_13(l_174_14, l_174_11, {"within", "outside"})
		end
	end
	if (not l_174_0._within_element or #l_174_0._within_element._elements == 0) and (not l_174_0._outside_element or #l_174_0._outside_element._elements == 0) then
		Application:throw_exception("\"" .. tostring(l_174_1:name()) .. "\" element on unit \"" .. tostring(l_174_2._name) .. "\" doesn't have a \"within\" nor a \"outside\" element or they doesn't contain any \"run_sequence\" elements.")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0 = CoreProximityTypeElement
l_0_0.get_name = function(l_175_0)
	return l_175_0._name
end

l_0_0 = CoreProximityTypeElement
l_0_0.get_slotmask = function(l_176_0)
	return l_176_0._slotmask
end

l_0_0 = CoreProximityTypeElement
l_0_0.get_enabled = function(l_177_0)
	return l_177_0._enabled
end

l_0_0 = CoreProximityTypeElement
l_0_0.get_ref_object = function(l_178_0)
	return l_178_0._ref_object
end

l_0_0 = CoreProximityTypeElement
l_0_0.get_interval = function(l_179_0)
	return l_179_0._interval
end

l_0_0 = CoreProximityTypeElement
l_0_0.is_quick = function(l_180_0)
	return l_180_0._quick
end

l_0_0 = CoreProximityTypeElement
l_0_0.get_start_within = function(l_181_0)
	return l_181_0._start_within
end

l_0_0 = CoreProximityTypeElement
l_0_0.get_within_element = function(l_182_0)
	return l_182_0._within_element
end

l_0_0 = CoreProximityTypeElement
l_0_0.get_outside_element = function(l_183_0)
	return l_183_0._outside_element
end

l_0_0 = CoreProximityRangeElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreProximityRangeElement = l_0_0
l_0_0 = CoreProximityRangeElement
l_0_0.init = function(l_184_0, l_184_1, l_184_2, l_184_3)
	CoreBaseElement.init(l_184_0, l_184_1, l_184_2)
	l_184_0._within = l_184_3
	l_184_0._max_activation_count = l_184_0:get("max_activations")
	l_184_0._max_activation_count = l_184_0._max_activation_count and l_184_0._max_activation_count(SequenceEnvironment) or -1
	l_184_0._delay = l_184_0:get("delay")
	l_184_0._delay = l_184_0._delay and l_184_0._delay(SequenceEnvironment) or 0
	l_184_0._range = l_184_0:get("range")
	if l_184_0._range then
		l_184_0._range = tonumber(l_184_0._range(SequenceEnvironment))
	end
	l_184_0._count = l_184_0:get("count")
	l_184_0._count = (l_184_0._count and l_184_0._count(SequenceEnvironment)) or (l_184_0._within and 1) or 0
	l_184_0._elements = {}
	if not l_184_0._range or l_184_0._range <= 0 then
		local l_184_7, l_184_8, l_184_9 = Application:throw_exception, Application, "\""
		l_184_9 = l_184_9 .. tostring(name) .. "\" element on unit \"" .. tostring(l_184_2._name) .. "\" doesn't have a range specified or it is not more than zero (specified range: " .. tostring(l_184_0._range) .. ")."
		l_184_7(l_184_8, l_184_9)
	end
	for i_0 in l_184_1:children() do
		if i_0:name() == "run_sequence" then
			local l_184_11 = nil
			if managers.sequence:parse_event(l_184_10, l_184_2) then
				table.insert(l_184_0._elements, managers.sequence:parse_event(l_184_10, l_184_2))
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif #l_184_11 ~= 0 and l_184_11 ~= "xdefine" then
			Application:throw_exception("\"" .. tostring(l_184_11) .. "\" elements for unit \"" .. tostring(l_184_2._name) .. "\" are not supported in the \"" .. tostring(l_184_1:name()) .. "\" elements, only \"run_sequence\" elements are supported.")
		end
	end
end

l_0_0 = CoreProximityRangeElement
l_0_0.get_max_activation_count = function(l_185_0)
	return l_185_0._max_activation_count
end

l_0_0 = CoreProximityRangeElement
l_0_0.get_delay = function(l_186_0)
	return l_186_0._delay
end

l_0_0 = CoreProximityRangeElement
l_0_0.get_range = function(l_187_0)
	return l_187_0._range
end

l_0_0 = CoreProximityRangeElement
l_0_0.get_count = function(l_188_0)
	return l_188_0._count
end

l_0_0 = CoreProximityRangeElement
l_0_0.activate_elements = function(l_189_0, l_189_1)
	local l_189_5, l_189_6, l_189_7, l_189_8 = nil
	for i_0,i_1 in ipairs(l_189_0._elements) do
		i_1:activate(l_189_1)
	end
end

l_0_0 = CoreWaterElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreWaterElement = l_0_0
l_0_0 = CoreWaterElement
l_0_0.init = function(l_190_0, l_190_1, l_190_2)
	CoreBaseElement.init(l_190_0, l_190_1, l_190_2)
	l_190_0._name = l_190_0:get("name")
	if l_190_0._name then
		l_190_0._name = l_190_0._name(SequenceEnvironment)
	end
	if not l_190_0._name then
		local l_190_7, l_190_8, l_190_9 = l_190_0:print_error, l_190_0, "\"" .. tostring(l_190_1:name()) .. "\" element for unit \"" .. tostring(l_190_2._name) .. "\" doesn't have a name."
		l_190_7(l_190_8, l_190_9, true, nil)
	end
	l_190_0._enabled = l_190_0:get("enabled")
	if l_190_0._enabled ~= nil then
		local l_190_3 = l_190_0._enabled(SequenceEnvironment)
		l_190_3 = l_190_3
	end
	l_190_0._enabled = l_190_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_190_0._interval = l_190_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_190_0._interval or not l_190_3 then
		l_190_0._interval = l_190_3
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_190_0._ref_object = l_190_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_190_3 then
		l_190_0._ref_object = l_190_3
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_190_0._ref_body = l_190_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_190_3 then
		l_190_0._ref_body = l_190_3
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_190_0._body_depth = l_190_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_190_3 or not l_190_3 then
		l_190_0._body_depth = l_190_3
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_190_0._physic_effect = l_190_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_190_3 then
		l_190_0._physic_effect = l_190_3
	end
	l_190_0._enter_element = nil
	l_190_0._exit_element = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_190_3 do
		local l_190_10 = l_190_6:name()
		if l_190_10 == "enter" then
			local l_190_11 = get_core_or_local("EnterWaterElement"):new(l_190_6, l_190_2)
			if not l_190_0._enter_element then
				l_190_0._enter_element = l_190_11
			else
				l_190_11:print_error("Duplicate enter element found in water element \"" .. tostring(l_190_0._name) .. "\".", false, nil)
			end
		elseif l_190_10 == "exit" then
			local l_190_12 = get_core_or_local("ExitWaterElement"):new(l_190_6, l_190_2)
			if not l_190_0._exit_element then
				l_190_0._exit_element = l_190_12
			else
				l_190_12:print_error("Duplicate exit element found in water element \"" .. tostring(l_190_0._name) .. "\".", false, nil)
			end
		else
			local l_190_13, l_190_14 = l_190_0:check_invalid_node, l_190_0
			local l_190_15 = l_190_6
			local l_190_16 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			l_190_13(l_190_14, l_190_15, l_190_16)
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_190_3(l_190_0) then
		l_190_0:print_error("Water element \"" .. tostring(l_190_0._name) .. "\" is empty.", false, nil)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreWaterElement
l_0_0.is_empty = function(l_191_0)
	return (not l_191_0._enter_element or l_191_0._enter_element:sequence_count() == 0) and not l_191_0._exit_element or l_191_0._exit_element:sequence_count() == 0
end

l_0_0 = CoreWaterElement
l_0_0.get_name = function(l_192_0)
	return l_192_0._name
end

l_0_0 = CoreWaterElement
l_0_0.get_enabled = function(l_193_0)
	return l_193_0._enabled
end

l_0_0 = CoreWaterElement
l_0_0.get_interval = function(l_194_0)
	return l_194_0._interval
end

l_0_0 = CoreWaterElement
l_0_0.get_ref_object = function(l_195_0)
	return l_195_0._ref_object
end

l_0_0 = CoreWaterElement
l_0_0.get_ref_body = function(l_196_0)
	return l_196_0._ref_body
end

l_0_0 = CoreWaterElement
l_0_0.get_body_depth = function(l_197_0)
	return l_197_0._body_depth
end

l_0_0 = CoreWaterElement
l_0_0.get_physic_effect = function(l_198_0)
	return l_198_0._physic_effect
end

l_0_0 = CoreWaterElement
l_0_0.activate_enter = function(l_199_0, l_199_1)
	if l_199_0._enter_element then
		l_199_0._enter_element:activate(l_199_1)
	end
end

l_0_0 = CoreWaterElement
l_0_0.activate_exit = function(l_200_0, l_200_1)
	if l_200_0._exit_element then
		l_200_0._exit_element:activate(l_200_1)
	end
end

l_0_0 = CoreSequenceContainerElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreSequenceContainerElement = l_0_0
l_0_0 = CoreSequenceContainerElement
l_0_0.init = function(l_201_0, l_201_1, l_201_2)
	local l_201_6 = CoreBaseElement.init
	l_201_6(l_201_0, l_201_1, l_201_2)
	l_201_0._sequence_list, l_201_6 = l_201_6, {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_201_6 do
		if l_201_5:name() == "run_sequence" then
			local l_201_7 = managers.sequence:parse_event(l_201_5, l_201_2)
			if l_201_7 then
				table.insert(l_201_0._sequence_list, l_201_7)
			end
		else
			local l_201_8, l_201_9 = l_201_0:check_invalid_node, l_201_0
			local l_201_10 = l_201_5
			local l_201_11 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			l_201_8(l_201_9, l_201_10, l_201_11)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreSequenceContainerElement
l_0_0.sequence_count = function(l_202_0)
	return #l_202_0._sequence_list
end

l_0_0 = CoreSequenceContainerElement
l_0_0.activate_callback = function(l_203_0, l_203_1)
	local l_203_5, l_203_6, l_203_7, l_203_8 = nil
	for i_0,i_1 in ipairs(l_203_0._sequence_list) do
		i_1:activate(l_203_1)
	end
end

l_0_0 = CoreEnterWaterElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreSequenceContainerElement)
end
CoreEnterWaterElement = l_0_0
l_0_0 = CoreExitWaterElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreSequenceContainerElement)
end
CoreExitWaterElement = l_0_0
l_0_0 = CoreRootBodyElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreRootBodyElement = l_0_0
l_0_0 = CoreRootBodyElement
l_0_0.init = function(l_204_0, l_204_1, l_204_2)
	CoreBaseElement.init(l_204_0, l_204_1, l_204_2)
	l_204_0._name = l_204_0:get("name")
	if l_204_0._name then
		l_204_0._name = l_204_0._name(SequenceEnvironment)
	else
		local l_204_6, l_204_7, l_204_24, l_204_25, l_204_26, l_204_27, l_204_29, l_204_30, l_204_31 = error, "\"", tostring(l_204_1:name()), "\" element for unit \""
		l_204_26 = tostring
		l_204_27 = l_204_2._name
		l_204_26 = l_204_26(l_204_27)
		l_204_27 = "\" doesn't have a name."
		l_204_7 = l_204_7 .. l_204_24 .. l_204_25 .. l_204_26 .. l_204_27
		l_204_6(l_204_7)
	end
	l_204_0._damage_multiplier = l_204_0:get("damage_multiplier")
	if not l_204_0._damage_multiplier(SequenceEnvironment) then
		l_204_0._damage_multiplier = not l_204_0._damage_multiplier or 1
		do return end
	end
	l_204_0._damage_multiplier = 1
	l_204_0._inflict_element = nil
	l_204_0._first_endurance = {}
	for i_0 in l_204_1:children() do
		do
			local l_204_28, l_204_32 = (i_0:name())
			l_204_32 = nil
			local l_204_9 = nil
			if l_204_28 == "inflict" then
				l_204_9 = l_204_0._inflict_element
				if l_204_9 then
					l_204_9 = Application
					do
						local l_204_14, l_204_15, l_204_16, l_204_17, l_204_18 = l_204_9, "\"", l_204_0._name, "\" element for unit \""
						l_204_18 = tostring
						l_204_18 = l_204_18(l_204_2._name)
						l_204_15 = l_204_15 .. l_204_16 .. l_204_17 .. l_204_18 .. "\" have a duplicate \"inflict\" element."
						l_204_9(l_204_14, l_204_15)
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				else
					l_204_0._inflict_element = l_204_9
				end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			elseif l_204_28 == "endurance" then
				local l_204_13 = l_204_9
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_204_32 = l_204_9
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_204_13 = l_204_32._endurance
				 -- DECOMPILER ERROR: Overwrote pending register.

				for i_0,i_1 in l_204_9 do
					if l_204_0._first_endurance[l_204_11] == nil then
						l_204_0._first_endurance[l_204_11] = l_204_32
					else
						if l_204_12 < l_204_0._first_endurance[l_204_11]._endurance[l_204_11] then
							l_204_32._next[l_204_11] = l_204_0._first_endurance[l_204_11]
							l_204_0._first_endurance[l_204_11] = l_204_32
						end
					else
						while 1 do
							local l_204_19 = l_204_0._first_endurance[l_204_11]
							while l_204_19._next[l_204_11] and l_204_19._next[l_204_11]._endurance[l_204_11] <= l_204_12 do
								l_204_19 = l_204_19._next[l_204_11]
							end
							l_204_32._next[l_204_11] = l_204_19._next[l_204_11]
							l_204_19._next[l_204_11] = l_204_32
						end
					end
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				 -- DECOMPILER ERROR: Overwrote pending register.

				else
					local l_204_20, l_204_21 = l_204_0
					l_204_21 = l_204_8
					local l_204_22 = nil
					local l_204_23 = nil
					l_204_23 = "inflict"
					l_204_9(l_204_20, l_204_21, l_204_22)
					l_204_22 = {l_204_23, "endurance"}
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		l_204_0._body_params = {}
		for i_0,l_204_28 in pairs(l_204_0._parameters) do
			if i_0 ~= "name" and i_0 ~= "damage_multiplier" then
				l_204_32 = l_204_0._body_params
				l_204_32[i_0] = l_204_0:get(i_0)
				l_204_32 = l_204_0._body_params
				l_204_32 = l_204_32[i_0]
			if l_204_32 then
				end
				l_204_32 = l_204_0._body_params
				l_204_32[i_0] = l_204_0._body_params[i_0](SequenceEnvironment)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

l_0_0 = CoreRootBodyElement
l_0_0.get_body_param = function(l_205_0, l_205_1)
	return l_205_0._body_params[l_205_1]
end

l_0_0 = CoreRootBodyElement
l_0_0.get_body_param_list = function(l_206_0)
	return l_206_0._body_params
end

l_0_0 = CoreRootBodyElement
l_0_0.get_first_endurance_element = function(l_207_0, l_207_1)
	return l_207_0._first_endurance[l_207_1]
end

l_0_0 = CoreRootBodyElement
l_0_0.get_first_endurance_element_list = function(l_208_0)
	return l_208_0._first_endurance
end

l_0_0 = CoreRootBodyElement
l_0_0.activate_inflict_enter = function(l_209_0, l_209_1)
	l_209_0._inflict_element:activate_enter(l_209_1)
end

l_0_0 = CoreRootBodyElement
l_0_0.activate_inflict_damage = function(l_210_0, l_210_1)
	l_210_0._inflict_element:activate_damage(l_210_1)
end

l_0_0 = CoreRootBodyElement
l_0_0.activate_inflict_exit = function(l_211_0, l_211_1)
	l_211_0._inflict_element:activate_exit(l_211_1)
end

l_0_0 = CoreRootBodyElement
l_0_0.get_inflict_element_list = function(l_212_0)
	if l_212_0._inflict_element then
		local l_212_1, l_212_2 = l_212_0._inflict_element:get_element_list, l_212_0._inflict_element
		return l_212_1(l_212_2)
	end
end

l_0_0 = CoreRootInflictElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreRootInflictElement = l_0_0
l_0_0 = CoreRootInflictElement
l_0_0.init = function(l_213_0, l_213_1, l_213_2)
	local l_213_7, l_213_8 = nil
	CoreBaseElement.init(l_213_0, l_213_1, l_213_2)
	l_213_0._element_list = {}
	local l_213_3 = managers.sequence:get_inflict_element_class_map()
	for i_0 in l_213_1:children() do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_213_3[i_0:name()] then
			local l_213_10 = nil
			l_213_0._element_list[l_213_3[i_0:name()]:new(l_213_9, l_213_2)._element_name] = l_213_3[i_0:name()]:new(l_213_9, l_213_2)
		else
			l_213_0:check_invalid_node(l_213_9, l_213_3)
		end
	end
end

l_0_0 = CoreRootInflictElement
l_0_0.activate_enter = function(l_214_0, l_214_1)
	l_214_0._element_list[l_214_1.damage_type]:activate_enter(l_214_1)
end

l_0_0 = CoreRootInflictElement
l_0_0.activate_damage = function(l_215_0, l_215_1)
	l_215_0._element_list[l_215_1.damage_type]:activate_damage(l_215_1)
end

l_0_0 = CoreRootInflictElement
l_0_0.activate_exit = function(l_216_0, l_216_1)
	l_216_0._element_list[l_216_1.damage_type]:activate_exit(l_216_1)
end

l_0_0 = CoreRootInflictElement
l_0_0.get_element_list = function(l_217_0)
	return l_217_0._element_list
end

l_0_0 = CoreInflictElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreBaseElement)
end
CoreInflictElement = l_0_0
l_0_0 = CoreInflictElement
l_0_0.init = function(l_218_0, l_218_1, l_218_2)
	local l_218_6 = CoreBaseElement.init
	l_218_6(l_218_0, l_218_1, l_218_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_218_0._damage = l_218_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_218_6 then
		l_218_0._damage = l_218_6
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_218_0._interval = l_218_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_218_6 then
		l_218_0._interval = l_218_6
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_218_0._instant = l_218_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_218_6 then
		l_218_0._instant = l_218_6
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	if l_218_6 == nil then
		l_218_0._instant = false
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_218_0._enabled = l_218_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_218_6 then
		l_218_0._enabled = l_218_6
		 -- DECOMPILER ERROR: Overwrote pending register.

	end
	if l_218_6 == nil then
		l_218_0._enabled = true
	end
	l_218_0._enter_element = nil
	l_218_0._damage_element = nil
	l_218_0._exit_element = nil
	l_218_0._enter_sequence_list, l_218_6 = l_218_6, {}
	l_218_0._sequence_list, l_218_6 = l_218_6, {}
	l_218_0._exit_sequence_list, l_218_6 = l_218_6, {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_218_6 do
		local l_218_7 = l_218_5:name()
		if l_218_7 == "enter" then
			l_218_0._enter_element = get_core_or_local("EnterInflictElement"):new(l_218_5, l_218_2)
		elseif l_218_7 == "damage" then
			l_218_0._damage_element = get_core_or_local("DamageInflictElement"):new(l_218_5, l_218_2)
		elseif l_218_7 == "exit" then
			l_218_0._exit_element = get_core_or_local("ExitInflictElement"):new(l_218_5, l_218_2)
		else
			local l_218_8, l_218_9 = l_218_0:check_invalid_node, l_218_0
			local l_218_10 = l_218_5
			local l_218_11 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			l_218_8(l_218_9, l_218_10, l_218_11)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreInflictElement
l_0_0.get_damage = function(l_219_0)
	return l_219_0._damage
end

l_0_0 = CoreInflictElement
l_0_0.get_interval = function(l_220_0)
	return l_220_0._interval
end

l_0_0 = CoreInflictElement
l_0_0.get_instant = function(l_221_0)
	return l_221_0._instant
end

l_0_0 = CoreInflictElement
l_0_0.get_enabled = function(l_222_0)
	return l_222_0._enabled
end

l_0_0 = CoreInflictElement
l_0_0.get_enter_element = function(l_223_0)
	return l_223_0._enter_element
end

l_0_0 = CoreInflictElement
l_0_0.get_exit_element = function(l_224_0)
	return l_224_0._exit_element
end

l_0_0 = CoreInflictElement
l_0_0.get_damage_element = function(l_225_0)
	return l_225_0._damage_element
end

l_0_0 = CoreInflictElement
l_0_0.activate_enter = function(l_226_0, l_226_1)
	if l_226_0._enter_element then
		l_226_0._enter_element:activate(l_226_1)
	end
end

l_0_0 = CoreInflictElement
l_0_0.activate_damage = function(l_227_0, l_227_1)
	if l_227_0._damage_element then
		l_227_0._damage_element:activate(l_227_1)
	end
end

l_0_0 = CoreInflictElement
l_0_0.activate_exit = function(l_228_0, l_228_1)
	if l_228_0._exit_element then
		l_228_0._exit_element:activate(l_228_1)
	end
end

l_0_0 = CoreInflictElement
l_0_0.enter_sequence_count = function(l_229_0)
	if l_229_0._enter_element then
		local l_229_1, l_229_2 = l_229_0._enter_element:sequence_count, l_229_0._enter_element
		return l_229_1(l_229_2)
	else
		return 0
	end
end

l_0_0 = CoreInflictElement
l_0_0.damage_sequence_count = function(l_230_0)
	if l_230_0._damage_element then
		local l_230_1, l_230_2 = l_230_0._damage_element:sequence_count, l_230_0._damage_element
		return l_230_1(l_230_2)
	else
		return 0
	end
end

l_0_0 = CoreInflictElement
l_0_0.exit_sequence_count = function(l_231_0)
	if l_231_0._exit_element then
		local l_231_1, l_231_2 = l_231_0._exit_element:sequence_count, l_231_0._exit_element
		return l_231_1(l_231_2)
	else
		return 0
	end
end

l_0_0 = CoreInflictElectricityElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreInflictElement)
end
CoreInflictElectricityElement = l_0_0
l_0_0 = CoreInflictElectricityElement
l_0_0.NAME = "electricity"
l_0_0 = CoreInflictFireElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0(CoreInflictElement)
end
CoreInflictFireElement = l_0_0
l_0_0 = CoreInflictFireElement
l_0_0.NAME = "fire"
l_0_0 = CoreInflictFireElement
l_0_0.init = function(l_232_0, l_232_1, l_232_2)
	CoreInflictElement.init(l_232_0, l_232_1, l_232_2)
	l_232_0._fire_object_name = l_232_0:get("fire_object")
	if l_232_0._fire_object_name then
		l_232_0._fire_object_name = l_232_0._fire_object_name(SequenceEnvironment)
	end
	l_232_0._fire_height = l_232_0:get("fire_height")
	if l_232_0._fire_height then
		l_232_0._fire_height = l_232_0._fire_height(SequenceEnvironment)
	end
	l_232_0._velocity = l_232_0:get("velocity")
	if l_232_0._velocity then
		l_232_0._velocity = l_232_0._velocity(SequenceEnvironment)
	end
	l_232_0._falloff = l_232_0:get("falloff")
	if l_232_0._falloff then
		l_232_0._falloff = l_232_0._falloff(SequenceEnvironment)
	end
end

l_0_0 = CoreInflictFireElement
local l_0_3 = "get_fire_object_name"
l_0_0[l_0_3] = function(l_233_0)
	return l_233_0._fire_object_name
end

l_0_0 = CoreInflictFireElement
l_0_3 = "get_fire_height"
l_0_0[l_0_3] = function(l_234_0)
	return l_234_0._fire_height
end

l_0_0 = CoreInflictFireElement
l_0_3 = "get_velocity"
l_0_0[l_0_3] = function(l_235_0)
	return l_235_0._velocity
end

l_0_0 = CoreInflictFireElement
l_0_3 = "get_falloff"
l_0_0[l_0_3] = function(l_236_0)
	return l_236_0._falloff
end

l_0_0 = CoreEnterInflictElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreSequenceContainerElement
	l_0_0 = l_0_0(l_0_3)
end
CoreEnterInflictElement = l_0_0
l_0_0 = CoreDamageInflictElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreSequenceContainerElement
	l_0_0 = l_0_0(l_0_3)
end
CoreDamageInflictElement = l_0_0
l_0_0 = CoreExitInflictElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreSequenceContainerElement
	l_0_0 = l_0_0(l_0_3)
end
CoreExitInflictElement = l_0_0
l_0_0 = CoreEnduranceElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreEnduranceElement = l_0_0
l_0_0 = CoreEnduranceElement
l_0_3 = function(l_237_0, l_237_1, l_237_2)
	local l_237_7, l_237_8, l_237_9, l_237_10, l_237_11, l_237_12, l_237_13 = nil
	local l_237_6 = CoreBaseElement.init
	l_237_6(l_237_0, l_237_1, l_237_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_237_0._can_skip = l_237_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_237_6 then
		l_237_0._can_skip = l_237_6
	end
	l_237_0._next, l_237_6 = l_237_6, {}
	l_237_0._endurance, l_237_6 = l_237_6, {}
	l_237_0._abs, l_237_6 = l_237_6, {}
	l_237_6 = pairs
	l_237_6 = l_237_6(l_237_0._parameters)
	for i_0,i_1 in l_237_6 do
		if l_237_5 ~= "can_skip" and string.sub(l_237_5, -4) ~= "_abs" then
			l_237_0._endurance[l_237_5] = l_237_0:get(l_237_5)
			if l_237_0._endurance[l_237_5] then
				l_237_0._endurance[l_237_5] = l_237_0._endurance[l_237_5](SequenceEnvironment)
			end
			if l_237_0._endurance[l_237_5] then
				l_237_0._abs[l_237_5] = l_237_0:get(l_237_5 .. "_abs")
				if not l_237_0._abs[l_237_5](SequenceEnvironment) then
					l_237_0._abs[l_237_5] = not l_237_0._abs[l_237_5] or 0
				end
				for l_237_5,i_1 in l_237_6 do
				end
				l_237_0._abs[l_237_5] = 0
			else
				Application:throw_exception("\"" .. tostring(l_237_1:name()) .. "\" element for unit \"" .. tostring(l_237_2._name) .. "\" had a endurance \"" .. l_237_5 .. "\" with the invalid value of \"" .. i_1 .. "\".")
			end
		end
		l_237_0._elements = {}
		for i_0 in l_237_1:children() do
			if i_0:name() == "run_sequence" then
				local l_237_14 = managers.sequence:parse_event(i_0, l_237_2)
				if l_237_14 then
					table.insert(l_237_0._elements, l_237_14)
				end
			else
				local l_237_15, l_237_16 = l_237_0:check_invalid_node, l_237_0
				local l_237_17 = i_0
				do
					local l_237_18 = {}
					 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

					l_237_15(l_237_16, l_237_17, l_237_18)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreEnduranceElement
l_0_3 = "can_skip"
l_0_0[l_0_3] = function(l_238_0)
	return l_238_0._can_skip
end

l_0_0 = CoreEnduranceElement
l_0_3 = "damage"
l_0_0[l_0_3] = function(l_239_0, l_239_1)
	local l_239_2 = l_239_1.damage - l_239_0._abs[l_239_1.damage_type]
	if l_239_2 >= 0 then
		local l_239_3 = l_239_1.dest_body:extension().damage
		local l_239_4 = l_239_3._damage
		local l_239_5 = l_239_1.damage_type
		l_239_4[l_239_5] = l_239_3._damage[l_239_1.damage_type] + l_239_2
		l_239_4 = l_239_3._damage
		l_239_5 = l_239_1.damage_type
		l_239_4 = l_239_4[l_239_5]
		l_239_5 = l_239_0._endurance
		l_239_5 = l_239_5[l_239_1.damage_type]
	if l_239_5 <= l_239_4 then
		end
		l_239_4 = l_239_3._damage
		l_239_5 = l_239_1.damage_type
		l_239_4 = l_239_4[l_239_5]
		l_239_5(l_239_0, l_239_1)
	end
end

l_0_0 = CoreEnduranceElement
l_0_3 = function(l_240_0, l_240_1)
	local l_240_2 = l_240_1.dest_body:extension().damage
	local l_240_3 = l_240_2._endurance
	local l_240_4 = l_240_1.damage_type
	l_240_3[l_240_4] = l_240_0._next[l_240_1.damage_type]
	l_240_3 = l_240_0._next
	l_240_4 = l_240_1.damage_type
	l_240_3 = l_240_3[l_240_4]
	if l_240_3 then
		l_240_4 = l_240_0._can_skip
	if l_240_4 then
		end
		l_240_4 = l_240_2._damage
		l_240_4 = l_240_4[l_240_1.damage_type]
		l_240_4 = l_240_3._endurance[l_240_1.damage_type] <= l_240_4
	end
	if not l_240_4 then
		l_240_0:activate_elements(l_240_1)
		l_240_3 = l_240_0._next[l_240_1.damage_type]
	end
	if l_240_3 and l_240_3._endurance[l_240_1.damage_type] <= l_240_2._damage[l_240_1.damage_type] then
		l_240_3:activate(l_240_1)
		local l_240_5 = managers.sequence:get_inflict_updator_unit_map(l_240_1.damage_type)
	if l_240_5 then
		end
	if not l_240_2._damage[l_240_1.damage_type] then
		end
	if alive(l_240_1.dest_body) then
		end
		managers.sequence:remove_inflict_updator_body(l_240_1.damage_type, l_240_1.dest_unit:key(), l_240_1.dest_body:key())
	end
end

l_0_0.activate = l_0_3
l_0_0 = CoreEnduranceElement
l_0_3 = function(l_241_0, l_241_1)
	local l_241_5, l_241_6, l_241_7, l_241_8 = nil
	for i_0,i_1 in ipairs(l_241_0._elements) do
		i_1:activate(l_241_1)
	end
end

l_0_0.activate_elements = l_0_3
l_0_0 = CoreAnimationGroupElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreAnimationGroupElement = l_0_0
l_0_0 = CoreAnimationGroupElement
l_0_3 = "animation_group"
l_0_0.NAME = l_0_3
l_0_0 = CoreAnimationGroupElement
l_0_3 = function(l_242_0, l_242_1, l_242_2)
	CoreBaseElement.init(l_242_0, l_242_1, l_242_2)
	l_242_0._name = l_242_0:get("name")
	l_242_0._action = l_242_0:get("action")
	l_242_0._duration = l_242_0:get("duration")
	l_242_0._once = l_242_0:get("once")
	l_242_0._speed = l_242_0:get("speed")
	l_242_0._time = l_242_0:get("time")
	l_242_0._end_time = l_242_0:get("end_time")
	l_242_0._loop = l_242_0:get("loop")
	l_242_0._start_loop_time = l_242_0:get("start_loop_time")
end

l_0_0.init = l_0_3
l_0_0 = CoreAnimationGroupElement
l_0_3 = function(l_243_0, l_243_1)
	local l_243_2 = l_243_0:run_parsed_func(l_243_1, l_243_0._name)
	local l_243_3 = (l_243_0:run_parsed_func(l_243_1, l_243_0._action))
	local l_243_4 = nil
	if l_243_3 then
		l_243_4 = l_243_0[l_243_3]
	else
		l_243_4 = l_243_0.play
	end
	l_243_4(l_243_0, l_243_1, l_243_2)
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreAnimationGroupElement
l_0_3 = "play"
l_0_0[l_0_3] = function(l_244_0, l_244_1, l_244_2)
	local l_244_3 = l_244_0:run_parsed_func(l_244_1, l_244_0._once)
	if not l_244_3 or not l_244_1.dest_unit:anim_is_playing(l_244_2) then
		l_244_0:set_time(l_244_1, l_244_2)
		local l_244_4 = l_244_0:run_parsed_func(l_244_1, l_244_0._duration)
		do
			local l_244_5 = l_244_0:run_parsed_func(l_244_1, l_244_0._speed) or 1
		end
		local l_244_6 = nil
		local l_244_7 = nil
		if l_244_0:run_parsed_func(l_244_1, l_244_0._loop) then
			if not l_244_0:run_parsed_func(l_244_1, l_244_0._start_loop_time) then
				local l_244_8, l_244_9, l_244_10, l_244_11 = , l_244_1.dest_unit:anim_time(l_244_2)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_244_4 then
				l_244_7 = l_244_9 + l_244_4
			else
				l_244_7 = l_244_0:run_parsed_func(l_244_1, l_244_0._end_time)
			end
			if not l_244_7 then
				l_244_7 = l_244_1.dest_unit:anim_length(l_244_2)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_244_1.dest_unit:anim_play_loop(l_244_2, l_244_9, l_244_7, l_244_6)
		if l_244_0.SAVE_STATE then
			end
			local l_244_12, l_244_13 = nil
			local l_244_14 = l_244_0:set_cat_state
			local l_244_15 = l_244_0
			local l_244_16 = l_244_1.dest_unit
			l_244_14(l_244_15, l_244_16, l_244_2, {"anim_play_loop", l_244_13, l_244_7, l_244_6})
		end
	elseif l_244_4 then
		l_244_7 = l_244_1.dest_unit:anim_time(l_244_2) + l_244_4
	else
		l_244_7 = l_244_0:run_parsed_func(l_244_1, l_244_0._end_time)
	end
	if l_244_7 then
		l_244_1.dest_unit:anim_play_to(l_244_2, l_244_7, l_244_6)
		if l_244_0.SAVE_STATE then
			local l_244_17, l_244_18 = , l_244_0:set_cat_state
			local l_244_19 = l_244_0
			local l_244_20 = l_244_1.dest_unit
			local l_244_21 = l_244_2
			l_244_18(l_244_19, l_244_20, l_244_21, {"anim_play_to", l_244_7, l_244_6})
		end
	else
		l_244_1.dest_unit:anim_play(l_244_2, l_244_6)
	if l_244_0.SAVE_STATE then
		end
		local l_244_22, l_244_23 = , l_244_0:set_cat_state
		local l_244_24 = l_244_0
		local l_244_25 = l_244_1.dest_unit
		local l_244_26 = l_244_2
		l_244_23(l_244_24, l_244_25, l_244_26, {"anim_play", l_244_6})
	end
end

l_0_0 = CoreAnimationGroupElement
l_0_3 = "stop"
l_0_0[l_0_3] = function(l_245_0, l_245_1, l_245_2)
	l_245_1.dest_unit:anim_stop(l_245_2)
	if l_245_0.SAVE_STATE then
		local l_245_3, l_245_4 = l_245_0:set_cat_state, l_245_0
		local l_245_5 = l_245_1.dest_unit
		local l_245_6 = l_245_2
		local l_245_7 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_245_3(l_245_4, l_245_5, l_245_6, l_245_7)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreAnimationGroupElement
l_0_3 = "set_time"
l_0_0[l_0_3] = function(l_246_0, l_246_1, l_246_2)
	local l_246_3 = l_246_0:run_parsed_func(l_246_1, l_246_0._time)
	if l_246_3 then
		l_246_1.dest_unit:anim_set_time(l_246_2, l_246_3)
	end
end

l_0_0 = CoreAnimationGroupElement
l_0_3 = function(l_247_0, l_247_1)
	local l_247_5, l_247_6, l_247_7, l_247_8, l_247_9, l_247_10, l_247_11, l_247_12, l_247_13, l_247_14, l_247_15 = nil
	for i_0,i_1 in pairs(l_247_1) do
		l_247_0[i_1[1]](l_247_0, i_0, i_1[2], i_1[3], i_1[4])
	end
end

l_0_0.load = l_0_3
l_0_0 = CoreAreaDamageElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreAreaDamageElement = l_0_0
l_0_0 = CoreAreaDamageElement
l_0_3 = "area_damage"
l_0_0.NAME = l_0_3
l_0_0 = CoreAreaDamageElement
l_0_3 = function(l_248_0, l_248_1, l_248_2)
	local l_248_6 = CoreBaseElement.init
	l_248_6(l_248_0, l_248_1, l_248_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_248_0._damage_type = l_248_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_248_0._position = l_248_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_248_0._range = l_248_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_248_0._damage = l_248_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_248_0._physic_effect = l_248_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_248_0._mass = l_248_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_248_0._falloff = l_248_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_248_0._ignore_mask = l_248_6
	l_248_0._falloff_func_map, l_248_6 = l_248_6, {}
	l_248_6 = l_248_0._falloff_func_map
	l_248_6.linear = nil
	l_248_6 = l_248_0._falloff_func_map
	l_248_6.keys = "get_falloff_key_damage"
	l_248_6 = l_248_0._falloff_func_map
	l_248_6.preset1 = "get_falloff_preset1_damage"
	l_248_0._key_list, l_248_6 = l_248_6, {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_248_6 do
		local l_248_7 = l_248_5:name()
		if l_248_7 == "key" then
			local l_248_8 = AreaDamageKeyElement:new(l_248_5, l_248_2)
			table.insert(l_248_0._key_list, l_248_8)
		else
			local l_248_9, l_248_10 = l_248_0:check_invalid_node, l_248_0
			local l_248_11 = l_248_5
			local l_248_12 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			l_248_9(l_248_10, l_248_11, l_248_12)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0.init = l_0_3
l_0_0 = CoreAreaDamageElement
l_0_3 = function(l_249_0, l_249_1)
	local l_249_2 = l_249_0:run_parsed_func(l_249_1, l_249_0._damage_type)
	if not l_249_2 then
		l_249_0:print_attribute_error("damage_type", l_249_2, nil, false, l_249_1)
	else
		local l_249_3 = l_249_0:run_parsed_func(l_249_1, l_249_0._position)
		if not l_249_3 then
			l_249_0:print_attribute_error("position", l_249_3, nil, false, l_249_1)
		end
	else
		local l_249_4 = l_249_0:run_parsed_func(l_249_1, l_249_0._range)
	if l_249_4 and l_249_4 > 0 then
		end
		do
			local l_249_5 = l_249_0:run_parsed_func(l_249_1, l_249_0._damage) or 0
		end
		local l_249_6 = nil
		local l_249_7 = l_249_0:run_parsed_func(l_249_1, l_249_0._physic_effect)
		local l_249_8 = l_249_0:run_parsed_func(l_249_1, l_249_0._mass)
		if l_249_0:run_parsed_func(l_249_1, l_249_0._falloff) then
			local l_249_10 = nil
		end
		do
			local l_249_11 = l_249_0._falloff_func_map[l_249_0:run_parsed_func(l_249_1, l_249_0._falloff)]
			 -- DECOMPILER ERROR: unhandled construct in 'if'

			if (not l_249_0:run_parsed_func(l_249_1, l_249_0._ignore_mask) or #l_249_0._key_list == 0) and l_249_10 == "keys" then
				do return end
			if not l_249_11 then
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

			end
			if l_249_11 then
				local l_249_12 = nil
			end
			l_249_0:do_area_damage(l_249_1, l_249_2, l_249_1.dest_unit, l_249_3, l_249_4, not l_249_10, l_249_6, l_249_7, l_249_8, nil, l_249_1.src_unit, managers.slot:get_mask(l_249_0:run_parsed_func(l_249_1, l_249_0._ignore_mask)), l_249_12, l_249_1.velocity)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreAreaDamageElement
l_0_3 = "get_params"
l_0_0[l_0_3] = function(l_250_0, l_250_1)
	local l_250_6, l_250_7, l_250_8, l_250_9, l_250_15, l_250_16, l_250_17 = nil
	local l_250_2 = {}
	l_250_2.env = l_250_1
	l_250_2.parsed_key_list = {}
	for i_0,i_1 in ipairs(l_250_0._key_list) do
		do
			for i_0,i_1 in ipairs(l_250_2.parsed_key_list) do
				local l_250_12, l_250_13 = (i_1:get_parsed_key(l_250_1)), nil
				if i_1:get_variable("range") < l_250_12:get_variable("range") then
					l_250_13 = i_0
			else
				end
			end
			if not l_250_13 then
				table.insert(l_250_2.parsed_key_list, #l_250_2.parsed_key_list + 1, l_250_12)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		return l_250_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreAreaDamageElement
l_0_3 = function(l_251_0, l_251_1, l_251_2, l_251_3, l_251_4, l_251_5, l_251_6, l_251_7, l_251_8, l_251_9, l_251_10, l_251_11, l_251_12, l_251_13, l_251_14)
	managers.sequence:do_area_damage(l_251_2, l_251_3, l_251_4, l_251_5, l_251_6, l_251_7, l_251_8, l_251_9, l_251_10, l_251_11, l_251_12, l_251_13, l_251_14)
end

l_0_0.do_area_damage = l_0_3
l_0_0 = CoreAreaDamageElement
l_0_3 = "get_falloff_key_damage"
l_0_0[l_0_3] = function(l_252_0, l_252_1, l_252_2, l_252_3, l_252_4, l_252_5, l_252_6, l_252_7, l_252_8, l_252_9, l_252_10, l_252_11, l_252_12, l_252_13, l_252_14, l_252_15)
	local l_252_22, l_252_23, l_252_24, l_252_25, l_252_26, l_252_27, l_252_28, l_252_29 = nil
	local l_252_16 = (l_252_0:get_distance(l_252_3, l_252_5, l_252_8))
	local l_252_17, l_252_18 = nil, nil
	for i_0,i_1 in ipairs(l_252_1.parsed_key_list) do
		if i_1:get_variable("range") < l_252_16 and not l_252_17 then
			l_252_17 = i_1
			l_252_18 = i_0
		end
		do return end
		for i_0,i_1 in l_252_19 do
			l_252_17 = i_1
			l_252_18 = i_0
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_252_17 then
			if l_252_1.parsed_key_list[l_252_18 + 1] then
				local l_252_36 = l_252_1.parsed_key_list[l_252_18 + 1]:get_key_element():activate
				do
					local l_252_37 = l_252_1.parsed_key_list[l_252_18 + 1]:get_key_element()
					l_252_36(l_252_37, l_252_1.env, l_252_2, l_252_3, l_252_5, l_252_16, l_252_9)
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			else
				if l_252_17:get_variable("range") <= l_252_16 then
					do return end
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_252_30, l_252_31 = l_252_17:get_key_element():get_distance_damage, l_252_17:get_key_element()
			local l_252_32 = l_252_17
			local l_252_33 = l_252_16
			local l_252_34 = nil
			local l_252_35 = nil
			return l_252_30(l_252_31, l_252_32, l_252_33, l_252_34, l_252_35)
		else
			return l_252_11
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

l_0_0 = CoreAreaDamageElement
l_0_3 = "get_falloff_preset1_damage"
l_0_0[l_0_3] = function(l_253_0, l_253_1, l_253_2, l_253_3, l_253_4, l_253_5, l_253_6, l_253_7, l_253_8, l_253_9, l_253_10, l_253_11, l_253_12, l_253_13, l_253_14, l_253_15)
	return (1 - l_253_0:get_distance(l_253_3, l_253_5, l_253_8) / l_253_9 ^ 2) * l_253_11
end

l_0_0 = CoreAreaDamageElement
l_0_3 = "get_distance"
l_0_0[l_0_3] = function(l_254_0, l_254_1, l_254_2, l_254_3)
	if not l_254_1 or not get_distance_to_body(l_254_1, l_254_3) then
		return l_254_2 - l_254_3:length()
	end
end

l_0_0 = AreaDamageKeyElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
AreaDamageKeyElement = l_0_0
l_0_0 = AreaDamageKeyElement
l_0_3 = function(l_255_0, l_255_1, l_255_2)
	CoreBaseElement.init(l_255_0, l_255_1, l_255_2)
	l_255_0._range = l_255_0:get("range")
	l_255_0._damage = l_255_0:get("damage")
	l_255_0._falloff_type = l_255_0:get("falloff")
	l_255_0._physic_effect = l_255_0:get("physic_effect")
	l_255_0._mass = l_255_0:get("mass")
	l_255_0._falloff_func_map = {}
	l_255_0._falloff_func_map.linear = l_255_0.get_linear_damage
end

l_0_0.init = l_0_3
l_0_0 = AreaDamageKeyElement
l_0_3 = "get_parsed_key"
l_0_0[l_0_3] = function(l_256_0, l_256_1)
	local l_256_2 = ParsedKeyElement:new(l_256_0)
	l_256_2:set_variable("range", tonumber(l_256_0:run_parsed_func(l_256_1, l_256_0._range)) or 0)
	l_256_2:set_variable("damage", tonumber(l_256_0:run_parsed_func(l_256_1, l_256_0._damage)) or 0)
	local l_256_3 = l_256_0:run_parsed_func(l_256_1, l_256_0._falloff_type)
	local l_256_4, l_256_5 = l_256_2:set_variable, l_256_2
	local l_256_6 = "falloff_func"
	do
		if l_256_3 then
			l_256_4(l_256_5, l_256_6, l_256_0._falloff_func_map[l_256_3])
		end
		l_256_4, l_256_5 = l_256_2:set_variable, l_256_2
		l_256_6 = "physic_effect"
		l_256_4(l_256_5, l_256_6, l_256_0:run_parsed_func(l_256_1, l_256_0._physic_effect))
		l_256_4, l_256_5 = l_256_2:set_variable, l_256_2
		l_256_6 = "mass"
		l_256_4(l_256_5, l_256_6, l_256_0:run_parsed_func(l_256_1, l_256_0._mass))
		return l_256_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = AreaDamageKeyElement
l_0_3 = "get_distance_damage"
l_0_0[l_0_3] = function(l_257_0, l_257_1, l_257_2, l_257_3, l_257_4)
	local l_257_5 = l_257_1:get_variable("falloff_func")
	if l_257_5 then
		local l_257_6 = l_257_1:get_variable("damage")
		local l_257_7 = l_257_1:get_variable("range")
		local l_257_8 = l_257_5
		local l_257_9 = l_257_0
		local l_257_10 = l_257_2
		local l_257_11 = l_257_7
		local l_257_12 = l_257_6
		local l_257_13 = l_257_3
		local l_257_14 = l_257_4
		return l_257_8(l_257_9, l_257_10, l_257_11, l_257_12, l_257_13, l_257_14)
	else
		return l_257_4
	end
end

l_0_0 = AreaDamageKeyElement
l_0_3 = function(l_258_0, l_258_1, l_258_2, l_258_3, l_258_4, l_258_5, l_258_6)
	SequenceEnvironment.element = l_258_0
	local l_258_7 = l_258_0:run_parsed_func(l_258_1, l_258_0._physic_effect)
	if l_258_7 then
		local l_258_8 = l_258_0:run_parsed_func(l_258_1, l_258_0._mass)
		if l_258_8 then
			local l_258_9, l_258_10 = World:play_physic_effect, World
			local l_258_11 = l_258_7
			l_258_9(l_258_10, l_258_11, l_258_3 or l_258_2, l_258_6, l_258_5, l_258_0._range, l_258_8)
		end
	else
		local l_258_13, l_258_14 = , World:play_physic_effect
		local l_258_15 = World
		do
			l_258_14(l_258_15, l_258_7, l_258_3 or l_258_2, l_258_6, l_258_5, l_258_0._range)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate = l_0_3
l_0_0 = AreaDamageKeyElement
l_0_3 = "get_linear_damage"
l_0_0[l_0_3] = function(l_259_0, l_259_1, l_259_2, l_259_3, l_259_4, l_259_5)
	local l_259_6 = l_259_2 - l_259_4
	local l_259_7 = nil
	if l_259_6 > 0 then
		l_259_7 = math.clamp(l_259_1 - l_259_4, 0, l_259_6) / l_259_6
	else
		l_259_7 = 0
	end
	local l_259_8 = math.lerp
	local l_259_9 = l_259_5
	local l_259_10 = l_259_3
	local l_259_11 = l_259_7
	return l_259_8(l_259_9, l_259_10, l_259_11)
end

l_0_0 = ParsedKeyElement
if not l_0_0 then
	l_0_0 = class
	l_0_0 = l_0_0()
end
ParsedKeyElement = l_0_0
l_0_0 = ParsedKeyElement
l_0_3 = function(l_260_0, l_260_1, l_260_2)
	l_260_0._key_element = l_260_1
	do
		if not l_260_2 then
			l_260_0._variable_map = {}
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.init = l_0_3
l_0_0 = ParsedKeyElement
l_0_3 = "get_key_element"
l_0_0[l_0_3] = function(l_261_0)
	return l_261_0._key_element
end

l_0_0 = ParsedKeyElement
l_0_3 = "get_variable"
l_0_0[l_0_3] = function(l_262_0, l_262_1)
	return l_262_0._variable_map[l_262_1]
end

l_0_0 = ParsedKeyElement
l_0_3 = "set_variable"
l_0_0[l_0_3] = function(l_263_0, l_263_1, l_263_2)
	l_263_0._variable_map[l_263_1] = l_263_2
end

l_0_0 = CoreBodyElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreBodyElement = l_0_0
l_0_0 = CoreBodyElement
l_0_0.NAME = "body"
l_0_0 = CoreBodyElement
l_0_3 = "VALID_MOTION_MAP"
if not CoreBodyElement.VALID_MOTION_MAP then
	local l_0_4, l_0_6 = {}
	l_0_6 = "fixed"
	local l_0_5 = nil
	l_0_5 = "set_fixed"
	l_0_4[l_0_6] = l_0_5
	l_0_6 = "keyframed"
	l_0_5 = "set_keyframed"
	l_0_4[l_0_6] = l_0_5
	l_0_6 = "dynamic"
	l_0_5 = "set_dynamic"
	l_0_4[l_0_6] = l_0_5
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_4
l_0_0 = CoreBodyElement
l_0_3 = "FUNC_MAP"
if not CoreBodyElement.FUNC_MAP then
	local l_0_7, l_0_9 = {}
	l_0_9 = "motion"
	local l_0_8 = nil
	l_0_8 = "set_motion"
	l_0_7[l_0_9] = l_0_8
	l_0_9 = "enabled"
	l_0_8 = "set_enabled"
	l_0_7[l_0_9] = l_0_8
	l_0_9 = "body_collision"
	l_0_8 = "set_body_collision"
	l_0_7[l_0_9] = l_0_8
	l_0_9 = "mover_collision"
	l_0_8 = "set_mover_collision"
	l_0_7[l_0_9] = l_0_8
	l_0_9 = "pushed_by_mover"
	l_0_8 = "set_pushed_by_mover"
	l_0_7[l_0_9] = l_0_8
	l_0_9 = "mover"
	l_0_8 = "set_mover"
	l_0_7[l_0_9] = l_0_8
	l_0_9 = "interpolate"
	l_0_8 = "interpolate"
	l_0_7[l_0_9] = l_0_8
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_7
l_0_0 = CoreBodyElement
l_0_3 = "VALID_MOVER_MAP"
if not CoreBodyElement.VALID_MOVER_MAP then
	local l_0_10, l_0_12 = {}
	l_0_12 = "none"
	local l_0_11 = nil
	l_0_11 = ""
	l_0_10[l_0_12] = l_0_11
	l_0_10.callback = "callback"
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_10
l_0_0 = CoreBodyElement
l_0_3 = function(l_264_0, l_264_1, l_264_2)
	local l_264_7, l_264_8 = nil
	local l_264_6 = CoreBaseElement.init
	l_264_6(l_264_0, l_264_1, l_264_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_264_0._name = l_264_6
	l_264_0._set_function_map, l_264_6 = l_264_6, {}
	l_264_6 = pairs
	l_264_6 = l_264_6(l_264_0.FUNC_MAP)
	for i_0,i_1 in l_264_6 do
		l_264_0._set_function_map[l_264_5] = l_264_0:get(l_264_5, l_264_0[i_1])
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_3
l_0_0 = CoreBodyElement
l_0_3 = function(l_265_0, l_265_1)
	local l_265_7, l_265_8, l_265_9, l_265_10 = nil
	local l_265_2 = l_265_0:run_parsed_func(l_265_1, l_265_0._name)
	if l_265_2 ~= nil then
		local l_265_3 = l_265_1.dest_unit:body(l_265_2)
	if alive(l_265_3) then
		end
		for i_0,i_1 in pairs(l_265_0._set_function_map) do
			i_1(l_265_1, l_265_3)
		end
		return 
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	local l_265_11 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	for l_265_15 = 1, l_265_1.dest_unit:num_bodies(), l_265_11 do
		local l_265_13, l_265_14, l_265_15 = nil
		l_265_13 = l_265_1.dest_unit
		l_265_13, l_265_14 = l_265_13:body, l_265_13
		l_265_15 = l_265_12 - 1
		l_265_13 = l_265_13(l_265_14, l_265_15)
		local l_265_16 = nil
		l_265_14 = alive
		l_265_15 = l_265_13
		l_265_14 = l_265_14(l_265_15)
		if l_265_14 then
			l_265_14 = table
			l_265_14 = l_265_14.insert
			l_265_15, l_265_3 = l_265_3, {}
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_265_14(l_265_15, l_265_16)
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	do
		local l_265_17 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_265_0:print_attribute_error(l_265_17, l_265_2, CoreSequenceManager:get_keys_as_string(l_265_11, "", true, false), true, l_265_16, nil)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreBodyElement
l_0_3 = "set_motion"
l_0_0[l_0_3] = function(l_266_0, l_266_1, l_266_2, l_266_3)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_266_2 or l_266_0.VALID_MOTION_MAP[l_266_2] then
		l_266_3[l_266_0.VALID_MOTION_MAP[l_266_2]](l_266_3)
		if l_266_0.SAVE_STATE then
			local l_266_5, l_266_6 = , l_266_0:set_cat_state2
			local l_266_7 = l_266_0
			local l_266_8 = l_266_3:unit()
			local l_266_9 = l_266_3:name()
			local l_266_10 = "motion"
			l_266_6(l_266_7, l_266_8, l_266_9, l_266_10, {l_266_5})
		end
	do
		else
			local l_266_11 = nil
			l_266_0:print_attribute_error("motion", l_266_2, CoreSequenceManager:get_keys_as_string(l_266_0.VALID_MOTION_MAP, "", true, true), true, l_266_1, nil)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0 = CoreBodyElement
l_0_3 = "set_enabled"
l_0_0[l_0_3] = function(l_267_0, l_267_1, l_267_2, l_267_3)
	l_267_3:set_enabled(l_267_2)
	if l_267_0.SAVE_STATE then
		local l_267_4, l_267_5 = l_267_0:set_cat_state2, l_267_0
		local l_267_6 = l_267_3:unit()
		local l_267_7 = l_267_3:name()
		local l_267_8 = "enabled"
		local l_267_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_267_4(l_267_5, l_267_6, l_267_7, l_267_8, l_267_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreBodyElement
l_0_3 = "set_body_collision"
l_0_0[l_0_3] = function(l_268_0, l_268_1, l_268_2, l_268_3)
	l_268_3:set_collisions_enabled(l_268_2)
	if l_268_0.SAVE_STATE then
		local l_268_4, l_268_5 = l_268_0:set_cat_state2, l_268_0
		local l_268_6 = l_268_3:unit()
		local l_268_7 = l_268_3:name()
		local l_268_8 = "body_collision"
		local l_268_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_268_4(l_268_5, l_268_6, l_268_7, l_268_8, l_268_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreBodyElement
l_0_3 = "set_mover_collision"
l_0_0[l_0_3] = function(l_269_0, l_269_1, l_269_2, l_269_3)
	l_269_3:set_collides_with_mover(l_269_2)
	if l_269_0.SAVE_STATE then
		local l_269_4, l_269_5 = l_269_0:set_cat_state2, l_269_0
		local l_269_6 = l_269_3:unit()
		local l_269_7 = l_269_3:name()
		local l_269_8 = "mover_collision"
		local l_269_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_269_4(l_269_5, l_269_6, l_269_7, l_269_8, l_269_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreBodyElement
l_0_3 = "set_pushed_by_mover"
l_0_0[l_0_3] = function(l_270_0, l_270_1, l_270_2, l_270_3)
	l_270_3:set_pushed_by_mover(l_270_2)
	if l_270_0.SAVE_STATE then
		local l_270_4, l_270_5 = l_270_0:set_cat_state2, l_270_0
		local l_270_6 = l_270_3:unit()
		local l_270_7 = l_270_3:name()
		local l_270_8 = "pushed_by_mover"
		local l_270_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_270_4(l_270_5, l_270_6, l_270_7, l_270_8, l_270_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreBodyElement
l_0_3 = "set_mover"
l_0_0[l_0_3] = function(l_271_0, l_271_1, l_271_2, l_271_3)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_271_2 or l_271_0.VALID_MOVER_MAP[l_271_2] then
		l_271_3:set_mover(l_271_0.VALID_MOVER_MAP[l_271_2])
		if l_271_0.SAVE_STATE then
			local l_271_5, l_271_6 = , l_271_0:set_cat_state2
			local l_271_7 = l_271_0
			local l_271_8 = l_271_3:unit()
			local l_271_9 = l_271_3:name()
			local l_271_10 = "mover"
			l_271_6(l_271_7, l_271_8, l_271_9, l_271_10, {"set_mover", l_271_5})
		end
	do
		else
			local l_271_11 = nil
			l_271_0:print_attribute_error("mover", l_271_2, CoreSequenceManager:get_keys_as_string(l_271_0.VALID_MOVER_MAP, "", true, true), true, l_271_1, nil)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0 = CoreBodyElement
l_0_3 = "interpolate"
l_0_0[l_0_3] = function(l_272_0, l_272_1, l_272_2, l_272_3)
	l_272_2 = tonumber(l_272_2)
	if l_272_2 then
		l_272_3:interpolate(l_272_2)
		if l_272_0.SAVE_STATE then
			local l_272_4, l_272_5 = l_272_0:set_cat_state2, l_272_0
			local l_272_6 = l_272_3:unit()
			local l_272_7 = l_272_3:name()
			local l_272_8 = "interpolate"
			local l_272_9 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			l_272_4(l_272_5, l_272_6, l_272_7, l_272_8, l_272_9)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_272_0:print_attribute_error("interpolate", l_272_2, nil, true, "interpolate", l_272_2)
	end
end

l_0_0 = CoreBodyElement
l_0_3 = function(l_273_0, l_273_1)
	local l_273_5, l_273_6, l_273_7, l_273_8, l_273_9, l_273_13, l_273_14, l_273_15, l_273_16 = nil
	for i_0,i_1 in pairs(l_273_1) do
		for i_0,i_1 in pairs(i_1) do
			l_273_0:body(l_273_10)[i_1[1]](l_273_0:body(l_273_10), i_1[2])
		end
	end
end

l_0_0.load = l_0_3
l_0_0 = CoreConstraintElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreConstraintElement = l_0_0
l_0_0 = CoreConstraintElement
l_0_3 = "constraint"
l_0_0.NAME = l_0_3
l_0_0 = CoreConstraintElement
l_0_3 = function(l_274_0, l_274_1, l_274_2)
	CoreBaseElement.init(l_274_0, l_274_1, l_274_2)
	l_274_0._name = l_274_0:get("name")
	l_274_0._action = l_274_0:get("action")
end

l_0_0.init = l_0_3
l_0_0 = CoreConstraintElement
l_0_3 = function(l_275_0, l_275_1)
	local l_275_2 = l_275_0:run_parsed_func(l_275_1, l_275_0._name)
	do
		local l_275_3 = l_275_0:run_parsed_func(l_275_1, l_275_0._action) or "enable"
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_275_4 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_275_0[l_275_3] then
		l_275_0[l_275_3](l_275_0, l_275_1.dest_unit, l_275_2)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreConstraintElement
l_0_3 = "enable"
l_0_0[l_0_3] = function(l_276_0, l_276_1, l_276_2)
	l_276_1:enable_constraint(l_276_2)
	if l_276_0.SAVE_STATE then
		l_276_0:set_cat_state(l_276_1, l_276_2, "enable_constraint")
	end
end

l_0_0 = CoreConstraintElement
l_0_3 = "disable"
l_0_0[l_0_3] = function(l_277_0, l_277_1, l_277_2)
	l_277_1:disable_constraint(l_277_2)
	if l_277_0.SAVE_STATE then
		l_277_0:set_cat_state(l_277_1, l_277_2, "disable_constraint")
	end
end

l_0_0 = CoreConstraintElement
l_0_3 = "remove"
l_0_0[l_0_3] = function(l_278_0, l_278_1, l_278_2)
	l_278_1:remove_constraint(l_278_2)
	if l_278_0.SAVE_STATE then
		l_278_0:set_cat_state(l_278_1, l_278_2, "remove_constraint")
	end
end

l_0_0 = CoreConstraintElement
l_0_3 = function(l_279_0, l_279_1)
	local l_279_5, l_279_6, l_279_7, l_279_8, l_279_9 = nil
	for i_0,i_1 in pairs(l_279_1) do
		l_279_0[i_1](l_279_0, i_0)
	end
end

l_0_0.load = l_0_3
l_0_0 = CoreDebugElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreDebugElement = l_0_0
l_0_0 = CoreDebugElement
l_0_3 = "debug"
l_0_0.NAME = l_0_3
l_0_0 = CoreDebugElement
l_0_3 = function(l_280_0, l_280_1, l_280_2)
	CoreBaseElement.init(l_280_0, l_280_1, l_280_2)
	l_280_0._text = l_280_0:get("text")
end

l_0_0.init = l_0_3
l_0_0 = CoreDebugElement
l_0_3 = function(l_281_0, l_281_1)
	local l_281_2 = l_281_0:run_parsed_func(l_281_1, l_281_0._text)
	cat_debug("sequence", "[SequenceManager] " .. tostring(l_281_2))
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreDecalMeshElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreDecalMeshElement = l_0_0
l_0_0 = CoreDecalMeshElement
l_0_3 = "decal_mesh"
l_0_0.NAME = l_0_3
l_0_0 = CoreDecalMeshElement
l_0_3 = function(l_282_0, l_282_1, l_282_2)
	CoreBaseElement.init(l_282_0, l_282_1, l_282_2)
	l_282_0._name = l_282_0:get("name")
	l_282_0._enabled = l_282_0:get("enabled")
	l_282_0._material = l_282_0:get("material")
end

l_0_0.init = l_0_3
l_0_0 = CoreDecalMeshElement
l_0_3 = function(l_283_0, l_283_1)
	local l_283_2 = l_283_1.dest_unit:decal_surface()
	if not l_283_2 then
		l_283_0:print_error("The unit didn't have a decal surface.", true, l_283_1)
	else
		local l_283_3 = l_283_0:run_parsed_func(l_283_1, l_283_0._name)
		if not l_283_3 then
			l_283_0:print_attribute_error("name", l_283_3, nil, true, l_283_1)
		end
	elseif l_283_0._enabled then
		local l_283_4 = l_283_0:run_parsed_func(l_283_1, l_283_0._enabled)
		l_283_2:set_mesh_enabled(l_283_3, l_283_4)
	if l_283_0.SAVE_STATE then
		end
		l_283_0:set_cat_state2(l_283_0, l_283_1.dest_unit, l_283_3, "set_mesh_enabled", l_283_4)
	end
	if l_283_0._material then
		local l_283_5 = l_283_0:run_parsed_func(l_283_1, l_283_0._material)
		if l_283_5 then
			l_283_2:set_mesh_material(l_283_3, l_283_5)
		if l_283_0.SAVE_STATE then
			end
			l_283_0:set_cat_state2(l_283_0, l_283_1.dest_unit, l_283_3, "set_mesh_material", l_283_5)
		end
	else
		l_283_0:print_attribute_error("material", l_283_5, nil, true, l_283_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreDecalMeshElement
l_0_3 = function(l_284_0, l_284_1)
	local l_284_6, l_284_7, l_284_8, l_284_9, l_284_13, l_284_14, l_284_15, l_284_16, l_284_17 = nil
	local l_284_2 = l_284_0:decal_surface()
	for i_0,i_1 in pairs(l_284_1) do
		for i_0,i_1 in pairs(i_1) do
			l_284_2[i_0](l_284_2, l_284_10, i_1)
		end
	end
end

l_0_0.load = l_0_3
l_0_0 = CoreEffectElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreEffectElement = l_0_0
l_0_0 = CoreEffectElement
l_0_3 = "effect"
l_0_0.NAME = l_0_3
l_0_0 = CoreEffectElement
l_0_3 = function(l_285_0, l_285_1, l_285_2)
	CoreBaseElement.init(l_285_0, l_285_1, l_285_2)
	l_285_0._name = l_285_0:get("name")
	l_285_0._position = l_285_0:get("position")
	l_285_0._align = l_285_0:get("align")
	l_285_0._velocity = l_285_0:get("velocity")
	l_285_0._parent = l_285_0:get("parent")
	l_285_0._param_list = {}
	for l_285_6 = 1, 5 do
		local l_285_7 = l_285_0:get("param" .. l_285_6)
		if l_285_7 then
			table.insert(l_285_0._param_list, l_285_7)
		else
			do break end
		end
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreEffectElement
l_0_3 = function(l_286_0, l_286_1)
	local l_286_2 = l_286_0:run_parsed_func(l_286_1, l_286_0._name)
	local l_286_3 = l_286_0:run_parsed_func(l_286_1, l_286_0._position)
	local l_286_4 = l_286_0:run_parsed_func(l_286_1, l_286_0._parent)
	if not l_286_2 then
		l_286_0:print_attribute_error("name", l_286_2, nil, true, l_286_1)
	elseif not l_286_3 and not l_286_4 then
		l_286_0:print_attribute_error("position", l_286_3, nil, true, l_286_1)
	else
		if Database:has("effect", l_286_2) then
			if l_286_4 then
				if type(l_286_4) == "string" then
					l_286_4 = l_286_1.dest_unit:get_object(l_286_4)
				elseif l_286_4.type_name ~= "Object3D" then
					l_286_4 = nil
				end
			if not l_286_4 then
				end
				l_286_0:print_attribute_error("parent", l_286_4, nil, true, l_286_1)
			end
			local l_286_5 = {}
			l_286_5.effect = l_286_2
			l_286_5.parent = l_286_4
			l_286_5.position = l_286_3
			if not l_286_0:run_parsed_func(l_286_1, l_286_0._velocity) then
				l_286_5.velocity = Vector3()
			end
			local l_286_6 = l_286_0:run_parsed_func(l_286_1, l_286_0._align)
			if l_286_6 then
				if l_286_6.type_name == "Vector3" then
					l_286_5.normal = l_286_6
				elseif l_286_6.type_name == "Rotation" then
					l_286_5.rotation = l_286_6
				else
					l_286_0:print_attribute_error("align", l_286_6, nil, true, l_286_1)
					return 
				end
			elseif not l_286_4 then
				l_286_5.normal = math.UP
			end
			if not World:effect_manager():has_effect(l_286_2) then
				l_286_0:print_error("The effect \"" .. tostring(l_286_2) .. "\" was not preloaded (type <depends_on effect=\"" .. tostring(l_286_2) .. "\"/> in unit xml) so it won't be played. THIS WILL CRASH SOON SO FIX IT!", true, l_286_1)
			end
		else
			World:effect_manager():spawn(l_286_5)
		end
	elseif not l_286_3 then
		l_286_0:print_attribute_error("position", l_286_3, nil, true, l_286_1)
	else
		l_286_0:print_attribute_error("name", l_286_2, nil, true, l_286_1)
		Application:error("THIS WILL CRASH SOON, SO FIX IT!\n")
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreEffectSpawnerElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreEffectSpawnerElement = l_0_0
l_0_0 = CoreEffectSpawnerElement
l_0_3 = "effect_spawner"
l_0_0.NAME = l_0_3
l_0_0 = CoreEffectSpawnerElement
l_0_3 = function(l_287_0, l_287_1, l_287_2)
	CoreBaseElement.init(l_287_0, l_287_1, l_287_2)
	l_287_0._name = l_287_0:get("name")
	l_287_0._set_function_list = {}
	local l_287_3 = l_287_0:get("enabled", l_287_0.set_enabled)
	if l_287_3 then
		table.insert(l_287_0._set_function_list, l_287_3)
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreEffectSpawnerElement
l_0_3 = function(l_288_0, l_288_1)
	local l_288_7, l_288_8, l_288_9, l_288_10 = nil
	local l_288_2 = l_288_0:run_parsed_func(l_288_1, l_288_0._name)
	if l_288_2 then
		local l_288_3 = l_288_1.dest_unit:effect_spawner(l_288_2)
		if l_288_3 then
			for i_0,i_1 in ipairs(l_288_0._set_function_list) do
				i_1(l_288_1, l_288_3, l_288_2)
			end
		else
			l_288_0:print_error("Effect spawner \"" .. tostring(l_288_2) .. "\" not found.", true, l_288_1)
		end
	else
		l_288_0:print_attribute_error("name", l_288_2, nil, true, l_288_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreEffectSpawnerElement
l_0_3 = "set_enabled"
l_0_0[l_0_3] = function(l_289_0, l_289_1, l_289_2, l_289_3, l_289_4)
	CoreSequenceManager.set_effect_spawner_enabled(l_289_3, l_289_2)
	if l_289_0.SAVE_STATE then
		l_289_0:set_cat_state2(l_289_0, l_289_1.dest_unit, l_289_4, "set_enabled", l_289_2)
	end
end

l_0_0 = CoreEffectSpawnerElement
l_0_3 = function(l_290_0, l_290_1)
	local l_290_5, l_290_6, l_290_7, l_290_8, l_290_9, l_290_14, l_290_15, l_290_16, l_290_17, l_290_18 = nil
	for i_0,i_1 in pairs(l_290_1) do
		if l_290_0:effect_spawner(i_0) then
			for i_0,i_1 in pairs(i_1) do
				local l_290_12 = nil
				if i_0 == "set_enabled" then
					CoreSequenceManager.set_effect_spawner_enabled(l_290_12, i_1)
				end
			end
		end
	end
end

l_0_0.load = l_0_3
l_0_0 = CoreEffectSurfaceElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreEffectSurfaceElement = l_0_0
l_0_0 = CoreEffectSurfaceElement
l_0_3 = "effect_surface"
l_0_0.NAME = l_0_3
l_0_0 = CoreEffectSurfaceElement
l_0_3 = function(l_291_0, l_291_1, l_291_2)
	CoreBaseElement.init(l_291_0, l_291_1, l_291_2)
	l_291_0._set_functions = {}
	l_291_0._name = l_291_0:get("name")
	local l_291_3 = l_291_0:get("active", l_291_0.set_active)
	if l_291_3 then
		table.insert(l_291_0._set_functions, l_291_3)
	end
	local l_291_4 = l_291_0:get("variation", l_291_0.set_variation)
	if l_291_4 then
		table.insert(l_291_0._set_functions, l_291_4)
	end
	local l_291_5 = l_291_0:get("spawnrate", l_291_0.set_spawnrate)
	if l_291_5 then
		table.insert(l_291_0._set_functions, l_291_5)
	end
	local l_291_6 = l_291_0:get("add_spawnrate", l_291_0.add_spawnrate)
	if l_291_6 then
		table.insert(l_291_0._set_functions, l_291_6)
	end
	local l_291_7 = l_291_0:get("far_distance_clip", l_291_0.set_far_distance_clip)
	if l_291_7 then
		table.insert(l_291_0._set_functions, l_291_7)
	end
	local l_291_8 = l_291_0:get("near_distance_clip", l_291_0.set_near_distance_clip)
	if l_291_8 then
		table.insert(l_291_0._set_functions, l_291_8)
	end
	local l_291_9 = l_291_0:get("effect", l_291_0.set_effect)
	if l_291_9 then
		table.insert(l_291_0._set_functions, l_291_9)
	end
	local l_291_10 = l_291_0:get("spawn_dist", l_291_0.set_spawn_dist)
	if l_291_10 then
		table.insert(l_291_0._set_functions, l_291_10)
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreEffectSurfaceElement
l_0_3 = function(l_292_0, l_292_1)
	local l_292_7, l_292_8, l_292_9, l_292_10 = nil
	local l_292_2 = l_292_0:run_parsed_func(l_292_1, l_292_0._name)
	if l_292_2 then
		local l_292_3 = l_292_1.dest_unit:effect_surface(l_292_2)
		if l_292_3 then
			for i_0,i_1 in ipairs(l_292_0._set_functions) do
				i_1(l_292_1, l_292_3, l_292_2)
			end
		else
			l_292_0:print_error("Effect surface \"" .. tostring(l_292_2) .. "\" not found.", true, l_292_1)
		end
	else
		l_292_0:print_attribute_error("name", l_292_2, nil, true, l_292_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreEffectSurfaceElement
l_0_3 = "set_active"
l_0_0[l_0_3] = function(l_293_0, l_293_1, l_293_2, l_293_3, l_293_4)
	l_293_3:set_active(l_293_2)
	if l_293_0.SAVE_STATE then
		l_293_0:set_cat_state2(l_293_0, l_293_1.dest_unit, l_293_4, "set_active", l_293_2)
	end
end

l_0_0 = CoreEffectSurfaceElement
l_0_3 = "set_variation"
l_0_0[l_0_3] = function(l_294_0, l_294_1, l_294_2, l_294_3, l_294_4)
	l_294_3:set_variation(l_294_2)
	if l_294_0.SAVE_STATE then
		l_294_0:set_cat_state2(l_294_0, l_294_1.dest_unit, l_294_4, "set_variation", l_294_2)
	end
end

l_0_0 = CoreEffectSurfaceElement
l_0_3 = "set_spawnrate"
l_0_0[l_0_3] = function(l_295_0, l_295_1, l_295_2, l_295_3, l_295_4)
	l_295_3:set_spawnrate(l_295_2)
	if l_295_0.SAVE_STATE then
		l_295_0:set_cat_state2(l_295_0, l_295_1.dest_unit, l_295_4, "set_spawnrate", l_295_2)
	end
end

l_0_0 = CoreEffectSurfaceElement
l_0_3 = "add_spawnrate"
l_0_0[l_0_3] = function(l_296_0, l_296_1, l_296_2, l_296_3, l_296_4)
	l_296_3:set_spawnrate(l_296_3:spawnrate() + l_296_2)
	if l_296_0.SAVE_STATE then
		l_296_0:set_cat_state2(l_296_0, l_296_1.dest_unit, l_296_4, "set_spawnrate", l_296_3:spawnrate())
	end
end

l_0_0 = CoreEffectSurfaceElement
l_0_3 = "set_far_distance_clip"
l_0_0[l_0_3] = function(l_297_0, l_297_1, l_297_2, l_297_3, l_297_4)
	l_297_3:set_far_distance_clip(l_297_2)
	if l_297_0.SAVE_STATE then
		l_297_0:set_cat_state2(l_297_0, l_297_1.dest_unit, l_297_4, "set_far_distance_clip", l_297_2)
	end
end

l_0_0 = CoreEffectSurfaceElement
l_0_3 = "set_near_distance_clip"
l_0_0[l_0_3] = function(l_298_0, l_298_1, l_298_2, l_298_3, l_298_4)
	l_298_3:set_near_distance_clip(l_298_2)
	if l_298_0.SAVE_STATE then
		l_298_0:set_cat_state2(l_298_0, l_298_1.dest_unit, l_298_4, "set_near_distance_clip", l_298_2)
	end
end

l_0_0 = CoreEffectSurfaceElement
l_0_3 = "set_effect"
l_0_0[l_0_3] = function(l_299_0, l_299_1, l_299_2, l_299_3, l_299_4)
	l_299_3:set_effect(l_299_2)
	if l_299_0.SAVE_STATE then
		l_299_0:set_cat_state2(l_299_0, l_299_1.dest_unit, l_299_4, "set_effect", l_299_2)
	end
end

l_0_0 = CoreEffectSurfaceElement
l_0_3 = "set_spawn_dist"
l_0_0[l_0_3] = function(l_300_0, l_300_1, l_300_2, l_300_3, l_300_4)
	l_300_3:set_spawn_dist(l_300_2)
	if l_300_0.SAVE_STATE then
		l_300_0:set_cat_state2(l_300_0, l_300_1.dest_unit, l_300_4, "set_spawn_dist", l_300_2)
	end
end

l_0_0 = CoreEffectSurfaceElement
l_0_3 = function(l_301_0, l_301_1)
	local l_301_5, l_301_6, l_301_7, l_301_8, l_301_9, l_301_14, l_301_15, l_301_16, l_301_17, l_301_18 = nil
	for i_0,i_1 in pairs(l_301_1) do
		if l_301_0:effect_surface(i_0) then
			for i_0,i_1 in pairs(i_1) do
				local l_301_12 = nil
				l_301_12[i_0](l_301_12, i_1)
			end
		end
	end
end

l_0_0.load = l_0_3
l_0_0 = CoreEnemyKilledElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreEnemyKilledElement = l_0_0
l_0_0 = CoreEnemyKilledElement
l_0_3 = "enemy_killed"
l_0_0.NAME = l_0_3
l_0_0 = CoreEnemyKilledElement
l_0_3 = function(l_302_0, l_302_1)
	local l_302_2 = l_302_1.dest_unit:enemy_data()
	if not l_302_2 then
		l_302_0:print_error("Unable to report enemy kill. Unit \"" .. l_302_1.dest_unit:name() .. "\" doesn't have a \"enemy_data\" extension.", true, l_302_1)
	else
		local l_302_3 = l_302_2.enemy_group
	if l_302_3 then
		end
		l_302_3:unit_killed()
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreFunctionElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreFunctionElement = l_0_0
l_0_0 = CoreFunctionElement
l_0_3 = "function"
l_0_0.NAME = l_0_3
l_0_0 = CoreFunctionElement
l_0_3 = function(l_303_0, l_303_1, l_303_2)
	CoreBaseElement.init(l_303_0, l_303_1, l_303_2)
	l_303_0._obj = l_303_0:get("object")
	l_303_0._extension = l_303_0:get("extension")
	l_303_0._function_name = l_303_0:get("function")
	l_303_0._param1 = l_303_0:get("param1")
	if l_303_0._param1 == nil then
		l_303_0._function = l_303_0.function0
	else
		l_303_0._param2 = l_303_0:get("param2")
		if l_303_0._param2 == nil then
			l_303_0._function = l_303_0.function1
		end
	else
		l_303_0._param3 = l_303_0:get("param3")
		if l_303_0._param3 == nil then
			l_303_0._function = l_303_0.function2
		end
	else
		l_303_0._param4 = l_303_0:get("param4")
		if l_303_0._param4 == nil then
			l_303_0._function = l_303_0.function3
		end
	else
		l_303_0._param5 = l_303_0:get("param5")
		if l_303_0._param5 == nil then
			l_303_0._function = l_303_0.function4
		end
	else
		l_303_0._function = l_303_0.function5
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreFunctionElement
l_0_3 = function(l_304_0, l_304_1)
	local l_304_4 = l_304_0:run_parsed_func(l_304_1, l_304_0._obj)
	local l_304_5 = l_304_0:run_parsed_func(l_304_1, l_304_0._extension)
	if l_304_4 == nil then
		local l_304_2, l_304_3 = l_304_0:run_parsed_func(l_304_1, l_304_0._function_name)
		l_304_3 = alive
		l_304_3 = l_304_3(l_304_4)
		if not l_304_3 then
			return 
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_304_5 and l_304_4[l_304_5] then
		SequenceEnvironment.self = l_304_1
		SequenceEnvironment.element = l_304_0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if not l_304_2 or l_304_4[l_304_2] then
			l_304_0._function(l_304_0, l_304_1, l_304_4, l_304_4[l_304_2])
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_304_0:print_attribute_error("function", l_304_2, nil, true, l_304_1, nil)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreFunctionElement
l_0_3 = "function0"
l_0_0[l_0_3] = function(l_305_0, l_305_1, l_305_2, l_305_3)
	l_305_3(l_305_2)
end

l_0_0 = CoreFunctionElement
l_0_3 = "function1"
l_0_0[l_0_3] = function(l_306_0, l_306_1, l_306_2, l_306_3)
	local l_306_4 = l_306_0:run_parsed_func(l_306_1, l_306_0._param1)
	l_306_3(l_306_2, l_306_4)
end

l_0_0 = CoreFunctionElement
l_0_3 = "function2"
l_0_0[l_0_3] = function(l_307_0, l_307_1, l_307_2, l_307_3)
	local l_307_4 = l_307_0:run_parsed_func(l_307_1, l_307_0._param1)
	local l_307_5 = l_307_0:run_parsed_func(l_307_1, l_307_0._param2)
	l_307_3(l_307_2, l_307_4, l_307_5)
end

l_0_0 = CoreFunctionElement
l_0_3 = "function3"
l_0_0[l_0_3] = function(l_308_0, l_308_1, l_308_2, l_308_3)
	local l_308_4 = l_308_0:run_parsed_func(l_308_1, l_308_0._param1)
	local l_308_5 = l_308_0:run_parsed_func(l_308_1, l_308_0._param2)
	local l_308_6 = l_308_0:run_parsed_func(l_308_1, l_308_0._param3)
	l_308_3(l_308_2, l_308_4, l_308_5, l_308_6)
end

l_0_0 = CoreFunctionElement
l_0_3 = "function4"
l_0_0[l_0_3] = function(l_309_0, l_309_1, l_309_2, l_309_3)
	local l_309_4 = l_309_0:run_parsed_func(l_309_1, l_309_0._param1)
	local l_309_5 = l_309_0:run_parsed_func(l_309_1, l_309_0._param2)
	local l_309_6 = l_309_0:run_parsed_func(l_309_1, l_309_0._param3)
	local l_309_7 = l_309_0:run_parsed_func(l_309_1, l_309_0._param4)
	l_309_3(l_309_2, l_309_4, l_309_5, l_309_6, l_309_7)
end

l_0_0 = CoreFunctionElement
l_0_3 = "function5"
l_0_0[l_0_3] = function(l_310_0, l_310_1, l_310_2, l_310_3)
	local l_310_4 = l_310_0:run_parsed_func(l_310_1, l_310_0._param1)
	local l_310_5 = l_310_0:run_parsed_func(l_310_1, l_310_0._param2)
	local l_310_6 = l_310_0:run_parsed_func(l_310_1, l_310_0._param3)
	local l_310_7 = l_310_0:run_parsed_func(l_310_1, l_310_0._param4)
	local l_310_8 = l_310_0:run_parsed_func(l_310_1, l_310_0._param5)
	l_310_3(l_310_2, l_310_4, l_310_5, l_310_6, l_310_7, l_310_8)
end

l_0_0 = CoreGraphicGroupElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreGraphicGroupElement = l_0_0
l_0_0 = CoreGraphicGroupElement
l_0_3 = "graphic_group"
l_0_0.NAME = l_0_3
l_0_0 = CoreGraphicGroupElement
l_0_3 = function(l_311_0, l_311_1, l_311_2)
	CoreBaseElement.init(l_311_0, l_311_1, l_311_2)
	l_311_0._name = l_311_0:get("name")
	l_311_0._activate = l_311_0:get("activate")
	l_311_0._visibility = l_311_0:get("visibility")
end

l_0_0.init = l_0_3
l_0_0 = CoreGraphicGroupElement
l_0_3 = function(l_312_0, l_312_1)
	local l_312_2 = l_312_0:run_parsed_func(l_312_1, l_312_0._name)
	local l_312_6 = l_312_0:run_parsed_func(l_312_1, l_312_0._activate) ~= false
	if l_312_6 then
		l_312_1.dest_unit:activate_graphic_group(l_312_2)
	if l_312_0.SAVE_STATE then
		end
		local l_312_7, l_312_8 = l_312_0:run_parsed_func(l_312_1, l_312_0._visibility), l_312_0:set_cat_state
		local l_312_9 = l_312_0
		local l_312_10 = l_312_1.dest_unit
		local l_312_11 = l_312_2
		l_312_8(l_312_9, l_312_10, l_312_11, {"activate_graphic_group"})
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_312_7 ~= nil then
		l_312_1.dest_unit:set_visibility(l_312_2, l_312_7)
	if l_312_0.SAVE_STATE then
		end
		local l_312_12, l_312_13 = , l_312_0:set_cat_state
		local l_312_14 = l_312_0
		local l_312_15 = l_312_1.dest_unit
		local l_312_16 = l_312_2
		l_312_13(l_312_14, l_312_15, l_312_16, {"set_visibility", l_312_12})
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreGraphicGroupElement
l_0_3 = function(l_313_0, l_313_1)
	local l_313_5, l_313_6, l_313_7, l_313_8, l_313_9, l_313_10, l_313_11 = nil
	for i_0,i_1 in pairs(l_313_1) do
		l_313_0[i_1[1]](l_313_0, i_0, i_1[2])
	end
end

l_0_0.load = l_0_3
l_0_0 = CoreLightElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreLightElement = l_0_0
l_0_0 = CoreLightElement
l_0_3 = "light"
l_0_0.NAME = l_0_3
l_0_0 = CoreLightElement
l_0_3 = function(l_314_0, l_314_1, l_314_2)
	CoreBaseElement.init(l_314_0, l_314_1, l_314_2)
	l_314_0._name = l_314_0:get("name")
	l_314_0._set_functions = {}
	local l_314_3 = l_314_0:get("enabled", l_314_0.set_enabled)
	if l_314_3 then
		table.insert(l_314_0._set_functions, l_314_3)
	end
	local l_314_4 = l_314_0:get("multiplier", l_314_0.set_multiplier)
	if l_314_4 then
		table.insert(l_314_0._set_functions, l_314_4)
	end
	local l_314_5 = l_314_0:get("color", l_314_0.set_color)
	if l_314_5 then
		table.insert(l_314_0._set_functions, l_314_5)
	end
	local l_314_6 = l_314_0:get("far_range", l_314_0.set_far_range)
	if l_314_6 then
		table.insert(l_314_0._set_functions, l_314_6)
	end
	local l_314_7 = l_314_0:get("spot_angle_end", l_314_0.set_spot_angle_end)
	if l_314_7 then
		table.insert(l_314_0._set_functions, l_314_7)
	end
	local l_314_8 = l_314_0:get("spot_angle_start", l_314_0.set_spot_angle_start)
	if l_314_8 then
		table.insert(l_314_0._set_functions, l_314_8)
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreLightElement
l_0_3 = function(l_315_0, l_315_1)
	local l_315_7, l_315_8, l_315_9, l_315_10 = nil
	local l_315_2 = l_315_0:run_parsed_func(l_315_1, l_315_0._name)
	local l_315_3 = l_315_1.dest_unit:get_object(l_315_2)
	if l_315_3 and l_315_3.set_multiplier then
		for i_0,i_1 in ipairs(l_315_0._set_functions) do
			i_1(l_315_1, l_315_3, l_315_2)
		end
	else
		l_315_0:print_attribute_error("name", l_315_2, nil, true, l_315_1, nil)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreLightElement
l_0_3 = "set_enabled"
l_0_0[l_0_3] = function(l_316_0, l_316_1, l_316_2, l_316_3, l_316_4)
	l_316_3:set_enable(l_316_2)
	if l_316_0.SAVE_STATE then
		local l_316_5, l_316_6 = l_316_0:set_cat_state, l_316_0
		local l_316_7 = l_316_1.dest_unit
		local l_316_8 = l_316_4
		local l_316_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_316_5(l_316_6, l_316_7, l_316_8, l_316_9)
	end
	local l_316_13, l_316_14 = ipairs, l_316_3:children()
	for i_0,i_1 in l_316_13 do
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		"set_enable"(l_316_2, l_316_2)
		if l_316_0.SAVE_STATE then
			local l_316_15, l_316_16 = l_316_0:set_cat_state, l_316_0
			local l_316_17 = l_316_1.dest_unit
			local l_316_18 = l_316_12:name()
			local l_316_19 = {}
			 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

			l_316_15(l_316_16, l_316_17, l_316_18, l_316_19)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreLightElement
l_0_3 = "set_multiplier"
l_0_0[l_0_3] = function(l_317_0, l_317_1, l_317_2, l_317_3, l_317_4)
	l_317_3:set_multiplier(l_317_2)
	if l_317_0.SAVE_STATE then
		local l_317_5, l_317_6 = l_317_0:set_cat_state, l_317_0
		local l_317_7 = l_317_1.dest_unit
		local l_317_8 = l_317_4
		local l_317_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_317_5(l_317_6, l_317_7, l_317_8, l_317_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreLightElement
l_0_3 = "set_color"
l_0_0[l_0_3] = function(l_318_0, l_318_1, l_318_2, l_318_3, l_318_4)
	l_318_3:set_color(l_318_2)
	if l_318_0.SAVE_STATE then
		local l_318_5, l_318_6 = l_318_0:set_cat_state, l_318_0
		local l_318_7 = l_318_1.dest_unit
		local l_318_8 = l_318_4
		local l_318_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_318_5(l_318_6, l_318_7, l_318_8, l_318_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreLightElement
l_0_3 = "set_far_range"
l_0_0[l_0_3] = function(l_319_0, l_319_1, l_319_2, l_319_3, l_319_4)
	l_319_3:set_far_range(l_319_2)
	if l_319_0.SAVE_STATE then
		local l_319_5, l_319_6 = l_319_0:set_cat_state, l_319_0
		local l_319_7 = l_319_1.dest_unit
		local l_319_8 = l_319_4
		local l_319_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_319_5(l_319_6, l_319_7, l_319_8, l_319_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreLightElement
l_0_3 = "set_spot_angle_start"
l_0_0[l_0_3] = function(l_320_0, l_320_1, l_320_2, l_320_3, l_320_4)
	l_320_3:set_spot_angle_start(l_320_2)
	if l_320_0.SAVE_STATE then
		local l_320_5, l_320_6 = l_320_0:set_cat_state, l_320_0
		local l_320_7 = l_320_1.dest_unit
		local l_320_8 = l_320_4
		local l_320_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_320_5(l_320_6, l_320_7, l_320_8, l_320_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreLightElement
l_0_3 = "set_spot_angle_end"
l_0_0[l_0_3] = function(l_321_0, l_321_1, l_321_2, l_321_3, l_321_4)
	l_321_3:set_spot_angle_end(l_321_2)
	if l_321_0.SAVE_STATE then
		local l_321_5, l_321_6 = l_321_0:set_cat_state, l_321_0
		local l_321_7 = l_321_1.dest_unit
		local l_321_8 = l_321_4
		local l_321_9 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_321_5(l_321_6, l_321_7, l_321_8, l_321_9)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0 = CoreLightElement
l_0_3 = function(l_322_0, l_322_1)
	local l_322_5, l_322_6, l_322_7, l_322_8, l_322_9 = nil
	for i_0,i_1 in pairs(l_322_1) do
		l_322_0:get_object(i_0)[i_1[1]](l_322_0:get_object(i_0), i_1[2])
	end
end

l_0_0.load = l_0_3
l_0_0 = CoreMaterialConfigElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreMaterialConfigElement = l_0_0
l_0_0 = CoreMaterialConfigElement
l_0_3 = "material_config"
l_0_0.NAME = l_0_3
l_0_0 = CoreMaterialConfigElement
l_0_3 = function(l_323_0, l_323_1, l_323_2)
	CoreBaseElement.init(l_323_0, l_323_1, l_323_2)
	l_323_0._name = l_323_0:get("name")
end

l_0_0.init = l_0_3
l_0_0 = CoreMaterialConfigElement
l_0_3 = function(l_324_0, l_324_1)
	local l_324_2 = l_324_0:run_parsed_func(l_324_1, l_324_0._name)
	if not l_324_2 then
		l_324_0:print_attribute_error("name", l_324_2, nil, true, l_324_1)
	else
		l_324_1.dest_unit:set_material_config(l_324_2, true)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreMaterialElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreMaterialElement = l_0_0
l_0_0 = CoreMaterialElement
l_0_3 = "material"
l_0_0.NAME = l_0_3
l_0_0 = CoreMaterialElement
l_0_3 = "MATERIAL_ATTRIBUTE_MAP"
if not CoreMaterialElement.MATERIAL_ATTRIBUTE_MAP then
	local l_0_13, l_0_15 = {}
	l_0_15 = "name"
	local l_0_14 = nil
	l_0_14 = true
	l_0_13[l_0_15] = l_0_14
	l_0_15 = "diffuse_color"
	l_0_14 = true
	l_0_13[l_0_15] = l_0_14
	l_0_15 = "diffuse_color_alpha"
	l_0_14 = true
	l_0_13[l_0_15] = l_0_14
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_13
l_0_0 = CoreMaterialElement
l_0_3 = "FUNC_MAP"
if not CoreMaterialElement.FUNC_MAP then
	local l_0_16, l_0_18 = {}
	l_0_18 = "glossiness"
	local l_0_17 = nil
	l_0_17 = "set_glossiness"
	l_0_16[l_0_18] = l_0_17
	l_0_18 = "render_template"
	l_0_17 = "set_render_template"
	l_0_16[l_0_18] = l_0_17
	l_0_18 = "time"
	l_0_17 = "set_time"
	l_0_16[l_0_18] = l_0_17
	l_0_18 = "state"
	l_0_17 = "set_material_state"
	l_0_16[l_0_18] = l_0_17
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_16
l_0_0 = CoreMaterialElement
l_0_3 = "TIMER_STATE_MAP"
if not CoreMaterialElement.TIMER_STATE_MAP then
	local l_0_19, l_0_21 = {}
	l_0_21 = "play"
	local l_0_20 = nil
	l_0_20 = true
	l_0_19[l_0_21] = l_0_20
	l_0_21 = "pause"
	l_0_20 = true
	l_0_19[l_0_21] = l_0_20
	l_0_21 = "stop"
	l_0_20 = true
	l_0_19[l_0_21] = l_0_20
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_19
l_0_0 = CoreMaterialElement
l_0_3 = function(l_325_0, l_325_1, l_325_2)
	local l_325_7 = nil
	local l_325_6 = CoreBaseElement.init
	l_325_6(l_325_0, l_325_1, l_325_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_325_0._name = l_325_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_325_0._diffuse_color = l_325_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_325_0._diffuse_color_alpha = l_325_6
	l_325_0._set_func_list, l_325_6 = l_325_6, {}
	l_325_6 = pairs
	l_325_6 = l_325_6(l_325_0._parameters)
	for i_0,i_1 in l_325_6 do
		local l_325_9 = l_325_0.FUNC_MAP[l_325_5]
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_325_9 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_325_0.BASE_ATTRIBUTE_MAP[l_325_5] or l_325_0.MATERIAL_ATTRIBUTE_MAP[l_325_5] or nil then
			l_325_0._set_func_list[l_325_5] = nil
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_3
l_0_0 = CoreMaterialElement
l_0_3 = function(l_326_0, l_326_1)
	local l_326_2 = l_326_0:run_parsed_func(l_326_1, l_326_0._name)
	if not l_326_2 then
		local l_326_7, l_326_9, l_326_10 = l_326_0:print_attribute_error, l_326_0, "name"
		local l_326_8, l_326_11 = l_326_2, nil
		l_326_7(l_326_9, l_326_10, l_326_8, l_326_11, true, l_326_1)
	else
		local l_326_3 = l_326_1.dest_unit:material(l_326_2)
		if l_326_3 then
			for i_0,i_1 in pairs(l_326_0._set_func_list) do
				i_1(l_326_1, l_326_3, i_0)
			end
		if l_326_0:run_parsed_func(l_326_1, l_326_0._diffuse_color) or l_326_0:run_parsed_func(l_326_1, l_326_0._diffuse_color_alpha) then
			end
			local l_326_12 = l_326_3
			do
				if l_326_0:run_parsed_func(l_326_1, l_326_0._diffuse_color) or not l_326_0:run_parsed_func(l_326_1, l_326_0._diffuse_color_alpha) then
					l_326_3:set_diffuse_color(l_326_3:diffuse_color(), l_326_3:diffuse_color_alpha())
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
	else
		end
	end
	l_326_0:print_error("Invalid material name \"" .. tostring(l_326_2) .. "\".", true, l_326_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreMaterialElement
l_0_3 = "set_glossiness"
l_0_0[l_0_3] = function(l_327_0, l_327_1, l_327_2, l_327_3)
	l_327_3:set_glossiness(l_327_2)
end

l_0_0 = CoreMaterialElement
l_0_3 = "set_render_template"
l_0_0[l_0_3] = function(l_328_0, l_328_1, l_328_2, l_328_3)
	l_328_3:set_render_template(l_328_2)
end

l_0_0 = CoreMaterialElement
l_0_3 = "set_time"
l_0_0[l_0_3] = function(l_329_0, l_329_1, l_329_2, l_329_3)
	l_329_3:set_render_template(l_329_2)
end

l_0_0 = CoreMaterialElement
l_0_3 = "set_variable"
l_0_0[l_0_3] = function(l_330_0, l_330_1, l_330_2, l_330_3, l_330_4)
	l_330_3:set_variable(l_330_4, l_330_2)
end

l_0_0 = CoreMaterialElement
l_0_3 = "set_material_state"
l_0_0[l_0_3] = function(l_331_0, l_331_1, l_331_2, l_331_3)
	if l_331_2 and l_331_0.TIMER_STATE_MAP[l_331_2] then
		l_331_3[l_331_2](l_331_3)
	else
		local l_331_4 = CoreSequenceManager:get_keys_as_string(l_331_0.TIMER_STATE_MAP, "", true)
		l_331_0:print_attribute_error("state", l_331_2, l_331_4, true, l_331_1, nil)
	end
end

l_0_0 = CoreMorphExpressionElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreMorphExpressionElement = l_0_0
l_0_0 = CoreMorphExpressionElement
l_0_3 = "morph_expression"
l_0_0.NAME = l_0_3
l_0_0 = CoreMorphExpressionElement
l_0_3 = function(l_332_0, l_332_1, l_332_2)
	CoreBaseElement.init(l_332_0, l_332_1, l_332_2)
	l_332_0._model = l_332_0:get("model")
	l_332_0._parameters = {}
	for l_332_6 = 1, 3 do
		local l_332_7 = l_332_0:get("expression" .. l_332_6)
		local l_332_8 = l_332_0:get("weight" .. l_332_6)
		if l_332_7 and l_332_8 then
			table.insert(l_332_0._parameters, l_332_7)
			table.insert(l_332_0._parameters, l_332_8)
		end
	end
	if #l_332_0._parameters == 0 then
		l_332_0:print_error("No expressions or weights defined.", false, nil)
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreMorphExpressionElement
l_0_3 = function(l_333_0, l_333_1)
	local l_333_2 = l_333_0:run_parsed_func(l_333_1, l_333_0._model)
	if l_333_2 then
		local l_333_3 = l_333_0:run_parsed_func_list(l_333_1, l_333_0._parameters)
		l_333_1.dest_unit:set_morph_target_expressions(l_333_2, unpack(l_333_3))
	else
		l_333_0:print_attribute_error("model", l_333_2, nil, true, l_333_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreMorphExpressionMovieElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreMorphExpressionMovieElement = l_0_0
l_0_0 = CoreMorphExpressionMovieElement
l_0_3 = "morph_expression_movie"
l_0_0.NAME = l_0_3
l_0_0 = CoreMorphExpressionMovieElement
l_0_3 = function(l_334_0, l_334_1, l_334_2)
	CoreBaseElement.init(l_334_0, l_334_1, l_334_2)
	l_334_0._model = l_334_0:get("model")
	l_334_0._movie = l_334_0:get("movie")
	l_334_0._loop = l_334_0:get("loop")
end

l_0_0.init = l_0_3
l_0_0 = CoreMorphExpressionMovieElement
l_0_3 = function(l_335_0, l_335_1)
	local l_335_2 = l_335_0:run_parsed_func(l_335_1, l_335_0._model)
	local l_335_3 = l_335_0:run_parsed_func(l_335_1, l_335_0._movie)
	if not l_335_2 then
		l_335_0:print_attribute_error("model", l_335_2, nil, true, l_335_1)
	elseif not l_335_3 then
		l_335_0:print_attribute_error("movie", l_335_3, nil, true, l_335_1)
	else
		local l_335_4 = l_335_0:run_parsed_func(l_335_1, l_335_0._loop)
		managers.expression:play(l_335_1.dest_unit, l_335_2, l_335_3, l_335_4)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreObjectElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreObjectElement = l_0_0
l_0_0 = CoreObjectElement
l_0_0.NAME = "object"
l_0_0 = CoreObjectElement
l_0_3 = function(l_336_0, l_336_1, l_336_2)
	CoreBaseElement.init(l_336_0, l_336_1, l_336_2)
	l_336_0._set_function_list = {}
	l_336_0._name = l_336_0:get("name")
	local l_336_3 = l_336_0:get("visible", l_336_0.set_visibility)
	if l_336_3 then
		table.insert(l_336_0._set_function_list, l_336_3)
	end
	local l_336_4 = l_336_0:get("rotation", l_336_0.set_rotation)
	if l_336_4 then
		table.insert(l_336_0._set_function_list, l_336_4)
	end
	local l_336_5 = l_336_0:get("position", l_336_0.set_position)
	if l_336_5 then
		table.insert(l_336_0._set_function_list, l_336_5)
	end
	l_336_0._local_scope = l_336_0:get("local_scope")
end

l_0_0.init = l_0_3
l_0_0 = CoreObjectElement
l_0_3 = function(l_337_0, l_337_1)
	local l_337_8, l_337_9, l_337_10, l_337_11 = nil
	local l_337_2 = l_337_0:run_parsed_func(l_337_1, l_337_0._name)
	if l_337_2 then
		local l_337_3 = l_337_1.dest_unit:get_objects(l_337_2)
		local l_337_4 = l_337_0:run_parsed_func(l_337_1, l_337_0._local_scope)
		for i_0,i_1 in ipairs(l_337_0._set_function_list) do
			i_1(l_337_1, l_337_3, l_337_4)
		end
		l_337_1.dest_unit:set_moving()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_337_3, l_337_4 = l_337_0:print_attribute_error, l_337_0
		l_337_3(l_337_4, "name", l_337_2, nil, true, l_337_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreObjectElement
l_0_3 = "set_visibility"
l_0_0[l_0_3] = function(l_338_0, l_338_1, l_338_2, l_338_3, l_338_4)
	l_338_0:set_object(l_338_1.dest_unit, l_338_3, "set_visibility", l_338_2)
end

l_0_0 = CoreObjectElement
l_0_3 = "set_position"
l_0_0[l_0_3] = function(l_339_0, l_339_1, l_339_2, l_339_3, l_339_4)
	if l_339_4 then
		local l_339_5, l_339_6, l_339_7 = "set_local_position"
	else
		l_339_0:set_object(l_339_1.dest_unit, l_339_3, "set_position", l_339_2)
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 6 
end

l_0_0 = CoreObjectElement
l_0_3 = "set_rotation"
l_0_0[l_0_3] = function(l_340_0, l_340_1, l_340_2, l_340_3, l_340_4)
	if l_340_4 then
		local l_340_5, l_340_6, l_340_7 = "set_local_rotation"
	else
		l_340_0:set_object(l_340_1.dest_unit, l_340_3, "set_rotation", l_340_2)
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 6 
end

l_0_0 = CoreObjectElement
l_0_3 = "set_object"
l_0_0[l_0_3] = function(l_341_0, l_341_1, l_341_2, l_341_3, l_341_4)
	local l_341_8, l_341_9, l_341_10, l_341_11, l_341_12, l_341_13, l_341_14, l_341_15, l_341_16, l_341_17 = nil
	for i_0,i_1 in ipairs(l_341_2) do
		i_1[l_341_3](i_1, l_341_4)
		if l_341_0.SAVE_STATE then
			l_341_0:set_cat_state2(l_341_0, l_341_1, i_1:name(), l_341_3, l_341_4)
		end
	end
end

l_0_0 = CoreObjectElement
l_0_3 = function(l_342_0, l_342_1)
	local l_342_5, l_342_6, l_342_7, l_342_8, l_342_9, l_342_13, l_342_14, l_342_15 = nil
	for i_0,i_1 in pairs(l_342_1) do
		for i_0,i_1 in pairs(i_1) do
			l_342_0:get_object(l_342_10)[i_0](l_342_0:get_object(l_342_10), i_1)
		end
	end
end

l_0_0.load = l_0_3
l_0_0 = CorePhantomElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CorePhantomElement = l_0_0
l_0_0 = CorePhantomElement
l_0_3 = "phantom"
l_0_0.NAME = l_0_3
l_0_0 = CorePhantomElement
l_0_3 = function(l_343_0, l_343_1, l_343_2)
	CoreBaseElement.init(l_343_0, l_343_1, l_343_2)
	l_343_0._name = l_343_0:get("name")
	l_343_0._enabled = l_343_0:get("enabled")
end

l_0_0.init = l_0_3
l_0_0 = CorePhantomElement
l_0_3 = function(l_344_0, l_344_1)
	local l_344_2 = l_344_0:run_parsed_func(l_344_1, l_344_0._name)
	local l_344_3 = l_344_1.dest_unit:phantom(l_344_2)
	if l_344_3 then
		local l_344_4 = l_344_0:run_parsed_func(l_344_1, l_344_0._enabled)
		l_344_3:set_enabled(l_344_4)
		if l_344_0.SAVE_STATE then
			l_344_0:set_cat_state(l_344_1.dest_unit, l_344_2, l_344_4)
		end
	else
		l_344_0:print_attribute_error("name", l_344_2, nil, true, l_344_1, nil)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CorePhantomElement
l_0_3 = function(l_345_0, l_345_1)
	local l_345_5, l_345_6, l_345_7 = nil
	for i_0,i_1 in pairs(l_345_1) do
		l_345_0:phantom(i_0):set_enabled(i_1)
	end
end

l_0_0.load = l_0_3
l_0_0 = CorePhysicEffectElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CorePhysicEffectElement = l_0_0
l_0_0 = CorePhysicEffectElement
l_0_3 = "physic_effect"
l_0_0.NAME = l_0_3
l_0_0 = CorePhysicEffectElement
l_0_3 = function(l_346_0, l_346_1, l_346_2)
	CoreBaseElement.init(l_346_0, l_346_1, l_346_2)
	l_346_0._name = l_346_0:get("name")
	l_346_0._target = l_346_0:get("target")
	l_346_0._store_id_var = l_346_0:get("store_id_var")
	l_346_0._param_list = {}
	for l_346_6 = 1, 5 do
		l_346_0._param_list[l_346_6] = l_346_0:get("param" .. l_346_6)
		if not l_346_0._param_list[l_346_6] then
			do break end
		end
	end
end

l_0_0.init = l_0_3
l_0_0 = CorePhysicEffectElement
l_0_3 = function(l_347_0, l_347_1)
	local l_347_2 = l_347_0:run_parsed_func(l_347_1, l_347_0._name)
	local l_347_3 = l_347_0:run_parsed_func(l_347_1, l_347_0._target)
	local l_347_4 = l_347_0:run_parsed_func_list(l_347_1, l_347_0._param_list)
	do
		local l_347_5 = l_347_0:run_parsed_func(l_347_1, l_347_0._store_id_var) or "last_physic_effect_id"
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_347_1.vars[l_347_5] = World:play_physic_effect(l_347_2, l_347_3, unpack(l_347_4))
end

l_0_0.activate_callback = l_0_3
l_0_0 = CorePostEffectElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CorePostEffectElement = l_0_0
l_0_0 = CorePostEffectElement
l_0_3 = "post_effect"
l_0_0.NAME = l_0_3
l_0_0 = CorePostEffectElement
l_0_3 = function(l_348_0, l_348_1, l_348_2)
	CoreBaseElement.init(l_348_0, l_348_1, l_348_2)
	l_348_0._name = l_348_0:get("name")
end

l_0_0.init = l_0_3
l_0_0 = CorePostEffectElement
l_0_3 = function(l_349_0, l_349_1)
	local l_349_2 = l_349_0:run_parsed_func(l_349_1, l_349_0._name)
	managers.post_effect:modify_current(l_349_2)
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreProjectDecalElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreProjectDecalElement = l_0_0
l_0_0 = CoreProjectDecalElement
l_0_3 = "project_decal"
l_0_0.NAME = l_0_3
l_0_0 = CoreProjectDecalElement
l_0_3 = function(l_350_0, l_350_1, l_350_2)
	CoreBaseElement.init(l_350_0, l_350_1, l_350_2)
	l_350_0._name = l_350_0:get("name")
	l_350_0._position = l_350_0:get("position")
	l_350_0._direction = l_350_0:get("direction")
	l_350_0._decal_x = l_350_0:get("decal_x")
	l_350_0._normal = l_350_0:get("normal")
	l_350_0._slotmask = l_350_0:get("slotmask")
	l_350_0._ray_distance = l_350_0:get("ray_distance")
	l_350_0._play_effect = l_350_0:get("play_effect")
	l_350_0._ignore_unit = l_350_0:get("ignore_unit")
end

l_0_0.init = l_0_3
l_0_0 = CoreProjectDecalElement
l_0_3 = function(l_351_0, l_351_1)
	local l_351_2 = l_351_0:run_parsed_func(l_351_1, l_351_0._name)
	local l_351_3 = l_351_0:run_parsed_func(l_351_1, l_351_0._position)
	local l_351_4 = l_351_0:run_parsed_func(l_351_1, l_351_0._direction)
	if l_351_0._slotmask then
		local l_351_5, l_351_6, l_351_7, l_351_8, l_351_9, l_351_10, l_351_12 = managers.slot:get_mask(l_351_0:run_parsed_func(l_351_1, l_351_0._slotmask))
	end
	if not l_351_2 then
		l_351_0:print_attribute_error("name", l_351_2, nil, true, l_351_1)
	elseif not l_351_3 then
		l_351_0:print_attribute_error("position", l_351_3, nil, true, l_351_1)
	elseif not l_351_4 then
		l_351_0:print_attribute_error("direction", l_351_4, nil, true, l_351_1)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif not l_351_5 then
		local l_351_11 = nil
		l_351_0:print_attribute_error("slotmask", l_351_11, CoreSequenceManager:get_keys_as_string(managers.slot:get_mask_map(), "", true, false), true, l_351_1)
	else
		l_351_4 = l_351_4:normalized()
		local l_351_13 = nil
		local l_351_14 = l_351_0:run_parsed_func(l_351_1, l_351_0._ray_distance)
		local l_351_15 = l_351_0:run_parsed_func(l_351_1, l_351_0._normal)
		do
			if nil or not alive(l_351_0:run_parsed_func(l_351_1, l_351_0._ignore_unit)) and not l_351_14 or World:raycast("ray", l_351_3, l_351_3 + l_351_4 * l_351_14, "slot_mask", l_351_13) then
				l_351_3 = not alive(l_351_0:run_parsed_func(l_351_1, l_351_0._ignore_unit)) and not l_351_14 or World:raycast("ray", l_351_3, l_351_3 + l_351_4 * l_351_14, "slot_mask", l_351_13).position
				if not l_351_15 then
					l_351_15 = not alive(l_351_0:run_parsed_func(l_351_1, l_351_0._ignore_unit)) and not l_351_14 or World:raycast("ray", l_351_3, l_351_3 + l_351_4 * l_351_14, "slot_mask", l_351_13).normal
				else
					return 
				end
			end
			local l_351_17 = nil
			table.insert({}, l_351_0:run_parsed_func(l_351_1, l_351_0._decal_x))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			table.insert({}, l_351_17)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			table.insert({}, nil)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			table.insert({}, l_351_13)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_351_18 = nil
		if #World:project_decal(l_351_2, l_351_3, l_351_4, unpack({})) > 0 then
			end
		if l_351_0:run_parsed_func(l_351_1, l_351_0._play_effect) then
			end
			local l_351_19, l_351_20 = nil
			do
				local l_351_21 = World:effect_manager():spawn
				l_351_21(World:effect_manager(), {effect = l_351_20, position = l_351_3, normal = l_351_17})
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 114 
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreRemoveStartTimeElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreRemoveStartTimeElement = l_0_0
l_0_0 = CoreRemoveStartTimeElement
l_0_3 = "remove_start_time"
l_0_0.NAME = l_0_3
l_0_0 = CoreRemoveStartTimeElement
l_0_3 = function(l_352_0, l_352_1, l_352_2)
	CoreBaseElement.init(l_352_0, l_352_1, l_352_2)
	l_352_0._id = l_352_0:get("id")
end

l_0_0.init = l_0_3
l_0_0 = CoreRemoveStartTimeElement
l_0_3 = function(l_353_0, l_353_1)
	local l_353_2 = l_353_0:run_parsed_func(l_353_1, l_353_0._id)
	if l_353_2 then
		managers.sequence:remove_time_callback(l_353_2)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreRunSequenceElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreRunSequenceElement = l_0_0
l_0_0 = CoreRunSequenceElement
l_0_3 = "RUN_SEQUENCE_ATTRIBUTE_MAP"
if not CoreRunSequenceElement.RUN_SEQUENCE_ATTRIBUTE_MAP then
	local l_0_22, l_0_24 = {}
	l_0_24 = "name"
	local l_0_23 = nil
	l_0_23 = true
	l_0_22[l_0_24] = l_0_23
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_22
l_0_0 = CoreRunSequenceElement
l_0_0.NAME = "run_sequence"
l_0_0 = CoreRunSequenceElement
l_0_3 = function(l_354_0, l_354_1, l_354_2)
	local l_354_7 = nil
	local l_354_6 = CoreBaseElement.init
	l_354_6(l_354_0, l_354_1, l_354_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_354_0._name = l_354_6
	l_354_0._params, l_354_6 = l_354_6, {}
	l_354_6 = pairs
	l_354_6 = l_354_6(l_354_0._parameters)
	for i_0,i_1 in l_354_6 do
		if not l_354_0.BASE_ATTRIBUTE_MAP[l_354_5] and not l_354_0.RUN_SEQUENCE_ATTRIBUTE_MAP[l_354_5] then
			l_354_0._params[l_354_5] = l_354_0:get(l_354_5)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_3
l_0_0 = CoreRunSequenceElement
l_0_3 = function(l_355_0, l_355_1)
	local l_355_8, l_355_9, l_355_10, l_355_11, l_355_12 = nil
	local l_355_2 = l_355_0:run_parsed_func(l_355_1, l_355_0._name)
	if l_355_2 and l_355_2 ~= "" then
		local l_355_3 = l_355_0._unit_element:get_sequence_element(l_355_2)
		if l_355_3 then
			local l_355_4 = clone(l_355_1.params)
			for i_0,i_1 in pairs(l_355_0._params) do
				if not l_355_1.__run_params[i_0] then
					l_355_1.params[i_0] = l_355_0:run_parsed_func(l_355_1, i_1)
				end
			end
			l_355_3:activate(l_355_1)
			l_355_1.params = l_355_4
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	else
		l_355_4 = CoreSequenceManager
		 -- DECOMPILER ERROR: Overwrote pending register.

		do
			local l_355_13 = nil
			l_355_0:print_attribute_error(l_355_13, l_355_2, l_355_4, true, l_355_1, nil)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreRunSpawnSystemSequenceElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreRunSpawnSystemSequenceElement = l_0_0
l_0_0 = CoreRunSpawnSystemSequenceElement
l_0_3 = "run_spawn_system_sequence"
l_0_0.NAME = l_0_3
l_0_0 = CoreRunSpawnSystemSequenceElement
l_0_3 = function(l_356_0, l_356_1, l_356_2)
	CoreBaseElement.init(l_356_0, l_356_1, l_356_2)
	l_356_0._socket_name = l_356_0:get("socket")
	l_356_0._unit_name = l_356_0:get("unit")
	l_356_0._sequence_name = l_356_0:get("sequence")
end

l_0_0.init = l_0_3
l_0_0 = CoreRunSpawnSystemSequenceElement
l_0_3 = function(l_357_0, l_357_1)
	local l_357_2 = l_357_0:run_parsed_func(l_357_1, l_357_0._socket_name)
	local l_357_3 = l_357_0:run_parsed_func(l_357_1, l_357_0._unit_name)
	local l_357_4 = l_357_0:run_parsed_func(l_357_1, l_357_0._sequence_name)
	if not l_357_2 then
		l_357_0:print_attribute_error("socket", l_357_2, nil, false, l_357_1)
	elseif not l_357_3 then
		l_357_0:print_attribute_error("unit", l_357_3, nil, false, l_357_1)
	elseif not l_357_4 then
		l_357_0:print_attribute_error("sequence", l_357_4, nil, false, l_357_1)
	else
		local l_357_5 = l_357_1.dest_unit:spawn_system()
		if l_357_5 then
			local l_357_6 = l_357_5:get_child_unit(l_357_2, l_357_3)
		if alive(l_357_6) then
			end
			local l_357_7 = l_357_6:damage()
			if l_357_7 then
				l_357_7:run_sequence_simple(l_357_4)
			end
		else
			l_357_0:print_error("No damage extension found on unit \"" .. tostring(l_357_6) .. "\".", true, l_357_1)
		end
	else
		l_357_0:print_error("No spawn_system extension found on unit \"" .. tostring(l_357_1.dest_unit) .. "\".", true, l_357_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetDamageElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetDamageElement = l_0_0
l_0_0 = CoreSetDamageElement
l_0_3 = "set_damage"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetDamageElement
l_0_3 = function(l_358_0, l_358_1, l_358_2)
	local l_358_7 = nil
	local l_358_6 = CoreBaseElement.init
	l_358_6(l_358_0, l_358_1, l_358_2)
	l_358_0._damage, l_358_6 = l_358_6, {}
	l_358_0._set_functions, l_358_6 = l_358_6, {}
	l_358_6 = pairs
	l_358_6 = l_358_6(l_358_0._parameters)
	for i_0,i_1 in l_358_6 do
		l_358_0._damage[l_358_5] = l_358_0:get(l_358_5, l_358_0.set_damage)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_3
l_0_0 = CoreSetDamageElement
l_0_3 = function(l_359_0, l_359_1)
	local l_359_5, l_359_6, l_359_7, l_359_8, l_359_9 = nil
	if alive(l_359_1.dest_body) then
		if l_359_1.dest_body:extension() and l_359_1.dest_body:extension().damage then
			for i_0,i_1 in pairs(l_359_0._damage) do
				i_1(l_359_1, i_0)
			end
		else
			l_359_0:print_error("Unable to set body damage on unit \"" .. tostring(l_359_1.dest_unit) .. "\" with body \"" .. l_359_1.dest_body:name() .. "\" since it didn't have a damage extension on the body.", true, l_359_1)
		end
	else
		l_359_0:print_error("Unable to set body damage on destroyed body. This is probably because a scripter didn't specify a body when a sequence was executed or if it was executed from a sequence that had \"startup\" attribute set to true or if the sequence was triggered from a water element.", true, l_359_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetDamageElement
l_0_3 = "set_damage"
l_0_0[l_0_3] = function(l_360_0, l_360_1, l_360_2, l_360_3)
	local l_360_4 = l_360_1.dest_body:extension().damage
	l_360_4:set_damage(l_360_3, l_360_2)
end

l_0_0 = CoreSetExtensionVarElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetExtensionVarElement = l_0_0
l_0_0 = CoreSetExtensionVarElement
l_0_3 = "set_extension_var"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetExtensionVarElement
l_0_3 = function(l_361_0, l_361_1, l_361_2)
	CoreBaseElement.init(l_361_0, l_361_1, l_361_2)
	l_361_0._name = l_361_0:get("name")
	l_361_0._variable = l_361_0:get("variable")
	l_361_0._value = l_361_0:get("value")
end

l_0_0.init = l_0_3
l_0_0 = CoreSetExtensionVarElement
l_0_3 = function(l_362_0, l_362_1)
	local l_362_2 = l_362_0:run_parsed_func(l_362_1, l_362_0._name)
	if not l_362_2 or not l_362_1.dest_unit[l_362_2](l_362_1.dest_unit) then
		local l_362_4 = nil
		l_362_0:print_attribute_error("name", l_362_2, CoreSequenceManager:get_keys_as_string(l_362_1.dest_unit:extensions(), "", true, true), true, l_362_1)
	do
		else
			local l_362_5 = nil
			if not l_362_0:run_parsed_func(l_362_1, l_362_0._variable) then
				l_362_0:print_attribute_error("variable", l_362_0:run_parsed_func(l_362_1, l_362_0._variable), nil, true, l_362_1)
			end
		else
			l_362_5[l_362_0:run_parsed_func(l_362_1, l_362_0._variable)] = l_362_0:run_parsed_func(l_362_1, l_362_0._value)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetGlobalVariableElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetGlobalVariableElement = l_0_0
l_0_0 = CoreSetGlobalVariableElement
l_0_3 = "set_global_variable"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetGlobalVariableElement
l_0_3 = function(l_363_0, l_363_1, l_363_2)
	CoreBaseElement.init(l_363_0, l_363_1, l_363_2)
	l_363_0._name = l_363_0:get("name")
	l_363_0._value = l_363_0:get("value")
end

l_0_0.init = l_0_3
l_0_0 = CoreSetGlobalVariableElement
l_0_3 = function(l_364_0, l_364_1)
	local l_364_2 = l_364_0:run_parsed_func(l_364_1, l_364_0._name)
	if l_364_2 then
		local l_364_3 = l_364_0:run_parsed_func(l_364_1, l_364_0._value)
		l_364_0:set_variable(l_364_1, l_364_2, l_364_3)
	else
		l_364_0:print_attribute_error("name", l_364_2, nil, true, l_364_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetGlobalVariableElement
l_0_3 = "set_variable"
l_0_0[l_0_3] = function(l_365_0, l_365_1, l_365_2, l_365_3)
	l_365_1.g_vars[l_365_2] = l_365_3
	l_365_0._unit_element._global_vars[l_365_2] = l_365_3
end

l_0_0 = CoreSetGlobalVariablesElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetGlobalVariablesElement = l_0_0
l_0_0 = CoreSetGlobalVariablesElement
l_0_3 = "set_global_variables"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetGlobalVariablesElement
l_0_3 = function(l_366_0, l_366_1, l_366_2)
	local l_366_7 = nil
	local l_366_6 = CoreBaseElement.init
	l_366_6(l_366_0, l_366_1, l_366_2)
	l_366_0._variables, l_366_6 = l_366_6, {}
	l_366_6 = pairs
	l_366_6 = l_366_6(l_366_0._parameters)
	for i_0,i_1 in l_366_6 do
		if not l_366_0.BASE_ATTRIBUTE_MAP[l_366_5] then
			l_366_0._variables[l_366_5] = l_366_0:get(l_366_5)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_3
l_0_0 = CoreSetGlobalVariablesElement
l_0_3 = function(l_367_0, l_367_1)
	local l_367_5, l_367_6, l_367_7, l_367_8, l_367_9 = nil
	for i_0,i_1 in pairs(l_367_0._variables) do
		l_367_0:set_variable(l_367_1, i_0, l_367_0:run_parsed_func(l_367_1, i_1))
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetGlobalVariablesElement
l_0_3 = "set_variable"
l_0_0[l_0_3] = function(l_368_0, l_368_1, l_368_2, l_368_3)
	l_368_1.g_vars[l_368_2] = l_368_3
	l_368_0._unit_element._global_vars[l_368_2] = l_368_3
end

l_0_0 = CoreSetInflictElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetInflictElement = l_0_0
l_0_0 = CoreSetInflictElement
l_0_3 = "set_inflict"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetInflictElement
l_0_3 = function(l_369_0, l_369_1, l_369_2)
	CoreBaseElement.init(l_369_0, l_369_1, l_369_2)
	l_369_0._body_name = l_369_0:get("body")
	l_369_0._damage_type = l_369_0:get("type")
	l_369_0._set_func_list = {}
	l_369_0._set_func_list.damage = l_369_0:get("damage")
	l_369_0._set_func_list.interval = l_369_0:get("interval")
	l_369_0._set_func_list.instant = l_369_0:get("instant")
	l_369_0._set_func_list.enabled = l_369_0:get("enabled")
	l_369_0._set_func_list.fire_object = l_369_0:get("fire_object")
	l_369_0._set_func_list.fire_height = l_369_0:get("fire_height")
	l_369_0._set_func_list.velocity = l_369_0:get("velocity")
	l_369_0._set_func_list.falloff = l_369_0:get("falloff")
end

l_0_0.init = l_0_3
l_0_0 = CoreSetInflictElement
l_0_3 = function(l_370_0, l_370_1)
	local l_370_10, l_370_11, l_370_12, l_370_13, l_370_14 = nil
	local l_370_2 = l_370_0:run_parsed_func(l_370_1, l_370_0._body_name)
	do
		if ((not l_370_2 or l_370_1.dest_unit:body(l_370_2)) and not l_370_1.dest_unit:body(l_370_2):extension()) or l_370_1.dest_unit:body(l_370_2):extension().damage then
			local l_370_6 = nil
			for i_0,i_1 in pairs(l_370_0._set_func_list) do
				local l_370_7, l_370_8, l_370_9 = , l_370_0:run_parsed_func(l_370_1, l_370_0._damage_type)
				do
					if not l_370_8 then
						l_370_0:print_attribute_error("type", l_370_9, CoreSequenceManager:get_keys_as_string(managers.sequence:get_inflict_element_class_map(), "", true, false), true, l_370_1)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				elseif not l_370_8:set_inflict_attribute(l_370_9, i_0, l_370_0:run_parsed_func(l_370_1, i_1)) then
					l_370_0:print_attribute_error(l_370_18, l_370_0:run_parsed_func(l_370_1, i_1), nil, true, l_370_1)
				end
			end
		else
			l_370_0:print_attribute_error("body", l_370_2, nil, true, l_370_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetPhysicEffectElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetPhysicEffectElement = l_0_0
l_0_0 = CoreSetPhysicEffectElement
l_0_3 = "set_physic_effect"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetPhysicEffectElement
l_0_3 = function(l_371_0, l_371_1, l_371_2)
	CoreBaseElement.init(l_371_0, l_371_1, l_371_2)
	l_371_0._id = l_371_0:get("id")
	l_371_0._param_list = {}
	for l_371_6 = 1, 5 do
		l_371_0._param_list[l_371_6] = l_371_0:get("param" .. l_371_6)
	end
	l_371_0._body_list = {}
	l_371_0._center_of_mass = {}
	l_371_0._offset_list = {}
	for l_371_10 = 1, 5 do
		l_371_0._body_list[l_371_10] = l_371_0:get("body" .. l_371_10)
		if l_371_0._body_list[l_371_10] then
			l_371_0._center_of_mass_list[l_371_10] = l_371_0:get("center" .. l_371_10)
			l_371_0._offset_list[l_371_10] = l_371_0:get("offset" .. l_371_10)
		end
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreSetPhysicEffectElement
l_0_3 = function(l_372_0, l_372_1)
	if not l_372_0:run_parsed_func(l_372_1, l_372_0._id) then
		local l_372_2, l_372_3, l_372_4 = l_372_1.vars.last_physic_effect_id
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_372_2 then
		local l_372_8, l_372_10, l_372_11, l_372_14, l_372_16, l_372_17, l_372_18, l_372_19 = , l_372_0:print_attribute_error, l_372_0, "id", l_372_2
		l_372_17 = nil
		local l_372_9, l_372_12, l_372_15, l_372_20 = nil
		l_372_18 = true
		l_372_19 = l_372_1
		l_372_10(l_372_11, l_372_14, l_372_16, l_372_17, l_372_18, l_372_19)
	else
		for i_0,i_1 in pairs(l_372_0._param_list) do
			local l_372_5 = nil
			World:set_physic_effect_parameter(l_372_5, i_0, l_372_0:run_parsed_func(l_372_1, i_1))
		end
		for i_0,i_1 in pairs(l_372_0._body_list) do
			do
				World:set_physic_effect_parameter(l_372_5, l_372_22, l_372_0:run_parsed_func(l_372_1, i_1), l_372_0:run_parsed_func(l_372_1, l_372_0._center_of_mass[i_0]), l_372_0:run_parsed_func(l_372_1, l_372_0._offset_list[l_372_22]))
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetProximityElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetProximityElement = l_0_0
l_0_0 = CoreSetProximityElement
l_0_3 = "set_proximity"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetProximityElement
l_0_3 = function(l_373_0, l_373_1, l_373_2)
	CoreBaseElement.init(l_373_0, l_373_1, l_373_2)
	l_373_0._name = l_373_0:get("name")
	l_373_0._set_func_list = {}
	local l_373_3 = l_373_0:get("enabled", l_373_0.set_enabled)
	if l_373_3 then
		table.insert(l_373_0._set_func_list, l_373_3)
	end
	local l_373_4 = l_373_0:get("type", l_373_0.set_type)
	if l_373_4 then
		table.insert(l_373_0._set_func_list, l_373_4)
	end
	local l_373_5 = l_373_0:get("ref_object", l_373_0.set_ref_object)
	if l_373_5 then
		table.insert(l_373_0._set_func_list, l_373_5)
	end
	local l_373_6 = l_373_0:get("interval", l_373_0.set_interval)
	if l_373_6 then
		table.insert(l_373_0._set_func_list, l_373_6)
	end
	local l_373_7 = l_373_0:get("quick", l_373_0.set_quick)
	if l_373_7 then
		table.insert(l_373_0._set_func_list, l_373_7)
	end
	local l_373_8 = l_373_0:get("is_within", l_373_0.set_is_within)
	if l_373_8 then
		table.insert(l_373_0._set_func_list, l_373_8)
	end
	local l_373_9 = l_373_0:get("within_activations", l_373_0.set_within_activations)
	if l_373_9 then
		table.insert(l_373_0._set_func_list, l_373_9)
	end
	local l_373_10 = l_373_0:get("within_max_activations", l_373_0.set_within_max_activations)
	if l_373_10 then
		table.insert(l_373_0._set_func_list, l_373_10)
	end
	local l_373_11 = l_373_0:get("within_delay", l_373_0.set_within_delay)
	if l_373_11 then
		table.insert(l_373_0._set_func_list, l_373_11)
	end
	local l_373_12 = l_373_0:get("within_range", l_373_0.set_within_range)
	if l_373_12 then
		table.insert(l_373_0._set_func_list, l_373_12)
	end
	local l_373_13 = l_373_0:get("within_count", l_373_0.set_within_count)
	if l_373_13 then
		table.insert(l_373_0._set_func_list, l_373_13)
	end
	local l_373_14 = l_373_0:get("outside_activations", l_373_0.set_outside_activations)
	if l_373_14 then
		table.insert(l_373_0._set_func_list, l_373_14)
	end
	local l_373_15 = l_373_0:get("outside_max_activations", l_373_0.set_outside_max_activations)
	if l_373_15 then
		table.insert(l_373_0._set_func_list, l_373_15)
	end
	local l_373_16 = l_373_0:get("outside_delay", l_373_0.set_outside_delay)
	if l_373_16 then
		table.insert(l_373_0._set_func_list, l_373_16)
	end
	local l_373_17 = l_373_0:get("outside_range", l_373_0.set_outside_range)
	if l_373_17 then
		table.insert(l_373_0._set_func_list, l_373_17)
	end
	local l_373_18 = l_373_0:get("outside_count", l_373_0.set_outside_count)
	if l_373_18 then
		table.insert(l_373_0._set_func_list, l_373_18)
	end
end

l_0_0.init = l_0_3
l_0_0 = CoreSetProximityElement
l_0_3 = function(l_374_0, l_374_1)
	local l_374_7, l_374_8, l_374_9, l_374_10 = nil
	local l_374_2 = l_374_0:run_parsed_func(l_374_1, l_374_0._name)
	local l_374_3 = l_374_1.dest_unit:damage():get_proximity_map()
	if l_374_2 and l_374_3[l_374_2] then
		for i_0,i_1 in ipairs(l_374_0._set_func_list) do
			i_1(l_374_1, l_374_2)
		end
	else
		local l_374_11 = CoreSequenceManager:get_keys_as_string(l_374_3, "", true, true)
		l_374_0:print_attribute_error("name", l_374_2, l_374_11, true, l_374_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetProximityElement
l_0_3 = "set_enabled"
l_0_0[l_0_3] = function(l_375_0, l_375_1, l_375_2, l_375_3)
	local l_375_4, l_375_5 = l_375_1.dest_unit:damage():set_proximity_enabled, l_375_1.dest_unit:damage()
	local l_375_6 = l_375_3
	l_375_4(l_375_5, l_375_6, l_375_2 == true)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_type"
l_0_0[l_0_3] = function(l_376_0, l_376_1, l_376_2, l_376_3)
	local l_376_4 = managers.sequence:get_proximity_mask(l_376_2)
	if l_376_4 then
		l_376_1.dest_unit:damage():set_proximity_slotmask(l_376_3, l_376_4)
	else
		local l_376_5 = CoreSequenceManager:get_keys_as_string(managers.sequence:get_proximity_mask_map(), "", true, false)
		l_376_0:print_attribute_error("type", l_376_2, l_376_5, true, l_376_1)
	end
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_ref_obj_name"
l_0_0[l_0_3] = function(l_377_0, l_377_1, l_377_2, l_377_3)
	damage_ext:set_proximity_ref_obj_name(l_377_3, l_377_2)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_interval"
l_0_0[l_0_3] = function(l_378_0, l_378_1, l_378_2, l_378_3)
	l_378_1.dest_unit:damage():set_proximity_interval(l_378_3, math.min(tonumber(l_378_2) or 0, get_core_or_local("ProximityTypeElement").MIN_INTERVAL))
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_quick"
l_0_0[l_0_3] = function(l_379_0, l_379_1, l_379_2, l_379_3)
	local l_379_4, l_379_5 = l_379_1.dest_unit:damage():set_proximity_quick, l_379_1.dest_unit:damage()
	local l_379_6 = l_379_3
	l_379_4(l_379_5, l_379_6, l_379_2 ~= false)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_is_within"
l_0_0[l_0_3] = function(l_380_0, l_380_1, l_380_2, l_380_3)
	local l_380_4, l_380_5 = l_380_1.dest_unit:damage():set_proximity_is_within, l_380_1.dest_unit:damage()
	local l_380_6 = l_380_3
	l_380_4(l_380_5, l_380_6, l_380_2 == true)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_within_activations"
l_0_0[l_0_3] = function(l_381_0, l_381_1, l_381_2, l_381_3)
	l_381_1.dest_unit:damage():set_proximity_within_activations(l_381_3, tonumber(l_381_2) or 0)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_within_max_activations"
l_0_0[l_0_3] = function(l_382_0, l_382_1, l_382_2, l_382_3)
	l_382_1.dest_unit:damage():set_proximity_within_max_activations(l_382_3, tonumber(l_382_2) or -1)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_within_delay"
l_0_0[l_0_3] = function(l_383_0, l_383_1, l_383_2, l_383_3)
	l_383_1.dest_unit:damage():set_proximity_within_delay(l_383_3, tonumber(l_383_2) or 0)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_within_range"
l_0_0[l_0_3] = function(l_384_0, l_384_1, l_384_2, l_384_3)
	l_384_1.dest_unit:damage():set_proximity_within_range(l_384_3, max(tonumber(l_384_2) or 0, 0))
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_inside_count"
l_0_0[l_0_3] = function(l_385_0, l_385_1, l_385_2, l_385_3)
	l_385_1.dest_unit:damage():set_proximity_inside_count(l_385_3, tonumber(l_385_2) or -1)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_outside_activations"
l_0_0[l_0_3] = function(l_386_0, l_386_1, l_386_2, l_386_3)
	l_386_1.dest_unit:damage():set_proximity_outside_activations(l_386_3, tonumber(l_386_2) or 0)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_outside_max_activations"
l_0_0[l_0_3] = function(l_387_0, l_387_1, l_387_2, l_387_3)
	l_387_1.dest_unit:damage():set_proximity_outside_max_activations(l_387_3, tonumber(l_387_2) or -1)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_outside_delay"
l_0_0[l_0_3] = function(l_388_0, l_388_1, l_388_2, l_388_3)
	l_388_1.dest_unit:damage():set_proximity_outside_delay(l_388_3, tonumber(l_388_2) or 0)
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_outside_range"
l_0_0[l_0_3] = function(l_389_0, l_389_1, l_389_2, l_389_3)
	l_389_1.dest_unit:damage():set_proximity_outside_range(l_389_3, max(tonumber(l_389_2) or 0, 0))
end

l_0_0 = CoreSetProximityElement
l_0_3 = "set_outside_count"
l_0_0[l_0_3] = function(l_390_0, l_390_1, l_390_2, l_390_3)
	l_390_1.dest_unit:damage():set_proximity_outside_count(l_390_3, tonumber(l_390_2) or -1)
end

l_0_0 = CoreSetSaveDataElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetSaveDataElement = l_0_0
l_0_0 = CoreSetSaveDataElement
l_0_3 = "set_save_data"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetSaveDataElement
l_0_3 = "SET_SAVE_DATA_ATTRIBUTE_MAP"
if not CoreSetSaveDataElement.SET_SAVE_DATA_ATTRIBUTE_MAP then
	local l_0_25, l_0_27 = {}
	l_0_27 = "unique"
	local l_0_26 = nil
	l_0_26 = true
	l_0_25[l_0_27] = l_0_26
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_25
l_0_0 = CoreSetSaveDataElement
l_0_3 = function(l_391_0, l_391_1, l_391_2)
	local l_391_7 = nil
	local l_391_6 = CoreBaseElement.init
	l_391_6(l_391_0, l_391_1, l_391_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_391_0._unique = l_391_6
	l_391_0._variables, l_391_6 = l_391_6, {}
	l_391_6 = pairs
	l_391_6 = l_391_6(l_391_0._parameters)
	for i_0,i_1 in l_391_6 do
		if not l_391_0.BASE_ATTRIBUTE_MAP[l_391_5] and not l_391_0.SET_SAVE_DATA_ATTRIBUTE_MAP[l_391_5] then
			l_391_0._variables[l_391_5] = l_391_0:get(l_391_5)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_3
l_0_0 = CoreSetSaveDataElement
l_0_3 = function(l_392_0, l_392_1)
	local l_392_6, l_392_7, l_392_8, l_392_9 = nil
	local l_392_2 = l_392_0:run_parsed_func(l_392_1, l_392_0._unique)
	for i_0,i_1 in pairs(l_392_0._variables) do
		i_1 = l_392_0:run_parsed_func(l_392_1, i_1)
		if l_392_2 then
			l_392_1.set_unique_save_data(l_392_10, i_1)
		else
			l_392_1.g_save_data[l_392_10] = i_1
		end
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = SetSpawnSystemUnitEnabledElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
SetSpawnSystemUnitEnabledElement = l_0_0
l_0_0 = SetSpawnSystemUnitEnabledElement
l_0_3 = "set_spawn_system_unit_enabled"
l_0_0.NAME = l_0_3
l_0_0 = SetSpawnSystemUnitEnabledElement
l_0_3 = function(l_393_0, l_393_1, l_393_2)
	CoreBaseElement.init(l_393_0, l_393_1, l_393_2)
	l_393_0._socket_name = l_393_0:get("socket")
	l_393_0._unit_name = l_393_0:get("unit")
	l_393_0._enabled = l_393_0:get("enabled")
end

l_0_0.init = l_0_3
l_0_0 = SetSpawnSystemUnitEnabledElement
l_0_3 = function(l_394_0, l_394_1)
	local l_394_2 = l_394_0:run_parsed_func(l_394_1, l_394_0._socket_name)
	local l_394_3 = l_394_0:run_parsed_func(l_394_1, l_394_0._unit_name)
	local l_394_4 = l_394_0:run_parsed_func(l_394_1, l_394_0._enabled)
	if not l_394_2 then
		l_394_0:print_attribute_error("socket", l_394_2, nil, false, l_394_1)
	elseif not l_394_3 then
		l_394_0:print_attribute_error("unit", l_394_3, nil, false, l_394_1)
	else
		local l_394_5 = l_394_1.dest_unit:spawn_system()
		if l_394_5 then
			local l_394_6, l_394_7 = l_394_5:set_unit_enabled(l_394_2, l_394_3, l_394_4)
		end
	else
		l_394_0:print_error("No spawn_system extension found on unit \"" .. tostring(l_394_1.dest_unit) .. "\".", true, l_394_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSetVariableElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreSetGlobalVariableElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetVariableElement = l_0_0
l_0_0 = CoreSetVariableElement
l_0_3 = "set_variable"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetVariableElement
l_0_3 = "set_variable"
l_0_0[l_0_3] = function(l_395_0, l_395_1, l_395_2, l_395_3)
	l_395_1.vars[l_395_2] = l_395_3
	l_395_1.dest_unit:damage()._variables[l_395_2] = l_395_3
end

l_0_0 = CoreSetVariablesElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreSetGlobalVariablesElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetVariablesElement = l_0_0
l_0_0 = CoreSetVariablesElement
l_0_3 = "set_variables"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetVariablesElement
l_0_3 = "set_variable"
l_0_0[l_0_3] = function(l_396_0, l_396_1, l_396_2, l_396_3)
	l_396_1.vars[l_396_2] = l_396_3
	l_396_1.dest_unit:damage()._variables[l_396_2] = l_396_3
end

l_0_0 = CoreSetWaterElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSetWaterElement = l_0_0
l_0_0 = CoreSetWaterElement
l_0_3 = "set_water"
l_0_0.NAME = l_0_3
l_0_0 = CoreSetWaterElement
l_0_3 = function(l_397_0, l_397_1, l_397_2)
	CoreBaseElement.init(l_397_0, l_397_1, l_397_2)
	l_397_0._name = l_397_0:get("name")
	l_397_0._enabled = l_397_0:get("enabled")
	l_397_0._interval = l_397_0:get("interval")
	l_397_0._ref_object_name = l_397_0:get("ref_object")
	l_397_0._ref_body_name = l_397_0:get("ref_body")
	l_397_0._body_depth = l_397_0:get("body_depth")
	l_397_0._physic_effect = l_397_0:get("physic_effect")
end

l_0_0.init = l_0_3
l_0_0 = CoreSetWaterElement
l_0_3 = function(l_398_0, l_398_1)
	local l_398_2 = l_398_0:run_parsed_func(l_398_1, l_398_0._name)
	if l_398_2 then
		local l_398_3 = (l_398_1.dest_unit:damage())
		local l_398_4 = nil
		do
			local l_398_5, l_398_6 = tonumber(l_398_0:run_parsed_func(l_398_1, l_398_0._interval)) or 1
		end
		local l_398_7 = nil
		local l_398_8 = l_398_0:run_parsed_func(l_398_1, l_398_0._ref_object_name)
		do
			local l_398_9, l_398_10 = l_398_0:run_parsed_func(l_398_1, l_398_0._ref_body_name), tonumber(l_398_0:run_parsed_func(l_398_1, l_398_0._body_depth)) or 0
		do
			end
			local l_398_11 = nil
			if l_398_0._enabled then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if not l_398_3:is_water_check_active(l_398_2) then
				l_398_3:set_water_check(l_398_2, l_398_4, l_398_7, l_398_8, l_398_11, l_398_10, l_398_0:run_parsed_func(l_398_1, l_398_0._physic_effect))
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			local l_398_12 = CoreSequenceManager:get_keys_as_string(l_398_1.dest_unit:damage():get_water_check_map(), "", true, false)
			l_398_0:print_attribute_error("name", l_398_2, l_398_12, true, l_398_1)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 59 
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreShakeCameraElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreShakeCameraElement = l_0_0
l_0_0 = CoreShakeCameraElement
l_0_3 = "shake_camera"
l_0_0.NAME = l_0_3
l_0_0 = CoreShakeCameraElement
l_0_3 = function(l_399_0, l_399_1, l_399_2)
	CoreBaseElement.init(l_399_0, l_399_1, l_399_2)
	l_399_0._shaker = l_399_0:get("shaker")
	l_399_0._amplitude = l_399_0:get("amplitude")
	l_399_0._frequency = l_399_0:get("frequency")
	l_399_0._offset = l_399_0:get("offset")
end

l_0_0.init = l_0_3
l_0_0 = CoreShakeCameraElement
l_0_3 = function(l_400_0, l_400_1)
	local l_400_2 = l_400_0:run_parsed_func(l_400_1, l_400_0._shaker)
	do
		local l_400_3, l_400_4, l_400_6, l_400_9 = l_400_0:run_parsed_func(l_400_1, l_400_0._amplitude) or 1
	do
		end
		local l_400_5, l_400_7, l_400_10 = , l_400_0:run_parsed_func(l_400_1, l_400_0._frequency) or 1
	do
		end
		local l_400_8, l_400_11 = nil
	end
	local l_400_12 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if managers.viewport:get_current_shaker() then
		managers.viewport:get_current_shaker():play(l_400_2, l_400_12, l_400_11, l_400_0:run_parsed_func(l_400_1, l_400_0._offset) or 0)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSlotElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSlotElement = l_0_0
l_0_0 = CoreSlotElement
l_0_3 = "slot"
l_0_0.NAME = l_0_3
l_0_0 = CoreSlotElement
l_0_3 = function(l_401_0, l_401_1, l_401_2)
	CoreBaseElement.init(l_401_0, l_401_1, l_401_2)
	l_401_0._slot = l_401_0:get("slot")
	l_401_0._frustum_delay = l_401_0:get("frustum_delay")
	l_401_0._frustum_close_radius = l_401_0:get("frustum_close_radius")
	l_401_0._frustum_extension = l_401_0:get("frustum_extension")
	l_401_0._frustum_far_clip = l_401_0:get("frustum_far_clip")
end

l_0_0.init = l_0_3
l_0_0 = CoreSlotElement
l_0_3 = function(l_402_0, l_402_1)
	if l_402_0._frustum_delay then
		local l_402_2 = l_402_0:run_parsed_func(l_402_1, l_402_0._frustum_delay)
		do
			local l_402_3 = l_402_0:run_parsed_func(l_402_1, l_402_0._frustum_close_radius)
			local l_402_4 = l_402_0:run_parsed_func(l_402_1, l_402_0._frustum_extension)
			local l_402_5 = l_402_0:run_parsed_func(l_402_1, l_402_0._frustum_far_clip)
			local l_402_6 = {}
			local l_402_8 = function()
				-- upvalues: l_402_0 , l_402_3 , l_402_4 , l_402_5 , l_402_2 , l_402_1 , l_402_6
				local l_403_0, l_403_1 = l_402_0:check_frustum_delay, l_402_0
				local l_403_2 = l_402_3
				local l_403_3 = l_402_4
				local l_403_4 = l_402_5
				local l_403_5 = l_402_2
				local l_403_6 = l_402_1
				local l_403_7 = l_402_6
				return l_403_0(l_403_1, l_403_2, l_403_3, l_403_4, l_403_5, l_403_6, l_403_7)
      end
			for l_402_12 = 0, l_402_1.dest_unit:num_bodies() - 1 do
				local l_402_9 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				table.insert(l_402_6._bodies, l_402_1.dest_unit:body(R12_PC43))
			end
			if #l_402_6._bodies == 0 then
				l_402_0:activate_element(l_402_1)
			end
			managers.sequence:add_retry_callback("culling", l_402_8, true)
			if l_402_0.SAVE_STATE then
				l_402_0:set_state(l_402_1.dest_unit, tonumber(l_402_0:run_parsed_func(l_402_1, l_402_0._slot)))
			end
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		l_402_0:activate_element(l_402_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSlotElement
l_0_3 = "activate_element"
l_0_0[l_0_3] = function(l_403_0, l_403_1)
	local l_403_2 = tonumber(l_403_0:run_parsed_func(l_403_1, l_403_0._slot))
	if l_403_2 then
		l_403_1.dest_unit:set_slot(l_403_2)
		if l_403_0.SAVE_STATE then
			l_403_0:set_state(l_403_1.dest_unit, l_403_2)
		end
	else
		l_403_0:print_attribute_error("slot", l_403_2, nil, true, l_403_1, nil)
	end
end

l_0_0 = CoreSlotElement
l_0_3 = function(l_404_0, l_404_1)
	l_404_0:set_slot(l_404_1)
end

l_0_0.load = l_0_3
l_0_0 = CoreSlotElement
l_0_3 = "check_frustum_delay"
l_0_0[l_0_3] = function(l_405_0, l_405_1, l_405_2, l_405_3, l_405_4, l_405_5, l_405_6)
	if not alive(l_405_5.dest_unit) then
		return true
	end
	local l_405_7 = l_405_6._bodies[l_405_6._body_index]
	local l_405_8 = l_405_7:position()
	local l_405_9, l_405_10 = World:in_view_with_options, World
	local l_405_11 = l_405_8
	do
		l_405_9 = l_405_9(l_405_10, l_405_11, l_405_1 or 0, l_405_2 or 350, l_405_3 or 150000)
		if l_405_9 == l_405_4 then
			l_405_9, l_405_10 = l_405_0:hide_objects, l_405_0
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_405_9(l_405_10, l_405_11)
			l_405_9 = table
			l_405_9 = l_405_9.remove
			l_405_10 = l_405_6._bodies
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_405_9(l_405_10, l_405_11)
			l_405_9 = l_405_6._bodies
			l_405_9 = #l_405_9
			if l_405_9 == 0 then
				l_405_9, l_405_10 = l_405_0:activate_element, l_405_0
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_405_9(l_405_10, l_405_11)
				l_405_9 = true
				return l_405_9
			end
		else
			l_405_9 = l_405_6._body_index
			l_405_9 = l_405_9 + 1
			l_405_6._body_index = l_405_9
		end
		l_405_9 = l_405_6._body_index
		l_405_10 = l_405_6._bodies
		l_405_10 = #l_405_10
		if l_405_10 < l_405_9 then
			l_405_6._body_index = 1
		end
		l_405_9 = false
		return l_405_9
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreSlotElement
l_0_3 = "hide_objects"
l_0_0[l_0_3] = function(l_406_0, l_406_1)
	l_406_1:set_visibility(false)
	local l_406_5, l_406_6 = ipairs, l_406_1:children()
	l_406_5 = l_406_5(l_406_6)
	for i_0,i_1 in l_406_5 do
		l_406_0:hide_objects(l_406_4)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreSoundElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSoundElement = l_0_0
l_0_0 = CoreSoundElement
l_0_3 = "sound"
l_0_0.NAME = l_0_3
l_0_0 = CoreSoundElement
l_0_3 = function(l_407_0, l_407_1, l_407_2)
	CoreBaseElement.init(l_407_0, l_407_1, l_407_2)
	l_407_0._action = l_407_0:get("action")
	l_407_0._target = l_407_0:get("target")
	l_407_0._cue = l_407_0:get("cue")
	l_407_0._gain_abs = l_407_0:get("gain")
	l_407_0._pitch_abs = l_407_0:get("pitch")
	l_407_0._crossfade = l_407_0:get("crossfade")
	l_407_0._t = l_407_0:get("t")
end

l_0_0.init = l_0_3
l_0_0 = CoreSoundElement
l_0_3 = function(l_408_0, l_408_1)
	do
		local l_408_2 = l_408_0:run_parsed_func(l_408_1, l_408_0._action) or "play"
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_408_3 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_408_0[l_408_2] then
		l_408_0[l_408_2](l_408_0, l_408_1)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSoundElement
l_0_3 = "play"
l_0_0[l_0_3] = function(l_409_0, l_409_1)
	local l_409_2 = l_409_0:run_parsed_func(l_409_1, l_409_0._cue)
	if l_409_2 ~= nil then
		local l_409_3 = l_409_0:run_parsed_func(l_409_1, l_409_0._target)
		local l_409_4 = {}
		l_409_4.gain_abs = l_409_0:run_parsed_func(l_409_1, l_409_0._gain_abs)
		l_409_4.pitch_abs = l_409_0:run_parsed_func(l_409_1, l_409_0._pitch_abs)
		l_409_4.crossfade = l_409_0:run_parsed_func(l_409_1, l_409_0._crossfade)
		l_409_4.t = l_409_0:run_parsed_func(l_409_1, l_409_0._t)
		if l_409_3 then
			if l_409_1.dest_unit:get_object(l_409_3) then
				l_409_1.dest_unit:play_at(l_409_2, l_409_3, table.unpack_map(l_409_4))
			else
				l_409_0:print_attribute_error("target", l_409_3, nil, true, l_409_1, nil)
			end
		else
			l_409_1.dest_unit:play(l_409_2, table.unpack_map(l_409_4))
		end
	else
		l_409_0:print_attribute_error("cue", l_409_2, nil, true, l_409_1, nil)
	end
end

l_0_0 = CoreSoundElement
l_0_3 = "stop"
l_0_0[l_0_3] = function(l_410_0, l_410_1)
	local l_410_2 = l_410_0:run_parsed_func(l_410_1, l_410_0._cue)
	if l_410_2 ~= nil then
		l_410_1.dest_unit:stop(l_410_2)
	else
		l_410_0:print_attribute_error("cue", l_410_2, nil, true, l_410_1, nil)
	end
end

l_0_0 = CoreSpawnUnitElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreSpawnUnitElement = l_0_0
l_0_0 = CoreSpawnUnitElement
l_0_3 = "spawn_unit"
l_0_0.NAME = l_0_3
l_0_0 = CoreSpawnUnitElement
l_0_3 = "SPAWN_UNIT_ATTRIBUTE_MAP"
if not CoreSpawnUnitElement.SPAWN_UNIT_ATTRIBUTE_MAP then
	local l_0_28, l_0_30 = {}
	l_0_30 = "name"
	local l_0_29 = nil
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = "position"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = "rotation"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = "transfer_velocity"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = true
	l_0_28.run_sequence = l_0_30
	l_0_30 = "src_link_obj"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = "dest_link_obj"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = "from_trigger"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = "from_trigger_sequence"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = "to_trigger"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
	l_0_30 = "to_trigger_sequence"
	l_0_29 = true
	l_0_28[l_0_30] = l_0_29
end
 -- DECOMPILER ERROR: Confused about usage of registers!

l_0_0[l_0_3] = l_0_28
l_0_0 = CoreSpawnUnitElement
l_0_3 = function(l_411_0, l_411_1, l_411_2)
	local l_411_7 = nil
	local l_411_6 = CoreBaseElement.init
	l_411_6(l_411_0, l_411_1, l_411_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._name = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._position = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._rotation = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._transfer_velocity = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._transfer_ang_velocity = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._run_sequence = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._src_link_obj = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._dest_link_obj = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._from_trigger = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._from_trigger_sequence = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._to_trigger = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._to_trigger_sequence = l_411_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_411_0._inherit_destroy = l_411_6
	l_411_0._params, l_411_6 = l_411_6, {}
	l_411_6 = pairs
	l_411_6 = l_411_6(l_411_0._parameters)
	for i_0,i_1 in l_411_6 do
		if not l_411_0.BASE_ATTRIBUTE_MAP[l_411_5] and not l_411_0.SPAWN_UNIT_ATTRIBUTE_MAP[l_411_5] then
			l_411_0._params[l_411_5] = l_411_0:get(l_411_5)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.init = l_0_3
l_0_0 = CoreSpawnUnitElement
l_0_3 = function(l_412_0, l_412_1)
	local l_412_2 = l_412_0:run_parsed_func(l_412_1, l_412_0._name)
	local l_412_3 = l_412_0:run_parsed_func(l_412_1, l_412_0._position)
	local l_412_4 = l_412_0:run_parsed_func(l_412_1, l_412_0._rotation)
	local l_412_5 = l_412_0:run_parsed_func(l_412_1, l_412_0._src_link_obj)
	local l_412_6 = l_412_0:run_parsed_func(l_412_1, l_412_0._run_sequence)
	if not l_412_2 then
		l_412_0:print_attribute_error("name", l_412_2, nil, true, l_412_1)
	elseif not l_412_3 then
		l_412_0:print_attribute_error("position", l_412_3, nil, true, l_412_1)
	elseif not l_412_4 then
		l_412_0:print_attribute_error("rotation", l_412_4, nil, true, l_412_1)
	else
		local l_412_7 = nil
		local l_412_8 = l_412_1.dest_unit:damage()
		if MassUnitManager:can_spawn_unit(l_412_2) then
			l_412_7 = MassUnitManager:spawn_unit(l_412_2, l_412_3, l_412_4)
		else
			if Network:multiplayer() and Network:is_client() then
				local l_412_9 = UnitDatabase:get_unit_data(l_412_2)
			if l_412_9 then
				end
				local l_412_10 = l_412_9:network_sync()
				if l_412_10 ~= "none" and l_412_10 ~= "client" then
					return 
				end
			end
			l_412_7 = World:spawn_unit(l_412_2, l_412_3, l_412_4)
		if l_412_7 then
			end
			if l_412_8.external_spawn_unit_callback then
				l_412_8:external_spawn_unit_callback(l_412_7, l_412_1)
			end
		if alive(l_412_1.src_unit) then
			end
		if l_412_1.dest_unit ~= l_412_1.src_unit then
			end
			local l_412_11 = l_412_1.src_unit:damage()
		if l_412_11 then
			end
		if l_412_11.external_spawn_unit_callback then
			end
			l_412_11:external_spawn_unit_callback(l_412_7, l_412_1)
		end
		if l_412_5 then
			if not l_412_7 then
				l_412_0:print_error("Spawned mass unit must be enabled before it can be linked.", false, l_412_1)
			end
		else
			local l_412_12 = l_412_0:run_parsed_func(l_412_1, l_412_0._dest_link_obj)
			if l_412_12 then
				l_412_1.dest_unit:link(l_412_5, l_412_7, l_412_12)
			end
		else
			l_412_1.dest_unit:link(l_412_5, l_412_7)
		end
		local l_412_13 = l_412_0:run_parsed_func(l_412_1, l_412_0._transfer_velocity)
		if l_412_13 then
			if not l_412_7 then
				l_412_0:print_error("Spawned mass unit must be enabled to be able to transfer velocity \"" .. tostring(l_412_13) .. "\".", false, l_412_1)
			end
		else
			local l_412_14 = nil
			if getmetatable(l_412_13) == Vector3 then
				l_412_14 = l_412_13
			elseif l_412_1.damage_type == "collision" then
				l_412_14 = l_412_1.velocity
			else
				if alive(l_412_1.dest_body) then
					l_412_14 = l_412_1.dest_body:velocity()
				end
			else
				l_412_14 = l_412_1.dest_unit:velocity()
			end
			local l_412_15 = (l_412_0:run_parsed_func(l_412_1, l_412_0._transfer_ang_velocity))
			local l_412_16 = nil
			if l_412_15 then
				if getmetatable(l_412_15) ~= Vector3 then
					if alive(l_412_1.dest_body) then
						l_412_15 = l_412_1.dest_body:angular_velocity()
					end
				else
					l_412_15 = Vector3()
					for l_412_20 = 1, l_412_1.dest_unit:num_bodies() do
						local l_412_21 = l_412_1.dest_unit:body(l_412_20 - 1)
						local l_412_22 = l_412_21:angular_velocity()
						if l_412_15:length() < l_412_22:length() then
							l_412_15 = l_412_22
						end
					end
				end
				l_412_16 = "core_sequencemanager_push_with_ang"
			else
				l_412_16 = "core_sequencemanager_push"
			end
			World:play_physic_effect(l_412_16, l_412_7, l_412_14, l_412_7:mass(), l_412_15)
		end
		local l_412_23 = nil
		if l_412_6 and l_412_6 ~= "" then
			if not l_412_7 then
				l_412_0:print_error("Spawned mass unit must be enabled before sequence \"" .. tostring(l_412_6) .. "\" can be runned on it.", false, l_412_1)
			end
		else
			if l_412_7:damage() then
				l_412_23 = l_412_0:get_params(l_412_1)
				if not l_412_1.src_unit then
					managers.sequence:run_sequence(l_412_6, l_412_1.damage_type, l_412_1.dest_unit, l_412_7, nil, l_412_1.dest_normal, l_412_1.pos, l_412_1.dir, l_412_1.damage, l_412_1.velocity, l_412_23)
					SequenceEnvironment.self = l_412_1
					SequenceEnvironment.element = l_412_0
				end
			else
				l_412_0:print_error("Unable to run sequence \"" .. tostring(l_412_6) .. "\" on unit \"" .. tostring(l_412_7) .. "\" since it doesn't have a damage-extension.", true, l_412_1)
			end
			local l_412_24 = l_412_0:run_parsed_func(l_412_1, l_412_0._from_trigger)
			if l_412_24 then
				if not l_412_7 then
					l_412_0:print_error("Spawned mass unit must be enabled before trigger \"" .. tostring(l_412_24) .. "\" on it can be connected.", false, l_412_1)
				end
			else
				local l_412_25 = l_412_7:damage()
				if l_412_25 then
					if l_412_25._unit_element:has_trigger_name(l_412_24) then
						local l_412_26 = l_412_0:run_parsed_func(l_412_1, l_412_0._from_trigger_sequence)
						if l_412_26 and l_412_0._unit_element:get_sequence_element(l_412_26) then
							if not l_412_23 then
								l_412_23 = l_412_0:get_params(l_412_1)
							end
							l_412_7:damage():add_trigger_sequence(l_412_24, l_412_26, l_412_1.dest_unit, nil, nil, l_412_23, false)
						end
					else
						local l_412_27 = CoreSequenceManager:get_keys_as_string(l_412_0._unit_element:get_sequence_name_list(), "", true, true)
						l_412_0:print_attribute_error("from_trigger_sequence", l_412_26, l_412_27, true, l_412_1)
					end
				else
					local l_412_28 = CoreSequenceManager:get_keys_as_string(l_412_25._unit_element:get_trigger_name_map(), "", true, true)
					l_412_0:print_attribute_error("from_trigger", l_412_24, l_412_28, true, l_412_1)
				end
			else
				l_412_0:print_error("Unable to connect trigger \"" .. tostring(l_412_24) .. "\" on unit \"" .. tostring(l_412_7) .. "\" since it doesn't have a damage-extension.", true, l_412_1)
			end
			local l_412_29 = l_412_0:run_parsed_func(l_412_1, l_412_0._to_trigger)
			if l_412_29 then
				if not l_412_7 then
					l_412_0:print_error("Spawned mass unit must be enabled before trigger \"" .. tostring(l_412_29) .. "\" can be connected to a sequence on it.", false, l_412_1)
				end
			else
				local l_412_30 = l_412_7:damage()
				if l_412_30 then
					if l_412_0._unit_element:has_trigger_name(l_412_29) then
						local l_412_31 = l_412_0:run_parsed_func(l_412_1, l_412_0._to_trigger_sequence)
						if l_412_31 and l_412_30._unit_element:get_sequence_element(l_412_31) then
							if not l_412_23 then
								l_412_23 = l_412_0:get_params(l_412_1)
							end
							l_412_8:add_trigger_sequence(l_412_29, l_412_31, l_412_7, nil, nil, l_412_23, false)
						end
					else
						local l_412_32 = CoreSequenceManager:get_keys_as_string(l_412_30._unit_element:get_sequence_name_list(), "", true, true)
						l_412_0:print_attribute_error("to_trigger_sequence", l_412_31, l_412_32, true, l_412_1)
					end
				else
					local l_412_33 = CoreSequenceManager:get_keys_as_string(l_412_0._unit_element:get_trigger_name_map(), "", true, true)
					l_412_0:print_attribute_error("to_trigger", l_412_29, l_412_33, true, l_412_1)
				end
			else
				l_412_0:print_error("Unable to connect trigger \"" .. tostring(l_412_29) .. "\" on unit \"" .. tostring(l_412_7) .. "\" since it doesn't have a damage-extension.", true, l_412_1)
			end
			local l_412_34 = l_412_0:run_parsed_func(l_412_1, l_412_0._inherit_destroy)
			if l_412_34 then
				if not l_412_7 then
					l_412_0:print_error("Spawned mass unit must be enabled if \"inherit_destroy\"-attribute is used.", false, l_412_1)
				end
			end
		else
			l_412_8:add_inherit_destroy_unit(l_412_7)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 297 
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreSpawnUnitElement
l_0_3 = "get_params"
l_0_0[l_0_3] = function(l_413_0, l_413_1)
	local l_413_6, l_413_7, l_413_8, l_413_9 = nil
	local l_413_2 = clone(l_413_1.params)
	for i_0,i_1 in pairs(l_413_0._params) do
		l_413_2[i_0] = l_413_0:run_parsed_func(l_413_1, i_1)
	end
	l_413_2.spawn_unit = l_413_1.dest_unit
	return l_413_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0 = CoreStopPhysicEffectElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreStopPhysicEffectElement = l_0_0
l_0_0 = CoreStopPhysicEffectElement
l_0_3 = "stop_physic_effect"
l_0_0.NAME = l_0_3
l_0_0 = CoreStopPhysicEffectElement
l_0_3 = function(l_414_0, l_414_1, l_414_2)
	CoreBaseElement.init(l_414_0, l_414_1, l_414_2)
	l_414_0._id = l_414_0:get("id")
end

l_0_0.init = l_0_3
l_0_0 = CoreStopPhysicEffectElement
l_0_3 = function(l_415_0, l_415_1)
	local l_415_2 = l_415_0:run_parsed_func(l_415_1, l_415_0._id)
	if not l_415_2 then
		l_415_0:print_attribute_error("id", l_415_2, nil, true, l_415_1)
	else
		World:stop_physic_effect(l_415_2)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreTriggerElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreTriggerElement = l_0_0
l_0_0 = CoreTriggerElement
l_0_3 = "trigger"
l_0_0.NAME = l_0_3
l_0_0 = CoreTriggerElement
l_0_3 = function(l_416_0, l_416_1, l_416_2)
	CoreBaseElement.init(l_416_0, l_416_1, l_416_2)
	l_416_0._name = l_416_0:get("name")
end

l_0_0.init = l_0_3
l_0_0 = CoreTriggerElement
l_0_3 = function(l_417_0, l_417_1)
	local l_417_2 = l_417_0:run_parsed_func(l_417_1, l_417_0._name)
	l_417_1.dest_unit:damage():activate_trigger(l_417_2, l_417_1)
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreVolumeSetElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreVolumeSetElement = l_0_0
l_0_0 = CoreVolumeSetElement
l_0_3 = "volume_set"
l_0_0.NAME = l_0_3
l_0_0 = CoreVolumeSetElement
l_0_3 = function(l_418_0, l_418_1, l_418_2)
	CoreBaseElement.init(l_418_0, l_418_1, l_418_2)
	l_418_0._name = l_418_0:get("name")
	l_418_0._activate = l_418_0:get("activate")
	l_418_0._position = l_418_0:get("position")
end

l_0_0.init = l_0_3
l_0_0 = CoreVolumeSetElement
l_0_3 = function(l_419_0, l_419_1)
	local l_419_2 = l_419_0:run_parsed_func(l_419_1, l_419_0._name)
	if not l_419_2 then
		l_419_0:print_attribute_error("name", l_419_2, nil, true, l_419_1)
	else
		local l_419_3 = l_419_0:run_parsed_func(l_419_1, l_419_0._activate)
		if l_419_3 or l_419_3 == nil then
			local l_419_4 = l_419_0:run_parsed_func(l_419_1, l_419_0._position)
			managers.volume:activate_set(l_419_2, l_419_4)
		end
	else
		managers.volume:deactivate_set(l_419_2)
	end
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreWheelRadiusElement
if not l_0_0 then
	l_0_0 = class
	l_0_3 = CoreBaseElement
	l_0_0 = l_0_0(l_0_3)
end
CoreWheelRadiusElement = l_0_0
l_0_0 = CoreWheelRadiusElement
l_0_3 = "wheel_radius"
l_0_0.NAME = l_0_3
l_0_0 = CoreWheelRadiusElement
l_0_3 = function(l_420_0, l_420_1, l_420_2)
	CoreBaseElement.init(l_420_0, l_420_1, l_420_2)
	l_420_0._wheel = l_420_0:get("wheel")
	l_420_0._radius = l_420_0:get("radius")
end

l_0_0.init = l_0_3
l_0_0 = CoreWheelRadiusElement
l_0_3 = function(l_421_0, l_421_1)
	local l_421_2 = l_421_0:run_parsed_func(l_421_1, l_421_0._wheel)
	local l_421_3 = l_421_0:run_parsed_func(l_421_1, l_421_0._radius)
	l_421_1.dest_unit:vehicle():set_wheel_radius(l_421_2, l_421_3)
	if l_421_0.SAVE_STATE then
		local l_421_4, l_421_5 = l_421_0:set_state, l_421_0
		local l_421_6 = l_421_1.dest_unit
		local l_421_7 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_421_4(l_421_5, l_421_6, l_421_7)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0.activate_callback = l_0_3
l_0_0 = CoreWheelRadiusElement
l_0_3 = function(l_422_0, l_422_1)
	if l_422_0:vehicle() then
		l_422_0:vehicle():set_wheel_radius(l_422_1[1], l_422_1[2])
	else
		self:print_error("Unable to load vehicle wheel radius on unit \"" .. tostring(l_422_0:name()) .. " because the vehicle didn't exist.", true, nil)
	end
end

l_0_0.load = l_0_3

