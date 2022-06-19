MenuStatePublisher3Movie = MenuStatePublisher3Movie or class(MenuStateMovie)
function MenuStatePublisher3Movie.init(A0_0)
	MenuStateMovie.init(A0_0)
	A0_0:play("EvolvedAnimation")
end
function MenuStatePublisher3Movie.next_state(A0_1)
	local L1_2
	L1_2 = MenuStatePublisherMovie
	return L1_2
end
