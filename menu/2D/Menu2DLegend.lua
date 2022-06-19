require("shared/MultiStateRequest")
if not Menu2DLegend then
	Menu2DLegend = class()
end
local l_0_0 = Menu2DLegend
local l_0_1 = {}
l_0_1.confirm = "menu_legend_confirm"
l_0_1.toggle = "menu_legend_toogle"
l_0_0.mode_texts = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._wants_visible_state = MultiStateRequest:new()
	l_1_0._safe_rect = l_1_3
	l_1_0._root_panel = l_1_1
	l_1_0:create_gui(l_1_2)
	l_1_0._confirm_active = false
	l_1_0._back_active = false
end

l_0_0.init = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_2_0, l_2_1)
	if alive(l_2_0._rootpanel) then
		l_2_0._root_panel:parent():remove(l_2_0._root_panel)
	end
	l_2_0._root_panel = l_2_1
	l_2_0:create_gui()
end

l_0_0.set_panel = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._safe_rect
	local l_3_3 = 3.1 * tweak_data.menu2d.legend_height
	local l_3_4, l_3_5 = l_3_0._root_panel:panel, l_3_0._root_panel
	local l_3_6 = {}
	l_3_6.x = l_3_2.x
	l_3_6.y = l_3_2.h + l_3_2.y - l_3_3
	l_3_6.w = 400
	l_3_6.h = l_3_3
	l_3_6.layer = tweak_data.menu2d.layer_legend
	l_3_4 = l_3_4(l_3_5, l_3_6)
	l_3_0._panel = l_3_4
	l_3_0._elements, l_3_4 = l_3_4, {}
	l_3_4 = tweak_data
	l_3_4 = l_3_4.menu2d
	l_3_4 = l_3_4.legend_height
	l_3_5 = l_3_0._panel
	l_3_5, l_3_6 = l_3_5:text, l_3_5
	local l_3_7 = {}
	l_3_7.x = 0
	l_3_7.y = 0
	l_3_7.h = l_3_4 * 2
	l_3_7.vertical = "center"
	l_3_7.font = "faith_font_22"
	l_3_7.text = managers.localization:text("menu_legend_back")
	l_3_5 = l_3_5(l_3_6, l_3_7)
	l_3_0._back = l_3_5
	l_3_5 = l_3_0._panel
	l_3_5, l_3_6 = l_3_5:text, l_3_5
	l_3_5, l_3_7 = l_3_5(l_3_6, l_3_7), {x = 0, y = l_3_0._back:y() + l_3_4 + tweak_data.menu2d.legend_height * 0.3, h = l_3_4 * 2, font = "faith_font_22", vertical = "center", text = managers.localization:text("menu_legend_confirm")}
	l_3_0._confirm = l_3_5
	l_3_5, l_3_6 = l_3_0:reset, l_3_0
	l_3_5(l_3_6)
	if not l_3_1 then
		l_3_5, l_3_6 = l_3_0:_hide, l_3_0
		l_3_5(l_3_6)
	end
end

l_0_0.create_gui = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_4_0)
	l_4_0._root_panel:remove(l_4_0._panel)
end

l_0_0.destroy = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_5_0)
	l_5_0:destroy()
	l_5_0:create_gui()
end

l_0_0.redo = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_6_0, l_6_1)
	l_6_0._confirm:set_text(managers.localization:text(l_6_1))
end

l_0_0._set_confirm_text = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_7_0, l_7_1)
end

l_0_0.set_dir_text = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_8_0, l_8_1)
	if l_8_1 ~= nil and l_8_1 ~= false then
		l_8_0:_set_confirm_text(Menu2DLegend.mode_texts[l_8_1])
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_8_0:_show_active(l_8_0._confirm, l_8_1 ~= nil and l_8_1 ~= false)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_8_0._confirm_active = l_8_1 ~= nil and l_8_1 ~= false
end

l_0_0._set_confirm_active = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_9_0, l_9_1)
	l_9_0:_show_active(l_9_0._back, l_9_1)
	l_9_0._back_active = l_9_1
end

l_0_0._set_back_active = l_0_1
l_0_0 = Menu2DLegend
l_0_0._VISIBLE_MODES, l_0_1 = l_0_1, {MENU = 1, DIALOG = 2}
l_0_0 = Menu2DLegend
l_0_1 = function(l_10_0)
	l_10_0._wants_visible_state:request(l_10_0._VISIBLE_MODES.MENU, true)
end

l_0_0.request_menu_show = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_11_0)
	l_11_0._wants_visible_state:request(l_11_0._VISIBLE_MODES.DIALOG, true)
end

l_0_0.request_dialog_show = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_12_0)
	l_12_0._wants_visible_state:request(l_12_0._VISIBLE_MODES.MENU, false)
end

l_0_0.request_menu_hide = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_13_0)
	l_13_0._wants_visible_state:request(l_13_0._VISIBLE_MODES.DIALOG, false)
end

l_0_0.request_dialog_hide = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_14_0)
	l_14_0._back:set_color(l_14_0._back:color():with_alpha(0))
	l_14_0._confirm:set_color(l_14_0._back:color():with_alpha(0))
	l_14_0._visible = false
end

l_0_0._hide = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_15_0)
	local l_15_1, l_15_2 = nil, nil
	if l_15_0._back_active then
		l_15_1 = tweak_data.menu2d.legend_alpha_active
	else
		l_15_1 = tweak_data.menu2d.legend_alpha_inactive
	end
	if l_15_0._confirm_active then
		l_15_2 = tweak_data.menu2d.legend_alpha_active
	else
		l_15_2 = tweak_data.menu2d.legend_alpha_inactive
	end
	l_15_0._back:set_color(l_15_0._back:color():with_alpha(l_15_1))
	l_15_0._confirm:set_color(l_15_0._confirm:color():with_alpha(l_15_2))
	l_15_0._visible = true
end

l_0_0._show = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_16_0)
	if l_16_0._visible then
		local l_16_1, l_16_2 = l_16_0:set_active, l_16_0
		local l_16_3 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		l_16_1(l_16_2, l_16_3, true)
		l_16_1(l_16_2, l_16_3)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

l_0_0.reset = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_17_0, l_17_1, l_17_2)
	if not l_17_0:active() then
		return 
	end
	if l_17_2 then
		l_17_1:set_color(l_17_0._confirm:color():with_alpha(tweak_data.menu2d.legend_alpha_active))
	else
		l_17_1:set_color(l_17_0._confirm:color():with_alpha(tweak_data.menu2d.legend_alpha_inactive))
	end
end

l_0_0._show_active = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_18_0)
	return l_18_0._visible
end

l_0_0.active = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_19_0)
	if l_19_0:active() and l_19_0._wants_visible_state:wants_disabled_state() then
		l_19_0:_hide()
	elseif not l_19_0._active and l_19_0._wants_visible_state:wants_enabled_state() then
		l_19_0:_show()
	end
	local l_19_1 = managers.menu2d:can_go_back()
	l_19_0:_set_back_active(l_19_1)
	local l_19_2 = managers.menu2d:confirm_mode()
	l_19_0:_set_confirm_active(l_19_2)
end

l_0_0.update = l_0_1
l_0_0 = Menu2DLegend
l_0_1 = function(l_20_0, l_20_1)
	local l_20_2 = l_20_1.mouse.cursor_position
	if l_20_1.mouse.select and (not Menu2DUtilities.is_position_over_gui_object(l_20_2, l_20_0._confirm)) or Menu2DUtilities.is_position_over_gui_object(l_20_2, l_20_0._back) then
		managers.menu2d:back()
	end
end

l_0_0.input = l_0_1

