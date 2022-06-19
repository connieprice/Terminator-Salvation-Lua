if not MenuStatePublisher2Movie then
	MenuStatePublisher2Movie = class(MenuStateMovie)
end
MenuStatePublisher2Movie.init = function(l_1_0)
	MenuStateMovie.init(l_1_0)
	l_1_0:play("EquityGamesLogo")
end

MenuStatePublisher2Movie.next_state = function(l_2_0)
	return MenuStatePublisher3Movie
end


