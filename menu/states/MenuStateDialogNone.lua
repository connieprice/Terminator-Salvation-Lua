if not MenuStateDialogNone then
	MenuStateDialogNone = class(MenuStateFadeTransition)
end
MenuStateDialogNone.init = function(l_1_0)
	l_1_0._menu:release_dialog_user()
	l_1_0._menu._is_in_dialog = false
	managers.game_transition:request_unfreeze()
end

MenuStateDialogNone.exit = function(l_2_0)
	l_2_0._menu._is_in_dialog = true
	managers.game_transition:request_freeze()
end

MenuStateDialogNone.transition = function(l_3_0)
	local l_3_1 = nil
	if managers.game_transition:pre_frontend_due_to_sign_out() and managers.game:is_in_pre_frontend() then
		return MenuStateDialogPreFrontendDueToSignOut
	else
		return 
	end
	l_3_1 = l_3_0:_check_user_states()
	if l_3_1 then
		return l_3_1
	end
	l_3_1 = l_3_0:_check_standard_states()
	if l_3_1 then
		return l_3_1
	end
end

MenuStateDialogNone._check_standard_states = function(l_4_0)
	local l_4_1 = {}
	local l_4_2 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_4_3 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_4_4 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_4_5 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	local l_4_6 = {}
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	for l_4_5,l_4_6 in l_4_2 do
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_4_7 = MenuStateDialogContinueWithoutSaving.waits_for_overwrite_confirmation
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_4_8 = MenuStateDialogOverwriteSaveGame
		local l_4_9 = l_4_0:_transition(l_4_7, l_4_8)
		if l_4_9 then
			return l_4_9
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MenuStateDialogNone._check_user_states = function(l_5_0)
	if l_5_0._menu:disconnected_controller_index() then
		return MenuStateDialogControllerLost
	end
end

MenuStateDialogNone._transition = function(l_6_0, l_6_1, l_6_2)
	local l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12 = nil
	local l_6_3 = managers.local_user:users()
	for i_0,i_1 in pairs(l_6_3) do
		if i_1:wants_to_play() and l_6_1(i_1._storage) then
			l_6_0._menu:set_dialog_user(i_1)
			return l_6_2
		end
	end
end


