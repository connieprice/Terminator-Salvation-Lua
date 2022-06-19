require("units/beings/player_tank/gui/MachineTextStates")
MachineText = MachineText or class()
function MachineText.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	local L5_5, L6_6
	A0_0._parent_panel = A1_1
	L5_5 = A2_2 or 0
	A0_0._x = L5_5
	L5_5 = A3_3 or 0
	A0_0._y = L5_5
	A0_0._text_length = 0
	A0_0._time_lived = 0
	L5_5 = tweak_data
	L5_5 = L5_5.machine
	L5_5 = L5_5.hud
	L6_6 = tweak_data
	L6_6 = L6_6.machine
	L6_6 = L6_6.hud
	L6_6 = L6_6.MAIN_ALPHA
	L5_5.MAIN_ALPHA = L6_6
	A0_0._font_scale = A4_4
end
function MachineText.get_panel(A0_7)
	local L1_8
	L1_8 = A0_7._machine_text
	return L1_8
end
function MachineText.set_text(A0_9, A1_10, A2_11, A3_12)
	A0_9:_set_text(A1_10, A2_11, A3_12)
	A0_9:set_text_alpha(0, A0_9._text_length)
	A0_9:fade_in()
end
function MachineText._set_text(A0_13, A1_14, A2_15, A3_16)
	local L4_17, L5_18
	L4_17 = A0_13._current_str
	if L4_17 == A1_14 then
		return
	end
	A0_13._current_str = A1_14
	L5_18 = A0_13
	L4_17 = A0_13.parse_text
	L4_17 = L4_17(L5_18, A1_14)
	L5_18 = A0_13._machine_text
	if not L5_18 then
		L5_18 = A0_13._parent_panel
		L5_18 = L5_18.text
		L5_18 = L5_18(L5_18, {
			valign = "left",
			font = tweak_data.machine.hud.text.TEXT_FONT,
			font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE,
			color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA),
			text = L4_17,
			x = A0_13._x,
			y = A0_13._y
		})
		A0_13._machine_text = L5_18
		L5_18 = A0_13._font_scale
		if L5_18 then
			L5_18 = A0_13._machine_text
			L5_18 = L5_18.set_font_scale
			L5_18(L5_18, A0_13._font_scale)
		end
	else
		L5_18 = A0_13._machine_text
		L5_18 = L5_18.set_text
		L5_18(L5_18, L4_17)
	end
	if A3_16 then
		L5_18 = A0_13._machine_text
		L5_18 = L5_18.number_of_lines
		L5_18 = L5_18(L5_18)
		if A3_16 < L5_18 then
			L5_18 = A0_13._machine_text
			L5_18 = L5_18.line_height
			L5_18 = L5_18(L5_18)
			L5_18 = L5_18 * A3_16
			A0_13._machine_text:set_h(L5_18)
		end
	end
	A0_13._blink = A2_15
	L5_18 = A1_14.len
	L5_18 = L5_18(A1_14)
	A0_13._text_length = L5_18
	A0_13._current_visible_characters = 0
end
function MachineText.get_text(A0_19)
	return A0_19._machine_text:text()
end
function MachineText.update_text(A0_20, A1_21, A2_22)
	if not A0_20._machine_text then
		return
	end
	A0_20:_set_text(A1_21)
	A0_20._wants_to_blink = A2_22
end
function MachineText.set_alignment(A0_23, A1_24, A2_25)
	if not A0_23._machine_text then
		A0_23:_set_text("")
	end
	A0_23._machine_text:set_align(A1_24)
	A0_23._machine_text:set_vertical(A2_25)
end
function MachineText.use_small_font(A0_26)
	if not A0_26._machine_text then
		A0_26:_set_text("")
	end
	A0_26._machine_text:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_SMALL)
end
function MachineText.use_very_small_font(A0_27)
	if not A0_27._machine_text then
		A0_27:_set_text("")
	end
	A0_27._machine_text:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_VERY_SMALL)
end
function MachineText.use_normal_font(A0_28)
	if not A0_28._machine_text then
		A0_28:_set_text("")
	end
	A0_28._machine_text:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE)
end
function MachineText.use_big_font(A0_29)
	if not A0_29._machine_text then
		A0_29:_set_text("")
	end
	A0_29._machine_text:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG)
end
function MachineText.set_text_alpha(A0_30, A1_31, A2_32, A3_33)
	local L4_34, L5_35, L7_36, L8_37, L9_38
	A0_30._alpha = A1_31
	L4_34 = tweak_data
	L4_34 = L4_34.machine
	L4_34 = L4_34.hud
	L4_34 = L4_34.MAIN_ALPHA
	A1_31 = A1_31 * L4_34
	L4_34 = A0_30._machine_text
	if L4_34 then
		L4_34 = A2_32 or A0_30._text_length
		L5_35 = A3_33 or 0
		L7_36 = A0_30._machine_text
		L8_37 = L7_36
		L7_36 = L7_36.set_range_color
		L9_38 = L5_35
		L7_36(L8_37, L9_38, L4_34, tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(A1_31))
	end
end
function MachineText.set_center_x(A0_39, A1_40)
	A0_39._machine_text:set_center_x(A1_40)
end
function MachineText.width(A0_41)
	return A0_41._machine_text:width()
end
function MachineText.text_length(A0_42)
	local L1_43
	L1_43 = A0_42._text_length
	return L1_43
end
function MachineText.fade_in(A0_44)
	local L1_45
	A0_44._displayed_time = 0
	A0_44._delay_time = 0.2
	A0_44._show_text = true
	L1_45 = A0_44._blink
	if L1_45 then
		L1_45 = tweak_data
		L1_45 = L1_45.machine
		L1_45 = L1_45.hud
		L1_45 = L1_45.text
		L1_45 = L1_45.BLINK_DELAY
		A0_44._next_blink = L1_45
	end
end
function MachineText.fade_out(A0_46)
	A0_46:set_text_alpha(A0_46._alpha)
	A0_46._show_text = false
end
function MachineText.update(A0_47, A1_48)
	A0_47._time_lived = A0_47._time_lived + A1_48
	A0_47:_update_text(A1_48)
	if not A0_47._life_time or A0_47._time_lived > A0_47._life_time then
	end
end
function MachineText._update_text(A0_49, A1_50)
	if not A0_49._show_text then
		return
	end
	A0_49._displayed_time = A0_49._displayed_time + A1_50
	if A0_49._displayed_time < A0_49._delay_time then
		return
	end
	A0_49._visible_characters = math.floor((A0_49._displayed_time - A0_49._delay_time) / tweak_data.machine.hud.text.TEXT_SPEED)
	A0_49._visible_characters = math.min(A0_49._visible_characters, A0_49._text_length)
	if A0_49._blink then
		if A0_49._next_blink < A0_49._displayed_time then
			if A0_49._alpha == 1 then
				A0_49:set_text_alpha(0, A0_49._visible_characters)
			else
				A0_49:set_text_alpha(1, A0_49._visible_characters)
			end
			A0_49._next_blink = A0_49._displayed_time + tweak_data.machine.hud.text.BLINK_SPEED
		end
	elseif A0_49._visible_characters ~= A0_49._current_visible_characters then
		A0_49:set_text_alpha(1, A0_49._visible_characters)
		A0_49._current_visible_characters = A0_49._visible_characters
	end
end
function MachineText.parse_text(A0_51, A1_52)
	local L2_53, L3_54, L4_55, L5_56
	if L2_53 then
		for L5_56 in L2_53(L3_54, L4_55) do
			L5_56 = A0_51:replace_with_randoms(L5_56)
			A1_52 = A1_52:gsub("(%b[])", L5_56, 1)
		end
	end
	return A1_52
end
function MachineText.replace_with_randoms(A0_57, A1_58)
	local L2_59, L3_60, L4_61, L5_62
	L2_59 = {}
	L4_61 = A1_58
	L3_60 = A1_58.find
	L5_62 = "(%d+)"
	L5_62 = L3_60(L4_61, L5_62)
	for _FORV_9_ = 1, L5_62 do
		table.insert(L2_59, math.round(math.rand(7)))
	end
	return _FOR_.concat(L2_59)
end
