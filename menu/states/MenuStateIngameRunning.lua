if not MenuStateIngameRunning then
	MenuStateIngameRunning = class(MenuStateFadeUp)
end
MenuStateIngameRunning.init = function(l_1_0)
	l_1_0._menu:ingame_gui():fade_up_slow()
	l_1_0._menu._is_ready_to_resume = false
	l_1_0._menu:gui_interface():set_state("ingame")
end

MenuStateIngameRunning.transition = function(l_2_0)
	if managers.game_transition:wants_to_show_cutscene() then
		return MenuStateIngamePausingForCutscene
	else
		if managers.game:is_pausing() then
			return MenuStateIngamePausing
		end
	else
		if managers.game:is_end_of_misson() then
			return MenuStateIngameEndOfMission
		end
	end
end

MenuStateIngameRunning.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0:user_requested_ingame_gui()
	if l_3_2 then
		managers.menu_input:set_bound_user(l_3_2)
		managers.game_transition:request_pause()
	end
end

MenuStateIngameRunning.user_requested_ingame_gui = function(l_4_0)
	return managers.menu_input:any_user_pressed(managers.local_session_user:users(), "pause")
end


