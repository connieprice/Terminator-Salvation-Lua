Menu2DEvents = Menu2DEvents or class()
function Menu2DEvents.init(A0_0)
	local L1_1
end
function Menu2DEvents.raise(A0_2, A1_3, A2_4)
	if A0_2[A1_3] and type(A0_2[A1_3]) == "function" then
		A0_2[A1_3](A0_2, A2_4)
	end
end
function Menu2DEvents.replay_set_start_level(A0_5, A1_6)
	managers.menu2d:menu_island_instance_data().start_level_id = tonumber(A1_6.level_id)
	managers.menu2d:menu_island_instance_data().start_level_name = A1_6.level_name
	managers.menu2d:menu_island_instance_data().start_level_checkpoint = tonumber(A1_6.checkpoint_id)
	managers.menu2d:menu_island_instance_data().save_progress = false
end
function Menu2DEvents.set_start_checkpoint(A0_7, A1_8)
	managers.menu2d:menu_island_instance_data().start_level_checkpoint = tonumber(A1_8.checkpoint_id)
end
function Menu2DEvents.unlock_achievements(A0_9)
	local L1_10, L2_11, L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18, L10_19, L11_20
	if L1_10 == "PS3" then
		L1_10(L2_11)
		for L4_13 = 1, L2_11(L3_12) do
			L6_15 = L5_14
			L5_14(L6_15, L7_16, L8_17)
		end
	elseif L1_10 == "X360" then
		L1_10(L2_11)
		if L2_11 then
			for L6_15 in L3_12(L4_13) do
				if L7_16 == "achievements" then
					for L10_19 in L7_16(L8_17) do
						L11_20 = managers
						L11_20 = L11_20.save
						L11_20 = L11_20.primary_user
						L11_20 = L11_20(L11_20)
						L11_20 = L11_20.user_index
						L11_20 = L11_20(L11_20)
						XboxLive:award_achievement(L11_20, L10_19:parameter("name"))
					end
				end
			end
		end
	else
		L1_10(L2_11)
	end
end
function Menu2DEvents.continue_set_start_level(A0_21, A1_22)
	managers.menu2d:menu_island_instance_data().start_level_id = tonumber(A0_21:_profile().progress_level_id)
	managers.menu2d:menu_island_instance_data().start_level_checkpoint = tonumber(A0_21:_profile().progress_checkpoint_id)
	managers.menu2d:menu_island_instance_data().save_progress = true
end
function Menu2DEvents.start_game(A0_23, A1_24)
	local L2_25, L3_26, L4_27, L5_28, L6_29, L7_30, L8_31
	L2_25 = managers
	L2_25 = L2_25.menu_input
	L3_26 = L2_25
	L2_25 = L2_25.bound_user
	L2_25 = L2_25(L3_26)
	L3_26 = assert
	L4_27 = L2_25
	L3_26(L4_27)
	L3_26 = managers
	L3_26 = L3_26.menu2d
	L4_27 = L3_26
	L3_26 = L3_26.menu_island_instance_data
	L3_26 = L3_26(L4_27)
	L4_27 = L3_26.start_level_id
	L5_28 = L3_26.start_level_name
	if not L5_28 then
		L5_28 = managers
		L5_28 = L5_28.world_info
		L6_29 = L5_28
		L5_28 = L5_28.info_from_id
		L7_30 = L4_27
		L5_28 = L5_28(L6_29, L7_30)
		L5_28 = L5_28.name
	end
	L6_29 = L3_26.start_level_checkpoint
	L6_29 = L6_29 or 1
	L7_30 = L3_26.save_progress
	L8_31 = managers
	L8_31 = L8_31.save
	L8_31 = L8_31.set_level_data_to_profiles
	L8_31(L8_31, L4_27, L6_29, L5_28, L7_30)
	L8_31 = nil
	if A1_24.mode == "coop" then
		L8_31 = 2
	else
		L8_31 = 1
	end
	managers.game_transition:set_wants_to_host(L8_31)
end
function Menu2DEvents.restart_at_last_checkpoint(A0_32, A1_33)
	managers.game_transition:exec_game_from_game()
end
function Menu2DEvents.quit_to_main(A0_34)
	managers.menu2d:remove_dialog()
	managers.game_transition:exec_menu()
end
function Menu2DEvents.quit_to_desktop(A0_35)
	Application:quit()
end
function Menu2DEvents.set_difficulty_level(A0_36, A1_37)
	(A0_36:_profile() or managers.save:profile()).difficulty_level = tonumber(A1_37.difficulty)
end
function Menu2DEvents.set_new_resolution(A0_38, A1_39, A2_40)
	managers.menu2d:set_aspect(A2_40)
	managers.menu2d:set_resolution(A1_39.x, A1_39.y, A1_39.z)
	managers.menu2d:callback_resolution_changed()
	managers.menu:ingame_gui():callback_resolution_changed()
end
function Menu2DEvents.apply_video_settings(A0_41)
	local L1_42, L2_43, L3_44, L4_45
	L1_42 = managers
	L1_42 = L1_42.menu2d
	L1_42 = L1_42._components
	L1_42 = L1_42.page_flipper
	L2_43 = L1_42
	L1_42 = L1_42.current_page
	L1_42 = L1_42(L2_43)
	L2_43 = L1_42
	L1_42 = L1_42.set_island_data
	L1_42(L2_43)
	L1_42 = managers
	L1_42 = L1_42.menu2d
	L2_43 = L1_42
	L1_42 = L1_42.menu_island_instance_data
	L1_42 = L1_42(L2_43)
	L2_43 = L1_42.video_mode
	L3_44 = L1_42.auto_aspect_ratio
	L4_45 = nil
	if L3_44 then
		L4_45 = L2_43.x / L2_43.y
	else
		L4_45 = L1_42.aspect_ratio
	end
	A0_41:try_new_resolution(L2_43, L4_45)
end
function Menu2DEvents.try_new_resolution(A0_46, A1_47, A2_48)
	managers.menu2d:menu_island_instance_data().last_resolution = RenderSettings.resolution
	managers.menu2d:menu_island_instance_data().last_aspect_ratio = core_setup.aspect_ratio
	if managers.menu2d:menu_island_instance_data().last_resolution ~= A1_47 or managers.menu2d:menu_island_instance_data().last_aspect_ratio ~= A2_48 then
		managers.menu2d:change_page("confirm_new_video_settings")
		A0_46:set_new_resolution(A1_47, A2_48)
	end
end
function Menu2DEvents.restore_resolution(A0_49)
	A0_49:set_new_resolution(managers.menu2d:menu_island_instance_data().last_resolution, managers.menu2d:menu_island_instance_data().last_aspect_ratio)
	managers.menu2d:back()
end
function Menu2DEvents.confirm_resolution(A0_50)
	managers.save:primary_user():profile().video_settings.auto_aspect_ratio = managers.menu2d:menu_island_instance_data().auto_aspect_ratio
	managers.save:primary_user():save_profile()
	managers.menu2d:back()
	managers.menu2d:back()
end
function Menu2DEvents._profile(A0_51)
	return managers.menu_input:bound_user() and managers.menu_input:bound_user():is_profile_ready() and managers.menu_input:bound_user():profile()
end
function Menu2DEvents.sound_volume(A0_52, A1_53)
	if A0_52:_profile().sound_settings[A1_53.sound_category .. "_volume"] ~= nil then
		return A0_52:_profile().sound_settings[A1_53.sound_category .. "_volume"]
	elseif managers.save:_default_sound_settings()[A1_53.sound_category .. "_volume"] ~= nil then
		return managers.save:_default_sound_settings()[A1_53.sound_category .. "_volume"]
	else
		return 1
	end
end
function Menu2DEvents.set_sound_volume(A0_54, A1_55, A2_56)
	A0_54:_profile().sound_settings[A2_56.sound_category .. "_volume"] = A1_55
end
function Menu2DEvents.brightness(A0_57)
	if A0_57:_profile().brightness ~= nil then
		return A0_57:_profile().brightness
	else
		return managers.save:_default_sound_settings()
	end
end
function Menu2DEvents.set_brightness(A0_58, A1_59)
	A0_58:_profile().brightness = A1_59
end
function Menu2DEvents.invert_camera(A0_60, A1_61, A2_62)
	if A0_60:_profile().control_settings.invert_y ~= nil then
		return A0_60:_profile().control_settings.invert_y
	else
		return managers.save:_default_control_settings().invert_y
	end
end
function Menu2DEvents.set_invert_camera(A0_63, A1_64, A2_65)
	A0_63:_profile().control_settings.invert_y = A1_64
end
function Menu2DEvents.sensitivity(A0_66)
	if A0_66:_profile().control_settings.sensitivity ~= nil then
		return A0_66:_profile().control_settings.sensitivity
	else
		return managers.save:_default_control_settings().sensitivity
	end
end
function Menu2DEvents.set_sensitivity(A0_67, A1_68)
	A0_67:_profile().control_settings.sensitivity = A1_68
end
function Menu2DEvents.subtitles_enabled(A0_69)
	assert(A0_69:_profile().subtitles_enabled ~= nil)
	return A0_69:_profile().subtitles_enabled
end
function Menu2DEvents.set_subtitles_enabled(A0_70, A1_71)
	A0_70:_profile().subtitles_enabled = A1_71
end
function Menu2DEvents.debug_god_mode(A0_72)
	local L1_73
	L1_73 = A0_72._debug
	L1_73 = L1_73 or {}
	A0_72._debug = L1_73
	L1_73 = A0_72._debug
	L1_73 = L1_73.god_mode
	return L1_73
end
function Menu2DEvents.debug_set_god_mode(A0_74, A1_75)
	A0_74._debug = A0_74._debug or {}
	if not A1_75 ~= not A0_74._debug.god_mode then
		debug_commands:set_god_mode(A1_75)
		A0_74._debug.god_mode = A1_75
	end
end
function Menu2DEvents.debug_hide_hud(A0_76)
	local L1_77
	L1_77 = A0_76._debug
	L1_77 = L1_77 or {}
	A0_76._debug = L1_77
	L1_77 = A0_76._debug
	L1_77 = L1_77.hide_hud
	return L1_77
end
function Menu2DEvents.debug_set_hide_hud(A0_78, A1_79)
	A0_78._debug = A0_78._debug or {}
	if not A1_79 ~= not A0_78._debug.hide_hud then
		debug_commands:show_huds(not A1_79)
		A0_78._debug.hide_hud = A1_79
	end
end
function Menu2DEvents.debug_control_unit(A0_80)
	local L1_81
	L1_81 = A0_80._debug
	L1_81 = L1_81 or {}
	A0_80._debug = L1_81
	L1_81 = A0_80._debug
	L1_81 = L1_81.control_unit
	return L1_81
end
function Menu2DEvents.debug_set_control_unit(A0_82, A1_83)
	A0_82._debug = A0_82._debug or {}
	if not A1_83 ~= not A0_82._debug.control_unit then
		debug_commands:control_unit(A1_83)
		A0_82._debug.control_unit = A1_83
	end
end
function Menu2DEvents.debug_free_flight_camera(A0_84)
	local L1_85
	L1_85 = A0_84._debug
	L1_85 = L1_85 or {}
	A0_84._debug = L1_85
	L1_85 = A0_84._debug
	L1_85 = L1_85.free_flight_camera
	return L1_85
end
function Menu2DEvents.debug_set_free_flight_camera(A0_86, A1_87)
	A0_86._debug = A0_86._debug or {}
	if not A1_87 ~= not A0_86._debug.free_flight_camera then
		if A1_87 then
			assert(not script_debug._freeflight)
			script_debug._freeflight = FreeFlight:new()
			script_debug._freeflight:on_get_focus()
		else
			assert(script_debug._freeflight)
			script_debug._freeflight:on_loose_focus()
			script_debug._freeflight = nil
		end
		A0_86._debug.free_flight_camera = A1_87
	end
end
function Menu2DEvents.debug_infinite_ammo(A0_88)
	return debug_commands:infinite_ammo()
end
function Menu2DEvents.debug_set_infinite_ammo(A0_89, A1_90)
	if not A1_90 ~= not A0_89:debug_infinite_ammo() then
		debug_commands:set_infinite_ammo(A1_90)
	end
end
function Menu2DEvents.goto_pad_mapping(A0_91)
	local L1_92
	L1_92 = "pad_mapping_pc"
	return L1_92
end
function Menu2DEvents.coop(A0_93)
	if managers.player_slot:number_of_occupied_slots() > 1 then
		return true
	end
end
function Menu2DEvents.coop_pad_mapping(A0_94)
	if managers.game:is_in_game() then
		return false
	elseif managers.player_slot:number_of_occupied_slots() > 1 and managers.player_slot:slot(2):user():controller_wrapper():get_default_controller_id() == "keyboard" then
		return true
	end
end
function Menu2DEvents.continue(A0_95)
	if not A0_95:_profile() then
		return false
	end
	for 