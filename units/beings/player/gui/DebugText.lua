require("units/beings/player/gui/TextPanelCreator")
require("units/beings/player/gui/TopToBottomHudElementStack")
DebugText = DebugText or class()
DebugText.TIMEOUT = 3
function DebugText.init(A0_0, A1_1)
	local L2_2
	L2_2 = 15
	A0_0._debug_text_element_stack = TopToBottomHudElementStack:new(A1_1, L2_2)
	A0_0._debug_text_element_stack:set_show_timeout(0.5)
	A0_0._start_text_timer = false
	A0_0._panel_and_timer = {}
end
function DebugText.destroy(A0_3)
	A0_3._debug_text_element_stack:destroy()
end
function DebugText.update(A0_4, A1_5)
	for 