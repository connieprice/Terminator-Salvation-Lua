if not MenuStateFadeTransition then
	MenuStateFadeTransition = class(MenuStateFadeDown)
end
MenuStateFadeTransition.init = function(l_1_0, l_1_1)
	if l_1_1 then
		l_1_0._menu:ingame_gui():fade_up()
	else
		l_1_0._menu:ingame_gui():fade_up_slow()
	end
	MenuStateFadeDown.init(l_1_0)
end


