require("units/beings/player/new_gui/HudPanel")
require("units/beings/player/new_gui/WeaponSelectionIcon")
if not WeaponSelectionPanel then
	WeaponSelectionPanel = class(HudPanel)
end
WeaponSelectionPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	HudPanel.init(l_1_0, false)
	l_1_0._safe_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._inventory = l_1_0._player_unit:base():inventory()
	l_1_0._width = l_1_0._safe_panel:width()
	l_1_0._height = l_1_0._safe_panel:height()
	local l_1_4, l_1_5 = l_1_0._safe_panel:panel, l_1_0._safe_panel
	local l_1_6 = {}
	l_1_6.name = "weapon_selection_panel"
	l_1_6.width = l_1_0._width
	l_1_6.height = l_1_0._height
	l_1_6.valign = "center"
	l_1_6.halign = "center"
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._panel = l_1_4
	l_1_0._weapon_selection_icons, l_1_4 = l_1_4, {}
	l_1_4 = 1
	l_1_5 = 4
	l_1_6 = 1
	for i = l_1_4, l_1_5, l_1_6 do
		local l_1_8 = nil
		local l_1_9 = l_1_0._inventory:item_by_index(l_1_7)
		if l_1_9 and l_1_9:hud() then
			l_1_8 = l_1_9:hud():texture_name()
		else
			l_1_8 = tweak_data.player.new_hud.weapon_selection_panel.DEFAULT_ICON
		end
		l_1_0._weapon_selection_icons[l_1_7] = WeaponSelectionIcon:new(l_1_0._panel, l_1_8, l_1_7)
	end
	l_1_0._weapon_switch_sound = Sound:make_bank("ui_menu_sound", "hud_inventory_switch")
	l_1_0._weapon_select_sound = Sound:make_bank("ui_menu_sound", "hud_inventory_select")
	l_1_0:set_alpha(0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WeaponSelectionPanel.panel = function(l_2_0)
	return l_2_0._panel
end

WeaponSelectionPanel.show = function(l_3_0)
	l_3_0._selected_icon = nil
	l_3_0:reset_icon_positions()
	l_3_0:update_weapon_icons()
	local l_3_1 = l_3_0._player_data.hud_inventory_primary_active_slot
	l_3_0._weapon_select_sound_played = false
	l_3_0:use_high_frequency_update()
end

WeaponSelectionPanel.update_weapon_icons = function(l_4_0)
	for l_4_4 = 1, 4 do
		local l_4_5 = nil
		local l_4_6 = l_4_0._inventory:item_by_index(l_4_4)
		if alive(l_4_6) then
			local l_4_7 = l_4_6:hud()
			if l_4_7 then
				l_4_5 = l_4_7:texture_name()
			else
				l_4_5 = tweak_data.player.new_hud.weapon_selection_panel.DEFAULT_ICON
			end
			l_4_0._weapon_selection_icons[l_4_4]:set_weapon_icon(l_4_5)
		else
			l_4_0._weapon_selection_icons[l_4_4]:set_weapon_icon("gui_inv_empty")
		end
	end
end

WeaponSelectionPanel.reset_icon_positions = function(l_5_0)
	for l_5_4 = 1, 4 do
		l_5_0._weapon_selection_icons[l_5_4]:reset_position()
	end
end

WeaponSelectionPanel.hide = function(l_6_0)
	local l_6_4, l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12, l_6_13, l_6_14 = nil
	for i_0,i_1 in pairs(l_6_0._weapon_selection_icons) do
		if i_0 == l_6_0._selected_icon then
			i_1:blink()
			if not l_6_0._weapon_select_sound_played then
				l_6_0._weapon_select_sound:play()
				l_6_0._weapon_select_sound_played = true
			end
		else
			i_1:hide()
		end
	end
end

WeaponSelectionPanel.visible = function(l_7_0)
	local l_7_4, l_7_5, l_7_6, l_7_7 = nil
	for i_0,i_1 in pairs(l_7_0._weapon_selection_icons) do
		if i_1:get_alpha() > 0 or i_1:wants_to_blink() then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WeaponSelectionPanel.set_selected_icon = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8 = nil
	if l_8_0._selected_icon ~= l_8_1 then
		l_8_0._weapon_switch_sound:play()
	end
	l_8_0._selected_icon = l_8_1
	for i_0,i_1 in pairs(l_8_0._weapon_selection_icons) do
		i_1:unselect()
	end
	if l_8_0._selected_icon then
		l_8_0._weapon_selection_icons[l_8_0._selected_icon]:select()
	if l_8_0._default_selected_icon_index then
		end
		l_8_0._weapon_selection_icons[l_8_0._default_selected_icon_index]:clear_default_select()
		l_8_0._default_selected_icon_index = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

WeaponSelectionPanel.set_default_selected_icon = function(l_9_0, l_9_1)
	if l_9_1 then
		l_9_0._default_selected_icon_index = l_9_1
		l_9_0._weapon_selection_icons[l_9_1]:default_select()
	end
end

WeaponSelectionPanel.update = function(l_10_0, l_10_1, l_10_2)
	local l_10_8, l_10_9, l_10_10, l_10_11, l_10_12, l_10_13 = nil
	local l_10_3 = l_10_0._player_data.hud_inventory_selection_slot
	if l_10_2 then
		l_10_0:set_selected_icon(l_10_3)
	end
	local l_10_4 = 0
	for i_0,i_1 in pairs(l_10_0._weapon_selection_icons) do
		i_1:update(l_10_1)
		l_10_4 = math.max(l_10_4, i_1:get_alpha())
	end
	l_10_0:set_alpha(l_10_4)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WeaponSelectionPanel.set_alpha = function(l_11_0, l_11_1)
	HudPanel.set_alpha(l_11_0, l_11_1)
end


