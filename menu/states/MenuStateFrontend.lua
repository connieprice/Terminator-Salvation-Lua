require("menu/states/MenuStateSyncTypes")
if not MenuStateFrontend then
	MenuStateFrontend = class(MenuStateFadeTransition)
end
MenuStateFrontend.init = function(l_1_0)
	MenuStateFadeUp.init(l_1_0)
	local l_1_1 = managers.menu_input:bound_user()
	local l_1_2 = (l_1_1:save_disabled())
	local l_1_3 = nil
	if not l_1_2 then
		l_1_3 = MenuStateSaveIconNotification
	else
		l_1_3 = MenuStateMainMenu
	end
	l_1_0._machine = FiniteStateMachine:new(l_1_0._menu, "_menu", l_1_3)
end

MenuStateFrontend.exit = function(l_2_0)
	l_2_0._machine:destroy()
end

MenuStateFrontend.update = function(l_3_0, l_3_1)
	l_3_0._machine:update(l_3_1)
	if not l_3_0._wait_time then
		l_3_0._wait_time = (not managers.game_transition:should_pass_through_menu() or 0) + l_3_1
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

MenuStateFrontend.transition = function(l_4_0)
	if managers.game:is_in_pre_frontend() then
		return MenuStatePreFrontend
	end
	if managers.game_transition:should_pass_through_menu() and l_4_0._wait_time < 5 then
		return 
	end
	if managers.game:requested_menu_sync_start() then
		local l_4_1 = managers.game:requested_menu_sync_type()
		local l_4_2 = MenuStateSyncTypes.get_sync_type_class
		local l_4_3 = l_4_1
		return l_4_2(l_4_3)
	end
end


