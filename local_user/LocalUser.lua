require("user/User")
require("local_user/storage/PortableLocalUserStorage")
require("local_user/signin/PortableLocalUserSignIn")
require("local_user/activity_tracker/PortableLocalUserActivityTracker")
require("local_user/activity_tracker/LocalUserActivityQuery")
require("local_user/LocalUserStats")
LocalUser = LocalUser or class(User)
function LocalUser.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	local L5_5
	L5_5 = User
	L5_5 = L5_5.init
	L5_5(A0_0)
	L5_5 = assert
	L5_5(A3_3)
	L5_5 = assert
	L5_5(A3_3:get_type())
	A0_0._controller_wrapper = A3_3
	A0_0._controller_index = A4_4
	L5_5 = A1_1.wanted_player_slot_id
	A0_0._wanted_player_slot_id = L5_5
	L5_5 = A1_1.profile
	A0_0._profile = L5_5
	A0_0._storage_id = 0
	L5_5 = LocalUserStats
	L5_5 = L5_5.new
	L5_5 = L5_5(L5_5)
	A0_0._stats = L5_5
	L5_5 = A1_1.persistent_profile
	A0_0._is_persistent_profile = L5_5
	A0_0._user_index = A2_2
	L5_5 = PortableLocalUserActivityTracker
	L5_5 = L5_5.new
	L5_5 = L5_5(L5_5, LocalUserActivityQuery:new(A0_0), A2_2)
	A0_0._activity_tracker = L5_5
	L5_5 = managers
	L5_5 = L5_5.update_scheduler
	L5_5 = L5_5.add_function
	L5_5 = L5_5(L5_5, A0_0.low_frequency_update, "local_user")
	A0_0._low_frequency = L5_5
	L5_5 = 524288
	A0_0._storage = PortableLocalUserStorage:new(A1_1.user_storage, A0_0, L5_5)
	A0_0._signin = PortableLocalUserSignIn:new(A1_1.sign_in, A0_0)
	A0_0._settings_defaults = {}
end
function LocalUser.default_data(A0_6)
	A0_6.user_storage = {}
	A0_6.persistent_profile = true
	PortableLocalUserStorage.default_data(A0_6.user_storage)
	A0_6.sign_in = {}
	LocalUserSignIn.default_data(A0_6.sign_in)
end
function LocalUser.save(A0_7, A1_8)
	A1_8.wanted_player_slot_id = A0_7._wanted_player_slot_id
	A1_8.persistent_profile = A0_7._is_persistent_profile
	A1_8.profile = A0_7:profile()
	A1_8.user_storage = {}
	A0_7._storage:save(A1_8.user_storage)
	A1_8.sign_in = {}
	A0_7._signin:save(A1_8.sign_in)
end
function LocalUser.prime_profile(A0_9)
	cat_print("debug", "LocalUser:prime_profile")
	A0_9._signin:show_sign_in_ui()
	A0_9:_load_profile()
end
function LocalUser.set_profile(A0_10, A1_11, A2_12)
	cat_print("debug", "LocalUser:set_profile", A2_12)
	A0_10._profile = A1_11
	A0_10._is_persistent_profile = A2_12
	managers.save:profile_loaded(A0_10._profile)
end
function LocalUser.clear_profile(A0_13)
	cat_print("debug", "LocalUser:clear_profile")
	cat_print("bob", "LocalUser:clear_profile")
	A0_13._profile = nil
end
function LocalUser.destroy(A0_14)
	A0_14._stats:destroy()
	A0_14._low_frequency:remove()
end
function LocalUser.controller_wrapper(A0_15)
	assert(A0_15._controller_wrapper)
	assert(A0_15._controller_wrapper:get_type())
	return A0_15._controller_wrapper
end
function LocalUser.set_controller_wrapper(A0_16, A1_17)
	assert(A1_17)
	assert(A1_17:get_type())
	A0_16._controller_wrapper = A1_17
end
function LocalUser.get_controller_index(A0_18)
	local L1_19
	L1_19 = A0_18._controller_index
	return L1_19
end
function LocalUser.update(A0_20, A1_21)
	A0_20.super:update(A1_21)
	A0_20._storage:update(A1_21)
	A0_20._signin:update(A1_21)
	A0_20:_push_profile_settings()
	A0_20._low_frequency:update(A0_20, A1_21)
end
function LocalUser.low_frequency_update(A0_22, A1_23)
	A0_22._activity_tracker:update(A1_23)
end
function LocalUser.profile(A0_24)
	local L1_25
	L1_25 = A0_24._profile
	return L1_25
end
function LocalUser.set_want_to_skip_sign_in(A0_26)
	A0_26._storage:_set_want_to_skip_sign_in()
end
function LocalUser.set_storage_changed(A0_27, A1_28)
	A0_27._storage:set_storage_changed(A1_28)
end
function LocalUser.is_storage_selected(A0_29)
	if A0_29._storage then
		return A0_29._storage:is_storage_selected()
	else
		return false
	end
end
function LocalUser.is_profile_ready(A0_30)
	return A0_30._profile ~= nil
end
function LocalUser._load_profile(A0_31)
	return A0_31._storage:load_data(0)
end
function LocalUser.save_profile(A0_32)
	if not A0_32._is_persistent_profile then
		return
	end
	assert(A0_32._profile)
	return A0_32._storage:save_data(0, A0_32._profile)
end
function LocalUser.set_assigned_unit(A0_33, A1_34)
	A0_33.super.set_assigned_unit(A0_33, A1_34)
	A0_33:control_unit(A1_34)
	if A0_33:profile() then
		A0_33._stats:set_assigned_unit_and_stats(A1_34, A0_33:profile().stats)
	end
end
function LocalUser.control_unit(A0_35, A1_36)
	local L2_37, L3_38
	L3_38 = A0_35
	L2_37 = A0_35.profile
	L2_37 = L2_37(L3_38)
	L3_38 = A1_36.difficulty_level
	L3_38 = L3_38(A1_36)
	if alive(A0_35._controlled_unit) then
		A0_35._controlled_unit:control():set_no_control()
		if L3_38 then
			L3_38:set_difficulty_level(nil)
		end
	end
	A0_35._controlled_unit = A1_36
	A0_35._controlled_unit:control():set_user_controlled(A0_35._controller_wrapper)
	if L3_38 then
		L3_38:set_difficulty_level(L2_37.difficulty_level)
	end
	assert(L3_38, "Controlled units must have difficulty level extension")
end
function LocalUser.has_controller_with_rumble(A0_39)
	return A0_39:controller_wrapper():get_controller().rumble ~= nil
end
function LocalUser.turn_on_rumble(A0_40)
	if A0_40:has_controller_with_rumble() then
		A0_40._rumble_listener_id = managers.rumble:create_listener(A0_40:controller_wrapper():get_controller())
	end
end
function LocalUser.turn_off_rumble(A0_41)
	if A0_41._rumble_listener_id then
		managers.rumble:destroy_listener(A0_41._rumble_listener_id)
		A0_41._rumble_listener_id = nil
	end
end
function LocalUser.is_rumble_on(A0_42)
	return A0_42._rumble_listener_id ~= nil
end
function LocalUser.set_rumble_listener_transform(A0_43, A1_44, A2_45)
	if A0_43._rumble_listener_id then
		managers.rumble:set_listener_position(A0_43._rumble_listener_id, A1_44)
		managers.rumble:set_listener_rotation(A0_43._rumble_listener_id, A2_45)
	end
end
function LocalUser.set_wants_to_init(A0_46)
	cat_print("debug", "Initialize storage!")
	A0_46._storage:set_wants_to_init()
end
function LocalUser.user_signed_in(A0_47)
	if A0_47:is_playing_the_game() then
		cat_print("debug", "User" .. A0_47._user_index .. " signed in while playing the game")
		managers.game_transition:request_pre_frontend(true)
	else
		cat_print("debug", "User signed in! (ignored because user wasn't playing)")
		if A0_47:is_profile_ready() then
			cat_print("debug", "...profile is ready!")
		else
			cat_print("debug", "...profile is ready!")
		end
		if A0_47:wants_to_play() then
			cat_print("debug", "...wants to play")
		else
			cat_print("debug", "...do not wants to play")
		end
	end
	A0_47._storage:user_signed_in()
end
function LocalUser.user_signed_out(A0_48)
	if A0_48:wants_to_play() then
		cat_print("debug", "User" .. A0_48._user_index .. " signed out while playing the game")
		managers.game_transition:request_pre_frontend(true)
	end
	A0_48._storage:user_signed_out()
end
function LocalUser.clear_user_canceled_sign_in(A0_49)
	A0_49._storage:_clear_want_to_skip_sign_in()
end
function LocalUser.user_canceled_sign_in(A0_50)
	cat_print("debug", "LocalUser:user_canceled_sign_in")
	A0_50._storage:_set_want_to_skip_sign_in()
end
function LocalUser.select_storage_device(A0_51)
	A0_51._storage:request_wants_to_select_storage_for_saving()
end
function LocalUser.storage_device_changed(A0_52)
	local L1_53
	L1_53 = Application
	L1_53 = L1_53.current_storage_device_id
	L1_53 = L1_53(L1_53, A0_52._user_index)
	cat_print("debug", "Storage Device Changed. User0" .. A0_52._user_index .. " device_id:" .. L1_53)
	if L1_53 == 0 then
		A0_52._storage:set_storage_device_lost()
	end
end
function LocalUser._push_profile_settings(A0_54)
	if not A0_54:is_profile_ready() then
		return
	end
	if not A0_54:profile().control_settings then
		return
	end
	if A0_54:is_rumble_on() ~= (A0_54:profile().control_settings.rumble and alive(A0_54._controlled_unit)) then
		if A0_54:profile().control_settings.rumble then
			A0_54:turn_on_rumble()
		else
			A0_54:turn_off_rumble()
		end
	end
	if alive(A0_54._controlled_unit) and A0_54._controlled_unit:player_data() then
		A0_54._controlled_unit:player_data().invert_y = A0_54:profile().control_settings.invert_y
		A0_54._controlled_unit:player_data().sensitivity = A0_54:profile().control_settings.sensitivity
	end
end
function LocalUser.user_index(A0_55)
	local L1_56
	L1_56 = A0_55._user_index
	return L1_56
end
function LocalUser.set_wanted_player_slot_id(A0_57, A1_58)
	A0_57._wanted_player_slot_id = A1_58
end
function LocalUser.clear_wanted_slot_id(A0_59)
	local L1_60
	A0_59._wanted_player_slot_id = nil
end
function LocalUser.wants_to_play(A0_61)
	return A0_61._wanted_player_slot_id ~= nil
end
function LocalUser.wanted_player_slot_id(A0_62)
	local L1_63
	L1_63 = A0_62._wanted_player_slot_id
	return L1_63
end
function LocalUser.is_playing_the_game(A0_64)
	return A0_64:is_profile_ready() and A0_64:wants_to_play()
end
function LocalUser.is_signed_in(A0_65)
	return A0_65._signin:is_signed_in()
end
function LocalUser.save_disabled(A0_66)
	return A0_66._storage:save_disabled()
end
function LocalUser.settings_defaults(A0_67)
	local L1_68
	L1_68 = A0_67._settings_defaults
	return L1_68
end
function LocalUser.sign_in_may_have_changed(A0_69, A1_70)
	A0_69._signin:sign_in_may_have_changed(A1_70)
end
function LocalUser.set_controller_disconnected(A0_71, A1_72)
	A0_71._controller_disconnected = A1_72
end
function LocalUser.controller_disconnected(A0_73)
	return A0_73._controller_disconnected or false
end
function LocalUser.debug_join(A0_74)
	A0_74._signin:set_ignore_sign_in_ui()
	A0_74._storage._state:_set_state(LocalUserStorageStateDebugJoin)
end
