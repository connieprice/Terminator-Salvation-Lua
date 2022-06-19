if not MenuStateIntroMoviesDone then
	MenuStateIntroMoviesDone = class(FiniteStateMachineState)
end
MenuStateIntroMoviesDone.init = function(l_1_0)
	l_1_0._menu:set_intro_movies_done()
end

MenuStateIntroMoviesDone.exit = function(l_2_0)
	l_2_0._menu:clear_intro_movies_done()
end

MenuStateIntroMoviesDone.transition = function(l_3_0)
	return MenuStateMainMenuTitle
end


