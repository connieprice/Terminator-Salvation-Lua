require("units/beings/player/new_gui/HudPanel")
require("units/beings/player/new_gui/ContextItem")
require("units/beings/player/new_gui/HudUtility")
ContextPanel = ContextPanel or class(HudPanel)
function ContextPanel.init(A0_0, A1_1, A2_2)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	Localizer:load("data/strings/context_actions.xml")
	A0_0._width = tweak_data.player.new_hud.context_panel.WIDTH
	A0_0._height = tweak_data.player.new_hud.context_panel.HEIGHT
	A0_0._x = A0_0._parent_panel:width() / 2
	if HudUtility.is_split_screen() and A0_0._parent_panel:height() <= 720 then
		A0_0._y = A0_0._parent_panel:height() / 2 + tweak_data.player.new_hud.context_panel.PANEL_COOP_OFFSET_Y
	else
		A0_0._y = A0_0._parent_panel:height() / 2 + tweak_data.player.new_hud.context_panel.PANEL_OFFSET_Y
	end
	A0_0._panel = A0_0._parent_panel:panel({
		name = "context_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "bottom",
		halign = "left"
	})
	A0_0._panel:set_center(A0_0._x, A0_0._y)
	A0_0._context_items = {}
	A0_0._context_items.action = ContextItem:new(A0_0._panel)
	A0_0._context_items.cover = ContextItem:new(A0_0._panel)
	A0_0._context_items.message = ContextItem:new(A0_0._panel)
	A0_0._context_list = {}
	A0_0:set_alpha(0)
end
function ContextPanel.hide(A0_3, A1_4)
	A0_3._context_items[A1_4]:fade_out()
end
function ContextPanel.instant_hide(A0_5, A1_6)
	A0_5._context_items[A1_6]:instant_hide()
end
function ContextPanel.is_visible(A0_7, A1_8)
	return A0_7._context_items[A1_8]:visible()
end
function ContextPanel.timed_out(A0_9, A1_10)
	return A0_9._context_items[A1_10]:timed_out()
end
function ContextPanel.set_minimum_display_time(A0_11, A1_12, A2_13, A3_14)
	A0_11._context_items[A1_12]:set_minimum_display_time(A2_13, A3_14)
end
function ContextPanel.display(A0_15, A1_16, A2_17, ...)
	local L4_19, L5_20
	L4_19 = A0_15._context_items
	L4_19 = L4_19[A1_16]
	L5_20 = A0_15._get_first_free_display_index
	L5_20 = L5_20(A0_15)
	if A0_15:is_displayed(L4_19) then
		L4_19:update_item(A2_17, ...)
		if L5_20 == 1 and A0_15._context_list[2] == L4_19 then
			L4_19:move_down()
			A0_15._context_list[1] = L4_19
			A0_15._context_list[2] = nil
		end
	elseif L5_20 then
		if A0_15:is_displayed(L4_19) then
			Application:debug("displayed already displayed target", L5_20, A2_17)
			return
		end
		A0_15._context_list[L5_20] = L4_19
		A0_15._context_list[L5_20]:display(A2_17, L5_20, ...)
		A0_15:use_high_frequency_update()
	end
	A0_15:update_positions()
end
function ContextPanel.is_displayed(A0_21, A1_22)
	local L2_23
	L2_23 = A0_21._context_list
	L2_23 = L2_23[1]
	if L2_23 ~= A1_22 then
		L2_23 = A0_21._context_list
		L2_23 = L2_23[2]
	elseif L2_23 == A1_22 then
		L2_23 = true
		return L2_23
	end
	L2_23 = false
	return L2_23
end
function ContextPanel._get_first_free_display_index(A0_24)
	local L1_25
	L1_25 = A0_24._context_list
	L1_25 = L1_25[1]
	if not L1_25 then
		L1_25 = 1
		return L1_25
	else
		L1_25 = A0_24._context_list
		L1_25 = L1_25[2]
		if not L1_25 then
			L1_25 = 2
			return L1_25
		else
			L1_25 = nil
			return L1_25
		end
	end
end
function ContextPanel.panel(A0_26)
	local L1_27
	L1_27 = A0_26._panel
	return L1_27
end
function ContextPanel.visible(A0_28)
	local L1_29
end
function ContextPanel.active_context(A0_30)
	local L1_31
	L1_31 = A0_30._context_list
	L1_31 = #L1_31
	L1_31 = L1_31 > 0
	return L1_31
end
function ContextPanel.update(A0_32, A1_33, A2_34)
	local L3_35, L4_36
	L3_35 = false
	L4_36(A0_32)
	for 