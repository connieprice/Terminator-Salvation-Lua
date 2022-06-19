FlashPanel = FlashPanel or class()
function FlashPanel.init(A0_0, A1_1, A2_2)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._screen_gun_flash_rect = A0_0._parent_panel:rect({
		layer = -1,
		color = Color("111"),
		blend_mode = "add",
		halign = "grow",
		valign = "grow"
	})
	A0_0._screen_gun_flash_rect:hide()
	A0_0._gun_flash_alpha_interpolator = InterpolatorLinear:new(0, tweak_data.player.hud.gun_flash.FADE_SPEED)
end
function FlashPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._flash_panel
	return L1_4
end
function FlashPanel.update(A0_5, A1_6, A2_7)
	if A2_7._on_fire and A0_5._gun_flash == nil then
		A0_5:make_gun_flash()
	end
	A0_5:update_gun_flash_overlay(A1_6)
end
function FlashPanel.make_gun_flash(A0_8)
	A0_8._gun_flash = "start"
	A0_8._screen_gun_flash_rect:show()
	A0_8._gun_flash_alpha_interpolator:set_value(tweak_data.player.hud.gun_flash.FADE_ALPHA_PEAK)
	A0_8._screen_gun_flash_rect:set_color(A0_8._screen_gun_flash_rect:color():with_alpha(tweak_data.player.hud.gun_flash.FADE_ALPHA_PEAK))
	A0_8._gun_flash_alpha_interpolator:set_target(0)
end
function FlashPanel.update_gun_flash_overlay(A0_9, A1_10)
	local L2_11
	L2_11 = A0_9._gun_flash_alpha_interpolator
	L2_11 = L2_11.update
	L2_11(L2_11, A1_10)
	L2_11 = A0_9._gun_flash
	if L2_11 == nil then
		return
	else
		L2_11 = A0_9._gun_flash
		if L2_11 == "remove" then
			L2_11 = A0_9._screen_gun_flash_rect
			L2_11 = L2_11.hide
			L2_11(L2_11)
			A0_9._gun_flash = nil
			return
		end
	end
	L2_11 = A0_9._gun_flash_alpha_interpolator
	L2_11 = L2_11.value
	L2_11 = L2_11(L2_11)
	A0_9._screen_gun_flash_rect:set_color(A0_9._screen_gun_flash_rect:color():with_alpha(L2_11))
	if A0_9._gun_flash_alpha_interpolator:has_reached_target() then
		A0_9._gun_flash = "remove"
	end
end
function FlashPanel.hide(A0_12)
	A0_12._screen_gun_flash_rect:hide()
end
