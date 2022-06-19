MenuStateFadeUp = MenuStateFadeUp or class(FiniteStateMachineState)
function MenuStateFadeUp.init(A0_0)
	A0_0._menu:ingame_gui():fade_up()
end
