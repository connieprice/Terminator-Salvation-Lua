require("managers/WorldManager")
require("shared/TableAlgorithms")
require("shared/MultiStateRequest")
GameTransition = GameTransition or class()
function GameTransition.init(A0_0, A1_1)
	TableAlgorithms.merge_except_functions(A0_0, A1_1)
	A0_0._wants_to_exec = false
	A0_0._wants_freeze_mode = MultiStateRequest:new()
	A0_0._wants_pause_mode = MultiStateRequest:new()
end
function GameTransition.default_data(A0_2, A1_3)
	A1_3 = {}
end
function GameTransition.save(A0_4, A1_5)
	TableAlgorithms.merge_except_functions(A1_5, A0_4)
end
function GameTransition.clear_wants_to_host(A0_6)
	local L1_7
	A0_6._wants_to_host = false
	A0_6._player_slot_count_needed_to_host = nil
end
function GameTransition.set_wants_to_host(A0_8, A1_9)
	A0_8._wants_to_host = true
	A0_8._player_slot_count_needed_to_host = A1_9
end
function GameTransition.slot_count_needed_to_host(A0_10)
	local L1_11
	L1_11 = A0_10._player_slot_count_needed_to_host
	return L1_11
end
function GameTransition.host_game(A0_12)
	managers.network:start_hosting()
	A0_12._session_to_join = Network:self()
end
function GameTransition.wants_to_host_session(A0_13)
	local L1_14
	L1_14 = A0_13._wants_to_host
	return L1_14
end
function GameTransition.wants_to_join_session(A0_15)
	return A0_15._session_to_join ~= nil
end
function GameTransition.clear_session_to_join(A0_16)
	local L1_17
	A0_16._session_to_join = nil
end
function GameTransition.set_ignore_level_load(A0_18, A1_19, A2_20)
	A0_18._ignore_level_load = A1_19
	assert(A2_20)
	managers.save:set_level_data_to_profiles(nil, A2_20, "editor_level_do_not_join", false)
end
function GameTransition.ignore_level_load(A0_21)
	local L1_22
	L1_22 = A0_21._ignore_level_load
	return L1_22
end
function GameTransition.request_load(A0_23, A1_24, A2_25)
	cat_print("debug", "request_load(" .. A1_24 .. ", " .. tostring(A2_25))
	A0_23._level_name = A1_24
	assert(A2_25)
	A0_23:set_checkpoint_index(A2_25)
end
function GameTransition.wants_to_load(A0_26)
	return A0_26._level_name ~= nil
end
function GameTransition.clear_wants_to_load(A0_27)
	local L1_28
	A0_27._level_name = nil
end
function GameTransition.level_name(A0_29)
	local L1_30
	L1_30 = A0_29._level_name
	return L1_30
end
function GameTransition.set_checkpoint_index(A0_31, A1_32)
	A0_31._checkpoint_index = A1_32
end
function GameTransition.checkpoint_index(A0_33)
	local L1_34
	L1_34 = A0_33._checkpoint_index
	return L1_34
end
function GameTransition.session_to_join(A0_35)
	assert(A0_35._session_to_join)
	return A0_35._session_to_join
end
function GameTransition.exec_game_from_menu(A0_36)
	Global.show_intro_credits = true
	assert(managers.network:host():session_provider():level_name())
end
function GameTransition.exec_game_from_game(A0_37)
	Global.show_intro_credits = false
	A0_37._wants_to_clear_world = true
	A0_37._wants_to_quit_session = true
	A0_37._wants_to_go_to_frontend = false
	A0_37:clear_game_over()
	A0_37:set_wants_to_host(A0_37:slot_count_needed_to_host())
end
function GameTransition.exec_menu(A0_38)
	Global.zone_data = {}
	Global.zone_data.skip_intro_movies = true
	Global.zone_data.skip_start_menu = true
	A0_38._wants_to_quit_session = true
	A0_38._wants_to_go_to_frontend = true
	A0_38:clear_session_to_join()
	A0_38:clear_wants_to_host()
end
function GameTransition.set_wants_to_go_to_frontend(A0_39)
	local L1_40
	A0_39._wants_to_go_to_frontend = true
end
function GameTransition.wants_to_go_to_frontend(A0_41)
	local L1_42
	L1_42 = A0_41._wants_to_go_to_frontend
	return L1_42
end
function GameTransition.clear_wants_to_go_to_frontend(A0_43)
	local L1_44
	A0_43._wants_to_go_to_frontend = nil
end
function GameTransition.wants_to_quit_session(A0_45)
	local L1_46
	L1_46 = A0_45._wants_to_quit_session
	return L1_46
end
function GameTransition.clear_wants_to_quit_session(A0_47)
	local L1_48
	A0_47._wants_to_quit_session = nil
end
function GameTransition.exec_end_of_mission(A0_49)
	local L1_50
	A0_49._reached_end_of_mission = true
end
function GameTransition.reached_end_of_mission(A0_51)
	local L1_52
	L1_52 = A0_51._reached_end_of_mission
	return L1_52
end
function GameTransition.clear_reached_end_of_mission(A0_53)
	local L1_54
	A0_53._reached_end_of_mission = nil
end
function GameTransition.exec_end_of_game(A0_55)
	A0_55:exec_menu()
	Global.zone_data.show_end_credits = true
end
function GameTransition.clear_game_over(A0_56)
	local L1_57
	A0_56._game_over = false
end
function GameTransition.game_over(A0_58)
	local L1_59
	A0_58._game_over = true
end
function GameTransition.is_game_over(A0_60)
	local L1_61
	L1_61 = A0_60._game_over
	return L1_61
end
function GameTransition.should_pass_through_menu(A0_62)
	local L1_63
	L1_63 = A0_62._pass_through_menu
	return L1_63
end
function GameTransition.set_should_pass_through_menu(A0_64)
	local L1_65
	A0_64._pass_through_menu = true
end
function GameTransition.request_pre_frontend(A0_66, A1_67)
	A0_66._wants_to_go_to_pre_frontend = true
	A0_66._wants_to_go_to_pre_frontend_due_to_sign_out = A1_67
end
function GameTransition.pre_frontend_due_to_sign_out(A0_68)
	local L1_69
	L1_69 = A0_68._wants_to_go_to_pre_frontend_due_to_sign_out
	return L1_69
end
function GameTransition.clear_pre_frontend_due_to_sign_out(A0_70)
	local L1_71
	A0_70._wants_to_go_to_pre_frontend_due_to_sign_out = nil
end
function GameTransition.wants_to_go_to_pre_frontend(A0_72)
	local L1_73
	L1_73 = A0_72._wants_to_go_to_pre_frontend
	return L1_73
end
function GameTransition.clear_wants_to_go_to_pre_frontend(A0_74)
	local L1_75
	A0_74._wants_to_go_to_pre_frontend = nil
end
GameTransition.PAUSE_MODES = {NORMAL = 1, CUTSCENE = 2}
function GameTransition.request_pause(A0_76)
	cat_print("debug", "transition: Request Pause")
	A0_76._wants_pause_mode:request(A0_76.PAUSE_MODES.NORMAL, true)
end
function GameTransition.request_cutscene_pause(A0_77)
	cat_print("debug", "transition: Request Cutscene Pause")
	A0_77._wants_pause_mode:request(A0_77.PAUSE_MODES.CUTSCENE, true)
end
function GameTransition.wants_to_pause(A0_78)
	return A0_78._wants_pause_mode:wants_enabled_state()
end
function GameTransition.request_unpause(A0_79)
	cat_print("debug", "transition: Request UnPause")
	A0_79._wants_pause_mode:request(A0_79.PAUSE_MODES.NORMAL, false)
end
function GameTransition.request_cutscene_unpause(A0_80)
	cat_print("debug", "transition: Request Cutscene UnPause")
	A0_80._wants_pause_mode:request(A0_80.PAUSE_MODES.CUTSCENE, false)
end
function GameTransition.wants_to_unpause(A0_81)
	return A0_81._wants_pause_mode:wants_disabled_state()
end
GameTransition.FREEZE_MODES = {NORMAL = 1, SYSTEM_UI = 2}
function GameTransition.request_freeze(A0_82)
	cat_print("debug", "transition: Request Freeze")
	A0_82._wants_freeze_mode:request(A0_82.FREEZE_MODES.NORMAL, true)
end
function GameTransition.request_system_ui_freeze(A0_83)
	cat_print("debug", "transition: Request System UI Freeze")
	A0_83._wants_freeze_mode:request(A0_83.FREEZE_MODES.SYSTEM_UI, true)
end
function GameTransition.wants_to_freeze(A0_84)
	return A0_84._wants_freeze_mode:wants_enabled_state()
end
function GameTransition.request_unfreeze(A0_85)
	cat_print("debug", "transition: Request UnFreeze")
	A0_85._wants_freeze_mode:request(A0_85.FREEZE_MODES.NORMAL, false)
end
function GameTransition.request_system_ui_unfreeze(A0_86)
	cat_print("debug", "transition: Request System UI UnFreeze")
	A0_86._wants_freeze_mode:request(A0_86.FREEZE_MODES.SYSTEM_UI, false)
end
function GameTransition.wants_to_unfreeze(A0_87)
	return A0_87._wants_freeze_mode:wants_disabled_state()
end
function GameTransition.request_exec(A0_88)
	assert(not Application:editor(), "It is illegal to request exec() when in editor")
	A0_88._wants_to_exec = true
end
function GameTransition.wants_to_exec(A0_89)
	local L1_90
	L1_90 = A0_89._wants_to_exec
	return L1_90
end
function GameTransition.request_cutscene(A0_91, A1_92)
	A0_91._cutscene_id = A1_92
	A0_91:request_cutscene_pause()
end
function GameTransition.wants_to_show_cutscene(A0_93)
	return A0_93._cutscene_id ~= nil
end
function GameTransition.cutscene_id(A0_94)
	local L1_95
	L1_95 = A0_94._cutscene_id
	return L1_95
end
function GameTransition.clear_wants_to_show_cutscene(A0_96)
	local L1_97
	A0_96._cutscene_id = nil
end
function GameTransition.set_should_cycle_levels(A0_98)
	local L1_99
	A0_98._should_cycle_levels = true
end
function GameTransition.should_cycle_levels(A0_100)
	local L1_101
	L1_101 = A0_100._should_cycle_levels
	return L1_101
end
