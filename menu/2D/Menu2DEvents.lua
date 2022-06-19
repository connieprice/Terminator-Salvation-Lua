if not Menu2DEvents then
	Menu2DEvents = class()
end
Menu2DEvents.init = function(l_1_0)
end

Menu2DEvents.raise = function(l_2_0, l_2_1, l_2_2)
	if l_2_0[l_2_1] and type(l_2_0[l_2_1]) == "function" then
		l_2_0[l_2_1](l_2_0, l_2_2)
	end
end

Menu2DEvents.replay_set_start_level = function(l_3_0, l_3_1)
	local l_3_2 = managers.menu2d:menu_island_instance_data()
	l_3_2.start_level_id = tonumber(l_3_1.level_id)
	l_3_2.start_level_name = l_3_1.level_name
	l_3_2.start_level_checkpoint = tonumber(l_3_1.checkpoint_id)
	l_3_2.save_progress = false
end

Menu2DEvents.set_start_checkpoint = function(l_4_0, l_4_1)
	managers.menu2d:menu_island_instance_data().start_level_checkpoint = tonumber(l_4_1.checkpoint_id)
end

Menu2DEvents.unlock_achievements = function(l_5_0)
	local l_5_16 = nil
	if SystemInfo:platform() == "PS3" then
		print("Unlock Trophies!")
		for l_5_4 = 1, Trophies:get_count() do
			local l_5_10, l_5_11, l_5_12 = Trophies:unlock_id, Trophies
			l_5_12 = l_5_4
			l_5_10(l_5_11, l_5_12, function(l_6_0)
				print("Trophy: " .. tostring(l_6_0))
      end)
		end
	else
		if SystemInfo:platform() == "X360" then
			print("Unlock achievements!")
			local l_5_5 = Database:lookup("xbox_live", "xbox_live")
			local l_5_6 = Database:load_node(l_5_5)
		if l_5_6 then
			end
			for i_0 in l_5_6:children() do
				if i_0:name() == "achievements" then
					for i_0 in i_0:children() do
						XboxLive:award_achievement(managers.save:primary_user():user_index(), i_0:parameter("name"))
					end
				end
			end
		end
	else
		print("Unlock")
	end
end

Menu2DEvents.continue_set_start_level = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0:_profile()
	local l_6_3 = managers.menu2d:menu_island_instance_data()
	l_6_3.start_level_id = tonumber(l_6_2.progress_level_id)
	l_6_3.start_level_checkpoint = tonumber(l_6_2.progress_checkpoint_id)
	l_6_3.save_progress = true
end

Menu2DEvents.start_game = function(l_7_0, l_7_1)
	local l_7_2 = managers.menu_input:bound_user()
	assert(l_7_2)
	local l_7_3 = managers.menu2d:menu_island_instance_data()
	local l_7_4 = l_7_3.start_level_id
	if not l_7_3.start_level_name then
		local l_7_5, l_7_7, l_7_8 = managers.world_info:info_from_id(l_7_4).name
	end
	do
		local l_7_6, l_7_9 = , l_7_3.start_level_checkpoint or 1
	end
	local l_7_10 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	managers.save:set_level_data_to_profiles(l_7_4, l_7_9, l_7_10, l_7_3.save_progress)
	local l_7_11 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_7_1.mode == "coop" then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	managers.game_transition:set_wants_to_host(nil)
end

Menu2DEvents.restart_at_last_checkpoint = function(l_8_0, l_8_1)
	managers.game_transition:exec_game_from_game()
end

Menu2DEvents.quit_to_main = function(l_9_0)
	managers.menu2d:remove_dialog()
	managers.game_transition:exec_menu()
end

Menu2DEvents.quit_to_desktop = function(l_10_0)
	Application:quit()
end

Menu2DEvents.set_difficulty_level = function(l_11_0, l_11_1)
	if not l_11_0:_profile() then
		managers.save:profile().difficulty_level = tonumber(l_11_1.difficulty)
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 9 
end

Menu2DEvents.set_new_resolution = function(l_12_0, l_12_1, l_12_2)
	managers.menu2d:set_aspect(l_12_2)
	managers.menu2d:set_resolution(l_12_1.x, l_12_1.y, l_12_1.z)
	managers.menu2d:callback_resolution_changed()
	managers.menu:ingame_gui():callback_resolution_changed()
end

Menu2DEvents.apply_video_settings = function(l_13_0)
	managers.menu2d._components.page_flipper:current_page():set_island_data()
	local l_13_1 = managers.menu2d:menu_island_instance_data()
	local l_13_2 = l_13_1.video_mode
	local l_13_3 = l_13_1.auto_aspect_ratio
	local l_13_4 = nil
	local l_13_5 = managers.save:profile()
	if l_13_3 then
		l_13_4 = l_13_2.x / l_13_2.y
	else
		l_13_4 = l_13_1.aspect_ratio
	end
	l_13_0:try_new_resolution(l_13_2, l_13_4)
end

Menu2DEvents.try_new_resolution = function(l_14_0, l_14_1, l_14_2)
	local l_14_3 = managers.menu2d:menu_island_instance_data()
	l_14_3.last_resolution = RenderSettings.resolution
	l_14_3.last_aspect_ratio = core_setup.aspect_ratio
	if l_14_3.last_resolution ~= l_14_1 or l_14_3.last_aspect_ratio ~= l_14_2 then
		managers.menu2d:change_page("confirm_new_video_settings")
		l_14_0:set_new_resolution(l_14_1, l_14_2)
	end
end

Menu2DEvents.restore_resolution = function(l_15_0)
	local l_15_1 = managers.menu2d:menu_island_instance_data()
	l_15_0:set_new_resolution(l_15_1.last_resolution, l_15_1.last_aspect_ratio)
	managers.menu2d:back()
end

Menu2DEvents.confirm_resolution = function(l_16_0)
	local l_16_1 = managers.menu2d:menu_island_instance_data()
	managers.save:primary_user():profile().video_settings.auto_aspect_ratio = l_16_1.auto_aspect_ratio
	managers.save:primary_user():save_profile()
	managers.menu2d:back()
	managers.menu2d:back()
end

Menu2DEvents._profile = function(l_17_0)
	local l_17_1 = managers.menu_input:bound_user()
	do
		if l_17_1 and l_17_1:is_profile_ready() then
			return l_17_1:profile()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DEvents.sound_volume = function(l_18_0, l_18_1)
	if l_18_0:_profile().sound_settings[l_18_1.sound_category .. "_volume"] ~= nil then
		return l_18_0:_profile().sound_settings[l_18_1.sound_category .. "_volume"]
	else
		if managers.save:_default_sound_settings()[l_18_1.sound_category .. "_volume"] ~= nil then
			return managers.save:_default_sound_settings()[l_18_1.sound_category .. "_volume"]
		end
	else
		return 1
	end
end

Menu2DEvents.set_sound_volume = function(l_19_0, l_19_1, l_19_2)
	local l_19_3 = l_19_0:_profile()
	l_19_3.sound_settings[l_19_2.sound_category .. "_volume"] = l_19_1
end

Menu2DEvents.brightness = function(l_20_0)
	local l_20_1 = l_20_0:_profile()
	if l_20_1.brightness ~= nil then
		return l_20_1.brightness
	else
		local l_20_2, l_20_3 = managers.save:_default_sound_settings, managers.save
		return l_20_2(l_20_3)
	end
end

Menu2DEvents.set_brightness = function(l_21_0, l_21_1)
	l_21_0:_profile().brightness = l_21_1
end

Menu2DEvents.invert_camera = function(l_22_0, l_22_1, l_22_2)
	local l_22_3 = l_22_0:_profile()
	if l_22_3.control_settings.invert_y ~= nil then
		return l_22_3.control_settings.invert_y
	else
		return managers.save:_default_control_settings().invert_y
	end
end

Menu2DEvents.set_invert_camera = function(l_23_0, l_23_1, l_23_2)
	local l_23_3 = l_23_0:_profile()
	l_23_3.control_settings.invert_y = l_23_1
end

Menu2DEvents.sensitivity = function(l_24_0)
	local l_24_1 = l_24_0:_profile()
	if l_24_1.control_settings.sensitivity ~= nil then
		return l_24_1.control_settings.sensitivity
	else
		return managers.save:_default_control_settings().sensitivity
	end
end

Menu2DEvents.set_sensitivity = function(l_25_0, l_25_1)
	local l_25_2 = l_25_0:_profile()
	l_25_2.control_settings.sensitivity = l_25_1
end

Menu2DEvents.subtitles_enabled = function(l_26_0)
	local l_26_1 = l_26_0:_profile()
	local l_26_2 = assert
	l_26_2(l_26_1.subtitles_enabled ~= nil)
	l_26_2 = l_26_1.subtitles_enabled
	return l_26_2
end

Menu2DEvents.set_subtitles_enabled = function(l_27_0, l_27_1)
	l_27_0:_profile().subtitles_enabled = l_27_1
end

Menu2DEvents.debug_god_mode = function(l_28_0)
	if not l_28_0._debug then
		l_28_0._debug = {}
	end
	return l_28_0._debug.god_mode
end

Menu2DEvents.debug_set_god_mode = function(l_29_0, l_29_1)
	if not l_29_0._debug then
		l_29_0._debug = {}
	end
	if not l_29_1 ~= not l_29_0._debug.god_mode then
		debug_commands:set_god_mode(l_29_1)
		l_29_0._debug.god_mode = l_29_1
	end
end

Menu2DEvents.debug_hide_hud = function(l_30_0)
	if not l_30_0._debug then
		l_30_0._debug = {}
	end
	return l_30_0._debug.hide_hud
end

Menu2DEvents.debug_set_hide_hud = function(l_31_0, l_31_1)
	if not l_31_0._debug then
		l_31_0._debug = {}
	end
	if not l_31_1 ~= not l_31_0._debug.hide_hud then
		debug_commands:show_huds(not l_31_1)
		l_31_0._debug.hide_hud = l_31_1
	end
end

Menu2DEvents.debug_control_unit = function(l_32_0)
	if not l_32_0._debug then
		l_32_0._debug = {}
	end
	return l_32_0._debug.control_unit
end

Menu2DEvents.debug_set_control_unit = function(l_33_0, l_33_1)
	if not l_33_0._debug then
		l_33_0._debug = {}
	end
	if not l_33_1 ~= not l_33_0._debug.control_unit then
		debug_commands:control_unit(l_33_1)
		l_33_0._debug.control_unit = l_33_1
	end
end

Menu2DEvents.debug_free_flight_camera = function(l_34_0)
	if not l_34_0._debug then
		l_34_0._debug = {}
	end
	return l_34_0._debug.free_flight_camera
end

Menu2DEvents.debug_set_free_flight_camera = function(l_35_0, l_35_1)
	if not l_35_0._debug then
		l_35_0._debug = {}
	end
	if not l_35_1 ~= not l_35_0._debug.free_flight_camera then
		if l_35_1 then
			assert(not script_debug._freeflight)
			script_debug._freeflight = FreeFlight:new()
			script_debug._freeflight:on_get_focus()
		else
			assert(script_debug._freeflight)
			script_debug._freeflight:on_loose_focus()
			script_debug._freeflight = nil
		end
		l_35_0._debug.free_flight_camera = l_35_1
	end
end

Menu2DEvents.debug_infinite_ammo = function(l_36_0)
	local l_36_1, l_36_2 = debug_commands:infinite_ammo, debug_commands
	return l_36_1(l_36_2)
end

Menu2DEvents.debug_set_infinite_ammo = function(l_37_0, l_37_1)
	local l_37_2 = l_37_0:debug_infinite_ammo()
	if not l_37_1 ~= not l_37_2 then
		debug_commands:set_infinite_ammo(l_37_1)
	end
end

Menu2DEvents.goto_pad_mapping = function(l_38_0)
	return "pad_mapping_pc"
end

Menu2DEvents.coop = function(l_39_0)
	if managers.player_slot:number_of_occupied_slots() > 1 then
		return true
	end
end

Menu2DEvents.coop_pad_mapping = function(l_40_0)
	if managers.game:is_in_game() then
		return false
	else
		if managers.player_slot:number_of_occupied_slots() > 1 and managers.player_slot:slot(2):user():controller_wrapper():get_default_controller_id() == "keyboard" then
			return true
		end
	end
end

Menu2DEvents.continue = function(l_41_0)
	local l_41_5, l_41_6 = nil
	local l_41_1 = l_41_0:_profile()
	if not l_41_1 then
		return false
	end
	for i_0,i_1 in ipairs(l_41_1.levels) do
		if i_1.current_checkpoint_id > 0 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DEvents.continue_last_game = function(l_42_0)
	if not l_42_0:_profile() then
		return false
	end
	return not l_42_0:_is_new_game()
end

Menu2DEvents.select_storage_device = function(l_43_0)
	local l_43_1 = managers.menu_input:bound_user()
	l_43_1:select_storage_device()
end

Menu2DEvents._is_new_game = function(l_44_0)
	return not l_44_0:_profile().has_progress
end

Menu2DEvents.check_new_game = function(l_45_0)
	local l_45_1 = l_45_0:_is_new_game()
	if l_45_1 == true then
		managers.menu2d:start_new_game()
	elseif l_45_1 == false then
		managers.menu2d:set_dialog("confirm_overwrite_save_game")
	end
end

Menu2DEvents.user_save_enabled = function(l_46_0)
	local l_46_1 = managers.menu_input:bound_user()
	return not l_46_1:save_disabled()
end

Menu2DEvents.signed_in_user = function(l_47_0)
	local l_47_1 = managers.menu_input:bound_user()
	local l_47_2, l_47_3 = l_47_1:is_signed_in, l_47_1
	return l_47_2(l_47_3)
end

Menu2DEvents.is_debug_mode = function(l_48_0)
	local l_48_1, l_48_2 = managers.menu2d:_is_debug_mode, managers.menu2d
	return l_48_1(l_48_2)
end

Menu2DEvents.back = function(l_49_0)
	managers.menu2d:back()
end

Menu2DEvents.player_2_edit_controls_available = function(l_50_0)
	local l_50_1 = not managers.menu2d:state_flag("frontend")
	do
		return not l_50_1 or (managers.menu_input:bound_user() == managers.save:primary_user() and managers.player_slot:number_of_occupied_slots() > 1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


