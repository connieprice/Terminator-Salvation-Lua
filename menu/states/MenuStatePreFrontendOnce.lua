MenuStatePreFrontendOnce = MenuStatePreFrontendOnce or class(MenuStateFadeTransition)
function MenuStatePreFrontendOnce.init(A0_0)
	local L1_1
	L1_1 = MenuStateFadeTransition
	L1_1 = L1_1.init
	L1_1(A0_0)
	L1_1 = MenuStateLegalScreen
	A0_0._screen = FiniteStateMachine:new(A0_0._menu, "_menu", L1_1)
	A0_0._screen:set_debug(true)
	A0_0._menu:set_pre_frontend_once_shown()
	Sound:override_music(true)
	cat_print("debug", "Overriding music begin")
end
function MenuStatePreFrontendOnce.update(A0_2, A1_3)
	if A0_2._next_state then
		return
	end
	A0_2._screen:update(A1_3)
end
function MenuStatePreFrontendOnce.exit(A0_4, A1_5)
	A0_4._screen:destroy()
	Sound:override_music(false)
	cat_print("debug", "Overriding music end")
end
function MenuStatePreFrontendOnce.transition(A0_6)
	if managers.game_transition:should_pass_through_menu() then
		return MenuStatePreFrontend
	else
		if not managers.game:is_in_pre_frontend() then
			return MenuStatePreFrontend
		end
		if managers.game:is_in_frontend() or managers.game_transition:wants_to_host_session() then
			return MenuStateFrontend
		elseif A0_6._menu:is_intro_movies_done() then
			return MenuStatePreFrontend
		end
	end
end
