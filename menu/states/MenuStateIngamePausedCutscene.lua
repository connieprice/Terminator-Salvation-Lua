if not MenuStateIngamePausedCutscene then
	MenuStateIngamePausedCutscene = class(FiniteStateMachineState)
end
MenuStateIngamePausedCutscene.init = function(l_1_0)
	l_1_0._menu:gui_interface():set_state("ingame")
	managers.volume:activate_set("movie")
	local l_1_1 = managers.game_transition:cutscene_id()
	managers.game_transition:clear_wants_to_show_cutscene()
	managers.cutscene:play_cutscene(l_1_1)
	l_1_0._frame_count_playing = 0
	l_1_0._menu._is_in_cutscene = true
end

MenuStateIngamePausedCutscene.exit = function(l_2_0)
	l_2_0._menu._is_in_cutscene = nil
end

MenuStateIngamePausedCutscene.update = function(l_3_0, l_3_1)
	if not managers.cutscene:is_playing() then
		l_3_0._menu:ingame_gui():set_faded_down()
		managers.game_transition:request_unpause()
		managers.game_transition:request_cutscene_unpause()
	end
	if not l_3_0._frame_count_playing then
		l_3_0._frame_count_playing = l_3_0._executed_post_init or not managers.cutscene:is_playing() or 0
	end
	l_3_0._frame_count_playing = l_3_0._frame_count_playing + 1
	if l_3_0._frame_count_playing > 10 then
		l_3_0._menu:ingame_gui():fade_up()
		l_3_0._executed_post_init = true
	end
end

MenuStateIngamePausedCutscene.exit = function(l_4_0)
	managers.volume:deactivate_set("movie")
	l_4_0._menu:ingame_gui():fade_down_slow()
	managers.cutscene:on_cutscene_exit()
end

MenuStateIngamePausedCutscene.transition = function(l_5_0)
end


