require("units/beings/player/gui/TextPanelCreator")
require("units/beings/player/gui/TopToBottomHudElementStack")
if not DebugText then
	DebugText = class()
end
DebugText.TIMEOUT = 3
DebugText.init = function(l_1_0, l_1_1)
	local l_1_2 = 15
	l_1_0._debug_text_element_stack = TopToBottomHudElementStack:new(l_1_1, l_1_2)
	l_1_0._debug_text_element_stack:set_show_timeout(0.5)
	l_1_0._start_text_timer = false
	l_1_0._panel_and_timer = {}
end

DebugText.destroy = function(l_2_0)
	l_2_0._debug_text_element_stack:destroy()
end

DebugText.update = function(l_3_0, l_3_1)
	local l_3_5, l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11, l_3_12, l_3_13, l_3_14, l_3_15, l_3_16, l_3_17, l_3_18, l_3_19, l_3_20 = nil
	for i_0,i_1 in pairs(l_3_0._panel_and_timer) do
		i_1.timer = i_1.timer + l_3_1
		if l_3_0.TIMEOUT < i_1.timer and i_1.panel then
			l_3_0._panel_and_timer[i_1.panel:key()] = nil
			l_3_0._debug_text_element_stack:remove_hud_panel(i_1.panel)
		end
	end
	l_3_0._debug_text_element_stack:update(l_3_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DebugText.set_debug_text = function(l_4_0, l_4_1)
	l_4_0:show_next_line(l_4_1)
end

DebugText.show_next_line = function(l_5_0, l_5_1)
	if l_5_1 then
		local l_5_2 = TextPanelCreator:new(l_5_0._debug_text_element_stack, l_5_1, l_5_0._color)
		local l_5_3 = {}
		l_5_3.panel = l_5_2:panel()
		l_5_3.timer = 0
		l_5_3.debug_text = l_5_1
		l_5_0._panel_and_timer[l_5_3.panel:key()] = l_5_3
	end
end


