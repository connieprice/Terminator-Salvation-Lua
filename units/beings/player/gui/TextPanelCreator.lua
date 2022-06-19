TextPanelCreator = TextPanelCreator or class()
function TextPanelCreator.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5)
	local L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12
	A0_0._font = L6_6
	A0_0._x = 0
	A0_0._y = 0
	A0_0._max_height = 0
	A0_0._use_small_font = A4_4
	if not A3_3 then
		L9_9 = 1
		L10_10 = 1
		A3_3 = L6_6
	end
	A0_0._pulse_target = L6_6
	L9_9 = tweak_data
	L9_9 = L9_9.player
	L9_9 = L9_9.new_hud
	L9_9 = L9_9.mission_objectives
	L9_9 = L9_9.ICON_PULSE_SPEED_NOT_COMPLETE
	A0_0._pulse_interpolator = L6_6
	L6_6(L7_7, L8_8)
	A0_0._panel = L6_6
	L6_6(L7_7)
	repeat
		if L6_6 then
			L9_9 = 1
			L10_10 = L6_6 - 1
			L9_9 = A2_2
			L10_10 = L6_6 + 1
			A2_2 = L8_8
			L9_9 = A2_2
			L10_10 = "[]]"
			L10_10 = A2_2
			L9_9 = A2_2.sub
			L11_11 = 1
			L12_12 = L8_8 - 1
			L9_9 = L9_9(L10_10, L11_11, L12_12)
			L11_11 = A2_2
			L10_10 = A2_2.sub
			L12_12 = L8_8 + 1
			L10_10 = L10_10(L11_11, L12_12)
			A2_2 = L10_10
			L10_10 = assert
			L11_11 = L8_8
			L10_10(L11_11)
			L11_11 = A0_0
			L10_10 = A0_0.add_text
			L12_12 = L7_7
			L10_10(L11_11, L12_12, A3_3)
			L11_11 = A0_0
			L10_10 = A0_0.add_icon
			L12_12 = L9_9
			L10_10(L11_11, L12_12)
		end
	until L6_6 == nil
	if L6_6 > 0 then
		L9_9 = A3_3
		L6_6(L7_7, L8_8, L9_9)
	end
	L9_9 = A0_0._max_height
	L6_6(L7_7, L8_8, L9_9)
	L12_12 = L7_7(L8_8)
	for L9_9, L10_10 in L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L7_7(L8_8)) do
		L12_12 = L10_10
		L11_11 = L10_10.height
		L11_11 = L11_11(L12_12)
		L12_12 = A0_0._max_height
		L12_12 = L12_12 - L11_11
		L12_12 = L12_12 / 2
		L10_10:set_y(L12_12)
	end
	A0_0._move_to_position = A5_5
	if L6_6 then
		A0_0._target_position = L6_6
		L9_9 = tweak_data
		L9_9 = L9_9.player
		L9_9 = L9_9.new_hud
		L9_9 = L9_9.mission_objectives
		L9_9 = L9_9.ICON_PULSE_SPEED_NOT_COMPLETE
		A0_0._move_interpolator = L6_6
		L6_6(L7_7, L8_8)
	else
		L9_9 = L8_8
		L9_9 = L8_8
		L12_12 = L8_8(L9_9)
		L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L8_8(L9_9))
	end
	L6_6(L7_7)
end
function TextPanelCreator.add_text(A0_13, A1_14, A2_15)
	if A0_13._use_small_font then
		A0_13._panel:text({
			valign = "center",
			x = A0_13._x,
			font = A0_13._font,
			font_size = 25,
			color = A2_15,
			text = A1_14,
			layer = 100
		}):set_font_scale(tweak_data.player.new_hud.TEXTPANEL_SMALL_FONT_FACTOR)
	end
	A0_13._panel:text({
		valign = "center",
		x = A0_13._x,
		font = A0_13._font,
		font_size = 25,
		color = A2_15,
		text = A1_14,
		layer = 100
	}):set_height(A0_13._panel:text({
		valign = "center",
		x = A0_13._x,
		font = A0_13._font,
		font_size = 25,
		color = A2_15,
		text = A1_14,
		layer = 100
	}):line_height())
	A0_13._x = A0_13._x + A0_13._panel:text({
		valign = "center",
		x = A0_13._x,
		font = A0_13._font,
		font_size = 25,
		color = A2_15,
		text = A1_14,
		layer = 100
	}):text_rect()
	if A0_13._panel:text({
		valign = "center",
		x = A0_13._x,
		font = A0_13._font,
		font_size = 25,
		color = A2_15,
		text = A1_14,
		layer = 100
	}):text_rect() > A0_13._max_height then
		A0_13._max_height = A0_13._panel:text({
			valign = "center",
			x = A0_13._x,
			font = A0_13._font,
			font_size = 25,
			color = A2_15,
			text = A1_14,
			layer = 100
		}):text_rect()
	end
end
function TextPanelCreator.add_icon(A0_16, A1_17)
	local L2_18
	if A1_17:sub(1, 7) == "action:" then
		A1_17 = A1_17:sub(8)
		L2_18 = "gui_button_" .. ({
			revive = "y",
			cover = "a",
			pick_up = "y",
			look_at = "y"
		})[A1_17]
	else
		L2_18 = "gui_" .. A1_17
	end
	A0_16._panel:bitmap({valign = "center", texture = L2_18}):set_left(A0_16._x)
	A0_16._x = A0_16._x + A0_16._panel:bitmap({valign = "center", texture = L2_18}):texture_width()
	if A0_16._panel:bitmap({valign = "center", texture = L2_18}):texture_height() > A0_16._max_height then
		A0_16._max_height = A0_16._panel:bitmap({valign = "center", texture = L2_18}):texture_height()
	end
	if L2_18 == "gui_mission_objectivebox_completed" then
		A0_16._pulse_icon = A0_16._panel:bitmap({valign = "center", texture = L2_18})
		A0_16._pulse_interpolator:set_speed(tweak_data.player.new_hud.mission_objectives.ICON_PULSE_SPEED_COMPLETE)
	elseif L2_18 == "gui_mission_objectivebox_not_completed" then
		A0_16._pulse_icon = A0_16._panel:bitmap({valign = "center", texture = L2_18})
		A0_16._pulse_interpolator:set_speed(tweak_data.player.new_hud.mission_objectives.ICON_PULSE_SPEED_NOT_COMPLETE)
	else
		A0_16._pulse_icon = nil
	end
end
function TextPanelCreator.panel(A0_19)
	local L1_20
	L1_20 = A0_19._panel
	return L1_20
end
function TextPanelCreator.update_icon_pulse(A0_21, A1_22)
	local L2_23, L3_24, L4_25
	L2_23 = A0_21._pulse_icon
	if not L2_23 then
		return
	end
	L2_23 = A0_21._pulse_interpolator
	L3_24 = L2_23
	L2_23 = L2_23.update
	L4_25 = A1_22
	L2_23(L3_24, L4_25)
	L2_23 = A0_21._pulse_interpolator
	L3_24 = L2_23
	L2_23 = L2_23.value
	L2_23 = L2_23(L3_24)
	L3_24 = A0_21._pulse_interpolator
	L4_25 = L3_24
	L3_24 = L3_24.has_reached_target
	L3_24 = L3_24(L4_25)
	if L3_24 then
		L3_24 = A0_21._pulse_interpolator
		L4_25 = L3_24
		L3_24 = L3_24.target
		L3_24 = L3_24(L4_25)
		L2_23 = L3_24
	end
	L3_24 = A0_21._pulse_target
	if L2_23 == L3_24 then
		L3_24 = A0_21._pulse_interpolator
		L4_25 = L3_24
		L3_24 = L3_24.set_target
		L3_24(L4_25, 1)
	elseif L2_23 == 1 then
		L3_24 = A0_21._pulse_interpolator
		L4_25 = L3_24
		L3_24 = L3_24.set_target
		L3_24(L4_25, A0_21._pulse_target)
	end
	L3_24 = A0_21._pulse_icon
	L4_25 = L3_24
	L3_24 = L3_24.center_x
	L3_24 = L3_24(L4_25)
	L4_25 = A0_21._pulse_icon
	L4_25 = L4_25.center_y
	L4_25 = L4_25(L4_25)
	A0_21._pulse_icon:set_size(64 * L2_23, 64 * L2_23)
	A0_21._pulse_icon:set_center(L3_24, L4_25)
end
function TextPanelCreator.update_mover(A0_26, A1_27)
	local L2_28
	L2_28 = A0_26._move_to_position
	if not L2_28 then
		return
	end
	L2_28 = A0_26._move_interpolator
	L2_28 = L2_28.update
	L2_28(L2_28, A1_27)
	L2_28 = A0_26._move_interpolator
	L2_28 = L2_28.value
	L2_28 = L2_28(L2_28)
	if A0_26._move_interpolator:has_reached_target() then
		L2_28 = A0_26._move_interpolator:target()
	end
	A0_26._panel:set_world_center_x(L2_28)
end
