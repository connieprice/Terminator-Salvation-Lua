if not MenuStatePublisher3Movie then
	MenuStatePublisher3Movie = class(MenuStateMovie)
end
MenuStatePublisher3Movie.init = function(l_1_0)
	MenuStateMovie.init(l_1_0)
	l_1_0:play("EvolvedAnimation")
end

MenuStatePublisher3Movie.next_state = function(l_2_0)
	return MenuStatePublisherMovie
end


