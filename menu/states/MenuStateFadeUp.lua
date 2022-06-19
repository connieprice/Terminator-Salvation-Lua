if not MenuStateFadeUp then
	MenuStateFadeUp = class(FiniteStateMachineState)
end
MenuStateFadeUp.init = function(l_1_0)
	l_1_0._menu:ingame_gui():fade_up()
end


