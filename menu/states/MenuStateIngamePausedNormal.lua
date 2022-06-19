MenuStateIngamePausedNormal = MenuStateIngamePausedNormal or class(FiniteStateMachineState)
function MenuStateIngamePausedNormal.init(A0_0)
	A0_0._menu:gui_interface():set_state("paused")
end
function MenuStateIngamePausedNormal.update(A0_1, A1_2)
end
function MenuStateIngamePausedNormal.exit(A0_3)
	local L1_4
end
function MenuStateIngamePausedNormal.transition(A0_5)
	if managers.game_transition:is_game_over() then
		return MenuStateIngamePausedGameOver
	elseif managers.game_transition:wants_to_show_cutscene() then
		return MenuStateIngamePausedCutscene
	end
end
