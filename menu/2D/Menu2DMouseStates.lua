if not Menu2DMouseStateInvisible then
	Menu2DMouseStateInvisible = class(FiniteStateMachineState)
end
Menu2DMouseStateInvisible.init = function(l_1_0)
	l_1_0._mouse._request_hide = nil
	l_1_0._invisible = true
end

Menu2DMouseStateInvisible.exit = function(l_2_0)
	l_2_0._invisible = nil
end

Menu2DMouseStateInvisible.transition = function(l_3_0)
	if l_3_0._mouse._state_data.input.cursor_movement or l_3_0._mouse._request_show then
		return Menu2DMouseStateVisible
	end
end

if not Menu2DMouseStateVisible then
	Menu2DMouseStateVisible = class(FiniteStateMachineState)
end
Menu2DMouseStateVisible.init = function(l_4_0)
	l_4_0._mouse._cursor:set_color(l_4_0._mouse._cursor:color():with_alpha(1))
	l_4_0._mouse._cursor:show()
	l_4_0._idle_timer = tweak_data.menu2d.MOUSE_IDLE_TIMEOUT
	l_4_0._mouse._request_show = nil
	l_4_0._mouse._visible = true
end

Menu2DMouseStateVisible.exit = function(l_5_0)
	l_5_0._mouse._visible = nil
end

Menu2DMouseStateVisible.update = function(l_6_0, l_6_1)
	if l_6_0._idle_timer > 0 then
		l_6_0._idle_timer = l_6_0._idle_timer - l_6_1
	end
	if l_6_0._mouse._state_data.input.cursor_movement or l_6_0._mouse._request_show then
		l_6_0._idle_timer = tweak_data.menu2d.MOUSE_IDLE_TIMEOUT
	end
	if l_6_0._idle_timer < 0 then
		l_6_0._idle_timer = 0
	end
end

Menu2DMouseStateVisible.transition = function(l_7_0)
	if l_7_0._idle_timer == 0 or l_7_0._mouse._request_hide then
		return Menu2DMouseStateFadeOut
	end
end

if not Menu2DMouseStateFadeOut then
	Menu2DMouseStateFadeOut = class(FiniteStateMachineState)
end
Menu2DMouseStateFadeOut.init = function(l_8_0)
	l_8_0._fade_out_animation = Menu2DFadeOutAnimation:new(l_8_0._mouse._cursor, 0, tweak_data.menu2d.MOUSE_IDLE_TIMEOUT_FADE_SPEED, 0)
	l_8_0._done = false
end

Menu2DMouseStateFadeOut.exit = function(l_9_0)
end

Menu2DMouseStateFadeOut.update = function(l_10_0, l_10_1)
	if not l_10_0._done then
		l_10_0._done = l_10_0._fade_out_animation:update(l_10_1)
	end
end

Menu2DMouseStateFadeOut.transition = function(l_11_0)
	if l_11_0._mouse._state_data.input.cursor_movement or l_11_0._mouse._request_show then
		return Menu2DMouseStateVisible
	elseif l_11_0._done then
		return Menu2DMouseStateInvisible
	end
end


