require("shared/FiniteStateMachine")
ReticuleArrowIdleState = ReticuleArrowIdleState or class()
function ReticuleArrowIdleState.transition(A0_0)
	if A0_0._reticule_arrow:wants_to_move_in() then
		return ReticuleArrowMoveInState
	elseif A0_0._reticule_arrow:wants_to_move_out() then
		return ReticuleArrowMoveOutState
	end
end
ReticuleArrowMoveInState = ReticuleArrowMoveInState or class()
function ReticuleArrowMoveInState.init(A0_1)
	A0_1._x, A0_1._y = A0_1._reticule_arrow:get_current_position()
	A0_1._end_x, A0_1._end_y = A0_1._reticule_arrow:get_move_in_end_position()
	A0_1._alpha = A0_1._reticule_arrow:get_alpha()
	A0_1._x_interpolator = Interpolator:new(A0_1._x, tweak_data.machine.hud.RETICULE_ARROW_MOVE_IN_SPEED)
	A0_1._y_interpolator = Interpolator:new(A0_1._y, tweak_data.machine.hud.RETICULE_ARROW_MOVE_IN_SPEED)
	A0_1._alpha_interpolator = Interpolator:new(A0_1._alpha, tweak_data.machine.hud.RETICULE_ARROW_MOVE_IN_SPEED)
	A0_1._alpha_interpolator_2 = Interpolator:new(1, tweak_data.machine.hud.RETICULE_ARROW_MOVE_IN_SPEED)
	A0_1._x_interpolator:set_target(A0_1._end_x)
	A0_1._y_interpolator:set_target(A0_1._end_y)
	A0_1._alpha_interpolator:set_target(1)
	A0_1._alpha_interpolator_2:set_target(0)
end
function ReticuleArrowMoveInState.update(A0_2, A1_3)
	local L2_4, L3_5, L4_6
	L2_4 = A0_2._x_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.update
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._y_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.update
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._alpha_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.update
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._x_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.value
	L2_4 = L2_4(L3_5)
	L3_5 = A0_2._y_interpolator
	L4_6 = L3_5
	L3_5 = L3_5.value
	L3_5 = L3_5(L4_6)
	L4_6 = A0_2._alpha_interpolator
	L4_6 = L4_6.value
	L4_6 = L4_6(L4_6)
	if L4_6 > 0.8 then
		A0_2._alpha_interpolator_2:update(A1_3)
		L4_6 = A0_2._alpha_interpolator_2:value()
	end
	A0_2._reticule_arrow:set_position(L2_4, L3_5)
	A0_2._reticule_arrow:set_alpha(L4_6)
end
function ReticuleArrowMoveInState.transition(A0_7)
	if A0_7._reticule_arrow:wants_to_move_out() then
		return ReticuleArrowMoveOutState
	end
end
ReticuleArrowMoveOutState = ReticuleArrowMoveOutState or class()
function ReticuleArrowMoveOutState.init(A0_8)
	A0_8._x, A0_8._y = A0_8._reticule_arrow:get_current_position()
	A0_8._end_x, A0_8._end_y = A0_8._reticule_arrow:get_original_position()
	A0_8._alpha = A0_8._reticule_arrow:get_alpha()
	A0_8._x_interpolator = Interpolator:new(A0_8._x, tweak_data.machine.hud.RETICULE_ARROW_MOVE_OUT_SPEED)
	A0_8._y_interpolator = Interpolator:new(A0_8._y, tweak_data.machine.hud.RETICULE_ARROW_MOVE_OUT_SPEED)
	A0_8._alpha_interpolator = Interpolator:new(A0_8._alpha, tweak_data.machine.hud.RETICULE_ARROW_MOVE_OUT_SPEED)
	A0_8._alpha_interpolator_2 = Interpolator:new(0.8, tweak_data.machine.hud.RETICULE_ARROW_MOVE_OUT_SPEED)
	A0_8._x_interpolator:set_target(A0_8._end_x)
	A0_8._y_interpolator:set_target(A0_8._end_y)
	A0_8._alpha_interpolator:set_target(1)
	A0_8._alpha_interpolator_2:set_target(0)
end
function ReticuleArrowMoveOutState.update(A0_9, A1_10)
	local L2_11, L3_12, L4_13
	L2_11 = A0_9._reticule_arrow
	L3_12 = L2_11
	L2_11 = L2_11.get_alpha
	L2_11 = L2_11(L3_12)
	A0_9._alpha = L2_11
	L2_11 = A0_9._alpha
	if L2_11 == 0 then
		L2_11 = A0_9._x
		L3_12 = A0_9._end_x
		if L2_11 == L3_12 then
			L2_11 = A0_9._y
			L3_12 = A0_9._end_y
			if L2_11 == L3_12 then
				return
			end
		end
	end
	L2_11 = A0_9._alpha
	if L2_11 == 1 then
		L2_11 = A0_9._x
		L3_12 = A0_9._end_x
		if L2_11 == L3_12 then
			L2_11 = A0_9._y
			L3_12 = A0_9._end_y
			if L2_11 == L3_12 then
				L2_11 = A0_9._reticule_arrow
				L3_12 = L2_11
				L2_11 = L2_11.set_alpha
				L4_13 = 0
				L2_11(L3_12, L4_13)
				return
			end
		end
	end
	L2_11 = A0_9._x_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.update
	L4_13 = A1_10
	L2_11(L3_12, L4_13)
	L2_11 = A0_9._y_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.update
	L4_13 = A1_10
	L2_11(L3_12, L4_13)
	L2_11 = A0_9._alpha_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.update
	L4_13 = A1_10
	L2_11(L3_12, L4_13)
	L2_11 = A0_9._x_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.value
	L2_11 = L2_11(L3_12)
	L3_12 = A0_9._y_interpolator
	L4_13 = L3_12
	L3_12 = L3_12.value
	L3_12 = L3_12(L4_13)
	L4_13 = A0_9._alpha_interpolator
	L4_13 = L4_13.value
	L4_13 = L4_13(L4_13)
	if L4_13 > 0.8 then
		A0_9._alpha_interpolator_2:update(A1_10)
		L4_13 = A0_9._alpha_interpolator_2:value()
	end
	A0_9._reticule_arrow:set_position(L2_11, L3_12)
	A0_9._reticule_arrow:set_alpha(L4_13)
end
function ReticuleArrowMoveOutState.transition(A0_14)
	if A0_14._reticule_arrow:wants_to_move_in() then
		return ReticuleArrowMoveInState
	end
end
