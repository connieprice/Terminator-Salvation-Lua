require("shared/FiniteStateMachine")
require("shared/TableAlgorithms")
require("local_user/storage/LocalUserStorageStates")
if not LocalUserStorage then
	LocalUserStorage = class()
end
LocalUserStorage.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._user_index = l_1_2:user_index()
	l_1_0._max_save_game_size = l_1_3
	l_1_0._callback_user = l_1_2
	local l_1_4 = _G[l_1_1.start_state]
	l_1_0._state = FiniteStateMachine:new(l_1_0, "storage", l_1_4)
	l_1_0._user_is_signed_in = l_1_1.user_is_signed_in
	l_1_0._device_id = l_1_1.device_id
	l_1_0._storage_device_is_lost = l_1_1.storage_device_is_lost
	l_1_0._user_has_signed_out = l_1_1.user_has_signed_out
	l_1_0._last_saved_device_id = l_1_1.last_saved_device_id
	l_1_0._state:set_debug(true)
	l_1_0._no_saving = false
end

LocalUserStorage.default_data = function(l_2_0)
	l_2_0.start_state = "LocalUserStorageStateInit"
	l_2_0.device_id = nil
	l_2_0.storage_device_is_lost = nil
end

LocalUserStorage.save = function(l_3_0, l_3_1)
	l_3_1.start_state = l_3_0._state:_debug_state_name()
	l_3_1.user_is_signed_in = l_3_0._user_is_signed_in
	l_3_1.storage_device_is_lost = l_3_0._storage_device_is_lost
	l_3_1.user_has_signed_out = l_3_0._user_has_signed_out
	l_3_1.last_saved_device_id = l_3_0._last_saved_device_id
end

LocalUserStorage.user_signed_in = function(l_4_0)
	l_4_0._user_is_signed_in = true
	l_4_0._user_canceled_signin = false
	l_4_0._user_has_signed_in = true
end

LocalUserStorage.user_signed_out = function(l_5_0)
	cat_print("bob", "LocalUserStorage:user_signed_out")
	l_5_0._user_is_signed_in = false
	l_5_0._user_has_signed_out = true
	l_5_0._user_has_signed_in = false
	l_5_0:_clear_wants_to_save()
	l_5_0:_clear_wants_to_load()
end

LocalUserStorage.clear_user_has_signed_out = function(l_6_0)
	l_6_0._user_has_signed_out = nil
end

LocalUserStorage.user_has_signed_out = function(l_7_0)
	return l_7_0._user_has_signed_out ~= nil
end

LocalUserStorage.user_has_signed_in = function(l_8_0)
	return l_8_0._user_has_signed_in
end

LocalUserStorage.clear_user_has_signed_in = function(l_9_0)
	l_9_0._user_has_signed_in = nil
end

LocalUserStorage.user_is_signed_in = function(l_10_0)
	return l_10_0._user_is_signed_in
end

LocalUserStorage.user_is_signed_out = function(l_11_0)
	return l_11_0._user_is_signed_in ~= true
end

LocalUserStorage.save_disabled = function(l_12_0)
	return l_12_0._no_saving
end

LocalUserStorage.open_storage_select = function(l_13_0)
	cat_print("bob", "LocalUserStorage:open_storage_select")
	l_13_0:clear_is_storage_canceled()
end

LocalUserStorage.set_is_storage_selected = function(l_14_0)
	assert(not l_14_0._storage_canceled)
	l_14_0._storage_selected = true
end

LocalUserStorage.is_storage_selected = function(l_15_0)
	return l_15_0._storage_selected
end

LocalUserStorage.clear_is_storage_selected = function(l_16_0)
	l_16_0._storage_selected = nil
end

LocalUserStorage.set_is_storage_canceled = function(l_17_0)
	assert(not l_17_0._storage_selected)
	l_17_0._storage_canceled = true
end

LocalUserStorage.is_storage_canceled = function(l_18_0)
	return l_18_0._storage_canceled
end

LocalUserStorage.clear_is_storage_canceled = function(l_19_0)
	l_19_0._storage_canceled = nil
end

LocalUserStorage.data_exists_on_media = function(l_20_0, l_20_1)
	local l_20_2 = l_20_0:_content_id_to_filename(l_20_1)
	local l_20_3, l_20_4 = Save:exists, Save
	local l_20_5 = l_20_2
	local l_20_6 = l_20_0._user_index
	return l_20_3(l_20_4, l_20_5, l_20_6)
end

LocalUserStorage.new_data = function(l_21_0, l_21_1)
	l_21_0._data = l_21_1
end

LocalUserStorage.update = function(l_22_0, l_22_1)
	l_22_0._state:update(l_22_1)
end

LocalUserStorage.data = function(l_23_0)
	return l_23_0._data
end

LocalUserStorage._common_save_params = function(l_24_0)
	local l_24_1 = {}
	do
		local l_24_2 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		return l_24_1
	end
	 -- WARNING: undefined locals caused missing assignments!
end

LocalUserStorage._exists = function(l_25_0)
	local l_25_1 = (l_25_0:_common_save_params())
	local l_25_2 = nil
	l_25_0._exist_task = NewSave:exists(l_25_1, l_25_2)
end

LocalUserStorage._exists_status = function(l_26_0)
	if not l_26_0._exist_task:has_next() then
		return 
	end
	return l_26_0._exist_task:next()
end

LocalUserStorage._close_exists_task = function(l_27_0)
	l_27_0._exist_task = nil
end

LocalUserStorage._load = function(l_28_0)
	local l_28_1 = (l_28_0:_common_save_params())
	local l_28_2 = nil
	l_28_0._load_task = NewSave:load(l_28_1, l_28_2)
end

LocalUserStorage._load_status = function(l_29_0)
	if not l_29_0._load_task:has_next() then
		return 
	end
	local l_29_1 = l_29_0._load_task:next()
	if l_29_1:status() == SaveData.OK then
		local l_29_4, l_29_5 = l_29_0:_data_loaded, l_29_0
		l_29_4(l_29_5, l_29_1:information())
	end
	local l_29_2, l_29_3 = l_29_1:status, l_29_1
	return l_29_2(l_29_3)
end

LocalUserStorage._close_load_task = function(l_30_0)
	l_30_0._load_task = nil
end

LocalUserStorage.is_loading = function(l_31_0)
	return l_31_0._load_task ~= nil or l_31_0._exist_task ~= nil
end

LocalUserStorage._save = function(l_32_0)
	l_32_0._callback_user:save_profile()
	local l_32_1 = NewSave:create_save_data()
	assert(l_32_0._data_to_save)
	l_32_1:set_information(l_32_0._data_to_save)
	local l_32_2 = (l_32_0:_common_save_params())
	local l_32_3 = nil
	l_32_1:set_title("Terminator Salvation")
	local l_32_4 = l_32_0._data_to_save.current_level_id
	assert(l_32_4)
	local l_32_5 = managers.world_info:info_from_id(l_32_4)
	assert(l_32_5)
	local l_32_6, l_32_7 = l_32_5:get_localized_chapter_names()
	assert(l_32_6)
	assert(l_32_7)
	l_32_1:set_subtitle(l_32_6 .. ": " .. l_32_7)
	l_32_1:set_details("")
	l_32_2.reserved_bytes = l_32_0._max_save_game_size
	if SystemInfo:platform() == "PS3" and l_32_0._save_for_the_first_time then
		cat_print("debug", "* Saving Movie, icon and sound.....")
		l_32_1:set_small_icon_by_path("ps3/SAVEINFOS/ICON0.PNG")
		l_32_2.use_small_icon = true
		l_32_1:set_animation_by_path("ps3/SAVEINFOS/ICON1.PAM")
		l_32_2.use_animation = true
		l_32_1:set_sound_by_path("ps3/SAVEINFOS/SND0.AT3")
		l_32_2.use_sound = true
	end
	local l_32_8 = l_32_0._callback_user:profile().newly_created
	l_32_2.reset_user = l_32_8
	l_32_0._save_succeeded = nil
	l_32_0._save_task = NewSave:save(l_32_1, l_32_2, l_32_3)
end

LocalUserStorage._close_save_task = function(l_33_0)
	l_33_0._save_task = nil
	if l_33_0._save_succeeded then
		l_33_0._callback_user:profile().newly_created = false
	end
end

LocalUserStorage._save_status = function(l_34_0)
	if not l_34_0._save_task:has_next() then
		return 
	end
	local l_34_1 = l_34_0._save_task:next()
	local l_34_2 = l_34_1:status()
	l_34_0._save_succeeded = l_34_2 == SaveData.OK
	if l_34_0._save_succeeded then
		l_34_0._last_saved_device_id = l_34_0._device_id
	end
	return l_34_2
end

LocalUserStorage.is_saving = function(l_35_0)
	return l_35_0._save_task ~= nil
end

LocalUserStorage.save_data = function(l_36_0, l_36_1, l_36_2)
	cat_print("bob", " -- LocalUserStorage:save_data")
	l_36_0._data_to_save = TableAlgorithms.copy(l_36_2)
	l_36_0._content_id_to_save = l_36_1
end

LocalUserStorage.load_data = function(l_37_0, l_37_1)
	l_37_0._content_id_to_load = l_37_1
end

LocalUserStorage.is_data_valid = function(l_38_0)
	return l_38_0._data ~= nil
end

LocalUserStorage._wants_to_load = function(l_39_0)
	return l_39_0._content_id_to_load ~= nil
end

LocalUserStorage._wants_to_save = function(l_40_0)
	return l_40_0._content_id_to_save ~= nil
end

LocalUserStorage._clear_wants_to_save = function(l_41_0)
	l_41_0._content_id_to_save = nil
end

LocalUserStorage._clear_wants_to_load = function(l_42_0)
	l_42_0._content_id_to_load = nil
end

LocalUserStorage._clear_data = function(l_43_0)
	l_43_0._callback_user:clear_profile()
end

LocalUserStorage._data_loaded = function(l_44_0, l_44_1)
	l_44_0._callback_user:set_profile(l_44_1, true)
end

LocalUserStorage.waits_for_retry_loading = function(l_45_0)
	return l_45_0._waits_for_retry_loading
end

LocalUserStorage.request_wants_to_retry_load = function(l_46_0)
	cat_print("debug", "request_wants_to_retry_load")
	l_46_0:load_data(0)
end

LocalUserStorage.set_storage_device_lost = function(l_47_0)
	cat_print("debug", "set_storage_device_lost")
	l_47_0._storage_device_is_lost = true
end

LocalUserStorage.clear_storage_device_lost = function(l_48_0)
	cat_print("debug", "CLEAR storage_device_lost")
	l_48_0._storage_device_is_lost = nil
end

LocalUserStorage.is_storage_device_lost = function(l_49_0)
	return l_49_0._storage_device_is_lost
end

LocalUserStorage.waits_for_storage_lost = function(l_50_0)
	return l_50_0._waits_for_storage_lost
end

LocalUserStorage.request_wants_to_select_storage_after_lost = function(l_51_0)
	cat_print("debug", "request_wants_to_select_storage_after_lost")
	l_51_0._wants_to_select_storage_after_lost = true
end

LocalUserStorage.wants_to_select_storage_after_lost = function(l_52_0)
	return l_52_0._wants_to_select_storage_after_lost
end

LocalUserStorage.clear_wants_to_select_storage_after_lost = function(l_53_0)
	l_53_0._wants_to_select_storage_after_lost = nil
end

LocalUserStorage.waits_for_continue_without_saving = function(l_54_0)
	return l_54_0._waits_for_continue_without_saving
end

LocalUserStorage.request_wants_to_continue_without_saving = function(l_55_0)
	cat_print("debug", "request_wants_to_continue_without_saving")
	l_55_0._wants_to_continue_without_saving = true
end

LocalUserStorage.request_do_not_continue_without_saving = function(l_56_0)
	cat_print("debug", "request_do_not_continue_without_saving")
	l_56_0._do_not_want_to_continue_without_saving = true
end

LocalUserStorage.do_not_want_to_continue_without_saving = function(l_57_0)
	return l_57_0._do_not_want_to_continue_without_saving
end

LocalUserStorage.clear_do_not_want_to_continue_without_saving = function(l_58_0)
	l_58_0._do_not_want_to_continue_without_saving = nil
end

LocalUserStorage.wants_to_continue_without_saving = function(l_59_0)
	return l_59_0._wants_to_continue_without_saving
end

LocalUserStorage.clear_wants_to_continue_without_saving = function(l_60_0)
	l_60_0._wants_to_continue_without_saving = nil
end

LocalUserStorage.waits_for_retry_saving = function(l_61_0)
	return l_61_0._waits_for_retry_saving
end

LocalUserStorage.clear_wants_to_select_storage_for_loading = function(l_62_0)
	l_62_0._wants_to_select_storage_for_loading = nil
end

LocalUserStorage.request_wants_to_select_storage_for_loading = function(l_63_0)
	cat_print("debug", "request_wants_to_select_storage_for_loading")
	l_63_0._wants_to_select_storage_for_loading = true
end

LocalUserStorage.wants_to_select_storage_for_loading = function(l_64_0)
	return l_64_0._wants_to_select_storage_for_loading
end

LocalUserStorage.clear_wants_to_select_storage_for_saving = function(l_65_0)
	l_65_0._wants_to_select_storage_for_saving = nil
end

LocalUserStorage.request_wants_to_select_storage_for_saving = function(l_66_0)
	cat_print("debug", "request_wants_to_select_storage_for_saving")
	l_66_0._wants_to_select_storage_for_saving = true
end

LocalUserStorage.wants_to_select_storage_for_saving = function(l_67_0)
	return l_67_0._wants_to_select_storage_for_saving
end

LocalUserStorage.request_wants_to_retry_save = function(l_68_0)
	cat_print("debug", "request_wants_to_retry_save")
	l_68_0:_save()
end

LocalUserStorage.waits_for_overwrite_confirmation = function(l_69_0)
	return l_69_0._waits_for_overwrite_confirmation
end

LocalUserStorage.request_wants_to_overwrite = function(l_70_0)
	cat_print("debug", "request_wants_to_overwrite")
	l_70_0._wants_to_overwrite = true
end

LocalUserStorage.wants_to_overwrite = function(l_71_0)
	return l_71_0._wants_to_overwrite
end

LocalUserStorage.clear_wants_to_overwrite = function(l_72_0)
	l_72_0._wants_to_overwrite = nil
end

LocalUserStorage._set_want_to_skip_sign_in = function(l_73_0)
	cat_print("debug", "LocalUserStorage:_set_want_to_skip_sign_in")
	l_73_0._want_to_skip_sign_in = true
end

LocalUserStorage._clear_want_to_skip_sign_in = function(l_74_0)
	l_74_0._want_to_skip_sign_in = nil
end

LocalUserStorage.want_to_skip_sign_in = function(l_75_0)
	return l_75_0._want_to_skip_sign_in ~= nil
end

LocalUserStorage.wants_to_init = function(l_76_0)
	return l_76_0._wants_to_init
end

LocalUserStorage.set_wants_to_init = function(l_77_0)
	cat_print("debug", "set_wants_to_init")
	l_77_0._wants_to_init = true
end

LocalUserStorage.clear_wants_to_init = function(l_78_0)
	l_78_0._wants_to_init = nil
end

LocalUserStorage.device_id = function(l_79_0)
	return l_79_0._device_id
end

LocalUserStorage.last_saved_to_device_id = function(l_80_0)
	return l_80_0._last_saved_device_id
end

LocalUserStorage.clear_last_saved_to_device_id = function(l_81_0)
	l_81_0._last_saved_device_id = nil
end

LocalUserStorage.set_storage_dialog_failed = function(l_82_0)
	l_82_0._storage_dialog_failed = true
end

LocalUserStorage.clear_storage_dialog_failed = function(l_83_0)
	l_83_0._storage_dialog_failed = nil
end

LocalUserStorage.did_storage_dialog_fail = function(l_84_0)
	return l_84_0._storage_dialog_failed
end


