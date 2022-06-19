if not CoreWorldDefinition then
	CoreWorldDefinition = class()
end
if not CoreHubElementUnit then
	CoreHubElementUnit = class()
end
if not WorldHolder then
	WorldHolder = class()
end
WorldHolder.get_world_file = function(l_1_0)
	return l_1_0._world_file
end

WorldHolder.init = function(l_2_0, l_2_1)
	l_2_0._worlds = {}
	l_2_0._world_file = l_2_1
	if l_2_0._world_file then
		local l_2_2 = string.reverse(l_2_1)
		local l_2_3 = string.find(l_2_2, "\\")
		l_2_0._world_dir = string.reverse(string.sub(l_2_2, l_2_3))
		if not rawget(_G, "WorldDefinition") then
			local l_2_4, l_2_5, l_2_9, l_2_10, l_2_11, l_2_12, l_2_23 = rawget(_G, "CoreWorldDefinition")
		end
		if string.find(l_2_0._world_file, ".level", 1, true) then
			if File:exists(l_2_0._world_file) then
				l_2_0._level_file = l_2_0._world_file
				local l_2_6 = nil
				local l_2_7 = Level:load(l_2_0._level_file)
				local l_2_8 = l_2_0._worlds
				local l_2_17, l_2_18, l_2_19, l_2_20 = l_2_7:data("world").name, l_2_6:new, l_2_6
				l_2_20 = nil
				l_2_18 = l_2_18(l_2_19, l_2_20, l_2_7, l_2_0._world_dir)
				l_2_8[l_2_17] = l_2_18
				return 
			end
			l_2_0._world_file = string.gsub(l_2_0._world_file, "%.level", ".xml")
			Application:error("Loading world.xml instead of world.level. Please resave the level and commit the file.")
		end
		cat_debug("gaspode", l_2_0._world_file)
		if File:config_exists(l_2_0._world_file) then
			local l_2_13 = nil
			for i_0 in File:parse_xml(l_2_0._world_file):children() do
				local l_2_14 = nil
				if i_0:name() == "world" then
					l_2_0._worlds[i_0:parameter("name")] = l_2_13:new(l_2_22, nil, l_2_0._world_dir)
				end
			end
		end
	else
		Application:error("Couldn't find", l_2_0._world_file)
	end
end

WorldHolder.is_ok = function(l_3_0)
	if table.size(l_3_0._worlds) > 0 then
		local l_3_1 = l_3_0._worlds.world
	else
		return false
	end
end

WorldHolder.create_world = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = l_4_0._worlds[l_4_1]
	if l_4_4 then
		local l_4_5 = l_4_4:create(l_4_2, l_4_3)
		if not Application:editor() and (l_4_2 == "statics" or l_4_2 == "all") and not Global.running_slave then
			World:culling_octree():build_tree()
			World:occlusion_manager():merge_occluders(5)
		end
		if not Application:editor() and l_4_2 == "all" then
			l_4_4:clear_definitions()
		end
		return l_4_5
	else
		Application:error("WorldHolder:create_world :: Could not create world", l_4_1, "for layer", l_4_2)
	end
end

WorldHolder.get_player_data = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_8, l_5_9, l_5_10 = nil
	local l_5_4 = l_5_0._worlds[l_5_1]
	if l_5_4 then
		local l_5_5, l_5_6 = l_5_4:get_player_data, l_5_4
		local l_5_7 = l_5_3
		return l_5_5(l_5_6, l_5_7)
	else
		Application:error("WorldHolder:create_world :: Could not create world", l_5_1, "for layer", l_5_2)
	end
end

WorldHolder.get_max_id = function(l_6_0, l_6_1)
	local l_6_5, l_6_6 = nil
	local l_6_2 = l_6_0._worlds[l_6_1]
	if l_6_2 then
		local l_6_3, l_6_4 = l_6_2:get_max_id, l_6_2
		return l_6_3(l_6_4)
	else
		Application:error("WorldHolder:create_world :: Could not create world", l_6_1)
	end
end

WorldHolder.get_level_name = function(l_7_0, l_7_1)
	local l_7_5, l_7_6 = nil
	local l_7_2 = l_7_0._worlds[l_7_1]
	if l_7_2 then
		local l_7_3, l_7_4 = l_7_2:get_level_name, l_7_2
		return l_7_3(l_7_4)
	else
		Application:error("WorldHolder:create_world :: Could not create world", l_7_1)
	end
end

CoreWorldDefinition.init = function(l_8_0, l_8_1, l_8_2, l_8_3)
	managers.worlddefinition = l_8_0
	l_8_0._world_dir = l_8_3
	l_8_0._max_id = 0
	l_8_0._level_name = "none"
	l_8_0._definitions = {}
	l_8_0._old_groups = {}
	l_8_0._old_groups.groups = {}
	l_8_0._old_groups.group_names = {}
	l_8_0._portal_slot_mask = World:make_slot_mask(1)
	l_8_0._massunit_replace_names = {}
	l_8_0._replace_names = {}
	l_8_0._replace_units_path = "\\data\\lib\\utils\\dev\\editor\\xml\\replace_units.xml"
	l_8_0:parse_replace_unit()
	if l_8_1 then
		if l_8_1:has_parameter("max_id") then
			l_8_0._max_id = tonumber(l_8_1:parameter("max_id"))
		end
		if l_8_1:has_parameter("level_name") then
			l_8_0._level_name = l_8_1:parameter("level_name")
		end
		l_8_0:parse_definitions(l_8_1)
	elseif l_8_2 then
		l_8_0._level_file = l_8_2
		l_8_0._max_id = l_8_0._level_file:data("world").max_id
		l_8_0._level_name = l_8_0._level_file:data("world").level_name
	end
	local l_8_4 = l_8_0._definitions
	if not l_8_0._definitions.editor_groups then
		local l_8_5, l_8_6 = {}
		l_8_6 = l_8_0._old_groups
		l_8_6 = l_8_6.groups
		l_8_5.groups = l_8_6
		l_8_6 = l_8_0._old_groups
		l_8_6 = l_8_6.group_names
		l_8_5.group_names = l_8_6
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_8_4.editor_groups = l_8_5
	l_8_0._all_units, l_8_4 = l_8_4, {}
	l_8_0._stage_depended_units, l_8_4 = l_8_4, {}
	l_8_0._trigger_units, l_8_4 = l_8_4, {}
	l_8_0._use_unit_callbacks, l_8_4 = l_8_4, {}
end

CoreWorldDefinition.parse_definitions = function(l_9_0, l_9_1)
	local l_9_7, l_9_8 = nil
	local l_9_2 = l_9_1:num_children()
	local l_9_3 = 0
	for i_0 in l_9_1:children() do
		if not l_9_0._definitions[i_0:name()] then
			l_9_0._definitions[i_0:name()] = {}
		end
		if managers.editor then
			l_9_3 = l_9_3 + 50 / l_9_2
			managers.editor:update_load_progress(l_9_3, "Parse layer: " .. i_0:name())
		end
		if l_9_0["parse_" .. i_0:name()] then
			l_9_0["parse_" .. i_0:name()](l_9_0, l_9_9, l_9_0._definitions[i_0:name()])
		else
			Application:error("CoreWorldDefinition:No parse function for type/layer", i_0:name())
		end
	end
end

CoreWorldDefinition.world_dir = function(l_10_0)
	return l_10_0._world_dir
end

CoreWorldDefinition.get_max_id = function(l_11_0)
	return l_11_0._max_id
end

CoreWorldDefinition.get_level_name = function(l_12_0)
	return l_12_0._level_name
end

CoreWorldDefinition.parse_continents = function(l_13_0, l_13_1, l_13_2)
	local l_13_3 = l_13_1:parameter("file")
	local l_13_4 = l_13_0:world_dir() .. "\\" .. l_13_3
	if not File:config_exists(l_13_4) then
		Application:error("Continent file didn't exist " .. l_13_4 .. ").")
		return 
	end
	local l_13_9 = File:parse_xml
	l_13_9 = l_13_9(File, l_13_0:world_dir() .. "\\" .. l_13_3)
	local l_13_5 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_13_5 do
		local l_13_10 = l_13_8:parameter("name")
		local l_13_11 = tonumber(l_13_8:parameter("base_id"))
		if File:exists(l_13_0:world_dir() .. l_13_10 .. ".xml") then
			local l_13_16 = File:parse_xml
			l_13_16 = l_13_16(File, l_13_0:world_dir() .. l_13_10 .. ".xml")
			local l_13_12 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			for i_0 in l_13_12 do
				local l_13_17 = {}
				l_13_17.max_id = tonumber(l_13_15:parameter("max_id"))
				l_13_17.base_id = l_13_11
				l_13_17.level_name = l_13_15:parameter("level_name")
				l_13_2[l_13_10] = l_13_17
				l_13_0:parse_definitions(l_13_15)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		else
			l_13_16 = Application
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_13_16 = l_13_16:error
			l_13_16(l_13_12, "Continent file " .. l_13_10 .. ".xml doesnt exist.")
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldDefinition.parse_values = function(l_14_0, l_14_1, l_14_2)
	local l_14_6, l_14_7 = nil
	for i_0 in l_14_1:children() do
		l_14_2[parse_value_node(i_0)] = i_0
	end
end

CoreWorldDefinition.parse_markers = function(l_15_0, l_15_1, l_15_2)
	local l_15_6, l_15_7 = nil
	for i_0 in l_15_1:children() do
		table.insert(l_15_2, LoadedMarker:new(i_0))
	end
end

CoreWorldDefinition.parse_groups = function(l_16_0, l_16_1, l_16_2)
	local l_16_6, l_16_7, l_16_8 = nil
	for i_0 in l_16_1:children() do
		local l_16_10 = i_0:parameter("name")
		if tonumber(l_16_9:parameter("reference_unit_id")) ~= 0 then
			l_16_0:add_editor_group(l_16_10, tonumber(l_16_9:parameter("reference_unit_id")))
		else
			cat_error("Removed empty group", l_16_10, "when converting from old GroupHandler to new.")
		end
	end
end

CoreWorldDefinition.parse_editor_groups = function(l_17_0, l_17_1, l_17_2)
	local l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_13 = nil
	local l_17_3 = l_17_0._old_groups.groups
	local l_17_4 = l_17_0._old_groups.group_names
	for i_0 in l_17_1:children() do
		if not l_17_3[i_0:parameter("name")] then
			local l_17_21 = nil
			local l_17_15 = (tonumber(l_17_14:parameter("reference_id")))
			local l_17_16 = nil
			if l_17_14:has_parameter("continent") and l_17_14:parameter("continent") ~= "nil" then
				l_17_16 = l_17_14:parameter("continent")
			end
			local l_17_17 = {}
			for i_0 in l_17_14:children() do
				table.insert(l_17_17, tonumber(i_0:parameter("id")))
			end
			l_17_3[l_17_21] = {}
			l_17_3[l_17_21].reference = l_17_15
			l_17_3[l_17_21].continent = l_17_16
			l_17_3[l_17_21].units = l_17_17
			table.insert(l_17_4, l_17_21)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	l_17_2.groups = l_17_3
	l_17_2.group_names = l_17_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldDefinition.add_editor_group = function(l_18_0, l_18_1, l_18_2)
	table.insert(l_18_0._old_groups.group_names, l_18_1)
	l_18_0._old_groups.groups[l_18_1] = {}
	l_18_0._old_groups.groups[l_18_1].reference = l_18_2
	if not l_18_0._old_groups.groups[l_18_1].units then
		l_18_0._old_groups.groups[l_18_1].units = {}
	end
end

CoreWorldDefinition.add_editor_group_unit = function(l_19_0, l_19_1, l_19_2)
	if not l_19_0._old_groups.groups[l_19_1].units then
		l_19_0._old_groups.groups[l_19_1].units = {}
	end
	table.insert(l_19_0._old_groups.groups[l_19_1].units, l_19_2)
end

CoreWorldDefinition.parse_brush = function(l_20_0, l_20_1)
	l_20_0._massunit_path = l_20_1:parameter("path")
end

CoreWorldDefinition.parse_sounds = function(l_21_0, l_21_1, l_21_2)
	if l_21_1:has_parameter("soundbank") then
		l_21_0._soundbank = l_21_1:parameter("soundbank")
		l_21_0._ambience_enabled = false
		for l_21_6 in l_21_1:children() do
			do
				local l_21_7, l_21_8, l_21_9, l_21_10, l_21_11 = nil
				l_21_0._ambience_enabled = true
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		if l_21_1:has_parameter("path") then
			if File:config_exists(l_21_1:parameter("path")) then
				l_21_1 = File:parse_xml(l_21_1:parameter("path"))
			end
		else
			Application:error("The specified world_sound.xml was not found for this level! ", l_21_1:parameter("path"), "No sound will be loaded!")
			return 
		end
		l_21_0._sounds = CoreWDSoundEnvironment:new(l_21_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreWorldDefinition.parse_hub_elements = function(l_22_0, l_22_1, l_22_2)
	local l_22_8, l_22_9 = nil
	if Application:editor() then
		if not rawget(_G, "HubElementUnit") then
			local l_22_3, l_22_4 = rawget(_G, "CoreHubElementUnit")
		end
		for i_0 in l_22_1:children() do
			local l_22_5 = nil
			table.insert(l_22_2, l_22_5:new(i_0))
		end
	end
end

CoreWorldDefinition.parse_environment = function(l_23_0, l_23_1)
	l_23_0._environment = CoreEnvironment:new(l_23_1)
end

CoreWorldDefinition.parse_world_camera = function(l_24_0, l_24_1)
	l_24_0._world_camera_path = l_24_1:parameter("path")
end

CoreWorldDefinition.parse_portal = function(l_25_0, l_25_1)
	l_25_0._portal = CorePortal:new(l_25_1)
end

CoreWorldDefinition.parse_wires = function(l_26_0, l_26_1, l_26_2)
	local l_26_6, l_26_7 = nil
	for i_0 in l_26_1:children() do
		table.insert(l_26_2, CoreWire:new(i_0))
	end
end

CoreWorldDefinition.clear_definitions = function(l_27_0)
	l_27_0._definitions = nil
end

CoreWorldDefinition.create = function(l_28_0, l_28_1, l_28_2)
	if l_28_0._level_file then
		l_28_0:create_from_level_file(l_28_1, l_28_2)
		l_28_0._level_file:destroy()
	else
		local l_28_3, l_28_4 = l_28_0:create_units, l_28_0
		local l_28_5 = l_28_1
		local l_28_6 = l_28_2
		return l_28_3(l_28_4, l_28_5, l_28_6)
	end
end

CoreWorldDefinition.create_units = function(l_29_0, l_29_1, l_29_2)
	local l_29_7, l_29_8, l_29_9, l_29_10, l_29_15, l_29_17 = nil
	local l_29_3 = {}
	if l_29_1 == "markers" then
		l_29_3 = l_29_0._definitions.markers
	end
	if l_29_1 == "values" then
		l_29_3 = l_29_0._definitions.values
	end
	if l_29_1 == "editor_groups" then
		l_29_3 = l_29_0._definitions.editor_groups
	end
	if l_29_1 == "continents" then
		l_29_3 = l_29_0._definitions.continents
	end
	if (l_29_1 == "portal" or l_29_1 == "all") and l_29_0._portal then
		l_29_0._portal:create(l_29_2)
		l_29_3 = l_29_0._portal
	end
	if l_29_1 == "sounds" or l_29_1 == "all" then
		if l_29_0._sounds then
			l_29_0._sounds:create()
			l_29_3 = l_29_0._sounds
		end
	else
		managers.sound_environment:set_default_soundbank(l_29_0._soundbank)
		managers.sound_environment:set_ambience_enabled(l_29_0._ambience_enabled)
	end
	if l_29_1 == "hub_elements" then
		for i_0,i_1 in ipairs(l_29_0._definitions.hub_elements) do
			table.insert(l_29_3, i_1:create_unit(l_29_2))
		end
	end
	if (l_29_1 == "brush" or l_29_1 == "all") and l_29_0._massunit_path then
		l_29_0:load_massunit(l_29_0._massunit_path, l_29_2)
	end
	if (l_29_1 == "environment" or l_29_1 == "all") and l_29_0._environment then
		l_29_0._environment:create(l_29_2)
		l_29_3 = l_29_0._environment
	end
	if (l_29_1 == "world_camera" or l_29_1 == "all") and l_29_0._world_camera_path then
		local l_29_14, l_29_16 = managers.worldcamera:load, managers.worldcamera
		l_29_14(l_29_16, l_29_0._world_camera_path, l_29_2)
	end
	if (l_29_1 == "wires" or l_29_1 == "all") and l_29_0._definitions.wires then
		for i_0,i_1 in ipairs(l_29_0._definitions.wires) do
			table.insert(l_29_3, i_1:create_unit(l_29_2))
		end
	end
	return l_29_3
end

CoreWorldDefinition.create_from_level_file = function(l_30_0, l_30_1, l_30_2)
	local l_30_8, l_30_10, l_30_12 = nil
	if (l_30_1 == "portal" or l_30_1 == "all") and not Application:editor() then
		l_30_0:create_portals(l_30_0._level_file:data("portal").portals, l_30_2)
		l_30_0:create_portal_unit_groups(l_30_0._level_file:data("portal").unit_groups, l_30_2)
	end
	if l_30_1 == "sounds" or l_30_1 == "all" then
		l_30_0:create_sounds(l_30_0._level_file:data("sounds").path, l_30_2)
	end
	if (l_30_1 == "brush" or l_30_1 == "all") and l_30_0._level_file:data("brush").path then
		l_30_0:load_massunit(l_30_0._level_file:data("brush").path, l_30_2)
	end
	if l_30_1 == "environment" or l_30_1 == "all" then
		l_30_0:create_environment(l_30_0._level_file:data("environment"), l_30_2)
	end
	if (l_30_1 == "world_camera" or l_30_1 == "all") and l_30_0._level_file:data("world_camera") and l_30_0._level_file:data("world_camera").path then
		local l_30_7, l_30_9, l_30_11 = managers.worldcamera:load, managers.worldcamera, l_30_0._level_file:data
		l_30_11 = l_30_11(l_30_0._level_file, "world_camera")
		l_30_11 = l_30_11.path
		l_30_7(l_30_9, l_30_11, l_30_2)
	end
	if l_30_1 == "wires" or l_30_1 == "all" then
		local l_30_3 = l_30_0:create_level_units("wires", l_30_2)
		for i_0,i_1 in ipairs(l_30_3) do
			local l_30_15 = i_1[1]
			l_30_15:wire_data().slack = i_1[2].wire.slack
			local l_30_16 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_30_15:get_object("a_target"):set_position(i_1[2].wire.target_pos)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_30_15:get_object("a_target"):set_rotation(i_1[2].wire.target_rot)
			wire_set_midpoint(l_30_15, "rp", "a_target", "a_bender")
			l_30_15:set_moving()
		end
	end
end

CoreWorldDefinition.create_level_units = function(l_31_0, l_31_1, l_31_2)
	local l_31_7, l_31_8, l_31_9, l_31_10, l_31_11, l_31_12 = nil
	local l_31_3 = l_31_0._level_file:create(l_31_1)
	for i_0,i_1 in ipairs(l_31_3) do
		local l_31_15 = i_1[1]
		l_31_0:assign_unit_data(l_31_15, l_31_0:make_generic_data(i_1[2]))
	end
	return l_31_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldDefinition.create_portals = function(l_32_0, l_32_1, l_32_2)
	local l_32_6, l_32_7, l_32_8, l_32_9, l_32_14, l_32_15, l_32_16, l_32_17 = nil
	for i_0,i_1 in ipairs(l_32_1) do
		for i_0,i_1 in ipairs(i_1.points) do
			local l_32_12 = {}
			table.insert(l_32_12, i_1.position + l_32_2)
		end
		if l_32_11.top == 0 and l_32_11.bottom == 0 then
			managers.portal:add_portal(l_32_12, nil, nil)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 25 
end

CoreWorldDefinition.create_portal_unit_groups = function(l_33_0, l_33_1, l_33_2)
	local l_33_6, l_33_7, l_33_8, l_33_9, l_33_10, l_33_15, l_33_16, l_33_17, l_33_18 = nil
	if not l_33_1 then
		return 
	end
	for i_0,i_1 in pairs(l_33_1) do
		for i_0,i_1 in ipairs(i_1) do
			local l_33_13 = managers.portal:add_unit_group(i_0)
			l_33_13:add_shape(i_1)
		end
	end
end

CoreWorldDefinition.create_sounds = function(l_34_0, l_34_1)
	local l_34_7, l_34_8, l_34_9, l_34_10, l_34_11, l_34_12, l_34_13, l_34_14, l_34_15, l_34_16, l_34_17, l_34_18 = nil
	local l_34_2 = Level:load(l_34_1)
	local l_34_3 = l_34_2:data("sounds")
	managers.sound_environment:set_default_environment(l_34_3.environment)
	managers.sound_environment:set_default_soundbank(l_34_3.soundbank)
	managers.sound_environment:set_ambience_enabled(l_34_3.ambience_enabled)
	for i_0,i_1 in ipairs(l_34_3.sound_environments) do
		managers.sound_environment:add_area(i_1)
	end
	for i_0,i_1 in ipairs(l_34_3.sound_emitters) do
		managers.sound_environment:add_emitter(i_1)
	end
	if l_34_3.sound_area_emitters then
		for i_0,i_1 in ipairs(l_34_3.sound_area_emitters) do
			managers.sound_environment:add_area_emitter(i_1)
		end
	end
	l_34_2:destroy()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldDefinition.create_environment = function(l_35_0, l_35_1, l_35_2)
	managers.environment_area:set_default_environment(l_35_1.environment, nil)
	managers.environment:setrotation(l_35_1.sky_rot)
	local l_35_3 = l_35_1.wind
	Wind:set_direction(l_35_3.angle, l_35_3.angle_var, 5)
	Wind:set_tilt(l_35_3.tilt, l_35_3.tilt_var, 5)
	do
		local l_35_7 = Wind:set_speed_m_s
	end
	local l_35_8 = nil
	l_35_8(Wind, l_35_3.speed or 6, l_35_3.speed_variation or 1, 5)
	l_35_8 = Wind
	l_35_8(l_35_8, true)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_35_8 then
		for i_0,i_1 in l_35_8 do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			if Database:has("effect", i_1.name) then
				if not World:effect_manager():has_effect(i_1.name) then
					World:effect_manager():load(i_1.name)
				end
				local l_35_10, l_35_11 = , managers.portal:add_effect
				local l_35_12 = managers.portal
				l_35_11(l_35_12, {effect = l_35_10, position = l_35_9.position, rotation = l_35_9.rotation})
			end
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_35_8(l_35_1.environment_areas) do
		managers.environment_area:add_area(i_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldDefinition.load_massunit = function(l_36_0, l_36_1, l_36_2)
	local l_36_7, l_36_8, l_36_9, l_36_10, l_36_11, l_36_12, l_36_13, l_36_14, l_36_15, l_36_16, l_36_17, l_36_18, l_36_19 = nil
	if Application:editor() then
		local l_36_3 = MassUnitManager:list(l_36_1)
		for i_0,i_1 in ipairs(l_36_3) do
			if not UnitDatabase:get_unit_data(i_1) and not table.has(l_36_0._massunit_replace_names, i_1) then
				if not UnitDatabase:get_unit_data(i_1) then
					managers.editor:output("Unit " .. i_1 .. " does not exist")
				end
				local l_36_22 = i_1
				l_36_0._massunit_replace_names[l_36_22] = l_36_20 or ""
				managers.editor:output("Unit " .. l_36_22 .. " changed to " .. tostring(l_36_20))
			end
		end
	end
	MassUnitManager:delete_all_units()
	 -- DECOMPILER ERROR: Confused about usage of registers!

	MassUnitManager:load(l_36_1, l_36_2, l_36_0._massunit_replace_names)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreWorldDefinition.parse_replace_unit = function(l_37_0)
	local l_37_6, l_37_7, l_37_8 = nil
	local l_37_1 = Application:editor()
	if File:config_exists(l_37_0._replace_units_path) then
		local l_37_2 = File:parse_xml(l_37_0._replace_units_path)
		for i_0 in l_37_2:children() do
			local l_37_10 = i_0:name()
			l_37_0._replace_names[l_37_10] = l_37_9:parameter("replace_with")
			if l_37_1 then
				managers.editor:output_info("Unit " .. l_37_10 .. " will be replaced with " .. l_37_9:parameter("replace_with"))
			end
		end
	end
end

CoreWorldDefinition.preload_unit = function(l_38_0, l_38_1)
	local l_38_2 = Application:editor()
	if table.has(l_38_0._replace_names, l_38_1) then
		l_38_1 = l_38_0._replace_names[l_38_1]
	elseif l_38_2 and (not UnitDatabase:get_unit_data(l_38_1) or UnitDatabase:get_unit_data(l_38_1):type() == "deleteme") then
		if not UnitDatabase:get_unit_data(l_38_1) then
			managers.editor:output_info("Unit " .. l_38_1 .. " does not exist")
		else
			managers.editor:output_info("Unit " .. l_38_1 .. " is of type " .. UnitDatabase:get_unit_data(l_38_1):type())
		end
		local l_38_3 = l_38_1
		l_38_1 = managers.editor:show_replace_unit()
		l_38_0._replace_names[l_38_3] = l_38_1
		managers.editor:output_info("Unit " .. l_38_3 .. " changed to " .. tostring(l_38_1))
	end
	if l_38_1 then
		World:preload_unit(l_38_1)
	end
end

CoreWorldDefinition.make_unit = function(l_39_0, l_39_1, l_39_2, l_39_3)
	local l_39_4 = Application:editor()
	if table.has(l_39_0._replace_names, l_39_1) then
		l_39_1 = l_39_0._replace_names[l_39_1]
	end
	local l_39_5 = nil
	if l_39_1 then
		if MassUnitManager:can_spawn_unit(l_39_1) and not l_39_4 then
			l_39_5 = MassUnitManager:spawn_unit(l_39_1, l_39_2._position + l_39_3, l_39_2._rotation)
		else
			l_39_5 = World:spawn_unit(l_39_1, l_39_2._position + l_39_3, l_39_2._rotation)
		end
		if l_39_5 then
			l_39_0:assign_unit_data(l_39_5, l_39_2)
		end
	elseif l_39_4 then
		local l_39_6 = "Failed creating unit " .. tostring(l_39_1)
		Application:throw_exception(l_39_6)
	end
	return l_39_5
end

CoreWorldDefinition.assign_unit_data = function(l_40_0, l_40_1, l_40_2)
	local l_40_3 = Application:editor()
	if not l_40_1:unit_data() then
		Application:error("The unit " .. l_40_1:name() .. " (" .. l_40_1:author() .. ") does not have the required extension unit_data (ScriptUnitData)")
	end
	if l_40_1:unit_data().only_exists_in_editor and not l_40_3 then
		l_40_1:set_slot(0)
		return 
	end
	if l_40_2._unit_id then
		l_40_1:unit_data().unit_id = l_40_2._unit_id
		l_40_1:set_editor_id(l_40_1:unit_data().unit_id)
		l_40_0._all_units[l_40_1:unit_data().unit_id] = l_40_1
		l_40_0:use_me(l_40_1, l_40_3)
	end
	if l_40_3 then
		l_40_1:unit_data().name_id = l_40_2._name_id
		l_40_1:unit_data().world_pos = l_40_1:position()
	end
	if l_40_2._group_name and l_40_3 and not l_40_0._level_file and l_40_2._group_name ~= "none" then
		local l_40_8, l_40_10 = l_40_0:add_editor_group_unit, l_40_0
		l_40_8(l_40_10, l_40_2._group_name, l_40_1:unit_data().unit_id)
	end
	if l_40_2._continent and l_40_3 then
		local l_40_7, l_40_9 = managers.editor:add_unit_to_continent, managers.editor
		l_40_7(l_40_9, l_40_2._continent, l_40_1)
	end
	for i_0,i_1 in ipairs(l_40_2._lights) do
		if l_40_1:get_object(i_1.name) then
			l_40_1:get_object(i_1.name):set_enable(l_40_14.enable)
			l_40_1:get_object(i_1.name):set_far_range(l_40_14.far_range)
			l_40_1:get_object(i_1.name):set_color(l_40_14.color)
			if l_40_14.angle_start then
				l_40_1:get_object(i_1.name):set_spot_angle_start(l_40_14.angle_start)
				l_40_1:get_object(i_1.name):set_spot_angle_end(l_40_14.angle_end)
			end
			if l_40_14.multiplier then
				if tonumber(l_40_14.multiplier) then
					l_40_14.multiplier = get_intensity_preset(tonumber(l_40_14.multiplier))
				end
				l_40_1:get_object(i_1.name):set_multiplier(LightIntensityDB:lookup(l_40_14.multiplier))
				l_40_1:get_object(i_1.name):set_specular_multiplier(LightIntensityDB:lookup_specular_multiplier(l_40_14.multiplier))
			end
		if l_40_14.falloff_exponent then
			end
			l_40_1:get_object(i_1.name):set_falloff_exponent(l_40_14.falloff_exponent)
		end
	end
	if l_40_2._variation and l_40_2._variation ~= "default" then
		l_40_1:unit_data().variation = l_40_2._variation
		local l_40_13 = "change_state"
		managers.sequence:run_sequence_simple2(managers.sequence, l_40_1:unit_data().variation, l_40_13, l_40_1)
	end
	if l_40_2._material_variation and l_40_2._material_variation ~= "default" then
		l_40_1:unit_data().material = l_40_2._material_variation
		l_40_1:set_material_config(l_40_1:unit_data().material, true)
	end
	if l_40_2._editable_gui then
		l_40_1:editable_gui():set_text(l_40_2._editable_gui.text)
		l_40_1:editable_gui():set_font_color(l_40_2._editable_gui.font_color)
		l_40_1:editable_gui():set_font_size(l_40_2._editable_gui.font_size)
	if not l_40_3 then
		end
		l_40_1:editable_gui():lock_gui()
	end
	l_40_0:add_trigger_sequence(l_40_1, l_40_2._triggers)
	if not table.empty(l_40_2._exists_in_stages) then
		for i_0,i_1 in pairs(l_40_2._exists_in_stages) do
			clone(CoreScriptUnitData.exists_in_stages)[i_0] = i_1
		end
		l_40_1:unit_data().exists_in_stages = clone(CoreScriptUnitData.exists_in_stages)
		table.insert(l_40_0._stage_depended_units, l_40_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	if l_40_1:unit_data().only_visible_in_editor and not l_40_3 then
		l_40_1:set_visible(false)
	end
	if l_40_2.cutscene_actor then
		l_40_1:unit_data().cutscene_actor = l_40_2.cutscene_actor
		managers.cutscene:register_cutscene_actor(l_40_1)
	end
	if l_40_2.disable_shadows then
		if l_40_3 then
			l_40_1:unit_data().disable_shadows = l_40_2.disable_shadows
		end
		l_40_1:set_shadows_disabled(l_40_2.disable_shadows)
	end
	if not l_40_3 and l_40_0._portal_slot_mask and l_40_1:in_slot(l_40_0._portal_slot_mask) and not l_40_1:unit_data().only_visible_in_editor then
		managers.portal:add_unit(l_40_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreWorldDefinition.add_trigger_sequence = function(l_41_0, l_41_1, l_41_2)
	local l_41_7, l_41_8, l_41_9, l_41_10, l_41_11, l_41_12, l_41_13, l_41_14, l_41_16, l_41_17, l_41_18, l_41_19, l_41_20, l_41_21, l_41_22, l_41_23, l_41_24, l_41_25, l_41_26, l_41_27, l_41_28, l_41_29, l_41_30, l_41_31, l_41_32, l_41_33, l_41_37, l_41_38, l_41_39, l_41_40 = nil
	local l_41_3 = Application:editor()
	for i_0,i_1 in ipairs(l_41_2) do
		if l_41_3 and script_debug.running_simulation then
			l_41_1:damage():add_trigger_sequence(i_1.name, i_1.notify_unit_sequence, managers.editor:unit_with_id(i_1.notify_unit_id), i_1.time, nil, nil, l_41_3)
		else
			if l_41_0._all_units[i_1.notify_unit_id] then
				l_41_1:damage():add_trigger_sequence(i_1.name, i_1.notify_unit_sequence, l_41_0._all_units[i_1.notify_unit_id], i_1.time, nil, nil, l_41_3)
			end
		else
			if l_41_0._trigger_units[i_1.notify_unit_id] then
				local l_41_34 = nil
				local l_41_36 = table.insert
				l_41_36(l_41_0._trigger_units[i_1.notify_unit_id], {unit = l_41_1, trigger = l_41_35})
			end
		else
			local l_41_41 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_41_42 = nil
			local l_41_43 = l_41_0._trigger_units
			local l_41_44 = l_41_35.notify_unit_id
			l_41_43[l_41_44] = {
{unit = l_41_1, trigger = l_41_42}}
		end
	end
end

CoreWorldDefinition.use_me = function(l_42_0, l_42_1, l_42_2)
	local l_42_7, l_42_8, l_42_9, l_42_10, l_42_11, l_42_12, l_42_13, l_42_14, l_42_15, l_42_16, l_42_20, l_42_21, l_42_22, l_42_23 = nil
	local l_42_3 = l_42_1:unit_data().unit_id
	if l_42_0._trigger_units[l_42_3] then
		for i_0,i_1 in ipairs(l_42_0._trigger_units[l_42_3]) do
			i_1.unit:damage():add_trigger_sequence(i_1.trigger.name, i_1.trigger.notify_unit_sequence, l_42_1, i_1.trigger.time, nil, nil, l_42_2)
		end
	end
	if l_42_0._use_unit_callbacks[l_42_3] then
		for i_0,i_1 in ipairs(l_42_0._use_unit_callbacks[l_42_3]) do
			i_1(l_42_1)
		end
	end
end

CoreWorldDefinition.get_unit_on_load = function(l_43_0, l_43_1, l_43_2)
	if l_43_0._all_units[l_43_1] then
		return l_43_0._all_units[l_43_1]
	end
	if l_43_0._use_unit_callbacks[l_43_1] then
		table.insert(l_43_0._use_unit_callbacks[l_43_1], l_43_2)
	else
		local l_43_3 = l_43_0._use_unit_callbacks
		local l_43_4 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	end
	return nil
	 -- WARNING: undefined locals caused missing assignments!
end

CoreWorldDefinition.check_stage_depended_units = function(l_44_0, l_44_1)
	local l_44_5, l_44_6, l_44_7, l_44_8, l_44_12, l_44_13, l_44_14, l_44_15, l_44_16 = nil
	for i_0,i_1 in ipairs(l_44_0._stage_depended_units) do
		for i_0,i_1 in ipairs(i_1:unit_data().exists_in_stages) do
			if l_44_1 == "stage" .. i_0 and not i_1 then
				World:delete_unit(l_44_10)
			end
		end
	end
end

CoreWorldDefinition.get_unit = function(l_45_0, l_45_1)
	return l_45_0._all_units[l_45_1]
end

CoreWorldDefinition.get_soundbank = function(l_46_0)
	return l_46_0._soundbank
end

if not LoadedMarker then
	LoadedMarker = class()
end
LoadedMarker.init = function(l_47_0, l_47_1)
	l_47_0._name = l_47_1:parameter("name")
	l_47_0._pos = math.string_to_vector(l_47_1:parameter("pos"))
	l_47_0._rot = math.string_to_vector(l_47_1:parameter("rot"))
	l_47_0._rot = Rotation(l_47_0._rot.x, l_47_0._rot.y, l_47_0._rot.z)
end

if not CoreWDSoundEnvironment then
	CoreWDSoundEnvironment = class()
end
CoreWDSoundEnvironment.init = function(l_48_0, l_48_1)
	l_48_0._sound_environments = {}
	l_48_0._sound_emitters = {}
	l_48_0._sound_area_emitters = {}
	l_48_1:for_each("default", callback(l_48_0, l_48_0, "parse_default"))
	l_48_1:for_each("ambience", callback(l_48_0, l_48_0, "parse_ambience"))
	l_48_1:for_each("sound_environment", callback(l_48_0, l_48_0, "parse_sound_environment"))
	l_48_1:for_each("sound_emitter", callback(l_48_0, l_48_0, "parse_sound_emitter"))
	l_48_1:for_each("sound_area_emitter", callback(l_48_0, l_48_0, "parse_sound_area_emitter"))
end

CoreWDSoundEnvironment.parse_default = function(l_49_0, l_49_1)
	l_49_0._default_soundbank = l_49_1:parameter("soundbank")
	l_49_0._default_environment = l_49_1:parameter("environment")
end

CoreWDSoundEnvironment.parse_ambience = function(l_50_0, l_50_1)
	l_50_0._ambience_enabled = toboolean(l_50_1:parameter("enabled"))
end

CoreWDSoundEnvironment.parse_sound_environment = function(l_51_0, l_51_1)
	local l_51_2 = {}
	l_51_2.environment = l_51_1:parameter("environment")
	l_51_2.environment_soundbank = l_51_1:parameter("soundbank")
	l_51_2.position = math.string_to_vector(l_51_1:parameter("position"))
	l_51_2.rotation = math.string_to_rotation(l_51_1:parameter("rotation"))
	l_51_2.width = tonumber(l_51_1:parameter("width"))
	l_51_2.depth = tonumber(l_51_1:parameter("depth"))
	l_51_2.height = tonumber(l_51_1:parameter("height"))
	l_51_2.name = l_51_1:parameter("name")
	table.insert(l_51_0._sound_environments, l_51_2)
end

CoreWDSoundEnvironment.parse_sound_emitter = function(l_52_0, l_52_1)
	local l_52_2 = {}
	l_52_2.emitter_soundbank = l_52_1:parameter("soundbank")
	l_52_2.emitter_cue = l_52_1:parameter("cue")
	l_52_2.position = math.string_to_vector(l_52_1:parameter("position"))
	l_52_2.rotation = math.string_to_rotation(l_52_1:parameter("rotation"))
	l_52_2.name = l_52_1:parameter("name")
	table.insert(l_52_0._sound_emitters, l_52_2)
end

CoreWDSoundEnvironment.parse_sound_area_emitter = function(l_53_0, l_53_1)
	local l_53_6, l_53_7, l_53_11 = nil
	local l_53_2 = {}
	for i_0 in l_53_1:children() do
		for i_0 in i_0:children() do
		end
		do
			local l_53_12 = l_53_8
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	table.insert(l_53_0._sound_area_emitters, l_53_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

CoreWDSoundEnvironment.create = function(l_54_0)
	local l_54_4, l_54_5, l_54_6, l_54_7, l_54_8, l_54_9, l_54_10, l_54_11, l_54_12, l_54_13, l_54_14, l_54_15 = nil
	managers.sound_environment:set_default_environment(l_54_0._default_environment)
	managers.sound_environment:set_default_soundbank(l_54_0._default_soundbank)
	managers.sound_environment:set_ambience_enabled(l_54_0._ambience_enabled)
	for i_0,i_1 in ipairs(l_54_0._sound_environments) do
		managers.sound_environment:add_area(i_1)
	end
	for i_0,i_1 in ipairs(l_54_0._sound_emitters) do
		managers.sound_environment:add_emitter(i_1)
	end
	for i_0,i_1 in ipairs(l_54_0._sound_area_emitters) do
		managers.sound_environment:add_area_emitter(i_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not CoreEnvironment then
	CoreEnvironment = class()
end
CoreEnvironment.init = function(l_55_0, l_55_1)
	l_55_0._values = {}
	if l_55_1:has_parameter("environment") then
		l_55_0._values.environment = l_55_1:parameter("environment")
	end
	if l_55_1:has_parameter("sky_rot") then
		l_55_0._values.sky_rot = tonumber(l_55_1:parameter("sky_rot"))
	end
	l_55_1:for_each("value", callback(l_55_0, l_55_0, "parse_value"))
	managers.environment:preload_environment(l_55_0._values.environment, true)
	l_55_1:for_each("wind", callback(l_55_0, l_55_0, "parse_wind"))
	l_55_0._unit_effects = {}
	l_55_1:for_each("unit_effect", callback(l_55_0, l_55_0, "parse_unit_effect"))
	l_55_0._environment_areas = {}
	l_55_1:for_each("environment_area", callback(l_55_0, l_55_0, "parse_environment_area"))
	l_55_0._units_data = {}
	l_55_0._units = {}
	l_55_1:for_each("unit", callback(l_55_0, l_55_0, "parse_unit"))
end

CoreEnvironment.parse_value = function(l_56_0, l_56_1)
	local l_56_2 = l_56_0._values
	local l_56_3 = l_56_1:parameter("name")
	l_56_2[l_56_3] = string_to_value(l_56_1:parameter("type"), l_56_1:parameter("value"))
end

CoreEnvironment.parse_wind = function(l_57_0, l_57_1)
	l_57_0._wind = {}
	l_57_0._wind.wind_angle = tonumber(l_57_1:parameter("angle"))
	l_57_0._wind.wind_dir_var = tonumber(l_57_1:parameter("angle_var"))
	l_57_0._wind.wind_tilt = tonumber(l_57_1:parameter("tilt"))
	l_57_0._wind.wind_tilt_var = tonumber(l_57_1:parameter("tilt_var"))
	if l_57_1:has_parameter("speed") then
		l_57_0._wind.wind_speed = tonumber(l_57_1:parameter("speed"))
	end
	if l_57_1:has_parameter("speed_variation") then
		l_57_0._wind.wind_speed_variation = tonumber(l_57_1:parameter("speed_variation"))
	end
end

CoreEnvironment.parse_unit_effect = function(l_58_0, l_58_1)
	local l_58_2, l_58_3, l_58_5, l_58_6 = nil, nil
	for i_0 in l_58_1:children() do
		l_58_2 = math.string_to_vector(i_0:parameter("pos"))
		l_58_3 = math.string_to_rotation(i_0:parameter("rot"))
	end
	table.insert(l_58_0._unit_effects, {pos = l_58_2, rot = l_58_3, name = l_58_1:parameter("name")})
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreEnvironment.parse_environment_area = function(l_59_0, l_59_1)
	local l_59_6 = nil
	local l_59_2 = {}
	for i_0 in l_59_1:children() do
		l_59_2 = managers.shape:parse(i_0)
	end
	table.insert(l_59_0._environment_areas, l_59_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreEnvironment.parse_unit = function(l_60_0, l_60_1)
	if not Application:editor() then
		return 
	end
	local l_60_2 = {}
	l_60_2.name = l_60_1:parameter("name")
	l_60_2.generic = Generic:new(l_60_1)
	table.insert(l_60_0._units_data, l_60_2)
end

CoreEnvironment.create = function(l_61_0, l_61_1)
	if l_61_0._values.environment ~= "none" then
		managers.environment_area:set_default_environment(l_61_0._values.environment, nil)
	end
	managers.environment:setrotation(l_61_0._values.sky_rot)
	if l_61_0._wind then
		Wind:set_direction(l_61_0._wind.wind_angle, l_61_0._wind.wind_dir_var, 5)
		Wind:set_tilt(l_61_0._wind.wind_tilt, l_61_0._wind.wind_tilt_var, 5)
		do
			local l_61_5, l_61_7, l_61_9, l_61_11, l_61_13, l_61_15, l_61_23, l_61_25, l_61_27, l_61_29, l_61_31 = Wind:set_speed_m_s, Wind, l_61_0._wind.wind_speed or 6, l_61_0._wind.wind_speed_variation or 1
		end
		local l_61_6, l_61_8, l_61_10, l_61_12, l_61_14, l_61_16, l_61_24, l_61_26, l_61_28, l_61_30, l_61_32 = , 5
		l_61_6(l_61_8, l_61_10, l_61_12, l_61_14)
		l_61_6 = Wind
		l_61_6, l_61_8 = l_61_6:set_enabled, l_61_6
		l_61_10 = true
		l_61_6(l_61_8, l_61_10)
	end
	if not Application:editor() then
		for i_0,i_1 in ipairs(l_61_0._unit_effects) do
			if Database:has("effect", i_1.name) then
				if not World:effect_manager():has_effect(i_1.name) then
					World:effect_manager():load(i_1.name)
				end
				local l_61_19 = managers.portal:add_effect
				l_61_19(managers.portal, {effect = l_61_18.name, position = l_61_18.pos, rotation = l_61_18.rot})
			end
		end
	end
	for i_0,i_1 in ipairs(l_61_0._environment_areas) do
		managers.environment_area:add_area(i_1)
	end
	for i_0,i_1 in ipairs(l_61_0._units_data) do
		do
			table.insert(l_61_0._units, managers.worlddefinition:make_unit(i_1.name, i_1.generic, l_61_1))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not CorePortal then
	CorePortal = class()
end
CorePortal.init = function(l_62_0, l_62_1)
	managers.worlddefinition:preload_unit("portal_point")
	l_62_0._portal_shapes = {}
	l_62_0._unit_groups = {}
	l_62_1:for_each("portal_list", callback(l_62_0, l_62_0, "parse_portal_list"))
	l_62_1:for_each("unit_group", callback(l_62_0, l_62_0, "parse_unit_group"))
end

CorePortal.parse_portal_list = function(l_63_0, l_63_1)
	local l_63_2 = l_63_1:parameter("name")
	do
		local l_63_3 = tonumber(l_63_1:parameter("top")) or 0
	do
		end
		local l_63_4 = nil
	end
	local l_63_10 = nil
	do
		local l_63_5 = tonumber(l_63_1:parameter("bottom")) or 0
	end
	local l_63_6 = nil
	local l_63_7 = tonumber(l_63_1:parameter("draw_base")) or 0
	l_63_0._portal_shapes[l_63_2] = {
portal = {}, top = l_63_10, bottom = l_63_6, draw_base = l_63_7}
	for i_0 in l_63_1:children() do
		local l_63_8 = l_63_0._portal_shapes[l_63_2].portal
		local l_63_14 = math.string_to_vector(i_0:parameter("pos"))
		table.insert(l_63_8, {pos = l_63_14})
	end
end

CorePortal.parse_unit_group = function(l_64_0, l_64_1)
	local l_64_7, l_64_8 = nil
	local l_64_2 = l_64_1:parameter("name")
	local l_64_3 = {}
	for i_0 in l_64_1:children() do
		table.insert(l_64_3, managers.shape:parse(i_0))
	end
	l_64_0._unit_groups[l_64_2] = l_64_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CorePortal.create = function(l_65_0, l_65_1)
	local l_65_5, l_65_6, l_65_7, l_65_8, l_65_13, l_65_14, l_65_15, l_65_16, l_65_20, l_65_21, l_65_22, l_65_23, l_65_24 = nil
	if not Application:editor() then
		for i_0,i_1 in pairs(l_65_0._portal_shapes) do
			for i_0,i_1 in ipairs(i_1.portal) do
				local l_65_11 = {}
				table.insert(l_65_11, i_1.pos + l_65_1)
			end
			if l_65_10.top == 0 and l_65_10.bottom == 0 then
				local l_65_29, l_65_31 = nil, managers.portal:add_portal
				do
					local l_65_30, l_65_32 = managers.portal, l_65_11
					l_65_31(l_65_30, l_65_32, l_65_29, nil)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		for i_0,i_1 in pairs(l_65_0._unit_groups) do
			local l_65_17, l_65_18, l_65_19 = nil
			l_65_11 = managers
			l_65_11 = l_65_11.portal
			l_65_11, l_65_17 = l_65_11:add_unit_group, l_65_11
			l_65_18 = i_0
			l_65_11 = l_65_11(l_65_17, l_65_18)
			local l_65_25 = nil
			l_65_17 = ipairs
			l_65_18 = i_1
			l_65_17 = l_65_17(l_65_18)
			for l_65_25,i_1 in l_65_17 do
				local l_65_27, l_65_28 = nil
				l_65_27, l_65_28 = l_65_11:add_shape, l_65_11
				l_65_27(l_65_28, l_65_26)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 30 
end

if not CoreWire then
	CoreWire = class()
end
CoreWire.init = function(l_66_0, l_66_1)
	l_66_0._unit_name = l_66_1:parameter("name")
	managers.worlddefinition:preload_unit(l_66_0._unit_name)
	l_66_0._generic = Generic:new(l_66_1)
	l_66_1:for_each("wire", callback(l_66_0, l_66_0, "parse_wire"))
end

CoreWire.parse_wire = function(l_67_0, l_67_1)
	l_67_0._target_pos = math.string_to_vector(l_67_1:parameter("target_pos"))
	local l_67_2 = math.string_to_vector(l_67_1:parameter("target_rot"))
	l_67_0._target_rot = Rotation(l_67_2.x, l_67_2.y, l_67_2.z)
	l_67_0._slack = tonumber(l_67_1:parameter("slack"))
end

CoreWire.create_unit = function(l_68_0, l_68_1)
	l_68_0._unit = managers.worlddefinition:make_unit(l_68_0._unit_name, l_68_0._generic, l_68_1)
	if l_68_0._unit then
		l_68_0._unit:wire_data().slack = l_68_0._slack
		local l_68_2 = l_68_0._unit:get_object("a_target")
		l_68_2:set_position(l_68_0._target_pos)
		l_68_2:set_rotation(l_68_0._target_rot)
		wire_set_midpoint(l_68_0._unit, "rp", "a_target", "a_bender")
		l_68_0._unit:set_moving()
	end
	return l_68_0._unit
end

CoreHubElementUnit.init = function(l_69_0, l_69_1)
	l_69_0._unit_name = l_69_1:parameter("name")
	managers.worlddefinition:preload_unit(l_69_0._unit_name)
	l_69_0._stage = "stage1"
	if l_69_1:parameter("stage") then
		l_69_0._stage = l_69_1:parameter("stage")
	end
	l_69_0._generic = Generic:new(l_69_1)
	l_69_1:for_each("type", callback(l_69_0, l_69_0, "parse_type"))
	l_69_1:for_each("values", callback(l_69_0, l_69_0, "parse_values"))
end

CoreHubElementUnit.parse_type = function(l_70_0, l_70_1)
	local l_70_2 = l_70_1:parameter("name")
	if l_70_2 == "area" then
		l_70_0._type = WHArea:new(l_70_1)
	end
end

CoreHubElementUnit.parse_values = function(l_71_0, l_71_1)
	l_71_0._values = WHubElementValues:new(l_71_1)
end

CoreHubElementUnit.create_unit = function(l_72_0, l_72_1)
	l_72_0._unit = managers.worlddefinition:make_unit(l_72_0._unit_name, l_72_0._generic, l_72_1)
	if l_72_0._unit then
		l_72_0._unit:hub_element_data().stage = l_72_0._stage
		local l_72_2 = script_data.hub_elements
		local l_72_3 = l_72_0._unit:unit_data().unit_id
		l_72_2[l_72_3] = l_72_0._unit
		l_72_2 = l_72_0._type
		if l_72_2 then
			l_72_2 = l_72_0._type
			l_72_2, l_72_3 = l_72_2:make_unit, l_72_2
			l_72_2(l_72_3, l_72_0._unit)
		end
		l_72_2 = l_72_0._values
	if l_72_2 then
		end
		l_72_2 = l_72_0._values
		l_72_2, l_72_3 = l_72_2:set_values, l_72_2
		l_72_2(l_72_3, l_72_0._unit)
		l_72_2 = l_72_0._unit
		l_72_2, l_72_3 = l_72_2:hub_element, l_72_2
		l_72_2 = l_72_2(l_72_3)
		l_72_2, l_72_3 = l_72_2:load_data, l_72_2
		l_72_2(l_72_3)
	end
	return l_72_0._unit
end

if not WHArea then
	WHArea = class()
end
WHArea.init = function(l_73_0, l_73_1)
	local l_73_5, l_73_6, l_73_7, l_73_8, l_73_9, l_73_10, l_73_11, l_73_12, l_73_13 = nil
	l_73_0._area_name = l_73_1:parameter("area_name")
	if l_73_1:has_parameter("area_type") then
		l_73_0._area_type = l_73_1:parameter("area_type")
	end
	l_73_0._shapes = {}
	for i_0 in l_73_1:children() do
		if i_0:parameter("type") == "sphere" then
			table.insert(l_73_0._shapes, WHAreaSphere:new(i_0))
		else
			if i_0:parameter("type") == "box" then
				table.insert(l_73_0._shapes, WHAreaBox:new(i_0))
			end
		else
			if i_0:parameter("type") == "plane" then
				table.insert(l_73_0._shapes, WHAreaPlane:new(i_0))
			end
		end
	end
end

WHArea.make_unit = function(l_74_0, l_74_1)
	l_74_1:hub_element():load_data(l_74_0)
end

if not WHAreaSphere then
	WHAreaSphere = class()
end
WHAreaSphere.init = function(l_75_0, l_75_1)
	l_75_0._type = "sphere"
	l_75_0._radious = tonumber(l_75_1:parameter("radious"))
	l_75_0._height = 0
	if l_75_1:has_parameter("height") then
		l_75_0._height = tonumber(l_75_1:parameter("height"))
	end
	l_75_0._generic = Generic:new(l_75_1)
end

if not WHAreaBox then
	WHAreaBox = class()
end
WHAreaBox.init = function(l_76_0, l_76_1)
	l_76_0._type = "box"
	l_76_0._width = tonumber(l_76_1:parameter("width"))
	l_76_0._length = tonumber(l_76_1:parameter("length"))
	l_76_0._height = 0
	if l_76_1:has_parameter("height") then
		l_76_0._height = tonumber(l_76_1:parameter("height"))
	end
	l_76_0._generic = Generic:new(l_76_1)
end

if not WHAreaPlane then
	WHAreaPlane = class()
end
WHAreaPlane.init = function(l_77_0, l_77_1)
	l_77_0._type = "plane"
	l_77_0._width = tonumber(l_77_1:parameter("width"))
	l_77_0._height = 0
	if l_77_1:has_parameter("height") then
		l_77_0._height = tonumber(l_77_1:parameter("height"))
	end
	l_77_0._generic = Generic:new(l_77_1)
end

if not WHubElementValues then
	WHubElementValues = class()
end
WHubElementValues.init = function(l_78_0, l_78_1)
	l_78_0._values = parse_values_node(l_78_1)
end

WHubElementValues.set_values = function(l_79_0, l_79_1)
	local l_79_5, l_79_6 = nil
	for i_0,i_1 in pairs(l_79_0._values) do
		l_79_1:hub_element_data()[i_0] = i_1
	end
end

CoreWorldDefinition.make_generic_data = function(l_80_0, l_80_1)
	local l_80_13, l_80_14, l_80_15, l_80_16, l_80_17, l_80_18, l_80_19, l_80_20 = nil
	local l_80_2 = {}
	l_80_2._name_id = "none"
	l_80_2._lights = {}
	l_80_2._triggers = {}
	l_80_2._exists_in_stages = {}
	local l_80_3 = l_80_1.generic
	local l_80_4 = l_80_1.lights
	local l_80_5 = l_80_1.variation
	local l_80_6 = l_80_1.material_variation
	local l_80_7 = l_80_1.triggers
	local l_80_8 = l_80_1.cutscene_actor
	local l_80_9 = l_80_1.disable_shadows
	if l_80_3 then
		l_80_2._unit_id = l_80_3.unit_id
		l_80_2._name_id = l_80_3.name_id
		l_80_2._group_name = l_80_3.group_name
	end
	for i_0,i_1 in ipairs(l_80_4) do
		table.insert(l_80_2._lights, i_1)
	end
	if l_80_5 then
		l_80_2._variation = l_80_5.value
	end
	if l_80_6 then
		l_80_2._material_variation = l_80_6.value
	end
	if l_80_7 then
		for i_0,i_1 in ipairs(l_80_7) do
			table.insert(l_80_2._triggers, i_1)
		end
	end
	if l_80_8 then
		l_80_2.cutscene_actor = l_80_8.name
	end
	if l_80_9 then
		l_80_2.disable_shadows = l_80_9.value
	end
	l_80_2._editable_gui = l_80_1.editable_gui
	return l_80_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not Generic then
	Generic = class()
end
Generic.init = function(l_81_0, l_81_1)
	l_81_0._name_id = "none"
	l_81_0._lights = {}
	l_81_0._triggers = {}
	l_81_0._exists_in_stages = {}
	l_81_1:for_each("generic", callback(l_81_0, l_81_0, "parse_generic"))
	l_81_1:for_each("orientation", callback(l_81_0, l_81_0, "parse_orientation"))
	l_81_1:for_each("light", callback(l_81_0, l_81_0, "parse_light"))
	l_81_1:for_each("variation", callback(l_81_0, l_81_0, "parse_variation"))
	l_81_1:for_each("material_variation", callback(l_81_0, l_81_0, "parse_material_variation"))
	l_81_1:for_each("trigger", callback(l_81_0, l_81_0, "parse_trigger"))
	l_81_1:for_each("editable_gui", callback(l_81_0, l_81_0, "parse_editable_gui"))
	l_81_1:for_each("settings", callback(l_81_0, l_81_0, "parse_settings"))
	l_81_1:for_each("legend_settings", callback(l_81_0, l_81_0, "parse_legend_settings"))
	l_81_1:for_each("exists_in_stage", callback(l_81_0, l_81_0, "parse_exists_in_stage"))
	l_81_1:for_each("cutscene_actor", callback(l_81_0, l_81_0, "cutscene_actor_settings"))
	l_81_1:for_each("disable_shadows", callback(l_81_0, l_81_0, "parse_disable_shadows"))
end

Generic.parse_orientation = function(l_82_0, l_82_1)
	l_82_0._position = math.string_to_vector(l_82_1:parameter("pos"))
	local l_82_2 = math.string_to_vector(l_82_1:parameter("rot"))
	l_82_0._rotation = Rotation(l_82_2.x, l_82_2.y, l_82_2.z)
end

Generic.parse_generic = function(l_83_0, l_83_1)
	if l_83_1:has_parameter("unit_id") then
		l_83_0._unit_id = tonumber(l_83_1:parameter("unit_id"))
	end
	if l_83_1:has_parameter("name_id") then
		l_83_0._name_id = l_83_1:parameter("name_id")
	end
	if l_83_1:has_parameter("group_name") then
		l_83_0._group_name = l_83_1:parameter("group_name")
	end
	if l_83_1:has_parameter("continent") then
		local l_83_2 = l_83_1:parameter("continent")
	if l_83_2 ~= "nil" then
		end
		l_83_0._continent = l_83_2
	end
end

Generic.parse_light = function(l_84_0, l_84_1)
	local l_84_2 = l_84_1:parameter("name")
	local l_84_3 = tonumber(l_84_1:parameter("far_range"))
	local l_84_4 = toboolean(l_84_1:parameter("enabled"))
	local l_84_5 = (math.string_to_vector(l_84_1:parameter("color")))
	local l_84_6, l_84_7, l_84_8, l_84_9 = nil, nil, nil, nil
	if l_84_1:has_parameter("angle_start") then
		l_84_6 = tonumber(l_84_1:parameter("angle_start"))
		l_84_7 = tonumber(l_84_1:parameter("angle_end"))
	end
	if l_84_1:has_parameter("multiplier") then
		l_84_8 = l_84_1:parameter("multiplier")
	end
	if l_84_1:has_parameter("falloff_exponent") then
		l_84_9 = tonumber(l_84_1:parameter("falloff_exponent"))
	end
	local l_84_10 = table.insert
	local l_84_11 = l_84_0._lights
	local l_84_12 = {}
	l_84_12.name = l_84_2
	l_84_12.far_range = l_84_3
	l_84_12.enable = l_84_4
	l_84_12.color = l_84_5
	l_84_12.angle_start = l_84_6
	l_84_12.angle_end = l_84_7
	l_84_12.multiplier = l_84_8
	l_84_12.falloff_exponent = l_84_9
	l_84_10(l_84_11, l_84_12)
end

Generic.parse_variation = function(l_85_0, l_85_1)
	l_85_0._variation = l_85_1:parameter("value")
end

Generic.parse_material_variation = function(l_86_0, l_86_1)
	l_86_0._material_variation = l_86_1:parameter("value")
end

Generic.parse_settings = function(l_87_0, l_87_1)
	l_87_0._unique_item = toboolean(l_87_1:parameter("unique_item"))
end

Generic.parse_legend_settings = function(l_88_0, l_88_1)
	l_88_0._legend_name = l_88_1:parameter("legend_name")
end

Generic.cutscene_actor_settings = function(l_89_0, l_89_1)
	l_89_0.cutscene_actor = l_89_1:parameter("name")
end

Generic.parse_disable_shadows = function(l_90_0, l_90_1)
	l_90_0.disable_shadows = toboolean(l_90_1:parameter("value"))
end

Generic.parse_exists_in_stage = function(l_91_0, l_91_1)
	local l_91_2 = l_91_0._exists_in_stages
	local l_91_3 = tonumber(l_91_1:parameter("stage"))
	l_91_2[l_91_3] = toboolean(l_91_1:parameter("value"))
end

Generic.parse_trigger = function(l_92_0, l_92_1)
	local l_92_2 = {}
	l_92_2.name = l_92_1:parameter("name")
	l_92_2.id = tonumber(l_92_1:parameter("id"))
	l_92_2.notify_unit_id = tonumber(l_92_1:parameter("notify_unit_id"))
	l_92_2.time = tonumber(l_92_1:parameter("time"))
	l_92_2.notify_unit_sequence = l_92_1:parameter("notify_unit_sequence")
	table.insert(l_92_0._triggers, l_92_2)
end

Generic.parse_editable_gui = function(l_93_0, l_93_1)
	local l_93_2 = l_93_1:parameter("text")
	local l_93_3 = math.string_to_vector(l_93_1:parameter("font_color"))
	local l_93_4 = tonumber(l_93_1:parameter("font_size"))
	local l_93_5 = {}
	l_93_5.text = l_93_2
	l_93_5.font_color = l_93_3
	l_93_5.font_size = l_93_4
	l_93_0._editable_gui = l_93_5
end

if not LightPreset then
	LightPreset = class()
end
LightPreset.intensity_value = function()
	local l_94_0 = {}
	local l_94_4, l_94_5 = ipairs, LightIntensityDB:list()
	l_94_4 = l_94_4(l_94_5)
	for i_0,i_1 in l_94_4 do
		table.insert(l_94_0, LightIntensityDB:lookup(l_94_3))
	end
	table.sort(l_94_0)
	return l_94_0
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

LightPreset.INTENSITY_VALUES = LightPreset.intensity_value()
get_intensity_preset = function(l_95_0)
	local l_95_1 = LightIntensityDB:reverse_lookup(l_95_0)
	if l_95_1 ~= "undefined" then
		return l_95_1
	end
	local l_95_2 = LightPreset.INTENSITY_VALUES
	for l_95_6 = 1, #l_95_2 do
		local l_95_7 = l_95_2[l_95_6 + 1]
		local l_95_8 = l_95_2[l_95_6]
		if not l_95_7 then
			local l_95_9, l_95_10 = LightIntensityDB:reverse_lookup, LightIntensityDB
			local l_95_11 = l_95_8
			return l_95_9(l_95_10, l_95_11)
		end
		if l_95_8 < l_95_0 and l_95_0 < l_95_7 then
			if l_95_0 - l_95_8 < l_95_7 - l_95_0 then
				local l_95_12, l_95_13 = LightIntensityDB:reverse_lookup, LightIntensityDB
				local l_95_14 = l_95_8
				return l_95_12(l_95_13, l_95_14)
			else
				local l_95_15, l_95_16 = LightIntensityDB:reverse_lookup, LightIntensityDB
				local l_95_17 = l_95_7
				return l_95_15(l_95_16, l_95_17)
			end
		elseif l_95_0 < l_95_8 then
			local l_95_18, l_95_19 = LightIntensityDB:reverse_lookup, LightIntensityDB
			local l_95_20 = l_95_8
			return l_95_18(l_95_19, l_95_20)
		end
	end
end


