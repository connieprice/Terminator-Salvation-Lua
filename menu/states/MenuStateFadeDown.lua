MenuStateFadeDown = MenuStateFadeDown or class(FiniteStateMachineState)
function MenuStateFadeDown.init(A0_0)
	local L1_1
	L1_1 = A0_0.transition
	A0_0._transition = L1_1
	L1_1 = MenuStateFadeDown
	L1_1 = L1_1.transition
	A0_0.transition = L1_1
end
function MenuStateFadeDown.transition(A0_2)
	if not A0_2._next_state and A0_2:_transition() then
		A0_2._next_state = A0_2:_transition()
		if A0_2._use_slow_fade then
			A0_2._menu:ingame_gui():fade_down_slow()
		else
			A0_2._menu:ingame_gui():fade_down()
		end
	end
	if A0_2._next_state and A0_2._menu:ingame_gui():is_faded_down() then
		return A0_2._next_state
	end
end
