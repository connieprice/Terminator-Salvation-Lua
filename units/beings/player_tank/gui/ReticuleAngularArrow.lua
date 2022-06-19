require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/ReticuleAngularArrowStates")
ReticuleAngularArrow = ReticuleAngularArrow or class()
function ReticuleAngularArrow.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8)
	A0_0.parent_panel = A1_1
	A0_0._size_modifier = A8_8 or 1
	A0_0._centre_x = A3_3
	A0_0._centre_y = A4_4
	A0_0._radius = A5_5 * A0_0._size_modifier
	A0_0._angle = A6_6
	A0_0._end_angle = A7_7
	A0_0._current_angle = 0
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._arrow_texture = A0_0.parent_panel:bitmap({name = A2_2, texture = A2_2})
	A0_0._arrow_texture:set_size(32 * A0_0._size_modifier, 32 * A0_0._size_modifier)
	A0_0._state = FiniteStateMachine:new(A0_0, "_reticule_angular_arrow", ReticuleAngularArrowIdleState)
	A0_0._state:set_debug(false)
	A0_0:set_angle(A6_6)
	A0_0:set_alpha(1)
end
function ReticuleAngularArrow.set_angle(A0_9, A1_10)
	local L2_11, L3_12
	L2_11 = A0_9._centre_x
	L3_12 = A0_9._radius
	L3_12 = L3_12 * math.cos(A1_10 - 90)
	L2_11 = L2_11 + L3_12
	L3_12 = A0_9._centre_y
	L3_12 = L3_12 + A0_9._radius * math.sin(A1_10 - 90)
	A0_9._current_angle = A1_10
	A0_9._arrow_texture:set_rotation(A1_10)
	A0_9:set_position(L2_11, L3_12)
end
function ReticuleAngularArrow.set_position(A0_13, A1_14, A2_15)
	A0_13._arrow_texture:set_center_x(A1_14)
	A0_13._arrow_texture:set_center_y(A2_15)
end
function ReticuleAngularArrow.set_radius(A0_16, A1_17)
	A0_16._radius = A1_17 * A0_16._size_modifier
	A0_16:set_angle(A0_16._current_angle)
end
function ReticuleAngularArrow.set_alpha(A0_18, A1_19)
	local L3_20
	A0_18._alpha = A1_19
	L3_20 = A0_18._arrow_texture
	L3_20 = L3_20.set_color
	L3_20(L3_20, A0_18._color:with_alpha(A1_19 * tweak_data.machine.hud.MAIN_ALPHA))
end
function ReticuleAngularArrow.get_current_angle(A0_21)
	local L1_22
	L1_22 = A0_21._current_angle
	return L1_22
end
function ReticuleAngularArrow.get_end_angle(A0_23)
	local L1_24
	L1_24 = A0_23._end_angle
	return L1_24
end
function ReticuleAngularArrow.get_original_angle(A0_25)
	local L1_26
	L1_26 = A0_25._angle
	return L1_26
end
function ReticuleAngularArrow.wants_to_rotate_right(A0_27)
	local L1_28
	L1_28 = A0_27._wants_to_rotate_right
	return L1_28
end
function ReticuleAngularArrow.wants_to_rotate_left(A0_29)
	local L1_30
	L1_30 = A0_29._wants_to_rotate_left
	return L1_30
end
function ReticuleAngularArrow.rotate_right(A0_31)
	local L1_32
	A0_31._wants_to_rotate_right = true
	A0_31._wants_to_rotate_left = false
end
function ReticuleAngularArrow.rotate_left(A0_33)
	local L1_34
	A0_33._wants_to_rotate_right = false
	A0_33._wants_to_rotate_left = true
end
function ReticuleAngularArrow.update(A0_35, A1_36, A2_37)
	A0_35._state:update(A2_37)
end
function ReticuleAngularArrow.at_end_position(A0_38)
	return math.abs(A0_38._current_angle - A0_38._end_angle) < 0.01
end
function ReticuleAngularArrow.at_start_position(A0_39)
	return math.abs(A0_39._current_angle - A0_39._angle) < 0.01
end
