require("menu/2D/LoadingScreenTest")
require("menu/2D/Menu2DIsland")
require("menu/2D/Menu2DEffects")
require("menu/2D/Menu2DSound")
require("menu/2D/Menu2DEvents")
require("menu/2D/Menu2DLegend")
require("menu/2D/Menu2DDistortion")
require("menu/2D/Menu2DTitleLogo")
require("menu/2D/Menu2DDebug")
require("menu/2D/Menu2DPageFlipper")
require("menu/2D/Menu2DPageSelector")
require("menu/2D/states/Menu2DMainStates")
require("menu/2D/states/Menu2DStateTransitionLookup")
require("menu/2D/Menu2DManagerGuiInterface")
require("menu/MenuUtility")
require("shared/CallbacksList")
require("shared/Stack")
require("menu/2D/Menu2DChoice")
require("menu/2D/Menu2DCameraNoise")
require("menu/2D/Menu2DDistortion")
require("menu/2D/Menu2DTitleLogo")
require("menu/2D/Menu2DPageFlipper")
require("menu/2D/Menu2DMouse")
if not Menu2DManager then
	Menu2DManager = class()
end
Menu2DManager._custom_controller_path = "settings/custom_controls.xml"
Menu2DManager._default_controller_path = "settings/default_controls.xml"
Menu2DManager.init = function(l_1_0)
	local l_1_1 = {}
	l_1_1.requested_state = "inactive"
	l_1_1.requested_dialog = nil
	l_1_0._state_transition_data = l_1_1
	l_1_0._sync_state, l_1_1 = l_1_1, {}
	l_1_0._settings, l_1_1 = l_1_1, {}
	l_1_0._components, l_1_1 = l_1_1, {sound = Menu2DSound:new(), effects = Menu2DEffects:new()}
	l_1_0._time_since_move = 0
	l_1_1 = Menu2DEvents
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._event_manager = l_1_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_1_1 then
		l_1_0._debug_manager = l_1_1
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_1(l_1_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_1.page_flipper = Menu2DPageFlipper:new(l_1_0._components, l_1_0._settings)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._page_selector = l_1_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_1(l_1_0, function(...)
		-- upvalues: l_1_0
		l_1_0._components.sound:on_page_change(...)
  end)
	l_1_0._state_flags, l_1_1 = l_1_1, {}
	l_1_1 = managers
	l_1_1 = l_1_1.viewport
	l_1_1(l_1_1, callback(l_1_0, l_1_0, "callback_resolution_changed"))
	local l_1_2 = {}
	l_1_2.menu, l_1_1 = l_1_1, {components = l_1_0._components, state_transition_data = l_1_0._state_transition_data, state_flags = l_1_0._state_flags, settings = l_1_0._settings, sync_state = l_1_0._sync_state}
	l_1_2.state_transitions = Menu2DStatesMainTransitions
	local l_1_3 = l_1_0._state_transition_data.requested_state
	local l_1_4 = Menu2DStateTransitionLookup:new(Menu2DStatesMainTransitions):state(l_1_3)
	l_1_0._menu_state_machine = FiniteStateMachine:new(l_1_2, "_state_data", l_1_4)
	l_1_0._menu_state_machine:set_debug(true)
	l_1_0:_parse_level_id_xml()
end

Menu2DManager._shutdown_resources = function(l_2_0)
	l_2_0._components.mouse:destroy()
	l_2_0._components.mouse = nil
	l_2_0._components.root_panel:clear()
	l_2_0._components.gui:destroy_workspace(l_2_0._components.workspace)
	Application:destroy_viewport(l_2_0._vp)
end

Menu2DManager._setup_resources = function(l_3_0)
	l_3_0:_create_menu_viewport()
	l_3_0:calc_safe_rect()
	l_3_0:preload()
	l_3_0._components.distortion = Menu2DDistortion:new()
	l_3_0._components.distortion:set_parent(l_3_0._components.root_panel)
	l_3_0._components.logo = Menu2DTitleLogo:new(l_3_0._components.root_panel, "title")
	l_3_0._components.mouse = Menu2DMouse:new(l_3_0._components.root_panel)
end

Menu2DManager.gui_interface = function(l_4_0)
	local l_4_1, l_4_2 = Menu2DManagerGuiInterface:new, Menu2DManagerGuiInterface
	local l_4_3 = l_4_0
	return l_4_1(l_4_2, l_4_3)
end

Menu2DManager.sound = function(l_5_0)
	return l_5_0._components.sound
end

Menu2DManager.page_change_completed = function(l_6_0)
	local l_6_1, l_6_2 = l_6_0._components.page_flipper:page_change_completed, l_6_0._components.page_flipper
	return l_6_1(l_6_2)
end

Menu2DManager.debug_loading_test = function(l_7_0)
	if l_7_0._loading_screen_test then
		l_7_0._loading_screen_test:stop()
	else
		l_7_0._loading_screen_test = LoadingScreenTest:new(l_7_0._components.workspace)
	end
end

Menu2DManager.post_init = function(l_8_0)
	l_8_0._components.page_flipper:post_init()
end

Menu2DManager._create_menu_viewport = function(l_9_0)
	local l_9_1 = RenderSettings.resolution
	l_9_0._vp = Application:create_scene_viewport(0, 0, 1, 1)
	l_9_0._width = 1280
	l_9_0._height = 720 * (1.7777778 / core_setup.aspect_ratio)
	l_9_0._components.gui = MenuOverlay:gui()
	l_9_0._components.workspace = l_9_0._components.gui:create_scaled_screen_workspace(l_9_0._width, l_9_0._height, 0, 0, l_9_1.x, l_9_1.y)
	l_9_0._components.workspace:set_timer(TimerManager:main())
	l_9_0._components.root_panel = l_9_0._components.workspace:panel()
end

Menu2DManager.preload = function(l_10_0)
	if l_10_0._preloaded then
		return 
	end
	World:preload_unit("empty")
	l_10_0._components.gui:preload_font("faith_font_22")
	l_10_0._components.gui:preload_font("credits")
	l_10_0._components.gui:preload_font("credits_merged")
	l_10_0._components.sound:preload()
	l_10_0._components.gui:preload_texture("gui_menu_salvation_logo_glow")
	l_10_0._components.gui:preload_texture("gui_menu_salvation_logo_big")
	l_10_0._components.gui:preload_texture("gui_menu_tickbox_on")
	l_10_0._components.gui:preload_texture("gui_menu_tickbox_off")
	l_10_0._components.gui:preload_texture("gui_menu_volumebar_line")
	l_10_0._components.gui:preload_texture("gui_menu_volumebar_gradient")
	l_10_0._components.gui:preload_texture("gui_hud_selection_dot")
	l_10_0._components.gui:preload_texture("gui_menu_bg_gradient")
	l_10_0._components.gui:preload_texture("gui_menu_360_controller")
	l_10_0._components.gui:preload_texture("security_camera_edgebleed")
	l_10_0._components.gui:preload_texture("security_camera_noise_1")
	l_10_0._components.gui:preload_texture("security_camera_noise_2")
	l_10_0._components.gui:preload_texture("security_camera_noise_3")
	l_10_0._components.gui:preload_texture("security_camera_noise_4")
	l_10_0._components.gui:preload_texture("gui_legalinfo_screen_global")
	l_10_0._components.gui:preload_texture("gui_legalinfo_screen")
	l_10_0._preloaded = true
end

Menu2DManager.destroy = function(l_11_0)
	l_11_0._components.page_flipper:page_change_callbacks().remove(l_11_0)
	l_11_0._components.page_flipper:destroy()
	l_11_0:_shutdown_resources()
end

Menu2DManager.set_state = function(l_12_0, l_12_1)
	l_12_0._state_transition_data.requested_state = l_12_1
end

Menu2DManager.set_dialog = function(l_13_0, l_13_1)
	l_13_0._state_transition_data.requested_dialog_state = l_13_1
end

Menu2DManager.remove_dialog = function(l_14_0)
	l_14_0._state_transition_data.requested_dialog_state = nil
end

Menu2DManager.state_flag = function(l_15_0, l_15_1)
	return l_15_0._state_flags[l_15_1]
end

Menu2DManager.is_active = function(l_16_0)
	local l_16_1, l_16_2 = l_16_0._components.page_flipper:has_active_page, l_16_0._components.page_flipper
	return l_16_1(l_16_2)
end

Menu2DManager.calc_safe_rect = function(l_17_0)
	l_17_0._settings.safe_rect = MenuUtility.safe_rect()
end

Menu2DManager.resume_game = function(l_18_0)
	managers.game_transition:request_unpause()
end

Menu2DManager.change_page = function(l_19_0, l_19_1)
	l_19_0._components.island:change_page(l_19_1)
end

Menu2DManager.back = function(l_20_0)
	l_20_0._components.island:go_back()
end

Menu2DManager.logo = function(l_21_0)
	return l_21_0._components.logo
end

Menu2DManager.can_go_back = function(l_22_0)
	local l_22_1, l_22_2 = l_22_0._page_selector:can_go_back, l_22_0._page_selector
	return l_22_1(l_22_2)
end

Menu2DManager.confirm_mode = function(l_23_0)
	local l_23_1, l_23_2 = l_23_0._page_selector:confirm_mode, l_23_0._page_selector
	return l_23_1(l_23_2)
end

Menu2DManager.update = function(l_24_0, l_24_1)
	l_24_0._menu_state_machine:update(l_24_1)
	l_24_0._components.sound:update(l_24_1)
	l_24_0._page_selector:set_dialog(l_24_0._state_transition_data.requested_dialog_state)
	l_24_0._page_selector:update(l_24_1)
	l_24_0._components.page_flipper:update(l_24_1)
	local l_24_2 = l_24_0._components.mouse:update(l_24_1, l_24_0:is_active())
	local l_24_3 = TimerManager:main():time()
	if l_24_0:is_active() then
		l_24_0._components.logo:update(l_24_3, l_24_1)
		l_24_0._components.distortion:update(l_24_3, l_24_1)
		l_24_0:update_menu_input(l_24_1, l_24_2)
	if l_24_0._loading_screen_test then
		end
		l_24_0._loading_screen_test:update(l_24_1)
	if l_24_0._loading_screen_test:fade_down_done() then
		end
		l_24_0._loading_screen_test = nil
	end
end

Menu2DManager.render = function(l_25_0)
	if not l_25_0._loading_screen_test then
		Application:render("MenuOverlay", l_25_0._vp)
	end
end

Menu2DManager.update_menu_input = function(l_26_0, l_26_1, l_26_2)
	local l_26_3 = {}
	if not l_26_0._block_input then
		l_26_3.move_axis = managers.menu_input:move_axis()
		if not managers.menu_input:pressed("menu_select") then
			l_26_3.select = managers.menu_input:pressed("menu_numpad_select")
		end
		if not managers.menu_input:pressed("menu_back") then
			l_26_3.back = l_26_2.back
		end
		l_26_3.start = managers.menu_input:pressed("pause")
		l_26_3.mouse = l_26_2
	else
		l_26_3.move_axis = Vector3(0, 0, 0)
	end
	local l_26_4 = l_26_0._components.page_flipper
	l_26_4:input(l_26_3, l_26_1)
end

Menu2DManager.raise_event = function(l_27_0, ...)
	l_27_0._event_manager:raise(...)
end

Menu2DManager.check_condition = function(l_28_0, l_28_1)
	if l_28_1 then
		local l_28_2 = l_28_0._event_manager[l_28_1]
		return l_28_2()
	end
end

Menu2DManager.set_event_on_hold = function(l_29_0, l_29_1, l_29_2)
	local l_29_3 = {}
	l_29_3.event = l_29_1
	l_29_3.params = l_29_2
	l_29_0._event_on_hold = l_29_3
end

Menu2DManager.execute_event_on_hold = function(l_30_0)
	if l_30_0._event_on_hold then
		l_30_0:raise_event(l_30_0._event_on_hold.event, l_30_0._event_on_hold.params)
		l_30_0._event_on_hold = nil
	else
		Application:error("try to execute event on hold that has not been set")
	end
end

Menu2DManager.use_connection = function(l_31_0, l_31_1, ...)
	if l_31_0._event_manager[l_31_1] then
		local l_31_3 = l_31_0._event_manager[l_31_1]
		local l_31_4, l_31_5, l_31_6 = l_31_0._event_manager, ..., .end
		return l_31_3(l_31_4, l_31_5, l_31_6)
	else
		Application:debug("no function in Menu2DEvent called " .. tostring(l_31_1))
	end
end

Menu2DManager.menu_island_instance_data = function(l_32_0)
	local l_32_1, l_32_2 = l_32_0._components.island:island_data, l_32_0._components.island
	return l_32_1(l_32_2)
end

Menu2DManager.logo_twitch = function(l_33_0, l_33_1)
	l_33_0._components.logo:twitch(l_33_1)
end

Menu2DManager.distortion_burst = function(l_34_0, l_34_1, l_34_2)
	l_34_0._components.distortion:create_burst(TimerManager:main():time(), l_34_1, l_34_2)
end

Menu2DManager.animation_dead = function(l_35_0, l_35_1)
	return coroutine.status(l_35_1) ~= "running" and coroutine.status(l_35_1) ~= "suspended"
end

Menu2DManager.is_credits_done = function(l_36_0)
	local l_36_1 = l_36_0._components.island:island_data()
	return l_36_1.credits_done == true
end

Menu2DManager.remove_resolution_changed_callback = function(l_37_0, l_37_1, l_37_2)
	l_37_0._changed_resolution_callbacks[l_37_1] = nil
end

Menu2DManager.set_resolution = function(l_38_0, l_38_1, l_38_2, l_38_3)
	local l_38_4 = rendering_change_resolution
	local l_38_5 = {}
	l_38_5.x = l_38_1
	l_38_5.y = l_38_2
	l_38_5.z = l_38_3
	l_38_4(l_38_5)
end

Menu2DManager.set_aspect = function(l_39_0, l_39_1)
	rendering_change_aspect_ratio(l_39_1)
end

Menu2DManager.set_gradient_page_name = function(l_40_0, l_40_1)
	l_40_0._gradient_page_name = l_40_1
end

Menu2DManager.gradient_page_name = function(l_41_0)
	return l_41_0._gradient_page_name
end

Menu2DManager.current_page_name = function(l_42_0)
	if l_42_0._current_page then
		local l_42_1, l_42_2 = l_42_0._current_page:name, l_42_0._current_page
		return l_42_1(l_42_2)
	else
		return ""
	end
end

Menu2DManager.save_profile = function(l_43_0)
	local l_43_1 = managers.menu_input:bound_user()
	if l_43_1 then
		l_43_1:save_profile()
	end
end

Menu2DManager.set_default_controller = function(l_44_0)
	local l_44_1 = managers.save:profile()
	l_44_1.control_settings.configuration_path = l_44_0._default_controller_path
	l_44_1.control_settings.configuration_path = nil
	l_44_0._save_controller = false
end

Menu2DManager.save_controller = function(l_45_0)
	local l_45_1 = managers.save:profile()
	local l_45_2 = managers.menu_input:bound_user():user_index()
	l_45_1.control_settings.configuration_path = l_45_0._custom_controller_path
	managers.controller:save_settings(l_45_0._custom_controller_path, l_45_2)
end

Menu2DManager.set_controller_changed = function(l_46_0)
	return l_46_0._save_controller
end

Menu2DManager.get_default_controller_path = function(l_47_0)
	return l_47_0._default_controller_path
end

Menu2DManager.block_input = function(l_48_0)
	return l_48_0._block_input
end

Menu2DManager.set_block_input = function(l_49_0, l_49_1)
	l_49_0._block_input = l_49_1
end

Menu2DManager._parse_level_id_xml = function(l_50_0)
	local l_50_1 = "data/lib/menu/levelnames.xml"
	l_50_0._start_level_ids = {}
	local l_50_6 = assert
	l_50_6(File:exists(l_50_1), "File " .. l_50_1 .. " is missing!")
	l_50_6 = File
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_50_2 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0 in l_50_2 do
		local l_50_7 = tonumber(l_50_5:parameter("start_id"))
		l_50_0._start_level_ids[l_50_7] = l_50_7
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DManager.callback_create_replay_scenario_page = function(l_51_0, l_51_1)
	local l_51_7, l_51_8, l_51_9, l_51_10, l_51_11, l_51_12, l_51_13 = nil
	local l_51_2 = managers.save:profile()
	if l_51_2 then
		l_51_1:clear()
		local l_51_3 = 0
		for i_0,i_1 in ipairs(l_51_2.levels) do
			if i_1.maximum_checkpoint_id > 0 and l_51_0._start_level_ids[i_0] ~= nil and managers.world_info:info_from_id(i_0) then
				Menu2DChoice:new():set_param("goto_page", "difficulty_level")
				Menu2DChoice:new():set_param("event", "replay_set_start_level")
				Menu2DChoice:new():set_param("level_name", Localizer:lookup("chapter_line_" .. tostring(i_0)))
				Menu2DChoice:new():set_param("level_id", l_51_14)
				Menu2DChoice:new():set_param("checkpoint_id", 1)
				local l_51_16, l_51_17 = nil
				local l_51_18 = Menu2DChoice:new():set_widget
				l_51_18(Menu2DChoice:new(), {type = "level", x = 0, y = 0, level = l_51_16, texture = "gui_resumegame_level_" .. tostring(l_51_14)})
				l_51_18(l_51_1, l_51_17)
			end
		end
	end
end

Menu2DManager.callback_resolution_changed = function(l_52_0)
	l_52_0._components.page_flipper:changing_resolution()
	l_52_0:_shutdown_resources()
	l_52_0:_setup_resources()
	l_52_0._components.page_flipper:resolution_changed()
end

Menu2DManager.callback_back_options_page = function(l_53_0)
	l_53_0:save_profile()
	l_53_0:back()
end

Menu2DManager.dismiss_save_icon_notification = function(l_54_0)
	l_54_0:menu_island_instance_data().save_icon_notification_done = true
end

Menu2DManager.start_new_game = function(l_55_0)
	managers.save:set_new_game()
	local l_55_1 = managers.menu2d:menu_island_instance_data()
	local l_55_2 = managers.save:profile().progress_level_id
	l_55_1.start_level_id = l_55_2
	l_55_1.start_level_name = 1
	l_55_1.start_level_checkpoint = 1
	l_55_1.save_progress = true
	l_55_0:remove_dialog()
	l_55_0:change_page("difficulty_level")
end

Menu2DManager.replay_scenario = function(l_56_0)
	l_56_0:remove_dialog()
	l_56_0:change_page("replay_scenario")
end

Menu2DManager.debug = function(l_57_0)
	return l_57_0._debug_manager
end

Menu2DManager._is_debug_mode = function(l_58_0)
	if Application:is_production() or Application:is_dev_build() then
		return true
	end
	if File:exists("data/videos/enable_debug.hack") then
		return true
	end
	return false
end


