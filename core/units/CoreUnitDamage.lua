if not CoreUnitDamage then
	CoreUnitDamage = class()
end
if not UnitDamage then
	UnitDamage = class(CoreUnitDamage)
end
CoreUnitDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0._unit = l_1_1
	local l_1_10 = managers.sequence:get
	local l_1_11 = managers.sequence
	l_1_10 = l_1_10(l_1_11, l_1_1:name(), false, true)
	l_1_0._unit_element = l_1_10
	l_1_0._damage = 0
	l_1_0._variables, l_1_10 = l_1_10, {}
	l_1_10 = l_1_0._unit_element
	if l_1_10 then
		l_1_10 = pairs
		l_1_11 = l_1_0._unit_element
		l_1_11 = l_1_11._set_variables
		l_1_10 = l_1_10(l_1_11)
		for i_0,i_1 in l_1_10 do
			l_1_0._variables[l_1_8] = l_1_9
		end
	end
	l_1_0._unit:set_extension_update_enabled("damage", l_1_0._update_func_map ~= nil)
	for i_0,i_1 in pairs(l_1_0._unit_element:get_proximity_element_map()) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if i_1:get_ref_object() then
			{name = i_0, enabled = i_1:get_enabled(), ref_object = l_1_0._unit:get_object(i_1:get_ref_object()), interval = i_1:get_interval(), quick = i_1:is_quick(), is_within = i_1:get_start_within(), slotmask = i_1:get_slotmask()}.last_check_time = TimerManager:game():time() + math.rand(math.min(({name = i_0, enabled = i_1:get_enabled(), ref_object = l_1_0._unit:get_object(i_1:get_ref_object()), interval = i_1:get_interval(), quick = i_1:is_quick(), is_within = i_1:get_start_within(), slotmask = i_1:get_slotmask()}).interval, 0))
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_1_0:populate_proximity_range_data({name = i_0, enabled = i_1:get_enabled(), ref_object = l_1_0._unit:get_object(i_1:get_ref_object()), interval = i_1:get_interval(), quick = i_1:is_quick(), is_within = i_1:get_start_within(), slotmask = i_1:get_slotmask()}, "within_data", i_1:get_within_element())
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_1_0:populate_proximity_range_data({name = i_0, enabled = i_1:get_enabled(), ref_object = l_1_0._unit:get_object(i_1:get_ref_object()), interval = i_1:get_interval(), quick = i_1:is_quick(), is_within = i_1:get_start_within(), slotmask = i_1:get_slotmask()}, "outside_data", i_1:get_outside_element())
			if not l_1_0._proximity_map then
				l_1_0._proximity_map = {}
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_1_0._proximity_map[i_0] = {name = i_0, enabled = i_1:get_enabled(), ref_object = l_1_0._unit:get_object(i_1:get_ref_object()), interval = i_1:get_interval(), quick = i_1:is_quick(), is_within = i_1:get_start_within(), slotmask = i_1:get_slotmask()}
			l_1_0._proximity_count = (l_1_0._proximity_count or 0) + 1
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if ({name = i_0, enabled = i_1:get_enabled(), ref_object = l_1_0._unit:get_object(i_1:get_ref_object()), interval = i_1:get_interval(), quick = i_1:is_quick(), is_within = i_1:get_start_within(), slotmask = i_1:get_slotmask()}).enabled then
				if not l_1_0._proximity_enabled_count then
					l_1_0._proximity_enabled_count = 0
					l_1_0:set_update_callback("update_proximity_list", true)
				end
				l_1_0._proximity_enabled_count = l_1_0._proximity_enabled_count + 1
			end
		end
		local l_1_14 = .end
		for i_0 in pairs(l_1_0._unit_element:get_trigger_name_map(), l_1_14) do
			if not l_1_0._trigger_func_list then
				l_1_0._trigger_func_list = {}
			end
			l_1_0._trigger_func_list[l_1_13] = {}
		end
		l_1_0._mover_collision_ignore_duration = l_1_6
		if l_1_0._unit_element then
			if not l_1_3 then
				l_1_3 = {}
			end
			if not l_1_2 then
				l_1_2 = CoreBodyDamage
			end
			for i_0,i_1 in pairs(l_1_0._unit_element._bodies) do
				if l_1_0._unit:body(i_1._name) then
					if not l_1_0._unit:body(i_1._name):extension() then
						l_1_0._unit:body(i_1._name):set_extension({})
					end
					do
						local l_1_22 = nil
						for i_0,i_1 in pairs(l_1_3[i_1._name] or l_1_2:new(l_1_0._unit, l_1_0, l_1_0._unit:body(i_1._name), i_1):get_endurance_map()) do
							local l_1_18, l_1_19 = , nil
							if get_core_or_local("InflictUpdator").INFLICT_UPDATOR_DAMAGE_TYPE_MAP[i_1] then
								if l_1_19 or not l_1_0._added_inflict_updator_damage_type_map then
									managers.sequence:add_inflict_updator_body(i_1, l_1_0._unit:key(), l_1_19, l_1_18)
								end
							end
					end
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Confused about usage of registers!

					else
						Application:throw_exception("Unit \"" .. l_1_0._unit:name() .. "\" doesn't have the body \"" .. l_1_21._name .. "\" that was loaded into the SequenceManager.")
					end
				end
			else
				Application:throw_exception("Unit \"" .. l_1_0._unit:name() .. "\" had damage extension but didn't have a <sequence_manager> in its model.xml file.")
			end
			if not l_1_4 then
				l_1_0._unit:set_body_collision_callback(callback(l_1_0, l_1_0, "body_collision_callback"))
			end
			if l_1_0._unit:mover() and not l_1_5 then
				l_1_0._unit:set_mover_collision_callback(callback(l_1_0, l_1_0, "mover_collision_callback"))
			end
			l_1_0._water_check_element_map = l_1_0._unit_element:get_water_element_map()
			if l_1_0._water_check_element_map then
				for i_0,i_1 in pairs(l_1_0._water_check_element_map) do
					l_1_0:set_water_check(i_0, i_1:get_enabled(), i_1:get_interval(), i_1:get_ref_object(), i_1:get_ref_body(), i_1:get_body_depth(), i_1:get_physic_effect())
				end
			end
			l_1_0._startup_sequence_map = l_1_0._unit_element:get_startup_sequence_map(l_1_0._unit, l_1_0)
			if l_1_0._startup_sequence_map then
				l_1_0._startup_sequence_callback_id = managers.sequence:add_time_callback(callback(l_1_0, l_1_0, "run_startup_sequences"))
			end
			if Application:editor() then
				l_1_0._editor_startup_sequence_map = l_1_0._unit_element:get_editor_startup_sequence_map(l_1_0._unit, l_1_0)
			if l_1_0._editor_startup_sequence_map then
				end
				l_1_0._editor_startup_sequence_callback_id = managers.sequence:add_time_callback(callback(l_1_0, l_1_0, "run_editor_startup_sequences"))
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 55 208 
end

CoreUnitDamage.destroy = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_13, l_2_14 = nil
	if l_2_0._added_inflict_updator_damage_type_map then
		local l_2_1 = l_2_0._unit:key()
		for l_2_18,l_2_19 in pairs(l_2_0._added_inflict_updator_damage_type_map) do
			local l_2_23, l_2_25, l_2_27 = nil
			l_2_23 = pairs
			l_2_25 = l_2_19
			l_2_23 = l_2_23(l_2_25)
			for i_0 in l_2_23 do
				local l_2_11, l_2_12 = nil
				l_2_11 = managers
				l_2_11 = l_2_11.sequence
				l_2_11, l_2_12 = l_2_11:remove_inflict_updator_body, l_2_11
				l_2_11(l_2_12, l_2_18, l_2_1, l_2_10)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_2_1 = l_2_0._water_check_map
	if l_2_1 then
		l_2_1 = pairs
		l_2_1 = l_2_1(l_2_0._water_check_map)
		for i_0 in l_2_1 do
			local l_2_16, l_2_17 = nil
			l_2_16, l_2_17 = l_2_0:set_water_check_active, l_2_0
			local l_2_24, l_2_26, l_2_28 = nil
			l_2_24 = 
			l_2_26 = false
			l_2_16(l_2_17, l_2_24, l_2_26)
		end
	end
	if l_2_0._inherit_destroy_unit_list then
		for i_0,i_1 in ipairs(l_2_0._inherit_destroy_unit_list) do
			local l_2_22 = nil
			l_2_22 = alive
			l_2_22 = l_2_22(l_2_21)
			if l_2_22 then
				l_2_22(l_2_21, 0)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitDamage.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_7, l_3_8, l_3_9, l_3_10, l_3_11 = nil
	if l_3_0._update_func_map then
		for i_0,i_1 in pairs(l_3_0._update_func_map) do
			l_3_0[i_0](l_3_0, l_3_1, l_3_2, l_3_3, i_1)
		end
	else
		Application:error("Some scripter tried to enable the damage extension on unit \"" .. tostring(l_3_1:name()) .. "\" or an artist have specified more than one damage-extension in the unit xml. This would have resulted in a crash, so fix it!")
		l_3_0._unit:set_extension_update_enabled("damage", false)
	end
end

CoreUnitDamage.set_update_callback = function(l_4_0, l_4_1, l_4_2)
	if l_4_2 then
		if not l_4_0._update_func_map then
			l_4_0._update_func_map = {}
		end
		if not l_4_0._update_func_map[l_4_1] then
			if not l_4_0._update_func_count then
				l_4_0._update_func_count = 0
				l_4_0._unit:set_extension_update_enabled("damage", true)
			end
			l_4_0._update_func_count = l_4_0._update_func_count + 1
		end
		l_4_0._update_func_map[l_4_1] = l_4_2
	elseif l_4_0._update_func_map and l_4_0._update_func_map[l_4_1] then
		l_4_0._update_func_count = l_4_0._update_func_count - 1
		l_4_0._update_func_map[l_4_1] = nil
	if l_4_0._update_func_count == 0 then
		end
		l_4_0._unit:set_extension_update_enabled("damage", false)
		l_4_0._update_func_map = nil
		l_4_0._update_func_count = nil
	end
end

CoreUnitDamage.populate_proximity_range_data = function(l_5_0, l_5_1, l_5_2, l_5_3)
	if l_5_3 then
		l_5_1[l_5_2] = {}
		l_5_1[l_5_2].element = l_5_3
		l_5_1[l_5_2].activation_count = 0
		l_5_1[l_5_2].max_activation_count = l_5_3:get_max_activation_count()
		l_5_1[l_5_2].delay = l_5_3:get_delay()
		l_5_1[l_5_2].range = l_5_3:get_range()
		l_5_1[l_5_2].count = l_5_3:get_count()
		local l_5_4 = l_5_1[l_5_2]
		l_5_4.is_within = l_5_2 == "within_data"
	end
end

CoreUnitDamage.set_proximity_enabled = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._proximity_map then
		local l_6_3, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8 = l_6_0._proximity_map[l_6_1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_6_3 and not l_6_3.enabled ~= not l_6_2 then
		l_6_3.enabled = l_6_2
		if l_6_2 then
			if not l_6_0._proximity_enabled_count then
				l_6_0:set_update_callback("update_proximity_list", true)
				l_6_0._proximity_enabled_count = 0
			end
			l_6_0._proximity_enabled_count = l_6_0._proximity_enabled_count + 1
		end
	else
		l_6_0._proximity_enabled_count = l_6_0._proximity_enabled_count - 1
	if l_6_0._proximity_enabled_count <= 0 then
		end
		l_6_0._proximity_enabled_count = nil
		l_6_0:set_update_callback("update_proximity_list", nil)
	end
end

CoreUnitDamage.update_proximity_list = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_7, l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13, l_7_14, l_7_15, l_7_16 = nil
	if managers.sequence:is_proximity_enabled() then
		for i_0,i_1 in pairs(l_7_0._proximity_map) do
			 -- DECOMPILER ERROR: Overwrote pending register.

			if i_1.enabled and i_1.last_check_time + i_1.interval <= l_7_2 then
				if l_7_18.is_within then
					if not nil then
						do return end
					end
				 -- DECOMPILER ERROR: Overwrote pending register.

				elseif not l_7_18.within_data then
					do return end
				end
			if l_7_0:check_proximity_activation_count(l_7_18) then
				end
			if l_7_18.last_check_time + l_7_18.outside_data.delay <= l_7_2 then
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_7_0:update_proximity(l_7_1, l_7_2, l_7_3, l_7_18, l_7_18.outside_data) ~= false then
				end
				l_7_18.last_check_time = l_7_2
				l_7_18.is_within = not l_7_18.is_within
				 -- DECOMPILER ERROR: Confused about usage of registers!

			if not false then
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_7_0:is_proximity_range_active(l_7_18.outside_data) then
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_7_18.outside_data.activation_count = l_7_18.outside_data.activation_count + 1
				if not l_7_0._proximity_env then
					l_7_0._proximity_env = SequenceEnvironment:new("proximity", l_7_0._unit, l_7_0._unit, nil, Vector3(0, 0, 0), Vector3(0, 0, 0), Vector3(0, 0, 0), 0, (Vector3(0, 0, 0)), nil, l_7_0._unit_element)
					 -- DECOMPILER ERROR: Confused about usage of registers!

				end
				l_7_18.outside_data.element:activate_elements(l_7_0._proximity_env)
				l_7_0:check_proximity_activation_count(l_7_18)
			end
		end
	end
end

CoreUnitDamage.is_proximity_range_active = function(l_8_0, l_8_1)
	do
		return not l_8_1 or l_8_1.max_activation_count < 0 or l_8_1.activation_count < l_8_1.max_activation_count
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitDamage.check_proximity_activation_count = function(l_9_0, l_9_1)
	if not l_9_0:is_proximity_range_active(l_9_1.within_data) and not l_9_0:is_proximity_range_active(l_9_1.outside_data) then
		l_9_0:set_proximity_enabled(l_9_1.name, false)
		return false
	else
		return true
	end
end

CoreUnitDamage.update_proximity = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5)
	local l_10_6 = nil
	if l_10_4.ref_object then
		l_10_6 = l_10_4.ref_object:position()
	else
		l_10_6 = l_10_0._unit:position()
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_10_5.quick then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if #nil > l_10_5.count then
		return (not l_10_4.is_within or l_10_5.is_within == l_10_4.is_within) and l_10_4.is_within or l_10_5.is_within ~= l_10_4.is_within
	end
	do return end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_10_5.count <= #nil
end

CoreUnitDamage.get_proximity_map = function(l_11_0)
	if not l_11_0._proximity_map then
		return {}
	end
end

CoreUnitDamage.set_proximity_slotmask = function(l_12_0, l_12_1, l_12_2)
	l_12_0._proximity_map[l_12_1].slotmask = l_12_2
end

CoreUnitDamage.set_proximity_ref_obj_name = function(l_13_0, l_13_1, l_13_2)
	local l_13_3 = l_13_0._proximity_map[l_13_1]
	do
		if l_13_2 then
			l_13_3.ref_object = l_13_0._unit:get_object(l_13_2)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitDamage.set_proximity_interval = function(l_14_0, l_14_1, l_14_2)
	l_14_0._proximity_map[l_14_1].interval = l_14_2
end

CoreUnitDamage.set_proximity_is_within = function(l_15_0, l_15_1, l_15_2)
	l_15_0._proximity_map[l_15_1].is_within = l_15_2
end

CoreUnitDamage.set_proximity_within_activations = function(l_16_0, l_16_1, l_16_2)
	local l_16_3 = l_16_0._proximity_map[l_16_1]
	local l_16_4 = l_16_3.within_data
	if l_16_4 then
		l_16_4.activations = l_16_2
		local l_16_5, l_16_6 = l_16_0:check_proximity_activation_count, l_16_0
		local l_16_7 = l_16_3
		return l_16_5(l_16_6, l_16_7)
	end
end

CoreUnitDamage.set_proximity_within_max_activations = function(l_17_0, l_17_1, l_17_2)
	local l_17_3 = l_17_0._proximity_map[l_17_1]
	local l_17_4 = l_17_3.within_data
	if l_17_4 then
		l_17_4.max_activations = l_17_2
		local l_17_5, l_17_6 = l_17_0:check_proximity_activation_count, l_17_0
		local l_17_7 = l_17_3
		return l_17_5(l_17_6, l_17_7)
	end
end

CoreUnitDamage.set_proximity_within_delay = function(l_18_0, l_18_1, l_18_2)
	local l_18_3 = l_18_0._proximity_map[l_18_1].within_data
	if l_18_3 then
		l_18_3.delay = l_18_2
	end
end

CoreUnitDamage.set_proximity_within_range = function(l_19_0, l_19_1, l_19_2)
	local l_19_3 = l_19_0._proximity_map[l_19_1].within_data
	if l_19_3 then
		l_19_3.range = l_19_2
	end
end

CoreUnitDamage.set_proximity_inside_count = function(l_20_0, l_20_1, l_20_2)
	local l_20_3 = l_20_0._proximity_map[l_20_1].within_data
	if l_20_3 then
		l_20_3.count = l_20_2
	end
end

CoreUnitDamage.set_proximity_outside_activations = function(l_21_0, l_21_1, l_21_2)
	local l_21_3 = l_21_0._proximity_map[l_21_1]
	local l_21_4 = l_21_3.outside_data
	if l_21_4 then
		l_21_4.activations = l_21_2
		local l_21_5, l_21_6 = l_21_0:check_proximity_activation_count, l_21_0
		local l_21_7 = l_21_3
		return l_21_5(l_21_6, l_21_7)
	end
end

CoreUnitDamage.set_proximity_outside_max_activations = function(l_22_0, l_22_1, l_22_2)
	local l_22_3 = l_22_0._proximity_map[l_22_1]
	local l_22_4 = l_22_3.outside_data
	if l_22_4 then
		l_22_4.max_activations = l_22_2
		local l_22_5, l_22_6 = l_22_0:check_proximity_activation_count, l_22_0
		local l_22_7 = l_22_3
		return l_22_5(l_22_6, l_22_7)
	end
end

CoreUnitDamage.set_proximity_outside_delay = function(l_23_0, l_23_1, l_23_2)
	local l_23_3 = l_23_0._proximity_map[l_23_1].outside_data
	if l_23_3 then
		l_23_3.delay = l_23_2
	end
end

CoreUnitDamage.set_proximity_outside_range = function(l_24_0, l_24_1, l_24_2)
	local l_24_3 = l_24_0._proximity_map[l_24_1].outside_data
	if l_24_3 then
		l_24_3.range = l_24_2
	end
end

CoreUnitDamage.set_proximity_outside_range = function(l_25_0, l_25_1, l_25_2)
	local l_25_3 = l_25_0._proximity_map[l_25_1].outside_data
	if l_25_3 then
		l_25_3.range = count
	end
end

CoreUnitDamage.get_water_check_map = function(l_26_0)
	return l_26_0._water_check_map
end

CoreUnitDamage.set_water_check = function(l_27_0, l_27_1, l_27_2, l_27_3, l_27_4, l_27_5, l_27_6, l_27_7)
	if not l_27_0._water_check_map then
		l_27_0._water_check_map = {}
	end
	local l_27_8 = l_27_0._water_check_map[l_27_1]
	do
		if (l_27_4 and not l_27_5) or not l_27_8 then
			l_27_8 = CoreDamageWaterCheck:new(l_27_0._unit, l_27_0, l_27_1, l_27_3, l_27_0._unit:get_object(l_27_4), l_27_0._unit:body(l_27_5), l_27_6, l_27_7)
			l_27_0._water_check_map[l_27_1] = l_27_8
		else
			l_27_8:set_interval(l_27_3)
			l_27_8:set_body_depth(l_27_6)
			if l_27_0._unit:get_object(l_27_4) then
				l_27_8:set_ref_object(l_27_0._unit:get_object(l_27_4))
			end
		elseif l_27_0._unit:body(l_27_5) then
			l_27_8:set_ref_body(l_27_0._unit:body(l_27_5))
		end
		l_27_0:set_water_check_active(l_27_1, l_27_2)
		if not l_27_8:is_valid() then
			Application:error("Invalid water check \"" .. tostring(l_27_1) .. "\" in unit \"" .. tostring(l_27_0._unit:name()) .. "\". Neither ref_body nor ref_object is speicified in it.")
			l_27_0:remove_water_check(l_27_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitDamage.remove_water_check = function(l_28_0, l_28_1)
	if l_28_0._water_check_map then
		local l_28_2 = l_28_0._water_check_map[l_28_1]
	if l_28_2 then
		end
		l_28_0:set_water_check_active(l_28_1, false)
		l_28_0._water_check_map[l_28_1] = nil
	end
end

CoreUnitDamage.exists_water_check = function(l_29_0, l_29_1)
	return not l_29_0._water_check_map or l_29_0._water_check_map[l_29_1] ~= nil
end

CoreUnitDamage.is_water_check_active = function(l_30_0, l_30_1)
	return not l_30_0._active_water_check_map or l_30_0._active_water_check_map[l_30_1] ~= nil
end

CoreUnitDamage.set_water_check_active = function(l_31_0, l_31_1, l_31_2)
	if l_31_0._water_check_map then
		local l_31_3, l_31_4, l_31_5, l_31_6, l_31_7, l_31_8, l_31_9, l_31_10, l_31_11 = l_31_0._water_check_map[l_31_1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_31_3 and l_31_2 and (not l_31_0._active_water_check_map or not l_31_0._active_water_check_map[l_31_1]) then
		if not l_31_0._active_water_check_map then
			l_31_0._active_water_check_map = {}
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_31_0._active_water_check_map[l_31_1] = l_31_3
		l_31_0._active_water_check_count = (l_31_0._active_water_check_count or 0) + 1
	if l_31_0._active_water_check_count == 1 then
		end
		l_31_0._water_check_func_id = managers.sequence:add_callback(callback(l_31_0, l_31_0, "update_water_checks"))
	end
	do return end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_31_3:set_activation_callbacks_enabled(false)
	if l_31_0._active_water_check_map and l_31_0._active_water_check_map[l_31_1] then
		l_31_0._active_water_check_map[l_31_1] = nil
		l_31_0._active_water_check_count = l_31_0._active_water_check_count - 1
	if l_31_0._active_water_check_count == 0 then
		end
		managers.sequence:remove_callback(l_31_0._water_check_func_id)
		l_31_0._water_check_func_id = nil
		l_31_0._active_water_check_map = nil
		l_31_0._active_water_check_count = nil
	end
end

CoreUnitDamage.update_water_checks = function(l_32_0, l_32_1, l_32_2)
	local l_32_6, l_32_7, l_32_8, l_32_9 = nil
	for i_0,i_1 in pairs(l_32_0._active_water_check_map) do
		i_1:update(l_32_1, l_32_2)
	end
end

CoreUnitDamage.water_check_enter = function(l_33_0, l_33_1, l_33_2, l_33_3, l_33_4, l_33_5, l_33_6, l_33_7, l_33_8, l_33_9, l_33_10)
	local l_33_11 = l_33_0._water_check_element_map[l_33_1]
	if l_33_11 then
		local l_33_12, l_33_13 = SequenceEnvironment:new, SequenceEnvironment
		local l_33_14 = "water"
		local l_33_15 = l_33_3
		local l_33_16 = l_33_0._unit
		local l_33_17 = l_33_4
		local l_33_18 = l_33_5
		local l_33_19 = l_33_6
		local l_33_20 = l_33_7
		local l_33_21 = l_33_8
		local l_33_22 = l_33_9
		local l_33_23 = {}
		l_33_23.water_depth = l_33_10
		l_33_12 = l_33_12(l_33_13, l_33_14, l_33_15, l_33_16, l_33_17, l_33_18, l_33_19, l_33_20, l_33_21, l_33_22, l_33_23, l_33_0._unit_element)
		l_33_13, l_33_14 = l_33_11:activate_enter, l_33_11
		l_33_15 = l_33_12
		l_33_13(l_33_14, l_33_15)
	end
end

CoreUnitDamage.water_check_exit = function(l_34_0, l_34_1, l_34_2, l_34_3, l_34_4, l_34_5, l_34_6, l_34_7, l_34_8, l_34_9, l_34_10)
	local l_34_11 = l_34_0._water_check_element_map[l_34_1]
	if l_34_11 then
		local l_34_12, l_34_13 = SequenceEnvironment:new, SequenceEnvironment
		local l_34_14 = "water"
		local l_34_15 = l_34_3
		local l_34_16 = l_34_0._unit
		local l_34_17 = l_34_4
		local l_34_18 = l_34_5
		local l_34_19 = l_34_6
		local l_34_20 = l_34_7
		local l_34_21 = l_34_8
		local l_34_22 = l_34_9
		local l_34_23 = {}
		l_34_23.water_depth = l_34_10
		l_34_12 = l_34_12(l_34_13, l_34_14, l_34_15, l_34_16, l_34_17, l_34_18, l_34_19, l_34_20, l_34_21, l_34_22, l_34_23, l_34_0._unit_element)
		l_34_13, l_34_14 = l_34_11:activate_exit, l_34_11
		l_34_15 = l_34_12
		l_34_13(l_34_14, l_34_15)
	end
end

CoreUnitDamage.save = function(l_35_0, l_35_1)
	local l_35_7, l_35_8, l_35_12, l_35_13, l_35_17, l_35_18, l_35_19, l_35_20, l_35_21, l_35_22, l_35_23, l_35_24, l_35_25, l_35_26, l_35_27, l_35_28, l_35_29, l_35_30, l_35_31, l_35_32, l_35_36, l_35_37, l_35_38, l_35_39, l_35_40, l_35_43, l_35_44, l_35_45, l_35_46, l_35_47, l_35_48, l_35_49, l_35_50, l_35_51, l_35_52, l_35_53, l_35_54, l_35_55, l_35_56, l_35_57, l_35_58, l_35_59, l_35_60, l_35_66, l_35_67, l_35_68 = nil
	local l_35_2 = {}
	local l_35_3 = false
	if l_35_0._runned_sequences then
		for i_0,i_1 in pairs(l_35_0._runned_sequences) do
			l_35_2.runned_sequences = table.map_copy(l_35_0._runned_sequences)
			l_35_3 = true
		end
		do return end
	end
	if l_35_0._state then
		for i_0,i_1 in pairs(l_35_0._state) do
			l_35_2.state = deep_clone(l_35_0._state)
			l_35_3 = true
		end
		do return end
	end
	if l_35_0._damage ~= 0 then
		l_35_2.damage = l_35_0._damage
		l_35_3 = true
	end
	for i_0,i_1 in pairs(l_35_0._variables) do
		if l_35_0._unit_element._set_variables[i_0] ~= i_1 and (i_0 ~= "damage" or i_1 ~= l_35_0._damage) then
			l_35_2.variables = table.map_copy(l_35_0._variables)
			l_35_3 = true
	else
		end
	end
	if l_35_0._proximity_count then
		l_35_3 = true
		l_35_2.proximity_count = l_35_0._proximity_count
		l_35_2.proximity_enabled_count = l_35_0._proximity_enabled_count
		if not l_35_0._proximity_map then
			for i_0,i_1 in pairs({}) do
			end
			if not l_35_2.proximity_map then
				l_35_2.proximity_map = {}
			end
			l_35_2.proximity_map[i_0] = {}
			for i_0,i_1 in pairs(i_1) do
				do
					if i_0 == "ref_object" then
						if i_1 then
							l_35_2.proximity_map[l_35_33][i_0] = i_1:name()
					else
						end
						if i_0 == "slotmask" then
							local l_35_64, l_35_65 = nil
							l_35_2.proximity_map[l_35_33][i_0] = managers.slot:get_mask_name(i_1)
						end
					elseif i_0 == "last_check_time" then
						l_35_2.proximity_map[l_35_33][i_0] = TimerManager:game():time() - i_1
					elseif i_0 == "within_data" or i_0 == "outside_data" then
						l_35_2.proximity_map[l_35_33][i_0] = {}
						for i_0,i_1 in pairs(i_1) do
							local l_35_61, l_35_62 = nil
							if i_0 ~= "element" then
								l_35_2.proximity_map[l_35_33][i_0][i_0] = i_1
							end
						end
					else
						l_35_2.proximity_map[l_35_33][i_0] = i_1
					end
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
			end
		end
	end
	local l_35_69, l_35_70 = .end
	for l_35_70,i_1 in ipairs(l_35_0._unit:anim_groups(), l_35_69, l_35_70) do
		if #i_1 > 0 then
			if not l_35_2.anim then
				l_35_2.anim = {}
			end
			l_35_2.anim[i_1] = l_35_0._unit:anim_time(i_1)
			l_35_3 = true
		end
	end
	if l_35_0._unit_element:save_by_unit(l_35_0._unit, l_35_2) or l_35_3 then
		l_35_1.CoreUnitDamage = l_35_2
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitDamage.get_unit_element = function(l_36_0)
	return l_36_0._unit_element
end

CoreUnitDamage.load = function(l_37_0, l_37_1)
	local l_37_6, l_37_7, l_37_8, l_37_9, l_37_10, l_37_11, l_37_15, l_37_16, l_37_17, l_37_18, l_37_19, l_37_22, l_37_23, l_37_24, l_37_25, l_37_26, l_37_27, l_37_28, l_37_29, l_37_30, l_37_31, l_37_32, l_37_33, l_37_34, l_37_35, l_37_36, l_37_37, l_37_38, l_37_43, l_37_44, l_37_45, l_37_51, l_37_53, l_37_59, l_37_61 = nil
	local l_37_2 = l_37_1.CoreUnitDamage
	if l_37_0._startup_sequence_callback_id then
		managers.sequence:remove_time_callback(l_37_0._startup_sequence_callback_id)
		l_37_0:run_startup_sequences()
	end
	if l_37_0._editor_startup_sequence_callback_id then
		managers.sequence:remove_time_callback(l_37_0._editor_startup_sequence_callback_id)
		l_37_0:run_editor_startup_sequences()
	end
	if l_37_2 then
		if l_37_2.runned_sequences then
			l_37_0._runned_sequences = table.map_copy(l_37_2.runned_sequences)
		end
		if l_37_2.state then
			l_37_0._state = deep_clone(l_37_2.state)
		end
		if not l_37_2.damage then
			l_37_0._damage = l_37_0._damage
		end
		if l_37_2.variables then
			l_37_0._variables = table.map_copy(l_37_2.variables)
		end
		if l_37_2.proximity_map then
			l_37_0._proximity_count = l_37_2.proximity_count
			l_37_0._proximity_enabled_count = l_37_2.proximity_enabled_count
			for i_0,i_1 in pairs(l_37_2.proximity_map) do
				if not l_37_0._proximity_map then
					l_37_0._proximity_map = {}
				end
				for i_0,i_1 in pairs(i_1) do
					if i_0 == "ref_object" then
						if i_1 then
							l_37_0._proximity_map[l_37_12][i_0] = l_37_0._unit:get_object(i_1)
					else
						end
						if i_0 == "slotmask" then
							local l_37_42 = nil
							l_37_0._proximity_map[l_37_12][i_0] = managers.slot:get_mask(i_1)
						end
					elseif i_0 == "last_check_time" then
						l_37_0._proximity_map[l_37_12][i_0] = TimerManager:game():time() - i_1
					elseif i_0 == "within_data" or i_0 == "outside_data" then
						for i_0,i_1 in pairs(i_1) do
							local l_37_39, l_37_40 = nil
							l_37_0._proximity_map[l_37_12][i_0][i_0] = i_1
						end
					else
						l_37_0._proximity_map[l_37_12][i_0] = i_1
					end
				end
			end
		if l_37_0._proximity_enabled_count then
			end
			do
				local l_37_49, l_37_50, l_37_52, l_37_57, l_37_58, l_37_60 = "update_proximity_list", true
				l_37_0:set_update_callback(l_37_49, l_37_50)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		if l_37_2.anim then
			for i_0,i_1 in pairs(l_37_2.anim) do
				l_37_0._unit:anim_set_time(l_37_48, i_1)
			end
		end
		if l_37_0._state then
			for i_0,i_1 in pairs(l_37_0._state) do
				managers.sequence:load_element_data(l_37_0._unit, l_37_56, i_1)
			end
		end
		l_37_0._unit_element:load_by_unit(l_37_0._unit, l_37_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitDamage.run_startup_sequences = function(l_38_0)
	local l_38_5, l_38_6 = nil
	local l_38_1 = Vector3(0, 0, 0)
	l_38_0._startup_sequence_callback_id = nil
	for i_0 in pairs(l_38_0._startup_sequence_map) do
		if alive(l_38_0._unit) then
			managers.sequence:run_sequence(i_0, "startup", l_38_0._unit, l_38_0._unit, nil, l_38_1, l_38_1, l_38_1, 0, l_38_1)
		else
			do return end
		end
	end
end

CoreUnitDamage.run_editor_startup_sequences = function(l_39_0)
	local l_39_5, l_39_6 = nil
	local l_39_1 = Vector3(0, 0, 0)
	l_39_0._editor_startup_sequence_callback_id = nil
	for i_0 in pairs(l_39_0._editor_startup_sequence_map) do
		if alive(l_39_0._unit) then
			managers.sequence:run_sequence(i_0, "editor_startup", l_39_0._unit, l_39_0._unit, nil, l_39_1, l_39_1, l_39_1, 0, l_39_1)
		else
			do return end
		end
	end
end

CoreUnitDamage.remove_trigger_func = function(l_40_0, l_40_1, l_40_2, l_40_3)
	local l_40_7, l_40_8, l_40_9, l_40_10, l_40_11 = nil
	if l_40_0:verify_trigger_name(l_40_1) then
		l_40_0._trigger_func_list[l_40_1][l_40_2] = nil
	if l_40_3 then
		end
		for i_0,i_1 in ipairs(l_40_0._editor_trigger_data) do
			if i_1.id == l_40_2 then
				table.remove(l_40_0._editor_trigger_data, i_0)
			end
	else
		end
	end
end

CoreUnitDamage.clear_trigger_func_list = function(l_41_0, l_41_1, l_41_2)
	if l_41_1 and l_41_0._trigger_func_list then
		l_41_0._trigger_func_list[l_41_1] = {}
		if l_41_0._editor_trigger_data then
			for l_41_6 = #l_41_0._editor_trigger_data, 1 do
				local l_41_7 = l_41_0._editor_trigger_data[l_41_6]
				if l_41_7.trigger_name == l_41_1 then
					table.remove(l_41_0._editor_trigger_data, l_41_6)
				end
			end
		end
	else
		l_41_0._editor_trigger_data = nil
	end
end

CoreUnitDamage.add_trigger_sequence = function(l_42_0, l_42_1, l_42_2, l_42_3, l_42_4, l_42_5, l_42_6, l_42_7)
	l_42_0._last_trigger_id = (l_42_0._last_trigger_id or 0) + 1
	local l_42_8, l_42_9 = l_42_0:set_trigger_sequence, l_42_0
	local l_42_10 = l_42_0._last_trigger_id
	local l_42_11 = l_42_1
	local l_42_12 = l_42_2
	local l_42_13 = l_42_3
	local l_42_14 = l_42_4
	local l_42_15 = l_42_5
	local l_42_16 = l_42_6
	local l_42_17 = l_42_7
	return l_42_8(l_42_9, l_42_10, l_42_11, l_42_12, l_42_13, l_42_14, l_42_15, l_42_16, l_42_17)
end

CoreUnitDamage.set_trigger_sequence_name = function(l_43_0, l_43_1, l_43_2, l_43_3)
	local l_43_7, l_43_8, l_43_9, l_43_10, l_43_11, l_43_12, l_43_13, l_43_14, l_43_15, l_43_16, l_43_17, l_43_18 = nil
	if l_43_0._trigger_func_list and l_43_0._trigger_func_list[l_43_2][l_43_1] then
		for i_0,i_1 in ipairs(l_43_0._editor_trigger_data) do
			if i_1.id == l_43_1 then
				local l_43_21 = l_43_0:set_trigger_sequence
				local l_43_22 = l_43_0
				local l_43_23 = l_43_1
				local l_43_24 = l_43_2
				local l_43_25 = l_43_3
				local l_43_26 = l_43_20.notify_unit
				local l_43_27 = l_43_20.time
				local l_43_28 = l_43_20.repeat_nr
				return l_43_21(l_43_22, l_43_23, l_43_24, l_43_25, l_43_26, l_43_27, l_43_28, l_43_20.params, true)
			end
		end
	end
	return nil
end

CoreUnitDamage.set_trigger_sequence_unit = function(l_44_0, l_44_1, l_44_2, l_44_3)
	local l_44_7, l_44_8, l_44_9, l_44_10, l_44_11, l_44_12, l_44_13, l_44_14, l_44_15, l_44_16, l_44_17, l_44_18 = nil
	if l_44_0._trigger_func_list and l_44_0._trigger_func_list[l_44_2][l_44_1] then
		for i_0,i_1 in ipairs(l_44_0._editor_trigger_data) do
			if i_1.id == l_44_1 then
				local l_44_21 = l_44_0:set_trigger_sequence
				local l_44_22 = l_44_0
				local l_44_23 = l_44_1
				local l_44_24 = l_44_2
				local l_44_25 = l_44_20.notify_unit_sequence
				local l_44_26 = l_44_3
				local l_44_27 = l_44_20.time
				local l_44_28 = l_44_20.repeat_nr
				return l_44_21(l_44_22, l_44_23, l_44_24, l_44_25, l_44_26, l_44_27, l_44_28, l_44_20.params, true)
			end
		end
	end
	return nil
end

CoreUnitDamage.set_trigger_sequence_time = function(l_45_0, l_45_1, l_45_2, l_45_3)
	local l_45_7, l_45_8, l_45_9, l_45_10, l_45_11, l_45_12, l_45_13, l_45_14, l_45_15, l_45_16, l_45_17, l_45_18 = nil
	if l_45_0._trigger_func_list and l_45_0._trigger_func_list[l_45_2][l_45_1] then
		for i_0,i_1 in ipairs(l_45_0._editor_trigger_data) do
			if i_1.id == l_45_1 then
				local l_45_21 = l_45_0:set_trigger_sequence
				local l_45_22 = l_45_0
				local l_45_23 = l_45_1
				local l_45_24 = l_45_2
				local l_45_25 = l_45_20.notify_unit_sequence
				local l_45_26 = l_45_20.notify_unit
				local l_45_27 = l_45_3
				local l_45_28 = l_45_20.repeat_nr
				return l_45_21(l_45_22, l_45_23, l_45_24, l_45_25, l_45_26, l_45_27, l_45_28, l_45_20.params, true)
			end
		end
	end
	return nil
end

CoreUnitDamage.set_trigger_sequence_repeat_nr = function(l_46_0, l_46_1, l_46_2, l_46_3)
	local l_46_7, l_46_8, l_46_9, l_46_10, l_46_11, l_46_12, l_46_13, l_46_14, l_46_15, l_46_16, l_46_17, l_46_18 = nil
	if l_46_0._trigger_func_list and l_46_0._trigger_func_list[l_46_2][l_46_1] then
		for i_0,i_1 in ipairs(l_46_0._editor_trigger_data) do
			if i_1.id == l_46_1 then
				local l_46_21 = l_46_0:set_trigger_sequence
				local l_46_22 = l_46_0
				local l_46_23 = l_46_1
				local l_46_24 = l_46_2
				local l_46_25 = l_46_20.notify_unit_sequence
				local l_46_26 = l_46_20.notify_unit
				local l_46_27 = l_46_20.time
				local l_46_28 = l_46_3
				return l_46_21(l_46_22, l_46_23, l_46_24, l_46_25, l_46_26, l_46_27, l_46_28, l_46_20.params, true)
			end
		end
	end
	return nil
end

CoreUnitDamage.set_trigger_sequence_params = function(l_47_0, l_47_1, l_47_2, l_47_3)
	local l_47_7, l_47_8, l_47_9, l_47_10, l_47_11, l_47_12, l_47_13, l_47_14, l_47_15, l_47_16, l_47_17, l_47_18 = nil
	if l_47_0._trigger_func_list and l_47_0._trigger_func_list[l_47_2][l_47_1] then
		for i_0,i_1 in ipairs(l_47_0._editor_trigger_data) do
			if i_1.id == l_47_1 then
				local l_47_21 = l_47_0:set_trigger_sequence
				local l_47_22 = l_47_0
				local l_47_23 = l_47_1
				local l_47_24 = l_47_2
				local l_47_25 = l_47_20.notify_unit_sequence
				local l_47_26 = l_47_20.notify_unit
				local l_47_27 = l_47_20.time
				local l_47_28 = l_47_20.repeat_nr
				return l_47_21(l_47_22, l_47_23, l_47_24, l_47_25, l_47_26, l_47_27, l_47_28, l_47_3, true)
			end
		end
	end
	return nil
end

CoreUnitDamage.set_trigger_sequence = function(l_48_0, l_48_1, l_48_2, l_48_3, l_48_4, l_48_5, l_48_6, l_48_7, l_48_8)
	local l_48_14, l_48_15, l_48_16, l_48_17 = nil
	if l_48_8 then
		local l_48_10 = function(l_49_0)
		-- upvalues: l_48_7 , l_48_3 , l_48_0 , l_48_4
		local l_49_4, l_49_5, l_49_9, l_49_10 = nil
		if l_49_0 and l_48_7 and getmetatable(l_49_0) ~= SequenceEnvironment then
			if getmetatable(l_48_7) == SequenceEnvironment then
				for i_0,i_1 in pairs(l_49_0) do
					l_48_7.params[i_0] = i_1
				end
			else
				for i_0,i_1 in pairs(l_49_0) do
					l_48_7[i_0] = i_1
				end
			end
		else
			l_48_7 = l_49_0
		end
		if getmetatable(l_48_7) == SequenceEnvironment then
			managers.sequence:run_sequence(l_48_3, "trigger", l_48_0._unit, l_48_4, nil, l_48_7.dest_normal, l_48_7.pos, l_48_7.dir, l_48_7.damage, l_48_7.velocity, l_48_7.params)
		else
			managers.sequence:run_sequence_simple3(managers.sequence, l_48_3, "trigger", l_48_0._unit, l_48_4, l_48_7)
		end
  end
		if (l_48_0._editor_trigger_data or l_48_0._trigger_func_list) and l_48_0._trigger_func_list[l_48_2] and l_48_0._trigger_func_list[l_48_2][l_48_1] then
			for i_0,i_1 in ipairs(l_48_0._editor_trigger_data) do
				local l_48_11 = nil
				if i_1.id == l_48_1 then
					l_48_11 = i_1
				end
		else
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if not l_48_11 then
			table.insert(l_48_0._editor_trigger_data, {})
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		{}.id = l_48_1
		 -- DECOMPILER ERROR: Confused about usage of registers!

		{}.trigger_name = l_48_2
		 -- DECOMPILER ERROR: Confused about usage of registers!

		{}.notify_unit_sequence = l_48_3
		 -- DECOMPILER ERROR: Confused about usage of registers!

		{}.notify_unit = l_48_4
		 -- DECOMPILER ERROR: Confused about usage of registers!

		{}.time = l_48_5
		 -- DECOMPILER ERROR: Confused about usage of registers!

		{}.repeat_nr = l_48_6
		 -- DECOMPILER ERROR: Confused about usage of registers!

		{}.params = l_48_7
	end
	local l_48_18, l_48_19 = , l_48_0:set_trigger_func
	local l_48_20 = l_48_0
	local l_48_21 = l_48_1
	local l_48_22 = l_48_2
	local l_48_23 = l_48_18
	local l_48_24 = l_48_5
	do
		local l_48_25 = l_48_6
		return l_48_19(l_48_20, l_48_21, l_48_22, l_48_23, l_48_24, l_48_25, l_48_8)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitDamage.get_editor_trigger_data = function(l_49_0)
	if l_49_0._editor_trigger_data then
		for l_49_4 = #l_49_0._editor_trigger_data, 1, -1 do
			local l_49_5 = l_49_0._editor_trigger_data[l_49_4]
			if not alive(l_49_5.notify_unit) then
				l_49_0:remove_trigger_func(l_49_5.trigger_name, l_49_5.id, true)
			end
		end
	end
	return l_49_0._editor_trigger_data
end

CoreUnitDamage.add_trigger_func = function(l_50_0, l_50_1, l_50_2, l_50_3, l_50_4, l_50_5)
	l_50_0._last_trigger_id = (l_50_0._last_trigger_id or 0) + 1
	local l_50_6, l_50_7 = l_50_0:set_trigger_func, l_50_0
	local l_50_8 = l_50_0._last_trigger_id
	local l_50_9 = l_50_1
	local l_50_10 = l_50_2
	local l_50_11 = l_50_3
	local l_50_12 = l_50_4
	local l_50_13 = l_50_5
	return l_50_6(l_50_7, l_50_8, l_50_9, l_50_10, l_50_11, l_50_12, l_50_13)
end

CoreUnitDamage.set_trigger_func = function(l_51_0, l_51_1, l_51_2, l_51_3, l_51_4, l_51_5, l_51_6)
	if l_51_0:verify_trigger_name(l_51_2) then
		local l_51_7 = nil
		if l_51_4 then
			l_51_7 = function(l_52_0)
			-- upvalues: l_51_3 , l_51_4 , l_51_5
			managers.sequence:add_time_callback(l_51_3, l_51_4, l_51_5, l_52_0)
    end
		elseif l_51_5 and l_51_5 > 1 then
			l_51_7 = function(l_53_0)
			-- upvalues: l_51_5 , l_51_3
			for l_53_4 = 1, l_51_5 do
				l_51_3(l_53_0)
			end
    end
		else
			l_51_7 = l_51_3
		end
		l_51_0._trigger_func_list[l_51_2][l_51_1] = l_51_7
		return l_51_1
	end
	return nil
end

CoreUnitDamage.activate_trigger = function(l_52_0, l_52_1, l_52_2)
	local l_52_6, l_52_7, l_52_8, l_52_9 = nil
	if l_52_0:verify_trigger_name(l_52_1) then
		for i_0,i_1 in pairs(l_52_0._trigger_func_list[l_52_1]) do
			i_1(l_52_2)
		end
	end
end

CoreUnitDamage.verify_trigger_name = function(l_53_0, l_53_1)
	if l_53_1 and l_53_0._trigger_func_list and l_53_0._trigger_func_list[l_53_1] then
		return true
	else
		Application:error("Trigger \"" .. tostring(l_53_1) .. "\" doesn't exist. Only the following triggers are available: " .. managers.sequence:get_keys_as_string(l_53_0._unit_element:get_trigger_name_map(), "[None]", true))
		return false
	end
end

CoreUnitDamage.inflict_damage = function(l_54_0, l_54_1, l_54_2, l_54_3, l_54_4, l_54_5, l_54_6, l_54_7)
	local l_54_8 = nil
	local l_54_9 = (l_54_3:extension())
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_54_9 and nil then
		local l_54_10, l_54_11 = , nil:inflict_damage
		local l_54_12 = nil
		local l_54_13 = l_54_1
		local l_54_14 = l_54_0._unit
		local l_54_15 = l_54_2
		local l_54_16 = l_54_4
		local l_54_17 = l_54_5
		return l_54_11(l_54_12, l_54_13, l_54_14, l_54_15, l_54_16, l_54_17, l_54_6)
	end
	return nil, false
end

CoreUnitDamage.damage_bullet = function(l_55_0, l_55_1, l_55_2, l_55_3, l_55_4, l_55_5, l_55_6, l_55_7)
	local l_55_8, l_55_9 = l_55_0:add_damage, l_55_0
	local l_55_10 = "bullet"
	local l_55_11 = l_55_1
	local l_55_12 = l_55_2
	local l_55_13 = l_55_3
	local l_55_14 = l_55_4
	local l_55_15 = l_55_5
	local l_55_16 = l_55_6
	local l_55_19 = Vector3
	local l_55_20 = 0
	l_55_19 = l_55_19(l_55_20, 0, 0)
	local l_55_17 = nil
	l_55_20 = l_55_7
	local l_55_18 = nil
	return l_55_8(l_55_9, l_55_10, l_55_11, l_55_12, l_55_13, l_55_14, l_55_15, l_55_16, l_55_19, l_55_20)
end

CoreUnitDamage.damage_explosion = function(l_56_0, l_56_1, l_56_2, l_56_3, l_56_4, l_56_5, l_56_6)
	local l_56_7, l_56_8 = l_56_0:add_damage, l_56_0
	local l_56_9 = "explosion"
	local l_56_10 = l_56_1
	local l_56_11 = l_56_2
	local l_56_12 = l_56_3
	local l_56_13 = l_56_4
	local l_56_14 = l_56_5
	local l_56_15 = l_56_6
	local l_56_16, l_56_17, l_56_18, l_56_19 = Vector3(0, 0, 0), .end
	return l_56_7(l_56_8, l_56_9, l_56_10, l_56_11, l_56_12, l_56_13, l_56_14, l_56_15, l_56_16, l_56_17, l_56_18, l_56_19)
end

CoreUnitDamage.damage_collision = function(l_57_0, l_57_1, l_57_2, l_57_3, l_57_4, l_57_5, l_57_6, l_57_7)
	local l_57_8, l_57_9 = l_57_0:add_damage, l_57_0
	local l_57_10 = "collision"
	local l_57_11 = l_57_1
	local l_57_12 = l_57_2
	local l_57_13 = l_57_3
	local l_57_14 = l_57_4
	local l_57_15 = l_57_5
	local l_57_16 = l_57_6
	local l_57_17 = l_57_7
	return l_57_8(l_57_9, l_57_10, l_57_11, l_57_12, l_57_13, l_57_14, l_57_15, l_57_16, l_57_17)
end

CoreUnitDamage.damage_melee = function(l_58_0, l_58_1, l_58_2, l_58_3, l_58_4, l_58_5, l_58_6)
	local l_58_7, l_58_8 = l_58_0:add_damage, l_58_0
	local l_58_9 = "melee"
	local l_58_10 = l_58_1
	local l_58_11 = l_58_2
	local l_58_12 = l_58_3
	local l_58_13 = l_58_4
	local l_58_14 = l_58_5
	local l_58_15 = l_58_6
	local l_58_16, l_58_17, l_58_18, l_58_19 = Vector3(0, 0, 0), .end
	return l_58_7(l_58_8, l_58_9, l_58_10, l_58_11, l_58_12, l_58_13, l_58_14, l_58_15, l_58_16, l_58_17, l_58_18, l_58_19)
end

CoreUnitDamage.damage_electricity = function(l_59_0, l_59_1, l_59_2, l_59_3, l_59_4, l_59_5, l_59_6)
	local l_59_7, l_59_8 = l_59_0:add_damage, l_59_0
	local l_59_9 = "electricity"
	local l_59_10 = l_59_1
	local l_59_11 = l_59_2
	local l_59_12 = l_59_3
	local l_59_13 = l_59_4
	local l_59_14 = l_59_5
	local l_59_15 = l_59_6
	local l_59_16, l_59_17, l_59_18, l_59_19 = Vector3(0, 0, 0), .end
	return l_59_7(l_59_8, l_59_9, l_59_10, l_59_11, l_59_12, l_59_13, l_59_14, l_59_15, l_59_16, l_59_17, l_59_18, l_59_19)
end

CoreUnitDamage.damage_fire = function(l_60_0, l_60_1, l_60_2, l_60_3, l_60_4, l_60_5, l_60_6, l_60_7)
	local l_60_8, l_60_9 = l_60_0:add_damage, l_60_0
	local l_60_10 = "fire"
	local l_60_11 = l_60_1
	local l_60_12 = l_60_2
	local l_60_13 = l_60_3
	local l_60_14 = l_60_4
	local l_60_15 = l_60_5
	local l_60_16 = l_60_6
	local l_60_17 = l_60_7
	return l_60_8(l_60_9, l_60_10, l_60_11, l_60_12, l_60_13, l_60_14, l_60_15, l_60_16, l_60_17)
end

CoreUnitDamage.damage_by_area = function(l_61_0, l_61_1, l_61_2, l_61_3, l_61_4, l_61_5, l_61_6, l_61_7, l_61_8)
	local l_61_9 = l_61_0["damage_" .. l_61_1]
	if l_61_9 then
		local l_61_10 = l_61_9
		local l_61_11 = l_61_0
		local l_61_12 = l_61_2
		local l_61_13 = l_61_3
		local l_61_14 = l_61_4
		local l_61_15 = l_61_5
		local l_61_16 = l_61_6
		local l_61_17 = l_61_7
		local l_61_18 = l_61_8
		return l_61_10(l_61_11, l_61_12, l_61_13, l_61_14, l_61_15, l_61_16, l_61_17, l_61_18)
	else
		Application:error("Unit \"" .. tostring(l_61_0._unit:name()) .. "\" doesn't have a \"damage_" .. tostring(l_61_1) .. "\"-function on its unit damage extension.")
		return false, nil
	end
end

CoreUnitDamage.add_damage = function(l_62_0, l_62_1, l_62_2, l_62_3, l_62_4, l_62_5, l_62_6, l_62_7, l_62_8)
	if l_62_0._unit_element then
		l_62_0._damage = l_62_0._damage + l_62_7
		if l_62_0._unit_element._global_vars.endurance <= l_62_0._damage then
			return true, l_62_7
		else
			return false, l_62_7
		end
	else
		return false, 0
	end
end

CoreUnitDamage.damage_effect = function(l_63_0, l_63_1, l_63_2, l_63_3, l_63_4, l_63_5, l_63_6, l_63_7, l_63_8)
end

CoreUnitDamage.run_sequence_simple = function(l_64_0, l_64_1, l_64_2)
	l_64_0:run_sequence_simple2(l_64_0, l_64_1, "", l_64_2)
end

CoreUnitDamage.run_sequence_simple2 = function(l_65_0, l_65_1, l_65_2, l_65_3)
	l_65_0:run_sequence_simple3(l_65_0, l_65_1, l_65_2, l_65_0._unit, l_65_3)
end

CoreUnitDamage.run_sequence_simple3 = function(l_66_0, l_66_1, l_66_2, l_66_3, l_66_4)
	l_66_0:run_sequence(l_66_1, l_66_2, l_66_3, nil, Vector3(0, 0, 1), l_66_0._unit:position(), Vector3(0, 0, -1), 0, Vector3(0, 0, 0), l_66_4)
end

CoreUnitDamage.run_sequence = function(l_67_0, l_67_1, l_67_2, l_67_3, l_67_4, l_67_5, l_67_6, l_67_7, l_67_8, l_67_9, l_67_10)
	l_67_0._unit_element:run_sequence(l_67_1, l_67_2, l_67_3, l_67_0._unit, l_67_4, l_67_5, l_67_6, l_67_7, l_67_8, l_67_9, l_67_10)
end

CoreUnitDamage.get_damage = function(l_68_0)
	return l_68_0._damage
end

CoreUnitDamage.get_endurance = function(l_69_0)
	if l_69_0._unit_element then
		local l_69_1, l_69_2 = l_69_0._unit_element:get_endurance, l_69_0._unit_element
		return l_69_1(l_69_2)
	else
		return 0
	end
end

CoreUnitDamage.get_damage_ratio = function(l_70_0)
	if l_70_0._unit_element and l_70_0._unit_element:get_endurance() > 0 then
		return l_70_0._damage / l_70_0._unit_element:get_endurance()
	else
		return 0
	end
end

CoreUnitDamage.update_inflict_damage = function(l_71_0, l_71_1, l_71_2)
	local l_71_6, l_71_7, l_71_8, l_71_9, l_71_11, l_71_12, l_71_13, l_71_14, l_71_15, l_71_17, l_71_18, l_71_19, l_71_20, l_71_22, l_71_23, l_71_25, l_71_26 = nil
	if l_71_0._inflict_dest_body then
		for i_0,i_1 in pairs(l_71_0._inflict_dest_body) do
			if not l_71_0._inflict_done or not l_71_0._inflict_done[i_0] then
				if l_71_0._inflict_src_body then
					local l_71_21, l_71_24, l_71_27 = l_71_0._inflict_src_body[i_0]
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				if alive(l_71_21) and alive(l_71_16) then
					l_71_0:exit_inflict_damage(l_71_10, l_71_21, l_71_16)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_71_0._inflict_src_body then
					l_71_0._inflict_src_body[l_71_10] = nil
				end
			if l_71_0._inflict_dest_body then
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_71_0._inflict_dest_body[l_71_10] = nil
			end
		end
	end
	l_71_0._inflict_done = nil
end

CoreUnitDamage.check_inflict_damage = function(l_72_0, l_72_1, l_72_2, l_72_3, l_72_4, l_72_5, l_72_6, l_72_7)
	local l_72_8, l_72_9 = l_72_0:can_receive_inflict_damage(l_72_1, l_72_3)
	if not l_72_0._inflict_done then
		l_72_0._inflict_done = {}
	end
	do
		local l_72_10 = l_72_0._inflict_done
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_72_10[l_72_1] = l_72_0._inflict_done[l_72_1] or l_72_8 or l_72_9
		if l_72_8 then
			if not l_72_0._inflict_dest_body then
				l_72_0._inflict_dest_body = {}
			end
			if not l_72_0._inflict_src_body then
				l_72_0._inflict_src_body = {}
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if alive(l_72_0._inflict_dest_body[l_72_1]) and l_72_0._inflict_dest_body[l_72_1]:key() ~= l_72_3:key() then
				l_72_0:exit_inflict_damage(l_72_1, l_72_0._inflict_src_body[l_72_1], l_72_0._inflict_dest_body[l_72_1], l_72_4, l_72_5, l_72_6, l_72_7)
			end
			l_72_0._inflict_dest_body[l_72_1] = l_72_3
			l_72_0._inflict_src_body[l_72_1] = l_72_2
			local l_72_13 = nil
			if not l_72_0:enter_inflict_damage(l_72_1, l_72_2, l_72_3, l_72_4, l_72_5, l_72_6, l_72_7) or l_72_3:extension().damage:get_inflict_instant(l_72_1) then
				local l_72_14, l_72_15 = nil
				local l_72_16 = l_72_0:inflict_damage
				local l_72_17 = l_72_0
				local l_72_18 = l_72_1
				local l_72_19 = l_72_2
				local l_72_20 = l_72_3
				local l_72_21 = l_72_4
				local l_72_22 = l_72_5
				return l_72_16(l_72_17, l_72_18, l_72_19, l_72_20, l_72_21, l_72_22, l_72_6, l_72_7)
			end
		else
			return false, 0
		end
		return false, nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitDamage.can_receive_inflict_damage = function(l_73_0, l_73_1, l_73_2)
	if alive(l_73_2) then
		local l_73_3 = l_73_2:extension()
	if l_73_3 then
		end
		local l_73_4 = l_73_3.damage
	if l_73_4 then
		end
		local l_73_5, l_73_6 = l_73_4:can_inflict_damage, l_73_4
		local l_73_7 = l_73_1
		local l_73_8 = l_73_0._unit
		return l_73_5(l_73_6, l_73_7, l_73_8)
	end
	return false, false
end

CoreUnitDamage.enter_inflict_damage = function(l_74_0, l_74_1, l_74_2, l_74_3, l_74_4, l_74_5, l_74_6, l_74_7)
	local l_74_8, l_74_9 = l_74_3:extension().damage:enter_inflict_damage, l_74_3:extension().damage
	local l_74_10 = l_74_1
	local l_74_11 = l_74_0._unit
	local l_74_12 = l_74_2
	local l_74_13 = l_74_4
	local l_74_14 = l_74_5
	local l_74_15 = l_74_6
	local l_74_16 = l_74_7
	return l_74_8(l_74_9, l_74_10, l_74_11, l_74_12, l_74_13, l_74_14, l_74_15, l_74_16)
end

CoreUnitDamage.inflict_damage = function(l_75_0, l_75_1, l_75_2, l_75_3, l_75_4, l_75_5, l_75_6, l_75_7)
	local l_75_8, l_75_9 = l_75_3:extension().damage:inflict_damage, l_75_3:extension().damage
	local l_75_10 = l_75_1
	local l_75_11 = l_75_0._unit
	local l_75_12 = l_75_2
	local l_75_13 = l_75_4
	local l_75_14 = l_75_5
	local l_75_15 = l_75_6
	local l_75_16 = l_75_7
	return l_75_8(l_75_9, l_75_10, l_75_11, l_75_12, l_75_13, l_75_14, l_75_15, l_75_16)
end

CoreUnitDamage.exit_inflict_damage = function(l_76_0, l_76_1, l_76_2, l_76_3, l_76_4, l_76_5, l_76_6, l_76_7)
	l_76_3:extension().damage:exit_inflict_damage(l_76_1, l_76_2, l_76_4, l_76_5, l_76_6, l_76_7)
end

CoreUnitDamage.set_direct_attack_unit = function(l_77_0, l_77_1)
	l_77_0._direct_attack_unit = l_77_1
end

CoreUnitDamage.get_direct_attack_unit = function(l_78_0)
	return l_78_0._direct_attack_unit
end

CoreUnitDamage.add_body_collision_callback = function(l_79_0, l_79_1)
	l_79_0._last_body_collision_callback_id = (l_79_0._last_body_collision_callback_id or 0) + 1
	if not l_79_0._body_collision_callback_list then
		l_79_0._body_collision_callback_list = {}
	end
	l_79_0._body_collision_callback_list[l_79_0._last_body_collision_callback_id] = l_79_1
	return l_79_0._last_body_collision_callback_id
end

CoreUnitDamage.remove_body_collision_callback = function(l_80_0, l_80_1)
	if l_80_0._body_collision_callback_list then
		l_80_0._body_collision_callback_list[l_80_1] = nil
	end
end

CoreUnitDamage.add_mover_collision_callback = function(l_81_0, l_81_1)
	l_81_0._last_mover_collision_callback_id = (l_81_0._last_mover_collision_callback_id or 0) + 1
	if not l_81_0._mover_collision_callback_list then
		l_81_0._mover_collision_callback_list = {}
	end
	l_81_0._mover_collision_callback_list[l_81_0._last_mover_collision_callback_id] = l_81_1
	return l_81_0._last_mover_collision_callback_id
end

CoreUnitDamage.remove_mover_collision_callback = function(l_82_0, l_82_1)
	if l_82_0._mover_collision_callback_list then
		l_82_0._mover_collision_callback_list[l_82_1] = nil
	end
end

CoreUnitDamage.set_ignore_mover_collision_unit = function(l_83_0, l_83_1, l_83_2)
	if not l_83_0._ignore_mover_collision_unit_map then
		l_83_0._ignore_mover_collision_unit_map = {}
	end
	l_83_0._ignore_mover_collision_unit_map[l_83_1] = l_83_2
end

CoreUnitDamage.set_ignore_mover_collision_body = function(l_84_0, l_84_1, l_84_2)
	if not l_84_0._ignore_mover_collision_body_map then
		l_84_0._ignore_mover_collision_body_map = {}
	end
	l_84_0._ignore_mover_collision_body_map[l_84_1] = l_84_2
end

CoreUnitDamage.clear_ignore_mover_collision_units = function(l_85_0)
	l_85_0._ignore_mover_collision_unit_map = nil
end

CoreUnitDamage.clear_ignore_mover_collision_bodies = function(l_86_0)
	l_86_0._ignore_mover_collision_body_map = nil
end

CoreUnitDamage.set_ignore_body_collision_unit = function(l_87_0, l_87_1, l_87_2)
	if not l_87_0._ignore_body_collision_unit_map then
		l_87_0._ignore_body_collision_unit_map = {}
	end
	l_87_0._ignore_body_collision_unit_map[l_87_1] = l_87_2
end

CoreUnitDamage.clear_ignore_body_collision_units = function(l_88_0)
	l_88_0._ignore_body_collision_unit_map = nil
end

CoreUnitDamage.set_ignore_mover_on_mover_collisions = function(l_89_0, l_89_1)
	if l_89_1 then
		l_89_0._ignore_mover_on_mover_collisions = true
	else
		l_89_0._ignore_mover_on_mover_collisions = nil
	end
end

CoreUnitDamage.get_ignore_mover_on_mover_collisions = function(l_90_0)
	return not not l_90_0._ignore_mover_on_mover_collisions
end

CoreUnitDamage.give_body_collision_velocity = function(l_91_0)
	return not l_91_0._skip_give_body_collision_velocity
end

CoreUnitDamage.set_give_body_collision_velocity = function(l_92_0, l_92_1)
	l_92_0._skip_give_body_collision_velocity = not l_92_1
end

CoreUnitDamage.give_mover_collision_velocity = function(l_93_0)
	return not l_93_0._skip_give_mover_collision_velocity
end

CoreUnitDamage.set_give_mover_collision_velocity = function(l_94_0, l_94_1)
	l_94_0._skip_give_mover_collision_velocity = not l_94_1
end

CoreUnitDamage.give_body_collision_damage = function(l_95_0)
	return not l_95_0._skip_give_body_collision_damage
end

CoreUnitDamage.set_give_body_collision_damage = function(l_96_0, l_96_1)
	l_96_0._skip_give_body_collision_damage = not l_96_1
end

CoreUnitDamage.give_mover_collision_damage = function(l_97_0)
	return not l_97_0._skip_give_mover_collision_damage
end

CoreUnitDamage.set_give_mover_collision_damage = function(l_98_0, l_98_1)
	l_98_0._skip_give_mover_collision_damage = not l_98_1
end

CoreUnitDamage.receive_body_collision_damage = function(l_99_0)
	return not l_99_0._skip_receive_body_collision_damage
end

CoreUnitDamage.set_receive_body_collision_damage = function(l_100_0, l_100_1)
	l_100_0._skip_receive_body_collision_damage = not l_100_1
end

CoreUnitDamage.receive_mover_collision_damage = function(l_101_0)
	return not l_101_0._skip_receive_mover_collision_damage
end

CoreUnitDamage.set_receive_mover_collision_damage = function(l_102_0, l_102_1)
	l_102_0._skip_receive_mover_collision_damage = not l_102_1
end

CoreUnitDamage.can_mover_collide = function(l_103_0, l_103_1, l_103_2, l_103_3, l_103_4, l_103_5, l_103_6, l_103_7, l_103_8, l_103_9)
	local l_103_10 = alive(l_103_4)
	local l_103_11 = l_103_3:damage()
	return (l_103_11 and not l_103_11:give_mover_collision_damage()) or (not l_103_0._skip_receive_mover_collision_damage and ((l_103_10 or not l_103_0._ignore_mover_on_mover_collisions) and ((not l_103_0._ignore_mover_collision_unit_map or not l_103_0._ignore_mover_collision_unit_map[l_103_3:key()] or l_103_0._ignore_mover_collision_unit_map[l_103_3:key()] < l_103_1) and l_103_10 and l_103_0._ignore_mover_collision_body_map and l_103_0._ignore_mover_collision_body_map[l_103_4:key()] and l_103_0._ignore_mover_collision_body_map[l_103_4:key()] < l_103_1)))
end

CoreUnitDamage.can_body_collide = function(l_104_0, l_104_1, l_104_2, l_104_3, l_104_4, l_104_5, l_104_6, l_104_7, l_104_8, l_104_9, l_104_10, l_104_11)
	local l_104_12 = l_104_5:damage()
	return (l_104_12 and not l_104_12:give_body_collision_damage()) or (not l_104_0._skip_receive_body_collision_damage and not managers.sequence:is_collisions_enabled() or l_104_0._ignore_body_collision_unit_map and l_104_0._ignore_body_collision_unit_map[l_104_5:key()] and l_104_0._ignore_body_collision_unit_map[l_104_5:key()] < l_104_1)
end

CoreUnitDamage.get_collision_velocity = function(l_105_0, l_105_1, l_105_2, l_105_3, l_105_4, l_105_5, l_105_6, l_105_7, l_105_8, l_105_9)
	local l_105_10 = l_105_4:damage()
	local l_105_11 = not alive(l_105_3)
	if l_105_10 and l_105_11 and not l_105_10:give_mover_collision_velocity() then
		l_105_9 = Vector3()
	end
	do return end
	if not l_105_10:give_body_collision_velocity() then
		l_105_9 = Vector3()
	end
	if l_105_7 then
		local l_105_12 = l_105_9:normalized()
		local l_105_13 = l_105_9:length()
		l_105_8 = l_105_12 * math.clamp(math.dot(l_105_8, l_105_12), 0, l_105_13)
	end
	l_105_5 = l_105_8 - l_105_9
	if l_105_8:length() < l_105_9:length() then
		l_105_5 = -(l_105_5)
	end
	local l_105_14 = l_105_5:normalized()
	if l_105_14:length() == 0 then
		l_105_14 = -l_105_6
	end
	local l_105_15, l_105_16 = l_105_0:add_angular_velocity, l_105_0
	local l_105_17 = l_105_1
	local l_105_18 = l_105_14
	local l_105_19 = l_105_2
	local l_105_20 = l_105_3
	local l_105_21 = l_105_4
	local l_105_22 = l_105_5
	local l_105_23 = l_105_7
	return l_105_15(l_105_16, l_105_17, l_105_18, l_105_19, l_105_20, l_105_21, l_105_22, l_105_23)
end

CoreUnitDamage.add_angular_velocity = function(l_106_0, l_106_1, l_106_2, l_106_3, l_106_4, l_106_5, l_106_6, l_106_7)
	local l_106_8 = Vector3()
	if alive(l_106_3) then
		local l_106_9 = l_106_3:angular_velocity()
		l_106_8 = l_106_2 * 200 * l_106_9:length() * (1 + math.abs(math.dot(l_106_9:normalized(), l_106_2))) / (10 * math.pi)
	end
	if alive(l_106_4) then
		local l_106_10 = l_106_4:angular_velocity()
		l_106_8 = l_106_8 + l_106_2 * 200 * l_106_10:length() * (1 + math.abs(math.dot(l_106_10:normalized(), l_106_2))) / (10 * math.pi)
		l_106_8 = l_106_2 * math.clamp(l_106_8:length(), 0, 200)
	end
	return l_106_6 + l_106_8, l_106_2
end

CoreUnitDamage.get_collision_damage = function(l_107_0, l_107_1, l_107_2, l_107_3, l_107_4, l_107_5, l_107_6, l_107_7, l_107_8)
	local l_107_9 = math.clamp
	local l_107_10 = (l_107_7:length() - 400) / 100
	local l_107_11 = 0
	local l_107_12 = 75
	return l_107_9(l_107_10, l_107_11, l_107_12)
end

CoreUnitDamage.body_collision_callback = function(l_108_0, l_108_1, l_108_2, l_108_3, l_108_4, l_108_5, l_108_6, l_108_7, l_108_8, l_108_9, l_108_10)
	local l_108_11 = (TimerManager:game():time())
	local l_108_12, l_108_13, l_108_14 = nil, nil, nil
	if l_108_0:can_body_collide(l_108_11, l_108_1, l_108_2, l_108_3, l_108_4, l_108_5, l_108_6, l_108_7, l_108_8, l_108_9, l_108_10) then
		l_108_12 = l_108_0:get_collision_velocity(l_108_6, l_108_3, l_108_5, l_108_4, l_108_8, l_108_7, false, l_108_9, l_108_10)
		l_108_14 = l_108_0:get_collision_damage(l_108_1, l_108_3, l_108_4, l_108_5, l_108_6, l_108_7, l_108_12, false)
		local l_108_18, l_108_20 = l_108_0:collision, l_108_0
		local l_108_19, l_108_21 = l_108_1, l_108_2
		l_108_18(l_108_20, l_108_19, l_108_21, l_108_3, l_108_4, l_108_5, l_108_6, l_108_7, l_108_13, l_108_14, l_108_12, false)
	end
	if l_108_0._body_collision_callback_list then
		for i_0,i_1 in pairs(l_108_0._body_collision_callback_list) do
			i_1(l_108_1, l_108_2, l_108_3, l_108_4, l_108_5, l_108_6, l_108_7, l_108_8, l_108_9, l_108_10, l_108_12, l_108_13, l_108_14)
		end
	end
end

CoreUnitDamage.mover_collision_callback = function(l_109_0, l_109_1, l_109_2, l_109_3, l_109_4, l_109_5, l_109_6, l_109_7, l_109_8)
	local l_109_9 = (TimerManager:game():time())
	local l_109_10, l_109_11, l_109_12 = nil, nil, nil
	if l_109_0:can_mover_collide(l_109_9, l_109_1, l_109_2, l_109_3, l_109_4, l_109_5, l_109_6, l_109_7, l_109_8) then
		l_109_10 = l_109_0:get_collision_velocity(l_109_4, nil, l_109_3, l_109_2, l_109_6, l_109_5, true, l_109_7, l_109_8)
		local l_109_17, l_109_23, l_109_25 = l_109_0:get_collision_damage, l_109_0, nil
		local l_109_18 = nil
		l_109_17 = l_109_17(l_109_23, l_109_25, l_109_18, l_109_2, l_109_3, l_109_4, l_109_5, l_109_10, true)
		l_109_12 = l_109_17
		if l_109_12 > 0 then
			l_109_17 = alive
			l_109_23 = l_109_3
			l_109_17 = l_109_17(l_109_23)
			if l_109_17 then
				l_109_17, l_109_23 = l_109_3:constrained_bodies, l_109_3
				l_109_17 = l_109_17(l_109_23)
				local l_109_13 = nil
				l_109_23 = table
				l_109_23 = l_109_23.insert
				l_109_25 = l_109_17
				l_109_18 = l_109_3
				l_109_23(l_109_25, l_109_18)
				l_109_23 = ipairs
				l_109_25 = l_109_17
				l_109_23 = l_109_23(l_109_25)
				for l_109_13,l_109_24 in l_109_23 do
					local l_109_15, l_109_16, l_109_22, l_109_24 = nil
					l_109_15, l_109_16 = l_109_0:set_ignore_mover_collision_body, l_109_0
					l_109_22, l_109_24 = l_109_14:key, l_109_14
					l_109_22 = l_109_22(l_109_24)
					l_109_24 = l_109_0._mover_collision_ignore_duration
					if not l_109_24 then
						l_109_24 = 1
					end
					l_109_24 = l_109_9 + l_109_24
					l_109_15(l_109_16, l_109_22, l_109_24)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		else
			l_109_17 = alive
			l_109_17 = l_109_17(l_109_2)
		if l_109_17 then
			end
			l_109_17(l_109_0, l_109_2:key(), l_109_9 + (l_109_0._mover_collision_ignore_duration or 1))
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_109_17(l_109_0, nil, l_109_1, nil, l_109_2, l_109_3, l_109_4, l_109_5, l_109_11, l_109_12, l_109_10, true)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_109_17 then
		for i_0,i_1 in l_109_17 do
			local l_109_21 = nil
			l_109_21 = l_109_20
			l_109_21(l_109_1, l_109_2, l_109_3, l_109_4, l_109_5, l_109_6, l_109_7, l_109_8, l_109_10, l_109_11, l_109_12)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitDamage.collision = function(l_110_0, l_110_1, l_110_2, l_110_3, l_110_4, l_110_5, l_110_6, l_110_7, l_110_8, l_110_9, l_110_10, l_110_11)
	if l_110_9 > 0 then
		if l_110_3 then
			local l_110_12 = l_110_3:extension()
		if l_110_12 then
			end
		if l_110_12.damage then
			end
			l_110_12.damage:damage_collision(l_110_4, l_110_7, l_110_6, l_110_8, l_110_9, l_110_10)
		end
	else
		l_110_0:damage_collision(l_110_4, l_110_3, l_110_7, l_110_6, l_110_8, l_110_9, l_110_10)
	end
end

CoreUnitDamage.toggle_debug_collision_all = function(l_111_0)
	l_111_0:toggle_debug_collision_body()
	l_111_0:toggle_debug_collision_mover()
end

CoreUnitDamage.set_debug_collision_all = function(l_112_0, l_112_1)
	l_112_0:toggle_debug_collision_body(l_112_1)
	l_112_0:toggle_debug_collision_mover(l_112_1)
end

CoreUnitDamage.toggle_debug_collision_body = function(l_113_0)
	l_113_0:set_debug_collision_body(not l_113_0._debug_collision_body_id)
end

CoreUnitDamage.set_debug_collision_body = function(l_114_0, l_114_1)
	if not l_114_0._debug_collision_body_id ~= not l_114_1 then
		if l_114_1 then
			l_114_0._debug_collision_body_id = l_114_0:add_body_collision_callback(callback(l_114_0, l_114_0, "debug_collision_body"))
		else
			l_114_0:remove_body_collision_callback(l_114_0._debug_collision_body_id)
			l_114_0._debug_collision_body_id = nil
		end
		cat_debug("debug", "Body collision debugging " .. tostring(l_114_0._unit) .. " enabled: " .. tostring(not not l_114_1))
	end
end

CoreUnitDamage.toggle_debug_collision_mover = function(l_115_0)
	l_115_0:set_debug_collision_mover(not l_115_0._debug_collision_mover_id)
end

CoreUnitDamage.set_debug_collision_mover = function(l_116_0, l_116_1)
	if not l_116_0._debug_collision_mover_id ~= not l_116_1 then
		if l_116_1 then
			l_116_0._debug_collision_mover_id = l_116_0:add_mover_collision_callback(callback(l_116_0, l_116_0, "debug_collision_mover"))
		else
			l_116_0:remove_mover_collision_callback(l_116_0._debug_collision_mover_id)
			l_116_0._debug_collision_mover_id = nil
		end
		cat_debug("debug", "Mover collision debugging " .. tostring(l_116_0._unit) .. " enabled: " .. tostring(not not l_116_1))
	end
end

CoreUnitDamage.debug_collision_body = function(l_117_0, l_117_1, l_117_2, l_117_3, l_117_4, l_117_5, l_117_6, l_117_7, l_117_8, l_117_9, l_117_10, l_117_11, l_117_12, l_117_13)
	local l_117_14 = TimerManager:game():time()
	local l_117_15 = cat_debug
	local l_117_16 = "debug"
	local l_117_17 = string.format
	local l_117_18 = "[B %g] Velocity: %g, Damage: %g, Ignored: %s"
	local l_117_19 = l_117_14
	do
		local l_117_20 = l_117_11 and l_117_11:length() or 0
	do
		end
		l_117_15(l_117_16, l_117_17, l_117_18, l_117_19)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_117_15 then
			l_117_15(l_117_16, l_117_17, l_117_18, l_117_19, 1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18, l_117_19, l_117_9, 0, 0, 1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18, l_117_19, l_117_10, 1, 0, 0)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18, l_117_19, l_117_8, 0, 1, 1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18, l_117_19, l_117_11, 0, 1, 0)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18, l_117_19, 0.5)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18, l_117_19, 0.5)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_117_15(l_117_16, l_117_17, l_117_18)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitDamage.debug_collision_mover = function(l_118_0, l_118_1, l_118_2, l_118_3, l_118_4, l_118_5, l_118_6, l_118_7, l_118_8, l_118_9, l_118_10, l_118_11)
	local l_118_12 = TimerManager:game():time()
	local l_118_13 = cat_debug
	local l_118_14 = "debug"
	local l_118_15 = string.format
	local l_118_16 = "[M %g] Velocity: %g, Damage: %g, Ignored: %s"
	local l_118_17 = l_118_12
	do
		local l_118_18 = l_118_9 and l_118_9:length() or 0
	do
		end
		l_118_13(l_118_14, l_118_15, l_118_16, l_118_17)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_118_13 then
			l_118_13(l_118_14, l_118_15, l_118_16, l_118_17, 1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16, l_118_17, l_118_7, 0, 0, 1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16, l_118_17, l_118_8, 1, 0, 0)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16, l_118_17, l_118_6, 0, 1, 1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16, l_118_17, l_118_9, 0, 1, 0)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16, l_118_17, 0.5)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16, l_118_17, 0.5)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_118_13(l_118_14, l_118_15, l_118_16)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreUnitDamage.debug_draw_velocity = function(l_119_0, l_119_1, l_119_2, l_119_3, l_119_4, l_119_5, l_119_6, l_119_7)
	managers.debug.gui:set_color(l_119_1, l_119_5, l_119_6, l_119_7)
	if l_119_4 then
		managers.debug.gui:set(l_119_1, string.format("%s: %g   (%g, %g, %g)", l_119_2, l_119_4:length(), l_119_4.x, l_119_4.y, l_119_4.z))
	else
		managers.debug.gui:set(l_119_1, string.format("%s: nil", l_119_2))
	end
	managers.debug.pos:set(1, l_119_3 + Vector3(0, 0, l_119_1 - 2), "debug_collision_body_" .. l_119_1 - 1, l_119_5, l_119_6, l_119_7)
	local l_119_8, l_119_9 = managers.debug.pos:set, managers.debug.pos
	local l_119_10 = 2
	local l_119_11 = l_119_3 + Vector3(0, 0, l_119_1 - 2)
	do
		if not l_119_4 then
			l_119_11 = l_119_11 + Vector3()
		end
		l_119_8(l_119_9, l_119_10, l_119_11, "debug_collision_body_" .. l_119_1 - 1, l_119_5, l_119_6, l_119_7)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreUnitDamage.outside_worlds_bounding_box = function(l_120_0)
	if alive(l_120_0._unit) then
		l_120_0:kill("collision", l_120_0._unit, nil, math.UP, l_120_0._unit:position(), -math.UP, 0, l_120_0._unit:sampled_velocity())
	end
end

CoreUnitDamage.report_enemy_killed = function(l_121_0)
	if not l_121_0._enemy_killed_reported then
		local l_121_1 = l_121_0._unit:enemy_data()
	if l_121_1 then
		end
		local l_121_2 = l_121_1.enemy_group
	if l_121_2 then
		end
		l_121_2:unit_killed()
		l_121_0._enemy_killed_reported = true
	end
end

CoreUnitDamage.kill = function(l_122_0, l_122_1, l_122_2, l_122_3, l_122_4, l_122_5, l_122_6, l_122_7, l_122_8)
	if alive(l_122_0._unit) then
		l_122_0:report_enemy_killed()
	end
end

CoreUnitDamage.remove = function(l_123_0)
	if alive(l_123_0._unit) then
		l_123_0:report_enemy_killed()
		l_123_0._unit:set_slot(0)
	end
end

CoreUnitDamage.add_inherit_destroy_unit = function(l_124_0, l_124_1)
	if not l_124_0._inherit_destroy_unit_list then
		l_124_0._inherit_destroy_unit_list = {}
	end
	table.insert(l_124_0._inherit_destroy_unit_list, l_124_1)
end

CoreUnitDamage.has_sequence = function(l_125_0, l_125_1)
	if l_125_0._unit_element then
		return l_125_0._unit_element:has_sequence(l_125_1)
	end
end

if not CoreBodyDamage then
	CoreBodyDamage = class()
end
CoreBodyDamage.init = function(l_126_0, l_126_1, l_126_2, l_126_3, l_126_4)
	local l_126_8, l_126_9, l_126_10, l_126_11, l_126_12, l_126_13, l_126_14 = nil
	l_126_0._unit = l_126_1
	l_126_0._unit_extension = l_126_2
	l_126_0._body = l_126_3
	l_126_0._body_element = l_126_4
	l_126_0._unit_element = l_126_2:get_unit_element()
	l_126_0._endurance = {}
	l_126_0._damage = {}
	if l_126_4 then
		for i_0,i_1 in pairs(l_126_4._first_endurance) do
			if i_0 == "collision" then
				l_126_0._body:set_collision_script_tag("core")
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_126_0._endurance[l_126_22] = i_1
			local l_126_20 = nil
			l_126_0._damage[l_126_20] = 0
		end
	end
	l_126_0._inflict = {}
	l_126_0._original_inflict = {}
	l_126_0._inflict_time = {}
	l_126_0._run_exit_inflict_sequences = {}
	l_126_0._inflict_updator_map = {}
	if l_126_0._body_element then
		local l_126_15 = l_126_0._body_element:get_inflict_element_list()
	if l_126_15 then
		end
		do
			local l_126_16 = get_core_or_local("InflictUpdator")
			for i_0,i_1 in pairs(l_126_15) do
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_126_16.INFLICT_UPDATOR_DAMAGE_TYPE_MAP[i_0] then
					local l_126_30 = nil
					local l_126_24 = l_126_16.INFLICT_UPDATOR_DAMAGE_TYPE_MAP[i_0]:new(l_126_1, l_126_3, l_126_0, l_126_29, l_126_0._unit_element)
					if l_126_24:is_valid() then
						l_126_0._inflict_updator_map[l_126_23] = l_126_24
					end
				else
					local l_126_25 = nil
					l_126_0._inflict[l_126_23] = {}
					 -- DECOMPILER ERROR: Confused about usage of registers!

					{}.damage = l_126_25:get_damage() or 0
					 -- DECOMPILER ERROR: Confused about usage of registers!

					{}.interval = l_126_25:get_interval() or 0
					 -- DECOMPILER ERROR: Confused about usage of registers!

					{}.instant = l_126_25:get_instant()
					 -- DECOMPILER ERROR: Confused about usage of registers!

					{}.enabled = l_126_25:get_enabled()
					l_126_0._original_inflict[l_126_23] = {}
					 -- DECOMPILER ERROR: Confused about usage of registers!

					for i_0,i_1 in pairs({}) do
						local l_126_26, l_126_27 = nil
						l_126_27[i_0] = i_1
					end
					l_126_0._inflict_time[l_126_23] = {}
					l_126_0._run_exit_inflict_sequences[l_126_23] = l_126_25:exit_sequence_count() > 0
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreBodyDamage.set_damage = function(l_127_0, l_127_1, l_127_2)
	l_127_0._damage[l_127_1] = l_127_2
	do
		while 1 do
			local l_127_3 = l_127_0._body_element._first_endurance[l_127_1]
			while l_127_3 and l_127_3._endurance[l_127_1] <= l_127_0._damage[l_127_1] do
				l_127_3 = l_127_3._next[l_127_1]
			end
			l_127_0._endurance[l_127_1] = l_127_3
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreBodyDamage.get_body = function(l_128_0)
	return l_128_0._body
end

CoreBodyDamage.get_inflict_updator_map = function(l_129_0)
	return l_129_0._inflict_updator_map
end

CoreBodyDamage.get_endurance_map = function(l_130_0)
	return l_130_0._endurance
end

CoreBodyDamage.get_inflict_time = function(l_131_0, l_131_1, l_131_2)
	return l_131_0._inflict_time[l_131_1][l_131_2]
end

CoreBodyDamage.can_inflict_damage = function(l_132_0, l_132_1, l_132_2)
	do
		if l_132_0._inflict[l_132_1] and l_132_0._inflict[l_132_1].enabled then
			local l_132_3 = l_132_0._inflict_time[l_132_1][l_132_2:key()]
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if TimerManager:game():time() >= l_132_3 + l_132_0._inflict[l_132_1].interval then
				return not not l_132_3, not l_132_3
			end
		end
		return false, false
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 29 
end

CoreBodyDamage.enter_inflict_damage = function(l_133_0, l_133_1, l_133_2, l_133_3, l_133_4, l_133_5, l_133_6, l_133_7)
	local l_133_8 = l_133_2:key()
	local l_133_9 = l_133_0._inflict_time[l_133_1]
	if not l_133_9[l_133_8] then
		l_133_9[l_133_8] = TimerManager:game():time()
		local l_133_10 = l_133_0._inflict[l_133_1].damage
		local l_133_11 = SequenceEnvironment:new(l_133_1, l_133_2, l_133_0._unit, l_133_0._body, l_133_4, l_133_5, l_133_6, l_133_10, l_133_7, nil, l_133_0._unit_element)
		l_133_0._body_element:activate_inflict_enter(l_133_11)
		return true
	else
		return false
	end
end

CoreBodyDamage.exit_inflict_damage = function(l_134_0, l_134_1, l_134_2, l_134_3, l_134_4, l_134_5, l_134_6)
	if alive(l_134_2) then
		local l_134_7 = l_134_2:unit()
		local l_134_8 = l_134_7:key()
		local l_134_9 = l_134_0._inflict_time[l_134_1]
	if l_134_9[l_134_8] then
		end
		l_134_9[l_134_8] = nil
	if l_134_0._run_exit_inflict_sequences[l_134_1] then
		end
		local l_134_10 = SequenceEnvironment:new(l_134_1, l_134_7, l_134_0._unit, l_134_0._body, l_134_3, l_134_4, l_134_5, 0, l_134_6, nil, l_134_0._unit_element)
		l_134_0._body_element:activate_inflict_exit(l_134_10)
	end
end

CoreBodyDamage.inflict_damage = function(l_135_0, l_135_1, l_135_2, l_135_3, l_135_4, l_135_5, l_135_6, l_135_7)
	local l_135_8 = l_135_2:key()
	l_135_0._inflict_time[l_135_1][l_135_8] = TimerManager:game():time()
	local l_135_9 = l_135_0._inflict[l_135_1].damage
	local l_135_20 = SequenceEnvironment:new
	local l_135_21 = SequenceEnvironment
	local l_135_22 = l_135_1
	l_135_20 = l_135_20(l_135_21, l_135_22, l_135_2, l_135_0._unit, l_135_0._body, l_135_4, l_135_5, l_135_6, l_135_9, l_135_7, nil, l_135_0._unit_element)
	local l_135_10 = nil
	l_135_21 = l_135_0._body_element
	l_135_21, l_135_22 = l_135_21:activate_inflict_damage, l_135_21
	l_135_10 = l_135_20
	l_135_21(l_135_22, l_135_10)
	l_135_21, l_135_22 = l_135_3:extension, l_135_3
	l_135_21 = l_135_21(l_135_22)
	l_135_21 = l_135_21.damage
	local l_135_11 = nil
	l_135_22 = "damage_"
	l_135_10 = l_135_1
	l_135_22 = l_135_22 .. l_135_10
	l_135_22 = l_135_21[l_135_22]
	local l_135_12 = nil
	l_135_10 = l_135_21
	local l_135_13 = nil
	l_135_11 = l_135_0._unit
	local l_135_14 = nil
	l_135_12 = l_135_4
	local l_135_15 = nil
	l_135_13 = l_135_5
	local l_135_16 = nil
	l_135_14 = l_135_6
	local l_135_17 = nil
	l_135_15 = l_135_9
	local l_135_18 = nil
	l_135_16 = l_135_7
	local l_135_19 = nil
	return l_135_22(l_135_10, l_135_11, l_135_12, l_135_13, l_135_14, l_135_15, l_135_16)
end

CoreBodyDamage.damage_bullet = function(l_136_0, l_136_1, l_136_2, l_136_3, l_136_4, l_136_5, l_136_6)
	local l_136_16, l_136_17, l_136_18 = l_136_0:damage_endurance, l_136_0, "bullet"
	l_136_16 = l_136_16(l_136_17, l_136_18, l_136_1, l_136_2, l_136_3, l_136_4, l_136_5, Vector3(0, 0, 0))
	l_136_5 = l_136_16
	l_136_16 = l_136_0._unit_extension
	l_136_16, l_136_17 = l_136_16:damage_bullet, l_136_16
	local l_136_7, l_136_8 = nil
	l_136_18 = l_136_1
	local l_136_9 = nil
	l_136_7 = l_136_0._body
	local l_136_10 = nil
	l_136_8 = l_136_2
	local l_136_11 = nil
	l_136_9 = l_136_3
	local l_136_12 = nil
	l_136_10 = l_136_4
	local l_136_13 = nil
	l_136_11 = l_136_5
	local l_136_14 = nil
	l_136_12 = l_136_6
	local l_136_15 = nil
	return l_136_16(l_136_17, l_136_18, l_136_7, l_136_8, l_136_9, l_136_10, l_136_11, l_136_12)
end

CoreBodyDamage.damage_explosion = function(l_137_0, l_137_1, l_137_2, l_137_3, l_137_4, l_137_5)
	l_137_5 = l_137_0:damage_endurance("explosion", l_137_1, l_137_2, l_137_3, l_137_4, l_137_5, Vector3(0, 0, 0))
	return false, 0
end

CoreBodyDamage.damage_collision = function(l_138_0, l_138_1, l_138_2, l_138_3, l_138_4, l_138_5, l_138_6)
	l_138_5 = l_138_0:damage_endurance("collision", l_138_1, l_138_2, l_138_3, l_138_4, l_138_5, l_138_6)
	local l_138_7, l_138_8 = l_138_0._unit_extension:damage_collision, l_138_0._unit_extension
	local l_138_9 = l_138_1
	local l_138_10 = l_138_0._body
	local l_138_11 = l_138_2
	local l_138_12 = l_138_3
	local l_138_13 = l_138_4
	local l_138_14 = l_138_5
	local l_138_15 = l_138_6
	return l_138_7(l_138_8, l_138_9, l_138_10, l_138_11, l_138_12, l_138_13, l_138_14, l_138_15)
end

CoreBodyDamage.damage_melee = function(l_139_0, l_139_1, l_139_2, l_139_3, l_139_4, l_139_5)
	local l_139_14, l_139_15, l_139_16, l_139_17 = l_139_0:damage_endurance, l_139_0, "melee", l_139_1
	l_139_14 = l_139_14(l_139_15, l_139_16, l_139_17, l_139_2, l_139_3, l_139_4, l_139_5, Vector3(0, 0, 0))
	l_139_5 = l_139_14
	l_139_14 = l_139_0._unit_extension
	l_139_14, l_139_15 = l_139_14:damage_melee, l_139_14
	local l_139_6, l_139_7 = nil
	l_139_16 = l_139_1
	local l_139_8 = nil
	l_139_17 = l_139_0._body
	local l_139_9 = nil
	l_139_6 = l_139_2
	local l_139_10 = nil
	l_139_7 = l_139_3
	local l_139_11 = nil
	l_139_8 = l_139_4
	local l_139_12 = nil
	l_139_9 = l_139_5
	local l_139_13 = nil
	return l_139_14(l_139_15, l_139_16, l_139_17, l_139_6, l_139_7, l_139_8, l_139_9)
end

CoreBodyDamage.damage_electricity = function(l_140_0, l_140_1, l_140_2, l_140_3, l_140_4, l_140_5)
	local l_140_14, l_140_15, l_140_16, l_140_17 = l_140_0:damage_endurance, l_140_0, "electricity", l_140_1
	l_140_14 = l_140_14(l_140_15, l_140_16, l_140_17, l_140_2, l_140_3, l_140_4, l_140_5, Vector3(0, 0, 0))
	l_140_5 = l_140_14
	l_140_14 = l_140_0._unit_extension
	l_140_14, l_140_15 = l_140_14:damage_electricity, l_140_14
	local l_140_6, l_140_7 = nil
	l_140_16 = l_140_1
	local l_140_8 = nil
	l_140_17 = l_140_0._body
	local l_140_9 = nil
	l_140_6 = l_140_2
	local l_140_10 = nil
	l_140_7 = l_140_3
	local l_140_11 = nil
	l_140_8 = l_140_4
	local l_140_12 = nil
	l_140_9 = l_140_5
	local l_140_13 = nil
	return l_140_14(l_140_15, l_140_16, l_140_17, l_140_6, l_140_7, l_140_8, l_140_9)
end

CoreBodyDamage.damage_fire = function(l_141_0, l_141_1, l_141_2, l_141_3, l_141_4, l_141_5, l_141_6)
	l_141_5 = l_141_0:damage_endurance("fire", l_141_1, l_141_2, l_141_3, l_141_4, l_141_5, l_141_6)
	local l_141_7, l_141_8 = l_141_0._unit_extension:damage_fire, l_141_0._unit_extension
	local l_141_9 = l_141_1
	local l_141_10 = l_141_0._body
	local l_141_11 = l_141_2
	local l_141_12 = l_141_3
	local l_141_13 = l_141_4
	local l_141_14 = l_141_5
	local l_141_15 = l_141_6
	return l_141_7(l_141_8, l_141_9, l_141_10, l_141_11, l_141_12, l_141_13, l_141_14, l_141_15)
end

CoreBodyDamage.damage_by_area = function(l_142_0, l_142_1, l_142_2, l_142_3, l_142_4, l_142_5, l_142_6, l_142_7)
	local l_142_8 = l_142_0["damage_" .. l_142_1]
	if l_142_8 then
		local l_142_9 = l_142_8
		local l_142_10 = l_142_0
		local l_142_11 = l_142_2
		local l_142_12 = l_142_3
		local l_142_13 = l_142_4
		local l_142_14 = l_142_5
		local l_142_15 = l_142_6
		local l_142_16 = l_142_7
		return l_142_9(l_142_10, l_142_11, l_142_12, l_142_13, l_142_14, l_142_15, l_142_16)
	else
		Application:error("Unit \"" .. tostring(l_142_0._unit:name()) .. "\" doesn't have a \"damage_" .. tostring(l_142_1) .. "\"-function on its body damage extension.")
		return false, nil
	end
end

CoreBodyDamage.damage_effect = function(l_143_0, l_143_1, l_143_2, l_143_3, l_143_4, l_143_5, l_143_6, l_143_7)
	local l_143_8, l_143_9 = l_143_0._unit_extension:damage_effect, l_143_0._unit_extension
	local l_143_10 = l_143_1
	local l_143_11 = l_143_2
	local l_143_12 = l_143_0._body
	local l_143_13 = l_143_3
	local l_143_14 = l_143_4
	local l_143_15 = l_143_5
	local l_143_16 = l_143_6
	local l_143_17 = l_143_7
	return l_143_8(l_143_9, l_143_10, l_143_11, l_143_12, l_143_13, l_143_14, l_143_15, l_143_16, l_143_17)
end

CoreBodyDamage.endurance_exists = function(l_144_0, l_144_1)
	return l_144_0._endurance[l_144_1] ~= nil
end

CoreBodyDamage.damage_endurance = function(l_145_0, l_145_1, l_145_2, l_145_3, l_145_4, l_145_5, l_145_6, l_145_7)
	if l_145_0._body_element then
		l_145_6 = l_145_6 * l_145_0._body_element._damage_multiplier
	end
	if l_145_0._endurance[l_145_1] then
		local l_145_8 = SequenceEnvironment:new(l_145_1, l_145_2, l_145_0._unit, l_145_0._body, l_145_3, l_145_4, l_145_5, l_145_6, l_145_7, nil, l_145_0._unit_element)
		l_145_0._endurance[l_145_1]:damage(l_145_8)
	end
	return l_145_6
end

CoreBodyDamage.get_body_param = function(l_146_0, l_146_1)
	if l_146_0._body_element then
		local l_146_2, l_146_3 = l_146_0._body_element:get_body_param, l_146_0._body_element
		local l_146_4 = l_146_1
		return l_146_2(l_146_3, l_146_4)
	else
		return nil
	end
end

CoreBodyDamage.set_inflict_damage = function(l_147_0, l_147_1, l_147_2)
	l_147_0:set_inflict_attribute(l_147_1, "damage", l_147_2)
end

CoreBodyDamage.set_inflict_interval = function(l_148_0, l_148_1, l_148_2)
	l_148_0:set_inflict_attribute(l_148_1, "interval", l_148_2)
end

CoreBodyDamage.set_inflict_instant = function(l_149_0, l_149_1, l_149_2)
	l_149_0:set_inflict_attribute(l_149_1, "instant", l_149_2)
end

CoreBodyDamage.set_inflict_enabled = function(l_150_0, l_150_1, l_150_2)
	l_150_0:set_inflict_attribute(l_150_1, "enabled", l_150_2)
end

CoreBodyDamage.get_inflict_damage = function(l_151_0, l_151_1)
	local l_151_2, l_151_3 = l_151_0:get_inflict_attribute, l_151_0
	local l_151_4 = l_151_1
	local l_151_5 = "damage"
	return l_151_2(l_151_3, l_151_4, l_151_5)
end

CoreBodyDamage.get_inflict_interval = function(l_152_0, l_152_1)
	local l_152_2, l_152_3 = l_152_0:get_inflict_attribute, l_152_0
	local l_152_4 = l_152_1
	local l_152_5 = "interval"
	return l_152_2(l_152_3, l_152_4, l_152_5)
end

CoreBodyDamage.get_inflict_instant = function(l_153_0, l_153_1)
	local l_153_2, l_153_3 = l_153_0:get_inflict_attribute, l_153_0
	local l_153_4 = l_153_1
	local l_153_5 = "instant"
	return l_153_2(l_153_3, l_153_4, l_153_5)
end

CoreBodyDamage.get_inflict_enabled = function(l_154_0, l_154_1)
	local l_154_2, l_154_3 = l_154_0:get_inflict_attribute, l_154_0
	local l_154_4 = l_154_1
	local l_154_5 = "enabled"
	return l_154_2(l_154_3, l_154_4, l_154_5)
end

CoreBodyDamage.set_inflict_attribute = function(l_155_0, l_155_1, l_155_2, l_155_3)
	local l_155_4 = l_155_0._inflict[l_155_1]
	if l_155_4 then
		if l_155_3 ~= nil then
			l_155_4[l_155_2] = l_155_3
			return true, true
		else
			return false, true
		end
	else
		local l_155_5 = l_155_0._inflict_updator_map[l_155_1]
		if l_155_5 then
			return l_155_5:set_attribute(l_155_2, l_155_3), true
		end
	else
		return false, false
	end
end

CoreBodyDamage.get_inflict_attribute = function(l_156_0, l_156_1, l_156_2)
	local l_156_8, l_156_9, l_156_10, l_156_11, l_156_12, l_156_13, l_156_14, l_156_15 = nil
	do
		local l_156_3 = l_156_0._inflict[l_156_1]
		if l_156_3 then
			return l_156_3[l_156_2]
		else
			local l_156_4 = l_156_0._inflict_updator_map[l_156_1]
			if l_156_4 then
				local l_156_5, l_156_6 = l_156_4:get_attribute, l_156_4
				local l_156_7 = l_156_2
				return l_156_5(l_156_6, l_156_7)
			end
		else
			if not l_156_0._body or l_156_0._unit then
				error("Tried to get " .. tostring(l_156_2) .. " on non-existing \"" .. tostring(l_156_1) .. "\"-inflict on body \"" .. tostring(l_156_0._body:name()) .. "\" that exist on unit \"" .. tostring(l_156_0._unit:name()) .. "\".")
			end
			return nil
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 43 
end

CoreBodyDamage.save = function(l_157_0, l_157_1)
	local l_157_7, l_157_8, l_157_9, l_157_10, l_157_11, l_157_12, l_157_13, l_157_14, l_157_15, l_157_19, l_157_20, l_157_21, l_157_22, l_157_23, l_157_24, l_157_25, l_157_26, l_157_27, l_157_29, l_157_31 = nil
	local l_157_2 = {}
	local l_157_3 = false
	for i_0,i_1 in pairs(l_157_0._damage) do
		if i_1 ~= 0 then
			l_157_2.damage = table.map_copy(l_157_0._damage)
			l_157_3 = true
	else
		end
	end
	for i_0,i_1 in pairs(l_157_0._inflict) do
		for l_157_30,l_157_32 in pairs(i_1) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_157_21 ~= l_157_0._original_inflict[l_157_16][l_157_20] then
				if not l_157_2.inflict then
					l_157_2.inflict = {}
				end
				if not l_157_2.inflict[l_157_16] then
					l_157_2.inflict[l_157_16] = {}
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_157_2.inflict[l_157_16][l_157_20] = l_157_21
				l_157_3 = true
			end
		end
	end
	for i_0,i_1 in pairs(l_157_0._inflict_updator_map) do
		if i_1:save(R13_PC58) then
			if not nil then
				{}[l_157_33] = {}
			end
			l_157_3 = true
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_157_2.InflictUpdatorMap = {}
	if l_157_3 then
		l_157_1.CoreBodyDamage = l_157_2
	end
	return l_157_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreBodyDamage.load = function(l_158_0, l_158_1)
	local l_158_6, l_158_7, l_158_8, l_158_12, l_158_13, l_158_18, l_158_19, l_158_21 = nil
	local l_158_2 = l_158_1.CoreBodyDamage
	if l_158_2 then
		if l_158_2.damage then
			l_158_0._damage = table.map_copy(l_158_2.damage)
		end
		if l_158_2.inflict then
			for i_0,i_1 in pairs(l_158_2.inflict) do
				for l_158_20,l_158_22 in pairs(l_158_2.inflict) do
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_158_0._inflict[l_158_9][R11_PC24] = R12_PC24
				end
			end
		end
		local l_158_14 = l_158_2.InflictUpdatorMap
	if l_158_14 then
		end
		for i_0,i_1 in pairs(l_158_0._inflict_updator_map) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_158_14[i_0] then
				i_1:load(l_158_14[i_0])
			end
		end
	end
end

if not CoreAfroBodyDamage then
	CoreAfroBodyDamage = class(CoreBodyDamage)
end
CoreAfroBodyDamage.init = function(l_159_0, l_159_1, l_159_2, l_159_3, l_159_4)
	CoreBodyDamage.init(l_159_0, l_159_1, l_159_2, l_159_3, l_159_4)
end

CoreAfroBodyDamage.damage_bullet = function(l_160_0, l_160_1, l_160_2, l_160_3, l_160_4, l_160_5)
	local l_160_6, l_160_7 = l_160_0:damage, l_160_0
	local l_160_8 = "bullet"
	local l_160_9 = l_160_1
	local l_160_10 = l_160_2
	local l_160_11 = l_160_3
	local l_160_12 = l_160_4
	local l_160_13 = l_160_5
	local l_160_14, l_160_15, l_160_16, l_160_17 = Vector3(0, 0, 0), .end
	return l_160_6(l_160_7, l_160_8, l_160_9, l_160_10, l_160_11, l_160_12, l_160_13, l_160_14, l_160_15, l_160_16, l_160_17)
end

CoreAfroBodyDamage.damage_explosion = function(l_161_0, l_161_1, l_161_2, l_161_3, l_161_4, l_161_5)
	local l_161_6, l_161_7 = l_161_0:damage, l_161_0
	local l_161_8 = "explosion"
	local l_161_9 = l_161_1
	local l_161_10 = l_161_2
	local l_161_11 = l_161_3
	local l_161_12 = l_161_4
	local l_161_13 = l_161_5
	local l_161_14, l_161_15, l_161_16, l_161_17 = Vector3(0, 0, 0), .end
	return l_161_6(l_161_7, l_161_8, l_161_9, l_161_10, l_161_11, l_161_12, l_161_13, l_161_14, l_161_15, l_161_16, l_161_17)
end

CoreAfroBodyDamage.damage_collision = function(l_162_0, l_162_1, l_162_2, l_162_3, l_162_4, l_162_5, l_162_6)
	local l_162_7, l_162_8 = l_162_0:damage, l_162_0
	local l_162_9 = "collision"
	local l_162_10 = l_162_1
	local l_162_11 = l_162_2
	local l_162_12 = l_162_3
	local l_162_13 = l_162_4
	local l_162_14 = l_162_5
	local l_162_15 = l_162_6
	return l_162_7(l_162_8, l_162_9, l_162_10, l_162_11, l_162_12, l_162_13, l_162_14, l_162_15)
end

CoreAfroBodyDamage.damage_melee = function(l_163_0, l_163_1, l_163_2, l_163_3, l_163_4, l_163_5)
	local l_163_6, l_163_7 = l_163_0:damage, l_163_0
	local l_163_8 = "melee"
	local l_163_9 = l_163_1
	local l_163_10 = l_163_2
	local l_163_11 = l_163_3
	local l_163_12 = l_163_4
	local l_163_13 = l_163_5
	local l_163_14, l_163_15, l_163_16, l_163_17 = Vector3(0, 0, 0), .end
	return l_163_6(l_163_7, l_163_8, l_163_9, l_163_10, l_163_11, l_163_12, l_163_13, l_163_14, l_163_15, l_163_16, l_163_17)
end

CoreAfroBodyDamage.damage_electricity = function(l_164_0, l_164_1, l_164_2, l_164_3, l_164_4, l_164_5)
	local l_164_6, l_164_7 = l_164_0:damage, l_164_0
	local l_164_8 = "electricity"
	local l_164_9 = l_164_1
	local l_164_10 = l_164_2
	local l_164_11 = l_164_3
	local l_164_12 = l_164_4
	local l_164_13 = l_164_5
	local l_164_14, l_164_15, l_164_16, l_164_17 = Vector3(0, 0, 0), .end
	return l_164_6(l_164_7, l_164_8, l_164_9, l_164_10, l_164_11, l_164_12, l_164_13, l_164_14, l_164_15, l_164_16, l_164_17)
end

CoreAfroBodyDamage.damage_fire = function(l_165_0, l_165_1, l_165_2, l_165_3, l_165_4, l_165_5, l_165_6)
	local l_165_7, l_165_8 = l_165_0:damage, l_165_0
	local l_165_9 = "fire"
	local l_165_10 = l_165_1
	local l_165_11 = l_165_2
	local l_165_12 = l_165_3
	local l_165_13 = l_165_4
	local l_165_14 = l_165_5
	local l_165_15 = l_165_6
	return l_165_7(l_165_8, l_165_9, l_165_10, l_165_11, l_165_12, l_165_13, l_165_14, l_165_15)
end

CoreAfroBodyDamage.damage = function(l_166_0, l_166_1, l_166_2, l_166_3, l_166_4, l_166_5, l_166_6, l_166_7)
	l_166_6 = l_166_0:damage_endurance(l_166_1, l_166_2, l_166_3, l_166_4, l_166_5, l_166_6, l_166_7)
	return false, 0
end

if not CoreDamageWaterCheck then
	CoreDamageWaterCheck = class()
end
CoreDamageWaterCheck.MIN_INTERVAL = 0.2
CoreDamageWaterCheck.DEFAULT_PHYSIC_EFFECT = "water_box"
CoreDamageWaterCheck.init = function(l_167_0, l_167_1, l_167_2, l_167_3, l_167_4, l_167_5, l_167_6, l_167_7, l_167_8)
	l_167_0._unit = l_167_1
	l_167_0._damage_ext = l_167_2
	l_167_0._name = l_167_3
	l_167_0._activation_callbacks_enabled = false
	l_167_0._activation_listener_enabled = false
	l_167_0._current_ref_body_depth = nil
	l_167_0:set_interval(l_167_4)
	l_167_0:set_ref_object(l_167_5)
	l_167_0:set_body_depth(l_167_7)
	l_167_0:set_ref_body(l_167_6)
	do
		if not l_167_8 then
			l_167_0._physic_effect = l_167_0.DEFAULT_PHYSIC_EFFECT
		end
		l_167_0._body_activation_func = callback(l_167_0, l_167_0, "body_activated")
		l_167_0._water_callback_func = callback(l_167_0, l_167_0, "water_collision")
		l_167_0._check_time = TimerManager:game():time() + math.random() * l_167_0._interval
		l_167_0._enter_water = false
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreDamageWaterCheck.is_valid = function(l_168_0)
	if not l_168_0._ref_object then
		return l_168_0._ref_body
	end
end

CoreDamageWaterCheck.update = function(l_169_0, l_169_1, l_169_2)
	if l_169_0._check_time <= l_169_1 and l_169_0:check_active_body() then
		local l_169_3 = l_169_0._in_water_check_func()
	if not l_169_0._enter_water ~= not l_169_3 then
		end
		l_169_0._enter_water = l_169_3
		if l_169_3 then
			l_169_0._damage_ext:water_check_enter(l_169_0._name, l_169_0, l_169_0:get_env_variables(l_169_3))
		end
	else
		l_169_0._damage_ext:water_check_exit(l_169_0._name, l_169_0, l_169_0:get_env_variables(l_169_3))
	end
end

CoreDamageWaterCheck.get_env_variables = function(l_170_0, l_170_1)
	if l_170_1 then
		local l_170_2, l_170_3, l_170_8, l_170_10, l_170_11, l_170_13, l_170_16, l_170_19 = Vector3(0, 0, 1)
	else
		if l_170_0._ref_object then
			local l_170_4 = Vector3(0, 0, -1)
			if alive(l_170_0._ref_body) then
				local l_170_5, l_170_6 = l_170_0._ref_object:position(), l_170_0._ref_body:velocity()
				do
					local l_170_7 = l_170_0._ref_body:in_water()
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			local l_170_15, l_170_18, l_170_21 = , l_170_0._unit:velocity()
			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_170_22 = 0
			if alive(l_170_0._ref_body) then
				l_170_18 = l_170_0._ref_body:position()
				local l_170_9, l_170_12, l_170_14, l_170_17, l_170_20 = nil
			end
		else
			l_170_18 = l_170_0._unit:position()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_170_0._unit, l_170_0._ref_body, l_170_15, l_170_18, l_170_21:normalized(), 0, l_170_21, l_170_22
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 16 
end

CoreDamageWaterCheck.set_update_variables = function(l_171_0)
	if l_171_0._ref_object then
		l_171_0._in_water_check_func = callback(l_171_0, l_171_0, "is_ref_object_in_water")
	else
		if alive(l_171_0._ref_body) then
			l_171_0._in_water_check_func = callback(l_171_0, l_171_0, "is_ref_body_in_water_depth")
		end
	end
end

CoreDamageWaterCheck.check_active_body = function(l_172_0)
	l_172_0._check_time = l_172_0._check_time + l_172_0._interval
	if alive(l_172_0._ref_body) then
		l_172_0._current_ref_body_depth = l_172_0._ref_body:in_water()
	end
	if l_172_0._current_ref_body_depth then
		local l_172_1 = not l_172_0._ref_body:dynamic()
		l_172_1 = l_172_1
		do
			local l_172_2, l_172_4, l_172_6 = nil
		end
		if l_172_0._current_ref_body_depth > 0 or l_172_1 or l_172_0._ref_body:active() == l_172_0._enter_water then
			l_172_0:set_activation_listener_enabled(true)
			return false
		end
		return true
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 23 
end

CoreDamageWaterCheck.set_activation_callbacks_enabled = function(l_173_0, l_173_1)
	if l_173_0._activation_callbacks_enabled ~= l_173_1 then
		l_173_0._activation_callbacks_enabled = l_173_1
		if l_173_1 then
			l_173_0._unit:add_body_activation_callback(l_173_0._body_activation_func)
			l_173_0._unit:add_water_collision_callback(l_173_0._water_callback_func)
		end
	else
		l_173_0._unit:remove_body_activation_callback(l_173_0._body_activation_func)
		l_173_0._unit:remove_water_collision_callback(l_173_0._water_callback_func)
		l_173_0._check_time = TimerManager:game():time() + l_173_0._interval
	end
end

CoreDamageWaterCheck.set_activation_listener_enabled = function(l_174_0, l_174_1)
	if l_174_0._activation_listener_enabled ~= l_174_1 then
		l_174_0._activation_listener_enabled = l_174_1
		l_174_0._damage_ext:set_water_check_active(l_174_0._name, not l_174_1)
		l_174_0:set_activation_callbacks_enabled(l_174_1)
	end
end

CoreDamageWaterCheck.is_ref_object_in_water = function(l_175_0)
	local l_175_1, l_175_2 = World:in_physic_effect, World
	local l_175_3 = l_175_0._physic_effect
	local l_175_4, l_175_5 = l_175_0._ref_object:position(), .end
	return l_175_1(l_175_2, l_175_3, l_175_4, l_175_5)
end

CoreDamageWaterCheck.is_ref_body_in_water_depth = function(l_176_0)
	return not l_176_0._current_ref_body_depth or body_depth < l_176_0._current_ref_body_depth
end

CoreDamageWaterCheck.get_interval = function(l_177_0)
	return l_177_0._interval
end

CoreDamageWaterCheck.set_interval = function(l_178_0, l_178_1)
	local l_178_2 = math.max
	do
		if not l_178_1 then
			l_178_2 = l_178_2(l_178_0.MIN_INTERVAL, l_178_0.MIN_INTERVAL)
			l_178_0._interval = l_178_2
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 6 
end

CoreDamageWaterCheck.get_ref_object = function(l_179_0)
	return l_179_0._ref_object
end

CoreDamageWaterCheck.set_ref_object = function(l_180_0, l_180_1)
	l_180_0._ref_object = l_180_1
	l_180_0:set_activation_listener_enabled(false)
	l_180_0:set_update_variables()
end

CoreDamageWaterCheck.get_ref_body = function(l_181_0)
	return l_181_0._ref_body
end

CoreDamageWaterCheck.set_ref_body = function(l_182_0, l_182_1)
	l_182_0._ref_body = l_182_1
	l_182_0:set_activation_listener_enabled(false)
	if l_182_0._ref_body then
		l_182_0._ref_body_key = l_182_0._ref_body:key()
		l_182_0._ref_body:set_activate_tag("CoreDamageWaterCheck")
		l_182_0._ref_body:set_deactivate_tag("CoreDamageWaterCheck")
		local l_182_2 = l_182_0._ref_body:enter_water_script_tag()
		if not l_182_2 or #l_182_2 == 0 then
			l_182_2 = "CoreDamageWaterCheck"
		end
		l_182_0._ref_body:set_enter_water_script_tag(l_182_2)
		l_182_0._ref_body:set_exit_water_script_tag("CoreDamageWaterCheck")
		l_182_0._ref_body:set_enter_water_script_filter(0)
		l_182_0._ref_body:set_exit_water_script_filter(0)
	end
	l_182_0:set_update_variables()
end

CoreDamageWaterCheck.get_body_depth = function(l_183_0)
	return l_183_0._body_depth
end

CoreDamageWaterCheck.set_body_depth = function(l_184_0, l_184_1)
	local l_184_2 = math.max
	do
		l_184_2 = l_184_2(l_184_1 or 0, 0)
		l_184_0._body_depth = l_184_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreDamageWaterCheck.water_collision = function(l_185_0, l_185_1, l_185_2, l_185_3, l_185_4, l_185_5, l_185_6, l_185_7, l_185_8)
	if not l_185_5 ~= not l_185_0._enter_water and l_185_3:key() == l_185_0._ref_body_key then
		l_185_0:set_activation_listener_enabled(false)
	end
end

CoreDamageWaterCheck.body_activated = function(l_186_0, l_186_1, l_186_2, l_186_3, l_186_4)
	if l_186_4 and l_186_3:key() == l_186_0._ref_body_key then
		l_186_0:set_activation_listener_enabled(false)
	end
end

CoreDamageWaterCheck.to_string = function(l_187_0)
	local l_187_1 = string.format
	local l_187_2 = "[Unit: %s, Name: %s, Enabled: %s, Interval: %g, Object: %s, Body: %s, Body depth: %g]"
	local l_187_3 = l_187_0._unit:name()
	local l_187_4 = l_187_0._name
	local l_187_5 = tostring(l_187_0._damage_ext:is_water_check_active(l_187_0._name))
	local l_187_6 = l_187_0._interval
	local l_187_7 = tostring(alive(l_187_0._ref_object) and l_187_0._ref_object:name() or nil)
	if alive(l_187_0._ref_body) then
		local l_187_10 = tostring
	if not l_187_0._ref_body:name() then
		end
	end
	l_187_10 = l_187_10(nil)
	local l_187_8 = nil
	l_187_8 = l_187_0._body_depth
	local l_187_9 = nil
	return l_187_1(l_187_2, l_187_3, l_187_4, l_187_5, l_187_6, l_187_7, l_187_10, l_187_8)
end

if not CoreInflictUpdator then
	CoreInflictUpdator = class()
end
if not CoreInflictUpdator.INFLICT_UPDATOR_DAMAGE_TYPE_MAP then
	CoreInflictUpdator.INFLICT_UPDATOR_DAMAGE_TYPE_MAP = {}
end
CoreInflictUpdator.MIN_INTERVAL = 0.2
CoreInflictUpdator.init = function(l_188_0, l_188_1, l_188_2, l_188_3, l_188_4, l_188_5)
	l_188_0._unit = l_188_1
	l_188_0._body = l_188_2
	l_188_0._body_damage_ext = l_188_3
	l_188_0._inflict_element = l_188_4
	l_188_0._unit_element = l_188_5
	l_188_0._update_func = callback(l_188_0, l_188_0, "update")
	l_188_0:set_damage(l_188_4:get_damage() or 0)
	l_188_0:set_interval(l_188_4:get_interval() or 1)
	l_188_0:set_instant(l_188_4:get_instant())
	l_188_0:set_enabled(l_188_4:get_enabled())
	l_188_0._original_damage = l_188_0._damage
	l_188_0._original_interval = l_188_0._interval
	l_188_0._original_instant = l_188_0._instant
	l_188_0._original_enabled = l_188_0._enabled
	l_188_0._check_time = TimerManager:game():time() + l_188_0._interval * math.random()
	l_188_0._is_inflicting = false
	l_188_0._set_attribute_func_map = {}
	l_188_0._set_attribute_func_map.damage = callback(l_188_0, l_188_0, "set_damage")
	l_188_0._set_attribute_func_map.interval = callback(l_188_0, l_188_0, "set_interval")
	l_188_0._set_attribute_func_map.instant = callback(l_188_0, l_188_0, "set_instant")
	l_188_0._set_attribute_func_map.enabled = callback(l_188_0, l_188_0, "set_enabled")
	l_188_0._get_attribute_func_map = {}
	l_188_0._get_attribute_func_map.damage = function()
		-- upvalues: l_188_0
		return l_188_0._damage
  end
	l_188_0._get_attribute_func_map.interval = function()
		-- upvalues: l_188_0
		return l_188_0._interval
  end
	l_188_0._get_attribute_func_map.instant = function()
		-- upvalues: l_188_0
		return l_188_0._instant
  end
	l_188_0._get_attribute_func_map.enabled = function()
		-- upvalues: l_188_0
		return l_188_0._enabled
  end
end

CoreInflictUpdator.is_valid = function(l_189_0)
	return true
end

CoreInflictUpdator.set_damage = function(l_190_0, l_190_1)
	do
		if not l_190_1 then
			l_190_0._damage = l_190_0._damage
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreInflictUpdator.set_interval = function(l_191_0, l_191_1)
	local l_191_2 = l_191_0._interval
	local l_191_3 = math.max
	do
		if not l_191_1 then
			l_191_3 = l_191_3(l_191_0._interval, l_191_0.MIN_INTERVAL)
			l_191_0._interval = l_191_3
			if l_191_2 then
				l_191_3 = math
				l_191_3 = l_191_3.clamp
				l_191_3 = l_191_3(l_191_0._check_time, l_191_0._check_time - l_191_2, TimerManager:game():time() + l_191_0._interval)
				l_191_0._check_time = l_191_3
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 7 
end

CoreInflictUpdator.set_instant = function(l_192_0, l_192_1)
	l_192_0._instant = not not l_192_1
end

CoreInflictUpdator.set_enabled = function(l_193_0, l_193_1)
	l_193_1 = not not l_193_1
	if l_193_0._enabled ~= l_193_1 then
		l_193_0._enabled = l_193_1
		if l_193_1 then
			l_193_0._id = managers.sequence:add_callback(l_193_0._update_func)
		end
	elseif l_193_0._id then
		managers.sequence:remove_callback(l_193_0._id)
		l_193_0._id = nil
	end
end

CoreInflictUpdator.save = function(l_194_0, l_194_1)
	local l_194_2 = {}
	local l_194_3 = false
	if l_194_0._original_damage ~= l_194_0._damage then
		l_194_2.damage = l_194_0._damage
		l_194_3 = true
	end
	if l_194_0._original_interval ~= l_194_0._interval then
		l_194_2.interval = l_194_0._interval
		l_194_3 = true
	end
	if not l_194_0._original_instant ~= not l_194_0._instant then
		l_194_2.instant = l_194_0._instant
		l_194_3 = true
	end
	if not l_194_0._original_enabled ~= not l_194_0._enabled then
		l_194_2.enabled = l_194_0._enabled
		l_194_3 = true
	end
	if l_194_3 then
		l_194_1.CoreInflictUpdator = l_194_2
	end
	return l_194_3
end

CoreInflictUpdator.load = function(l_195_0, l_195_1)
	local l_195_2 = l_195_1.CoreInflictUpdator
	if l_195_2 then
		if not l_195_2.damage then
			l_195_0._damage = l_195_0._damage
		end
		if not l_195_2.interval then
			l_195_0._interval = l_195_0._interval
		end
		if l_195_2.instant ~= nil then
			l_195_0:set_instant(l_195_2.instant)
		end
	if l_195_2.enabled ~= nil then
		end
		l_195_0:set_enabled(l_195_2.enabled)
	end
end

CoreInflictUpdator.update = function(l_196_0, l_196_1, l_196_2)
	if l_196_0._check_time <= l_196_1 then
		if alive(l_196_0._unit) then
			l_196_0._check_time = l_196_0._check_time + l_196_0._interval
			l_196_0:check_damage(l_196_1, l_196_2)
		end
	else
		l_196_0:set_enabled(false)
	end
end

CoreInflictUpdator.set_attribute = function(l_197_0, l_197_1, l_197_2)
	if l_197_2 ~= nil then
		local l_197_3 = l_197_0._set_attribute_func_map[l_197_1]
	if l_197_3 then
		end
		l_197_3(l_197_2)
		return true
	end
	return false
end

CoreInflictUpdator.get_attribute = function(l_198_0, l_198_1)
	local l_198_4, l_198_5, l_198_6, l_198_7, l_198_8, l_198_9, l_198_10 = nil
	if l_198_1 then
		local l_198_2 = l_198_0._get_attribute_func_map[l_198_1]
	if l_198_2 then
		end
		local l_198_3 = l_198_2
		return l_198_3()
	end
	if not l_198_0._body or l_198_0._unit then
		error("Tried to get non existing attribute \"" .. tostring(l_198_1) .. "\" on body \"" .. tostring(l_198_0._body:name()) .. "\" that exist on unit \"" .. tostring(l_198_0._unit:name()) .. "\".")
		return nil
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 32 
end

if not CoreInflictFireUpdator then
	CoreInflictFireUpdator = class(CoreInflictUpdator)
end
CoreInflictUpdator.INFLICT_UPDATOR_DAMAGE_TYPE_MAP.fire = CoreInflictFireUpdator
CoreInflictFireUpdator.SPHERE_CHECK_SLOTMASK = "fire_damage"
CoreInflictFireUpdator.SPHERE_CHECK_PADDING = 200
CoreInflictFireUpdator.DAMAGE_TYPE = "fire"
CoreInflictFireUpdator.init = function(l_199_0, l_199_1, l_199_2, l_199_3, l_199_4, l_199_5)
	CoreInflictUpdator.init(l_199_0, l_199_1, l_199_2, l_199_3, l_199_4, l_199_5)
	l_199_0._slotmask = managers.slot:get_mask(l_199_0.SPHERE_CHECK_SLOTMASK)
	if not l_199_0._inflict_element:get_velocity() then
		l_199_0._velocity = Vector3()
	end
	l_199_0._falloff = l_199_0._inflict_element:get_falloff()
	l_199_0._fire_height = math.max(l_199_4:get_fire_height() or 0, 0)
	l_199_0._original_fire_object_name = l_199_4:get_fire_object_name()
	l_199_0:set_fire_object_name(l_199_0._original_fire_object_name)
	l_199_0._original_velocity = l_199_0._velocity
	l_199_0._original_falloff = l_199_0._falloff
	l_199_0._original_fire_height = l_199_0._fire_height
	local l_199_6 = l_199_4:get_enter_element()
	if l_199_6 then
		l_199_0._enter_element_func = callback(l_199_6, l_199_6, "activate")
	end
	if l_199_4:get_exit_element() then
		l_199_0._exit_element_func = callback(l_199_4:get_exit_element(), l_199_4:get_exit_element(), "activate")
	end
	do
		if l_199_4:get_damage_element() then
			l_199_0._damage_element_func = callback(l_199_4:get_damage_element(), l_199_4:get_damage_element(), "activate")
		end
		l_199_0._set_attribute_func_map.fire_object = callback(l_199_0, l_199_0, "set_fire_object_name")
		l_199_0._set_attribute_func_map.fire_height = callback(l_199_0, l_199_0, "set_fire_height")
		l_199_0._set_attribute_func_map.velocity = callback(l_199_0, l_199_0, "set_velocity")
		l_199_0._set_attribute_func_map.falloff = callback(l_199_0, l_199_0, "set_falloff")
		l_199_0._get_attribute_func_map.fire_object = function()
		-- upvalues: l_199_0
		return l_199_0._fire_object
  end
		l_199_0._get_attribute_func_map.fire_height = function()
		-- upvalues: l_199_0
		return l_199_0._fire_height
  end
		l_199_0._get_attribute_func_map.velocity = function()
		-- upvalues: l_199_0
		return l_199_0._velocity
  end
		l_199_0._get_attribute_func_map.falloff = function()
		-- upvalues: l_199_0
		return l_199_0._falloff
  end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreInflictFireUpdator.is_valid = function(l_200_0)
	return not CoreInflictUpdator.is_valid(l_200_0) or l_200_0._fire_object ~= nil
end

CoreInflictFireUpdator.set_fire_object_name = function(l_201_0, l_201_1)
	do
		if l_201_1 then
			l_201_0._fire_object = l_201_0._unit:get_object(l_201_1)
		end
		if not l_201_0._fire_object then
			l_201_0:set_enabled(false)
			Application:error("Invalid inflict fire element object \"" .. tostring(l_201_1) .. "\".")
			l_201_0._body_damage_ext:get_inflict_updator_map()[l_201_0.DAMAGE_TYPE] = nil
			return 
		end
		l_201_0:set_fire_height(l_201_0._fire_height)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreInflictFireUpdator.set_fire_height = function(l_202_0, l_202_1)
	l_202_0._fire_height = l_202_1
	l_202_0._sphere_check_range = l_202_0._fire_object:oobb():size() / 2:length() + l_202_0._fire_height + l_202_0.SPHERE_CHECK_PADDING
end

CoreInflictFireUpdator.set_velocity = function(l_203_0, l_203_1)
	l_203_0._velocity = l_203_1
end

CoreInflictFireUpdator.set_falloff = function(l_204_0, l_204_1)
	l_204_0._falloff = l_204_1
end

CoreInflictFireUpdator.save = function(l_205_0, l_205_1)
	local l_205_2 = {}
	local l_205_3 = CoreInflictUpdator.save(l_205_0, l_205_1)
	if l_205_0._original_fire_object_name ~= l_205_0._fire_object:name() then
		l_205_2.fire_object_name = l_205_0._fire_object:name()
		l_205_3 = true
	end
	if l_205_0._original_velocity ~= l_205_0._velocity then
		l_205_2.velocity = l_205_0._velocity
		l_205_3 = true
	end
	if l_205_0._original_falloff ~= l_205_0._falloff then
		l_205_2.falloff = l_205_0._falloff
		l_205_3 = true
	end
	if l_205_0._original_fire_height ~= l_205_0._fire_height then
		l_205_2.fire_height = l_205_0._fire_height
		l_205_3 = true
	end
	if l_205_3 then
		l_205_1.CoreInflictFireUpdator = l_205_2
	end
	return l_205_3
end

CoreInflictFireUpdator.load = function(l_206_0, l_206_1)
	CoreInflictUpdator.load(l_206_0, l_206_1)
	local l_206_2 = l_206_1.CoreInflictUpdator
	if l_206_2 then
		if l_206_2.fire_object_name then
			l_206_0:set_fire_object_name(l_206_2.fire_object_name)
		end
		if l_206_2.fire_height then
			l_206_0:set_fire_height(l_206_2.fire_height)
		end
		if not l_206_2.velocity then
			l_206_0._velocity = l_206_0._velocity
		end
		if not l_206_2.falloff then
			l_206_0._falloff = l_206_0._falloff
		end
	end
end

CoreInflictFireUpdator.check_damage = function(l_207_0, l_207_1, l_207_2)
	local l_207_11, l_207_12, l_207_13, l_207_14, l_207_20, l_207_21, l_207_22, l_207_23 = nil
	local l_207_3 = l_207_0._fire_object:oobb()
	local l_207_4 = l_207_3:center()
	local l_207_5 = (l_207_0._unit:find_units_quick("sphere", l_207_4, l_207_0._sphere_check_range, l_207_0._slotmask))
	local l_207_6, l_207_7 = nil, nil
	for i_0,i_1 in ipairs(l_207_5) do
		if managers.sequence:get_inflict_updator_body_map(l_207_0.DAMAGE_TYPE, i_1:key()) then
			for i_0,i_1 in pairs(managers.sequence:get_inflict_updator_body_map(l_207_0.DAMAGE_TYPE, i_1:key())) do
				local l_207_17, l_207_18 = nil
				if alive(i_1:get_body()) then
					local l_207_28 = nil
					local l_207_29 = nil
					local l_207_30 = (l_207_3:principal_distance(i_1:get_body():oobb()))
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					if l_207_30 > 0 and nil then
						if l_207_0._falloff and l_207_0._fire_height > 0 then
							do return end
						end
						 -- DECOMPILER ERROR: Overwrote pending register.

					end
					do return end
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					if l_207_29 then
						local l_207_31 = nil
						if not l_207_0._is_inflicting and l_207_0._enter_element_func then
							local l_207_32, l_207_33 = nil
							local l_207_34 = nil
							local l_207_35 = l_207_0._is_inflicting
							local l_207_36 = SequenceEnvironment:new
							local l_207_37 = SequenceEnvironment
							local l_207_38 = l_207_0.DAMAGE_TYPE
							local l_207_39 = l_207_16
							local l_207_40 = l_207_0._unit
							local l_207_41 = l_207_0._body
							local l_207_42 = l_207_32
							local l_207_43 = l_207_31
							l_207_36 = l_207_36(l_207_37, l_207_38, l_207_39, l_207_40, l_207_41, l_207_42, l_207_43, l_207_33, l_207_34, l_207_0._velocity, {distance = l_207_30}, l_207_0._unit_element)
							l_207_37 = l_207_0._enter_element_func
							l_207_38 = l_207_36
							l_207_37(l_207_38)
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						if l_207_35 or l_207_0._instant then
							if l_207_0._damage_element_func then
								local l_207_44, l_207_45 = nil
								local l_207_46 = nil
								local l_207_47 = nil
								local l_207_48 = SequenceEnvironment:new
								local l_207_49 = SequenceEnvironment
								local l_207_50 = l_207_0.DAMAGE_TYPE
								local l_207_51 = l_207_16
								local l_207_52 = l_207_0._unit
								local l_207_53 = l_207_0._body
								local l_207_54 = l_207_44
								local l_207_55 = l_207_31
								l_207_48 = l_207_48(l_207_49, l_207_50, l_207_51, l_207_52, l_207_53, l_207_54, l_207_55, l_207_45, l_207_46, l_207_0._velocity, {distance = l_207_30}, l_207_0._unit_element)
								l_207_49 = l_207_0._damage_element_func
								l_207_50 = l_207_48
								l_207_49(l_207_50)
							end
							 -- DECOMPILER ERROR: Confused about usage of registers!

							 -- DECOMPILER ERROR: Confused about usage of registers!

							 -- DECOMPILER ERROR: Confused about usage of registers!

							l_207_27:damage_fire(l_207_0._unit, l_207_44, l_207_31, l_207_45, l_207_46, l_207_0._velocity)
						end
					elseif l_207_0._exit_element_func and not l_207_7 then
						local l_207_56, l_207_57 = nil
						local l_207_58 = nil
						local l_207_59 = nil
						local l_207_60 = SequenceEnvironment:new
						local l_207_61 = SequenceEnvironment
						local l_207_62 = l_207_0.DAMAGE_TYPE
						local l_207_63 = l_207_16
						local l_207_64 = l_207_0._unit
						local l_207_65 = l_207_0._body
						local l_207_66 = -l_207_58
						local l_207_67 = l_207_29
						l_207_60 = l_207_60(l_207_61, l_207_62, l_207_63, l_207_64, l_207_65, l_207_66, l_207_67, l_207_58, l_207_59, l_207_0._velocity, {distance = l_207_30}, l_207_0._unit_element)
						l_207_7 = l_207_60
					end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				else
					managers.sequence:remove_inflict_updator_body(l_207_0.DAMAGE_TYPE, l_207_17, l_207_26)
				end
			end
		end
	end
	if not l_207_6 and l_207_0._is_inflicting then
		l_207_0._is_inflicting = false
	if l_207_7 then
		end
		l_207_0._exit_element_func(l_207_7)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


