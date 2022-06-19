WeaponHud = WeaponHud or class()
function WeaponHud.init(A0_0, A1_1, A2_2)
	local L3_3
	A0_0._player_unit = A1_1
	A0_0._safe_panel = A2_2
	L3_3 = tweak_data
	L3_3 = L3_3.player
	L3_3 = L3_3.weapon_hud
	A0_0._weapon_panel = A0_0._safe_panel:panel({
		name = "weapon_panel",
		valign = "top",
		halign = "right"
	})
	A0_0._weapon_panel:set_size(281, 54)
	A0_0._weapon_panel:set_righttop(A0_0._safe_panel:width(), 0)
	A0_0._alpha_interpolator = Interpolator:new(0, L3_3.FADE_SPEED)
	A0_0._ammo_pool_text = A0_0._weapon_panel:text({
		layer = 1,
		font = L3_3.AMMO_POOL_TEXT_FONT,
		font_size = L3_3.AMMO_POOL_TEXT_FONT_SIZE,
		color = L3_3.AMMO_POOL_TEXT_COLOR,
		align = "left",
		width = 50,
		height = L3_3.AMMO_POOL_TEXT_FONT_SIZE
	})
	A0_0._ammo_pool_text:set_left(L3_3.AMMO_POOL_TEXT_XOFFSET)
	A0_0._ammo_pool_text:set_bottom(A0_0._weapon_panel:height() - L3_3.AMMO_POOL_TEXT_YOFFSET)
	A0_0._ammo_pool_text:set_color(A0_0._ammo_pool_text:color():with_alpha(0))
	A0_0._stay_visible_time = 0
	A0_0._background = A0_0._weapon_panel:bitmap({
		layer = 0,
		name = "weapon_background",
		texture = "gui_bullet_bg"
	})
	A0_0._background:set_texture_rect(115, 37, 512, 128)
	A0_0._background:set_blend_mode("normal")
end
function WeaponHud.update(A0_4, A1_5)
	local L2_6, L3_7, L4_8, L5_9, L6_10, L7_11
	L2_6 = A0_4._player_unit
	L3_7 = L2_6
	L2_6 = L2_6.base
	L2_6 = L2_6(L3_7)
	L3_7 = L2_6
	L2_6 = L2_6.weapon_type
	L2_6 = L2_6(L3_7)
	L3_7 = A0_4._player_unit
	L4_8 = L3_7
	L3_7 = L3_7.base
	L3_7 = L3_7(L4_8)
	L4_8 = L3_7
	L3_7 = L3_7.weapon_data
	L3_7 = L3_7(L4_8)
	L4_8 = A0_4._player_unit
	L5_9 = L4_8
	L4_8 = L4_8.player_data
	L4_8 = L4_8(L5_9)
	L5_9 = tweak_data
	L5_9 = L5_9.player
	L5_9 = L5_9.weapon_hud
	L6_10 = assert
	L7_11 = L3_7
	L6_10(L7_11)
	L6_10 = assert
	L7_11 = L4_8
	L6_10(L7_11)
	L6_10 = A0_4._player_unit
	L7_11 = L6_10
	L6_10 = L6_10.player_data
	L6_10 = L6_10(L7_11)
	L6_10 = L6_10.is_precision_aiming
	if L6_10 then
		L6_10 = A0_4._stay_visible_time
		if L6_10 < 0 then
			A0_4._stay_visible_time = 0.01
		end
	end
	L7_11 = L3_7
	L6_10 = L3_7.bullets_in_clip
	L6_10 = L6_10(L7_11)
	L7_11 = A0_4._previous_bullets_in_clip
	if L7_11 then
		L7_11 = A0_4._previous_bullets_in_clip
		if L6_10 ~= L7_11 then
			L7_11 = L5_9.STAY_VISIBILE_DELAY_AFTER_SHOOTING
			A0_4._stay_visible_time = L7_11
		end
	end
	A0_4._previous_bullets_in_clip = L6_10
	L7_11 = A0_4._previous_weapon_slot
	if L7_11 then
		L7_11 = L4_8.hud_inventory_primary_active_slot
		if L7_11 ~= A0_4._previous_weapon_slot then
			L7_11 = L5_9.STAY_VISIBILE_DELAY_AFTER_SWITCHING_WEAPON
			A0_4._stay_visible_time = L7_11
		end
	end
	L7_11 = L4_8.hud_inventory_active_slot
	A0_4._previous_weapon_slot = L7_11
	L7_11 = A0_4._stay_visible_time
	if L7_11 > 0 then
		L7_11 = A0_4._hide
		if not L7_11 then
			L7_11 = A0_4._alpha_interpolator
			L7_11 = L7_11.set_target
			L7_11(L7_11, 1)
		end
	else
		L7_11 = A0_4._alpha_interpolator
		L7_11 = L7_11.set_target
		L7_11(L7_11, 0)
	end
	L7_11 = A0_4._stay_visible_time
	L7_11 = L7_11 - A1_5
	A0_4._stay_visible_time = L7_11
	L7_11 = A0_4._alpha_interpolator
	L7_11 = L7_11.update
	L7_11(L7_11, A1_5)
	L7_11 = A0_4._alpha_interpolator
	L7_11 = L7_11.value
	L7_11 = L7_11(L7_11)
	A0_4._background:set_color(A0_4._background:color():with_alpha(L7_11))
	A0_4._ammo_pool_text:set_color(A0_4._ammo_pool_text:color():with_alpha(L7_11))
	A0_4._ammo_pool_text:set_text("" .. L3_7:ammo_pool())
end
function WeaponHud.hide(A0_12)
	local L1_13
	A0_12._hide = true
end
function WeaponHud.show(A0_14)
	local L1_15
	A0_14._hide = false
end
