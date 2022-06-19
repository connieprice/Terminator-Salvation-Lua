if not MenuStatePreFrontendOnce then
	MenuStatePreFrontendOnce = class(MenuStateFadeTransition)
end
MenuStatePreFrontendOnce.init = function(l_1_0)
	MenuStateFadeTransition.init(l_1_0)
	local l_1_1 = MenuStateLegalScreen
	l_1_0._screen = FiniteStateMachine:new(l_1_0._menu, "_menu", l_1_1)
	l_1_0._screen:set_debug(true)
	l_1_0._menu:set_pre_frontend_once_shown()
	Sound:override_music(true)
	cat_print("debug", "Overriding music begin")
end

MenuStatePreFrontendOnce.update = function(l_2_0, l_2_1)
	if l_2_0._next_state then
		return 
	end
	l_2_0._screen:update(l_2_1)
end

MenuStatePreFrontendOnce.exit = function(l_3_0, l_3_1)
	l_3_0._screen:destroy()
	Sound:override_music(false)
	cat_print("debug", "Overriding music end")
end

MenuStatePreFrontendOnce.transition = function(l_4_0)
	if managers.game_transition:should_pass_through_menu() then
		return MenuStatePreFrontend
	else
		if not managers.game:is_in_pre_frontend() then
			return MenuStatePreFrontend
		end
		if managers.game:is_in_frontend() or managers.game_transition:wants_to_host_session() then
			return MenuStateFrontend
		end
	else
		if l_4_0._menu:is_intro_movies_done() then
			return MenuStatePreFrontend
		end
	end
end


