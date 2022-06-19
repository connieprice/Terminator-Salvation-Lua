require("shared/FiniteStateMachine")
IconIdleState = IconIdleState or class()
function IconIdleState.init(A0_0)
	local L1_1
end
function IconIdleState.transition(A0_2)
	if A0_2._icon:wants_to_move_out() then
		return IconMoveOutState
	elseif A0_2._icon:wants_to_move_in() then
		return IconMoveInState
	elseif A0_2._icon:wants_to_hide() then
		return IconHideState
	elseif A0_2._icon:wants_to_blink() then
		return IconBlinkState
	end
end
IconMoveOutState = IconMoveOutState or class()
function IconMoveOutState.init(A0_3)
	A0_3._alpha = A0_3._icon:get_alpha()
	A0_3._x = A0_3._icon:get_current_position()
	A0_3._alpha_interpolator = Interpolator:new(A0_3._alpha, A0_3._icon:get_selected_icon_fade_in_speed())
	A0_3._alpha_interpolator:set_target(A0_3._icon:get_move_out_alpha_target())
	A0_3._x_interpolator = Interpolator:new(A0_3._x, A0_3._icon:get_selected_icon_move_out_speed())
	A0_3._x_interpolator:set_target(A0_3._icon:get_end_position())
end
function IconMoveOutState.update(A0_4, A1_5)
	local L2_6, L3_7
	L2_6 = A0_4._alpha_interpolator
	L3_7 = L2_6
	L2_6 = L2_6.has_reached_target
	L2_6 = L2_6(L3_7)
	if L2_6 then
		L2_6 = A0_4._x_interpolator
		L3_7 = L2_6
		L2_6 = L2_6.has_reached_target
		L2_6 = L2_6(L3_7)
		if L2_6 then
			L2_6 = A0_4._icon
			L3_7 = L2_6
			L2_6 = L2_6.idle
			L2_6(L3_7)
			return
		end
	end
	L2_6 = A0_4._alpha_interpolator
	L3_7 = L2_6
	L2_6 = L2_6.update
	L2_6(L3_7, A1_5)
	L2_6 = A0_4._x_interpolator
	L3_7 = L2_6
	L2_6 = L2_6.update
	L2_6(L3_7, A1_5)
	L2_6 = A0_4._alpha_interpolator
	L3_7 = L2_6
	L2_6 = L2_6.value
	L2_6 = L2_6(L3_7)
	L3_7 = A0_4._x_interpolator
	L3_7 = L3_7.value
	L3_7 = L3_7(L3_7)
	A0_4._icon:set_alpha(L2_6)
	A0_4._icon:set_position(L3_7)
end
function IconMoveOutState.transition(A0_8)
	if A0_8._icon:wants_to_idle() then
		return IconIdleState
	elseif A0_8._icon:wants_to_move_in() then
		return IconMoveInState
	elseif A0_8._icon:wants_to_hide() then
		return IconHideState
	elseif A0_8._icon:wants_to_blink() then
		return IconBlinkState
	end
end
IconMoveInState = IconMoveInState or class()
function IconMoveInState.init(A0_9)
	A0_9._alpha = A0_9._icon:get_alpha()
	A0_9._x = A0_9._icon:get_current_position()
	A0_9._alpha_interpolator = Interpolator:new(A0_9._alpha, A0_9._icon:get_selected_icon_fade_in_speed())
	if A0_9._icon:is_default_selected() then
		A0_9._alpha_target = 1
	else
		A0_9._alpha_target = A0_9._icon:get_move_in_alpha_target()
	end
	A0_9._alpha_interpolator:set_target(A0_9._alpha_target)
	A0_9._x_interpolator = Interpolator:new(A0_9._x, A0_9._icon:get_selected_icon_move_in_speed())
	A0_9._x_interpolator:set_target(A0_9._icon:get_start_position())
end
function IconMoveInState.update(A0_10, A1_11)
	local L2_12, L3_13
	L2_12 = A0_10._alpha_target
	L3_13 = A0_10._icon
	L3_13 = L3_13.get_move_in_alpha_target
	L3_13 = L3_13(L3_13)
	if L2_12 ~= L3_13 then
		L2_12 = A0_10._icon
		L3_13 = L2_12
		L2_12 = L2_12.is_default_selected
		L2_12 = L2_12(L3_13)
		if not L2_12 then
			L2_12 = A0_10._icon
			L3_13 = L2_12
			L2_12 = L2_12.get_move_in_alpha_target
			L2_12 = L2_12(L3_13)
			A0_10._alpha_target = L2_12
			L2_12 = A0_10._alpha_interpolator
			L3_13 = L2_12
			L2_12 = L2_12.set_target
			L2_12(L3_13, A0_10._alpha_target)
		end
	end
	L2_12 = A0_10._alpha_interpolator
	L3_13 = L2_12
	L2_12 = L2_12.has_reached_target
	L2_12 = L2_12(L3_13)
	if L2_12 then
		L2_12 = A0_10._x_interpolator
		L3_13 = L2_12
		L2_12 = L2_12.has_reached_target
		L2_12 = L2_12(L3_13)
		if L2_12 then
			L2_12 = A0_10._icon
			L3_13 = L2_12
			L2_12 = L2_12.idle
			L2_12(L3_13)
			return
		end
	end
	L2_12 = A0_10._alpha_interpolator
	L3_13 = L2_12
	L2_12 = L2_12.update
	L2_12(L3_13, A1_11)
	L2_12 = A0_10._x_interpolator
	L3_13 = L2_12
	L2_12 = L2_12.update
	L2_12(L3_13, A1_11)
	L2_12 = A0_10._alpha_interpolator
	L3_13 = L2_12
	L2_12 = L2_12.value
	L2_12 = L2_12(L3_13)
	L3_13 = A0_10._x_interpolator
	L3_13 = L3_13.value
	L3_13 = L3_13(L3_13)
	A0_10._icon:set_alpha(L2_12)
	A0_10._icon:set_position(L3_13)
end
function IconMoveInState.transition(A0_14)
	if A0_14._icon:wants_to_idle() then
		return IconIdleState
	elseif A0_14._icon:wants_to_move_out() then
		return IconMoveOutState
	elseif A0_14._icon:wants_to_hide() then
		return IconHideState
	end
end
IconHideState = IconHideState or class()
function IconHideState.init(A0_15)
	A0_15._alpha = A0_15._icon:get_alpha()
	A0_15._alpha_interpolator = Interpolator:new(A0_15._alpha, A0_15._icon:get_selected_icon_fade_out_speed())
	A0_15._alpha_interpolator:set_target(0)
	A0_15._x = A0_15._icon:get_current_position()
	A0_15._x_interpolator = Interpolator:new(A0_15._x, A0_15._icon:get_selected_icon_move_in_speed())
	A0_15._x_interpolator:set_target(A0_15._icon:get_start_position())
end
function IconHideState.update(A0_16, A1_17)
	local L2_18, L3_19
	L2_18 = A0_16._alpha_interpolator
	L3_19 = L2_18
	L2_18 = L2_18.has_reached_target
	L2_18 = L2_18(L3_19)
	if L2_18 then
		L2_18 = A0_16._x_interpolator
		L3_19 = L2_18
		L2_18 = L2_18.has_reached_target
		L2_18 = L2_18(L3_19)
		if L2_18 then
			L2_18 = A0_16._icon
			L3_19 = L2_18
			L2_18 = L2_18.idle
			L2_18(L3_19)
			return
		end
	end
	L2_18 = A0_16._alpha_interpolator
	L3_19 = L2_18
	L2_18 = L2_18.update
	L2_18(L3_19, A1_17)
	L2_18 = A0_16._alpha_interpolator
	L3_19 = L2_18
	L2_18 = L2_18.value
	L2_18 = L2_18(L3_19)
	L3_19 = A0_16._x_interpolator
	L3_19 = L3_19.update
	L3_19(L3_19, A1_17)
	L3_19 = A0_16._x_interpolator
	L3_19 = L3_19.value
	L3_19 = L3_19(L3_19)
	if A0_16._alpha_interpolator:has_reached_target() then
		L2_18 = 0
		L3_19 = A0_16._icon:get_start_position()
	end
	A0_16._icon:set_alpha(L2_18)
	A0_16._icon:set_position(L3_19)
end
function IconHideState.transition(A0_20)
	if A0_20._icon:wants_to_idle() then
		return IconIdleState
	elseif A0_20._icon:wants_to_move_out() then
		return IconMoveOutState
	elseif A0_20._icon:wants_to_move_in() then
		return IconMoveInState
	end
end
IconBlinkState = IconBlinkState or class()
function IconBlinkState.init(A0_21)
	A0_21._time = 0
	A0_21._next_blink_time = 0
	A0_21._blink_alpha = 0
	A0_21._blinked_times = 0
	A0_21._times_to_blink = A0_21._icon:get_selected_icon_blink_times()
	A0_21._blink_speed = A0_21._icon:get_selected_icon_blink_speed()
end
function IconBlinkState.update(A0_22, A1_23)
	A0_22._time = A0_22._time + A1_23
	if A0_22._time > A0_22._next_blink_time then
		A0_22._icon:set_alpha(A0_22._blink_alpha)
		if A0_22._blink_alpha == 0 then
			A0_22._blink_alpha = 1
			A0_22._blinked_times = A0_22._blinked_times + 1
		else
			A0_22._blink_alpha = 0
		end
		if A0_22._blinked_times > A0_22._times_to_blink then
			return A0_22._icon:hide()
		else
			A0_22._next_blink_time = A0_22._time + A0_22._blink_speed
		end
	end
end
function IconBlinkState.transition(A0_24)
	if A0_24._icon:wants_to_hide() then
		return IconHideState
	end
end
