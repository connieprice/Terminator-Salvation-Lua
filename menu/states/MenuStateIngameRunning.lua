MenuStateIngameRunning = MenuStateIngameRunning or class(MenuStateFadeUp)
function MenuStateIngameRunning.init(A0_0)
	A0_0._menu:ingame_gui():fade_up_slow()
	A0_0._menu._is_ready_to_resume = false
	A0_0._menu:gui_interface():set_state("ingame")
end
function MenuStateIngameRunning.transition(A0_1)
	if managers.game_transition:wants_to_show_cutscene() then
		return MenuStateIngamePausingForCutscene
	elseif managers.game:is_pausing() then
		return MenuStateIngamePausing
	elseif managers.game:is_end_of_misson() then
		return MenuStateIngameEndOfMission
	end
end
function MenuStateIngameRunning.update(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2.user_requested_ingame_gui
	L2_4 = L2_4(A0_2)
	if L2_4 then
		managers.menu_input:set_bound_user(L2_4)
		managers.game_transition:request_pause()
	end
end
function MenuStateIngameRunning.user_requested_ingame_gui(A0_5)
	return (managers.menu_input:any_user_pressed(managers.local_session_user:users(), "pause"))
end
