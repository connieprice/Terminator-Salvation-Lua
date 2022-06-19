MenuStatePublisherMovie = MenuStatePublisherMovie or class(MenuStateMovie)
function MenuStatePublisherMovie.init(A0_0)
	MenuStateMovie.init(A0_0)
	A0_0:play("warner_logo")
end
function MenuStatePublisherMovie.next_state(A0_1)
	local L1_2
	L1_2 = MenuStateSponsorMovie1
	return L1_2
end
