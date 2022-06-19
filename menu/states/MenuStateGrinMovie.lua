if not MenuStateGrinMovie then
	MenuStateGrinMovie = class(MenuStateMovie)
end
MenuStateGrinMovie.init = function(l_1_0)
	MenuStateMovie.init(l_1_0)
	l_1_0:play("grin_logo")
end

MenuStateGrinMovie.next_state = function(l_2_0)
	return MenuStatePublisher2Movie
end


