MenuStatePreFrontend = MenuStatePreFrontend or class(FiniteStateMachineState)
function MenuStatePreFrontend.init(A0_0)
	local L1_1
	if Global.zone_data and Global.zone_data.show_end_credits then
		L1_1 = MenuStateEndCredits
		Global.zone_data.show_end_credits = false
	else
		L1_1 = MenuStateMainMenuTitle
	end
	managers.game_transition:clear_wants_to_go_to_pre_frontend()
	A0_0._screen = FiniteStateMachine:new(A0_0._menu, "_menu", L1_1)
	A0_0._screen:set_debug(true)
	managers.menu_input:release_bound_user()
end
function MenuStatePreFrontend.update(A0_2, A1_3)
	A0_2._screen:update(A1_3)
	if managers.game_transition:should_pass_through_menu() and (managers.game:is_in_frontend() or managers.game_transition:wants_to_host_session()) then
		A0_2._wait_time = A0_2._wait_time or 0
		A0_2._wait_time = A0_2._wait_time + A1_3
	end
end
function MenuStatePreFrontend.exit(A0_4, A1_5)
	A0_4._screen:destroy()
end
function MenuStatePreFrontend.transition(A0_6)
	if managers.game_transition:should_pass_through_menu() and A0_6._wait_time < 3 then
		return
	end
	if not managers.game:is_in_pre_frontend() then
		return MenuStateFrontend
	end
end
