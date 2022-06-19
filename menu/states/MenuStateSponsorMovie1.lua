if not MenuStateSponsorMovie1 then
	MenuStateSponsorMovie1 = class(MenuStateMovie)
end
MenuStateSponsorMovie1.init = function(l_1_0)
	MenuStateMovie.init(l_1_0)
	l_1_0:play("alienware")
end

MenuStateSponsorMovie1.next_state = function(l_2_0)
	return MenuStateIntroMoviesDone
end


