require("units/beings/player/gui/ContextActionHudStates")
require("units/beings/player/gui/TextPanelCreator")
ContextActionHud = ContextActionHud or class()
function ContextActionHud.init(A0_0, A1_1, A2_2)
	A0_0._panel_creator = A1_1
	Localizer:load("data/strings/context_actions.xml")
	A0_0._alpha = Interpolator:new(0, 10)
	A0_0._state = FiniteStateMachine:new(A0_0, "item", ContextActionHudIdle)
	A0_0._use_timeout = not A2_2
end
function ContextActionHud.update(A0_3, A1_4)
	A0_3._state:update(A1_4)
end
function ContextActionHud.display(A0_5, A1_6, ...)
	local L3_8
	L3_8 = assert
	L3_8(A1_6)
	L3_8 = Localizer
	L3_8 = L3_8.lookup
	L3_8 = L3_8(L3_8, A1_6)
	L3_8 = L3_8.format(L3_8, ...)
	A0_5:display_with_color(L3_8)
end
function ContextActionHud.display_with_color(A0_9, A1_10, A2_11)
	local L3_12
	L3_12 = A0_9._last_text
	if L3_12 ~= A1_10 then
		A0_9._wants_to_show_new_text = true
	end
	A0_9._text = A1_10
	L3_12 = A0_9._text
	A0_9._last_text = L3_12
	A0_9._text_color = A2_11
end
function ContextActionHud.hide(A0_13)
	local L1_14
	A0_13._text = nil
	A0_13._last_text = nil
	A0_13._wants_to_show_new_text = false
end
function ContextActionHud.wants_to_show_new_text(A0_15)
	local L1_16
	L1_16 = A0_15._wants_to_show_new_text
	return L1_16
end
function ContextActionHud.wants_to_hide(A0_17)
	return A0_17:wants_to_show_new_text() or A0_17._text == nil
end
function ContextActionHud.construct_panel(A0_18)
	if A0_18._action_panel then
		A0_18:destroy_panel()
	end
	A0_18._action_panel = TextPanelCreator:new(A0_18._panel_creator, A0_18._text, A0_18._text_color):panel()
	A0_18._wants_to_show_new_text = false
end
function ContextActionHud.destroy_panel(A0_19)
	assert(A0_19._action_panel)
	A0_19._panel_creator:remove_hud_panel(A0_19._action_panel)
	A0_19._action_panel = nil
end
