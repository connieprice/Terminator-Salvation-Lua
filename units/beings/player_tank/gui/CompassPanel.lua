require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/CompassStates")
CompassPanel = CompassPanel or class(MachineHudPanel)
function CompassPanel.init(A0_0, A1_1)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._size_modifier = 1
	A0_0._x = A0_0._parent_panel:width() / 2
	A0_0._y = 0
	A0_0._width = tweak_data.machine.hud.COMPASS_PANEL_WIDTH * A0_0._size_modifier
	A0_0._height = tweak_data.machine.hud.COMPASS_PANEL_HEIGHT
	A0_0._center_y = A0_0._height / 2
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._compass_panel = A0_0._parent_panel:panel({
		name = "compass_panel ",
		width = A0_0._width,
		height = A0_0._height,
		layer = 100
	})
	A0_0._compass_panel:set_center_x(A0_0._x)
	A0_0._compass_panel:set_top(A0_0._y)
	A0_0:_set_up_compass()
	A0_0._state = FiniteStateMachine:new(A0_0, "_compass_panel", CompassIdleState)
	A0_0._state:set_debug(false)
	A0_0._current_bearing = 1
	A0_0._last_direction = {}
	A0_0:set_size_y(0)
end
function CompassPanel.panel(A0_2)
	local L1_3
	L1_3 = A0_2._compass_panel
	return L1_3
end
function CompassPanel._set_up_compass(A0_4)
	local L1_5, L2_6, L3_7, L4_8, L5_9, L6_10, L7_11, L8_12, L9_13
	L1_5 = A0_4._width
	L1_5 = L1_5 / 2
	L2_6 = A0_4._size_modifier
	L2_6 = 10 * L2_6
	L3_7 = math
	L3_7 = L3_7.round
	L4_8 = A0_4._width
	L4_8 = L4_8 / L2_6
	L3_7 = L3_7(L4_8)
	L4_8 = math
	L4_8 = L4_8.round
	L5_9 = L3_7 / 2
	L4_8 = L4_8(L5_9)
	L5_9 = 0
	A0_4._lines = L6_10
	for L9_13 = 1, 360 do
		if L9_13 < L4_8 then
			L5_9 = 1 * L9_13 / L4_8
		else
			L5_9 = 1 * (L3_7 - L9_13) / L4_8
		end
		if L9_13 % 5 == 0 then
			A0_4._compass_panel:rect({
				name = "line",
				y = 0,
				width = 4 * A0_4._size_modifier,
				height = 25 * A0_4._size_modifier
			}):set_center_x(L1_5)
			MachineText:new(A0_4._compass_panel, L1_5, 30 * A0_4._size_modifier):set_static_text(tostring(L9_13))
			MachineText:new(A0_4._compass_panel, L1_5, 30 * A0_4._size_modifier):set_alignment("center", "top")
			MachineText:new(A0_4._compass_panel, L1_5, 30 * A0_4._size_modifier):set_center_x(L1_5)
			MachineText:new(A0_4._compass_panel, L1_5, 30 * A0_4._size_modifier):set_text_alpha(0)
			if A0_4._size_modifier <= 0.5 then
				MachineText:new(A0_4._compass_panel, L1_5, 30 * A0_4._size_modifier):use_small_font()
			end
			A0_4._lines[L9_13] = {
				line = A0_4._compass_panel:rect({
					name = "line",
					y = 0,
					width = 4 * A0_4._size_modifier,
					height = 25 * A0_4._size_modifier
				}),
				text = MachineText:new(A0_4._compass_panel, L1_5, 30 * A0_4._size_modifier)
			}
		else
			A0_4._lines[L9_13] = {
				line = A0_4._compass_panel:rect({
					name = "line",
					x = L1_5,
					y = 0,
					width = 2 * A0_4._size_modifier,
					height = 15 * A0_4._size_modifier
				})
			}
		end
		L1_5 = L1_5 + L2_6
	end
end
function CompassPanel.get_current_bearing(A0_14)
	local L1_15
	L1_15 = A0_14._current_bearing
	return L1_15
end
function CompassPanel.get_target_bearing(A0_16)
	local L1_17
	L1_17 = A0_16._target_bearing
	return L1_17
end
function CompassPanel.set_current_spin_speed(A0_18, A1_19)
	A0_18._current_spin_speed = A1_19
end
function CompassPanel.get_current_spin_speed(A0_20, A1_21)
	local L2_22
	L2_22 = A0_20._current_spin_speed
	return L2_22
end
function CompassPanel.spin_to_bearing(A0_23, A1_24)
	local L4_25, L5_26
	A0_23._target_bearing = A1_24
	L4_25 = false
	L5_26 = false
	if A0_23._target_bearing - A0_23._current_bearing > 3000 then
		L4_25 = true
	end
	if A0_23._target_bearing - A0_23._current_bearing < -3000 then
		L5_26 = true
	end
	if L4_25 or A0_23._target_bearing - A0_23._current_bearing < 0 and not L5_26 then
		A0_23._wants_to_spin_left = true
		A0_23._wants_to_spin_right = false
		A0_23._wants_to_slowdown_spin_left = false
		A0_23._wants_to_slowdown_spin_right = false
	else
		A0_23._wants_to_spin_right = true
		A0_23._wants_to_spin_left = false
		A0_23._wants_to_slowdown_spin_left = false
		A0_23._wants_to_slowdown_spin_right = false
	end
	A0_23._wants_to_idle = false
end
function CompassPanel.slow_down_spin_to_bearing(A0_27, A1_28)
	A0_27._target_bearing = A1_28
	if true or A0_27._target_bearing - A0_27._current_bearing < 0 and not true then
		A0_27._wants_to_spin_left = false
		A0_27._wants_to_spin_right = false
		A0_27._wants_to_slowdown_spin_left = true
		A0_27._wants_to_slowdown_spin_right = false
		Application:debug("slow_spin_left", A0_27._current_bearing, A0_27._target_bearing)
	else
		A0_27._wants_to_spin_right = false
		A0_27._wants_to_spin_left = false
		A0_27._wants_to_slowdown_spin_left = false
		A0_27._wants_to_slowdown_spin_right = true
		Application:debug("slow_spin_right", A0_27._current_bearing, A0_27._target_bearing)
	end
	A0_27._wants_to_idle = false
end
function CompassPanel.wants_to_spin_right(A0_29)
	local L1_30
	L1_30 = A0_29._wants_to_spin_right
	return L1_30
end
function CompassPanel.wants_to_spin_left(A0_31)
	local L1_32
	L1_32 = A0_31._wants_to_spin_left
	return L1_32
end
function CompassPanel.wants_to_slowdown_spin_right(A0_33)
	local L1_34
	L1_34 = A0_33._wants_to_slowdown_spin_right
	return L1_34
end
function CompassPanel.wants_to_slowdown_spin_left(A0_35)
	local L1_36
	L1_36 = A0_35._wants_to_slowdown_spin_left
	return L1_36
end
function CompassPanel.wants_to_idle(A0_37)
	local L1_38
	L1_38 = A0_37._wants_to_idle
	return L1_38
end
function CompassPanel.idle(A0_39)
	local L1_40
	A0_39._wants_to_idle = true
	A0_39._wants_to_spin_left = false
	A0_39._wants_to_spin_right = false
end
function CompassPanel.set_bearing(A0_41, A1_42)
	local L2_43, L3_44, L4_45, L5_46, L6_47, L7_48, L8_49, L9_50, L10_51, L11_52, L12_53, L13_54, L14_55
	L2_43 = 10
	L3_44 = A0_41._width
	L3_44 = L3_44 / 2
	L4_45 = math
	L4_45 = L4_45.round
	L5_46 = A0_41._width
	L5_46 = L5_46 / L2_43
	L4_45 = L4_45(L5_46)
	L5_46 = math
	L5_46 = L5_46.round
	L6_47 = L4_45 / 2
	L5_46 = L5_46(L6_47)
	L6_47 = 180
	L7_48 = A1_42 % 10
	if A1_42 < 1 then
		A1_42 = A1_42 + 3600
	elseif A1_42 > 3600 then
		A1_42 = A1_42 - 3600
	end
	A1_42 = L8_49
	A0_41._current_bearing = L8_49
	if A1_42 < 1 then
		A1_42 = 1
		L7_48 = 0
	end
	for L11_52 = A1_42 - 180, A1_42 do
		L12_53 = L11_52
		if L11_52 < 1 then
			L12_53 = L12_53 + 360
		end
		L13_54 = 0
		if L5_46 > L6_47 then
			L14_55 = L6_47 / L5_46
			L13_54 = 1 - L14_55
		end
		L14_55 = L6_47 * L2_43
		L14_55 = L3_44 - L14_55
		L14_55 = L14_55 - L7_48
		A0_41._lines[L12_53].line:set_center_x(L14_55)
		A0_41._lines[L12_53].line:set_color(A0_41._color:with_alpha(L13_54 * tweak_data.machine.hud.MAIN_ALPHA))
		if A0_41._lines[L12_53].text then
			A0_41._lines[L12_53].text._machine_text:set_center_x(L14_55)
			if A0_41.startup_done then
				A0_41._lines[L12_53].text:set_text_alpha(L13_54)
			else
				A0_41._lines[L12_53].text:set_text_alpha(0)
			end
		end
		L6_47 = L6_47 - 1
	end
	L6_47 = 180
	for L11_52 = A1_42 + 180, A1_42, -1 do
		L12_53 = L11_52
		if L11_52 > 360 then
			L12_53 = L12_53 - 360
		end
		L13_54 = 0
		if L5_46 > L6_47 then
			L14_55 = L6_47 / L5_46
			L13_54 = 1 - L14_55
		end
		L14_55 = L6_47 * L2_43
		L14_55 = L3_44 + L14_55
		L14_55 = L14_55 - L7_48
		A0_41._lines[L12_53].line:set_center_x(L14_55)
		A0_41._lines[L12_53].line:set_color(A0_41._color:with_alpha(L13_54 * tweak_data.machine.hud.MAIN_ALPHA))
		if A0_41._lines[L12_53].text then
			A0_41._lines[L12_53].text._machine_text:set_center_x(L14_55)
			if A0_41.startup_done then
				A0_41._lines[L12_53].text:set_text_alpha(L13_54)
			else
				A0_41._lines[L12_53].text:set_text_alpha(0)
			end
		end
		L6_47 = L6_47 - 1
	end
end
function CompassPanel.update(A0_56, A1_57, A2_58, A3_59)
	local L4_60
	L4_60 = MachineHudPanel
	L4_60 = L4_60.update
	L4_60(A0_56, A2_58)
	L4_60 = A0_56._disabled
	if not L4_60 then
		L4_60 = A0_56._shuting_down
	elseif L4_60 then
		return
	end
	L4_60 = math
	L4_60 = L4_60.round
	L4_60 = L4_60(A3_59)
	A0_56:spin_to_bearing(L4_60)
	A0_56._current_direction_time = 0
	A0_56._slow_down_initated = false
	A0_56._state:update(A2_58)
end
function CompassPanel.get_target_size(A0_61)
	local L1_62, L2_63
	L1_62 = A0_61._width
	L2_63 = A0_61._height
	return L1_62, L2_63
end
function CompassPanel.shutdown(A0_64, A1_65, A2_66)
	for 