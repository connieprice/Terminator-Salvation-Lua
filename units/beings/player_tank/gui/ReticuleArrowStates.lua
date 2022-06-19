require("shared/FiniteStateMachine")
if not ReticuleArrowIdleState then
	ReticuleArrowIdleState = class()
end
ReticuleArrowIdleState.transition = function(l_1_0)
	if l_1_0._reticule_arrow:wants_to_move_in() then
		return ReticuleArrowMoveInState
	else
		if l_1_0._reticule_arrow:wants_to_move_out() then
			return ReticuleArrowMoveOutState
		end
	end
end

if not ReticuleArrowMoveInState then
	ReticuleArrowMoveInState = class()
end
ReticuleArrowMoveInState.init = function(l_2_0)
	local l_2_1 = l_2_0._reticule_arrow:get_current_position()
	l_2_0._y = l_2_0._reticule_arrow
	l_2_0._x = l_2_1
	l_2_1 = l_2_0._reticule_arrow
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._end_y = l_2_1
	l_2_0._end_x = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._alpha = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._x_interpolator = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._y_interpolator = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._alpha_interpolator = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._alpha_interpolator_2 = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_1, l_2_0._end_x)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_1, l_2_0._end_y)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_1, 1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_1, 0)
end

ReticuleArrowMoveInState.update = function(l_3_0, l_3_1)
	l_3_0._x_interpolator:update(l_3_1)
	l_3_0._y_interpolator:update(l_3_1)
	l_3_0._alpha_interpolator:update(l_3_1)
	local l_3_2 = l_3_0._x_interpolator:value()
	local l_3_3 = l_3_0._y_interpolator:value()
	local l_3_4 = l_3_0._alpha_interpolator:value()
	if l_3_4 > 0.8 then
		l_3_0._alpha_interpolator_2:update(l_3_1)
		l_3_4 = l_3_0._alpha_interpolator_2:value()
	end
	l_3_0._reticule_arrow:set_position(l_3_2, l_3_3)
	l_3_0._reticule_arrow:set_alpha(l_3_4)
end

ReticuleArrowMoveInState.transition = function(l_4_0)
	if l_4_0._reticule_arrow:wants_to_move_out() then
		return ReticuleArrowMoveOutState
	end
end

if not ReticuleArrowMoveOutState then
	ReticuleArrowMoveOutState = class()
end
ReticuleArrowMoveOutState.init = function(l_5_0)
	local l_5_1 = l_5_0._reticule_arrow:get_current_position()
	l_5_0._y = l_5_0._reticule_arrow
	l_5_0._x = l_5_1
	l_5_1 = l_5_0._reticule_arrow
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._end_y = l_5_1
	l_5_0._end_x = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._alpha = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._x_interpolator = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._y_interpolator = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._alpha_interpolator = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._alpha_interpolator_2 = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_1(l_5_1, l_5_0._end_x)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_1(l_5_1, l_5_0._end_y)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_1(l_5_1, 1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_1(l_5_1, 0)
end

ReticuleArrowMoveOutState.update = function(l_6_0, l_6_1)
	l_6_0._alpha = l_6_0._reticule_arrow:get_alpha()
	if l_6_0._alpha == 0 and l_6_0._x == l_6_0._end_x and l_6_0._y == l_6_0._end_y then
		return 
	end
	if l_6_0._alpha == 1 and l_6_0._x == l_6_0._end_x and l_6_0._y == l_6_0._end_y then
		l_6_0._reticule_arrow:set_alpha(0)
		return 
	end
	l_6_0._x_interpolator:update(l_6_1)
	l_6_0._y_interpolator:update(l_6_1)
	l_6_0._alpha_interpolator:update(l_6_1)
	local l_6_2 = l_6_0._x_interpolator:value()
	local l_6_3 = l_6_0._y_interpolator:value()
	local l_6_4 = l_6_0._alpha_interpolator:value()
	if l_6_4 > 0.8 then
		l_6_0._alpha_interpolator_2:update(l_6_1)
		l_6_4 = l_6_0._alpha_interpolator_2:value()
	end
	l_6_0._reticule_arrow:set_position(l_6_2, l_6_3)
	l_6_0._reticule_arrow:set_alpha(l_6_4)
end

ReticuleArrowMoveOutState.transition = function(l_7_0)
	if l_7_0._reticule_arrow:wants_to_move_in() then
		return ReticuleArrowMoveInState
	end
end


