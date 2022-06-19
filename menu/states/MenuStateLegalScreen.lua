if not MenuStateLegalScreen then
	MenuStateLegalScreen = class(MenuStateFadeTransition)
end
MenuStateLegalScreen.init = function(l_1_0)
	MenuStateFadeTransition.init(l_1_0)
	l_1_0._menu:gui_interface():set_state("legal")
	l_1_0._time = 0
	l_1_0._end_time = 4
end

MenuStateLegalScreen.exit = function(l_2_0)
end

MenuStateLegalScreen.update = function(l_3_0, l_3_1)
	l_3_0._time = l_3_0._time + l_3_1
end

MenuStateLegalScreen.transition = function(l_4_0)
	if managers.game_transition:should_pass_through_menu() then
		return MenuStateIntroMoviesDone
	end
	if l_4_0._end_time < l_4_0._time then
		return MenuStateProducerMovie
	end
end


