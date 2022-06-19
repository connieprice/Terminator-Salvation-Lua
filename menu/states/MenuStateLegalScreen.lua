MenuStateLegalScreen = MenuStateLegalScreen or class(MenuStateFadeTransition)
function MenuStateLegalScreen.init(A0_0)
	MenuStateFadeTransition.init(A0_0)
	A0_0._menu:gui_interface():set_state("legal")
	A0_0._time = 0
	A0_0._end_time = 4
end
function MenuStateLegalScreen.exit(A0_1)
	local L1_2
end
function MenuStateLegalScreen.update(A0_3, A1_4)
	local L2_5
	L2_5 = A0_3._time
	L2_5 = L2_5 + A1_4
	A0_3._time = L2_5
end
function MenuStateLegalScreen.transition(A0_6)
	if managers.game_transition:should_pass_through_menu() then
		return MenuStateIntroMoviesDone
	end
	if A0_6._time > A0_6._end_time then
		return MenuStateProducerMovie
	end
end
