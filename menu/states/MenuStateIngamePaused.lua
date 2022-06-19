MenuStateIngamePaused = MenuStateIngamePaused or class(MenuStateFadeTransition)
function MenuStateIngamePaused.init(A0_0)
	local L1_1
	L1_1 = A0_0._menu
	L1_1 = L1_1.set_ingame_paused
	L1_1(L1_1, true)
	L1_1 = nil
	if managers.game_transition:is_game_over() then
		L1_1 = MenuStateIngamePausedGameOver
	elseif managers.game_transition:wants_to_show_cutscene() then
		L1_1 = MenuStateIngamePausedCutscene
	else
		L1_1 = MenuStateIngamePausedNormal
	end
	A0_0._pause_menu = FiniteStateMachine:new(A0_0._menu, "_menu", L1_1)
	A0_0._pause_menu:set_debug(true)
end
function MenuStateIngamePaused.update(A0_2, A1_3)
	A0_2._pause_menu:update(A1_3)
end
function MenuStateIngamePaused.exit(A0_4)
	A0_4._menu:set_ingame_paused(false)
	managers.menu_input:set_bound_user(managers.save:primary_user())
	A0_4._pause_menu:destroy()
end
function MenuStateIngamePaused.transition(A0_5)
	if managers.game:is_resuming() then
		if A0_5._menu._is_in_cutscene then
			return MenuStateIngameResumingFromCutscene
		else
			return MenuStateIngameResuming
		end
	end
end
