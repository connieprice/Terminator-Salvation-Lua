if not MenuStatePreFrontendSyncDone then
	MenuStatePreFrontendSyncDone = class(FiniteStateMachineState)
end
MenuStatePreFrontendSyncDone.init = function(l_1_0)
	l_1_0._menu:_set_frontend_ready()
end

MenuStatePreFrontendSyncDone.exit = function(l_2_0)
	l_2_0._menu:_clear_frontend_ready()
end

MenuStatePreFrontendSyncDone.transition = function(l_3_0)
	if managers.game:show_menu_frontend_requested() then
		if not l_3_0._menu:has_shown_pre_frontend_once() then
			return MenuStatePreFrontendOnce
		end
	else
		return MenuStatePreFrontend
	end
	if managers.game:requested_menu_sync_start() then
		local l_3_1 = managers.game:requested_menu_sync_type()
		local l_3_2 = MenuStateSyncTypes.get_sync_type_class
		local l_3_3 = l_3_1
		return l_3_2(l_3_3)
	end
end


