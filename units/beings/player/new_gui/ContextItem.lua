require("units/beings/player/new_gui/ContextItemStates")
ContextItem = ContextItem or class()
function ContextItem.init(A0_0, A1_1, A2_2)
	A0_0._parent_panel = A1_1
	A0_0._timeout_time = A2_2
	A0_0._width = 700
	A0_0._height = 50
	A0_0._x = 0
	A0_0._y = A0_0._parent_panel:height() + 12
	A0_0._center_x = A0_0._width / 2
	A0_0._panel = A0_0._parent_panel:panel({
		name = "_panel",
		width = A0_0._width,
		height = A0_0._height
	})
	A0_0._context_item_texts = {}
	A0_0._context_item_icons = {}
	A0_0:set_alpha(0)
	A0_0._state = FiniteStateMachine:new(A0_0, "_context_item", ContextItemIdleState)
	A0_0._state:set_debug(false)
	A0_0._time = 0
end
function ContextItem.display(A0_3, A1_4, A2_5, ...)
	local L4_7
	L4_7 = assert
	L4_7(A1_4)
	L4_7 = alive
	L4_7 = L4_7(A0_3._panel)
	if not L4_7 then
		return
	end
	L4_7 = managers
	L4_7 = L4_7.localization
	L4_7 = L4_7.text
	L4_7 = L4_7(L4_7, A1_4, A0_3._localizer_mapping)
	L4_7 = L4_7.format(L4_7, ...)
	if A0_3._timed_out then
		return
	end
	if L4_7 ~= A0_3._current_context_string then
		A0_3._current_context_string = L4_7
		A0_3:_parse_context_string(L4_7)
		A0_3._panel:set_center_x(A0_3._parent_panel:width() / 2)
	end
	if A2_5 then
		A0_3:_set_position(A2_5)
		A0_3._move_down_interpolator = nil
	end
	A0_3:fade_in()
end
function ContextItem._set_position(A0_8, A1_9)
	local L2_10
	L2_10 = A0_8._y
	L2_10 = L2_10 - (A1_9 - 1) * tweak_data.player.new_hud.context_panel.OFFSET_MESSAGES
	A0_8._panel:set_bottom(L2_10)
end
function ContextItem.update_item(A0_11, A1_12, ...)
	local L3_14, L4_15, L5_16, L6_17, L7_18
	L4_15 = A0_11
	L3_14 = A0_11.display
	L5_16 = A1_12
	L6_17 = nil
	L7_18 = ...
	L3_14(L4_15, L5_16, L6_17, L7_18)
	return
end
function ContextItem.get_timeout(A0_19)
	local L1_20
	L1_20 = A0_19._timeout_time
	return L1_20
end
function ContextItem.set_timed_out(A0_21)
	local L1_22
	A0_21._timed_out = true
	A0_21._wants_to_fade_out = true
	A0_21._wants_to_fade_in = false
end
function ContextItem.timed_out(A0_23)
	local L1_24
	L1_24 = A0_23._timed_out
	return L1_24
end
function ContextItem.instant_hide(A0_25)
	A0_25.is_instant_hide = true
	A0_25:set_alpha(0)
end
function ContextItem.fade_in(A0_26)
	local L1_27
	A0_26.is_instant_hide = false
	A0_26._wants_to_fade_in = true
	A0_26._wants_to_fade_out = false
	A0_26._wants_to_idle = false
end
function ContextItem.fade_out(A0_28)
	if A0_28:allowed_to_fade_out() then
		A0_28.is_instant_hide = false
		A0_28._wants_to_fade_out = true
		A0_28._wants_to_fade_in = false
		A0_28._wants_to_idle = false
		A0_28._timed_out = false
	end
end
function ContextItem.idle(A0_29)
	local L1_30
	A0_29._wants_to_idle = true
	A0_29._wants_to_fade_out = false
	A0_29._wants_to_fade_in = false
end
function ContextItem.wants_to_fade_in(A0_31)
	local L1_32
	L1_32 = A0_31._wants_to_fade_in
	return L1_32
end
function ContextItem.wants_to_fade_out(A0_33)
	local L1_34
	L1_34 = A0_33._wants_to_fade_out
	return L1_34
end
function ContextItem.wants_to_idle(A0_35)
	local L1_36
	L1_36 = A0_35._wants_to_idle
	return L1_36
end
function ContextItem.moving_down(A0_37)
	return A0_37._move_down_interpolator ~= nil
end
function ContextItem.get_alpha(A0_38)
	local L1_39
	L1_39 = A0_38._alpha
	return L1_39
end
function ContextItem.set_alpha(A0_40, A1_41)
	A0_40._alpha = A1_41
	for 