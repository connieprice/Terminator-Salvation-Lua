require("units/beings/player/gui/HudElementStackItem")
HudElementStack = HudElementStack or class()
function HudElementStack.init(A0_0, A1_1, A2_2)
	assert(A1_1)
	A0_0._panel = A1_1
	A0_0._hud_elements = {}
	A0_0._panel_to_element = {}
	A0_0._spacing = 3
	A0_0._highest_index = 0
	A0_0._maximum_messages_shown = A2_2 or 2
end
function HudElementStack.panel(A0_3)
	local L1_4
	L1_4 = A0_3._panel
	return L1_4
end
function HudElementStack.destroy(A0_5)
	for 