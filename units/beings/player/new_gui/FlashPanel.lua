if not FlashPanel then
	FlashPanel = class()
end
FlashPanel.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	local l_1_3, l_1_4 = l_1_0._parent_panel:rect, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.layer = -1
	l_1_5.color = Color("111")
	l_1_5.blend_mode = "add"
	l_1_5.halign = "grow"
	l_1_5.valign = "grow"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._screen_gun_flash_rect = l_1_3
	l_1_3 = l_1_0._screen_gun_flash_rect
	l_1_3, l_1_4 = l_1_3:hide, l_1_3
	l_1_3(l_1_4)
	l_1_3 = InterpolatorLinear
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 0
	l_1_3 = l_1_3(l_1_4, l_1_5, tweak_data.player.hud.gun_flash.FADE_SPEED)
	l_1_0._gun_flash_alpha_interpolator = l_1_3
end

FlashPanel.panel = function(l_2_0)
	return l_2_0._flash_panel
end

FlashPanel.update = function(l_3_0, l_3_1, l_3_2)
	if l_3_2._on_fire and l_3_0._gun_flash == nil then
		l_3_0:make_gun_flash()
	end
	l_3_0:update_gun_flash_overlay(l_3_1)
end

FlashPanel.make_gun_flash = function(l_4_0)
	l_4_0._gun_flash = "start"
	l_4_0._screen_gun_flash_rect:show()
	l_4_0._gun_flash_alpha_interpolator:set_value(tweak_data.player.hud.gun_flash.FADE_ALPHA_PEAK)
	l_4_0._screen_gun_flash_rect:set_color(l_4_0._screen_gun_flash_rect:color():with_alpha(tweak_data.player.hud.gun_flash.FADE_ALPHA_PEAK))
	l_4_0._gun_flash_alpha_interpolator:set_target(0)
end

FlashPanel.update_gun_flash_overlay = function(l_5_0, l_5_1)
	l_5_0._gun_flash_alpha_interpolator:update(l_5_1)
	if l_5_0._gun_flash == nil then
		return 
	end
	do return end
	if l_5_0._gun_flash == "remove" then
		l_5_0._screen_gun_flash_rect:hide()
		l_5_0._gun_flash = nil
		return 
	end
	local l_5_2 = l_5_0._gun_flash_alpha_interpolator:value()
	l_5_0._screen_gun_flash_rect:set_color(l_5_0._screen_gun_flash_rect:color():with_alpha(l_5_2))
	if l_5_0._gun_flash_alpha_interpolator:has_reached_target() then
		l_5_0._gun_flash = "remove"
	end
end

FlashPanel.hide = function(l_6_0)
	l_6_0._screen_gun_flash_rect:hide()
end


