MenuStateMovie = MenuStateMovie or class(MenuStateFadeTransition)
function MenuStateMovie.init(A0_0)
	MenuStateFadeTransition.init(A0_0, true)
	A0_0._menu:gui_interface():set_state("intro_movie")
	A0_0._time = 0
	managers.viewport:push()
	managers.viewport:deactivate_all_viewports()
end
function MenuStateMovie.play(A0_1, A1_2, A2_3)
	local L3_4
	L3_4 = "data/videos/"
	L3_4 = L3_4 .. A1_2 .. ".bik"
	A0_1._movie = OverlayMovie:new(L3_4, A2_3)
	managers.volume:activate_set("movie")
end
function MenuStateMovie.exit(A0_5)
	managers.volume:deactivate_set("movie")
	A0_5._movie:destroy()
	A0_5._movie = nil
	managers.viewport:pop()
end
function MenuStateMovie.update(A0_6, A1_7)
	A0_6._movie:update(A1_7)
	A0_6._time = A0_6._time + A1_7
end
function MenuStateMovie.transition(A0_8)
	if A0_8._movie:is_done() or A0_8._menu:user_wants_to_skip() and A0_8._time > tweak_data.menu.INTRO_MOVIE_MIN_SKIP_TIME then
		return A0_8:next_state()
	end
end
