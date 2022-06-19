if not AMMovie then
	AMMovie = class(CoreActionElement)
end
AMMovie.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMMovie.activate_now = function(l_2_0)
	local l_2_1 = string.lower(l_2_0.movie_id)
	managers.game_transition:request_cutscene(l_2_1)
	l_2_0:deactivate_now()
end


