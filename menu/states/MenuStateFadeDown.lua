if not MenuStateFadeDown then
	MenuStateFadeDown = class(FiniteStateMachineState)
end
MenuStateFadeDown.init = function(l_1_0)
	l_1_0._transition = l_1_0.transition
	l_1_0.transition = MenuStateFadeDown.transition
end

MenuStateFadeDown.transition = function(l_2_0)
	if not l_2_0._next_state then
		local l_2_1 = l_2_0:_transition()
	if l_2_1 then
		end
		l_2_0._next_state = l_2_1
		if l_2_0._use_slow_fade then
			l_2_0._menu:ingame_gui():fade_down_slow()
		end
	else
		l_2_0._menu:ingame_gui():fade_down()
	end
	if l_2_0._next_state and l_2_0._menu:ingame_gui():is_faded_down() then
		return l_2_0._next_state
	end
end


