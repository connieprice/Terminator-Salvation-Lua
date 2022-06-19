require("shared/MultiStateRequest")
Menu2DLegend = Menu2DLegend or class()
Menu2DLegend.mode_texts = {
	confirm = "menu_legend_confirm",
	toggle = "menu_legend_toogle"
}
function Menu2DLegend.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._wants_visible_state = MultiStateRequest:new()
	A0_0._safe_rect = A3_3
	A0_0._root_panel = A1_1
	A0_0:create_gui(A2_2)
	A0_0._confirm_active = false
	A0_0._back_active = false
end
function Menu2DLegend.set_panel(A0_4, A1_5)
	if alive(A0_4._rootpanel) then
		A0_4._root_panel:parent():remove(A0_4._root_panel)
	end
	A0_4._root_panel = A1_5
	A0_4:create_gui()
end
function Menu2DLegend.create_gui(A0_6, A1_7)
	local L2_8, L3_9
	L2_8 = A0_6._safe_rect
	L3_9 = tweak_data
	L3_9 = L3_9.menu2d
	L3_9 = L3_9.legend_height
	L3_9 = 3.1 * L3_9
	A0_6._panel = A0_6._root_panel:panel({
		x = L2_8.x,
		y = L2_8.h + L2_8.y - L3_9,
		w = 400,
		h = L3_9,
		layer = tweak_data.menu2d.layer_legend
	})
	A0_6._elements = {}
	A0_6._back = A0_6._panel:text({
		x = 0,
		y = 0,
		h = tweak_data.menu2d.legend_height * 2,
		vertical = "center",
		font = "faith_font_22",
		text = managers.localization:text("menu_legend_back")
	})
	A0_6._confirm = A0_6._panel:text({
		x = 0,
		y = A0_6._back:y() + tweak_data.menu2d.legend_height + tweak_data.menu2d.legend_height * 0.3,
		h = tweak_data.menu2d.legend_height * 2,
		font = "faith_font_22",
		vertical = "center",
		text = managers.localization:text("menu_legend_confirm")
	})
	A0_6:reset()
	if not A1_7 then
		A0_6:_hide()
	end
end
function Menu2DLegend.destroy(A0_10)
	A0_10._root_panel:remove(A0_10._panel)
end
function Menu2DLegend.redo(A0_11)
	A0_11:destroy()
	A0_11:create_gui()
end
function Menu2DLegend._set_confirm_text(A0_12, A1_13)
	local L3_14
	L3_14 = A0_12._confirm
	L3_14 = L3_14.set_text
	L3_14(L3_14, managers.localization:text(A1_13))
end
function Menu2DLegend.set_dir_text(A0_15, A1_16)
end
function Menu2DLegend._set_confirm_active(A0_17, A1_18)
	local L2_19
	L2_19 = A1_18 ~= nil and A1_18 ~= false
	if L2_19 then
		A0_17:_set_confirm_text(Menu2DLegend.mode_texts[A1_18])
	end
	A0_17:_show_active(A0_17._confirm, L2_19)
	A0_17._confirm_active = L2_19
end
function Menu2DLegend._set_back_active(A0_20, A1_21)
	A0_20:_show_active(A0_20._back, A1_21)
	A0_20._back_active = A1_21
end
Menu2DLegend._VISIBLE_MODES = {MENU = 1, DIALOG = 2}
function Menu2DLegend.request_menu_show(A0_22)
	A0_22._wants_visible_state:request(A0_22._VISIBLE_MODES.MENU, true)
end
function Menu2DLegend.request_dialog_show(A0_23)
	A0_23._wants_visible_state:request(A0_23._VISIBLE_MODES.DIALOG, true)
end
function Menu2DLegend.request_menu_hide(A0_24)
	A0_24._wants_visible_state:request(A0_24._VISIBLE_MODES.MENU, false)
end
function Menu2DLegend.request_dialog_hide(A0_25)
	A0_25._wants_visible_state:request(A0_25._VISIBLE_MODES.DIALOG, false)
end
function Menu2DLegend._hide(A0_26)
	local L1_27, L2_28
	L1_27 = A0_26._back
	L2_28 = L1_27
	L1_27 = L1_27.set_color
	L1_27(L2_28, A0_26._back:color():with_alpha(0))
	L1_27 = A0_26._confirm
	L2_28 = L1_27
	L1_27 = L1_27.set_color
	L1_27(L2_28, A0_26._back:color():with_alpha(0))
	A0_26._visible = false
end
function Menu2DLegend._show(A0_29)
	local L1_30, L2_31, L3_32, L4_33
	L3_32 = A0_29._back_active
	if L3_32 then
		L3_32 = tweak_data
		L3_32 = L3_32.menu2d
		L1_30 = L3_32.legend_alpha_active
	else
		L3_32 = tweak_data
		L3_32 = L3_32.menu2d
		L1_30 = L3_32.legend_alpha_inactive
	end
	L3_32 = A0_29._confirm_active
	if L3_32 then
		L3_32 = tweak_data
		L3_32 = L3_32.menu2d
		L2_31 = L3_32.legend_alpha_active
	else
		L3_32 = tweak_data
		L3_32 = L3_32.menu2d
		L2_31 = L3_32.legend_alpha_inactive
	end
	L3_32 = A0_29._back
	L4_33 = L3_32
	L3_32 = L3_32.set_color
	L3_32(L4_33, A0_29._back:color():with_alpha(L1_30))
	L3_32 = A0_29._confirm
	L4_33 = L3_32
	L3_32 = L3_32.set_color
	L3_32(L4_33, A0_29._confirm:color():with_alpha(L2_31))
	A0_29._visible = true
end
function Menu2DLegend.reset(A0_34)
	if A0_34._visible then
		A0_34:set_active({"back", "confirm"}, true)
		A0_34:set_confirm_text("menu_legend_confirm")
	end
end
function Menu2DLegend._show_active(A0_35, A1_36, A2_37)
	if not A0_35:active() then
		return
	end
	if A2_37 then
		A1_36:set_color(A0_35._confirm:color():with_alpha(tweak_data.menu2d.legend_alpha_active))
	else
		A1_36:set_color(A0_35._confirm:color():with_alpha(tweak_data.menu2d.legend_alpha_inactive))
	end
end
function Menu2DLegend.active(A0_38)
	local L1_39
	L1_39 = A0_38._visible
	return L1_39
end
function Menu2DLegend.update(A0_40)
	local L1_41, L2_42
	L2_42 = A0_40
	L1_41 = A0_40.active
	L1_41 = L1_41(L2_42)
	if L1_41 then
		L1_41 = A0_40._wants_visible_state
		L2_42 = L1_41
		L1_41 = L1_41.wants_disabled_state
		L1_41 = L1_41(L2_42)
		if L1_41 then
			L2_42 = A0_40
			L1_41 = A0_40._hide
			L1_41(L2_42)
		end
	else
		L1_41 = A0_40._active
		if not L1_41 then
			L1_41 = A0_40._wants_visible_state
			L2_42 = L1_41
			L1_41 = L1_41.wants_enabled_state
			L1_41 = L1_41(L2_42)
			if L1_41 then
				L2_42 = A0_40
				L1_41 = A0_40._show
				L1_41(L2_42)
			end
		end
	end
	L1_41 = managers
	L1_41 = L1_41.menu2d
	L2_42 = L1_41
	L1_41 = L1_41.can_go_back
	L1_41 = L1_41(L2_42)
	L2_42 = A0_40._set_back_active
	L2_42(A0_40, L1_41)
	L2_42 = managers
	L2_42 = L2_42.menu2d
	L2_42 = L2_42.confirm_mode
	L2_42 = L2_42(L2_42)
	A0_40:_set_confirm_active(L2_42)
end
function Menu2DLegend.input(A0_43, A1_44)
	local L2_45
	L2_45 = A1_44.mouse
	L2_45 = L2_45.cursor_position
	if A1_44.mouse.select then
		if Menu2DUtilities.is_position_over_gui_object(L2_45, A0_43._confirm) then
		end
		if Menu2DUtilities.is_position_over_gui_object(L2_45, A0_43._back) then
			managers.menu2d:back()
		end
	end
end
