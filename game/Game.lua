require("shared/FiniteStateMachine")
require("game/GameStates")
require("game/states/GameStateUnFrozen")
Game = Game or class()
function Game.init(A0_0, A1_1)
	local L2_2
	A0_0._profile_loaded = false
	L2_2 = _G
	L2_2 = L2_2[A1_1.start_state]
	A0_0._state = FiniteStateMachine:new(A0_0, "game", L2_2)
	assert(A0_0._state)
	A0_0._state:set_debug(true)
	A0_0._freeze_state = FiniteStateMachine:new(A0_0, "game", GameStateUnFrozen)
	A0_0._freeze_state:set_debug(true)
	A0_0:_set_default_frontend_type()
	A0_0._wants_to_pause_sounds = MultiStateRequest:new()
	A0_0._sounds_paused = false
end
function Game.default_data(A0_3)
	local L1_4
	A0_3.start_state = "GameStateInit"
end
function Game._set_default_frontend_type(A0_5)
	local L1_6
	if Application:editor() then
		L1_6 = "editor"
	else
		L1_6 = "menu"
	end
	A0_5:_set_menu_frontend_type(L1_6)
end
function Game.save(A0_7, A1_8)
	A1_8.start_state = A0_7._state:_debug_state_name()
end
function Game.update(A0_9, A1_10)
	assert(A0_9._state)
	A0_9._freeze_state:update(A1_10)
	A0_9._state:update(A1_10)
end
function Game._set_is_in_session(A0_11, A1_12)
	A0_11._is_in_session = A1_12
end
function Game.is_in_session(A0_13)
	local L1_14
	L1_14 = A0_13._is_in_session
	return L1_14
end
function Game.is_in_game(A0_15)
	local L1_16
	L1_16 = A0_15._is_in_game
	return L1_16
end
function Game.is_in_frontend(A0_17)
	local L1_18
	L1_18 = A0_17._is_in_frontend
	return L1_18
end
function Game.is_in_pre_frontend(A0_19)
	local L1_20
	L1_20 = A0_19._is_in_pre_frontend
	return L1_20
end
function Game.is_profile_loaded(A0_21)
	local L1_22
	L1_22 = A0_21._profile_loaded
	return L1_22
end
function Game.is_paused(A0_23)
	local L1_24
	L1_24 = A0_23._is_paused
	return L1_24
end
function Game.is_pausing(A0_25)
	local L1_26
	L1_26 = A0_25._is_pausing
	return L1_26
end
function Game.is_resuming(A0_27)
	local L1_28
	L1_28 = A0_27._is_resuming
	return L1_28
end
function Game.is_end_of_misson(A0_29)
	local L1_30
	L1_30 = A0_29._is_end_of_mission
	return L1_30
end
function Game.level_name(A0_31)
	local L1_32
	L1_32 = A0_31._level_name
	return L1_32
end
function Game.is_in_editor(A0_33)
	local L1_34
	L1_34 = A0_33._is_in_editor
	return L1_34
end
function Game.is_frozen(A0_35)
	local L1_36
	L1_36 = A0_35._is_frozen
	return L1_36
end
function Game._request_menu_sync_start(A0_37, A1_38)
	assert(not A0_37._menu_sync_start)
	A0_37._menu_sync_start = true
	A0_37._menu_sync_type = A1_38
end
function Game._clear_request_menu_sync_start(A0_39)
	local L1_40
	A0_39._menu_sync_start = nil
end
function Game.requested_menu_sync_start(A0_41)
	local L1_42
	L1_42 = A0_41._menu_sync_start
	return L1_42
end
function Game.requested_menu_sync_type(A0_43)
	local L1_44
	L1_44 = A0_43._menu_sync_type
	return L1_44
end
function Game._request_menu_ingame(A0_45)
	local L1_46
	A0_45._menu_ingame_requested = true
end
function Game._clear_request_menu_ingame(A0_47)
	local L1_48
	A0_47._menu_ingame_requested = nil
end
function Game.menu_ingame_requested(A0_49)
	local L1_50
	L1_50 = A0_49._menu_ingame_requested
	return L1_50
end
function Game._request_menu_frontend(A0_51)
	local L1_52
	A0_51._menu_frontend_requested = true
end
function Game._clear_request_menu_frontend(A0_53)
	local L1_54
	A0_53._menu_frontend_requested = nil
end
function Game.menu_frontend_requested(A0_55)
	local L1_56
	L1_56 = A0_55._menu_frontend_requested
	return L1_56
end
function Game._set_menu_frontend_type(A0_57, A1_58)
	A0_57._menu_frontend_type = A1_58
end
function Game.menu_frontend_type(A0_59)
	local L1_60
	L1_60 = A0_59._menu_frontend_type
	return L1_60
end
function Game._request_show_menu_ingame(A0_61)
	local L1_62
	A0_61._show_menu_ingame_requested = true
end
function Game._clear_request_show_menu_ingame(A0_63)
	local L1_64
	A0_63._show_menu_ingame_requested = nil
end
function Game.show_menu_ingame_requested(A0_65)
	local L1_66
	L1_66 = A0_65._show_menu_ingame_requested
	return L1_66
end
function Game._request_show_menu_frontend(A0_67)
	local L1_68
	A0_67._show_menu_frontend_requested = true
end
function Game._clear_request_show_menu_frontend(A0_69)
	local L1_70
	A0_69._show_menu_frontend_requested = nil
end
function Game.show_menu_frontend_requested(A0_71)
	local L1_72
	L1_72 = A0_71._show_menu_frontend_requested
	return L1_72
end
function Game.is_loading_done(A0_73)
	local L1_74
	L1_74 = A0_73._is_loading_done
	return L1_74
end
Game.PAUSE_SOUNDS_MODES = {PAUSE = 1, FREEZE = 2}
function Game.request_pause_sounds(A0_75)
	A0_75._wants_to_pause_sounds:request(A0_75.PAUSE_SOUNDS_MODES.PAUSE, true)
	A0_75:_update_sound_paused_state()
end
function Game.request_freeze_sounds(A0_76)
	A0_76._wants_to_pause_sounds:request(A0_76.PAUSE_SOUNDS_MODES.FREEZE, true)
	A0_76:_update_sound_paused_state()
end
function Game.request_unpause_sounds(A0_77)
	A0_77._wants_to_pause_sounds:request(A0_77.PAUSE_SOUNDS_MODES.PAUSE, false)
	A0_77:_update_sound_paused_state()
end
function Game.request_unfreeze_sounds(A0_78)
	A0_78._wants_to_pause_sounds:request(A0_78.PAUSE_SOUNDS_MODES.FREEZE, false)
	A0_78:_update_sound_paused_state()
end
function Game._update_sound_paused_state(A0_79)
	if not A0_79._sounds_paused and A0_79._wants_to_pause_sounds:wants_enabled_state() then
		managers.music2:pause()
		managers.volume:set_paused(true)
		managers.synced_sound:set_paused(true)
		A0_79._sounds_paused = true
	elseif A0_79._sounds_paused and A0_79._wants_to_pause_sounds:wants_disabled_state() then
		managers.music2:resume()
		managers.volume:set_paused(false)
		managers.synced_sound:set_paused(false)
		A0_79._sounds_paused = false
	end
end
