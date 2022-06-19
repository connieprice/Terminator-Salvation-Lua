if not CoreAiArea then
	CoreAiArea = class()
end
CoreAiArea.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._unit = l_1_1
	l_1_0._spawn_point_index = 1
	l_1_0._obj = l_1_0._unit:get_object(l_1_3)
	l_1_0._nav = Search:nav(l_1_2 .. l_1_3)
	l_1_0._nav:set_reference_object(l_1_0._obj)
	l_1_0._spawn_points = {}
	l_1_0:find_spawnpoints(l_1_4)
end

CoreAiArea.spawn = function(l_2_0, l_2_1, l_2_2)
	if l_2_2 ~= "" then
		local l_2_3, l_2_4, l_2_5, l_2_6, l_2_7, l_2_8, l_2_9 = l_2_0._unit:get_object(l_2_2)
	else
		if #l_2_0._spawn_points < l_2_0._spawn_point_index then
			return 
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_2_10 = nil
	if World:raycast("ray", l_2_0._spawn_points[l_2_0._spawn_point_index]:position() + l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 100, l_2_0._spawn_points[l_2_0._spawn_point_index]:position() - l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")) then
		local l_2_11 = nil
		if World:spawn_unit(l_2_1, World:raycast("ray", l_2_0._spawn_points[l_2_0._spawn_point_index]:position() + l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 100, l_2_0._spawn_points[l_2_0._spawn_point_index]:position() - l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")).position):base() ~= nil and World:spawn_unit(l_2_1, World:raycast("ray", l_2_0._spawn_points[l_2_0._spawn_point_index]:position() + l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 100, l_2_0._spawn_points[l_2_0._spawn_point_index]:position() - l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")).position):base().link ~= nil then
			World:spawn_unit(l_2_1, World:raycast("ray", l_2_0._spawn_points[l_2_0._spawn_point_index]:position() + l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 100, l_2_0._spawn_points[l_2_0._spawn_point_index]:position() - l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")).position):base():link(l_2_0._unit, l_2_0._obj, l_2_0._nav)
		end
		return World:spawn_unit(l_2_1, World:raycast("ray", l_2_0._spawn_points[l_2_0._spawn_point_index]:position() + l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 100, l_2_0._spawn_points[l_2_0._spawn_point_index]:position() - l_2_0._spawn_points[l_2_0._spawn_point_index]:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")).position)
	end
end

CoreAiArea.find_spawnpoints = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9 = nil
	for i_0 in l_3_1:children() do
		if i_0:name() == "ai_spawn_point" and i_0:parameter("name") ~= "" and l_3_0._unit:get_object(i_0:parameter("name")) ~= nil then
			cat_print("spawn_system", "[" .. l_3_0._unit:name() .. "] AI spawn point found: " .. l_3_10:parameter("name"))
			table.insert(l_3_0._spawn_points, l_3_0._unit:get_object(i_0:parameter("name")))
		end
	end
end

if not CoreSpawnSystem then
	CoreSpawnSystem = class()
end
CoreSpawnSystem.init = function(l_4_0, l_4_1)
	l_4_0._unit = l_4_1
	l_4_0._post_init = false
	l_4_0._ai_surface_name = "surface_generic_spawner_"
	l_4_0._ai_spawn_areas = {}
	l_4_0:read_spawn_xml()
end

CoreSpawnSystem.get_linked_unit_list = function(l_5_0)
	local l_5_5, l_5_6, l_5_7, l_5_8, l_5_12, l_5_13, l_5_14, l_5_15 = nil
	local l_5_1 = {}
	if l_5_0._linked_unit_map then
		for i_0,i_1 in pairs(l_5_0._linked_unit_map) do
			for i_0,i_1 in pairs(i_1) do
				table.insert(l_5_1, i_1)
			end
		end
	end
	return l_5_1
end

CoreSpawnSystem.destroy = function(l_6_0)
	local l_6_4, l_6_5, l_6_6, l_6_7, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17, l_6_18, l_6_19, l_6_20 = nil
	if l_6_0._linked_unit_map then
		for i_0,i_1 in pairs(l_6_0._linked_unit_map) do
			for i_0,i_1 in pairs(i_1) do
				if alive(i_1) then
					cat_print("spawn_system", "[CoreSpawnSystem] Destroy unit: " .. i_1:name())
					i_1:set_slot(0)
				end
			end
		end
	end
end

CoreSpawnSystem.update = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_7, l_7_8, l_7_9, l_7_10, l_7_11 = nil
	if l_7_0._delayed_var_and_cb_init then
		for i_0,i_1 in pairs(l_7_0._delayed_var_and_cb_init) do
			l_7_0:set_var_and_cb(i_1, i_0)
		end
		l_7_0._delayed_var_and_cb_init = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_7_0._unit:set_extension_update_enabled("spawn_system", false)
	l_7_0._post_init = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSpawnSystem.get_child_unit = function(l_8_0, l_8_1, l_8_2)
	if l_8_0._linked_unit_map then
		local l_8_3 = l_8_0._linked_unit_map[l_8_1]
	if l_8_3 then
		end
		return l_8_3[l_8_2]
	end
	return nil
end

CoreSpawnSystem.init_ai_area = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = l_9_0._unit:get_object(l_9_1)
	if not l_9_0._ai_spawn_areas[l_9_3:name()] then
		local l_9_4 = l_9_0._ai_spawn_areas
		local l_9_5 = l_9_3:name()
		l_9_4[l_9_5] = CoreAiArea:new(l_9_0._unit, l_9_0._ai_surface_name, l_9_3:name(), l_9_2)
	end
end

CoreSpawnSystem.find_spawn_node = function(l_10_0, l_10_1)
	local l_10_5, l_10_6, l_10_7 = nil
	for i_0 in l_10_1:children() do
		if i_0:name() == "spawn" then
			cat_print("spawn_system", "[CoreSpawnSystem] Found spawn node on: " .. l_10_0._unit:name())
			return i_0
		end
	end
	Application:error("[CoreSpawnSystem] Could not find spawn node on: " .. l_10_0._unit:name())
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSpawnSystem.set_var_and_cb_delayed = function(l_11_0, l_11_1, l_11_2)
	if not l_11_0._post_init then
		if not l_11_0._delayed_var_and_cb_init then
			l_11_0._delayed_var_and_cb_init = {}
		end
		l_11_0._delayed_var_and_cb_init[l_11_2] = l_11_1
	else
		l_11_0:set_var_and_cb(l_11_1, l_11_2)
	end
end

CoreSpawnSystem.set_var_and_cb = function(l_12_0, l_12_1, l_12_2)
	local l_12_6, l_12_7, l_12_8, l_12_9, l_12_10, l_12_11, l_12_19, l_12_20, l_12_21, l_12_22 = nil
	for i_0 in l_12_2:children() do
		if i_0:name() == "variables" and i_0:parameter("extension") ~= "" then
			cat_print("spawn_system", "Found variable block for: " .. i_0:parameter("extension"))
			for i_0 in l_12_15:children() do
				if i_0:name() == "var" and i_0:parameter("name") ~= "" and i_0:parameter("val") ~= "" then
					cat_print("spawn_system", "Set variable: " .. i_0:parameter("name") .. "='" .. tostring(i_0:parameter("val") .. "'"))
					local l_12_17 = nil
					local l_12_18 = getmetatable(l_12_1)[l_12_15:parameter("extension")](l_12_1)
					l_12_18[l_12_16:parameter("name")] = l_12_16:parameter("val")
				end
			end
		end
	end
	for i_0 in l_12_2:children() do
		if l_12_23:name() == "callback" and i_0:parameter("name") ~= "" and l_12_23:parameter("extension") ~= "" then
			cat_print("spawn_system", "Building callback '" .. i_0:parameter("name") .. "' in extension '" .. l_12_23:parameter("extension") .. "'.")
			local l_12_24 = nil
			for l_12_28 = 1, table.size(l_12_23:parameter_map()) - 2 do
				local l_12_25 = {}
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_12_23:parameter("param" .. tostring()) ~= "" then
					cat_print("spawn_system", "Found parameter: " .. "param" .. tostring() .. "=\"" .. tostring(l_12_23:parameter("param" .. tostring())) .. "\"")
					 -- DECOMPILER ERROR: Confused about usage of registers!

					table.insert(l_12_25, l_12_23:parameter("param" .. tostring()))
				end
			end
			cat_print("spawn_system", "Call callback!")
			local l_12_30 = nil
			do
				local l_12_31 = nil
				getmetatable(l_12_1)[l_12_23:parameter("extension")](l_12_1)[l_12_24](l_12_1:base(), unpack(l_12_30))
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSpawnSystem.read_spawn_xml = function(l_13_0)
	local l_13_5 = l_13_0:find_spawn_node
	l_13_5 = l_13_5(l_13_0, UnitDatabase:get_unit_data(l_13_0._unit:name()):model_script_data())
	local l_13_1 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_13_5 then
		for i_0 in l_13_1 do
			local l_13_6 = l_13_4:name()
			local l_13_7 = l_13_4:parameter("name")
			if l_13_6 == "ai_area" and l_13_7 ~= "" then
				cat_print("spawn_system", "[CoreSpawnSystem] AI area defined: " .. l_13_7)
				do
					local l_13_11, l_13_19, l_13_20, l_13_21, l_13_22, l_13_25, l_13_26, l_13_29, l_13_32, l_13_35, l_13_36 = l_13_0:init_ai_area, l_13_0, l_13_7, l_13_4
					l_13_11(l_13_19, l_13_20, l_13_21)
					l_13_11, l_13_19 = l_13_4:children, l_13_4
					l_13_11 = l_13_11(l_13_19)
					for l_13_21 in l_13_11 do
						local l_13_8, l_13_9, l_13_10 = nil
						l_13_22, l_13_25 = l_13_21:parameter, l_13_21
						l_13_26 = "name"
						l_13_22 = l_13_22(l_13_25, l_13_26)
						local l_13_12 = nil
						l_13_25, l_13_26 = l_13_21:name, l_13_21
						l_13_25 = l_13_25(l_13_26)
						if l_13_25 == "unit" and l_13_22 ~= "" then
							l_13_25 = cat_print
							l_13_26 = "spawn_system"
							l_13_29 = "[CoreSpawnSystem] Spawning unit: "
							l_13_32 = l_13_22
							l_13_29 = l_13_29 .. l_13_32
							l_13_25(l_13_26, l_13_29)
							l_13_25 = l_13_0._ai_spawn_areas
							l_13_25 = l_13_25[l_13_7]
							l_13_25, l_13_26 = l_13_25:spawn, l_13_25
							l_13_29 = l_13_22
							l_13_32, l_13_35 = l_13_21:parameter, l_13_21
							l_13_36 = "spawn_point"
							l_13_35, l_13_32 = .end, l_13_32(l_13_35, l_13_36)
							l_13_25 = l_13_25(l_13_26, l_13_29, l_13_32, l_13_35, l_13_36, l_13_8, l_13_9, l_13_10, l_13_12)
							local l_13_13 = nil
							l_13_26 = l_13_0._linked_unit_map
							if not l_13_26 then
								l_13_0._linked_unit_map, l_13_26 = l_13_26, {}
							end
							l_13_26 = l_13_0._linked_unit_map
							l_13_26 = l_13_26[l_13_7]
							if not l_13_26 then
								local l_13_14, l_13_15 = nil
							end
							l_13_29 = l_13_0._linked_unit_map
							l_13_29[l_13_7], l_13_26 = l_13_26, {[l_13_22] = l_13_25}
							l_13_29, l_13_32 = l_13_0:set_var_and_cb_delayed, l_13_0
							l_13_35 = l_13_25
							l_13_36 = l_13_21
							l_13_29(l_13_32, l_13_35, l_13_36)
						end
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			if l_13_6 == "socket" and l_13_7 ~= "" then
				for i_0 in l_13_4:children() do
					local l_13_17, l_13_18 = nil
					l_13_17, l_13_18 = l_13_16:name, l_13_16
					l_13_17 = l_13_17(l_13_18)
					if l_13_17 == "unit" then
						l_13_17 = l_13_0._enabled_unit_map
						if not l_13_17 then
							l_13_0._enabled_unit_map, l_13_17 = l_13_17, {}
						end
						l_13_17 = l_13_0._enabled_unit_map
						l_13_17 = l_13_17[l_13_7]
						if not l_13_17 then
							local l_13_23, l_13_27, l_13_30, l_13_33, l_13_37 = nil
						end
						 -- DECOMPILER ERROR: Overwrote pending register.

						 -- DECOMPILER ERROR: Overwrote pending register.

						l_13_0._enabled_unit_map[l_13_7], l_13_17 = l_13_17, {[l_13_16:parameter("name")] = l_13_18}
					if l_13_18 then
						end
						l_13_0:setup_unit(l_13_4, l_13_16)
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_13_1 then
		l_13_0._unit:set_extension_update_enabled("spawn_system", false)
		l_13_0._post_init = true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSpawnSystem.setup_unit = function(l_14_0, l_14_1, l_14_2)
	local l_14_3 = l_14_1:parameter("name")
	local l_14_4 = l_14_2:parameter("name")
	cat_print("spawn_system", "[CoreSpawnSystem] Spawn unit '" .. l_14_4 .. "' in socket '" .. l_14_3 .. "'.")
	local l_14_5 = nil
	local l_14_6 = l_14_0._unit:get_object(l_14_3)
	if MassUnitManager:can_spawn_unit(l_14_4) then
		cat_print("spawn_system", "Spawning mass unit!")
		l_14_5 = MassUnitManager:spawn_unit(l_14_4, l_14_6:position(), l_14_6:rotation())
	else
		l_14_5 = World:spawn_unit(l_14_4, l_14_6:position(), l_14_6:rotation())
	end
	if not l_14_0._linked_unit_map then
		l_14_0._linked_unit_map = {}
	end
	if not l_14_0._linked_unit_map[l_14_3] then
		local l_14_7, l_14_8, l_14_9, l_14_14, l_14_15, l_14_22, l_14_23, l_14_24, l_14_25, l_14_27 = {}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_14_7[l_14_4] = l_14_5
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_14_0._linked_unit_map[l_14_3] = l_14_7
	if l_14_2:parameter("link_object") ~= "" then
		if l_14_5:base() and l_14_5:base().link then
			local l_14_13 = nil
			l_14_5:base():link(l_14_0._unit, l_14_3, l_14_2:parameter("link_object"))
			if l_14_5:base().link_object then
				for i_0 in l_14_2:children() do
					if i_0:name() == "object" and i_0:parameter("name") ~= "" and i_0:parameter("socket") ~= "" then
						l_14_5:base():link_object(l_14_0._unit, i_0:parameter("socket"), i_0:parameter("name"))
					end
				end
			end
		else
			local l_14_19 = nil
			l_14_0._unit:link(l_14_3, l_14_5, l_14_2:parameter("link_object"))
			for i_0 in l_14_2:children() do
				if l_14_20:name() == "object" and l_14_20:parameter("name") ~= "" and l_14_20:parameter("socket") ~= "" then
					local l_14_21 = i_0:parameter("name")
					l_14_5:get_object(l_14_21):link(l_14_0._unit:get_object(l_14_20:parameter("socket")))
					l_14_5:get_object(l_14_21):set_local_position(Vector3())
					l_14_5:get_object(l_14_21):set_local_rotation(Rotation())
				end
			end
		end
	else
		cat_print("spawn_system", "Spawning only! (No linking.)")
	end
	if not l_14_0._linked_unit_map then
		l_14_0._linked_unit_map = {}
	end
	if not l_14_0._linked_unit_map[l_14_3] then
		local l_14_26, l_14_28 = , {}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_14_28[l_14_4] = l_14_5
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_14_0._linked_unit_map[l_14_3] = l_14_28
	l_14_0:set_var_and_cb_delayed(l_14_5, l_14_2)
end

CoreSpawnSystem.set_unit_enabled = function(l_15_0, l_15_1, l_15_2, l_15_3)
	local l_15_4 = l_15_0._enabled_unit_map[l_15_1]
	if l_15_4 then
		local l_15_5 = l_15_4[l_15_2]
		if l_15_5 == nil then
			Application:error("Unable to set enabled state \"" .. tostring(l_15_3) .. "\" on unit name \"" .. tostring(l_15_2) .. "\" and socket name \"" .. tostring(l_15_1) .. "\". It doesn't exist.")
		else
			if not l_15_5 ~= not l_15_3 then
				if l_15_3 then
					l_15_0:setup_unit(l_15_0:get_socket_nodes(l_15_1, l_15_2))
				else
					local l_15_6 = l_15_0._linked_unit_map[l_15_1][l_15_2]
					l_15_0._linked_unit_map[l_15_1][l_15_2] = nil
				if alive(l_15_6) then
					end
					l_15_6:set_slot(0)
				end
				l_15_4[l_15_2] = l_15_3
			end
		end
	else
		Application:error("Unable to set enabled state \"" .. tostring(l_15_3) .. "\" on unit name \"" .. tostring(l_15_2) .. "\" and socket name \"" .. tostring(l_15_1) .. "\". It was either not disabled or it doesn't exist.")
	end
end

CoreSpawnSystem.get_socket_nodes = function(l_16_0, l_16_1, l_16_2)
	do
		local l_16_7, l_16_12 = l_16_0:find_spawn_node, l_16_0
		l_16_7 = l_16_7(l_16_12, UnitDatabase:get_unit_data(l_16_0._unit:name()):model_script_data())
		local l_16_3 = nil
		if l_16_7 then
			l_16_12, l_16_3 = l_16_7:children, l_16_7
			l_16_12 = l_16_12(l_16_3)
			for i_0 in l_16_12 do
				local l_16_6 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				local l_16_8 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_16_8 == "socket" and l_16_6 == l_16_1 then
					for i_0 in l_16_8 do
						if l_16_11:name() == "unit" and l_16_11:parameter("name") == l_16_2 then
							return l_16_5, l_16_11
						end
					end
					 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				end
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


