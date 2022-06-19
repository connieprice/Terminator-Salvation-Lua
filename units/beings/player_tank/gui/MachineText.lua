require("units/beings/player_tank/gui/MachineTextStates")
if not MachineText then
	MachineText = class()
end
MachineText.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._parent_panel = l_1_1
	do
		l_1_0._x = l_1_2 or 0
		l_1_0._y = l_1_3 or 0
		l_1_0._text_length = 0
		l_1_0._time_lived = 0
		tweak_data.machine.hud.MAIN_ALPHA = tweak_data.machine.hud.MAIN_ALPHA
		l_1_0._font_scale = l_1_4
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MachineText.get_panel = function(l_2_0)
	return l_2_0._machine_text
end

MachineText.set_text = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0:_set_text(l_3_1, l_3_2, l_3_3)
	l_3_0:set_text_alpha(0, l_3_0._text_length)
	l_3_0:fade_in()
end

MachineText._set_text = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if l_4_0._current_str == l_4_1 then
		return 
	end
	l_4_0._current_str = l_4_1
	local l_4_4 = l_4_0:parse_text(l_4_1)
	if not l_4_0._machine_text then
		local l_4_5, l_4_6 = l_4_0._parent_panel:text, l_4_0._parent_panel
		local l_4_7 = {}
		l_4_7.valign = "left"
		l_4_7.font = tweak_data.machine.hud.text.TEXT_FONT
		l_4_7.font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE
		l_4_7.color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA)
		l_4_7.text = l_4_4
		l_4_7.x = l_4_0._x
		l_4_7.y = l_4_0._y
		l_4_5 = l_4_5(l_4_6, l_4_7)
		l_4_0._machine_text = l_4_5
		l_4_5 = l_4_0._font_scale
		if l_4_5 then
			l_4_5 = l_4_0._machine_text
			l_4_5, l_4_6 = l_4_5:set_font_scale, l_4_5
			l_4_7 = l_4_0._font_scale
			l_4_5(l_4_6, l_4_7)
		end
	else
		l_4_0._machine_text:set_text(l_4_4)
	end
	if l_4_3 and l_4_3 < l_4_0._machine_text:number_of_lines() then
		local l_4_8 = l_4_0._machine_text:line_height() * l_4_3
		l_4_0._machine_text:set_h(l_4_8)
	end
	l_4_0._blink = l_4_2
	l_4_0._text_length = l_4_1:len()
	l_4_0._current_visible_characters = 0
end

MachineText.get_text = function(l_5_0)
	local l_5_1, l_5_2 = l_5_0._machine_text:text, l_5_0._machine_text
	return l_5_1(l_5_2)
end

MachineText.update_text = function(l_6_0, l_6_1, l_6_2)
	if not l_6_0._machine_text then
		return 
	end
	l_6_0:_set_text(l_6_1)
	l_6_0._wants_to_blink = l_6_2
end

MachineText.set_alignment = function(l_7_0, l_7_1, l_7_2)
	if not l_7_0._machine_text then
		l_7_0:_set_text("")
	end
	l_7_0._machine_text:set_align(l_7_1)
	l_7_0._machine_text:set_vertical(l_7_2)
end

MachineText.use_small_font = function(l_8_0)
	if not l_8_0._machine_text then
		l_8_0:_set_text("")
	end
	l_8_0._machine_text:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_SMALL)
end

MachineText.use_very_small_font = function(l_9_0)
	if not l_9_0._machine_text then
		l_9_0:_set_text("")
	end
	l_9_0._machine_text:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_VERY_SMALL)
end

MachineText.use_normal_font = function(l_10_0)
	if not l_10_0._machine_text then
		l_10_0:_set_text("")
	end
	l_10_0._machine_text:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE)
end

MachineText.use_big_font = function(l_11_0)
	if not l_11_0._machine_text then
		l_11_0:_set_text("")
	end
	l_11_0._machine_text:set_font_size(tweak_data.machine.hud.text.TEXT_FONT_SIZE_BIG)
end

MachineText.set_text_alpha = function(l_12_0, l_12_1, l_12_2, l_12_3)
	l_12_0._alpha = l_12_1
	l_12_1 = l_12_1 * tweak_data.machine.hud.MAIN_ALPHA
	do
		if l_12_2 or not l_12_3 then
			l_12_0._machine_text:set_range_color(not l_12_0._machine_text or 0, l_12_0._text_length, tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(l_12_1))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 16 
end

MachineText.set_center_x = function(l_13_0, l_13_1)
	l_13_0._machine_text:set_center_x(l_13_1)
end

MachineText.width = function(l_14_0)
	local l_14_1, l_14_2 = l_14_0._machine_text:width, l_14_0._machine_text
	return l_14_1(l_14_2)
end

MachineText.text_length = function(l_15_0)
	return l_15_0._text_length
end

MachineText.fade_in = function(l_16_0)
	l_16_0._displayed_time = 0
	l_16_0._delay_time = 0.2
	l_16_0._show_text = true
	if l_16_0._blink then
		l_16_0._next_blink = tweak_data.machine.hud.text.BLINK_DELAY
	end
end

MachineText.fade_out = function(l_17_0)
	l_17_0:set_text_alpha(l_17_0._alpha)
	l_17_0._show_text = false
end

MachineText.update = function(l_18_0, l_18_1)
	l_18_0._time_lived = l_18_0._time_lived + l_18_1
	l_18_0:_update_text(l_18_1)
	if not l_18_0._life_time or l_18_0._life_time < l_18_0._time_lived then
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 14 
end

MachineText._update_text = function(l_19_0, l_19_1)
	if not l_19_0._show_text then
		return 
	end
	l_19_0._displayed_time = l_19_0._displayed_time + l_19_1
	if l_19_0._displayed_time < l_19_0._delay_time then
		return 
	end
	l_19_0._visible_characters = math.floor((l_19_0._displayed_time - l_19_0._delay_time) / tweak_data.machine.hud.text.TEXT_SPEED)
	l_19_0._visible_characters = math.min(l_19_0._visible_characters, l_19_0._text_length)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_19_0._blink and l_19_0._next_blink < l_19_0._displayed_time then
		if l_19_0._alpha == 1 then
			l_19_0:set_text_alpha(0, l_19_0._visible_characters)
		else
			l_19_0:set_text_alpha(1, l_19_0._visible_characters)
		end
		l_19_0._next_blink = l_19_0._displayed_time + tweak_data.machine.hud.text.BLINK_SPEED
	end
	do return end
	if l_19_0._visible_characters ~= l_19_0._current_visible_characters then
		l_19_0:set_text_alpha(1, l_19_0._visible_characters)
		l_19_0._current_visible_characters = l_19_0._visible_characters
	end
end

MachineText.parse_text = function(l_20_0, l_20_1)
	local l_20_5 = nil
	if l_20_1:find("random") then
		for i_0 in l_20_1:gfind("(%b[])") do
			i_0 = l_20_0:replace_with_randoms(i_0)
			l_20_1 = l_20_1:gsub("(%b[])", l_20_6, 1)
		end
	end
	return l_20_1
end

MachineText.replace_with_randoms = function(l_21_0, l_21_1)
	local l_21_2 = {}
	local l_21_3, l_21_4, l_21_5 = l_21_1:find("(%d+)")
	for l_21_9 = 1, l_21_5 do
		local l_21_12, l_21_13 = nil
		l_21_12 = table
		l_21_12 = l_21_12.insert
		local l_21_14 = nil
		l_21_13 = l_21_2
		local l_21_15 = nil
		l_21_14 = math
		l_21_14 = l_21_14.round
		l_21_15 = math
		l_21_15 = l_21_15.rand
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_21_14 = l_21_14(l_21_15)
		local l_21_16, l_21_17, l_21_18 = nil
		l_21_12(l_21_13, l_21_14, l_21_15, l_21_16, l_21_17, l_21_18)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	local l_21_10 = table.concat
	local l_21_11 = l_21_2
	return l_21_10(l_21_11)
end


