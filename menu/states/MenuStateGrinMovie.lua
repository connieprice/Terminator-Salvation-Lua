MenuStateGrinMovie = MenuStateGrinMovie or class(MenuStateMovie)
function MenuStateGrinMovie.init(A0_0)
	MenuStateMovie.init(A0_0)
	A0_0:play("grin_logo")
end
function MenuStateGrinMovie.next_state(A0_1)
	local L1_2
	L1_2 = MenuStatePublisher2Movie
	return L1_2
end
