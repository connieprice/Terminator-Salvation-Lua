require("shared/FiniteStateMachine")
if not IconIdleState then
	IconIdleState = class()
end
IconIdleState.init = function(l_1_0)
end

IconIdleState.transition = function(l_2_0)
	if l_2_0._icon:wants_to_move_out() then
		return IconMoveOutState
	else
		if l_2_0._icon:wants_to_move_in() then
			return IconMoveInState
		end
	else
		if l_2_0._icon:wants_to_hide() then
			return IconHideState
		end
	else
		if l_2_0._icon:wants_to_blink() then
			return IconBlinkState
		end
	end
end

if not IconMoveOutState then
	IconMoveOutState = class()
end
IconMoveOutState.init = function(l_3_0)
	l_3_0._alpha = l_3_0._icon:get_alpha()
	l_3_0._x = l_3_0._icon:get_current_position()
	l_3_0._alpha_interpolator = Interpolator:new(l_3_0._alpha, l_3_0._icon:get_selected_icon_fade_in_speed())
	l_3_0._alpha_interpolator:set_target(l_3_0._icon:get_move_out_alpha_target())
	l_3_0._x_interpolator = Interpolator:new(l_3_0._x, l_3_0._icon:get_selected_icon_move_out_speed())
	l_3_0._x_interpolator:set_target(l_3_0._icon:get_end_position())
end

IconMoveOutState.update = function(l_4_0, l_4_1)
	if l_4_0._alpha_interpolator:has_reached_target() and l_4_0._x_interpolator:has_reached_target() then
		l_4_0._icon:idle()
		return 
	end
	l_4_0._alpha_interpolator:update(l_4_1)
	l_4_0._x_interpolator:update(l_4_1)
	local l_4_2 = l_4_0._alpha_interpolator:value()
	local l_4_3 = l_4_0._x_interpolator:value()
	l_4_0._icon:set_alpha(l_4_2)
	l_4_0._icon:set_position(l_4_3)
end

IconMoveOutState.transition = function(l_5_0)
	if l_5_0._icon:wants_to_idle() then
		return IconIdleState
	else
		if l_5_0._icon:wants_to_move_in() then
			return IconMoveInState
		end
	else
		if l_5_0._icon:wants_to_hide() then
			return IconHideState
		end
	else
		if l_5_0._icon:wants_to_blink() then
			return IconBlinkState
		end
	end
end

if not IconMoveInState then
	IconMoveInState = class()
end
IconMoveInState.init = function(l_6_0)
	l_6_0._alpha = l_6_0._icon:get_alpha()
	l_6_0._x = l_6_0._icon:get_current_position()
	l_6_0._alpha_interpolator = Interpolator:new(l_6_0._alpha, l_6_0._icon:get_selected_icon_fade_in_speed())
	if l_6_0._icon:is_default_selected() then
		l_6_0._alpha_target = 1
	else
		l_6_0._alpha_target = l_6_0._icon:get_move_in_alpha_target()
	end
	l_6_0._alpha_interpolator:set_target(l_6_0._alpha_target)
	l_6_0._x_interpolator = Interpolator:new(l_6_0._x, l_6_0._icon:get_selected_icon_move_in_speed())
	l_6_0._x_interpolator:set_target(l_6_0._icon:get_start_position())
end

IconMoveInState.update = function(l_7_0, l_7_1)
	if l_7_0._alpha_target ~= l_7_0._icon:get_move_in_alpha_target() and not l_7_0._icon:is_default_selected() then
		l_7_0._alpha_target = l_7_0._icon:get_move_in_alpha_target()
		l_7_0._alpha_interpolator:set_target(l_7_0._alpha_target)
	end
	if l_7_0._alpha_interpolator:has_reached_target() and l_7_0._x_interpolator:has_reached_target() then
		l_7_0._icon:idle()
		return 
	end
	l_7_0._alpha_interpolator:update(l_7_1)
	l_7_0._x_interpolator:update(l_7_1)
	local l_7_2 = l_7_0._alpha_interpolator:value()
	local l_7_3 = l_7_0._x_interpolator:value()
	l_7_0._icon:set_alpha(l_7_2)
	l_7_0._icon:set_position(l_7_3)
end

IconMoveInState.transition = function(l_8_0)
	if l_8_0._icon:wants_to_idle() then
		return IconIdleState
	else
		if l_8_0._icon:wants_to_move_out() then
			return IconMoveOutState
		end
	else
		if l_8_0._icon:wants_to_hide() then
			return IconHideState
		end
	end
end

if not IconHideState then
	IconHideState = class()
end
IconHideState.init = function(l_9_0)
	l_9_0._alpha = l_9_0._icon:get_alpha()
	l_9_0._alpha_interpolator = Interpolator:new(l_9_0._alpha, l_9_0._icon:get_selected_icon_fade_out_speed())
	l_9_0._alpha_interpolator:set_target(0)
	l_9_0._x = l_9_0._icon:get_current_position()
	l_9_0._x_interpolator = Interpolator:new(l_9_0._x, l_9_0._icon:get_selected_icon_move_in_speed())
	l_9_0._x_interpolator:set_target(l_9_0._icon:get_start_position())
end

IconHideState.update = function(l_10_0, l_10_1)
	if l_10_0._alpha_interpolator:has_reached_target() and l_10_0._x_interpolator:has_reached_target() then
		l_10_0._icon:idle()
		return 
	end
	l_10_0._alpha_interpolator:update(l_10_1)
	local l_10_2 = l_10_0._alpha_interpolator:value()
	l_10_0._x_interpolator:update(l_10_1)
	local l_10_3 = l_10_0._x_interpolator:value()
	if l_10_0._alpha_interpolator:has_reached_target() then
		l_10_2 = 0
		l_10_3 = l_10_0._icon:get_start_position()
	end
	l_10_0._icon:set_alpha(l_10_2)
	l_10_0._icon:set_position(l_10_3)
end

IconHideState.transition = function(l_11_0)
	if l_11_0._icon:wants_to_idle() then
		return IconIdleState
	else
		if l_11_0._icon:wants_to_move_out() then
			return IconMoveOutState
		end
	else
		if l_11_0._icon:wants_to_move_in() then
			return IconMoveInState
		end
	end
end

if not IconBlinkState then
	IconBlinkState = class()
end
IconBlinkState.init = function(l_12_0)
	l_12_0._time = 0
	l_12_0._next_blink_time = 0
	l_12_0._blink_alpha = 0
	l_12_0._blinked_times = 0
	l_12_0._times_to_blink = l_12_0._icon:get_selected_icon_blink_times()
	l_12_0._blink_speed = l_12_0._icon:get_selected_icon_blink_speed()
end

IconBlinkState.update = function(l_13_0, l_13_1)
	l_13_0._time = l_13_0._time + l_13_1
	if l_13_0._next_blink_time < l_13_0._time then
		local l_13_4 = l_13_0._icon:set_alpha
		l_13_4(l_13_0._icon, l_13_0._blink_alpha)
		l_13_4 = l_13_0._blink_alpha
		if l_13_4 == 0 then
			l_13_0._blink_alpha = 1
			l_13_4 = l_13_0._blinked_times
			l_13_4 = l_13_4 + 1
			l_13_0._blinked_times = l_13_4
		else
			l_13_0._blink_alpha = 0
		end
		l_13_4 = l_13_0._blinked_times
		if l_13_0._times_to_blink < l_13_4 then
			l_13_4 = l_13_0._icon
			local l_13_2, l_13_3 = l_13_4
			return l_13_4(l_13_2)
		end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_13_0._next_blink_time = l_13_4
	end
end

IconBlinkState.transition = function(l_14_0)
	if l_14_0._icon:wants_to_hide() then
		return IconHideState
	end
end


