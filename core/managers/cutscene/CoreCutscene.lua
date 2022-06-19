require("core/managers/cutscene/CoreCutsceneKeys")
require("core/managers/cutscene/CoreCutsceneKeyCollection")
if not CoreCutscene then
	CoreCutscene = frozen_class()
end
mixin(CoreCutscene, CoreCutsceneKeyCollection)
local l_0_0 = 30
CoreCutscene._all_keys_sorted_by_time = function(l_1_0)
	if not l_1_0._keys then
		return {}
	end
end

CoreCutscene.init = function(l_2_0, l_2_1, l_2_2)
	assert(l_2_1, "No cutscene XML node supplied.")
	assert(l_2_2, "Must supply a reference to the CutsceneManager.")
	l_2_0._name = l_2_1:parameter("name")
	l_2_0._unit_name = l_2_1:parameter("unit")
	local l_2_6, l_2_10 = tonumber, l_2_1:parameter("frames")
	l_2_6 = l_2_6(l_2_10)
	l_2_0._frame_count = l_2_6
	l_2_0._keys, l_2_6 = l_2_6, {}
	l_2_0._unit_types, l_2_6 = l_2_6, {}
	l_2_0._unit_animations, l_2_6 = l_2_6, {}
	l_2_0._unit_blend_sets, l_2_6 = l_2_6, {}
	l_2_0._camera_names, l_2_6 = l_2_6, {}
	l_2_6, l_2_10 = l_2_0:_parse_animation_blobs, l_2_0
	l_2_6 = l_2_6(l_2_10, l_2_1)
	l_2_0._animation_blobs = l_2_6
	l_2_6, l_2_10 = l_2_1:children, l_2_1
	l_2_6 = l_2_6(l_2_10)
	for i_0 in l_2_6 do
		local l_2_5 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_2_5 == "controlled_units" then
			for i_0 in l_2_5 do
				local l_2_11 = l_2_9:parameter("name")
				l_2_0._unit_types[l_2_11] = l_2_2:cutscene_actor_unit_type(l_2_0:_cutscene_specific_unit_type(l_2_9:parameter("type")))
				l_2_0._unit_animations[l_2_11] = l_2_9:parameter("animation")
				l_2_0._unit_blend_sets[l_2_11] = l_2_9:parameter("blend_set")
				if string.begins(l_2_11, "camera") then
					table.insert(l_2_0._camera_names, l_2_11)
				end
			end
		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			if l_2_5(l_2_4) == "keys" then
				for i_0 in l_2_4:children() do
					CoreCutsceneKey:create(i_0:name(), l_2_0):load(i_0)
					table.insert(l_2_0._keys, freeze(CoreCutsceneKey:create(i_0:name(), l_2_0)))
				end
			end
		end
	end
	table.sort(l_2_0._camera_names)
	table.sort(l_2_0._keys, function(l_3_0, l_3_1)
		return l_3_0:frame() < l_3_1:frame()
  end)
	freeze(l_2_0._keys, l_2_0._unit_types, l_2_0._unit_animations, l_2_0._unit_blend_sets, l_2_0._camera_names)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscene.is_valid = function(l_3_0)
	return table.empty(l_3_0._unit_types) or UnitDatabase:get_unit_data(l_3_0:unit_name()) ~= nil
end

CoreCutscene.name = function(l_4_0)
	return l_4_0._name or ""
end

CoreCutscene.unit_name = function(l_5_0)
	return l_5_0._unit_name or ""
end

CoreCutscene.frames_per_second = function(l_6_0)
	-- upvalues: l_0_0
	return l_0_0
end

CoreCutscene.frame_count = function(l_7_0)
	return l_7_0._frame_count or 1
end

CoreCutscene.duration = function(l_8_0)
	return l_8_0:frame_count() / l_8_0:frames_per_second()
end

CoreCutscene.is_optimized = function(l_9_0)
	local l_9_1 = table.empty
	local l_9_2 = l_9_0._unit_animations
	return l_9_1(l_9_2)
end

CoreCutscene.has_cameras = function(l_10_0)
	return not table.empty(l_10_0._camera_names)
end

CoreCutscene.has_unit = function(l_11_0, l_11_1, l_11_2)
	local l_11_6 = nil
	if l_11_0:controlled_unit_types()[l_11_1] ~= nil then
		return true
	end
	if l_11_2 then
		for i_0 in l_11_0:keys(CoreSpawnUnitCutsceneKey.ELEMENT_NAME) do
			if i_0:name() == l_11_1 then
				return true
			end
		end
	end
	return false
end

CoreCutscene.controlled_unit_types = function(l_12_0)
	return l_12_0._unit_types
end

CoreCutscene.camera_names = function(l_13_0)
	return l_13_0._camera_names
end

CoreCutscene.default_camera = function(l_14_0)
	local l_14_4, l_14_5 = ipairs, l_14_0:camera_names()
	l_14_4 = l_14_4(l_14_5)
	for i_0,i_1 in l_14_4 do
		return l_14_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscene.objects_in_unit = function(l_15_0, l_15_1)
	local l_15_4 = l_15_0:_actor_database_info
	l_15_4 = l_15_4(l_15_0, l_15_1)
	local l_15_2, l_15_3 = l_15_4
	return l_15_4(l_15_2)
end

CoreCutscene.extensions_on_unit = function(l_16_0, l_16_1)
	local l_16_4 = l_16_0:_actor_database_info
	l_16_4 = l_16_4(l_16_0, l_16_1)
	local l_16_2, l_16_3 = l_16_4
	return l_16_4(l_16_2)
end

CoreCutscene.animation_for_unit = function(l_17_0, l_17_1)
	return l_17_0._unit_animations[l_17_1]
end

CoreCutscene.blend_set_for_unit = function(l_18_0, l_18_1)
	return l_18_0._unit_blend_sets[l_18_1] or "all"
end

CoreCutscene.animation_blobs = function(l_19_0)
	return l_19_0._animation_blobs
end

CoreCutscene.find_spawned_orientation_unit = function(l_20_0)
	local l_20_5, l_20_6 = World:unit_manager():get_units, World:unit_manager()
	l_20_5 = l_20_5(l_20_6, managers.slot:get_mask("cutscenes"))
	local l_20_1 = nil
	l_20_6 = ipairs
	l_20_1 = l_20_5
	l_20_6 = l_20_6(l_20_1)
	for i_0,i_1 in l_20_6 do
		if l_20_4:name() == l_20_0:unit_name() then
			return l_20_4
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscene._parse_animation_blobs = function(l_21_0, l_21_1)
	if not l_21_0:_parse_animation_blob_list(l_21_1) then
		return l_21_0:_parse_single_animation_blob(l_21_1)
	end
end

CoreCutscene._parse_animation_blob_list = function(l_22_0, l_22_1)
	local l_22_5, l_22_6, l_22_7, l_22_12, l_22_13, l_22_14, l_22_16 = nil
	for i_0 in l_22_1:children() do
		if i_0:name() == "animation_blobs" then
			for i_0 in l_22_8:children() do
				local l_22_9 = {}
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if i_0:name() == "part" and i_0:parameter("animation_blob") or nil then
					table.insert(l_22_9, i_0:name() == "part" and i_0:parameter("animation_blob") or nil)
				end
			end
			return l_22_9
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscene._parse_single_animation_blob = function(l_23_0, l_23_1)
	local l_23_5, l_23_6, l_23_7 = nil
	for i_0 in l_23_1:children() do
		if i_0:name() == "controlled_units" then
			if i_0:parameter("animation_blob") then
				return {i_0:parameter("animation_blob")}
			end
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutscene._actor_database_info = function(l_24_0, l_24_1)
	local l_24_2 = assert(l_24_0:controlled_unit_types()[l_24_1], string.format("Unit \"%s\" is not in cutscene \"%s\".", l_24_1, l_24_0:name()))
	return assert(managers.cutscene:actor_database():unit_type_info(l_24_2), string.format("Unit type \"%s\", used in cutscene \"%s\", is not registered in the actor database.", l_24_2, l_24_0:name()))
end

CoreCutscene._cutscene_specific_unit_type = function(l_25_0, l_25_1)
	if l_25_1 ~= "locator" and UnitDatabase:get_unit_data(l_25_1 .. "_cutscene") then
		l_25_1 = l_25_1 .. "_cutscene"
	end
	return l_25_1
end

CoreCutscene._debug_persistent_keys = function(l_26_0)
	local l_26_6, l_26_7, l_26_12, l_26_13 = nil
	local l_26_1 = {}
	local l_26_2 = l_26_0:controlled_unit_types()
	for i_0 in l_26_0:keys(CoreSequenceCutsceneKey.ELEMENT_NAME) do
		local l_26_9 = l_26_2[i_0:unit_name()]
		local l_26_10 = string.format
		if not l_26_9 then
			l_26_10 = l_26_10("Sequence %s.%s", "\"" .. l_26_8:unit_name() .. "\"", l_26_8:name())
			l_26_1[l_26_10] = true
		end
		for i_0 in l_26_0:keys(CoreUnitCallbackCutsceneKey.ELEMENT_NAME) do
			local l_26_16 = l_26_2[i_0:unit_name()]
			do
				if not l_26_16 then
					l_26_1[string.format("Callback %s:%s():%s()", "\"" .. l_26_15:unit_name() .. "\"", l_26_15:extension(), l_26_15:method())] = true
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			return l_26_1
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 22 46 
end


