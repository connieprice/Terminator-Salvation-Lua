if not MenuStatePublisherMovie then
	MenuStatePublisherMovie = class(MenuStateMovie)
end
MenuStatePublisherMovie.init = function(l_1_0)
	MenuStateMovie.init(l_1_0)
	l_1_0:play("warner_logo")
end

MenuStatePublisherMovie.next_state = function(l_2_0)
	return MenuStateSponsorMovie1
end


