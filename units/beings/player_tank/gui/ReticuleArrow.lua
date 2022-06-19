require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/ReticuleArrowStates")
ReticuleArrow = ReticuleArrow or class()
function ReticuleArrow.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8)
	A0_0.parent_panel = A1_1
	A0_0._size_modifier = A8_8 or 1
	A0_0._x = A3_3
	A0_0._y = A4_4
	A0_0._align_x = A5_5
	A0_0._align_y = A6_6
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._arrow_texture = A0_0.parent_panel:bitmap({name = A2_2, texture = A2_2})
	A0_0._arrow_texture:set_size(64 * A0_0._size_modifier, 64 * A0_0._size_modifier)
	if A7_7 then
		A0_0._arrow_texture:rotate(A7_7)
	end
	if A0_0._align_x:find("right") then
		A0_0._arrow_texture:set_right(A0_0._x)
	elseif A0_0._align_x:find("left") then
		A0_0._arrow_texture:set_left(A0_0._x)
	else
		A0_0._arrow_texture:set_center_x(A0_0._x)
	end
	if A0_0._align_y:find("top") then
		A0_0._arrow_texture:set_top(A0_0._y)
	elseif A0_0._align_y:find("bottom") then
		A0_0._arrow_texture:set_bottom(A0_0._y)
	else
		A0_0._arrow_texture:set_center_y(A0_0._y)
	end
	A0_0._state = FiniteStateMachine:new(A0_0, "_reticule_arrow", ReticuleArrowIdleState)
	A0_0._state:set_debug(false)
	A0_0._x = A0_0._arrow_texture:x()
	A0_0._y = A0_0._arrow_texture:y()
	A0_0._current_x = A0_0._x
	A0_0._current_y = A0_0._y
	A0_0:set_alpha(0)
end
function ReticuleArrow.set_move_in_end_position(A0_9, A1_10, A2_11)
	local L3_12
	L3_12 = {}
	A0_9._move_in_end_position = L3_12
	L3_12 = A0_9._move_in_end_position
	L3_12.x = A0_9._arrow_texture:x() + A1_10
	L3_12 = A0_9._move_in_end_position
	L3_12.y = A0_9._arrow_texture:y() + A2_11
end
function ReticuleArrow.get_move_in_end_position(A0_13)
	local L1_14
	L1_14 = A0_13._move_in_end_position
	if not L1_14 then
		L1_14 = nil
		return L1_14, nil
	end
	L1_14 = A0_13._move_in_end_position
	L1_14 = L1_14.x
	return L1_14, A0_13._move_in_end_position.y
end
function ReticuleArrow.get_current_position(A0_15)
	return A0_15._arrow_texture:x(), A0_15._arrow_texture:y()
end
function ReticuleArrow.get_original_position(A0_16)
	local L1_17, L2_18
	L1_17 = A0_16._x
	L2_18 = A0_16._y
	return L1_17, L2_18
end
function ReticuleArrow.get_alpha(A0_19)
	local L1_20
	L1_20 = A0_19._alpha
	return L1_20
end
function ReticuleArrow.set_alpha(A0_21, A1_22)
	local L3_23
	A0_21._alpha = A1_22
	L3_23 = A0_21._arrow_texture
	L3_23 = L3_23.set_color
	L3_23(L3_23, A0_21._color:with_alpha(A1_22 * tweak_data.machine.hud.MAIN_ALPHA))
end
function ReticuleArrow.set_position(A0_24, A1_25, A2_26)
	A0_24._arrow_texture:set_x(A1_25)
	A0_24._arrow_texture:set_y(A2_26)
	A0_24._current_x = A1_25
	A0_24._current_y = A2_26
end
function ReticuleArrow.wants_to_move_in(A0_27)
	local L1_28
	L1_28 = A0_27._wants_to_move_in
	return L1_28
end
function ReticuleArrow.wants_to_move_out(A0_29)
	local L1_30
	L1_30 = A0_29._wants_to_move_out
	return L1_30
end
function ReticuleArrow.move_in(A0_31)
	local L1_32
	A0_31._wants_to_move_in = true
	A0_31._wants_to_move_out = false
end
function ReticuleArrow.move_out(A0_33)
	local L1_34
	A0_33._wants_to_move_in = false
	A0_33._wants_to_move_out = true
end
function ReticuleArrow.update(A0_35, A1_36, A2_37)
	A0_35._state:update(A2_37)
end
function ReticuleArrow.at_end_position(A0_38)
	if math.abs(A0_38._current_x - A0_38._move_in_end_position.x) < 0.01 and 0.01 > math.abs(A0_38._current_y - A0_38._move_in_end_position.y) then
		return true
	end
	return false
end
function ReticuleArrow.at_start_position(A0_39)
	if math.abs(A0_39._current_x - A0_39._x) < 0.01 and 0.01 > math.abs(A0_39._current_y - A0_39._y) then
		return true
	end
	return false
end
