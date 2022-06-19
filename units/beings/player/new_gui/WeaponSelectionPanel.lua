require("units/beings/player/new_gui/HudPanel")
require("units/beings/player/new_gui/WeaponSelectionIcon")
WeaponSelectionPanel = WeaponSelectionPanel or class(HudPanel)
function WeaponSelectionPanel.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4, L5_5, L6_6, L7_7, L8_8
	L4_4(L5_5, L6_6)
	A0_0._safe_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = L4_4
	A0_0._inventory = L4_4
	A0_0._width = L4_4
	A0_0._height = L4_4
	L6_6.name = "weapon_selection_panel"
	L7_7 = A0_0._width
	L6_6.width = L7_7
	L7_7 = A0_0._height
	L6_6.height = L7_7
	L6_6.valign = "center"
	L6_6.halign = "center"
	A0_0._panel = L4_4
	A0_0._weapon_selection_icons = L4_4
	for L7_7 = 1, 4 do
		L8_8 = nil
		if A0_0._inventory:item_by_index(L7_7) and A0_0._inventory:item_by_index(L7_7):hud() then
			L8_8 = A0_0._inventory:item_by_index(L7_7):hud():texture_name()
		else
			L8_8 = tweak_data.player.new_hud.weapon_selection_panel.DEFAULT_ICON
		end
		A0_0._weapon_selection_icons[L7_7] = WeaponSelectionIcon:new(A0_0._panel, L8_8, L7_7)
	end
	L7_7 = "hud_inventory_switch"
	A0_0._weapon_switch_sound = L4_4
	L7_7 = "hud_inventory_select"
	A0_0._weapon_select_sound = L4_4
	L4_4(L5_5, L6_6)
end
function WeaponSelectionPanel.panel(A0_9)
	local L1_10
	L1_10 = A0_9._panel
	return L1_10
end
function WeaponSelectionPanel.show(A0_11)
	A0_11._selected_icon = nil
	A0_11:reset_icon_positions()
	A0_11:update_weapon_icons()
	A0_11._weapon_select_sound_played = false
	A0_11:use_high_frequency_update()
end
function WeaponSelectionPanel.update_weapon_icons(A0_12)
	local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18
	for L4_16 = 1, 4 do
		L5_17 = nil
		L6_18 = A0_12._inventory
		L6_18 = L6_18.item_by_index
		L6_18 = L6_18(L6_18, L4_16)
		if alive(L6_18) then
			if L6_18:hud() then
				L5_17 = L6_18:hud():texture_name()
			else
				L5_17 = tweak_data.player.new_hud.weapon_selection_panel.DEFAULT_ICON
			end
			A0_12._weapon_selection_icons[L4_16]:set_weapon_icon(L5_17)
		else
			A0_12._weapon_selection_icons[L4_16]:set_weapon_icon("gui_inv_empty")
		end
	end
end
function WeaponSelectionPanel.reset_icon_positions(A0_19)
	local L1_20, L2_21, L3_22
	for _FORV_4_ = 1, 4 do
		A0_19._weapon_selection_icons[_FORV_4_]:reset_position()
	end
end
function WeaponSelectionPanel.hide(A0_23)
	for 