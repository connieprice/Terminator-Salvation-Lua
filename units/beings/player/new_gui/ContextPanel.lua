require("units/beings/player/new_gui/HudPanel")
require("units/beings/player/new_gui/ContextItem")
require("units/beings/player/new_gui/HudUtility")
if not ContextPanel then
	ContextPanel = class(HudPanel)
end
ContextPanel.init = function(l_1_0, l_1_1, l_1_2)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	Localizer:load("data/strings/context_actions.xml")
	l_1_0._width = tweak_data.player.new_hud.context_panel.WIDTH
	l_1_0._height = tweak_data.player.new_hud.context_panel.HEIGHT
	l_1_0._x = l_1_0._parent_panel:width() / 2
	if HudUtility.is_split_screen() and l_1_0._parent_panel:height() <= 720 then
		l_1_0._y = l_1_0._parent_panel:height() / 2 + tweak_data.player.new_hud.context_panel.PANEL_COOP_OFFSET_Y
	else
		l_1_0._y = l_1_0._parent_panel:height() / 2 + tweak_data.player.new_hud.context_panel.PANEL_OFFSET_Y
	end
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "context_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.valign = "bottom"
	l_1_5.halign = "left"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:set_center, l_1_3
	l_1_5 = l_1_0._x
	l_1_3(l_1_4, l_1_5, l_1_0._y)
	l_1_0._context_items, l_1_3 = l_1_3, {}
	l_1_3 = l_1_0._context_items
	l_1_4 = ContextItem
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_4 = l_1_4(l_1_5, l_1_0._panel)
	l_1_3.action = l_1_4
	l_1_3 = l_1_0._context_items
	l_1_4 = ContextItem
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_4 = l_1_4(l_1_5, l_1_0._panel)
	l_1_3.cover = l_1_4
	l_1_3 = l_1_0._context_items
	l_1_4 = ContextItem
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_4 = l_1_4(l_1_5, l_1_0._panel)
	l_1_3.message = l_1_4
	l_1_0._context_list, l_1_3 = l_1_3, {}
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
end

ContextPanel.hide = function(l_2_0, l_2_1)
	l_2_0._context_items[l_2_1]:fade_out()
end

ContextPanel.instant_hide = function(l_3_0, l_3_1)
	l_3_0._context_items[l_3_1]:instant_hide()
end

ContextPanel.is_visible = function(l_4_0, l_4_1)
	local l_4_2, l_4_3 = l_4_0._context_items[l_4_1]:visible, l_4_0._context_items[l_4_1]
	return l_4_2(l_4_3)
end

ContextPanel.timed_out = function(l_5_0, l_5_1)
	local l_5_2, l_5_3 = l_5_0._context_items[l_5_1]:timed_out, l_5_0._context_items[l_5_1]
	return l_5_2(l_5_3)
end

ContextPanel.set_minimum_display_time = function(l_6_0, l_6_1, l_6_2, l_6_3)
	l_6_0._context_items[l_6_1]:set_minimum_display_time(l_6_2, l_6_3)
end

ContextPanel.display = function(l_7_0, l_7_1, l_7_2, ...)
	local l_7_4 = l_7_0._context_items[l_7_1]
	if l_7_0:is_displayed(l_7_4) then
		l_7_4:update_item(l_7_2, ...)
		if l_7_0:_get_first_free_display_index() == 1 and l_7_0._context_list[2] == l_7_4 then
			l_7_4:move_down()
			l_7_0._context_list[1] = l_7_4
			l_7_0._context_list[2] = nil
		end
	elseif l_7_0:_get_first_free_display_index() then
		if l_7_0:is_displayed(l_7_4) then
			Application:debug("displayed already displayed target", l_7_0:_get_first_free_display_index(), l_7_2)
			return 
		end
		l_7_0._context_list[l_7_0:_get_first_free_display_index()] = l_7_4
		l_7_0._context_list[l_7_0:_get_first_free_display_index()]:display(l_7_2, l_7_0:_get_first_free_display_index(), ...)
		l_7_0:use_high_frequency_update()
	end
	l_7_0:update_positions()
end

ContextPanel.is_displayed = function(l_8_0, l_8_1)
	if l_8_0._context_list[1] == l_8_1 or l_8_0._context_list[2] == l_8_1 then
		return true
	end
	return false
end

ContextPanel._get_first_free_display_index = function(l_9_0)
	if not l_9_0._context_list[1] then
		return 1
	else
		if not l_9_0._context_list[2] then
			return 2
		end
	else
		return nil
	end
end

ContextPanel.panel = function(l_10_0)
	return l_10_0._panel
end

ContextPanel.visible = function(l_11_0)
end

ContextPanel.active_context = function(l_12_0)
	return #l_12_0._context_list > 0
end

ContextPanel.update = function(l_13_0, l_13_1, l_13_2)
	local l_13_7, l_13_8, l_13_9, l_13_10, l_13_11, l_13_12, l_13_13, l_13_14, l_13_15, l_13_16, l_13_18, l_13_20, l_13_22 = nil
	local l_13_3 = false
	l_13_0:update_positions()
	for i_0,i_1 in pairs(l_13_0._context_list) do
		if not i_1:visible() and not i_1:wants_to_fade_in() then
			l_13_0._context_list[i_0] = nil
		end
		if i_1:wants_to_idle() then
			local l_13_23 = i_1:moving_down()
		if l_13_23 then
			end
		end
		l_13_3 = true
	end
	if l_13_3 then
		l_13_0:use_high_frequency_update()
	else
		l_13_0:use_low_frequency_update()
	end
	for i_0,l_13_23 in pairs(l_13_0._context_items) do
		do
			local l_13_17 = nil
			l_13_17(l_13_23, l_13_1, l_13_2)
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

		end
		l_13_0:set_alpha(l_13_17)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ContextPanel.set_alpha = function(l_14_0, l_14_1)
	HudPanel.set_alpha(l_14_0, l_14_1)
end

ContextPanel.update_positions = function(l_15_0)
	if l_15_0._context_list[1] == nil or l_15_0._context_list[2] == nil then
		return 
	end
	if l_15_0._context_list[1]._panel:y() == l_15_0._context_list[2]._panel:y() then
		l_15_0._context_list[2]:_set_position(2)
		l_15_0._context_list[2]._move_down_interpolator = nil
		l_15_0._context_list[1]:_set_position(1)
		l_15_0._context_list[1]._move_down_interpolator = nil
	end
end

ContextPanel.set_localizer_mapping = function(l_16_0, l_16_1)
	local l_16_5, l_16_6, l_16_7, l_16_8 = nil
	for i_0,i_1 in pairs(l_16_0._context_items) do
		i_1:set_localizer_mapping(l_16_1)
	end
end


