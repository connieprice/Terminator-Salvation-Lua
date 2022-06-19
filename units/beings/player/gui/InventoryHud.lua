if not InventoryHud then
	InventoryHud = class()
end
InventoryHud.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._player_unit = l_1_1
	l_1_0._inventory = l_1_0._player_unit:base():inventory()
	l_1_0._safe_panel = l_1_2
	l_1_0._player_data = l_1_1:player_data()
	l_1_0._inventory_icons = l_1_3
	local l_1_4, l_1_5 = l_1_0._safe_panel:panel, l_1_0._safe_panel
	local l_1_6 = {}
	l_1_6.name = "inventory_panel"
	l_1_6.valign = "grow"
	l_1_6.halign = "grow"
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._panel = l_1_4
	l_1_4 = 170
	l_1_5 = 110
	local l_1_7 = {}
	l_1_7.x = l_1_4
	l_1_7.y = 0
	l_1_7 = {x = 0, y = l_1_5}
	l_1_7 = {x = -l_1_4, y = 0}
	l_1_7 = {x = 0, y = -l_1_5}
	l_1_0._icons, l_1_6 = l_1_6, {[1] = l_1_7, [2] = l_1_7, [3] = l_1_7, [4] = l_1_7}
	l_1_6 = Interpolator
	l_1_6, l_1_7 = l_1_6:new, l_1_6
	l_1_6 = l_1_6(l_1_7, 0, tweak_data.player.hud.INVENTORY_FADE_SPEED)
	l_1_0._alpha_interpolator = l_1_6
	l_1_0._stay_visible_time = 0
	l_1_6 = l_1_0._panel
	l_1_6, l_1_7 = l_1_6:bitmap, l_1_6
	local l_1_8 = {}
	l_1_8.layer = 0
	l_1_8.name = "inventory_center"
	l_1_8.texture = "gui_inv_arrow_dummy"
	l_1_6 = l_1_6(l_1_7, l_1_8)
	l_1_0._centered_image = l_1_6
	l_1_6 = l_1_0._centered_image
	l_1_6, l_1_7 = l_1_6:set_center_x, l_1_6
	l_1_8 = l_1_0._panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_7, l_1_8)
	l_1_6 = l_1_0._centered_image
	l_1_6, l_1_7 = l_1_6:set_center_y, l_1_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_7, l_1_8)
end

InventoryHud.destroy = function(l_2_0)
	if l_2_0._panel then
		l_2_0._panel:clear()
	end
	l_2_0._panel = nil
end

InventoryHud.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._player_data.hud_inventory_show
	local l_3_3 = l_3_0._player_data.hud_inventory_selection_slot
	local l_3_4 = l_3_0._player_data.hud_inventory_primary_active_slot
	local l_3_5 = l_3_0._player_data.hud_inventory_secondary_active_slot
	l_3_0:_update_stay_visible_time(l_3_1, l_3_2)
	l_3_0:_update_alpha_fade(l_3_1)
	l_3_0:_create_destroy_bitmaps()
	l_3_0:_set_bitmap_alpha_and_visibility(l_3_0._alpha_interpolator:value(), l_3_3, l_3_4, l_3_5)
end

InventoryHud._update_stay_visible_time = function(l_4_0, l_4_1, l_4_2)
	if l_4_2 then
		l_4_0._stay_visible_time = tweak_data.player.hud.INVENTORY_FADE_OUT_TIME
	end
	l_4_0._stay_visible_time = l_4_0._stay_visible_time - l_4_1
end

InventoryHud._update_alpha_fade = function(l_5_0, l_5_1)
	if l_5_0._stay_visible_time > 0 then
		l_5_0._alpha_interpolator:set_target(1)
	else
		l_5_0._alpha_interpolator:set_target(0)
	end
	l_5_0._alpha_interpolator:update(l_5_1)
end

InventoryHud._create_destroy_bitmaps = function(l_6_0, l_6_1)
	for l_6_5 = 1, 4 do
		local l_6_6 = l_6_0._inventory:item_by_index(l_6_5)
		if l_6_0._icons[l_6_5].bitmap then
			local l_6_7, l_6_9, l_6_11, l_6_13, l_6_15, l_6_16, l_6_18, l_6_20, l_6_22 = l_6_0._icons[l_6_5].texture_name
		end
		do
			local l_6_8, l_6_10, l_6_12, l_6_14, l_6_17, l_6_19, l_6_21, l_6_23 = , l_6_6 and l_6_0._inventory_icons[l_6_6:name()] or "gui_inv_empty"
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_6_8 and l_6_10 and l_6_8 ~= l_6_10 then
			l_6_0:_destroy_bitmap_in_slot(l_6_5)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_6_0:_create_bitmap_in_slot(l_6_5, l_6_10)
		end
		do return end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_6_8 then
			l_6_0:_destroy_bitmap_in_slot(l_6_5)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif l_6_10 then
			l_6_0:_create_bitmap_in_slot(l_6_5, l_6_10)
		end
	end
end

InventoryHud._create_bitmap_in_slot = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_0._icons[l_7_1]
	local l_7_4, l_7_5 = l_7_0._panel:bitmap, l_7_0._panel
	local l_7_6 = {}
	l_7_6.layer = 0
	l_7_6.name = "inventory_weapon_icon"
	l_7_6.texture = l_7_2
	l_7_4 = l_7_4(l_7_5, l_7_6)
	l_7_3.bitmap = l_7_4
	l_7_3 = l_7_0._icons
	l_7_3 = l_7_3[l_7_1]
	l_7_3.texture_name = l_7_2
	l_7_3 = l_7_0._icons
	l_7_3 = l_7_3[l_7_1]
	l_7_3 = l_7_3.bitmap
	l_7_3, l_7_4 = l_7_3:set_color, l_7_3
	l_7_5 = l_7_0._icons
	l_7_5 = l_7_5[l_7_1]
	l_7_5 = l_7_5.bitmap
	l_7_5, l_7_6 = l_7_5:color, l_7_5
	l_7_5 = l_7_5(l_7_6)
	l_7_5, l_7_6 = l_7_5:with_alpha, l_7_5
	l_7_6, l_7_5 = .end, l_7_5(l_7_6, 0)
	l_7_3(l_7_4, l_7_5, l_7_6)
	l_7_3 = l_7_0._icons
	l_7_3 = l_7_3[l_7_1]
	l_7_3 = l_7_3.bitmap
	l_7_3, l_7_4 = l_7_3:set_center_x, l_7_3
	l_7_5 = l_7_0._panel
	l_7_5, l_7_6 = l_7_5:center_x, l_7_5
	l_7_5 = l_7_5(l_7_6)
	l_7_6 = l_7_0._icons
	l_7_6 = l_7_6[l_7_1]
	l_7_6 = l_7_6.x
	l_7_5 = l_7_5 + l_7_6
	l_7_3(l_7_4, l_7_5)
	l_7_3 = l_7_0._icons
	l_7_3 = l_7_3[l_7_1]
	l_7_3 = l_7_3.bitmap
	l_7_3, l_7_4 = l_7_3:set_center_y, l_7_3
	l_7_5 = l_7_0._panel
	l_7_5, l_7_6 = l_7_5:center_y, l_7_5
	l_7_5 = l_7_5(l_7_6)
	l_7_6 = l_7_0._icons
	l_7_6 = l_7_6[l_7_1]
	l_7_6 = l_7_6.y
	l_7_5 = l_7_5 + l_7_6
	l_7_3(l_7_4, l_7_5)
	l_7_3 = l_7_0._icons
	l_7_3 = l_7_3[l_7_1]
	l_7_3 = l_7_3.bitmap
	l_7_3, l_7_4 = l_7_3:set_valign, l_7_3
	l_7_5 = "center"
	l_7_3(l_7_4, l_7_5)
	l_7_3 = l_7_0._icons
	l_7_3 = l_7_3[l_7_1]
	l_7_3 = l_7_3.bitmap
	l_7_3, l_7_4 = l_7_3:set_halign, l_7_3
	l_7_5 = "center"
	l_7_3(l_7_4, l_7_5)
	l_7_3 = l_7_0._icons
	l_7_3 = l_7_3[l_7_1]
	l_7_3 = l_7_3.bitmap
	l_7_3, l_7_4 = l_7_3:hide, l_7_3
	l_7_3(l_7_4)
end

InventoryHud._destroy_bitmap_in_slot = function(l_8_0, l_8_1)
	l_8_0._panel:remove(l_8_0._icons[l_8_1].bitmap)
	l_8_0._icons[l_8_1].bitmap = nil
	l_8_0._icons[l_8_1].weapon = nil
end

InventoryHud._set_bitmap_alpha_and_visibility = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4)
	l_9_0._centered_image:set_color(l_9_0._centered_image:color():with_alpha(l_9_1))
	for l_9_8 = 1, 4 do
		if l_9_0._icons[l_9_8] then
			local l_9_9, l_9_10, l_9_11, l_9_14, l_9_15 = l_9_0._icons[l_9_8].bitmap
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_9_9 then
			if l_9_1 > 0 then
				l_9_9:show()
				local l_9_12, l_9_13 = , nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_9_8 == l_9_3 then
					do return end
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_9_8 == l_9_4 then
					do return end
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_9_8 == l_9_2 then
					do return end
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_9_12:set_color(nil:with_alpha(l_9_13))
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			l_9_13(l_9_12)
		end
	end
end


