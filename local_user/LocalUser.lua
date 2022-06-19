require("user/User")
require("local_user/storage/PortableLocalUserStorage")
require("local_user/signin/PortableLocalUserSignIn")
require("local_user/activity_tracker/PortableLocalUserActivityTracker")
require("local_user/activity_tracker/LocalUserActivityQuery")
require("local_user/LocalUserStats")
if not LocalUser then
	LocalUser = class(User)
end
LocalUser.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	User.init(l_1_0)
	assert(l_1_3)
	assert(l_1_3:get_type())
	l_1_0._controller_wrapper = l_1_3
	l_1_0._controller_index = l_1_4
	l_1_0._wanted_player_slot_id = l_1_1.wanted_player_slot_id
	l_1_0._profile = l_1_1.profile
	l_1_0._storage_id = 0
	l_1_0._stats = LocalUserStats:new()
	l_1_0._is_persistent_profile = l_1_1.persistent_profile
	l_1_0._user_index = l_1_2
	l_1_0._activity_tracker = PortableLocalUserActivityTracker:new(LocalUserActivityQuery:new(l_1_0), l_1_2)
	l_1_0._low_frequency = managers.update_scheduler:add_function(l_1_0.low_frequency_update, "local_user")
	local l_1_5 = 524288
	l_1_0._storage = PortableLocalUserStorage:new(l_1_1.user_storage, l_1_0, l_1_5)
	l_1_0._signin = PortableLocalUserSignIn:new(l_1_1.sign_in, l_1_0)
	l_1_0._settings_defaults = {}
end

LocalUser.default_data = function(l_2_0)
	l_2_0.user_storage = {}
	l_2_0.persistent_profile = true
	PortableLocalUserStorage.default_data(l_2_0.user_storage)
	l_2_0.sign_in = {}
	LocalUserSignIn.default_data(l_2_0.sign_in)
end

LocalUser.save = function(l_3_0, l_3_1)
	l_3_1.wanted_player_slot_id = l_3_0._wanted_player_slot_id
	l_3_1.persistent_profile = l_3_0._is_persistent_profile
	l_3_1.profile = l_3_0:profile()
	l_3_1.user_storage = {}
	l_3_0._storage:save(l_3_1.user_storage)
	l_3_1.sign_in = {}
	l_3_0._signin:save(l_3_1.sign_in)
end

LocalUser.prime_profile = function(l_4_0)
	cat_print("debug", "LocalUser:prime_profile")
	l_4_0._signin:show_sign_in_ui()
	l_4_0:_load_profile()
end

LocalUser.set_profile = function(l_5_0, l_5_1, l_5_2)
	cat_print("debug", "LocalUser:set_profile", l_5_2)
	l_5_0._profile = l_5_1
	l_5_0._is_persistent_profile = l_5_2
	managers.save:profile_loaded(l_5_0._profile)
end

LocalUser.clear_profile = function(l_6_0)
	cat_print("debug", "LocalUser:clear_profile")
	cat_print("bob", "LocalUser:clear_profile")
	l_6_0._profile = nil
end

LocalUser.destroy = function(l_7_0)
	l_7_0._stats:destroy()
	l_7_0._low_frequency:remove()
end

LocalUser.controller_wrapper = function(l_8_0)
	assert(l_8_0._controller_wrapper)
	assert(l_8_0._controller_wrapper:get_type())
	return l_8_0._controller_wrapper
end

LocalUser.set_controller_wrapper = function(l_9_0, l_9_1)
	assert(l_9_1)
	assert(l_9_1:get_type())
	l_9_0._controller_wrapper = l_9_1
end

LocalUser.get_controller_index = function(l_10_0)
	return l_10_0._controller_index
end

LocalUser.update = function(l_11_0, l_11_1)
	l_11_0.super:update(l_11_1)
	l_11_0._storage:update(l_11_1)
	l_11_0._signin:update(l_11_1)
	l_11_0:_push_profile_settings()
	l_11_0._low_frequency:update(l_11_0, l_11_1)
end

LocalUser.low_frequency_update = function(l_12_0, l_12_1)
	l_12_0._activity_tracker:update(l_12_1)
end

LocalUser.profile = function(l_13_0)
	return l_13_0._profile
end

LocalUser.set_want_to_skip_sign_in = function(l_14_0)
	l_14_0._storage:_set_want_to_skip_sign_in()
end

LocalUser.set_storage_changed = function(l_15_0, l_15_1)
	l_15_0._storage:set_storage_changed(l_15_1)
end

LocalUser.is_storage_selected = function(l_16_0)
	if l_16_0._storage then
		local l_16_1, l_16_2 = l_16_0._storage:is_storage_selected, l_16_0._storage
		return l_16_1(l_16_2)
	else
		return false
	end
end

LocalUser.is_profile_ready = function(l_17_0)
	return l_17_0._profile ~= nil
end

LocalUser._load_profile = function(l_18_0)
	local l_18_1, l_18_2 = l_18_0._storage:load_data, l_18_0._storage
	local l_18_3 = 0
	return l_18_1(l_18_2, l_18_3)
end

LocalUser.save_profile = function(l_19_0)
	if not l_19_0._is_persistent_profile then
		return 
	end
	assert(l_19_0._profile)
	local l_19_1, l_19_2 = l_19_0._storage:save_data, l_19_0._storage
	local l_19_3 = 0
	local l_19_4 = l_19_0._profile
	return l_19_1(l_19_2, l_19_3, l_19_4)
end

LocalUser.set_assigned_unit = function(l_20_0, l_20_1)
	l_20_0.super.set_assigned_unit(l_20_0, l_20_1)
	l_20_0:control_unit(l_20_1)
	if l_20_0:profile() then
		l_20_0._stats:set_assigned_unit_and_stats(l_20_1, l_20_0:profile().stats)
	end
end

LocalUser.control_unit = function(l_21_0, l_21_1)
	local l_21_2 = l_21_0:profile()
	local l_21_3 = l_21_1:difficulty_level()
	if alive(l_21_0._controlled_unit) then
		l_21_0._controlled_unit:control():set_no_control()
	if l_21_3 then
		end
		l_21_3:set_difficulty_level(nil)
	end
	l_21_0._controlled_unit = l_21_1
	l_21_0._controlled_unit:control():set_user_controlled(l_21_0._controller_wrapper)
	if l_21_3 then
		l_21_3:set_difficulty_level(l_21_2.difficulty_level)
	end
	assert(l_21_3, "Controlled units must have difficulty level extension")
end

LocalUser.has_controller_with_rumble = function(l_22_0)
	return l_22_0:controller_wrapper():get_controller().rumble ~= nil
end

LocalUser.turn_on_rumble = function(l_23_0)
	if l_23_0:has_controller_with_rumble() then
		l_23_0._rumble_listener_id = managers.rumble:create_listener(l_23_0:controller_wrapper():get_controller())
	end
end

LocalUser.turn_off_rumble = function(l_24_0)
	if l_24_0._rumble_listener_id then
		managers.rumble:destroy_listener(l_24_0._rumble_listener_id)
		l_24_0._rumble_listener_id = nil
	end
end

LocalUser.is_rumble_on = function(l_25_0)
	return l_25_0._rumble_listener_id ~= nil
end

LocalUser.set_rumble_listener_transform = function(l_26_0, l_26_1, l_26_2)
	if l_26_0._rumble_listener_id then
		managers.rumble:set_listener_position(l_26_0._rumble_listener_id, l_26_1)
		managers.rumble:set_listener_rotation(l_26_0._rumble_listener_id, l_26_2)
	end
end

LocalUser.set_wants_to_init = function(l_27_0)
	cat_print("debug", "Initialize storage!")
	l_27_0._storage:set_wants_to_init()
end

LocalUser.user_signed_in = function(l_28_0)
	if l_28_0:is_playing_the_game() then
		cat_print("debug", "User" .. l_28_0._user_index .. " signed in while playing the game")
		managers.game_transition:request_pre_frontend(true)
	else
		cat_print("debug", "User signed in! (ignored because user wasn't playing)")
		if l_28_0:is_profile_ready() then
			cat_print("debug", "...profile is ready!")
		else
			cat_print("debug", "...profile is ready!")
		end
		if l_28_0:wants_to_play() then
			cat_print("debug", "...wants to play")
		end
	else
		cat_print("debug", "...do not wants to play")
	end
	l_28_0._storage:user_signed_in()
end

LocalUser.user_signed_out = function(l_29_0)
	if l_29_0:wants_to_play() then
		cat_print("debug", "User" .. l_29_0._user_index .. " signed out while playing the game")
		managers.game_transition:request_pre_frontend(true)
	end
	l_29_0._storage:user_signed_out()
end

LocalUser.clear_user_canceled_sign_in = function(l_30_0)
	l_30_0._storage:_clear_want_to_skip_sign_in()
end

LocalUser.user_canceled_sign_in = function(l_31_0)
	cat_print("debug", "LocalUser:user_canceled_sign_in")
	l_31_0._storage:_set_want_to_skip_sign_in()
end

LocalUser.select_storage_device = function(l_32_0)
	l_32_0._storage:request_wants_to_select_storage_for_saving()
end

LocalUser.storage_device_changed = function(l_33_0)
	local l_33_1 = Application:current_storage_device_id(l_33_0._user_index)
	cat_print("debug", "Storage Device Changed. User0" .. l_33_0._user_index .. " device_id:" .. l_33_1)
	if l_33_1 == 0 then
		l_33_0._storage:set_storage_device_lost()
	end
end

LocalUser._push_profile_settings = function(l_34_0)
	if not l_34_0:is_profile_ready() then
		return 
	end
	local l_34_1 = l_34_0:profile()
	if not l_34_1.control_settings then
		return 
	end
	if l_34_1.control_settings.rumble then
		local l_34_2, l_34_3, l_34_4 = alive(l_34_0._controlled_unit)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_34_0:is_rumble_on() ~= l_34_2 then
		if l_34_1.control_settings.rumble then
			l_34_0:turn_on_rumble()
		end
	else
		l_34_0:turn_off_rumble()
	end
	if alive(l_34_0._controlled_unit) then
		local l_34_5 = nil
	if l_34_0._controlled_unit:player_data() then
		end
		l_34_0._controlled_unit:player_data().invert_y = l_34_1.control_settings.invert_y
		l_34_0._controlled_unit:player_data().sensitivity = l_34_1.control_settings.sensitivity
	end
end

LocalUser.user_index = function(l_35_0)
	return l_35_0._user_index
end

LocalUser.set_wanted_player_slot_id = function(l_36_0, l_36_1)
	l_36_0._wanted_player_slot_id = l_36_1
end

LocalUser.clear_wanted_slot_id = function(l_37_0)
	l_37_0._wanted_player_slot_id = nil
end

LocalUser.wants_to_play = function(l_38_0)
	return l_38_0._wanted_player_slot_id ~= nil
end

LocalUser.wanted_player_slot_id = function(l_39_0)
	return l_39_0._wanted_player_slot_id
end

LocalUser.is_playing_the_game = function(l_40_0)
	if l_40_0:is_profile_ready() then
		return l_40_0:wants_to_play()
	end
end

LocalUser.is_signed_in = function(l_41_0)
	local l_41_1, l_41_2 = l_41_0._signin:is_signed_in, l_41_0._signin
	return l_41_1(l_41_2)
end

LocalUser.save_disabled = function(l_42_0)
	local l_42_1, l_42_2 = l_42_0._storage:save_disabled, l_42_0._storage
	return l_42_1(l_42_2)
end

LocalUser.settings_defaults = function(l_43_0)
	return l_43_0._settings_defaults
end

LocalUser.sign_in_may_have_changed = function(l_44_0, l_44_1)
	l_44_0._signin:sign_in_may_have_changed(l_44_1)
end

LocalUser.set_controller_disconnected = function(l_45_0, l_45_1)
	l_45_0._controller_disconnected = l_45_1
end

LocalUser.controller_disconnected = function(l_46_0)
	return l_46_0._controller_disconnected or false
end

LocalUser.debug_join = function(l_47_0)
	l_47_0._signin:set_ignore_sign_in_ui()
	l_47_0._storage._state:_set_state(LocalUserStorageStateDebugJoin)
end


