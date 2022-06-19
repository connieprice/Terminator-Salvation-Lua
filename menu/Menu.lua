require("menu/OverlayMovie")
require("shared/FiniteStateMachine")
require("menu/states/MenuStates")
require("LevelLoadingEnvironment")
require("MenuLoadingEnvironment")
if not Menu then
	Menu = class()
end
Menu.is_production_mode = false
Menu.EASY = 1
Menu.MEDIUM = 2
Menu.HARD = 3
Menu.init = function(l_1_0, l_1_1, l_1_2)
	local l_1_9, l_1_10, l_1_11 = nil
	l_1_0._gui_interface = l_1_2
	if l_1_1.dialog_local_user_index then
		l_1_0:_set_dialog_user_index(l_1_1.dialog_local_user_index)
	end
	local l_1_3 = _G[l_1_1.start_state]
	l_1_0:show_ingame_gui()
	local l_1_8 = FiniteStateMachine:new
	l_1_8 = l_1_8(FiniteStateMachine, l_1_0, "_menu", l_1_3)
	l_1_0._machine = l_1_8
	l_1_8 = l_1_0._machine
	l_1_8(l_1_8, true)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_4 = nil
	l_1_4 = ipairs
	l_1_4 = l_1_4(l_1_8)
	for i_0,i_1 in l_1_4 do
		if i_1 == "-skipintro" then
			if not Global.zone_data then
				Global.zone_data = {}
			end
			Global.zone_data.skip_intro_movies = true
		end
	end
	l_1_0._is_production = false
	l_1_0._dialog_state = FiniteStateMachine:new(l_1_0, "_menu", _G[l_1_1.dialog_start_state])
	l_1_0._dialog_state:set_debug(true)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu.gui_interface = function(l_2_0)
	return l_2_0._gui_interface
end

Menu.default_data = function(l_3_0)
	l_3_0.start_state = "MenuStateInit"
	l_3_0.dialog_start_state = "MenuStateDialogNone"
end

Menu.save = function(l_4_0, l_4_1)
	l_4_1.start_state = l_4_0._machine:_debug_state_name()
	l_4_1.dialog_start_state = l_4_0._dialog_state:_debug_state_name()
	if l_4_0._dialog_local_user then
		l_4_1.dialog_local_user_index = l_4_0._dialog_local_user:user_index()
	end
end

Menu.destroy = function(l_5_0)
	l_5_0:hide_ingame_gui()
	l_5_0._machine:destroy()
	l_5_0._machine = nil
end

Menu._frontend_end_sync_state = function(l_6_0, l_6_1)
	if l_6_1 == "editor" then
		return MenuStateInEditorEndSync
	else
		return MenuStatePreFrontendEndSync
	end
end

Menu.update = function(l_7_0, l_7_1)
	l_7_0:_common_update(l_7_1)
	if l_7_0._ingame_gui then
		l_7_0._ingame_gui:update(l_7_1)
	end
end

Menu._common_update = function(l_8_0, l_8_1)
	l_8_0:_update_dialog_state_data()
	l_8_0._dialog_state:update(l_8_1)
	l_8_0._machine:update(l_8_1)
end

Menu._update_dialog_state_data = function(l_9_0)
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12 = nil
	local l_9_1 = managers.local_user:users()
	l_9_0._disconnected_controller_index = nil
	for i_0,i_1 in pairs(l_9_1) do
		if i_1:is_playing_the_game() and i_1:controller_disconnected() then
			l_9_0._disconnected_controller_index = i_1:user_index()
			return 
		end
	end
end

Menu.user_wants_to_skip = function(l_10_0)
	if not managers.menu_input:any_user_pressed(managers.local_user:users(), "menu_select") then
		return managers.menu_input:any_user_pressed(managers.local_user:users(), "menu_start")
	end
end

Menu.show_ingame_gui = function(l_11_0)
	l_11_0._ingame_gui = IngameGui:new()
	l_11_0._ingame_gui:show()
end

Menu.hide_ingame_gui = function(l_12_0)
	l_12_0._ingame_gui:hide()
	l_12_0._ingame_gui:destroy()
	l_12_0._ingame_gui = nil
end

Menu.ingame_gui = function(l_13_0)
	assert(l_13_0._ingame_gui)
	return l_13_0._ingame_gui
end

Menu.root_panel = function(l_14_0)
	local l_14_1, l_14_2 = l_14_0._ingame_gui:root_panel, l_14_0._ingame_gui
	return l_14_1(l_14_2)
end

Menu.set_in_mainmenu = function(l_15_0, l_15_1)
	l_15_0._in_main_menu = l_15_1
end

Menu.is_in_mainmenu = function(l_16_0)
	return l_16_0._in_main_menu
end

Menu.quit_front_end = function(l_17_0)
end

Menu.is_in_front_end = function(l_18_0)
	return l_18_0._is_in_front_end
end

Menu.start_ingame = function(l_19_0)
end

Menu.quit_ingame = function(l_20_0)
end

Menu.start_editor = function(l_21_0)
end

Menu.quit_editor = function(l_22_0)
end

Menu.start_editor_simulation = function(l_23_0, l_23_1)
end

Menu.stop_editor_simulation = function(l_24_0)
end

Menu.clear_intro_movies_done = function(l_25_0)
	l_25_0._intro_movies_done = nil
end

Menu.set_intro_movies_done = function(l_26_0)
	l_26_0._intro_movies_done = true
end

Menu.is_intro_movies_done = function(l_27_0)
	if not l_27_0._intro_movies_done and Global.zone_data then
		return Global.zone_data.skip_intro_movies
	end
end

Menu.set_movies_are_skipped = function(l_28_0)
	l_28_0._movies_are_skipped = true
end

Menu.clear_movies_are_skipped = function(l_29_0)
	l_29_0._movies_are_skipped = nil
end

Menu.are_movies_skipped = function(l_30_0)
	return l_30_0._movies_are_skipped
end

Menu.clear_save_notification_dismissed = function(l_31_0)
	l_31_0._save_notification_dismissed = nil
end

Menu.set_save_notification_dismissed = function(l_32_0)
	l_32_0._save_notification_dismissed = true
end

Menu.is_save_notification_dismissed = function(l_33_0)
	return l_33_0._save_notification_dismissed
end

Menu.set_ingame_paused = function(l_34_0, l_34_1)
	l_34_0._is_ingame_paused = l_34_1
end

Menu.is_ingame_paused = function(l_35_0)
	return l_35_0._is_ingame_paused
end

Menu.is_ready_to_resume = function(l_36_0)
	return l_36_0._is_ready_to_resume
end

Menu.sync_started = function(l_37_0)
	return l_37_0._sync_started
end

Menu._set_sync_started = function(l_38_0)
	l_38_0._sync_started = true
end

Menu._clear_sync_started = function(l_39_0)
	l_39_0._sync_started = nil
end

Menu._set_ingame_ready = function(l_40_0)
	l_40_0._ingame_ready = true
end

Menu._clear_ingame_ready = function(l_41_0)
	l_41_0._ingame_ready = nil
end

Menu.is_ingame_ready = function(l_42_0)
	return l_42_0._ingame_ready
end

Menu._set_frontend_ready = function(l_43_0)
	l_43_0._frontend_ready = true
end

Menu._clear_frontend_ready = function(l_44_0)
	l_44_0._frontend_ready = nil
end

Menu.is_frontend_ready = function(l_45_0)
	return l_45_0._frontend_ready
end

Menu.is_end_of_mission_done = function(l_46_0)
	return l_46_0._is_end_of_mission_done
end

Menu.is_in_title_screen = function(l_47_0)
	return l_47_0._is_in_title_screen
end

Menu.is_in_dialog = function(l_48_0)
	return l_48_0._is_in_dialog
end

Menu._set_dialog_user_index = function(l_49_0, l_49_1)
	local l_49_2 = managers.local_user:user_from_user_index(l_49_1)
	assert(l_49_2)
	l_49_0:set_dialog_user(l_49_2)
end

Menu.set_dialog_user = function(l_50_0, l_50_1)
	l_50_0._dialog_local_user = l_50_1
	l_50_0._dialog_local_user_storage = l_50_1._storage
	assert(l_50_0._dialog_local_user_storage)
end

Menu.release_dialog_user = function(l_51_0)
	cat_print("debug", "release_dialog_user")
	l_51_0._dialog_local_user_storage = nil
	l_51_0._dialog_local_user = nil
end

Menu.has_dialog_user = function(l_52_0)
	return l_52_0._dialog_local_user ~= nil
end

Menu.dialog_user = function(l_53_0)
	assert(l_53_0._dialog_local_user)
	return l_53_0._dialog_local_user
end

Menu.dialog_user_storage = function(l_54_0)
	assert(l_54_0._dialog_local_user_storage)
	return l_54_0._dialog_local_user_storage
end

Menu.set_waits_for_pre_frontend_due_to_sign_out = function(l_55_0)
	l_55_0._waits_for_pre_frontend_due_to_sign_out = true
end

Menu.waits_for_pre_frontend_due_to_sign_out = function(l_56_0)
	return l_56_0._waits_for_pre_frontend_due_to_sign_out
end

Menu.ack_waits_for_pre_frontend_due_to_sign_out = function(l_57_0)
	l_57_0._waits_for_pre_frontend_due_to_sign_out = nil
end

Menu.set_pre_frontend_once_shown = function(l_58_0)
	Global.has_shown_pre_frontend_once = true
end

Menu.has_shown_pre_frontend_once = function(l_59_0)
	return Global.has_shown_pre_frontend_once
end

Menu.disconnected_controller_index = function(l_60_0)
	return l_60_0._disconnected_controller_index
end


