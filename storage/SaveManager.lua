if not SaveManager then
	SaveManager = class()
end
SaveManager.init = function(l_1_0, l_1_1)
	l_1_0._debug_check_profile = false
	if l_1_1.primary_user_index then
		l_1_0._primary_user = managers.local_user:user_from_user_index(l_1_1.primary_user_index)
	end
end

SaveManager.default_data = function(l_2_0)
end

SaveManager.save = function(l_3_0, l_3_1)
	if l_3_0._primary_user then
		l_3_1.primary_user_index = l_3_0._primary_user:user_index()
	end
end

SaveManager.set_localized_chapter_names = function(l_4_0, l_4_1, l_4_2)
	l_4_0._chapter = l_4_1
	l_4_0._line = l_4_2
end

SaveManager.localized_chapter_names = function(l_5_0)
	return l_5_0._chapter, l_5_0._line
end

SaveManager.save_progress = function(l_6_0, l_6_1, l_6_2)
	local l_6_10, l_6_11, l_6_12, l_6_13, l_6_14, l_6_15, l_6_16, l_6_17, l_6_18, l_6_19 = nil
	assert(l_6_0._primary_user)
	assert(l_6_1)
	local l_6_3 = managers.local_user:users()
	local l_6_4 = l_6_0:profile()
	assert(l_6_4)
	local l_6_5 = l_6_4.save_progress
	if not l_6_2 then
		l_6_2 = l_6_4.current_level_id
	end
	if not l_6_2 then
		print("This is a debug or temporary level, so I can not save")
		return 
	end
	local l_6_6 = false
	for i_0,i_1 in pairs(l_6_3) do
		if i_1:is_playing_the_game() then
			cat_print("debug", "Saving progress for user index " .. i_1:user_index())
			if not i_1:profile().levels[l_6_2] then
				cat_print("debug", "This level is not included in the users profile. skip progress")
				return 
			end
			l_6_0:set_mission_objective_id_to_profile(i_1:profile(), l_6_2, l_6_1)
			i_1:profile().current_level_id = l_6_2
			i_1:profile().current_checkpoint_id = l_6_1
			i_1:profile().debug_level_name = nil
			if i_1:profile().save_progress then
				i_1:profile().progress_level_id = l_6_2
				i_1:profile().progress_checkpoint_id = l_6_1
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			i_1:profile().levels[l_6_2].maximum_checkpoint_id = math.max(i_1:profile().levels[l_6_2].maximum_checkpoint_id, l_6_1)
			i_1:profile().has_progress = true
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_6_22 = nil
			i_1:profile().levels[l_6_2].checkpoints[l_6_1].difficulty_levels[l_6_22.difficulty_level] = true
			local l_6_23 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if alive(l_6_21:assigned_unit()) then
				assert(not TableAlgorithms.is_empty(i_1:profile().levels[l_6_2].checkpoints[l_6_1].inventory))
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if l_6_22.save_progress or i_1:profile().levels[l_6_2].checkpoints[l_6_1].inventory.items[1].name == "" then
					print("saving inventory for unit " .. l_6_21:assigned_unit():name())
					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_6_0:_save_inventory_to_profile(l_6_22, l_6_21, i_1:profile().levels[l_6_2].checkpoints[l_6_1])
				end
			if not l_6_6 then
				end
				l_6_21:assigned_unit():hud_sound():progress_updated()
				l_6_6 = true
			end
			l_6_21:save_profile()
		end
	end
end

SaveManager._save_inventory_to_profile = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_4 = l_7_2:assigned_unit()
	assert(l_7_4, "Player has no unit at checkpoint")
	local l_7_5 = l_7_4:base()
	local l_7_6 = l_7_5:inventory()
	for l_7_10 = 1, 4 do
		local l_7_11 = l_7_6:item_by_index(l_7_10)
		if l_7_11 then
			local l_7_12 = 0
			if l_7_11:logic() then
				l_7_12 = l_7_11:logic():bullet_count()
			else
				l_7_12 = l_7_11:weapon_data()._ammo_pool + l_7_11:weapon_data()._bullets_in_clip
			end
			local l_7_13 = tweak_data.player.weapon[l_7_11:name()]
			if l_7_13 and l_7_13.respawn_min_ammo and l_7_12 < l_7_13.respawn_min_ammo then
				l_7_12 = l_7_13.respawn_min_ammo
			end
			l_7_3.inventory.items[l_7_10].name = l_7_11:name()
			l_7_3.inventory.items[l_7_10].ammo = l_7_12
		else
			l_7_3.inventory.items[l_7_10].name = ""
			l_7_3.inventory.items[l_7_10].ammo = 0
		end
	end
end

SaveManager.set_new_game = function(l_8_0)
	local l_8_1 = l_8_0:profile()
	l_8_0._set_cleared_checkpoint_data(l_8_1)
	l_8_1.has_progress = false
	l_8_0._primary_user:save_profile()
end

SaveManager.set_level_data_to_profiles = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4)
	local l_9_10, l_9_11, l_9_12, l_9_13, l_9_14, l_9_15 = nil
	local l_9_5 = l_9_0:profile()
	assert(l_9_5)
	local l_9_6 = managers.local_user:users()
	for i_0,i_1 in pairs(l_9_6) do
		if i_1:is_playing_the_game() then
			i_1:profile().save_progress = l_9_4
		end
	end
	if l_9_1 then
		l_9_3 = nil
		l_9_5.current_level_id = l_9_1
	else
		assert(l_9_3)
	if managers.world_info:info_from_name(l_9_3) then
		end
		l_9_5.current_level_id = managers.world_info:info_from_name(l_9_3).id
		l_9_3 = nil
	end
	if l_9_5.current_level_id then
		cat_print("debug", "Did set level " .. l_9_5.current_level_id .. " to primary profile")
	elseif l_9_3 then
		cat_print("debug", "Did set *debug* levelname '" .. l_9_3 .. "'")
	else
		assert(false, "No levelID or debuglevelname set to profile!")
	end
	l_9_5.debug_level_name = l_9_3
	l_9_5.current_checkpoint_id = l_9_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SaveManager.set_mission_objective_id_to_profile = function(l_10_0, l_10_1, l_10_2, l_10_3)
	local l_10_4 = l_10_1.levels[l_10_2]
	local l_10_5 = l_10_4.checkpoints[l_10_3]
	local l_10_6 = managers.assigned_mission_objective:assigned_objectives()
	local l_10_7 = next(l_10_6)
	if l_10_7 then
		l_10_5.active_mission_objective = l_10_7
	end
end

SaveManager._activate_mission_objective = function(l_11_0, l_11_1)
	local l_11_2 = managers.mission_objective:objective(l_11_1)
	managers.assigned_mission_objective:start_objective(l_11_2, nil)
end

SaveManager.check_for_mission_objective = function(l_12_0)
	local l_12_1 = l_12_0:profile()
	local l_12_2 = l_12_1.levels[l_12_1.current_level_id]
	local l_12_3 = l_12_2.checkpoints[l_12_1.current_checkpoint_id]
	local l_12_4 = l_12_3.active_mission_objective
	if l_12_4 then
		l_12_0:_activate_mission_objective(l_12_4)
	end
end

SaveManager._debug_check_profile_integrity = function(l_13_0)
	local l_13_6, l_13_7, l_13_8, l_13_9 = nil
	if l_13_0._debug_check_profile and l_13_0:primary_profile_is_ready() then
		local l_13_1 = l_13_0:profile()
		local l_13_2 = l_13_1.levels
		for i_0,i_1 in pairs(l_13_2) do
			for l_13_13 = 1, i_1.maximum_checkpoint_id do
				 -- DECOMPILER ERROR: Confused about usage of registers!

				for l_13_19 = 1, 4 do
					local l_13_16, l_13_17 = , l_13_11.checkpoints[R11_PC19].inventory
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					assert(not l_13_17.items[R17_PC26].name or l_13_17.items[R17_PC26].name ~= "", " bad format on level " .. l_13_10 .. " cp " .. l_13_15 .. " item " .. l_13_21)
				end
			end
		end
	end
end

SaveManager.select_primary_user = function(l_14_0, l_14_1)
	cat_print("debug", "SaveManager:select_primary_user")
	assert(l_14_1)
	if l_14_1 == l_14_0._primary_user then
		return 
	end
	l_14_1:set_wanted_player_slot_id(1)
	l_14_0._primary_user = l_14_1
	l_14_1:prime_profile()
end

SaveManager._set_cleared_checkpoint_data = function(l_15_0)
	local l_15_1 = 32
	local l_15_2 = 16
	local l_15_3 = 4
	for l_15_7 = 1, l_15_1 do
		l_15_0.levels[l_15_7] = {}
		local l_15_8 = l_15_0.levels[l_15_7]
		l_15_8.maximum_checkpoint_id = 0
		print(l_15_8.maximum_checkpoint_id)
		l_15_8.checkpoints = {}
		for l_15_12 = 1, l_15_2 do
			l_15_8.checkpoints[l_15_12] = {}
			local l_15_13 = l_15_8.checkpoints[l_15_12]
			l_15_13.difficulty_levels = {}
			l_15_13.inventory = {}
			l_15_13.inventory.current_item = 0
			l_15_13.inventory.items = {}
			for l_15_17 = 1, l_15_3 do
				l_15_13.inventory.items[l_15_17] = {}
				local l_15_18 = l_15_13.inventory.items[l_15_17]
				l_15_18.name = ""
				l_15_18.ammo = 0
			end
		end
	end
	l_15_0.current_level_id = managers.world_info:first_world_info().id
	l_15_0.current_checkpoint_id = 1
	l_15_0.progress_level_id = managers.world_info:first_world_info().id
	l_15_0.progress_checkpoint_id = 1
end

SaveManager._set_cleared_progress = function(l_16_0)
	l_16_0.levels = {}
	SaveManager._set_cleared_checkpoint_data(l_16_0)
	local l_16_1 = managers.world_info:first_world_info().id
	l_16_0.levels[l_16_1].maximum_checkpoint_id = 1
	l_16_0.debug_level_name = ""
	l_16_0.has_progress = false
	SaveManager._set_profile_version(l_16_0)
	SaveManager._reset_stats(l_16_0)
end

SaveManager._set_profile_version = function(l_17_0)
	l_17_0.version = 10
end

SaveManager.new_profile = function(l_18_0, l_18_1)
	assert(l_18_1)
	SaveManager._set_cleared_progress(l_18_0)
	l_18_0.sound_settings = SaveManager._default_sound_settings()
	l_18_0.brightness = SaveManager._default_brightness()
	l_18_0.control_settings = SaveManager._default_control_settings(l_18_1)
	l_18_0.subtitles_enabled = SaveManager._default_subtitle_settings()
	l_18_0.video_settings = SaveManager._default_video_settings()
	l_18_0.newly_created = true
	l_18_0.has_progress = false
end

SaveManager._reset_stats = function(l_19_0)
	l_19_0.stats = {}
	l_19_0.stats.player_reload_count = 0
end

SaveManager.profile_loaded = function(l_20_0, l_20_1)
	local l_20_5, l_20_6, l_20_7, l_20_8, l_20_12, l_20_13 = nil
	if not l_20_1.sound_settings then
		l_20_1.sound_settings = l_20_0:_default_sound_settings()
	end
	if not l_20_1.control_settings then
		l_20_1.control_settings = l_20_0:_default_control_settings({})
	end
	if not l_20_1.stats then
		l_20_1.stats = {}
	end
	if l_20_1.version < 5 then
		SaveManager._reset_stats(l_20_1)
	end
	if l_20_1.version < 5 then
		SaveManager:_change_checkpoint_variable_name(l_20_1)
	end
	if l_20_1.version < 6 then
		l_20_1.has_progress = true
	end
	if l_20_1.version < 7 then
		for i_0,i_1 in pairs(l_20_1.levels) do
			for i_0,i_1 in pairs(i_1.checkpoints) do
				i_1.difficulty_levels = {}
			end
		end
	end
	if l_20_1.version < 8 then
		l_20_0.progress_level_id = l_20_0.current_level_id
		l_20_0.progress_checkpoint_id = l_20_0.current_checkpoint_id
	end
	if l_20_1.version < 9 then
		l_20_1.video_settings = l_20_0._default_video_settings()
	end
	if l_20_1.version < 10 then
		l_20_1.custom_controls_keyboard = nil
		l_20_1.custom_controls_gamepad = nil
		l_20_1.custom_controls_xbox_pad = nil
	end
	l_20_0._set_profile_version(l_20_1)
end

SaveManager._change_checkpoint_variable_name = function(l_21_0, l_21_1)
	local l_21_5, l_21_6, l_21_7, l_21_8 = nil
	for i_0,i_1 in pairs(l_21_1.levels) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if i_1.current_checkpoint_id then
			i_1.maximum_checkpoint_id = i_1.current_checkpoint_id
			i_1.current_checkpoint_id = nil
		elseif i_1.maximum_checkpoint_id == nil then
			i_1.maximum_checkpoint_id = 0
		end
	end
end

SaveManager._default_sound_settings = function()
	local l_22_0 = {}
	l_22_0.music_volume = 1
	l_22_0.sfx_volume = 1
	l_22_0.dialogue_volume = 1
	return l_22_0
end

SaveManager._default_brightness = function()
	return 1
end

SaveManager._default_control_settings = function(l_24_0)
	local l_24_1 = {}
	l_24_1.invert_y = l_24_0.invert_y_axis or false
	l_24_1.rumble = true
	l_24_1.sensitivity = 1
	return l_24_1
end

SaveManager._default_subtitle_settings = function()
	return true
end

SaveManager._default_video_settings = function()
	local l_26_0 = {}
	l_26_0.auto_aspect_ratio = true
	return l_26_0
end

SaveManager.primary_user = function(l_27_0)
	return l_27_0._primary_user
end

SaveManager.has_primary_user = function(l_28_0)
	return l_28_0._primary_user ~= nil
end

SaveManager.release_primary_user = function(l_29_0)
	cat_print("debug", "SaveManager:release_primary_user")
	l_29_0._primary_user = nil
end

SaveManager.profile = function(l_30_0)
	local l_30_1, l_30_2 = l_30_0._primary_user:profile, l_30_0._primary_user
	return l_30_1(l_30_2)
end

SaveManager.primary_profile_is_ready = function(l_31_0)
	if l_31_0._primary_user then
		return l_31_0._primary_user:is_profile_ready()
	end
end

SaveManager.is_busy = function(l_32_0)
	if not l_32_0:is_busy_saving() then
		return l_32_0:is_busy_loading()
	end
end

SaveManager.is_busy_saving = function(l_33_0)
	local l_33_5, l_33_6, l_33_7, l_33_8, l_33_9, l_33_10 = nil
	local l_33_1 = managers.local_user:users()
	for i_0,i_1 in pairs(l_33_1) do
		if i_1 and i_1._storage and i_1._storage:is_saving() then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SaveManager.is_busy_loading = function(l_34_0)
	local l_34_5, l_34_6, l_34_7, l_34_8, l_34_9, l_34_10 = nil
	local l_34_1 = managers.local_user:users()
	for i_0,i_1 in pairs(l_34_1) do
		if i_1 and i_1._storage and i_1._storage:is_loading() then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SaveManager.load_controller_settings = function(l_35_0, l_35_1, l_35_2)
	local l_35_11, l_35_13, l_35_15, l_35_20, l_35_21, l_35_22 = nil
	local l_35_3 = l_35_1:controller_wrapper()
	local l_35_4 = l_35_3:get_default_controller_id()
	if l_35_2 or not l_35_0:_parse_controllers_xml(l_35_1, true) then
		local l_35_10, l_35_12, l_35_14 = , l_35_0:_parse_controllers_xml, l_35_0
		l_35_12 = l_35_12(l_35_14, l_35_1, false)
		l_35_10 = l_35_12
		local l_35_5, l_35_6 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	for i_0,i_1 in pairs(l_35_10) do
		local l_35_7 = nil
		if i_1.connection_type == "button" then
			l_35_3:get_connection_settings(i_1.name):set_input_name_list(i_1.buttons)
			if i_1.controller and i_1.controller ~= "" then
				l_35_3:get_connection_settings(i_1.name):set_controller_id(i_1.controller)
			end
		elseif i_1.connection_type == "axis" and i_1.name == "move" then
			for i_0,i_1 in pairs(l_35_3:get_connection_settings(i_1.name)._btn_connections) do
				local l_35_19 = nil
				i_1.name = l_35_3:get_connection_settings(i_0)._input_name_list[1]
			end
		end
	end
	l_35_3:rebind_connections(deep_clone(l_35_3:get_setup()))
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SaveManager._parse_controllers_xml = function(l_36_0, l_36_1, l_36_2, l_36_3)
	local l_36_4 = l_36_1:controller_wrapper()
	local l_36_5 = l_36_4:get_type()
	local l_36_6 = {}
	local l_36_7 = nil
	if l_36_2 == true then
		local l_36_8 = (l_36_0:profile())
		local l_36_9 = nil
		if l_36_5 == "pc" and l_36_1 == l_36_0:primary_user() then
			l_36_9 = l_36_8.custom_controls_keyboard
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_36_5 == "xbox360" and l_36_1 == l_36_0:primary_user() then
			l_36_9 = l_36_8.custom_controls_xbox_pad
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_36_5 == "pc" and not l_36_1 == l_36_0:primary_user() then
			l_36_9 = l_36_8.custom_controls_keyboard_two
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_36_5 == "xbox360" and not l_36_1 == l_36_0:primary_user() then
			l_36_9 = l_36_8.custom_controls_xbox_pad_two
		end
		if l_36_9 then
			l_36_7 = Node.from_xml(l_36_9)
		end
	elseif l_36_2 == false then
		local l_36_15 = "settings/default_controls.xml"
	if File:config_exists(l_36_15) then
		end
		l_36_7 = File:parse_xml(l_36_15)
	end
	if l_36_7 then
		l_36_6 = Menu2DPageControllerUtil.parse_controllers_xml(l_36_7, l_36_5)
	else
		return nil
	end
	return l_36_6
end

SaveManager.save_controller_settings = function(l_37_0, l_37_1)
	local l_37_2 = l_37_1:controller_wrapper()
	local l_37_3 = (l_37_2:get_type())
	local l_37_4 = nil
	if l_37_3 == "pc" then
		l_37_4 = "pc"
	elseif l_37_3 == "xbox360" then
		l_37_4 = "xbox360"
	end
	local l_37_5 = "custom_controls_" .. l_37_3
	local l_37_6 = string.format("<controller_settings>")
	l_37_6 = l_37_6 .. "\t<" .. tostring(l_37_4) .. ">"
	l_37_6 = l_37_2:get_setup():print_output_to_string(l_37_6, 2)
	l_37_6 = l_37_6 .. "\t</" .. tostring(l_37_4) .. ">"
	l_37_6 = l_37_6 .. "</controller_settings>"
	local l_37_7 = l_37_0:profile()
	if l_37_3 == "pc" and l_37_1 == l_37_0:primary_user() then
		l_37_7.custom_controls_keyboard = l_37_6
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_37_3 == "xbox360" and l_37_1 == l_37_0:primary_user() then
		l_37_7.custom_controls_xbox_pad = l_37_6
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_37_3 == "pc" and not l_37_1 == l_37_0:primary_user() then
		l_37_7.custom_controls_keyboard_two = l_37_6
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_37_3 == "xbox360" and not l_37_1 == l_37_0:primary_user() then
		l_37_7.custom_controls_xbox_pad_two = l_37_6
	end
	l_37_0._primary_user:save_profile()
end


