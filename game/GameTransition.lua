require("managers/WorldManager")
require("shared/TableAlgorithms")
require("shared/MultiStateRequest")
if not GameTransition then
	GameTransition = class()
end
GameTransition.init = function(l_1_0, l_1_1)
	TableAlgorithms.merge_except_functions(l_1_0, l_1_1)
	l_1_0._wants_to_exec = false
	l_1_0._wants_freeze_mode = MultiStateRequest:new()
	l_1_0._wants_pause_mode = MultiStateRequest:new()
end

GameTransition.default_data = function(l_2_0, l_2_1)
	l_2_1 = {}
end

GameTransition.save = function(l_3_0, l_3_1)
	TableAlgorithms.merge_except_functions(l_3_1, l_3_0)
end

GameTransition.clear_wants_to_host = function(l_4_0)
	l_4_0._wants_to_host = false
	l_4_0._player_slot_count_needed_to_host = nil
end

GameTransition.set_wants_to_host = function(l_5_0, l_5_1)
	l_5_0._wants_to_host = true
	l_5_0._player_slot_count_needed_to_host = l_5_1
end

GameTransition.slot_count_needed_to_host = function(l_6_0)
	return l_6_0._player_slot_count_needed_to_host
end

GameTransition.host_game = function(l_7_0)
	managers.network:start_hosting()
	l_7_0._session_to_join = Network:self()
end

GameTransition.wants_to_host_session = function(l_8_0)
	return l_8_0._wants_to_host
end

GameTransition.wants_to_join_session = function(l_9_0)
	return l_9_0._session_to_join ~= nil
end

GameTransition.clear_session_to_join = function(l_10_0)
	l_10_0._session_to_join = nil
end

GameTransition.set_ignore_level_load = function(l_11_0, l_11_1, l_11_2)
	l_11_0._ignore_level_load = l_11_1
	assert(l_11_2)
	managers.save:set_level_data_to_profiles(nil, l_11_2, "editor_level_do_not_join", false)
end

GameTransition.ignore_level_load = function(l_12_0)
	return l_12_0._ignore_level_load
end

GameTransition.request_load = function(l_13_0, l_13_1, l_13_2)
	cat_print("debug", "request_load(" .. l_13_1 .. ", " .. tostring(l_13_2))
	l_13_0._level_name = l_13_1
	assert(l_13_2)
	l_13_0:set_checkpoint_index(l_13_2)
end

GameTransition.wants_to_load = function(l_14_0)
	return l_14_0._level_name ~= nil
end

GameTransition.clear_wants_to_load = function(l_15_0)
	l_15_0._level_name = nil
end

GameTransition.level_name = function(l_16_0)
	return l_16_0._level_name
end

GameTransition.set_checkpoint_index = function(l_17_0, l_17_1)
	l_17_0._checkpoint_index = l_17_1
end

GameTransition.checkpoint_index = function(l_18_0)
	return l_18_0._checkpoint_index
end

GameTransition.session_to_join = function(l_19_0)
	assert(l_19_0._session_to_join)
	return l_19_0._session_to_join
end

GameTransition.exec_game_from_menu = function(l_20_0)
	Global.show_intro_credits = true
	assert(managers.network:host():session_provider():level_name())
end

GameTransition.exec_game_from_game = function(l_21_0)
	Global.show_intro_credits = false
	l_21_0._wants_to_clear_world = true
	l_21_0._wants_to_quit_session = true
	l_21_0._wants_to_go_to_frontend = false
	l_21_0:clear_game_over()
	l_21_0:set_wants_to_host(l_21_0:slot_count_needed_to_host())
end

GameTransition.exec_menu = function(l_22_0)
	Global.zone_data = {}
	Global.zone_data.skip_intro_movies = true
	Global.zone_data.skip_start_menu = true
	l_22_0._wants_to_quit_session = true
	l_22_0._wants_to_go_to_frontend = true
	l_22_0:clear_session_to_join()
	l_22_0:clear_wants_to_host()
end

GameTransition.set_wants_to_go_to_frontend = function(l_23_0)
	l_23_0._wants_to_go_to_frontend = true
end

GameTransition.wants_to_go_to_frontend = function(l_24_0)
	return l_24_0._wants_to_go_to_frontend
end

GameTransition.clear_wants_to_go_to_frontend = function(l_25_0)
	l_25_0._wants_to_go_to_frontend = nil
end

GameTransition.wants_to_quit_session = function(l_26_0)
	return l_26_0._wants_to_quit_session
end

GameTransition.clear_wants_to_quit_session = function(l_27_0)
	l_27_0._wants_to_quit_session = nil
end

GameTransition.exec_end_of_mission = function(l_28_0)
	l_28_0._reached_end_of_mission = true
end

GameTransition.reached_end_of_mission = function(l_29_0)
	return l_29_0._reached_end_of_mission
end

GameTransition.clear_reached_end_of_mission = function(l_30_0)
	l_30_0._reached_end_of_mission = nil
end

GameTransition.exec_end_of_game = function(l_31_0)
	l_31_0:exec_menu()
	Global.zone_data.show_end_credits = true
end

GameTransition.clear_game_over = function(l_32_0)
	l_32_0._game_over = false
end

GameTransition.game_over = function(l_33_0)
	l_33_0._game_over = true
end

GameTransition.is_game_over = function(l_34_0)
	return l_34_0._game_over
end

GameTransition.should_pass_through_menu = function(l_35_0)
	return l_35_0._pass_through_menu
end

GameTransition.set_should_pass_through_menu = function(l_36_0)
	l_36_0._pass_through_menu = true
end

GameTransition.request_pre_frontend = function(l_37_0, l_37_1)
	l_37_0._wants_to_go_to_pre_frontend = true
	l_37_0._wants_to_go_to_pre_frontend_due_to_sign_out = l_37_1
end

GameTransition.pre_frontend_due_to_sign_out = function(l_38_0)
	return l_38_0._wants_to_go_to_pre_frontend_due_to_sign_out
end

GameTransition.clear_pre_frontend_due_to_sign_out = function(l_39_0)
	l_39_0._wants_to_go_to_pre_frontend_due_to_sign_out = nil
end

GameTransition.wants_to_go_to_pre_frontend = function(l_40_0)
	return l_40_0._wants_to_go_to_pre_frontend
end

GameTransition.clear_wants_to_go_to_pre_frontend = function(l_41_0)
	l_41_0._wants_to_go_to_pre_frontend = nil
end

local l_0_0 = GameTransition
local l_0_1 = {}
l_0_1.NORMAL = 1
l_0_1.CUTSCENE = 2
l_0_0.PAUSE_MODES = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_42_0)
	cat_print("debug", "transition: Request Pause")
	l_42_0._wants_pause_mode:request(l_42_0.PAUSE_MODES.NORMAL, true)
end

l_0_0.request_pause = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_43_0)
	cat_print("debug", "transition: Request Cutscene Pause")
	l_43_0._wants_pause_mode:request(l_43_0.PAUSE_MODES.CUTSCENE, true)
end

l_0_0.request_cutscene_pause = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_44_0)
	local l_44_1, l_44_2 = l_44_0._wants_pause_mode:wants_enabled_state, l_44_0._wants_pause_mode
	return l_44_1(l_44_2)
end

l_0_0.wants_to_pause = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_45_0)
	cat_print("debug", "transition: Request UnPause")
	l_45_0._wants_pause_mode:request(l_45_0.PAUSE_MODES.NORMAL, false)
end

l_0_0.request_unpause = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_46_0)
	cat_print("debug", "transition: Request Cutscene UnPause")
	l_46_0._wants_pause_mode:request(l_46_0.PAUSE_MODES.CUTSCENE, false)
end

l_0_0.request_cutscene_unpause = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_47_0)
	local l_47_1, l_47_2 = l_47_0._wants_pause_mode:wants_disabled_state, l_47_0._wants_pause_mode
	return l_47_1(l_47_2)
end

l_0_0.wants_to_unpause = l_0_1
l_0_0 = GameTransition
l_0_0.FREEZE_MODES, l_0_1 = l_0_1, {NORMAL = 1, SYSTEM_UI = 2}
l_0_0 = GameTransition
l_0_1 = function(l_48_0)
	cat_print("debug", "transition: Request Freeze")
	l_48_0._wants_freeze_mode:request(l_48_0.FREEZE_MODES.NORMAL, true)
end

l_0_0.request_freeze = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_49_0)
	cat_print("debug", "transition: Request System UI Freeze")
	l_49_0._wants_freeze_mode:request(l_49_0.FREEZE_MODES.SYSTEM_UI, true)
end

l_0_0.request_system_ui_freeze = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_50_0)
	local l_50_1, l_50_2 = l_50_0._wants_freeze_mode:wants_enabled_state, l_50_0._wants_freeze_mode
	return l_50_1(l_50_2)
end

l_0_0.wants_to_freeze = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_51_0)
	cat_print("debug", "transition: Request UnFreeze")
	l_51_0._wants_freeze_mode:request(l_51_0.FREEZE_MODES.NORMAL, false)
end

l_0_0.request_unfreeze = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_52_0)
	cat_print("debug", "transition: Request System UI UnFreeze")
	l_52_0._wants_freeze_mode:request(l_52_0.FREEZE_MODES.SYSTEM_UI, false)
end

l_0_0.request_system_ui_unfreeze = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_53_0)
	local l_53_1, l_53_2 = l_53_0._wants_freeze_mode:wants_disabled_state, l_53_0._wants_freeze_mode
	return l_53_1(l_53_2)
end

l_0_0.wants_to_unfreeze = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_54_0)
	assert(not Application:editor(), "It is illegal to request exec() when in editor")
	l_54_0._wants_to_exec = true
end

l_0_0.request_exec = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_55_0)
	return l_55_0._wants_to_exec
end

l_0_0.wants_to_exec = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_56_0, l_56_1)
	l_56_0._cutscene_id = l_56_1
	l_56_0:request_cutscene_pause()
end

l_0_0.request_cutscene = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_57_0)
	return l_57_0._cutscene_id ~= nil
end

l_0_0.wants_to_show_cutscene = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_58_0)
	return l_58_0._cutscene_id
end

l_0_0.cutscene_id = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_59_0)
	l_59_0._cutscene_id = nil
end

l_0_0.clear_wants_to_show_cutscene = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_60_0)
	l_60_0._should_cycle_levels = true
end

l_0_0.set_should_cycle_levels = l_0_1
l_0_0 = GameTransition
l_0_1 = function(l_61_0)
	return l_61_0._should_cycle_levels
end

l_0_0.should_cycle_levels = l_0_1

