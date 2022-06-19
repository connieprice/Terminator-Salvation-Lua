if not MenuStateSyncStarted then
	MenuStateSyncStarted = class(FiniteStateMachineState)
end
MenuStateSyncStarted.init = function(l_1_0)
	l_1_0._menu:_set_sync_started()
end

MenuStateSyncStarted.exit = function(l_2_0)
	l_2_0._menu:_clear_sync_started()
end

MenuStateSyncStarted.transition = function(l_3_0)
	if managers.game:menu_frontend_requested() then
		local l_3_1 = managers.game:menu_frontend_type()
		local l_3_2, l_3_3 = l_3_0._menu:_frontend_end_sync_state, l_3_0._menu
		local l_3_4 = l_3_1
		return l_3_2(l_3_3, l_3_4)
	end
	if managers.game:menu_ingame_requested() then
		return MenuStateIngame
	end
end


