MenuStateProducerMovie = MenuStateProducerMovie or class(MenuStateMovie)
function MenuStateProducerMovie.init(A0_0)
	MenuStateMovie.init(A0_0)
	A0_0:play("HalcyonAnimation")
end
function MenuStateProducerMovie.next_state(A0_1)
	local L1_2
	L1_2 = MenuStateGrinMovie
	return L1_2
end
