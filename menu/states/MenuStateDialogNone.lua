MenuStateDialogNone = MenuStateDialogNone or class(MenuStateFadeTransition)
function MenuStateDialogNone.init(A0_0)
	A0_0._menu:release_dialog_user()
	A0_0._menu._is_in_dialog = false
	managers.game_transition:request_unfreeze()
end
function MenuStateDialogNone.exit(A0_1)
	A0_1._menu._is_in_dialog = true
	managers.game_transition:request_freeze()
end
function MenuStateDialogNone.transition(A0_2)
	local L1_3
	if managers.game_transition:pre_frontend_due_to_sign_out() then
		if managers.game:is_in_pre_frontend() then
			return MenuStateDialogPreFrontendDueToSignOut
		else
			return
		end
	end
	L1_3 = A0_2:_check_user_states()
	if L1_3 then
		return L1_3
	end
	L1_3 = A0_2:_check_standard_states()
	if L1_3 then
		return L1_3
	end
end
function MenuStateDialogNone._check_standard_states(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9, L6_10, L7_11, L8_12
	L1_5 = {
		L2_6,
		L3_7,
		L4_8,
		L5_9,
		L6_10
	}
	L5_9 = MenuStateDialogRetryLoad
	L5_9 = LocalUserStorage
	L5_9 = L5_9.waits_for_retry_saving
	L6_10 = MenuStateDialogRetrySave
	L5_9 = {L6_10, L7_11}
	L6_10 = LocalUserStorage
	L6_10 = L6_10.waits_for_continue_without_saving
	L7_11 = MenuStateDialogContinueWithoutSaving
	L6_10 = {L7_11, L8_12}
	L7_11 = LocalUserStorage
	L7_11 = L7_11.waits_for_overwrite_confirmation
	L8_12 = MenuStateDialogOverwriteSaveGame
	for L5_9, L6_10 in L2_6(L3_7) do
		L7_11 = L6_10[1]
		L8_12 = L6_10[2]
		if A0_4:_transition(L7_11, L8_12) then
			return (A0_4:_transition(L7_11, L8_12))
		end
	end
end
function MenuStateDialogNone._check_user_states(A0_13)
	if A0_13._menu:disconnected_controller_index() then
		return MenuStateDialogControllerLost
	end
end
function MenuStateDialogNone._transition(A0_14, A1_15, A2_16)
	local L3_17, L4_18, L5_19, L6_20, L7_21, L8_22, L9_23
	L3_17 = managers
	L3_17 = L3_17.local_user
	L3_17 = L3_17.users
	L3_17 = L3_17(L4_18)
	for L7_21, L8_22 in L4_18(L5_19) do
		L9_23 = L8_22.wants_to_play
		L9_23 = L9_23(L8_22)
		if L9_23 then
			L9_23 = L8_22._storage
			if A1_15(L9_23) then
				A0_14._menu:set_dialog_user(L8_22)
				return A2_16
			end
		end
	end
end
