require("units/beings/player/gui/HudElementStackItem")
if not HudElementStack then
	HudElementStack = class()
end
HudElementStack.init = function(l_1_0, l_1_1, l_1_2)
	assert(l_1_1)
	l_1_0._panel = l_1_1
	l_1_0._hud_elements = {}
	l_1_0._panel_to_element = {}
	l_1_0._spacing = 3
	l_1_0._highest_index = 0
	do
		l_1_0._maximum_messages_shown = l_1_2 or 2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

HudElementStack.panel = function(l_2_0)
	return l_2_0._panel
end

HudElementStack.destroy = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7, l_3_8, l_3_9 = nil
	for i_0,i_1 in ipairs(l_3_0._hud_elements) do
		if alive(i_1._panel) then
			l_3_0._panel:remove(i_1._panel)
		end
	end
	l_3_0._hud_elements = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

HudElementStack.set_show_timeout = function(l_4_0, l_4_1)
	l_4_0._show_timeout = l_4_1
end

HudElementStack.create_hud_panel = function(l_5_0)
	local l_5_1, l_5_2 = l_5_0._panel:panel, l_5_0._panel
	local l_5_3 = {}
	l_5_3.valign = "center"
	l_5_3.halign = "grow"
	l_5_1 = l_5_1(l_5_2, l_5_3)
	l_5_2 = HudElementStackItem
	l_5_2, l_5_3 = l_5_2:new, l_5_2
	l_5_2 = l_5_2(l_5_3, l_5_1, l_5_0._show_timeout)
	l_5_3 = l_5_0._highest_index
	l_5_3 = l_5_3 + 1
	l_5_0._highest_index = l_5_3
	l_5_3 = l_5_0._highest_index
	l_5_0._hud_elements[l_5_3] = l_5_2
	l_5_0._panel_to_element[l_5_1:key()] = l_5_2
	return l_5_1
end

HudElementStack.hud_panel_done = function(l_6_0)
	l_6_0:_recalculate_target_positions(0)
end

HudElementStack.remove_hud_panel = function(l_7_0, l_7_1)
	if not alive(l_7_1) then
		return 
	end
	local l_7_2 = l_7_0._panel_to_element[l_7_1:key()]
	assert(l_7_2)
	l_7_0._panel_to_element[l_7_1:key()] = nil
	l_7_2:mark_as_done()
end

HudElementStack.update = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14, l_8_15, l_8_16, l_8_17, l_8_22, l_8_23 = nil
	for i_0,i_1 in pairs(l_8_0._hud_elements) do
		i_1:update(l_8_1)
	end
	for i_0,i_1 in ipairs(l_8_0._hud_elements) do
		if i_1:wants_to_be_removed() then
			l_8_0._panel:remove(i_1._panel)
			for l_8_21 = i_0, l_8_0._highest_index do
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				l_8_0._hud_elements[l_8_13] = l_8_0._hud_elements[l_8_13 + 1]
			end
			l_8_0._highest_index = l_8_0._highest_index - 1
		end
	end
	l_8_0:_recalculate_target_positions(l_8_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

HudElementStack._recalculate_target_positions = function(l_9_0, l_9_1)
	local l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14, l_9_15, l_9_16, l_9_17, l_9_18, l_9_19, l_9_20, l_9_21, l_9_22, l_9_23 = nil
	local l_9_2 = l_9_0._panel:bottom() - l_9_0._panel:height() * 0.05
	local l_9_3 = 50
	for i_0,i_1 in ipairs(l_9_0._hud_elements) do
		if i_0 <= l_9_0._maximum_messages_shown then
			i_1:mark_should_show()
		end
		l_9_2 = l_9_2 - i_1._panel:height() - l_9_0._spacing
		if i_1:y_has_been_set() and l_9_2 < i_1:y() then
			l_9_2 = i_1:y() - l_9_3 * l_9_1
		end
		i_1:set_y(l_9_2)
	end
end

HudElementStack.use_top_align = function(l_10_0, l_10_1)
	local l_10_5, l_10_6, l_10_7, l_10_8 = nil
	for i_0,i_1 in ipairs(l_10_0._hud_elements) do
		i_1:use_top_align(l_10_1)
	end
end


