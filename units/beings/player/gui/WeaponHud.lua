if not WeaponHud then
	WeaponHud = class()
end
WeaponHud.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._player_unit = l_1_1
	l_1_0._safe_panel = l_1_2
	local l_1_3 = tweak_data.player.weapon_hud
	local l_1_4, l_1_5 = l_1_0._safe_panel:panel, l_1_0._safe_panel
	local l_1_6 = {}
	l_1_6.name = "weapon_panel"
	l_1_6.valign = "top"
	l_1_6.halign = "right"
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._weapon_panel = l_1_4
	l_1_4 = l_1_0._weapon_panel
	l_1_4, l_1_5 = l_1_4:set_size, l_1_4
	l_1_6 = 281
	l_1_4(l_1_5, l_1_6, 54)
	l_1_4 = l_1_0._weapon_panel
	l_1_4, l_1_5 = l_1_4:set_righttop, l_1_4
	l_1_6 = l_1_0._safe_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4(l_1_5, l_1_6, 0)
	l_1_4 = Interpolator
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4 = l_1_4(l_1_5, l_1_6, l_1_3.FADE_SPEED)
	l_1_0._alpha_interpolator = l_1_4
	l_1_4 = l_1_0._weapon_panel
	l_1_4, l_1_5 = l_1_4:text, l_1_4
	l_1_4, l_1_6 = l_1_4(l_1_5, l_1_6), {layer = 1, font = l_1_3.AMMO_POOL_TEXT_FONT, font_size = l_1_3.AMMO_POOL_TEXT_FONT_SIZE, color = l_1_3.AMMO_POOL_TEXT_COLOR, align = "left", width = 50, height = l_1_3.AMMO_POOL_TEXT_FONT_SIZE}
	l_1_0._ammo_pool_text = l_1_4
	l_1_4 = l_1_0._ammo_pool_text
	l_1_4, l_1_5 = l_1_4:set_left, l_1_4
	l_1_6 = l_1_3.AMMO_POOL_TEXT_XOFFSET
	l_1_4(l_1_5, l_1_6)
	l_1_4 = l_1_0._ammo_pool_text
	l_1_4, l_1_5 = l_1_4:set_bottom, l_1_4
	l_1_6 = l_1_0._weapon_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4(l_1_5, l_1_6)
	l_1_4 = l_1_0._ammo_pool_text
	l_1_4, l_1_5 = l_1_4:set_color, l_1_4
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4(l_1_5, l_1_6)
	l_1_0._stay_visible_time = 0
	l_1_4 = l_1_0._weapon_panel
	l_1_4, l_1_5 = l_1_4:bitmap, l_1_4
	l_1_4, l_1_6 = l_1_4(l_1_5, l_1_6), {layer = 0, name = "weapon_background", texture = "gui_bullet_bg"}
	l_1_0._background = l_1_4
	l_1_4 = l_1_0._background
	l_1_4, l_1_5 = l_1_4:set_texture_rect, l_1_4
	l_1_6 = 115
	l_1_4(l_1_5, l_1_6, 37, 512, 128)
	l_1_4 = l_1_0._background
	l_1_4, l_1_5 = l_1_4:set_blend_mode, l_1_4
	l_1_6 = "normal"
	l_1_4(l_1_5, l_1_6)
end

WeaponHud.update = function(l_2_0, l_2_1)
	local l_2_2 = l_2_0._player_unit:base():weapon_type()
	local l_2_3 = l_2_0._player_unit:base():weapon_data()
	local l_2_4 = l_2_0._player_unit:player_data()
	local l_2_5 = tweak_data.player.weapon_hud
	assert(l_2_3)
	assert(l_2_4)
	if l_2_0._player_unit:player_data().is_precision_aiming and l_2_0._stay_visible_time < 0 then
		l_2_0._stay_visible_time = 0.01
	end
	local l_2_6 = l_2_3:bullets_in_clip()
	if l_2_0._previous_bullets_in_clip and l_2_6 ~= l_2_0._previous_bullets_in_clip then
		l_2_0._stay_visible_time = l_2_5.STAY_VISIBILE_DELAY_AFTER_SHOOTING
	end
	l_2_0._previous_bullets_in_clip = l_2_6
	if l_2_0._previous_weapon_slot and l_2_4.hud_inventory_primary_active_slot ~= l_2_0._previous_weapon_slot then
		l_2_0._stay_visible_time = l_2_5.STAY_VISIBILE_DELAY_AFTER_SWITCHING_WEAPON
	end
	l_2_0._previous_weapon_slot = l_2_4.hud_inventory_active_slot
	if l_2_0._stay_visible_time > 0 and not l_2_0._hide then
		l_2_0._alpha_interpolator:set_target(1)
	else
		l_2_0._alpha_interpolator:set_target(0)
	end
	l_2_0._stay_visible_time = l_2_0._stay_visible_time - l_2_1
	l_2_0._alpha_interpolator:update(l_2_1)
	do
		local l_2_7 = l_2_0._alpha_interpolator:value()
		l_2_0._background:set_color(l_2_0._background:color():with_alpha(l_2_7))
		l_2_0._ammo_pool_text:set_color(l_2_0._ammo_pool_text:color():with_alpha(l_2_7))
		l_2_0._ammo_pool_text:set_text("" .. l_2_3:ammo_pool())
	end
	 -- WARNING: undefined locals caused missing assignments!
end

WeaponHud.hide = function(l_3_0)
	l_3_0._hide = true
end

WeaponHud.show = function(l_4_0)
	l_4_0._hide = false
end


