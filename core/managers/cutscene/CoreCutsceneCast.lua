if not CoreCutsceneCast then
	CoreCutsceneCast = class()
end
CoreCutsceneCast.FLOAT_ERROR_TIME_COMPENSATION = 1e-005
CoreCutsceneCast.prime = function(l_1_0, l_1_1)
	local l_1_2 = assert
	do
		if l_1_1 then
			l_1_2(l_1_1:is_valid(), "Attempting to prime invalid cutscene.")
		end
		l_1_2 = true
		l_1_0:_actor_units_in_cutscene(l_1_1, l_1_2)
		l_1_0:_animation_blob_controller(l_1_1, l_1_2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneCast.unload = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17, l_2_18, l_2_19, l_2_20, l_2_21, l_2_22, l_2_23, l_2_24, l_2_25 = nil
	if not l_2_0._animation_blob_controllers then
		for i_0,i_1 in pairs({}) do
		end
		if i_1 ~= false and alive(i_1) then
			if i_1:is_playing() then
				i_1:stop()
			end
			i_1:destroy()
		end
	end
	l_2_0._animation_blob_controllers = nil
	if not l_2_0._spawned_units then
		for i_0,i_1 in pairs({}) do
		end
		if alive(i_1) then
			World:delete_unit(i_1)
		end
	end
	if alive(l_2_0.__root_unit) then
		World:delete_unit(l_2_0.__root_unit)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

CoreCutsceneCast.is_ready = function(l_3_0, l_3_1)
	if not l_3_1 or l_3_0:_animation_blob_controller(l_3_1) ~= nil then
		local l_3_3 = nil
		return l_3_0:_animation_blob_controller(l_3_1):ready()
	end
end

CoreCutsceneCast.set_timer = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13, l_4_14 = nil
	if not l_4_0._spawned_units then
		for i_0,i_1 in pairs({}) do
		end
		if alive(i_1) then
			i_1:set_timer(l_4_1)
			i_1:set_animation_timer(l_4_1)
		end
	end
end

CoreCutsceneCast.set_cutscene_visible = function(l_5_0, l_5_1, l_5_2)
	local l_5_6, l_5_7, l_5_8, l_5_9, l_5_10 = nil
	if not l_5_0._spawned_units then
		for i_0,i_1 in pairs({}) do
		end
		if l_5_1:has_unit(i_0, true) then
			local l_5_13 = l_5_0:_set_unit_and_children_visible
			if l_5_2 then
				l_5_13(l_5_0, l_5_12, l_5_0:unit_visible(l_5_11))
			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneCast.set_unit_visible = function(l_6_0, l_6_1, l_6_2)
	l_6_2 = not not l_6_2
	if not l_6_0._hidden_units then
		l_6_0._hidden_units = {}
	end
	local l_6_3 = not l_6_0._hidden_units[l_6_1]
	if l_6_2 ~= l_6_3 then
		local l_6_4 = l_6_0._hidden_units
		if l_6_2 then
			local l_6_5 = nil
			l_6_5 = l_6_5
		end
		l_6_4[l_6_1] = l_6_5
		l_6_4, l_6_5 = l_6_0:unit, l_6_0
		l_6_4 = l_6_4(l_6_5, l_6_1)
	if l_6_4 then
		end
		l_6_5(l_6_0, l_6_4, l_6_2)
	end
end

CoreCutsceneCast.unit_visible = function(l_7_0, l_7_1)
	return l_7_0._hidden_units and l_7_0._hidden_units[l_7_1] == nil
end

CoreCutsceneCast.unit = function(l_8_0, l_8_1)
	if l_8_0._spawned_units then
		return l_8_0._spawned_units[l_8_1]
	end
end

CoreCutsceneCast.actor_unit = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = l_9_0:unit(l_9_1)
	if l_9_3 and l_9_2:has_unit(l_9_1) then
		return l_9_3
	end
	do return end
	return l_9_0:_actor_units_in_cutscene(l_9_2)[l_9_1]
end

CoreCutsceneCast.unit_names = function(l_10_0)
	if not l_10_0._spawned_units or not table.map_keys(l_10_0._spawned_units) then
		return {}
	end
end

CoreCutsceneCast.evaluate_cutscene_at_time = function(l_11_0, l_11_1, l_11_2)
	l_11_0._last_evaluated_cutscene = l_11_0._last_evaluated_cutscene or l_11_1
	if l_11_1 ~= l_11_0._last_evaluated_cutscene then
		l_11_0:_stop_animations_on_actor_units_in_cutscene(l_11_0._last_evaluated_cutscene)
	end
	local l_11_3 = l_11_1:find_spawned_orientation_unit()
	if l_11_3 and l_11_0:_root_unit():parent() ~= l_11_3 then
		l_11_0:_reparent_to_locator_unit(l_11_3, l_11_0:_root_unit())
	end
	local l_11_4 = l_11_0:_animation_blob_controller(l_11_1)
	if l_11_4 and l_11_4:ready() then
		if not l_11_4:is_playing() then
			local l_11_5 = l_11_0:_actor_units_in_cutscene(l_11_1)
			local l_11_6 = table.remap(l_11_5, function(l_12_0)
				-- upvalues: l_11_1
				return l_12_0, l_11_1:blend_set_for_unit(l_12_0)
      end)
			l_11_4:play(l_11_5, l_11_6)
			l_11_4:pause()
		end
		l_11_4:set_time(l_11_2 + l_11_0.FLOAT_ERROR_TIME_COMPENSATION)
	end
	do return end
	local l_11_10, l_11_11 = pairs, l_11_0:_actor_units_in_cutscene(l_11_1)
	l_11_10 = l_11_10(l_11_11)
	for i_0,i_1 in l_11_10 do
		local l_11_12 = l_11_1:animation_for_unit(l_11_8)
		if l_11_12 then
			local l_11_13 = l_11_9:anim_state_machine()
			if not l_11_13:enabled() then
				l_11_13:set_enabled(true)
			if not l_11_0:_state_machine_is_playing_raw_animation(l_11_13, l_11_12) then
				end
				l_11_13:play_raw(l_11_12)
			end
			local l_11_14 = l_11_1:duration()
			if l_11_14 ~= 0 or not 0 then
				local l_11_15, l_11_16 = l_11_2 / l_11_14
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_11_13:set_parameter(l_11_12, "t", l_11_15)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	l_11_0._last_evaluated_cutscene = l_11_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneCast.evaluate_object_at_time = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4)
	assert(l_12_1:is_optimized(), "Currently only supported with optimized cutscenes.")
	local l_12_5 = l_12_0:_animation_blob_controller(l_12_1)
	if alive(l_12_5) and l_12_5:ready() and l_12_5:is_playing() then
		local l_12_6 = l_12_2 .. l_12_3
		local l_12_7 = l_12_4 + l_12_0.FLOAT_ERROR_TIME_COMPENSATION
		return l_12_5:position(l_12_6, l_12_7), l_12_5:rotation(l_12_6, l_12_7)
	else
		return Vector3(0, 0, 0), Rotation()
	end
end

CoreCutsceneCast.spawn_unit = function(l_13_0, l_13_1, l_13_2)
	local l_13_3 = UnitDatabase:get_unit_data(l_13_2)
	if l_13_3 then
		cat_print("cutscene", string.format("[CoreCutsceneCast] Spawning \"%s\" named \"%s\".", l_13_2, l_13_1))
		World:effect_manager():set_spawns_enabled(false)
		local l_13_4 = World:spawn_unit(l_13_2, Vector3(0, 0, 0), Rotation())
		World:effect_manager():set_spawns_enabled(true)
		l_13_4:set_timer(managers.cutscene:timer())
		l_13_4:set_animation_timer(managers.cutscene:timer())
		l_13_0:_reparent_to_locator_unit(l_13_0:_root_unit(), l_13_4)
		l_13_0:_set_unit_and_children_visible(l_13_4, false)
		l_13_4:set_animation_lod(1, 100000, 10000000, 10000000)
		if l_13_4:cutscene() and l_13_4:cutscene().setup then
			l_13_4:cutscene():setup()
		end
		if l_13_4:anim_state_machine() then
			l_13_4:anim_state_machine():set_enabled(false)
		end
		managers.cutscene:actor_database():append_unit_info(l_13_4)
		if not l_13_0._spawned_units then
			l_13_0._spawned_units = {}
		end
		l_13_0._spawned_units[l_13_1] = l_13_4
		return l_13_4
	else
		error("Unit type \"" .. tostring(l_13_2) .. "\" not found.")
	end
end

CoreCutsceneCast.delete_unit = function(l_14_0, l_14_1)
	local l_14_2 = l_14_0:unit(l_14_1)
	if l_14_2 and alive(l_14_2) then
		local l_14_3 = l_14_2:name()
		World:delete_unit(l_14_2)
	end
	if l_14_0._spawned_units then
		l_14_0._spawned_units[l_14_1] = nil
	end
	if l_14_0._hidden_units then
		l_14_0._hidden_units[l_14_1] = nil
	end
	return l_14_2 ~= nil
end

CoreCutsceneCast.rename_unit = function(l_15_0, l_15_1, l_15_2)
	local l_15_3 = l_15_0:unit(l_15_1)
	if l_15_3 then
		l_15_0._spawned_units[l_15_1] = nil
		l_15_0._spawned_units[l_15_2] = l_15_3
		if l_15_0._hidden_units and l_15_0._hidden_units[l_15_1] then
			l_15_0._hidden_units[l_15_1] = nil
			l_15_0._hidden_units[l_15_2] = true
		end
		return true
	end
	return false
end

CoreCutsceneCast._stop_animations_on_actor_units_in_cutscene = function(l_16_0, l_16_1)
	local l_16_2 = l_16_0:_animation_blob_controller(l_16_1)
	if l_16_2 then
		l_16_2:stop()
	else
		local l_16_6, l_16_7 = pairs, l_16_0:_actor_units_in_cutscene(l_16_1)
		l_16_6 = l_16_6(l_16_7)
		for i_0,i_1 in l_16_6 do
			local l_16_8 = l_16_5:anim_state_machine()
			if l_16_8 then
				l_16_8:set_enabled(false)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutsceneCast._state_machine_is_playing_raw_animation = function(l_17_0, l_17_1, l_17_2)
	local l_17_3 = table.collect(l_17_1:config():states(), function(l_18_0)
		local l_18_1, l_18_2 = l_18_0:name, l_18_0
		return l_18_1(l_18_2)
  end)
	if table.contains(l_17_3, l_17_2) then
		return l_17_1:is_playing(l_17_2)
	end
end

CoreCutsceneCast._reparent_to_locator_unit = function(l_18_0, l_18_1, l_18_2)
	local l_18_3 = assert(l_18_1:get_object("locator"), "Parent does not have an Object named \"locator\".")
	l_18_2:unlink()
	l_18_1:link(l_18_3:name(), l_18_2, l_18_2:orientation_object():name())
end

CoreCutsceneCast._set_unit_and_children_visible = function(l_19_0, l_19_1, l_19_2, l_19_3)
	l_19_1:set_visible(l_19_2)
	l_19_1:set_enabled(l_19_2)
	if not l_19_3 then
		if not l_19_0._spawned_units then
			l_19_3 = table.remap({}, function(l_20_0, l_20_1)
		return l_20_1, true
  end)
		end
		local l_19_7, l_19_8 = ipairs, l_19_1:children()
		l_19_7 = l_19_7(l_19_8)
		for i_0,i_1 in l_19_7 do
			if not l_19_3[l_19_6] then
				l_19_0:_set_unit_and_children_visible(l_19_6, l_19_2, l_19_3)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

CoreCutsceneCast._animation_blob_controller = function(l_20_0, l_20_1, l_20_2)
	if l_20_1:animation_blobs() == nil then
		return nil
	end
	if not l_20_0._animation_blob_controllers then
		l_20_0._animation_blob_controllers = {}
	end
	local l_20_3 = l_20_0._animation_blob_controllers[l_20_1]
	if l_20_3 == nil then
		if not l_20_2 then
			Application:error("The cutscene \"" .. l_20_1:name() .. "\" was not preloaded, causing a performance spike.")
		end
		l_20_3 = CutScene:load(l_20_1:animation_blobs())
		l_20_0._animation_blob_controllers[l_20_1] = l_20_3
	end
	return l_20_3
end

CoreCutsceneCast._actor_units_in_cutscene = function(l_21_0, l_21_1, l_21_2)
	if not l_21_0._spawned_units then
		l_21_0._spawned_units = {}
	end
	local l_21_3 = {}
	local l_21_7, l_21_8 = pairs, l_21_1:controlled_unit_types()
	l_21_7 = l_21_7(l_21_8)
	for i_0,i_1 in l_21_7 do
		local l_21_9 = l_21_0._spawned_units[l_21_5]
		if l_21_9 == nil then
			if l_21_2 and UnitDatabase:get_unit_data(l_21_6) ~= nil then
				World:preload_unit(l_21_6)
			end
			l_21_9 = l_21_0:spawn_unit(l_21_5, l_21_6)
		else
			if not alive(l_21_9) then
				cat_print("debug", string.format("[CoreCutsceneCast] Zombie Unit detected! Actor \"%s\" of unit type \"%s\" in cutscene \"%s\".", l_21_5, l_21_6, l_21_1:name()))
				l_21_9 = nil
			end
		else
			local l_21_10 = assert
			l_21_10(l_21_9:name() == l_21_6, "Named unit type mismatch.")
		end
		l_21_3[l_21_5] = l_21_9
	end
	return l_21_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneCast._root_unit = function(l_22_0)
	if l_22_0.__root_unit == nil then
		l_22_0.__root_unit = World:spawn_unit("locator", Vector3(0, 0, 0), Rotation())
	end
	return l_22_0.__root_unit
end


