MenuStateIntroMoviesDone = MenuStateIntroMoviesDone or class(FiniteStateMachineState)
function MenuStateIntroMoviesDone.init(A0_0)
	A0_0._menu:set_intro_movies_done()
end
function MenuStateIntroMoviesDone.exit(A0_1)
	A0_1._menu:clear_intro_movies_done()
end
function MenuStateIntroMoviesDone.transition(A0_2)
	local L1_3
	L1_3 = MenuStateMainMenuTitle
	return L1_3
end
