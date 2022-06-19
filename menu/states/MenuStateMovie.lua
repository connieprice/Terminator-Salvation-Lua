if not MenuStateMovie then
	MenuStateMovie = class(MenuStateFadeTransition)
end
MenuStateMovie.init = function(l_1_0)
	MenuStateFadeTransition.init(l_1_0, true)
	l_1_0._menu:gui_interface():set_state("intro_movie")
	l_1_0._time = 0
	managers.viewport:push()
	managers.viewport:deactivate_all_viewports()
end

MenuStateMovie.play = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = "data/videos/" .. l_2_1 .. ".bik"
	l_2_0._movie = OverlayMovie:new(l_2_3, l_2_2)
	managers.volume:activate_set("movie")
end

MenuStateMovie.exit = function(l_3_0)
	managers.volume:deactivate_set("movie")
	l_3_0._movie:destroy()
	l_3_0._movie = nil
	managers.viewport:pop()
end

MenuStateMovie.update = function(l_4_0, l_4_1)
	l_4_0._movie:update(l_4_1)
	l_4_0._time = l_4_0._time + l_4_1
end

MenuStateMovie.transition = function(l_5_0)
	if l_5_0._movie:is_done() or not l_5_0._menu:user_wants_to_skip() or tweak_data.menu.INTRO_MOVIE_MIN_SKIP_TIME < l_5_0._time then
		local l_5_4, l_5_5 = , l_5_0:next_state
		return l_5_5(l_5_0)
	end
end


