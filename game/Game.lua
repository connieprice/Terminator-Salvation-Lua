require("shared/FiniteStateMachine")
require("game/GameStates")
require("game/states/GameStateUnFrozen")
if not Game then
	Game = class()
end
Game.init = function(l_1_0, l_1_1)
	l_1_0._profile_loaded = false
	local l_1_2 = _G[l_1_1.start_state]
	l_1_0._state = FiniteStateMachine:new(l_1_0, "game", l_1_2)
	assert(l_1_0._state)
	l_1_0._state:set_debug(true)
	l_1_0._freeze_state = FiniteStateMachine:new(l_1_0, "game", GameStateUnFrozen)
	l_1_0._freeze_state:set_debug(true)
	l_1_0:_set_default_frontend_type()
	l_1_0._wants_to_pause_sounds = MultiStateRequest:new()
	l_1_0._sounds_paused = false
end

Game.default_data = function(l_2_0)
	l_2_0.start_state = "GameStateInit"
end

Game._set_default_frontend_type = function(l_3_0)
	local l_3_1 = nil
	if Application:editor() then
		l_3_1 = "editor"
	else
		l_3_1 = "menu"
	end
	l_3_0:_set_menu_frontend_type(l_3_1)
end

Game.save = function(l_4_0, l_4_1)
	l_4_1.start_state = l_4_0._state:_debug_state_name()
end

Game.update = function(l_5_0, l_5_1)
	assert(l_5_0._state)
	l_5_0._freeze_state:update(l_5_1)
	l_5_0._state:update(l_5_1)
end

Game._set_is_in_session = function(l_6_0, l_6_1)
	l_6_0._is_in_session = l_6_1
end

Game.is_in_session = function(l_7_0)
	return l_7_0._is_in_session
end

Game.is_in_game = function(l_8_0)
	return l_8_0._is_in_game
end

Game.is_in_frontend = function(l_9_0)
	return l_9_0._is_in_frontend
end

Game.is_in_pre_frontend = function(l_10_0)
	return l_10_0._is_in_pre_frontend
end

Game.is_profile_loaded = function(l_11_0)
	return l_11_0._profile_loaded
end

Game.is_paused = function(l_12_0)
	return l_12_0._is_paused
end

Game.is_pausing = function(l_13_0)
	return l_13_0._is_pausing
end

Game.is_resuming = function(l_14_0)
	return l_14_0._is_resuming
end

Game.is_end_of_misson = function(l_15_0)
	return l_15_0._is_end_of_mission
end

Game.level_name = function(l_16_0)
	return l_16_0._level_name
end

Game.is_in_editor = function(l_17_0)
	return l_17_0._is_in_editor
end

Game.is_frozen = function(l_18_0)
	return l_18_0._is_frozen
end

Game._request_menu_sync_start = function(l_19_0, l_19_1)
	assert(not l_19_0._menu_sync_start)
	l_19_0._menu_sync_start = true
	l_19_0._menu_sync_type = l_19_1
end

Game._clear_request_menu_sync_start = function(l_20_0)
	l_20_0._menu_sync_start = nil
end

Game.requested_menu_sync_start = function(l_21_0)
	return l_21_0._menu_sync_start
end

Game.requested_menu_sync_type = function(l_22_0)
	return l_22_0._menu_sync_type
end

Game._request_menu_ingame = function(l_23_0)
	l_23_0._menu_ingame_requested = true
end

Game._clear_request_menu_ingame = function(l_24_0)
	l_24_0._menu_ingame_requested = nil
end

Game.menu_ingame_requested = function(l_25_0)
	return l_25_0._menu_ingame_requested
end

Game._request_menu_frontend = function(l_26_0)
	l_26_0._menu_frontend_requested = true
end

Game._clear_request_menu_frontend = function(l_27_0)
	l_27_0._menu_frontend_requested = nil
end

Game.menu_frontend_requested = function(l_28_0)
	return l_28_0._menu_frontend_requested
end

Game._set_menu_frontend_type = function(l_29_0, l_29_1)
	l_29_0._menu_frontend_type = l_29_1
end

Game.menu_frontend_type = function(l_30_0)
	return l_30_0._menu_frontend_type
end

Game._request_show_menu_ingame = function(l_31_0)
	l_31_0._show_menu_ingame_requested = true
end

Game._clear_request_show_menu_ingame = function(l_32_0)
	l_32_0._show_menu_ingame_requested = nil
end

Game.show_menu_ingame_requested = function(l_33_0)
	return l_33_0._show_menu_ingame_requested
end

Game._request_show_menu_frontend = function(l_34_0)
	l_34_0._show_menu_frontend_requested = true
end

Game._clear_request_show_menu_frontend = function(l_35_0)
	l_35_0._show_menu_frontend_requested = nil
end

Game.show_menu_frontend_requested = function(l_36_0)
	return l_36_0._show_menu_frontend_requested
end

Game.is_loading_done = function(l_37_0)
	return l_37_0._is_loading_done
end

local l_0_0 = Game
local l_0_1 = {}
l_0_1.PAUSE = 1
l_0_1.FREEZE = 2
l_0_0.PAUSE_SOUNDS_MODES = l_0_1
l_0_0 = Game
l_0_1 = function(l_38_0)
	l_38_0._wants_to_pause_sounds:request(l_38_0.PAUSE_SOUNDS_MODES.PAUSE, true)
	l_38_0:_update_sound_paused_state()
end

l_0_0.request_pause_sounds = l_0_1
l_0_0 = Game
l_0_1 = function(l_39_0)
	l_39_0._wants_to_pause_sounds:request(l_39_0.PAUSE_SOUNDS_MODES.FREEZE, true)
	l_39_0:_update_sound_paused_state()
end

l_0_0.request_freeze_sounds = l_0_1
l_0_0 = Game
l_0_1 = function(l_40_0)
	l_40_0._wants_to_pause_sounds:request(l_40_0.PAUSE_SOUNDS_MODES.PAUSE, false)
	l_40_0:_update_sound_paused_state()
end

l_0_0.request_unpause_sounds = l_0_1
l_0_0 = Game
l_0_1 = function(l_41_0)
	l_41_0._wants_to_pause_sounds:request(l_41_0.PAUSE_SOUNDS_MODES.FREEZE, false)
	l_41_0:_update_sound_paused_state()
end

l_0_0.request_unfreeze_sounds = l_0_1
l_0_0 = Game
l_0_1 = function(l_42_0)
	if not l_42_0._sounds_paused and l_42_0._wants_to_pause_sounds:wants_enabled_state() then
		managers.music2:pause()
		managers.volume:set_paused(true)
		managers.synced_sound:set_paused(true)
		l_42_0._sounds_paused = true
	elseif l_42_0._sounds_paused and l_42_0._wants_to_pause_sounds:wants_disabled_state() then
		managers.music2:resume()
		managers.volume:set_paused(false)
		managers.synced_sound:set_paused(false)
		l_42_0._sounds_paused = false
	end
end

l_0_0._update_sound_paused_state = l_0_1

