if not MenuStateProducerMovie then
	MenuStateProducerMovie = class(MenuStateMovie)
end
MenuStateProducerMovie.init = function(l_1_0)
	MenuStateMovie.init(l_1_0)
	l_1_0:play("HalcyonAnimation")
end

MenuStateProducerMovie.next_state = function(l_2_0)
	return MenuStateGrinMovie
end


