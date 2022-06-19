MenuStateIngamePausedCutscene = MenuStateIngamePausedCutscene or class(FiniteStateMachineState)
function MenuStateIngamePausedCutscene.init(A0_0)
	local L1_1
	L1_1 = A0_0._menu
	L1_1 = L1_1.gui_interface
	L1_1 = L1_1(L1_1)
	L1_1 = L1_1.set_state
	L1_1(L1_1, "ingame")
	L1_1 = managers
	L1_1 = L1_1.volume
	L1_1 = L1_1.activate_set
	L1_1(L1_1, "movie")
	L1_1 = managers
	L1_1 = L1_1.game_transition
	L1_1 = L1_1.cutscene_id
	L1_1 = L1_1(L1_1)
	managers.game_transition:clear_wants_to_show_cutscene()
	managers.cutscene:play_cutscene(L1_1)
	A0_0._frame_count_playing = 0
	A0_0._menu._is_in_cutscene = true
end
function MenuStateIngamePausedCutscene.exit(A0_2)
	A0_2._menu._is_in_cutscene = nil
end
function MenuStateIngamePausedCutscene.update(A0_3, A1_4)
	if not managers.cutscene:is_playing() then
		A0_3._menu:ingame_gui():set_faded_down()
		managers.game_transition:request_unpause()
		managers.game_transition:request_cutscene_unpause()
	end
	if not A0_3._executed_post_init and managers.cutscene:is_playing() then
		A0_3._frame_count_playing = A0_3._frame_count_playing or 0
		A0_3._frame_count_playing = A0_3._frame_count_playing + 1
		if A0_3._frame_count_playing > 10 then
			A0_3._menu:ingame_gui():fade_up()
			A0_3._executed_post_init = true
		end
	end
end
function MenuStateIngamePausedCutscene.exit(A0_5)
	managers.volume:deactivate_set("movie")
	A0_5._menu:ingame_gui():fade_down_slow()
	managers.cutscene:on_cutscene_exit()
end
function MenuStateIngamePausedCutscene.transition(A0_6)
	local L1_7
end
