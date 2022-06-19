if not MenuStatePreFrontend then
	MenuStatePreFrontend = class(FiniteStateMachineState)
end
MenuStatePreFrontend.init = function(l_1_0)
	local l_1_1 = nil
	if Global.zone_data and Global.zone_data.show_end_credits then
		l_1_1 = MenuStateEndCredits
		Global.zone_data.show_end_credits = false
	else
		l_1_1 = MenuStateMainMenuTitle
	end
	managers.game_transition:clear_wants_to_go_to_pre_frontend()
	l_1_0._screen = FiniteStateMachine:new(l_1_0._menu, "_menu", l_1_1)
	l_1_0._screen:set_debug(true)
	managers.menu_input:release_bound_user()
end

MenuStatePreFrontend.update = function(l_2_0, l_2_1)
	l_2_0._screen:update(l_2_1)
	if not l_2_0._wait_time then
		l_2_0._wait_time = not managers.game_transition:should_pass_through_menu() or (not managers.game:is_in_frontend() and not managers.game_transition:wants_to_host_session()) or 0
	end
	l_2_0._wait_time = l_2_0._wait_time + l_2_1
end

MenuStatePreFrontend.exit = function(l_3_0, l_3_1)
	l_3_0._screen:destroy()
end

MenuStatePreFrontend.transition = function(l_4_0)
	if managers.game_transition:should_pass_through_menu() and l_4_0._wait_time < 3 then
		return 
	end
	if not managers.game:is_in_pre_frontend() then
		return MenuStateFrontend
	end
end


