MenuStateAttract = MenuStateAttract or class(MenuStateMovie)
function MenuStateAttract.init(A0_0)
	MenuStateMovie.init(A0_0)
	A0_0._movie_name = "attract"
	A0_0._menu:gui_interface():set_state("attract")
	managers.music:override_user_music(true)
	A0_0:play(A0_0._movie_name, true)
end
function MenuStateAttract.update(A0_1, A1_2)
	A0_1._movie:update(A1_2)
	if not A0_1._user_skip then
		A0_1._user_skip = A0_1._menu:user_wants_to_skip()
	end
end
function MenuStateAttract.exit(A0_3)
	managers.music:override_user_music(false)
	MenuStateMovie.exit(A0_3)
	MenuStateFadeUp.init(A0_3)
end
function MenuStateAttract.transition(A0_4)
	if A0_4._menu:user_wants_to_skip() or A0_4._movie:is_done() then
		return A0_4:next_state()
	end
end
function MenuStateAttract.next_state(A0_5)
	local L1_6
	L1_6 = MenuStateMainMenuTitle
	return L1_6
end
