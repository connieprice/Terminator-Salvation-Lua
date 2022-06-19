if not LocalizerMappingManager then
	LocalizerMappingManager = class()
end
LocalizerMappingManager.init = function(l_1_0)
	l_1_0._localizer_mapping = {}
	l_1_0._controller = {}
	l_1_0._unit = {}
	l_1_0._user = {}
end

LocalizerMappingManager.get_localizer_mapping_by_unit = function(l_2_0, l_2_1)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_9 = nil
	for i_0,i_1 in pairs(l_2_0._unit) do
		if i_1 == l_2_1 then
			local l_2_12 = l_2_0:get_localizer_mapping_by_slot
			return l_2_12(l_2_0, l_2_10)
		end
	end
end

LocalizerMappingManager.get_localizer_mapping_by_slot = function(l_3_0, l_3_1)
	return l_3_0._localizer_mapping[l_3_1]
end

LocalizerMappingManager.update_mapping = function(l_4_0)
	l_4_0._localizer_mapping = {}
	l_4_0:_update_mapping(1)
	l_4_0:_update_mapping(2)
end

LocalizerMappingManager._update_mapping = function(l_5_0, l_5_1)
	l_5_0._localizer_mapping[l_5_1] = {}
	if not l_5_0._user[l_5_1] then
		local l_5_2 = managers.player_slot:slot(l_5_1)
		l_5_0._unit[l_5_1] = l_5_2:spawned_unit()
		if not l_5_0._unit[l_5_1] then
			return 
		end
		l_5_0._user[l_5_1] = l_5_2:user()
		if not l_5_0._user[l_5_1] then
			return 
		end
	end
	l_5_0._controller[l_5_1] = l_5_0._user[l_5_1]:controller_wrapper()
	l_5_0:_map_table(l_5_1, tweak_data.localizer.MAPPINGS)
	if l_5_0._user[l_5_1]:controller_wrapper():get_default_controller_id() == "keyboard" then
		l_5_0:_update_keyboard_specifics(l_5_1)
	else
		l_5_0:_update_gamepad_specifics(l_5_1)
	end
end

LocalizerMappingManager._update_keyboard_specifics = function(l_6_0, l_6_1)
	l_6_0:_map_table(l_6_1, tweak_data.localizer.KEYBOARD)
end

LocalizerMappingManager._update_gamepad_specifics = function(l_7_0, l_7_1)
	l_7_0:_map_table(l_7_1, tweak_data.localizer.GAME_PAD)
end

LocalizerMappingManager._map_table = function(l_8_0, l_8_1, l_8_2)
	local l_8_6, l_8_7, l_8_8, l_8_9, l_8_14, l_8_15, l_8_16, l_8_17 = nil
	for i_0,i_1 in pairs(l_8_2) do
		for i_0,i_1 in pairs(string.split(i_1, ";")) do
			local l_8_12 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_8_0._controller[l_8_1]:get_connection_settings(i_1) then
				if l_8_0._controller[l_8_1]:get_connection_settings(i_1)._controller_id ~= "mouse" or i_1 == "switch_primary_weapon" or l_8_0._localizer_mapping[l_8_1][l_8_10] then
					l_8_0._localizer_mapping[l_8_1][l_8_10] = l_8_0._localizer_mapping[l_8_1][l_8_10] .. "[" .. "" .. l_8_0._controller[l_8_1]:get_connection_settings(i_1)._input_name_list[1]:upper() .. "]"
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				else
					l_8_0._localizer_mapping[l_8_1][l_8_10] = "[" .. "" .. l_8_0._controller[l_8_1]:get_connection_settings(i_1)._input_name_list[1]:upper() .. "]"
				end
			else
				l_8_0._localizer_mapping[l_8_1][l_8_10] = i_1
			end
		end
	end
end

LocalizerMappingManager.skip_tutorial = function(l_9_0, l_9_1)
	if l_9_0._user[1]:controller_wrapper():get_default_controller_id() == "keyboard" and tweak_data.localizer.KEYBOARD_SKIP_TUTORIALS[l_9_1.text] then
		return true
	end
	return false
end


