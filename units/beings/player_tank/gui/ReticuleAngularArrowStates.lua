require("shared/FiniteStateMachine")
if not ReticuleAngularArrowIdleState then
	ReticuleAngularArrowIdleState = class()
end
ReticuleAngularArrowIdleState.transition = function(l_1_0)
	if l_1_0._reticule_angular_arrow:wants_to_rotate_right() then
		return ReticuleAngularArrowRotateRightState
	else
		if l_1_0._reticule_angular_arrow:wants_to_rotate_left() then
			return ReticuleAngularArrowRotateLeftState
		end
	end
end

if not ReticuleAngularArrowRotateRightState then
	ReticuleAngularArrowRotateRightState = class()
end
ReticuleAngularArrowRotateRightState.init = function(l_2_0)
	l_2_0._angle = l_2_0._reticule_angular_arrow:get_current_angle()
	l_2_0._end_angle = l_2_0._reticule_angular_arrow:get_end_angle()
	l_2_0._angle_interpolator = Interpolator:new(l_2_0._angle, tweak_data.machine.hud.RETICULE_ARROW_ROTATE_RIGHT_SPEED)
	l_2_0._angle_interpolator:set_target(l_2_0._end_angle)
end

ReticuleAngularArrowRotateRightState.update = function(l_3_0, l_3_1)
	l_3_0._angle_interpolator:update(l_3_1)
	local l_3_2 = l_3_0._angle_interpolator:value()
	l_3_0._reticule_angular_arrow:set_angle(l_3_2)
end

ReticuleAngularArrowRotateRightState.transition = function(l_4_0)
	if l_4_0._reticule_angular_arrow:wants_to_rotate_left() then
		return ReticuleAngularArrowRotateLeftState
	end
end

if not ReticuleAngularArrowRotateLeftState then
	ReticuleAngularArrowRotateLeftState = class()
end
ReticuleAngularArrowRotateLeftState.init = function(l_5_0)
	l_5_0._angle = l_5_0._reticule_angular_arrow:get_current_angle()
	l_5_0._end_angle = l_5_0._reticule_angular_arrow:get_original_angle()
	l_5_0._angle_interpolator = Interpolator:new(l_5_0._angle, tweak_data.machine.hud.RETICULE_ARROW_ROTATE_LEFT_SPEED)
	l_5_0._angle_interpolator:set_target(l_5_0._end_angle)
end

ReticuleAngularArrowRotateLeftState.update = function(l_6_0, l_6_1)
	l_6_0._angle_interpolator:update(l_6_1)
	local l_6_2 = l_6_0._angle_interpolator:value()
	l_6_0._reticule_angular_arrow:set_angle(l_6_2)
end

ReticuleAngularArrowRotateLeftState.transition = function(l_7_0)
	if l_7_0._reticule_angular_arrow:wants_to_rotate_right() then
		return ReticuleAngularArrowRotateRightState
	end
end


