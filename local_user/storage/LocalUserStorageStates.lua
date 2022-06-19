require("shared/FiniteStateMachineState")
if not LocalUserStorageStateInit then
	LocalUserStorageStateInit = class(FiniteStateMachineState)
end
LocalUserStorageStateInit.init = function(l_1_0)
	l_1_0.storage:_clear_data()
	l_1_0.storage:clear_wants_to_init()
	l_1_0.storage:_clear_want_to_skip_sign_in()
	l_1_0.storage:clear_is_storage_canceled()
	l_1_0.storage:_clear_wants_to_load()
	l_1_0.storage:clear_user_has_signed_in()
	l_1_0.storage:clear_user_has_signed_out()
	if managers.save and managers.save:has_primary_user() and l_1_0.storage == managers.save:primary_user()._storage then
		managers.save:release_primary_user()
	end
	l_1_0.storage._callback_user:clear_wanted_slot_id()
end

LocalUserStorageStateInit.exit = function(l_2_0)
	l_2_0.storage:clear_wants_to_init()
	l_2_0.storage:clear_user_has_signed_out()
end

LocalUserStorageStateInit.transition = function(l_3_0)
	if l_3_0.storage:_wants_to_load() then
		if l_3_0.storage._callback_user:wanted_player_slot_id() == 2 and (SystemInfo:platform() == "PS3" or SystemInfo:platform() == "WIN32") then
			return LocalUserStorageUserConfirmedNoSaving
		end
		if l_3_0.storage:user_is_signed_in() then
			return LocalUserStorageStateOpenSelectForLoading
		else
			if l_3_0.storage:want_to_skip_sign_in() then
				return LocalUserStorageStateNotFound
			end
		else
			if l_3_0.storage:want_to_skip_sign_in() then
				return LocalUserStorageStateNotFound
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

if not LocalUserStorageStateDetectSignOut then
	LocalUserStorageStateDetectSignOut = class(FiniteStateMachineState)
end
LocalUserStorageStateDetectSignOut.init = function(l_4_0)
	l_4_0._parent_transition = l_4_0.transition
	assert(l_4_0._parent_transition)
	l_4_0.transition = LocalUserStorageStateDetectSignOut.transition
end

LocalUserStorageStateDetectSignOut.transition = function(l_5_0)
	if l_5_0.storage:user_has_signed_out() then
		return LocalUserStorageStateOwnerSignedOut
	else
		if l_5_0.storage:wants_to_init() then
			return LocalUserStorageStateInit
		end
	end
	local l_5_1 = l_5_0:_parent_transition()
	if l_5_1 then
		l_5_0.transition = l_5_0._parent_transition
		return l_5_1
	end
end

if not LocalUserStorageStateOwnerSignedOut then
	LocalUserStorageStateOwnerSignedOut = class(FiniteStateMachineState)
end
LocalUserStorageStateOwnerSignedOut.init = function(l_6_0)
	l_6_0.storage:clear_user_has_signed_out()
end

LocalUserStorageStateOwnerSignedOut.transition = function(l_7_0)
	return LocalUserStorageStateInit
end

if not LocalUserStorageStateOpenSelectForLoading then
	LocalUserStorageStateOpenSelectForLoading = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateOpenSelectForLoading.init = function(l_8_0)
	LocalUserStorageStateDetectSignOut.init(l_8_0)
	local l_8_1 = false
	l_8_0.storage:clear_storage_dialog_failed()
	l_8_0.storage:clear_user_has_signed_in()
	l_8_0.storage:open_storage_select(l_8_1)
end

LocalUserStorageStateOpenSelectForLoading.transition = function(l_9_0)
	if l_9_0.storage:did_storage_dialog_fail() then
		return LocalUserStorageStateOpenSelectForLoading
	else
		if l_9_0.storage:is_storage_selected() then
			return LocalUserStorageStateLoading
		end
	else
		if l_9_0.storage:is_storage_canceled() then
			return LocalUserStorageStateNotFound
		end
	end
end

if not LocalUserStorageStateLoading then
	LocalUserStorageStateLoading = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateLoading.init = function(l_10_0)
	LocalUserStorageStateDetectSignOut.init(l_10_0)
	l_10_0.storage:_load()
end

LocalUserStorageStateLoading.exit = function(l_11_0)
	l_11_0.storage:_close_load_task()
end

LocalUserStorageStateLoading.transition = function(l_12_0)
	local l_12_1 = l_12_0.storage:_load_status()
	if not l_12_1 then
		return 
	end
	if l_12_1 == SaveData.OK then
		return LocalUserStorageStateReady
	else
		if l_12_1 == SaveData.FILE_NOT_FOUND then
			return LocalUserStorageStateNoSaveGameFound
		end
	else
		return LocalUserStorageStateLoadError
	end
end

if not LocalUserStorageStateLoadError then
	LocalUserStorageStateLoadError = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateLoadError.init = function(l_13_0)
	l_13_0.storage:_clear_wants_to_load()
	l_13_0.storage:clear_wants_to_select_storage_for_loading()
	l_13_0.storage:clear_wants_to_overwrite()
	l_13_0.storage._waits_for_retry_loading = true
end

LocalUserStorageStateLoadError.exit = function(l_14_0)
	l_14_0.storage._waits_for_retry_loading = false
end

LocalUserStorageStateLoadError.transition = function(l_15_0)
	if l_15_0.storage:_wants_to_load() then
		return LocalUserStorageStateLoading
	else
		if l_15_0.storage:wants_to_select_storage_for_loading() then
			return LocalUserStorageStateOpenSelectForLoading
		end
	else
		if l_15_0.storage:wants_to_overwrite() then
			local l_15_1 = l_15_0.storage._callback_user:settings_defaults()
			local l_15_2 = {}
			SaveManager.new_profile(l_15_2, l_15_1)
			l_15_0.storage:_data_loaded(l_15_2)
			l_15_0.storage._save_for_the_first_time = true
			return LocalUserStorageStateSaving
		end
	end
end

if not LocalUserStorageStateNoSaveGameFound then
	LocalUserStorageStateNoSaveGameFound = class(FiniteStateMachineState)
end
LocalUserStorageStateNoSaveGameFound.init = function(l_16_0)
	local l_16_1 = l_16_0.storage._callback_user:settings_defaults()
	local l_16_2 = {}
	SaveManager.new_profile(l_16_2, l_16_1)
	l_16_0.storage:_data_loaded(l_16_2)
	l_16_0.storage._save_for_the_first_time = true
end

LocalUserStorageStateNoSaveGameFound.transition = function(l_17_0)
	return LocalUserStorageStateReady
end

if not LocalUserStorageStateNotFound then
	LocalUserStorageStateNotFound = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateNotFound.init = function(l_18_0)
	LocalUserStorageStateDetectSignOut.init(l_18_0)
	l_18_0.storage:_clear_want_to_skip_sign_in()
	l_18_0.storage:clear_wants_to_init()
	l_18_0.storage:clear_do_not_want_to_continue_without_saving()
	l_18_0.storage:clear_wants_to_continue_without_saving()
	l_18_0.storage._waits_for_continue_without_saving = true
end

LocalUserStorageStateNotFound.exit = function(l_19_0)
	l_19_0.storage._waits_for_continue_without_saving = false
	l_19_0.storage:clear_user_has_signed_in()
	l_19_0.storage:clear_do_not_want_to_continue_without_saving()
end

LocalUserStorageStateNotFound.transition = function(l_20_0)
	if l_20_0.storage:wants_to_continue_without_saving() then
		return LocalUserStorageUserConfirmedNoSaving
	else
		if l_20_0.storage:user_has_signed_in() then
			return LocalUserStorageStateOpenSelectForLoading
		end
	else
		if l_20_0.storage:do_not_want_to_continue_without_saving() then
			return LocalUserStorageStateInit
		end
	end
end

if not LocalUserStorageUserConfirmedNoSaving then
	LocalUserStorageUserConfirmedNoSaving = class(FiniteStateMachineState)
end
LocalUserStorageUserConfirmedNoSaving.init = function(l_21_0)
	l_21_0.storage:clear_wants_to_init()
	l_21_0.storage:clear_wants_to_continue_without_saving()
	local l_21_1 = {}
	local l_21_2 = l_21_0.storage._callback_user:settings_defaults()
	SaveManager.new_profile(l_21_1, l_21_2)
	l_21_0.storage:_data_loaded(l_21_1)
	l_21_0.storage:_clear_wants_to_load()
end

LocalUserStorageUserConfirmedNoSaving.transition = function(l_22_0)
	return LocalUserStorageStateNoSaving
end

if not LocalUserStorageStateNoSaving then
	LocalUserStorageStateNoSaving = class(FiniteStateMachineState)
end
LocalUserStorageStateNoSaving.init = function(l_23_0)
	l_23_0.storage:clear_storage_device_lost()
	l_23_0.storage:clear_user_has_signed_in()
	l_23_0.storage._no_saving = true
end

LocalUserStorageStateNoSaving.exit = function(l_24_0)
	l_24_0.storage._no_saving = false
end

LocalUserStorageStateNoSaving.transition = function(l_25_0)
	if l_25_0.storage:wants_to_init() then
		return LocalUserStorageStateInit
	else
		if l_25_0.storage:user_has_signed_in() then
			return LocalUserStorageStateInit
		end
	else
		if l_25_0.storage:wants_to_select_storage_for_saving() then
			return LocalUserStorageStateOpenSelectForSaving
		end
	end
end

if not LocalUserStorageStateDebugJoin then
	LocalUserStorageStateDebugJoin = class(FiniteStateMachineState)
end
LocalUserStorageStateDebugJoin.init = function(l_26_0)
	local l_26_1 = {}
	local l_26_2 = {}
	SaveManager.new_profile(l_26_1, l_26_2)
	l_26_0.storage:_data_loaded(l_26_1)
end

LocalUserStorageStateDebugJoin.transition = function(l_27_0)
	return LocalUserStorageStateDoNothing
end

if not LocalUserStorageStateDoNothing then
	LocalUserStorageStateDoNothing = class(FiniteStateMachineState)
end
LocalUserStorageStateDoNothing.transition = function(l_28_0)
end

if not LocalUserStorageStateReady then
	LocalUserStorageStateReady = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateReady.init = function(l_29_0)
	LocalUserStorageStateDetectSignOut.init(l_29_0)
	l_29_0.storage:_clear_wants_to_load()
	l_29_0.storage:clear_storage_device_lost()
end

LocalUserStorageStateReady.transition = function(l_30_0)
	if l_30_0.storage:_wants_to_save() then
		if l_30_0.storage:is_storage_device_lost() then
			return LocalUserStorageStateLost
		else
			return LocalUserStorageStateSaving
		end
	else
		if l_30_0.storage:wants_to_select_storage_for_saving() then
			return LocalUserStorageStateOpenSelectForSaving
		end
	end
end

if not LocalUserStorageStateOpenSelectForSaving then
	LocalUserStorageStateOpenSelectForSaving = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateOpenSelectForSaving.init = function(l_31_0)
	LocalUserStorageStateDetectSignOut.init(l_31_0)
	l_31_0.storage:clear_wants_to_select_storage_for_saving()
	local l_31_1 = true
	l_31_0.storage:open_storage_select(l_31_1)
end

LocalUserStorageStateOpenSelectForSaving.transition = function(l_32_0)
	if l_32_0.storage:is_storage_selected() and l_32_0.storage:last_saved_to_device_id() == l_32_0.storage:device_id() then
		return LocalUserStorageStateReady
	else
		if l_32_0.storage:is_storage_canceled() then
			return LocalUserStorageStateNotFoundForSaving
		end
	else
		if l_32_0.storage:is_storage_selected() then
			return LocalUserStorageStateCheckOverwrite
		end
	end
end

if not LocalUserStorageStateCheckOverwrite then
	LocalUserStorageStateCheckOverwrite = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateCheckOverwrite.init = function(l_33_0)
	LocalUserStorageStateDetectSignOut.init(l_33_0)
	l_33_0.storage:clear_storage_device_lost()
	l_33_0.storage:_exists()
end

LocalUserStorageStateCheckOverwrite.exit = function(l_34_0)
	l_34_0.storage:_close_exists_task()
end

LocalUserStorageStateCheckOverwrite.transition = function(l_35_0)
	local l_35_1 = l_35_0.storage:_exists_status()
	if l_35_1 == nil then
		return 
	end
	if l_35_1 then
		return LocalUserStorageStateAskOverwrite
	else
		return LocalUserStorageStateSaving
	end
end

if not LocalUserStorageStateAskOverwrite then
	LocalUserStorageStateAskOverwrite = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateAskOverwrite.init = function(l_36_0)
	LocalUserStorageStateDetectSignOut.init(l_36_0)
	l_36_0.storage:clear_wants_to_overwrite()
	l_36_0.storage:clear_wants_to_select_storage_for_saving()
	l_36_0.storage._waits_for_overwrite_confirmation = true
end

LocalUserStorageStateAskOverwrite.exit = function(l_37_0)
	l_37_0.storage._waits_for_overwrite_confirmation = false
end

LocalUserStorageStateAskOverwrite.transition = function(l_38_0)
	if l_38_0.storage:wants_to_overwrite() then
		return LocalUserStorageStateSaving
	else
		if l_38_0.storage:wants_to_select_storage_for_saving() then
			return LocalUserStorageStateOpenSelectForSaving
		end
	end
end

if not LocalUserStorageStateNotFoundForSaving then
	LocalUserStorageStateNotFoundForSaving = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateNotFoundForSaving.init = function(l_39_0)
	LocalUserStorageStateDetectSignOut.init(l_39_0)
	l_39_0.storage:clear_wants_to_select_storage_for_saving()
	l_39_0.storage:clear_wants_to_continue_without_saving()
	l_39_0.storage:clear_do_not_want_to_continue_without_saving()
	l_39_0.storage._waits_for_continue_without_saving = true
end

LocalUserStorageStateNotFoundForSaving.exit = function(l_40_0)
	l_40_0.storage._waits_for_continue_without_saving = nil
end

LocalUserStorageStateNotFoundForSaving.transition = function(l_41_0)
	if l_41_0.storage:wants_to_continue_without_saving() then
		return LocalUserStorageStateNoSaving
	else
		if l_41_0.storage:do_not_want_to_continue_without_saving() then
			return LocalUserStorageStateOpenSelectForSaving
		end
	else
		if l_41_0.storage:wants_to_select_storage_for_saving() then
			return LocalUserStorageStateOpenSelectForSaving
		end
	end
end

if not LocalUserStorageStateSaving then
	LocalUserStorageStateSaving = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateSaving.init = function(l_42_0)
	LocalUserStorageStateDetectSignOut.init(l_42_0)
	local l_42_1 = nil
	l_42_0.storage:_save()
end

LocalUserStorageStateSaving.exit = function(l_43_0)
	l_43_0.storage:_close_save_task()
end

LocalUserStorageStateSaving.transition = function(l_44_0)
	local l_44_1 = l_44_0.storage:_save_status()
	if not l_44_1 then
		return 
	end
	if l_44_1 == SaveData.OK then
		l_44_0.storage._save_for_the_first_time = nil
		return LocalUserStorageStateSaved
	else
		if l_44_1 == SaveData.XBOX_CONTENT then
			return LocalUserStorageStateLost
		end
	else
		return LocalUserStorageStateSaveFailed
	end
end

if not LocalUserStorageStateSaveFailed then
	LocalUserStorageStateSaveFailed = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateSaveFailed.init = function(l_45_0)
	LocalUserStorageStateDetectSignOut.init(l_45_0)
	l_45_0.storage:_clear_wants_to_save()
	l_45_0.storage._waits_for_retry_saving = true
end

LocalUserStorageStateSaveFailed.exit = function(l_46_0)
	l_46_0.storage._waits_for_retry_saving = false
end

LocalUserStorageStateSaveFailed.transition = function(l_47_0)
	if l_47_0.storage:_wants_to_save() then
		return LocalUserStorageStateSaving
	else
		if l_47_0.storage:wants_to_select_storage_for_saving() then
			return LocalUserStorageStateOpenSelectForSaving
		end
	end
end

if not LocalUserStorageStateSaved then
	LocalUserStorageStateSaved = class(FiniteStateMachineState)
end
LocalUserStorageStateSaved.init = function(l_48_0)
	l_48_0.storage:_clear_wants_to_save()
end

LocalUserStorageStateSaved.transition = function(l_49_0)
	return LocalUserStorageStateReady
end

if not LocalUserStorageStateLost then
	LocalUserStorageStateLost = class(LocalUserStorageStateDetectSignOut)
end
LocalUserStorageStateLost.init = function(l_50_0)
	LocalUserStorageStateDetectSignOut.init(l_50_0)
	l_50_0.storage._waits_for_storage_lost = true
	l_50_0.storage:clear_last_saved_to_device_id()
	l_50_0.storage:clear_storage_device_lost()
end

LocalUserStorageStateLost.exit = function(l_51_0)
	l_51_0.storage._waits_for_storage_lost = false
	l_51_0.storage:clear_wants_to_select_storage_after_lost()
end

LocalUserStorageStateLost.transition = function(l_52_0)
	if l_52_0.storage:wants_to_select_storage_after_lost() then
		return LocalUserStorageStateOpenSelectForSaving
	end
end


