require("shared/FiniteStateMachineState")
LocalUserStorageStateInit = LocalUserStorageStateInit or class(FiniteStateMachineState)
function LocalUserStorageStateInit.init(A0_0)
	A0_0.storage:_clear_data()
	A0_0.storage:clear_wants_to_init()
	A0_0.storage:_clear_want_to_skip_sign_in()
	A0_0.storage:clear_is_storage_canceled()
	A0_0.storage:_clear_wants_to_load()
	A0_0.storage:clear_user_has_signed_in()
	A0_0.storage:clear_user_has_signed_out()
	if managers.save and managers.save:has_primary_user() and A0_0.storage == managers.save:primary_user()._storage then
		managers.save:release_primary_user()
	end
	A0_0.storage._callback_user:clear_wanted_slot_id()
end
function LocalUserStorageStateInit.exit(A0_1)
	A0_1.storage:clear_wants_to_init()
	A0_1.storage:clear_user_has_signed_out()
end
function LocalUserStorageStateInit.transition(A0_2)
	if A0_2.storage:_wants_to_load() then
		if A0_2.storage._callback_user:wanted_player_slot_id() == 2 and (SystemInfo:platform() == "PS3" or SystemInfo:platform() == "WIN32") then
			return LocalUserStorageUserConfirmedNoSaving
		end
		if A0_2.storage:user_is_signed_in() then
			return LocalUserStorageStateOpenSelectForLoading
		elseif A0_2.storage:want_to_skip_sign_in() then
			return LocalUserStorageStateNotFound
		end
	elseif A0_2.storage:want_to_skip_sign_in() then
		return LocalUserStorageStateNotFound
	end
end
LocalUserStorageStateDetectSignOut = LocalUserStorageStateDetectSignOut or class(FiniteStateMachineState)
function LocalUserStorageStateDetectSignOut.init(A0_3)
	A0_3._parent_transition = A0_3.transition
	assert(A0_3._parent_transition)
	A0_3.transition = LocalUserStorageStateDetectSignOut.transition
end
function LocalUserStorageStateDetectSignOut.transition(A0_4)
	if A0_4.storage:user_has_signed_out() then
		return LocalUserStorageStateOwnerSignedOut
	elseif A0_4.storage:wants_to_init() then
		return LocalUserStorageStateInit
	end
	if A0_4:_parent_transition() then
		A0_4.transition = A0_4._parent_transition
		return (A0_4:_parent_transition())
	end
end
LocalUserStorageStateOwnerSignedOut = LocalUserStorageStateOwnerSignedOut or class(FiniteStateMachineState)
function LocalUserStorageStateOwnerSignedOut.init(A0_5)
	A0_5.storage:clear_user_has_signed_out()
end
function LocalUserStorageStateOwnerSignedOut.transition(A0_6)
	local L1_7
	L1_7 = LocalUserStorageStateInit
	return L1_7
end
LocalUserStorageStateOpenSelectForLoading = LocalUserStorageStateOpenSelectForLoading or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateOpenSelectForLoading.init(A0_8)
	local L1_9
	L1_9 = LocalUserStorageStateDetectSignOut
	L1_9 = L1_9.init
	L1_9(A0_8)
	L1_9 = false
	A0_8.storage:clear_storage_dialog_failed()
	A0_8.storage:clear_user_has_signed_in()
	A0_8.storage:open_storage_select(L1_9)
end
function LocalUserStorageStateOpenSelectForLoading.transition(A0_10)
	if A0_10.storage:did_storage_dialog_fail() then
		return LocalUserStorageStateOpenSelectForLoading
	elseif A0_10.storage:is_storage_selected() then
		return LocalUserStorageStateLoading
	elseif A0_10.storage:is_storage_canceled() then
		return LocalUserStorageStateNotFound
	end
end
LocalUserStorageStateLoading = LocalUserStorageStateLoading or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateLoading.init(A0_11)
	LocalUserStorageStateDetectSignOut.init(A0_11)
	A0_11.storage:_load()
end
function LocalUserStorageStateLoading.exit(A0_12)
	A0_12.storage:_close_load_task()
end
function LocalUserStorageStateLoading.transition(A0_13)
	if not A0_13.storage:_load_status() then
		return
	end
	if A0_13.storage:_load_status() == SaveData.OK then
		return LocalUserStorageStateReady
	elseif A0_13.storage:_load_status() == SaveData.FILE_NOT_FOUND then
		return LocalUserStorageStateNoSaveGameFound
	else
		return LocalUserStorageStateLoadError
	end
end
LocalUserStorageStateLoadError = LocalUserStorageStateLoadError or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateLoadError.init(A0_14)
	A0_14.storage:_clear_wants_to_load()
	A0_14.storage:clear_wants_to_select_storage_for_loading()
	A0_14.storage:clear_wants_to_overwrite()
	A0_14.storage._waits_for_retry_loading = true
end
function LocalUserStorageStateLoadError.exit(A0_15)
	A0_15.storage._waits_for_retry_loading = false
end
function LocalUserStorageStateLoadError.transition(A0_16)
	local L1_17, L2_18
	L1_17 = A0_16.storage
	L2_18 = L1_17
	L1_17 = L1_17._wants_to_load
	L1_17 = L1_17(L2_18)
	if L1_17 then
		L1_17 = LocalUserStorageStateLoading
		return L1_17
	else
		L1_17 = A0_16.storage
		L2_18 = L1_17
		L1_17 = L1_17.wants_to_select_storage_for_loading
		L1_17 = L1_17(L2_18)
		if L1_17 then
			L1_17 = LocalUserStorageStateOpenSelectForLoading
			return L1_17
		else
			L1_17 = A0_16.storage
			L2_18 = L1_17
			L1_17 = L1_17.wants_to_overwrite
			L1_17 = L1_17(L2_18)
			if L1_17 then
				L1_17 = A0_16.storage
				L1_17 = L1_17._callback_user
				L2_18 = L1_17
				L1_17 = L1_17.settings_defaults
				L1_17 = L1_17(L2_18)
				L2_18 = {}
				SaveManager.new_profile(L2_18, L1_17)
				A0_16.storage:_data_loaded(L2_18)
				A0_16.storage._save_for_the_first_time = true
				return LocalUserStorageStateSaving
			end
		end
	end
end
LocalUserStorageStateNoSaveGameFound = LocalUserStorageStateNoSaveGameFound or class(FiniteStateMachineState)
function LocalUserStorageStateNoSaveGameFound.init(A0_19)
	local L1_20, L2_21
	L1_20 = A0_19.storage
	L1_20 = L1_20._callback_user
	L2_21 = L1_20
	L1_20 = L1_20.settings_defaults
	L1_20 = L1_20(L2_21)
	L2_21 = {}
	SaveManager.new_profile(L2_21, L1_20)
	A0_19.storage:_data_loaded(L2_21)
	A0_19.storage._save_for_the_first_time = true
end
function LocalUserStorageStateNoSaveGameFound.transition(A0_22)
	local L1_23
	L1_23 = LocalUserStorageStateReady
	return L1_23
end
LocalUserStorageStateNotFound = LocalUserStorageStateNotFound or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateNotFound.init(A0_24)
	LocalUserStorageStateDetectSignOut.init(A0_24)
	A0_24.storage:_clear_want_to_skip_sign_in()
	A0_24.storage:clear_wants_to_init()
	A0_24.storage:clear_do_not_want_to_continue_without_saving()
	A0_24.storage:clear_wants_to_continue_without_saving()
	A0_24.storage._waits_for_continue_without_saving = true
end
function LocalUserStorageStateNotFound.exit(A0_25)
	A0_25.storage._waits_for_continue_without_saving = false
	A0_25.storage:clear_user_has_signed_in()
	A0_25.storage:clear_do_not_want_to_continue_without_saving()
end
function LocalUserStorageStateNotFound.transition(A0_26)
	if A0_26.storage:wants_to_continue_without_saving() then
		return LocalUserStorageUserConfirmedNoSaving
	elseif A0_26.storage:user_has_signed_in() then
		return LocalUserStorageStateOpenSelectForLoading
	elseif A0_26.storage:do_not_want_to_continue_without_saving() then
		return LocalUserStorageStateInit
	end
end
LocalUserStorageUserConfirmedNoSaving = LocalUserStorageUserConfirmedNoSaving or class(FiniteStateMachineState)
function LocalUserStorageUserConfirmedNoSaving.init(A0_27)
	local L1_28, L2_29
	L1_28 = A0_27.storage
	L2_29 = L1_28
	L1_28 = L1_28.clear_wants_to_init
	L1_28(L2_29)
	L1_28 = A0_27.storage
	L2_29 = L1_28
	L1_28 = L1_28.clear_wants_to_continue_without_saving
	L1_28(L2_29)
	L1_28 = {}
	L2_29 = A0_27.storage
	L2_29 = L2_29._callback_user
	L2_29 = L2_29.settings_defaults
	L2_29 = L2_29(L2_29)
	SaveManager.new_profile(L1_28, L2_29)
	A0_27.storage:_data_loaded(L1_28)
	A0_27.storage:_clear_wants_to_load()
end
function LocalUserStorageUserConfirmedNoSaving.transition(A0_30)
	local L1_31
	L1_31 = LocalUserStorageStateNoSaving
	return L1_31
end
LocalUserStorageStateNoSaving = LocalUserStorageStateNoSaving or class(FiniteStateMachineState)
function LocalUserStorageStateNoSaving.init(A0_32)
	A0_32.storage:clear_storage_device_lost()
	A0_32.storage:clear_user_has_signed_in()
	A0_32.storage._no_saving = true
end
function LocalUserStorageStateNoSaving.exit(A0_33)
	A0_33.storage._no_saving = false
end
function LocalUserStorageStateNoSaving.transition(A0_34)
	if A0_34.storage:wants_to_init() then
		return LocalUserStorageStateInit
	elseif A0_34.storage:user_has_signed_in() then
		return LocalUserStorageStateInit
	elseif A0_34.storage:wants_to_select_storage_for_saving() then
		return LocalUserStorageStateOpenSelectForSaving
	end
end
LocalUserStorageStateDebugJoin = LocalUserStorageStateDebugJoin or class(FiniteStateMachineState)
function LocalUserStorageStateDebugJoin.init(A0_35)
	local L1_36, L2_37
	L1_36 = {}
	L2_37 = {}
	SaveManager.new_profile(L1_36, L2_37)
	A0_35.storage:_data_loaded(L1_36)
end
function LocalUserStorageStateDebugJoin.transition(A0_38)
	local L1_39
	L1_39 = LocalUserStorageStateDoNothing
	return L1_39
end
LocalUserStorageStateDoNothing = LocalUserStorageStateDoNothing or class(FiniteStateMachineState)
function LocalUserStorageStateDoNothing.transition(A0_40)
	local L1_41
end
LocalUserStorageStateReady = LocalUserStorageStateReady or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateReady.init(A0_42)
	LocalUserStorageStateDetectSignOut.init(A0_42)
	A0_42.storage:_clear_wants_to_load()
	A0_42.storage:clear_storage_device_lost()
end
function LocalUserStorageStateReady.transition(A0_43)
	if A0_43.storage:_wants_to_save() then
		if A0_43.storage:is_storage_device_lost() then
			return LocalUserStorageStateLost
		else
			return LocalUserStorageStateSaving
		end
	elseif A0_43.storage:wants_to_select_storage_for_saving() then
		return LocalUserStorageStateOpenSelectForSaving
	end
end
LocalUserStorageStateOpenSelectForSaving = LocalUserStorageStateOpenSelectForSaving or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateOpenSelectForSaving.init(A0_44)
	local L1_45
	L1_45 = LocalUserStorageStateDetectSignOut
	L1_45 = L1_45.init
	L1_45(A0_44)
	L1_45 = A0_44.storage
	L1_45 = L1_45.clear_wants_to_select_storage_for_saving
	L1_45(L1_45)
	L1_45 = true
	A0_44.storage:open_storage_select(L1_45)
end
function LocalUserStorageStateOpenSelectForSaving.transition(A0_46)
	if A0_46.storage:is_storage_selected() and A0_46.storage:last_saved_to_device_id() == A0_46.storage:device_id() then
		return LocalUserStorageStateReady
	elseif A0_46.storage:is_storage_canceled() then
		return LocalUserStorageStateNotFoundForSaving
	elseif A0_46.storage:is_storage_selected() then
		return LocalUserStorageStateCheckOverwrite
	end
end
LocalUserStorageStateCheckOverwrite = LocalUserStorageStateCheckOverwrite or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateCheckOverwrite.init(A0_47)
	LocalUserStorageStateDetectSignOut.init(A0_47)
	A0_47.storage:clear_storage_device_lost()
	A0_47.storage:_exists()
end
function LocalUserStorageStateCheckOverwrite.exit(A0_48)
	A0_48.storage:_close_exists_task()
end
function LocalUserStorageStateCheckOverwrite.transition(A0_49)
	if A0_49.storage:_exists_status() == nil then
		return
	end
	if A0_49.storage:_exists_status() then
		return LocalUserStorageStateAskOverwrite
	else
		return LocalUserStorageStateSaving
	end
end
LocalUserStorageStateAskOverwrite = LocalUserStorageStateAskOverwrite or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateAskOverwrite.init(A0_50)
	LocalUserStorageStateDetectSignOut.init(A0_50)
	A0_50.storage:clear_wants_to_overwrite()
	A0_50.storage:clear_wants_to_select_storage_for_saving()
	A0_50.storage._waits_for_overwrite_confirmation = true
end
function LocalUserStorageStateAskOverwrite.exit(A0_51)
	A0_51.storage._waits_for_overwrite_confirmation = false
end
function LocalUserStorageStateAskOverwrite.transition(A0_52)
	if A0_52.storage:wants_to_overwrite() then
		return LocalUserStorageStateSaving
	elseif A0_52.storage:wants_to_select_storage_for_saving() then
		return LocalUserStorageStateOpenSelectForSaving
	end
end
LocalUserStorageStateNotFoundForSaving = LocalUserStorageStateNotFoundForSaving or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateNotFoundForSaving.init(A0_53)
	LocalUserStorageStateDetectSignOut.init(A0_53)
	A0_53.storage:clear_wants_to_select_storage_for_saving()
	A0_53.storage:clear_wants_to_continue_without_saving()
	A0_53.storage:clear_do_not_want_to_continue_without_saving()
	A0_53.storage._waits_for_continue_without_saving = true
end
function LocalUserStorageStateNotFoundForSaving.exit(A0_54)
	A0_54.storage._waits_for_continue_without_saving = nil
end
function LocalUserStorageStateNotFoundForSaving.transition(A0_55)
	if A0_55.storage:wants_to_continue_without_saving() then
		return LocalUserStorageStateNoSaving
	elseif A0_55.storage:do_not_want_to_continue_without_saving() then
		return LocalUserStorageStateOpenSelectForSaving
	elseif A0_55.storage:wants_to_select_storage_for_saving() then
		return LocalUserStorageStateOpenSelectForSaving
	end
end
LocalUserStorageStateSaving = LocalUserStorageStateSaving or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateSaving.init(A0_56)
	LocalUserStorageStateDetectSignOut.init(A0_56)
	A0_56.storage:_save()
end
function LocalUserStorageStateSaving.exit(A0_57)
	A0_57.storage:_close_save_task()
end
function LocalUserStorageStateSaving.transition(A0_58)
	if not A0_58.storage:_save_status() then
		return
	end
	if A0_58.storage:_save_status() == SaveData.OK then
		A0_58.storage._save_for_the_first_time = nil
		return LocalUserStorageStateSaved
	elseif A0_58.storage:_save_status() == SaveData.XBOX_CONTENT then
		return LocalUserStorageStateLost
	else
		return LocalUserStorageStateSaveFailed
	end
end
LocalUserStorageStateSaveFailed = LocalUserStorageStateSaveFailed or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateSaveFailed.init(A0_59)
	LocalUserStorageStateDetectSignOut.init(A0_59)
	A0_59.storage:_clear_wants_to_save()
	A0_59.storage._waits_for_retry_saving = true
end
function LocalUserStorageStateSaveFailed.exit(A0_60)
	A0_60.storage._waits_for_retry_saving = false
end
function LocalUserStorageStateSaveFailed.transition(A0_61)
	if A0_61.storage:_wants_to_save() then
		return LocalUserStorageStateSaving
	elseif A0_61.storage:wants_to_select_storage_for_saving() then
		return LocalUserStorageStateOpenSelectForSaving
	end
end
LocalUserStorageStateSaved = LocalUserStorageStateSaved or class(FiniteStateMachineState)
function LocalUserStorageStateSaved.init(A0_62)
	A0_62.storage:_clear_wants_to_save()
end
function LocalUserStorageStateSaved.transition(A0_63)
	local L1_64
	L1_64 = LocalUserStorageStateReady
	return L1_64
end
LocalUserStorageStateLost = LocalUserStorageStateLost or class(LocalUserStorageStateDetectSignOut)
function LocalUserStorageStateLost.init(A0_65)
	LocalUserStorageStateDetectSignOut.init(A0_65)
	A0_65.storage._waits_for_storage_lost = true
	A0_65.storage:clear_last_saved_to_device_id()
	A0_65.storage:clear_storage_device_lost()
end
function LocalUserStorageStateLost.exit(A0_66)
	A0_66.storage._waits_for_storage_lost = false
	A0_66.storage:clear_wants_to_select_storage_after_lost()
end
function LocalUserStorageStateLost.transition(A0_67)
	if A0_67.storage:wants_to_select_storage_after_lost() then
		return LocalUserStorageStateOpenSelectForSaving
	end
end
