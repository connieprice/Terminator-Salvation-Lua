InventoryHud = InventoryHud or class()
function InventoryHud.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._player_unit = A1_1
	A0_0._inventory = A0_0._player_unit:base():inventory()
	A0_0._safe_panel = A2_2
	A0_0._player_data = A1_1:player_data()
	A0_0._inventory_icons = A3_3
	A0_0._panel = A0_0._safe_panel:panel({
		name = "inventory_panel",
		valign = "grow",
		halign = "grow"
	})
	A0_0._icons = {
		[1] = {x = 170, y = 0},
		[2] = {x = 0, y = 110},
		[3] = {
			x = -170,
			y = 0
		},
		[4] = {
			x = 0,
			y = -110
		}
	}
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.hud.INVENTORY_FADE_SPEED)
	A0_0._stay_visible_time = 0
	A0_0._centered_image = A0_0._panel:bitmap({
		layer = 0,
		name = "inventory_center",
		texture = "gui_inv_arrow_dummy"
	})
	A0_0._centered_image:set_center_x(A0_0._panel:center_x())
	A0_0._centered_image:set_center_y(A0_0._panel:center_y())
end
function InventoryHud.destroy(A0_4)
	if A0_4._panel then
		A0_4._panel:clear()
	end
	A0_4._panel = nil
end
function InventoryHud.update(A0_5, A1_6)
	local L2_7, L3_8, L4_9, L5_10
	L2_7 = A0_5._player_data
	L2_7 = L2_7.hud_inventory_show
	L3_8 = A0_5._player_data
	L3_8 = L3_8.hud_inventory_selection_slot
	L4_9 = A0_5._player_data
	L4_9 = L4_9.hud_inventory_primary_active_slot
	L5_10 = A0_5._player_data
	L5_10 = L5_10.hud_inventory_secondary_active_slot
	A0_5:_update_stay_visible_time(A1_6, L2_7)
	A0_5:_update_alpha_fade(A1_6)
	A0_5:_create_destroy_bitmaps()
	A0_5:_set_bitmap_alpha_and_visibility(A0_5._alpha_interpolator:value(), L3_8, L4_9, L5_10)
end
function InventoryHud._update_stay_visible_time(A0_11, A1_12, A2_13)
	local L3_14
	if A2_13 then
		L3_14 = tweak_data
		L3_14 = L3_14.player
		L3_14 = L3_14.hud
		L3_14 = L3_14.INVENTORY_FADE_OUT_TIME
		A0_11._stay_visible_time = L3_14
	end
	L3_14 = A0_11._stay_visible_time
	L3_14 = L3_14 - A1_12
	A0_11._stay_visible_time = L3_14
end
function InventoryHud._update_alpha_fade(A0_15, A1_16)
	if A0_15._stay_visible_time > 0 then
		A0_15._alpha_interpolator:set_target(1)
	else
		A0_15._alpha_interpolator:set_target(0)
	end
	A0_15._alpha_interpolator:update(A1_16)
end
function InventoryHud._create_destroy_bitmaps(A0_17, A1_18)
	local L2_19, L3_20, L4_21, L5_22, L6_23, L7_24, L8_25
	for L5_22 = 1, 4 do
		L6_23 = A0_17._inventory
		L7_24 = L6_23
		L6_23 = L6_23.item_by_index
		L8_25 = L5_22
		L6_23 = L6_23(L7_24, L8_25)
		L7_24 = A0_17._icons
		L7_24 = L7_24[L5_22]
		L7_24 = L7_24.bitmap
		if L7_24 then
			L7_24 = A0_17._icons
			L7_24 = L7_24[L5_22]
			L7_24 = L7_24.texture_name
		end
		if L6_23 then
			L8_25 = A0_17._inventory_icons
			L8_25 = L8_25[L6_23:name()]
		else
			L8_25 = L8_25 or "gui_inv_empty"
		end
		if L7_24 and L8_25 then
			if L7_24 ~= L8_25 then
				A0_17:_destroy_bitmap_in_slot(L5_22)
				A0_17:_create_bitmap_in_slot(L5_22, L8_25)
			end
		elseif L7_24 then
			A0_17:_destroy_bitmap_in_slot(L5_22)
		elseif L8_25 then
			A0_17:_create_bitmap_in_slot(L5_22, L8_25)
		end
	end
end
function InventoryHud._create_bitmap_in_slot(A0_26, A1_27, A2_28)
	A0_26._icons[A1_27].bitmap = A0_26._panel:bitmap({
		layer = 0,
		name = "inventory_weapon_icon",
		texture = A2_28
	})
	A0_26._icons[A1_27].texture_name = A2_28
	A0_26._icons[A1_27].bitmap:set_color(A0_26._icons[A1_27].bitmap:color():with_alpha(0))
	A0_26._icons[A1_27].bitmap:set_center_x(A0_26._panel:center_x() + A0_26._icons[A1_27].x)
	A0_26._icons[A1_27].bitmap:set_center_y(A0_26._panel:center_y() + A0_26._icons[A1_27].y)
	A0_26._icons[A1_27].bitmap:set_valign("center")
	A0_26._icons[A1_27].bitmap:set_halign("center")
	A0_26._icons[A1_27].bitmap:hide()
end
function InventoryHud._destroy_bitmap_in_slot(A0_29, A1_30)
	A0_29._panel:remove(A0_29._icons[A1_30].bitmap)
	A0_29._icons[A1_30].bitmap = nil
	A0_29._icons[A1_30].weapon = nil
end
function InventoryHud._set_bitmap_alpha_and_visibility(A0_31, A1_32, A2_33, A3_34, A4_35)
	local L5_36, L6_37, L7_38, L8_39, L9_40, L10_41, L11_42
	L8_39 = L7_38
	L8_39 = L7_38
	L9_40 = A1_32
	L11_42 = L7_38(L8_39, L9_40)
	L5_36(L6_37, L7_38, L8_39, L9_40, L10_41, L11_42, L7_38(L8_39, L9_40))
	for L8_39 = 1, 4 do
		L9_40 = A0_31._icons
		L9_40 = L9_40[L8_39]
		if L9_40 then
			L9_40 = A0_31._icons
			L9_40 = L9_40[L8_39]
			L9_40 = L9_40.bitmap
		end
		if L9_40 then
			if A1_32 > 0 then
				L11_42 = L9_40
				L10_41 = L9_40.show
				L10_41(L11_42)
				L10_41, L11_42 = nil, nil
				if L8_39 == A3_34 then
					L11_42 = Color(0, 1, 0)
				elseif L8_39 == A4_35 then
					L11_42 = Color(1, 0, 0)
				else
					L11_42 = Color(1, 1, 1)
				end
				if L8_39 == A2_33 then
					L10_41 = A1_32
				else
					L10_41 = 0.5 * A1_32
				end
				L9_40:set_color(L11_42:with_alpha(L10_41))
			else
				L11_42 = L9_40
				L10_41 = L9_40.hide
				L10_41(L11_42)
			end
		end
	end
end
