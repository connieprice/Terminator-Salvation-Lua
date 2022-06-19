if not MenuStateIngamePaused then
	MenuStateIngamePaused = class(MenuStateFadeTransition)
end
MenuStateIngamePaused.init = function(l_1_0)
	l_1_0._menu:set_ingame_paused(true)
	local l_1_1 = nil
	if managers.game_transition:is_game_over() then
		l_1_1 = MenuStateIngamePausedGameOver
	else
		if managers.game_transition:wants_to_show_cutscene() then
			l_1_1 = MenuStateIngamePausedCutscene
		end
	else
		l_1_1 = MenuStateIngamePausedNormal
	end
	l_1_0._pause_menu = FiniteStateMachine:new(l_1_0._menu, "_menu", l_1_1)
	l_1_0._pause_menu:set_debug(true)
end

MenuStateIngamePaused.update = function(l_2_0, l_2_1)
	l_2_0._pause_menu:update(l_2_1)
end

MenuStateIngamePaused.exit = function(l_3_0)
	l_3_0._menu:set_ingame_paused(false)
	managers.menu_input:set_bound_user(managers.save:primary_user())
	l_3_0._pause_menu:destroy()
end

MenuStateIngamePaused.transition = function(l_4_0)
	if managers.game:is_resuming() then
		if l_4_0._menu._is_in_cutscene then
			return MenuStateIngameResumingFromCutscene
		end
	else
		return MenuStateIngameResuming
	end
end


