Menu2DMouseStateInvisible = Menu2DMouseStateInvisible or class(FiniteStateMachineState)
function Menu2DMouseStateInvisible.init(A0_0)
	A0_0._mouse._request_hide = nil
	A0_0._invisible = true
end
function Menu2DMouseStateInvisible.exit(A0_1)
	local L1_2
	A0_1._invisible = nil
end
function Menu2DMouseStateInvisible.transition(A0_3)
	local L1_4
	L1_4 = A0_3._mouse
	L1_4 = L1_4._state_data
	L1_4 = L1_4.input
	L1_4 = L1_4.cursor_movement
	if not L1_4 then
		L1_4 = A0_3._mouse
		L1_4 = L1_4._request_show
	elseif L1_4 then
		L1_4 = Menu2DMouseStateVisible
		return L1_4
	end
end
Menu2DMouseStateVisible = Menu2DMouseStateVisible or class(FiniteStateMachineState)
function Menu2DMouseStateVisible.init(A0_5)
	A0_5._mouse._cursor:set_color(A0_5._mouse._cursor:color():with_alpha(1))
	A0_5._mouse._cursor:show()
	A0_5._idle_timer = tweak_data.menu2d.MOUSE_IDLE_TIMEOUT
	A0_5._mouse._request_show = nil
	A0_5._mouse._visible = true
end
function Menu2DMouseStateVisible.exit(A0_6)
	A0_6._mouse._visible = nil
end
function Menu2DMouseStateVisible.update(A0_7, A1_8)
	local L2_9
	L2_9 = A0_7._idle_timer
	if L2_9 > 0 then
		L2_9 = A0_7._idle_timer
		L2_9 = L2_9 - A1_8
		A0_7._idle_timer = L2_9
	end
	L2_9 = A0_7._mouse
	L2_9 = L2_9._state_data
	L2_9 = L2_9.input
	L2_9 = L2_9.cursor_movement
	if not L2_9 then
		L2_9 = A0_7._mouse
		L2_9 = L2_9._request_show
	elseif L2_9 then
		L2_9 = tweak_data
		L2_9 = L2_9.menu2d
		L2_9 = L2_9.MOUSE_IDLE_TIMEOUT
		A0_7._idle_timer = L2_9
	end
	L2_9 = A0_7._idle_timer
	if L2_9 < 0 then
		A0_7._idle_timer = 0
	end
end
function Menu2DMouseStateVisible.transition(A0_10)
	local L1_11
	L1_11 = A0_10._idle_timer
	if L1_11 ~= 0 then
		L1_11 = A0_10._mouse
		L1_11 = L1_11._request_hide
	elseif L1_11 then
		L1_11 = Menu2DMouseStateFadeOut
		return L1_11
	end
end
Menu2DMouseStateFadeOut = Menu2DMouseStateFadeOut or class(FiniteStateMachineState)
function Menu2DMouseStateFadeOut.init(A0_12)
	A0_12._fade_out_animation = Menu2DFadeOutAnimation:new(A0_12._mouse._cursor, 0, tweak_data.menu2d.MOUSE_IDLE_TIMEOUT_FADE_SPEED, 0)
	A0_12._done = false
end
function Menu2DMouseStateFadeOut.exit(A0_13)
	local L1_14
end
function Menu2DMouseStateFadeOut.update(A0_15, A1_16)
	if not A0_15._done then
		A0_15._done = A0_15._fade_out_animation:update(A1_16)
	end
end
function Menu2DMouseStateFadeOut.transition(A0_17)
	local L1_18
	L1_18 = A0_17._mouse
	L1_18 = L1_18._state_data
	L1_18 = L1_18.input
	L1_18 = L1_18.cursor_movement
	if not L1_18 then
		L1_18 = A0_17._mouse
		L1_18 = L1_18._request_show
	else
		if L1_18 then
			L1_18 = Menu2DMouseStateVisible
			return L1_18
	end
	else
		L1_18 = A0_17._done
		if L1_18 then
			L1_18 = Menu2DMouseStateInvisible
			return L1_18
		end
	end
end
