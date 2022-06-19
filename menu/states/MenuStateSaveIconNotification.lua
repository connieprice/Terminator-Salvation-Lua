if not MenuStateSaveIconNotification then
	MenuStateSaveIconNotification = class(FiniteStateMachineState)
end
MenuStateSaveIconNotification.init = function(l_1_0)
	assert(managers.save:profile())
	l_1_0._menu:clear_save_notification_dismissed()
	if l_1_0:_active() then
		l_1_0._menu:gui_interface():set_state("save_icon_notification")
	end
end

MenuStateSaveIconNotification.transition = function(l_2_0)
	if not l_2_0:_active() then
		return MenuStateMainMenu
	end
end

MenuStateSaveIconNotification._active = function(l_3_0)
	if SystemInfo:platform() == "WIN32" then
		return false
	end
	local l_3_1 = nil
	if managers.menu_input:has_bound_user() then
		local l_3_2 = managers.menu_input:bound_user()
		l_3_1 = l_3_2:save_disabled()
	end
	return l_3_0._menu:is_save_notification_dismissed() or l_3_1
end


