MenuStatePublisher2Movie = MenuStatePublisher2Movie or class(MenuStateMovie)
function MenuStatePublisher2Movie.init(A0_0)
	MenuStateMovie.init(A0_0)
	A0_0:play("EquityGamesLogo")
end
function MenuStatePublisher2Movie.next_state(A0_1)
	local L1_2
	L1_2 = MenuStatePublisher3Movie
	return L1_2
end
