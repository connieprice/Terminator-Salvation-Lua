if not MenuStateAttract then
	MenuStateAttract = class(MenuStateMovie)
end
MenuStateAttract.init = function(l_1_0)
	MenuStateMovie.init(l_1_0)
	l_1_0._movie_name = "attract"
	l_1_0._menu:gui_interface():set_state("attract")
	managers.music:override_user_music(true)
	l_1_0:play(l_1_0._movie_name, true)
end

MenuStateAttract.update = function(l_2_0, l_2_1)
	l_2_0._movie:update(l_2_1)
	if not l_2_0._user_skip then
		l_2_0._user_skip = l_2_0._menu:user_wants_to_skip()
	end
end

MenuStateAttract.exit = function(l_3_0)
	managers.music:override_user_music(false)
	MenuStateMovie.exit(l_3_0)
	MenuStateFadeUp.init(l_3_0)
end

MenuStateAttract.transition = function(l_4_0)
	local l_4_1 = l_4_0._menu:user_wants_to_skip()
	if l_4_1 or l_4_0._movie:is_done() then
		local l_4_2, l_4_3 = l_4_0:next_state, l_4_0
		return l_4_2(l_4_3)
	end
end

MenuStateAttract.next_state = function(l_5_0)
	return MenuStateMainMenuTitle
end


