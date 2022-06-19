MenuStateSaveIconNotification = MenuStateSaveIconNotification or class(FiniteStateMachineState)
function MenuStateSaveIconNotification.init(A0_0)
	assert(managers.save:profile())
	A0_0._menu:clear_save_notification_dismissed()
	if A0_0:_active() then
		A0_0._menu:gui_interface():set_state("save_icon_notification")
	end
end
function MenuStateSaveIconNotification.transition(A0_1)
	if not A0_1:_active() then
		return MenuStateMainMenu
	end
end
function MenuStateSaveIconNotification._active(A0_2)
	local L1_3
	L1_3 = SystemInfo
	L1_3 = L1_3.platform
	L1_3 = L1_3(L1_3)
	if L1_3 == "WIN32" then
		L1_3 = false
		return L1_3
	end
	L1_3 = nil
	if managers.menu_input:has_bound_user() then
		L1_3 = managers.menu_input:bound_user():save_disabled()
	end
	return A0_2._menu:is_save_notification_dismissed() or L1_3
end
