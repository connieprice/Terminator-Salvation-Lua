require("shared/FiniteStateMachine")
require("shared/TableAlgorithms")
require("local_user/storage/LocalUserStorageStates")
LocalUserStorage = LocalUserStorage or class()
function LocalUserStorage.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4
	L4_4 = A2_2.user_index
	L4_4 = L4_4(A2_2)
	A0_0._user_index = L4_4
	A0_0._max_save_game_size = A3_3
	A0_0._callback_user = A2_2
	L4_4 = _G
	L4_4 = L4_4[A1_1.start_state]
	A0_0._state = FiniteStateMachine:new(A0_0, "storage", L4_4)
	A0_0._user_is_signed_in = A1_1.user_is_signed_in
	A0_0._device_id = A1_1.device_id
	A0_0._storage_device_is_lost = A1_1.storage_device_is_lost
	A0_0._user_has_signed_out = A1_1.user_has_signed_out
	A0_0._last_saved_device_id = A1_1.last_saved_device_id
	A0_0._state:set_debug(true)
	A0_0._no_saving = false
end
function LocalUserStorage.default_data(A0_5)
	local L1_6
	A0_5.start_state = "LocalUserStorageStateInit"
	A0_5.device_id = nil
	A0_5.storage_device_is_lost = nil
end
function LocalUserStorage.save(A0_7, A1_8)
	A1_8.start_state = A0_7._state:_debug_state_name()
	A1_8.user_is_signed_in = A0_7._user_is_signed_in
	A1_8.storage_device_is_lost = A0_7._storage_device_is_lost
	A1_8.user_has_signed_out = A0_7._user_has_signed_out
	A1_8.last_saved_device_id = A0_7._last_saved_device_id
end
function LocalUserStorage.user_signed_in(A0_9)
	local L1_10
	A0_9._user_is_signed_in = true
	A0_9._user_canceled_signin = false
	A0_9._user_has_signed_in = true
end
function LocalUserStorage.user_signed_out(A0_11)
	cat_print("bob", "LocalUserStorage:user_signed_out")
	A0_11._user_is_signed_in = false
	A0_11._user_has_signed_out = true
	A0_11._user_has_signed_in = false
	A0_11:_clear_wants_to_save()
	A0_11:_clear_wants_to_load()
end
function LocalUserStorage.clear_user_has_signed_out(A0_12)
	local L1_13
	A0_12._user_has_signed_out = nil
end
function LocalUserStorage.user_has_signed_out(A0_14)
	return A0_14._user_has_signed_out ~= nil
end
function LocalUserStorage.user_has_signed_in(A0_15)
	local L1_16
	L1_16 = A0_15._user_has_signed_in
	return L1_16
end
function LocalUserStorage.clear_user_has_signed_in(A0_17)
	local L1_18
	A0_17._user_has_signed_in = nil
end
function LocalUserStorage.user_is_signed_in(A0_19)
	local L1_20
	L1_20 = A0_19._user_is_signed_in
	return L1_20
end
function LocalUserStorage.user_is_signed_out(A0_21)
	return A0_21._user_is_signed_in ~= true
end
function LocalUserStorage.save_disabled(A0_22)
	local L1_23
	L1_23 = A0_22._no_saving
	return L1_23
end
function LocalUserStorage.open_storage_select(A0_24)
	cat_print("bob", "LocalUserStorage:open_storage_select")
	A0_24:clear_is_storage_canceled()
end
function LocalUserStorage.set_is_storage_selected(A0_25)
	assert(not A0_25._storage_canceled)
	A0_25._storage_selected = true
end
function LocalUserStorage.is_storage_selected(A0_26)
	local L1_27
	L1_27 = A0_26._storage_selected
	return L1_27
end
function LocalUserStorage.clear_is_storage_selected(A0_28)
	local L1_29
	A0_28._storage_selected = nil
end
function LocalUserStorage.set_is_storage_canceled(A0_30)
	assert(not A0_30._storage_selected)
	A0_30._storage_canceled = true
end
function LocalUserStorage.is_storage_canceled(A0_31)
	local L1_32
	L1_32 = A0_31._storage_canceled
	return L1_32
end
function LocalUserStorage.clear_is_storage_canceled(A0_33)
	local L1_34
	A0_33._storage_canceled = nil
end
function LocalUserStorage.data_exists_on_media(A0_35, A1_36)
	local L2_37
	L2_37 = A0_35._content_id_to_filename
	L2_37 = L2_37(A0_35, A1_36)
	return Save:exists(L2_37, A0_35._user_index)
end
function LocalUserStorage.new_data(A0_38, A1_39)
	A0_38._data = A1_39
end
function LocalUserStorage.update(A0_40, A1_41)
	A0_40._state:update(A1_41)
end
function LocalUserStorage.data(A0_42)
	local L1_43
	L1_43 = A0_42._data
	return L1_43
end
function LocalUserStorage._common_save_params(A0_44)
	local L1_45, L2_46
	L1_45 = {}
	L2_46 = {1}
	L1_45.save_slots = L2_46
	L1_45.preview = false
	L2_46 = A0_44._user_index
	L1_45.user_index = L2_46
	return L1_45
end
function LocalUserStorage._exists(A0_47)
	local L1_48, L2_49
	L2_49 = A0_47
	L1_48 = A0_47._common_save_params
	L1_48 = L1_48(L2_49)
	L2_49 = nil
	A0_47._exist_task = NewSave:exists(L1_48, L2_49)
end
function LocalUserStorage._exists_status(A0_50)
	if not A0_50._exist_task:has_next() then
		return
	end
	return (A0_50._exist_task:next())
end
function LocalUserStorage._close_exists_task(A0_51)
	local L1_52
	A0_51._exist_task = nil
end
function LocalUserStorage._load(A0_53)
	local L1_54, L2_55
	L2_55 = A0_53
	L1_54 = A0_53._common_save_params
	L1_54 = L1_54(L2_55)
	L2_55 = nil
	A0_53._load_task = NewSave:load(L1_54, L2_55)
end
function LocalUserStorage._load_status(A0_56)
	if not A0_56._load_task:has_next() then
		return
	end
	if A0_56._load_task:next():status() == SaveData.OK then
		A0_56:_data_loaded(A0_56._load_task:next():information())
	end
	return A0_56._load_task:next():status()
end
function LocalUserStorage._close_load_task(A0_57)
	local L1_58
	A0_57._load_task = nil
end
function LocalUserStorage.is_loading(A0_59)
	local L1_60
	L1_60 = A0_59._load_task
	L1_60 = L1_60 ~= nil or L1_60 ~= nil
	return L1_60
end
function LocalUserStorage._save(A0_61)
	local L1_62, L2_63, L3_64, L4_65, L5_66, L6_67, L7_68, L8_69, L9_70
	L1_62 = A0_61._callback_user
	L2_63 = L1_62
	L1_62 = L1_62.save_profile
	L1_62(L2_63)
	L1_62 = NewSave
	L2_63 = L1_62
	L1_62 = L1_62.create_save_data
	L1_62 = L1_62(L2_63)
	L2_63 = assert
	L3_64 = A0_61._data_to_save
	L2_63(L3_64)
	L3_64 = L1_62
	L2_63 = L1_62.set_information
	L4_65 = A0_61._data_to_save
	L2_63(L3_64, L4_65)
	L3_64 = A0_61
	L2_63 = A0_61._common_save_params
	L2_63 = L2_63(L3_64)
	L3_64 = nil
	L5_66 = L1_62
	L4_65 = L1_62.set_title
	L6_67 = "Terminator Salvation"
	L4_65(L5_66, L6_67)
	L4_65 = A0_61._data_to_save
	L4_65 = L4_65.current_level_id
	L5_66 = assert
	L6_67 = L4_65
	L5_66(L6_67)
	L5_66 = managers
	L5_66 = L5_66.world_info
	L6_67 = L5_66
	L5_66 = L5_66.info_from_id
	L7_68 = L4_65
	L5_66 = L5_66(L6_67, L7_68)
	L6_67 = assert
	L7_68 = L5_66
	L6_67(L7_68)
	L7_68 = L5_66
	L6_67 = L5_66.get_localized_chapter_names
	L7_68 = L6_67(L7_68)
	L8_69 = assert
	L9_70 = L6_67
	L8_69(L9_70)
	L8_69 = assert
	L9_70 = L7_68
	L8_69(L9_70)
	L9_70 = L1_62
	L8_69 = L1_62.set_subtitle
	L8_69(L9_70, L6_67 .. ": " .. L7_68)
	L9_70 = L1_62
	L8_69 = L1_62.set_details
	L8_69(L9_70, "")
	L8_69 = A0_61._max_save_game_size
	L2_63.reserved_bytes = L8_69
	L8_69 = SystemInfo
	L9_70 = L8_69
	L8_69 = L8_69.platform
	L8_69 = L8_69(L9_70)
	if L8_69 == "PS3" then
		L8_69 = A0_61._save_for_the_first_time
		if L8_69 then
			L8_69 = cat_print
			L9_70 = "debug"
			L8_69(L9_70, "* Saving Movie, icon and sound.....")
			L9_70 = L1_62
			L8_69 = L1_62.set_small_icon_by_path
			L8_69(L9_70, "ps3/SAVEINFOS/ICON0.PNG")
			L2_63.use_small_icon = true
			L9_70 = L1_62
			L8_69 = L1_62.set_animation_by_path
			L8_69(L9_70, "ps3/SAVEINFOS/ICON1.PAM")
			L2_63.use_animation = true
			L9_70 = L1_62
			L8_69 = L1_62.set_sound_by_path
			L8_69(L9_70, "ps3/SAVEINFOS/SND0.AT3")
			L2_63.use_sound = true
		end
	end
	L8_69 = A0_61._callback_user
	L9_70 = L8_69
	L8_69 = L8_69.profile
	L8_69 = L8_69(L9_70)
	L8_69 = L8_69.newly_created
	L2_63.reset_user = L8_69
	A0_61._save_succeeded = nil
	L9_70 = NewSave
	L9_70 = L9_70.save
	L9_70 = L9_70(L9_70, L1_62, L2_63, L3_64)
	A0_61._save_task = L9_70
end
function LocalUserStorage._close_save_task(A0_71)
	A0_71._save_task = nil
	if A0_71._save_succeeded then
		A0_71._callback_user:profile().newly_created = false
	end
end
function LocalUserStorage._save_status(A0_72)
	if not A0_72._save_task:has_next() then
		return
	end
	A0_72._save_succeeded = A0_72._save_task:next():status() == SaveData.OK
	if A0_72._save_succeeded then
		A0_72._last_saved_device_id = A0_72._device_id
	end
	return (A0_72._save_task:next():status())
end
function LocalUserStorage.is_saving(A0_73)
	return A0_73._save_task ~= nil
end
function LocalUserStorage.save_data(A0_74, A1_75, A2_76)
	cat_print("bob", " -- LocalUserStorage:save_data")
	A0_74._data_to_save = TableAlgorithms.copy(A2_76)
	A0_74._content_id_to_save = A1_75
end
function LocalUserStorage.load_data(A0_77, A1_78)
	A0_77._content_id_to_load = A1_78
end
function LocalUserStorage.is_data_valid(A0_79)
	return A0_79._data ~= nil
end
function LocalUserStorage._wants_to_load(A0_80)
	return A0_80._content_id_to_load ~= nil
end
function LocalUserStorage._wants_to_save(A0_81)
	return A0_81._content_id_to_save ~= nil
end
function LocalUserStorage._clear_wants_to_save(A0_82)
	local L1_83
	A0_82._content_id_to_save = nil
end
function LocalUserStorage._clear_wants_to_load(A0_84)
	local L1_85
	A0_84._content_id_to_load = nil
end
function LocalUserStorage._clear_data(A0_86)
	A0_86._callback_user:clear_profile()
end
function LocalUserStorage._data_loaded(A0_87, A1_88)
	A0_87._callback_user:set_profile(A1_88, true)
end
function LocalUserStorage.waits_for_retry_loading(A0_89)
	local L1_90
	L1_90 = A0_89._waits_for_retry_loading
	return L1_90
end
function LocalUserStorage.request_wants_to_retry_load(A0_91)
	cat_print("debug", "request_wants_to_retry_load")
	A0_91:load_data(0)
end
function LocalUserStorage.set_storage_device_lost(A0_92)
	cat_print("debug", "set_storage_device_lost")
	A0_92._storage_device_is_lost = true
end
function LocalUserStorage.clear_storage_device_lost(A0_93)
	cat_print("debug", "CLEAR storage_device_lost")
	A0_93._storage_device_is_lost = nil
end
function LocalUserStorage.is_storage_device_lost(A0_94)
	local L1_95
	L1_95 = A0_94._storage_device_is_lost
	return L1_95
end
function LocalUserStorage.waits_for_storage_lost(A0_96)
	local L1_97
	L1_97 = A0_96._waits_for_storage_lost
	return L1_97
end
function LocalUserStorage.request_wants_to_select_storage_after_lost(A0_98)
	cat_print("debug", "request_wants_to_select_storage_after_lost")
	A0_98._wants_to_select_storage_after_lost = true
end
function LocalUserStorage.wants_to_select_storage_after_lost(A0_99)
	local L1_100
	L1_100 = A0_99._wants_to_select_storage_after_lost
	return L1_100
end
function LocalUserStorage.clear_wants_to_select_storage_after_lost(A0_101)
	local L1_102
	A0_101._wants_to_select_storage_after_lost = nil
end
function LocalUserStorage.waits_for_continue_without_saving(A0_103)
	local L1_104
	L1_104 = A0_103._waits_for_continue_without_saving
	return L1_104
end
function LocalUserStorage.request_wants_to_continue_without_saving(A0_105)
	cat_print("debug", "request_wants_to_continue_without_saving")
	A0_105._wants_to_continue_without_saving = true
end
function LocalUserStorage.request_do_not_continue_without_saving(A0_106)
	cat_print("debug", "request_do_not_continue_without_saving")
	A0_106._do_not_want_to_continue_without_saving = true
end
function LocalUserStorage.do_not_want_to_continue_without_saving(A0_107)
	local L1_108
	L1_108 = A0_107._do_not_want_to_continue_without_saving
	return L1_108
end
function LocalUserStorage.clear_do_not_want_to_continue_without_saving(A0_109)
	local L1_110
	A0_109._do_not_want_to_continue_without_saving = nil
end
function LocalUserStorage.wants_to_continue_without_saving(A0_111)
	local L1_112
	L1_112 = A0_111._wants_to_continue_without_saving
	return L1_112
end
function LocalUserStorage.clear_wants_to_continue_without_saving(A0_113)
	local L1_114
	A0_113._wants_to_continue_without_saving = nil
end
function LocalUserStorage.waits_for_retry_saving(A0_115)
	local L1_116
	L1_116 = A0_115._waits_for_retry_saving
	return L1_116
end
function LocalUserStorage.clear_wants_to_select_storage_for_loading(A0_117)
	local L1_118
	A0_117._wants_to_select_storage_for_loading = nil
end
function LocalUserStorage.request_wants_to_select_storage_for_loading(A0_119)
	cat_print("debug", "request_wants_to_select_storage_for_loading")
	A0_119._wants_to_select_storage_for_loading = true
end
function LocalUserStorage.wants_to_select_storage_for_loading(A0_120)
	local L1_121
	L1_121 = A0_120._wants_to_select_storage_for_loading
	return L1_121
end
function LocalUserStorage.clear_wants_to_select_storage_for_saving(A0_122)
	local L1_123
	A0_122._wants_to_select_storage_for_saving = nil
end
function LocalUserStorage.request_wants_to_select_storage_for_saving(A0_124)
	cat_print("debug", "request_wants_to_select_storage_for_saving")
	A0_124._wants_to_select_storage_for_saving = true
end
function LocalUserStorage.wants_to_select_storage_for_saving(A0_125)
	local L1_126
	L1_126 = A0_125._wants_to_select_storage_for_saving
	return L1_126
end
function LocalUserStorage.request_wants_to_retry_save(A0_127)
	cat_print("debug", "request_wants_to_retry_save")
	A0_127:_save()
end
function LocalUserStorage.waits_for_overwrite_confirmation(A0_128)
	local L1_129
	L1_129 = A0_128._waits_for_overwrite_confirmation
	return L1_129
end
function LocalUserStorage.request_wants_to_overwrite(A0_130)
	cat_print("debug", "request_wants_to_overwrite")
	A0_130._wants_to_overwrite = true
end
function LocalUserStorage.wants_to_overwrite(A0_131)
	local L1_132
	L1_132 = A0_131._wants_to_overwrite
	return L1_132
end
function LocalUserStorage.clear_wants_to_overwrite(A0_133)
	local L1_134
	A0_133._wants_to_overwrite = nil
end
function LocalUserStorage._set_want_to_skip_sign_in(A0_135)
	cat_print("debug", "LocalUserStorage:_set_want_to_skip_sign_in")
	A0_135._want_to_skip_sign_in = true
end
function LocalUserStorage._clear_want_to_skip_sign_in(A0_136)
	local L1_137
	A0_136._want_to_skip_sign_in = nil
end
function LocalUserStorage.want_to_skip_sign_in(A0_138)
	return A0_138._want_to_skip_sign_in ~= nil
end
function LocalUserStorage.wants_to_init(A0_139)
	local L1_140
	L1_140 = A0_139._wants_to_init
	return L1_140
end
function LocalUserStorage.set_wants_to_init(A0_141)
	cat_print("debug", "set_wants_to_init")
	A0_141._wants_to_init = true
end
function LocalUserStorage.clear_wants_to_init(A0_142)
	local L1_143
	A0_142._wants_to_init = nil
end
function LocalUserStorage.device_id(A0_144)
	local L1_145
	L1_145 = A0_144._device_id
	return L1_145
end
function LocalUserStorage.last_saved_to_device_id(A0_146)
	local L1_147
	L1_147 = A0_146._last_saved_device_id
	return L1_147
end
function LocalUserStorage.clear_last_saved_to_device_id(A0_148)
	local L1_149
	A0_148._last_saved_device_id = nil
end
function LocalUserStorage.set_storage_dialog_failed(A0_150)
	local L1_151
	A0_150._storage_dialog_failed = true
end
function LocalUserStorage.clear_storage_dialog_failed(A0_152)
	local L1_153
	A0_152._storage_dialog_failed = nil
end
function LocalUserStorage.did_storage_dialog_fail(A0_154)
	local L1_155
	L1_155 = A0_154._storage_dialog_failed
	return L1_155
end
