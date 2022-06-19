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
Menu2DManager = Menu2DManager or class()
Menu2DManager._custom_controller_path = "settings/custom_controls.xml"
Menu2DManager._default_controller_path = "settings/default_controls.xml"
function Menu2DManager.init(A0_0)
	local L1_1, L2_2, L3_3, L4_4
	L1_1 = {}
	L1_1.requested_state = "inactive"
	L1_1.requested_dialog = nil
	A0_0._state_transition_data = L1_1
	L1_1 = {}
	A0_0._sync_state = L1_1
	L1_1 = {}
	A0_0._settings = L1_1
	L1_1 = {}
	L2_2 = Menu2DSound
	L3_3 = L2_2
	L2_2 = L2_2.new
	L2_2 = L2_2(L3_3)
	L1_1.sound = L2_2
	L2_2 = Menu2DEffects
	L3_3 = L2_2
	L2_2 = L2_2.new
	L2_2 = L2_2(L3_3)
	L1_1.effects = L2_2
	A0_0._components = L1_1
	A0_0._time_since_move = 0
	L1_1 = Menu2DEvents
	L2_2 = L1_1
	L1_1 = L1_1.new
	L1_1 = L1_1(L2_2)
	A0_0._event_manager = L1_1
	L2_2 = A0_0
	L1_1 = A0_0._is_debug_mode
	L1_1 = L1_1(L2_2)
	if L1_1 then
		L1_1 = Menu2DDebug
		L2_2 = L1_1
		L1_1 = L1_1.new
		L1_1 = L1_1(L2_2)
		A0_0._debug_manager = L1_1
	end
	L2_2 = A0_0
	L1_1 = A0_0._setup_resources
	L1_1(L2_2)
	L1_1 = A0_0._components
	L2_2 = Menu2DPageFlipper
	L3_3 = L2_2
	L2_2 = L2_2.new
	L4_4 = A0_0._components
	L2_2 = L2_2(L3_3, L4_4, A0_0._settings)
	L1_1.page_flipper = L2_2
	L1_1 = Menu2DPageSelector
	L2_2 = L1_1
	L1_1 = L1_1.new
	L3_3 = A0_0._components
	L1_1 = L1_1(L2_2, L3_3)
	A0_0._page_selector = L1_1
	L1_1 = A0_0._components
	L1_1 = L1_1.page_flipper
	L2_2 = L1_1
	L1_1 = L1_1.page_change_callbacks
	L1_1 = L1_1(L2_2)
	L1_1 = L1_1.add
	L2_2 = A0_0
	function L3_3(...)
		local L1_6, L2_7, L3_8
		L1_6 = _UPVALUE0_
		L1_6 = L1_6._components
		L1_6 = L1_6.sound
		L2_7 = L1_6
		L1_6 = L1_6.on_page_change
		L3_8 = ...
		L1_6(L2_7, L3_8)
	end
	L1_1(L2_2, L3_3)
	L1_1 = {}
	A0_0._state_flags = L1_1
	L1_1 = managers
	L1_1 = L1_1.viewport
	L2_2 = L1_1
	L1_1 = L1_1.add_resolution_changed_func
	L3_3 = callback
	L4_4 = A0_0
	L4_4 = L3_3(L4_4, A0_0, "callback_resolution_changed")
	L1_1(L2_2, L3_3, L4_4, L3_3(L4_4, A0_0, "callback_resolution_changed"))
	L1_1 = {}
	L2_2 = A0_0._components
	L1_1.components = L2_2
	L2_2 = A0_0._state_transition_data
	L1_1.state_transition_data = L2_2
	L2_2 = A0_0._state_flags
	L1_1.state_flags = L2_2
	L2_2 = A0_0._settings
	L1_1.settings = L2_2
	L2_2 = A0_0._sync_state
	L1_1.sync_state = L2_2
	L2_2 = {}
	L2_2.menu = L1_1
	L3_3 = Menu2DStatesMainTransitions
	L2_2.state_transitions = L3_3
	L3_3 = A0_0._state_transition_data
	L3_3 = L3_3.requested_state
	L4_4 = Menu2DStateTransitionLookup
	L4_4 = L4_4.new
	L4_4 = L4_4(L4_4, Menu2DStatesMainTransitions)
	L4_4 = L4_4.state
	L4_4 = L4_4(L4_4, L3_3)
	A0_0._menu_state_machine = FiniteStateMachine:new(L2_2, "_state_data", L4_4)
	A0_0._menu_state_machine:set_debug(true)
	A0_0:_parse_level_id_xml()
end
function Menu2DManager._shutdown_resources(A0_9)
	A0_9._components.mouse:destroy()
	A0_9._components.mouse = nil
	A0_9._components.root_panel:clear()
	A0_9._components.gui:destroy_workspace(A0_9._components.workspace)
	Application:destroy_viewport(A0_9._vp)
end
function Menu2DManager._setup_resources(A0_10)
	A0_10:_create_menu_viewport()
	A0_10:calc_safe_rect()
	A0_10:preload()
	A0_10._components.distortion = Menu2DDistortion:new()
	A0_10._components.distortion:set_parent(A0_10._components.root_panel)
	A0_10._components.logo = Menu2DTitleLogo:new(A0_10._components.root_panel, "title")
	A0_10._components.mouse = Menu2DMouse:new(A0_10._components.root_panel)
end
function Menu2DManager.gui_interface(A0_11)
	return Menu2DManagerGuiInterface:new(A0_11)
end
function Menu2DManager.sound(A0_12)
	return A0_12._components.sound
end
function Menu2DManager.page_change_completed(A0_13)
	return A0_13._components.page_flipper:page_change_completed()
end
function Menu2DManager.debug_loading_test(A0_14)
	if A0_14._loading_screen_test then
		A0_14._loading_screen_test:stop()
	else
		A0_14._loading_screen_test = LoadingScreenTest:new(A0_14._components.workspace)
	end
end
function Menu2DManager.post_init(A0_15)
	A0_15._components.page_flipper:post_init()
end
function Menu2DManager._create_menu_viewport(A0_16)
	local L1_17
	L1_17 = RenderSettings
	L1_17 = L1_17.resolution
	A0_16._vp = Application:create_scene_viewport(0, 0, 1, 1)
	A0_16._width = 1280
	A0_16._height = 720 * (1.7777778 / core_setup.aspect_ratio)
	A0_16._components.gui = MenuOverlay:gui()
	A0_16._components.workspace = A0_16._components.gui:create_scaled_screen_workspace(A0_16._width, A0_16._height, 0, 0, L1_17.x, L1_17.y)
	A0_16._components.workspace:set_timer(TimerManager:main())
	A0_16._components.root_panel = A0_16._components.workspace:panel()
end
function Menu2DManager.preload(A0_18)
	if A0_18._preloaded then
		return
	end
	World:preload_unit("empty")
	A0_18._components.gui:preload_font("faith_font_22")
	A0_18._components.gui:preload_font("credits")
	A0_18._components.gui:preload_font("credits_merged")
	A0_18._components.sound:preload()
	A0_18._components.gui:preload_texture("gui_menu_salvation_logo_glow")
	A0_18._components.gui:preload_texture("gui_menu_salvation_logo_big")
	A0_18._components.gui:preload_texture("gui_menu_tickbox_on")
	A0_18._components.gui:preload_texture("gui_menu_tickbox_off")
	A0_18._components.gui:preload_texture("gui_menu_volumebar_line")
	A0_18._components.gui:preload_texture("gui_menu_volumebar_gradient")
	A0_18._components.gui:preload_texture("gui_hud_selection_dot")
	A0_18._components.gui:preload_texture("gui_menu_bg_gradient")
	A0_18._components.gui:preload_texture("gui_menu_360_controller")
	A0_18._components.gui:preload_texture("security_camera_edgebleed")
	A0_18._components.gui:preload_texture("security_camera_noise_1")
	A0_18._components.gui:preload_texture("security_camera_noise_2")
	A0_18._components.gui:preload_texture("security_camera_noise_3")
	A0_18._components.gui:preload_texture("security_camera_noise_4")
	A0_18._components.gui:preload_texture("gui_legalinfo_screen_global")
	A0_18._components.gui:preload_texture("gui_legalinfo_screen")
	A0_18._preloaded = true
end
function Menu2DManager.destroy(A0_19)
	A0_19._components.page_flipper:page_change_callbacks().remove(A0_19)
	A0_19._components.page_flipper:destroy()
	A0_19:_shutdown_resources()
end
function Menu2DManager.set_state(A0_20, A1_21)
	A0_20._state_transition_data.requested_state = A1_21
end
function Menu2DManager.set_dialog(A0_22, A1_23)
	A0_22._state_transition_data.requested_dialog_state = A1_23
end
function Menu2DManager.remove_dialog(A0_24)
	A0_24._state_transition_data.requested_dialog_state = nil
end
function Menu2DManager.state_flag(A0_25, A1_26)
	return A0_25._state_flags[A1_26]
end
function Menu2DManager.is_active(A0_27)
	return A0_27._components.page_flipper:has_active_page()
end
function Menu2DManager.calc_safe_rect(A0_28)
	A0_28._settings.safe_rect = MenuUtility.safe_rect()
end
function Menu2DManager.resume_game(A0_29)
	managers.game_transition:request_unpause()
end
function Menu2DManager.change_page(A0_30, A1_31)
	A0_30._components.island:change_page(A1_31)
end
function Menu2DManager.back(A0_32)
	A0_32._components.island:go_back()
end
function Menu2DManager.logo(A0_33)
	return A0_33._components.logo
end
function Menu2DManager.can_go_back(A0_34)
	return A0_34._page_selector:can_go_back()
end
function Menu2DManager.confirm_mode(A0_35)
	return A0_35._page_selector:confirm_mode()
end
function Menu2DManager.update(A0_36, A1_37)
	local L2_38, L3_39
	L2_38 = A0_36._menu_state_machine
	L3_39 = L2_38
	L2_38 = L2_38.update
	L2_38(L3_39, A1_37)
	L2_38 = A0_36._components
	L2_38 = L2_38.sound
	L3_39 = L2_38
	L2_38 = L2_38.update
	L2_38(L3_39, A1_37)
	L2_38 = A0_36._page_selector
	L3_39 = L2_38
	L2_38 = L2_38.set_dialog
	L2_38(L3_39, A0_36._state_transition_data.requested_dialog_state)
	L2_38 = A0_36._page_selector
	L3_39 = L2_38
	L2_38 = L2_38.update
	L2_38(L3_39, A1_37)
	L2_38 = A0_36._components
	L2_38 = L2_38.page_flipper
	L3_39 = L2_38
	L2_38 = L2_38.update
	L2_38(L3_39, A1_37)
	L2_38 = A0_36._components
	L2_38 = L2_38.mouse
	L3_39 = L2_38
	L2_38 = L2_38.update
	L2_38 = L2_38(L3_39, A1_37, A0_36:is_active())
	L3_39 = TimerManager
	L3_39 = L3_39.main
	L3_39 = L3_39(L3_39)
	L3_39 = L3_39.time
	L3_39 = L3_39(L3_39)
	if A0_36:is_active() then
		A0_36._components.logo:update(L3_39, A1_37)
		A0_36._components.distortion:update(L3_39, A1_37)
		A0_36:update_menu_input(A1_37, L2_38)
		if A0_36._loading_screen_test then
			A0_36._loading_screen_test:update(A1_37)
			if A0_36._loading_screen_test:fade_down_done() then
				A0_36._loading_screen_test = nil
			end
		end
	end
end
function Menu2DManager.render(A0_40)
	if not A0_40._loading_screen_test then
		Application:render("MenuOverlay", A0_40._vp)
	end
end
function Menu2DManager.update_menu_input(A0_41, A1_42, A2_43)
	local L3_44
	L3_44 = {}
	if not A0_41._block_input then
		L3_44.move_axis = managers.menu_input:move_axis()
		L3_44.select = managers.menu_input:pressed("menu_select") or managers.menu_input:pressed("menu_numpad_select")
		L3_44.back = managers.menu_input:pressed("menu_back") or A2_43.back
		L3_44.start = managers.menu_input:pressed("pause")
		L3_44.mouse = A2_43
	else
		L3_44.move_axis = Vector3(0, 0, 0)
	end
	A0_41._components.page_flipper:input(L3_44, A1_42)
end
function Menu2DManager.raise_event(A0_45, ...)
	local L3_47, L4_48
	L3_47 = A0_45._event_manager
	L4_48 = L3_47
	L3_47 = L3_47.raise
	L3_47(L4_48, ...)
end
function Menu2DManager.check_condition(A0_49, A1_50)
	if A1_50 then
		return A0_49._event_manager[A1_50]()
	end
end
function Menu2DManager.set_event_on_hold(A0_51, A1_52, A2_53)
	local L3_54
	L3_54 = {}
	L3_54.event = A1_52
	L3_54.params = A2_53
	A0_51._event_on_hold = L3_54
end
function Menu2DManager.execute_event_on_hold(A0_55)
	if A0_55._event_on_hold then
		A0_55:raise_event(A0_55._event_on_hold.event, A0_55._event_on_hold.params)
		A0_55._event_on_hold = nil
	else
		Application:error("try to execute event on hold that has not been set")
	end
end
function Menu2DManager.use_connection(A0_56, A1_57, ...)
	if A0_56._event_manager[A1_57] then
		return A0_56._event_manager[A1_57](A0_56._event_manager, ...)
	else
		Application:debug("no function in Menu2DEvent called " .. tostring(A1_57))
	end
end
function Menu2DManager.menu_island_instance_data(A0_59)
	return A0_59._components.island:island_data()
end
function Menu2DManager.logo_twitch(A0_60, A1_61)
	A0_60._components.logo:twitch(A1_61)
end
function Menu2DManager.distortion_burst(A0_62, A1_63, A2_64)
	A0_62._components.distortion:create_burst(TimerManager:main():time(), A1_63, A2_64)
end
function Menu2DManager.animation_dead(A0_65, A1_66)
	return coroutine.status(A1_66) ~= "running" and coroutine.status(A1_66) ~= "suspended"
end
function Menu2DManager.is_credits_done(A0_67)
	return A0_67._components.island:island_data().credits_done == true
end
function Menu2DManager.remove_resolution_changed_callback(A0_68, A1_69, A2_70)
	A0_68._changed_resolution_callbacks[A1_69] = nil
end
function Menu2DManager.set_resolution(A0_71, A1_72, A2_73, A3_74)
	rendering_change_resolution({
		x = A1_72,
		y = A2_73,
		z = A3_74
	})
end
function Menu2DManager.set_aspect(A0_75, A1_76)
	rendering_change_aspect_ratio(A1_76)
end
function Menu2DManager.set_gradient_page_name(A0_77, A1_78)
	A0_77._gradient_page_name = A1_78
end
function Menu2DManager.gradient_page_name(A0_79)
	local L1_80
	L1_80 = A0_79._gradient_page_name
	return L1_80
end
function Menu2DManager.current_page_name(A0_81)
	if A0_81._current_page then
		return A0_81._current_page:name()
	else
		return ""
	end
end
function Menu2DManager.save_profile(A0_82)
	if managers.menu_input:bound_user() then
		managers.menu_input:bound_user():save_profile()
	end
end
function Menu2DManager.set_default_controller(A0_83)
	managers.save:profile().control_settings.configuration_path = A0_83._default_controller_path
	managers.save:profile().control_settings.configuration_path = nil
	A0_83._save_controller = false
end
function Menu2DManager.save_controller(A0_84)
	local L1_85, L2_86
	L1_85 = managers
	L1_85 = L1_85.save
	L2_86 = L1_85
	L1_85 = L1_85.profile
	L1_85 = L1_85(L2_86)
	L2_86 = managers
	L2_86 = L2_86.menu_input
	L2_86 = L2_86.bound_user
	L2_86 = L2_86(L2_86)
	L2_86 = L2_86.user_index
	L2_86 = L2_86(L2_86)
	L1_85.control_settings.configuration_path = A0_84._custom_controller_path
	managers.controller:save_settings(A0_84._custom_controller_path, L2_86)
end
function Menu2DManager.set_controller_changed(A0_87)
	local L1_88
	L1_88 = A0_87._save_controller
	return L1_88
end
function Menu2DManager.get_default_controller_path(A0_89)
	local L1_90
	L1_90 = A0_89._default_controller_path
	return L1_90
end
function Menu2DManager.block_input(A0_91)
	local L1_92
	L1_92 = A0_91._block_input
	return L1_92
end
function Menu2DManager.set_block_input(A0_93, A1_94)
	A0_93._block_input = A1_94
end
function Menu2DManager._parse_level_id_xml(A0_95)
	local L1_96
	L1_96 = "data/lib/menu/levelnames.xml"
	A0_95._start_level_ids = {}
	assert(File:exists(L1_96), "File " .. L1_96 .. " is missing!")
	for 