MenuStateFadeTransition = MenuStateFadeTransition or class(MenuStateFadeDown)
function MenuStateFadeTransition.init(A0_0, A1_1)
	if A1_1 then
		A0_0._menu:ingame_gui():fade_up()
	else
		A0_0._menu:ingame_gui():fade_up_slow()
	end
	MenuStateFadeDown.init(A0_0)
end
