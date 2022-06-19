require("shared/Interpolator")
require("shared/FiniteStateMachine")
require("units/beings/player/gui/HudElementStackItemStates")
HudElementStackItem = HudElementStackItem or class()
function HudElementStackItem.init(A0_0, A1_1, A2_2)
	A0_0._panel = A1_1
	A0_0._show_timeout = A2_2
	A0_0._state = FiniteStateMachine:new(A0_0, "item", HudElementStackItemStateInvisible)
end
function HudElementStackItem.update(A0_3, A1_4)
	A0_3._state:update(A1_4)
end
function HudElementStackItem.y_has_been_set(A0_5)
	local L1_6
	L1_6 = A0_5._y_has_been_set
	return L1_6
end
function HudElementStackItem.use_top_align(A0_7, A1_8)
	A0_7._use_top_align = A1_8
end
function HudElementStackItem.set_y(A0_9, A1_10)
	if A0_9._use_top_align then
		A0_9._panel:set_bottom(A1_10)
	else
		A0_9._panel:set_y(A1_10)
	end
	A0_9._y_has_been_set = true
end
function HudElementStackItem.set_bottom(A0_11, A1_12)
	A0_11._panel:set_bottom(A1_12)
	A0_11._y_has_been_set = true
end
function HudElementStackItem.y(A0_13)
	if A0_13._use_top_align then
		return A0_13._panel:bottom()
	else
		return A0_13._panel:y()
	end
end
function HudElementStackItem.mark_should_show(A0_14)
	local L1_15
	A0_14._should_show = true
end
function HudElementStackItem.should_show(A0_16)
	local L1_17
	L1_17 = A0_16._should_show
	return L1_17
end
function HudElementStackItem.mark_as_done(A0_18)
	local L1_19
	A0_18._is_done = true
end
function HudElementStackItem.is_done(A0_20)
	local L1_21
	L1_21 = A0_20._is_done
	return L1_21
end
function HudElementStackItem.mark_fading_out(A0_22)
	local L1_23
	A0_22._is_fading_out = true
end
function HudElementStackItem.is_fading_out(A0_24)
	local L1_25
	L1_25 = A0_24._is_fading_out
	return L1_25
end
function HudElementStackItem.set_wants_to_be_removed(A0_26)
	local L1_27
	A0_26._wants_to_be_removed = true
end
function HudElementStackItem.wants_to_be_removed(A0_28)
	local L1_29
	L1_29 = A0_28._wants_to_be_removed
	return L1_29
end
function HudElementStackItem.show_timeout(A0_30)
	local L1_31
	L1_31 = A0_30._show_timeout
	return L1_31
end
