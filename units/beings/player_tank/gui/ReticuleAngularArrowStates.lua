require("shared/FiniteStateMachine")
ReticuleAngularArrowIdleState = ReticuleAngularArrowIdleState or class()
function ReticuleAngularArrowIdleState.transition(A0_0)
	if A0_0._reticule_angular_arrow:wants_to_rotate_right() then
		return ReticuleAngularArrowRotateRightState
	elseif A0_0._reticule_angular_arrow:wants_to_rotate_left() then
		return ReticuleAngularArrowRotateLeftState
	end
end
ReticuleAngularArrowRotateRightState = ReticuleAngularArrowRotateRightState or class()
function ReticuleAngularArrowRotateRightState.init(A0_1)
	A0_1._angle = A0_1._reticule_angular_arrow:get_current_angle()
	A0_1._end_angle = A0_1._reticule_angular_arrow:get_end_angle()
	A0_1._angle_interpolator = Interpolator:new(A0_1._angle, tweak_data.machine.hud.RETICULE_ARROW_ROTATE_RIGHT_SPEED)
	A0_1._angle_interpolator:set_target(A0_1._end_angle)
end
function ReticuleAngularArrowRotateRightState.update(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._angle_interpolator
	L2_4 = L2_4.update
	L2_4(L2_4, A1_3)
	L2_4 = A0_2._angle_interpolator
	L2_4 = L2_4.value
	L2_4 = L2_4(L2_4)
	A0_2._reticule_angular_arrow:set_angle(L2_4)
end
function ReticuleAngularArrowRotateRightState.transition(A0_5)
	if A0_5._reticule_angular_arrow:wants_to_rotate_left() then
		return ReticuleAngularArrowRotateLeftState
	end
end
ReticuleAngularArrowRotateLeftState = ReticuleAngularArrowRotateLeftState or class()
function ReticuleAngularArrowRotateLeftState.init(A0_6)
	A0_6._angle = A0_6._reticule_angular_arrow:get_current_angle()
	A0_6._end_angle = A0_6._reticule_angular_arrow:get_original_angle()
	A0_6._angle_interpolator = Interpolator:new(A0_6._angle, tweak_data.machine.hud.RETICULE_ARROW_ROTATE_LEFT_SPEED)
	A0_6._angle_interpolator:set_target(A0_6._end_angle)
end
function ReticuleAngularArrowRotateLeftState.update(A0_7, A1_8)
	local L2_9
	L2_9 = A0_7._angle_interpolator
	L2_9 = L2_9.update
	L2_9(L2_9, A1_8)
	L2_9 = A0_7._angle_interpolator
	L2_9 = L2_9.value
	L2_9 = L2_9(L2_9)
	A0_7._reticule_angular_arrow:set_angle(L2_9)
end
function ReticuleAngularArrowRotateLeftState.transition(A0_10)
	if A0_10._reticule_angular_arrow:wants_to_rotate_right() then
		return ReticuleAngularArrowRotateRightState
	end
end
