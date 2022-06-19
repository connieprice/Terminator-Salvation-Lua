core_change_unit_type = function(l_1_0, l_1_1)
	local l_1_5, l_1_6 = ipairs, ProjectDatabase:all(false, "unit")
	l_1_5 = l_1_5(l_1_6)
	for i_0,i_1 in l_1_5 do
		if string.find(l_1_4:name(), l_1_0) then
			local l_1_7 = ProjectDatabase:load_node(l_1_4)
			l_1_7:set_parameter("type", l_1_1)
			ProjectDatabase:save_node(l_1_7, l_1_4)
		end
	end
	ProjectDatabase:save()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

core_convert_material_configs_to_version_3 = function()
	core_do_convert_material_configs_to_version_3(ProjectDatabase)
	ProjectDatabase:save()
	core_do_convert_material_configs_to_version_3(CoreDatabase)
	CoreDatabase:save()
	cat_print("debug", "[core_convert_material_configs_to_version_3] Done!")
end

core_do_convert_material_configs_to_version_3 = function(l_3_0)
	local l_3_6, l_3_7 = nil
	local l_3_5 = cat_print
	l_3_5("debug", "[core_convert_material_configs_to_version_3] Converting: " .. l_3_0:root())
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_3_1 = nil
	l_3_1 = ipairs
	l_3_1 = l_3_1(l_3_5)
	for i_0,i_1 in l_3_1 do
		local l_3_13 = math.floor(l_3_4 / #l_3_5 * 100)
		cat_print("debug", "[core_convert_material_configs_to_version_3] " .. l_3_8:name() .. " " .. tostring(l_3_13) .. "%")
		local l_3_9 = l_3_0:load_node(l_3_8)
		if l_3_9 and l_3_9:parameter("version") ~= "3" then
			if l_3_9:parameter("version") == "2" and l_3_8:name() ~= "global_v2" then
				for i_0 in l_3_9:children() do
					i_0:set_parameter("version", "2")
				end
			else
				for i_0 in l_3_9:children() do
					i_0:set_parameter("version", "1")
				end
			end
			l_3_9:set_parameter("version", "3")
			l_3_0:save_node(l_3_9, l_3_8)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

core_output_unit_info = function(l_4_0, l_4_1)
	local l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13 = nil
	local l_4_2 = File:open(l_4_0, "w")
	l_4_2:write("")
	l_4_2:close()
	out("UnitInfo", "Start scanning units!")
	local l_4_3 = (UnitDatabase:get_all_unit_data())
	local l_4_4 = nil
	for i_0,i_1 in ipairs(l_4_3) do
		if not l_4_1 or i_1:name() == l_4_1 or l_4_4 then
			l_4_4 = true
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_4_14 < #l_4_3 then
				out("UnitInfo", "Scanning " .. i_1:name() .. "... Next unit is: " .. "")
				local l_4_16 = nil
				if not ProjectDatabase:lookup("unit", l_4_15:name()):valid() then
					local l_4_20, l_4_21 = nil
					out("UnitInfo", "Skipping " .. l_4_15:name() .. "! (Can't find it in database.)")
					l_4_20 = true
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				if not l_4_20 then
					for i_0 in ProjectDatabase:load_node(l_4_21):children() do
						local l_4_17, l_4_18 = nil
						if i_0:name() == "anim_state_machine" then
							out("UnitInfo", "Skipping " .. l_4_15:name() .. "! (Found animation state machine.)")
							l_4_17 = true
						end
				else
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if not l_4_17 and not l_4_15:model_script_data() then
					out("UnitInfo", "Skipping " .. l_4_15:name() .. "! (Can't find model xml node info.)")
				end
			if not true then
				end
				out("UnitInfo", "Test spawning...")
				local l_4_22 = nil
				local l_4_23 = nil
				local l_4_24 = nil
				local l_4_25 = World:spawn_unit_without_extensions(l_4_15:name(), Vector3(Vector3(math.random(100000) - 50000, math.random(100000) - 50000, math.random(100000) - 50000)))
				if File:open(l_4_0, "r") then
					local l_4_26 = nil
					 -- DECOMPILER ERROR: Overwrote pending register.

					if File:open(l_4_0, "r"):read() ~= "" then
						l_4_26:close()
					end
				end
				assert(File:open(l_4_0, "w"))
				 -- DECOMPILER ERROR: Confused about usage of registers!

				File:open(l_4_0, "w"):write("" .. l_4_25:name() .. " - Geometry Memory: " .. tostring(l_4_25:geometry_memory_use() / 1024) .. "K - NumMaterials: " .. tostring(#l_4_25:get_objects_by_type("material")) .. "\n")
				 -- DECOMPILER ERROR: Confused about usage of registers!

				File:open(l_4_0, "w"):close()
				l_4_25:set_slot(0)
			end
		end
		assert(File:open(l_4_0, "r"))
		File:open(l_4_0, "r"):close()
		out("UnitInfo", File:open(l_4_0, "r"):read() .. "\nDone!\n")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		File:open(l_4_0, "w"):write(File:open(l_4_0, "r"):read() .. "\nDone!\n")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		File:open(l_4_0, "w"):close()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 41 
end

core_send_email = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = "ruby \""
	local l_5_4 = Application:base_path()
	local l_5_5 = "send_email\" "
	local l_5_6 = l_5_0
	local l_5_7 = " \""
	local l_5_9 = l_5_1 or "none"
	do
		l_5_3 = l_5_3 .. l_5_4 .. l_5_5 .. l_5_6 .. l_5_7 .. l_5_9 .. "\" \"" .. (l_5_2 or "none") .. "\""
		l_5_4 = Application
		l_5_4, l_5_5 = l_5_4:system, l_5_4
		l_5_6 = l_5_3
		l_5_7 = true
		l_5_4(l_5_5, l_5_6, l_5_7)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

rendering_toggle_fullscreen = function()
	local l_6_0 = core_setup_get_aspect()
	local l_6_1, l_6_2 = core_setup_get_mode()
	local l_6_3 = File:open(Application:render_settings_filename(), "w")
	l_6_3:puts("<renderer_config>\n\t<d3d_device adapter=\"" .. RenderSettings.adapter .. "\" resolution=\"" .. l_6_1.x .. " " .. l_6_1.y .. "\" refresh_rate=\"" .. l_6_1.z .. "\" windowed=\"" .. tostring(l_6_2) .. "\" aspect_ratio=\"" .. l_6_0 .. "\"/>\n</renderer_config>")
	l_6_3:close()
	if not Application:editor() then
		core_setup_resolution()
	end
end

rendering_change_resolution = function(l_7_0)
	local l_7_1 = core_setup_get_aspect()
	local l_7_2, l_7_3 = core_setup_get_mode()
	local l_7_4 = File:open(Application:render_settings_filename(), "w")
	l_7_4:puts("<renderer_config>\n\t<d3d_device adapter=\"" .. RenderSettings.adapter .. "\" resolution=\"" .. l_7_0.x .. " " .. l_7_0.y .. "\" refresh_rate=\"" .. l_7_0.z .. "\" windowed=\"" .. tostring(not l_7_3) .. "\" aspect_ratio=\"" .. l_7_1 .. "\"/>\n</renderer_config>")
	l_7_4:close()
	if not Application:editor() then
		core_setup_resolution()
	end
end

rendering_change_aspect_ratio = function(l_8_0)
	local l_8_1, l_8_2 = core_setup_get_mode()
	local l_8_3 = File:open(Application:render_settings_filename(), "w")
	l_8_3:puts("<renderer_config>\n\t<d3d_device adapter=\"" .. RenderSettings.adapter .. "\" resolution=\"" .. l_8_1.x .. " " .. l_8_1.y .. "\" refresh_rate=\"" .. l_8_1.z .. "\" windowed=\"" .. tostring(not l_8_2) .. "\" aspect_ratio=\"" .. l_8_0 .. "\"/>\n</renderer_config>")
	l_8_3:close()
	if not Application:editor() then
		core_setup_apply_aspect_settings()
	end
end

kb_str = function(l_9_0)
	return math.ceil(l_9_0 / 1024) .. "kb"
end

move_all_environments_to_database = function()
	local l_10_5, l_10_6, l_10_7, l_10_8, l_10_9, l_10_10, l_10_13, l_10_14, l_10_15, l_10_26, l_10_27, l_10_28, l_10_39, l_10_40, l_10_41 = nil
	local l_10_1 = function(l_11_0, l_11_1)
		-- upvalues: l_10_0
		local l_11_5, l_11_6 = pairs, l_11_1:parameter_map()
		l_11_5 = l_11_5(l_11_6)
		for i_0,i_1 in l_11_5 do
			if l_11_3 == "name" then
				l_11_0:set_parameter(l_11_3, string.lower(l_11_4))
			else
				l_11_0:set_parameter(l_11_3, l_11_4)
			end
		end
		for i_0 in l_11_1:children() do
			l_10_0(l_11_0:make_child(i_0:name()), i_0)
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
	for i_0 in File:parse_xml("data/settings/environments.xml"):children() do
		local l_10_2 = nil
		if i_0:name() == "environment" and i_0:parameter("name") and not ProjectDatabase:has("environment", string.lower(i_0:parameter("name"))) then
			l_10_1(Node(i_0:name()), l_10_12)
			do
				local l_10_19, l_10_20, l_10_21, l_10_22, l_10_23, l_10_32, l_10_33, l_10_34, l_10_35, l_10_36, l_10_45, l_10_46, l_10_47, l_10_48, l_10_49 = ProjectDatabase:add("environment", string.lower(i_0:parameter("name")), {}, "xml"), ProjectDatabase:save_node, ProjectDatabase
				l_10_23 = l_10_20
				l_10_32 = l_10_19
				l_10_21(l_10_22, l_10_23, l_10_32)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			if l_10_12:name() == "post_effects" then
				for i_0 in l_10_12:children() do
					local l_10_16, l_10_17 = nil
					if i_0:parameter("name") and not ProjectDatabase:has("environment_effect", string.lower(i_0:parameter("name"))) then
						l_10_1(Node(i_0:name()), i_0)
						ProjectDatabase:save_node(Node(i_0:name()), ProjectDatabase:add("environment_effect", string.lower(i_0:parameter("name")), {}, "xml"))
					end
				end
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			if l_10_17:name() == "underlay_effects" then
				for i_0 in l_10_17:children() do
					local l_10_29, l_10_30 = nil
					if i_0:parameter("name") and not ProjectDatabase:has("environment_underlay", string.lower(i_0:parameter("name"))) then
						l_10_1(Node(i_0:name()), i_0)
						ProjectDatabase:save_node(Node(i_0:name()), ProjectDatabase:add("environment_underlay", string.lower(i_0:parameter("name")), {}, "xml"))
					end
				end
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			if l_10_30:name() == "skies" then
				for i_0 in l_10_30:children() do
					local l_10_42, l_10_43 = nil
					if i_0:parameter("name") and not ProjectDatabase:has("environment_sky", string.lower(i_0:parameter("name"))) then
						l_10_1(Node(i_0:name()), i_0)
						ProjectDatabase:save_node(Node(i_0:name()), ProjectDatabase:add("environment_sky", string.lower(i_0:parameter("name")), {}, "xml"))
					end
				end
			end
		end
	end
	ProjectDatabase:save()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_look_for_material_duplicates = function()
	local l_11_3, l_11_4 = ipairs, ProjectDatabase:all(false, "material_config")
	l_11_3 = l_11_3(l_11_4)
	for i_0,i_1 in l_11_3 do
		local l_11_5 = 0
		local l_11_6 = ProjectDatabase:load_node(l_11_2):to_xml()
		local l_11_10, l_11_11 = ipairs, ProjectDatabase:all(false, "material_config")
		l_11_10 = l_11_10(l_11_11)
		for i_0,i_1 in l_11_10 do
			if l_11_2:name() ~= l_11_9:name() and l_11_6 == ProjectDatabase:load_node(l_11_9):to_xml() then
				l_11_5 = l_11_5 + 1
			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_list_material_duplicates = function()
	local l_12_0 = {}
	local l_12_4, l_12_5 = ipairs, ProjectDatabase:all(false, "material_config")
	l_12_4 = l_12_4(l_12_5)
	for i_0,i_1 in l_12_4 do
		local l_12_6 = 0
		local l_12_7 = ProjectDatabase:load_node(l_12_3):to_xml()
		if not l_12_0[l_12_3:name()] then
			local l_12_11, l_12_12 = ipairs, ProjectDatabase:all(false, "material_config")
			l_12_11 = l_12_11(l_12_12)
			for i_0,i_1 in l_12_11 do
				if l_12_3:name() ~= l_12_10:name() and not l_12_0[l_12_10:name()] and l_12_7 == ProjectDatabase:load_node(l_12_10):to_xml() then
					if l_12_6 == 0 then
						l_12_0[l_12_3:name()] = true
					end
					l_12_0[l_12_10:name()] = true
					l_12_6 = l_12_6 + 1
				end
			end
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_textures = function()
	local l_13_5, l_13_6, l_13_7, l_13_8, l_13_10, l_13_11, l_13_12, l_13_14 = nil
	local l_13_0 = {}
	local l_13_1 = File:list_config_files("/data/effects", "*")
	for i_0,i_1 in ipairs(l_13_1) do
		batch_textures_iterate_effects(File:parse_xml("/data/effects/" .. i_1), l_13_0)
	end
	local l_13_9 = "*"
	l_13_1 = File:list_config_files("/data/gui", l_13_9)
	for l_13_9,i_1 in ipairs(l_13_1) do
		local l_13_15, l_13_18, l_13_20, l_13_22, l_13_24, l_13_26, l_13_28 = batch_textures_iterate_gui
		l_13_18 = File
		l_13_18, l_13_20 = l_13_18:parse_xml, l_13_18
		l_13_22 = "/data/gui/"
		l_13_24 = l_13_13
		l_13_22 = l_13_22 .. l_13_24
		l_13_18 = l_13_18(l_13_20, l_13_22)
		l_13_20 = l_13_0
		l_13_15(l_13_18, l_13_20)
	end
	for i_0,i_1 in ipairs(ProjectDatabase:all(false, "material_config")) do
		local l_13_21, l_13_23, l_13_25, l_13_27, l_13_29 = ProjectDatabase:load_node(i_1)
		if l_13_21 then
			l_13_23 = batch_textures_iterate_materials
			l_13_25 = l_13_21
			l_13_27 = l_13_0
			l_13_29 = "|"
			l_13_23(l_13_25, l_13_27, l_13_29)
		end
	end
	for i_0,i_1 in ipairs(ProjectDatabase:all(false, "texture")) do
		if l_13_0[i_1:name()] then
			ProjectDatabase:set_metadata(i_1, "db_browser_folder", l_13_0[i_1:name()])
		else
			ProjectDatabase:set_metadata(i_1, "db_browser_folder", "unknown")
		end
	end
	ProjectDatabase:save()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_textures_iterate_effects = function(l_14_0, l_14_1)
	local l_14_5, l_14_6 = nil
	if l_14_0:name() == "data" and l_14_0:parameter("image") ~= "" then
		l_14_1[l_14_0:parameter("image")] = "effects"
	end
	for i_0 in l_14_0:children() do
		batch_textures_iterate_effects(i_0, l_14_1)
	end
end

batch_textures_iterate_gui = function(l_15_0, l_15_1)
	local l_15_7 = nil
	if l_15_0:name() == "bitmap" and l_15_0:parameter("texture") ~= "" then
		local l_15_2 = l_15_0:parameter("texture") .. "/"
		local l_15_3 = nil
		for l_15_11 in string.gmatch(l_15_2, "(.-)[\\/]+") do
			do
				local l_15_12 = nil
				l_15_3 = l_15_11
			end
		if l_15_3 then
			end
			l_15_1[l_15_3] = "gui"
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_15_2, l_15_3 = l_15_0:children, l_15_0
	l_15_2 = l_15_2(l_15_3)
	for i_0 in l_15_2 do
		local l_15_8, l_15_9, l_15_10 = nil
		batch_textures_iterate_gui(l_15_8, l_15_9)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_textures_iterate_materials = function(l_16_0, l_16_1, l_16_2)
	local l_16_7, l_16_8 = nil
	local l_16_3 = l_16_2 .. "_"
	if l_16_0:parameter("file") then
		l_16_1[l_16_0:parameter("file")] = "materials"
	end
	for i_0 in l_16_0:children() do
		batch_textures_iterate_materials(i_0, l_16_1, l_16_3)
	end
end

batch_material_config = function()
	local l_17_8, l_17_9, l_17_10, l_17_11, l_17_17, l_17_18, l_17_19, l_17_20, l_17_21, l_17_22, l_17_30, l_17_31, l_17_32, l_17_33, l_17_34 = nil
	local l_17_0 = UnitDatabase:get_all_unit_data()
	local l_17_1 = {}
	local l_17_2 = {}
	local l_17_3 = {}
	local l_17_4 = {}
	for i_0,i_1 in ipairs(l_17_0) do
		local l_17_14 = batch_material_config_for_unit(i_1)
		if not i_1 or ProjectDatabase:has("material_config", R16_PC20) then
			l_17_4[l_17_13:name()] = true
		else
			local l_17_15 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_17_16 = nil
			l_17_3[batch_material_config_nice_path(R14_PC29)] = l_17_15
			 -- DECOMPILER ERROR: Overwrote pending register.

			if not R14_PC29 then
				cat_debug(R16_PC20, "[batch_material_config] Warning! Expected proper file ending. (Like: " .. l_17_15 .. ".xml)")
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_17_3[batch_material_config_nice_path(R14_PC29) .. R16_PC20] = l_17_15 .. R16_PC20
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_17_4[l_17_13:name()] = true
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if not R14_PC29 then
				l_17_4[l_17_13:name()] = true
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_17_1[batch_material_config_nice_path(R14_PC29) .. R16_PC20] then
			l_17_1[batch_material_config_nice_path(R14_PC29) .. R16_PC20] = batch_material_config_nice_path(R16_PC20)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			l_17_1[batch_material_config_nice_path(R14_PC29) .. R16_PC20] = l_17_13:name()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_17_3[batch_material_config_nice_path(R14_PC29) .. R16_PC20] = l_17_15
	end
	for i_0,i_1 in ipairs(l_17_0) do
		if not l_17_4[i_1:name()] then
			local l_17_25 = batch_material_config_for_unit(i_1)
			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_17_26 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			local l_17_27 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			if not R14_PC29 then
				cat_debug(R16_PC20, "[batch_material_config] Warning! Expected proper file ending. (Like: " .. l_17_26 .. ".xml)")
				 -- DECOMPILER ERROR: Overwrote pending register.

			end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			if not l_17_2[l_17_24:model()] then
				local l_17_28 = batch_material_config_nice_path(R14_PC29) .. R16_PC20
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				local l_17_29 = R14_PC29
				R16_PC20:write(l_17_25 .. l_17_1[l_17_28] .. l_17_27)
				R16_PC20:close()
				l_17_2[l_17_24:model()] = true
			end
		end
	end
	for i_0,i_1 in pairs(l_17_1) do
		batch_material_config_and_import(l_17_3[i_0], i_1)
	end
	ProjectDatabase:save()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_material_config_nice_path = function(l_18_0)
	local l_18_6 = nil
	local l_18_1 = l_18_0 .. "/"
	local l_18_2 = ""
	for i_0 in string.gmatch(l_18_1, "(.-)[\\/]+") do
		l_18_2 = l_18_2 .. i_0
	end
	return l_18_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_material_config_and_import = function(l_19_0, l_19_1)
	if not ProjectDatabase:has("material_config", l_19_1) then
		local l_19_2 = File:parse_xml(l_19_0)
		local l_19_3 = Node(l_19_2:name())
		batch_material_config_create_node(l_19_3, l_19_2)
		ProjectDatabase:save_node(l_19_3, ProjectDatabase:add("material_config", l_19_1, {}, "xml"))
	end
end

batch_material_config_create_node = function(l_20_0, l_20_1)
	local l_20_5, l_20_6 = pairs, l_20_1:parameter_map()
	l_20_5 = l_20_5(l_20_6)
	for i_0,i_1 in l_20_5 do
		l_20_0:set_parameter(l_20_3, l_20_4)
	end
	for i_0 in l_20_1:children() do
		batch_material_config_create_node(l_20_0:make_child(i_0:name()), i_0)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_material_config_for_unit = function(l_21_0)
	local l_21_1 = l_21_0:model()
	local l_21_2 = File:open("data/objects/" .. l_21_1, "r")
	local l_21_3 = l_21_2:read()
	local l_21_4 = string.find(l_21_3, "materials=\"")
	local l_21_5 = 11
	l_21_2:close()
	if not l_21_4 then
		l_21_4 = string.find(l_21_3, "materials = \"")
		l_21_5 = 13
	end
	if not l_21_4 then
		cat_debug("debug", "[batch_material_config] Warning! Could not find the materials parameter in: data/objects/" .. l_21_1 .. " (It should be formated like this: materials=\"...\")")
		return 
	end
	local l_21_6 = l_21_4 + l_21_5
	local l_21_7 = string.sub(l_21_3, l_21_6)
	local l_21_8 = string.find(l_21_7, "\"")
	local l_21_9 = string.sub(l_21_7, l_21_8)
	local l_21_10 = string.sub(l_21_7, 1, l_21_8 - 1)
	local l_21_11 = string.sub(l_21_3, 1, l_21_6 - 1)
	if l_21_10 == "" then
		error("[batch_material_config] Empty materials parameter in: data/objects/" .. l_21_1)
	end
	return l_21_11, l_21_10, l_21_9
end

batch_units = function()
	cat_print("debug", "Start unit processing...")
	local l_22_0 = #UnitDatabase:get_all_unit_data()
	batch_units_in_folder("/data/units/", l_22_0, l_22_0)
	ProjectDatabase:save()
	cat_print("debug", "Unit processing done!")
end

batch_units_in_folder = function(l_23_0, l_23_1, l_23_2)
	local l_23_8, l_23_9, l_23_10, l_23_11, l_23_16, l_23_17 = nil
	local l_23_7 = File:list
	l_23_7 = l_23_7(File, l_23_0, "*.xml", false)
	local l_23_3 = nil
	l_23_3 = ipairs
	l_23_3 = l_23_3(l_23_7)
	for i_0,i_1 in l_23_3 do
		cat_print("debug", "\tProcessing: " .. i_1)
		local l_23_19 = File:parse_xml(l_23_0 .. i_1)
		if l_23_19:name() == "units" then
			for i_0 in l_23_19:children() do
				batch_units_do_unit(i_0)
				l_23_2 = l_23_2 - 1
			end
		else
			if l_23_19:name() == "unit" then
				batch_units_do_unit(l_23_19)
				l_23_2 = l_23_2 - 1
			end
		end
		cat_print("debug", "\n\t" .. tostring(math.floor((l_23_1 - (l_23_2)) / l_23_1 * 100)) .. "%\n")
	end
	local l_23_18 = true
	for l_23_18,i_1 in ipairs(File:list(l_23_0, "*.*", l_23_18)) do
		l_23_2 = batch_units_in_folder(l_23_0 .. i_1 .. "/", l_23_1, l_23_2)
	end
	return l_23_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_units_do_unit = function(l_24_0)
	if l_24_0:parameter("name") ~= "" and not CoreDatabase:has("unit", l_24_0:parameter("name")) then
		local l_24_1 = Node("unit")
		local l_24_5 = batch_units_create_node
		l_24_5(l_24_1, l_24_0, "unit", 0)
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_24_5 do
			if l_24_4:name() == "model" and l_24_4:parameter("file") ~= "" and not Database:lookup("object", l_24_4:parameter("file")):valid() then
				l_24_4:set_parameter("file", batch_units_process_model_xml(l_24_4:parameter("file")))
		else
			end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_24_5(l_24_1, "name", string.lower(l_24_1:parameter("name")))
		assert(not ProjectDatabase:has("unit", string.lower(l_24_1:parameter("name"))))
		assert(ProjectDatabase:add("unit", string.lower(l_24_1:parameter("name")), {}, "xml"):valid())
		ProjectDatabase:save_node(l_24_1, ProjectDatabase:add("unit", string.lower(l_24_1:parameter("name")), {}, "xml"))
		cat_print("debug", "\t[U]\tUnit XML done!")
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

batch_units_process_sequence_manager = function(l_25_0, l_25_1)
	local l_25_5, l_25_6 = nil
	for i_0 in l_25_0:children() do
		if i_0:name() == "sequence_manager" then
			assert(File:open(l_25_1, "w"))
			File:open(l_25_1, "w"):write(l_25_7:to_xml())
			File:open(l_25_1, "w"):close()
			l_25_0:remove_child_at(l_25_0:index_of_child(l_25_7))
			l_25_0:make_child("sequence_manager"):set_parameter("file", l_25_1)
			cat_print("debug", "\t[S]\tSequence Manager XML done!")
			return 
		end
	end
end

batch_units_process_diesel = function(l_26_0)
	local l_26_4, l_26_5, l_26_6 = nil
	for i_0 in l_26_0:children() do
		if i_0:name() == "diesel" and i_0:parameter("file") and i_0:parameter("file") ~= "" and not ProjectDatabase:has("model", i_0:parameter("file")) and File:exists(i_0:parameter("file")) then
			local l_26_8 = nil
			if not ProjectDatabase:has("model", string.lower(batch_units_nice_path(i_0:parameter("file")))) then
				local l_26_9 = nil
				assert(ProjectDatabase:add("model", string.lower(batch_units_nice_path(i_0:parameter("file"))), {}, "diesel"):valid())
				assert(File:copy_file(l_26_8, "db/" .. ProjectDatabase:add("model", string.lower(batch_units_nice_path(i_0:parameter("file"))), {}, "diesel"):path()))
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_26_7:set_parameter("file", l_26_9)
			cat_print("debug", "\t[D]\tDiesel done!")
			return 
		end
	end
end

batch_units_process_model_xml = function(l_27_0, l_27_1)
	local l_27_2 = "/data/objects/" .. l_27_0
	local l_27_3 = File:parse_xml(l_27_2)
	local l_27_4 = Node("dynamic_object")
	batch_units_create_node(l_27_4, l_27_3, "object", 0)
	batch_units_process_sequence_manager(l_27_4, l_27_2)
	batch_units_process_diesel(l_27_4)
	local l_27_5 = string.lower(batch_units_nice_path(l_27_0))
	if not ProjectDatabase:has("object", l_27_5) then
		local l_27_6 = ProjectDatabase:add("object", l_27_5, {}, "xml")
		assert(l_27_6:valid())
		ProjectDatabase:save_node(l_27_4, l_27_6)
		cat_print("debug", "\t[M]\tModel XML done!")
	end
	return l_27_5
end

batch_units_create_node = function(l_28_0, l_28_1, l_28_2, l_28_3)
	local l_28_7, l_28_8 = pairs, l_28_1:parameter_map()
	l_28_7 = l_28_7(l_28_8)
	for i_0,i_1 in l_28_7 do
		l_28_0:set_parameter(l_28_5, l_28_6)
	end
	if l_28_2 == "object" and (l_28_1:name() == "decal_surfaces" or l_28_1:name() ~= "mesh" or l_28_1:parameter("object") ~= "") then
		l_28_0:set_parameter("name", "u" .. tostring(l_28_3))
	end
	for i_0 in l_28_1:children() do
		if i_0:name() ~= "#text" and i_0:name() ~= "xdefine" then
			l_28_3 = batch_units_create_node(l_28_0:make_child(i_0:name()), i_0, l_28_2, l_28_3) + 1
		end
	end
	return l_28_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

batch_units_nice_path = function(l_29_0)
	local l_29_6, l_29_7 = nil
	local l_29_1 = l_29_0 .. "/"
	local l_29_2 = nil
	for i_0 in string.gmatch(l_29_1, "[%w_]+") do
		if not l_29_2 then
			l_29_2 = i_0
		else
			l_29_2 = l_29_2 .. "_" .. i_0
		end
	end
	assert(not l_29_2 or l_29_2 ~= "")
	return l_29_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

geometry_mem_analyzer = function()
	local l_30_5, l_30_6, l_30_7, l_30_8, l_30_9, l_30_10, l_30_11, l_30_12, l_30_19, l_30_20, l_30_22, l_30_24 = nil
	cat_debug("debug", "Geometry memory usage for all spawned units (note that some units may not be spawned at level start, such as units managed by MassUnitManager, spawned by effects etc.).\n")
	local l_30_0 = World:find_units_quick("all")
	local l_30_1 = {}
	for i_0,i_1 in ipairs(l_30_0) do
		local l_30_23, l_30_25 = i_1:geometry_memory_use()
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if not l_30_25 then
			local l_30_14 = nil
			do
				local l_30_15 = nil
				l_30_15 = l_30_23
				l_30_1[l_30_25], l_30_14 = l_30_14, {l_30_15, 1}
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			local l_30_16 = nil
			local l_30_17 = nil
			l_30_17 = l_30_23
			l_30_1[l_30_25], l_30_16 = l_30_16, {l_30_17, l_30_1[l_30_21:name()][2] + 1}
		end
	end
	for i_0,i_1 in pairs(l_30_1) do
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_30_33, l_30_35, l_30_37, l_30_39 = l_30_25.insert
		l_30_35 = {}
		local l_30_27, l_30_32, l_30_34, l_30_36, l_30_38, l_30_40 = nil
		local l_30_28 = nil
		l_30_39 = l_30_26
		l_30_27 = l_30_31[1]
		l_30_32 = l_30_31[2]
		l_30_33(l_30_35, l_30_37)
		l_30_37 = {l_30_39, l_30_27, l_30_32}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	table.sort({}, function(l_31_0, l_31_1)
		return l_31_0[2] < l_31_1[2]
  end)
	cat_debug("debug", "unit\tmem/instance\tnr instances")
	 -- DECOMPILER ERROR: Confused about usage of registers!

	for i_0,i_1 in pairs({}) do
		cat_debug("debug", i_1[1] .. "\t" .. kb_str(i_1[2]) .. "\t" .. i_1[3])
	end
	cat_debug("debug", "\n\nTotal used memory: " .. kb_str(0 + i_1[2]))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not CubeMapCreator then
	CubeMapCreator = class()
end
CubeMapCreator.init = function(l_31_0)
	l_31_0._camera = World:create_camera()
	l_31_0._vp = Application:create_world_viewport(0, 0, 1, 1)
	l_31_0._vp:set_camera(l_31_0._camera)
	l_31_0._camera:set_fov(90)
	l_31_0._camera:set_aspect_ratio(1)
	l_31_0._camera:set_near_range(20)
	l_31_0._camera:set_far_range(100000)
	l_31_0._creating_cube_map = false
end

CubeMapCreator.destroy = function(l_32_0)
	if l_32_0._vp then
		Application:destroy_viewport(l_32_0._vp)
		l_32_0._vp = nil
	end
end

CubeMapCreator.set_camera_rot = function(l_33_0, l_33_1)
	local l_33_2 = l_33_1:yaw()
	local l_33_3 = l_33_1:roll()
	l_33_0._camera:new_set_rotation(Rotation(l_33_2, 0, l_33_3))
end

CubeMapCreator.render = function(l_34_0)
	if l_34_0._creating_cube_map then
		l_34_0._creating_cube_map = false
		l_34_0:create_cube_map()
	end
end

CubeMapCreator.start_cube_map = function(l_35_0, l_35_1)
	l_35_0._camera:set_position(l_35_1)
	l_35_0._creating_cube_map = true
end

CubeMapCreator.create_cube_map = function(l_36_0)
	local l_36_1 = Application:create_texture("render_target", 512, 512)
	local l_36_2 = Application:create_texture("render_target", 512, 512)
	local l_36_3 = Application:create_texture("render_target", 512, 512)
	local l_36_4 = Application:create_texture("render_target", 512, 512)
	local l_36_5 = Application:create_texture("render_target", 512, 512)
	local l_36_6 = Application:create_texture("render_target", 512, 512)
	l_36_0:set_camera_rot(Rotation(Vector3(0, 1, 0), Vector3(0, 0, 1)))
	Application:render("World", l_36_0._vp, l_36_1)
	l_36_0:set_camera_rot(Rotation(Vector3(-1, 0, 0), Vector3(0, 0, 1)))
	Application:render("World", l_36_0._vp, l_36_2)
	l_36_0:set_camera_rot(Rotation(Vector3(0, -1, 0), Vector3(0, 0, 1)))
	Application:render("World", l_36_0._vp, l_36_3)
	l_36_0:set_camera_rot(Rotation(Vector3(1, 0, 0), Vector3(0, 0, 1)))
	Application:render("World", l_36_0._vp, l_36_4)
	l_36_0:set_camera_rot(Rotation(Vector3(0, 0, 1), Vector3(1, 0, 0)))
	Application:render("World", l_36_0._vp, l_36_5)
	l_36_0:set_camera_rot(Rotation(Vector3(0, 0, -1), Vector3(1, 0, 0)))
	Application:render("World", l_36_0._vp, l_36_6)
end

if not FFCController then
	FFCController = class()
end
FFCController.init = function(l_37_0, l_37_1, l_37_2)
	l_37_0._controller = l_37_2
	l_37_0._camera = l_37_1
	l_37_0._move_speed = 5000
	l_37_0._turn_speed = 150
	l_37_0._yaw = l_37_1:new_rotation():yaw()
	l_37_0._roll = l_37_1:new_rotation():roll()
	l_37_0._lock_pos = false
	l_37_0._cube_counter = 1
	l_37_0._creating_cube_map = false
end

FFCController.update = function(l_38_0, l_38_1, l_38_2)
	if l_38_0._camera then
		if l_38_0._creating_cube_map then
			l_38_0:create_cube_map()
			return 
		end
		local l_38_3 = l_38_0._move_speed * l_38_2
		local l_38_4 = l_38_0._turn_speed * l_38_2 * 0.1
		local l_38_5 = Vector3(0, 0, l_38_3 * (l_38_0._controller:button("altitude_up") - l_38_0._controller:button("altitude_down")))
		local l_38_6 = (l_38_0._controller:button("go_right") - l_38_0._controller:button("go_left")) * l_38_3
		local l_38_7 = (l_38_0._controller:button("forward") - l_38_0._controller:button("backward")) * l_38_3
		local l_38_8 = l_38_0._camera:new_rotation():x() * l_38_6 + l_38_0._camera:new_rotation():y() * l_38_7
		l_38_0._yaw = math.clamp(l_38_0._yaw + l_38_4 * -l_38_0._controller:axis("look").y, -90, 90)
		l_38_0._roll = l_38_0._roll + l_38_4 * -l_38_0._controller:axis("look").x
		if l_38_0._controller:has_axis("look_gamepad") then
			local l_38_9 = l_38_0._controller:axis("look_gamepad").x
			local l_38_10 = l_38_0._controller:axis("look_gamepad").y
			if math.abs(l_38_10) < 0.1 then
				l_38_10 = 0
			end
			if math.abs(l_38_9) < 0.1 then
				l_38_9 = 0
			end
			l_38_0._yaw = math.clamp(l_38_0._yaw + 10 * l_38_4 * -l_38_10, -90, 90)
			l_38_0._roll = l_38_0._roll + 10 * l_38_4 * -l_38_9
		end
		if l_38_0._controller:button("plane_switch") ~= 0 then
			l_38_8 = Vector3(l_38_8.x, l_38_8.y, 0)
		end
		l_38_0._camera:set_position(l_38_0._camera:position() + l_38_8 + l_38_5)
		l_38_0._camera:new_set_rotation(Rotation(l_38_0._yaw, 0, l_38_0._roll))
	end
end

FFCController.set_camera = function(l_39_0, l_39_1)
	l_39_0._camera = l_39_1
end

FFCController.set_camera_pos = function(l_40_0, l_40_1)
	l_40_0._camera:set_position(l_40_1)
end

FFCController.set_camera_rot = function(l_41_0, l_41_1)
	l_41_0._roll = l_41_1:roll()
	l_41_0._yaw = l_41_1:yaw()
	l_41_0._camera:new_set_rotation(Rotation(l_41_0._yaw, 0, l_41_0._roll))
end

FFCController.set_controller = function(l_42_0, l_42_1)
	l_42_0._controller = l_42_1
end

FFCController.set_move_speed = function(l_43_0, l_43_1)
	l_43_0._move_speed = l_43_1
end

FFCController.set_turn_speed = function(l_44_0, l_44_1)
	l_44_0._turn_speed = l_44_1
end

FFCController.set_fov = function(l_45_0, l_45_1)
	l_45_0._camera:set_fov(l_45_1)
end

FFCController.get_camera_pos = function(l_46_0)
	local l_46_1, l_46_2 = l_46_0._camera:position, l_46_0._camera
	return l_46_1(l_46_2)
end

FFCController.get_camera_rot = function(l_47_0)
	local l_47_1, l_47_2 = l_47_0._camera:new_rotation, l_47_0._camera
	return l_47_1(l_47_2)
end

FFCController.get_move_speed = function(l_48_0)
	return l_48_0._move_speed
end

FFCController.get_turn_speed = function(l_49_0)
	return l_49_0._turn_speed
end

FFCController.start_cube_map = function(l_50_0, l_50_1, l_50_2)
	do
		l_50_0._cubemap_name = l_50_2 or ""
		l_50_0._camera:set_fov(105)
		l_50_0._cube_counter = 0
		l_50_0._creating_cube_map = true
		l_50_0._cube_map_done_func = l_50_1
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

FFCController.creating_cube_map = function(l_51_0)
	return l_51_0._creating_cube_map
end

FFCController.create_cube_map = function(l_52_0)
	l_52_0._cube_counter = l_52_0._cube_counter + 1
	local l_52_1 = Application:screen_resolution()
	local l_52_2 = l_52_1.x - l_52_1.y
	local l_52_3 = l_52_2 / 2
	local l_52_4 = 0
	local l_52_5 = l_52_1.x - l_52_2 / 2
	local l_52_6 = l_52_1.y
	if l_52_0._cube_counter == 1 then
		l_52_0._camera:new_set_rotation(Rotation(Vector3(0, 0, 1), Vector3(0, -1, 0)))
		Application:screenshot(l_52_0._cubemap_name .. "_6(zpos).tga", l_52_3, l_52_4, l_52_5, l_52_6)
		assert(managers.environment:get_posteffect()):set_value("hdr_post_processor", "exposure_sepia_levels", "copy_luminance_target", 1)
		managers.environment:set_light_adaption(false)
	elseif l_52_0._cube_counter == 2 then
		l_52_0._camera:new_set_rotation(Rotation(Vector3(-1, 0, 0), Vector3(0, -1, 0)))
		Application:screenshot(l_52_0._cubemap_name .. "_1(xneg).tga", l_52_3, l_52_4, l_52_5, l_52_6)
	elseif l_52_0._cube_counter == 3 then
		l_52_0._camera:new_set_rotation(Rotation(Vector3(0, 1, 0), Vector3(0, 0, -1)))
		Application:screenshot(l_52_0._cubemap_name .. "_4(ypos).tga", l_52_3, l_52_4, l_52_5, l_52_6)
	elseif l_52_0._cube_counter == 4 then
		l_52_0._camera:new_set_rotation(Rotation(Vector3(1, 0, 0), Vector3(0, -1, 0)))
		Application:screenshot(l_52_0._cubemap_name .. "_2(xpos).tga", l_52_3, l_52_4, l_52_5, l_52_6)
	elseif l_52_0._cube_counter == 5 then
		l_52_0._camera:new_set_rotation(Rotation(Vector3(0, -1, 0), Vector3(0, 0, 1)))
		Application:screenshot(l_52_0._cubemap_name .. "_3(yneg).tga", l_52_3, l_52_4, l_52_5, l_52_6)
	elseif l_52_0._cube_counter == 6 then
		l_52_0._camera:new_set_rotation(Rotation(Vector3(0, 0, -1), Vector3(0, -1, 0)))
		Application:screenshot(l_52_0._cubemap_name .. "_5(zneg).tga", l_52_3, l_52_4, l_52_5, l_52_6)
	elseif l_52_0._cube_counter == 7 then
		managers.environment:set_light_adaption(true)
		assert(managers.environment:get_posteffect()):set_value("hdr_post_processor", "exposure_sepia_levels", "copy_luminance_target", 0)
		l_52_0._creating_cube_map = nil
		if l_52_0._cube_map_done_func then
			l_52_0._cube_map_done_func()
		end
		return true
	end
end

if not FFCEditorController then
	FFCEditorController = class(FFCController)
end
FFCEditorController.init = function(l_53_0, l_53_1, l_53_2)
	FFCController.init(l_53_0, l_53_1, l_53_2)
	l_53_0._mul = 112
end

FFCEditorController.update_orthographic = function(l_54_0, l_54_1, l_54_2)
	local l_54_3 = l_54_0._move_speed * l_54_2
	local l_54_4 = (l_54_0._controller:button("go_right") - l_54_0._controller:button("go_left")) * l_54_3
	local l_54_5 = (l_54_0._controller:button("forward") - l_54_0._controller:button("backward")) * l_54_3
	local l_54_6 = Vector3(l_54_4 * 5, l_54_5 * 5, 0)
	l_54_0._camera:set_position(l_54_0._camera:position() + l_54_6)
	l_54_0._mul = l_54_0._mul + l_54_3 * (l_54_0._controller:button("altitude_up") - l_54_0._controller:button("altitude_down")) / 100
	l_54_0:set_orthographic_screen()
end

FFCEditorController.set_orthographic_screen = function(l_55_0)
	local l_55_1 = Application:screen_resolution()
	l_55_0._camera:set_orthographic_screen(-(l_55_1.x / 2) * l_55_0._mul, l_55_1.x / 2 * l_55_0._mul, -(l_55_1.y / 2) * l_55_0._mul, l_55_1.y / 2 * l_55_0._mul)
end

FFCEditorController.toggle_orthographic = function(l_56_0, l_56_1)
	local l_56_2 = l_56_0._camera
	if l_56_1 then
		l_56_0._camera_settings = {}
		l_56_0._camera_settings.far_range = l_56_2:far_range()
		l_56_0._camera_settings.near_range = l_56_2:near_range()
		l_56_0._camera_settings.position = l_56_2:position()
		l_56_0._camera_settings.rotation = l_56_2:new_rotation()
		l_56_2:set_projection_type("orthographic")
		l_56_0:set_orthographic_screen()
		l_56_2:set_position(Vector3(0, 0, l_56_2:position().z))
		l_56_2:new_set_rotation(Rotation(-math.UP, Vector3(0, 1, 0)))
		l_56_2:set_far_range(75000)
	else
		l_56_2:set_projection_type("perspective")
		l_56_2:set_far_range(l_56_0._camera_settings.far_range)
		l_56_2:set_near_range(l_56_0._camera_settings.near_range)
		l_56_2:set_position(l_56_0._camera_settings.position)
		l_56_2:new_set_rotation(l_56_0._camera_settings.rotation)
	end
end


