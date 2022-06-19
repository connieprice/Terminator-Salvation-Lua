MenuStateSponsorMovie1 = MenuStateSponsorMovie1 or class(MenuStateMovie)
function MenuStateSponsorMovie1.init(A0_0)
	MenuStateMovie.init(A0_0)
	A0_0:play("alienware")
end
function MenuStateSponsorMovie1.next_state(A0_1)
	local L1_2
	L1_2 = MenuStateIntroMoviesDone
	return L1_2
end
