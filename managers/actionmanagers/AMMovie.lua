AMMovie = AMMovie or class(CoreActionElement)
function AMMovie.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMMovie.activate_now(A0_3)
	local L1_4
	L1_4 = string
	L1_4 = L1_4.lower
	L1_4 = L1_4(A0_3.movie_id)
	managers.game_transition:request_cutscene(L1_4)
	A0_3:deactivate_now()
end
