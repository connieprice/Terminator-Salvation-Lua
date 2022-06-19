if not Hud3DigitText then
	Hud3DigitText = class()
end
Hud3DigitText.init = function(l_1_0, l_1_1)
	l_1_0._gui_text = l_1_1
	l_1_0._red_alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.ammo_panel.RED_FADE_IN_SPEED)
	l_1_0._gui_text_color = l_1_0._gui_text:color()
	l_1_0:set_red_alpha(0)
end

Hud3DigitText.instant_red = function(l_2_0)
	l_2_0._red_alpha_interpolator:set_target(1)
	l_2_0._red_alpha_interpolator:set_value(1)
end

Hud3DigitText.show_red = function(l_3_0)
	l_3_0._red_alpha_interpolator:set_target(1)
	l_3_0._red_alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.RED_FADE_IN_SPEED)
end

Hud3DigitText.hide_red = function(l_4_0)
	l_4_0._red_alpha_interpolator:set_target(0)
	l_4_0._red_alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.RED_FADE_OUT_SPEED)
end

Hud3DigitText.instant_hide_red = function(l_5_0)
	l_5_0._red_alpha_interpolator:set_target(0)
	l_5_0._red_alpha_interpolator:set_value(0)
	l_5_0._red_alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.RED_FADE_OUT_SPEED)
end

Hud3DigitText.set_red_alpha = function(l_6_0, l_6_1)
	if l_6_0._red_alpha and l_6_0._red_alpha == l_6_1 then
		return 
	end
	l_6_0._red_alpha = l_6_1
	local l_6_2 = tweak_data.player.new_hud.health_panel.RED_HEALTH_RGB
	local l_6_3 = 1 - (1 - l_6_2.red) * l_6_1
	local l_6_4 = 1 - (1 - l_6_2.green) * l_6_1
	local l_6_5 = 1 - (1 - l_6_2.blue) * l_6_1
	l_6_0._current_color = Color(l_6_3, l_6_4, l_6_5)
	l_6_0._gui_text:set_color(l_6_0._gui_text_color * l_6_0._current_color:with_alpha(l_6_0._alpha))
	l_6_0:_update_alpha()
end

Hud3DigitText.update = function(l_7_0, l_7_1)
	l_7_0._red_alpha_interpolator:update(l_7_1)
	local l_7_2 = l_7_0._red_alpha_interpolator:value()
	l_7_0:set_red_alpha(l_7_2)
end

Hud3DigitText.set_text = function(l_8_0, l_8_1)
	local l_8_2 = l_8_0:_parse(l_8_1)
	if l_8_0._text == l_8_2 then
		return 
	end
	l_8_0._text = l_8_2
	l_8_0._gui_text:set_text(l_8_2)
	l_8_0:_update_alpha()
end

Hud3DigitText._parse = function(l_9_0, l_9_1)
	local l_9_2 = "000" .. l_9_1
	l_9_2 = l_9_2:sub(-3)
	return l_9_2
end

Hud3DigitText.set_alpha = function(l_10_0, l_10_1)
	l_10_0._alpha = l_10_1
	l_10_0:_update_alpha()
end

Hud3DigitText._update_alpha = function(l_11_0)
	do
		local l_11_1, l_11_2 = l_11_0._alpha or 0
	end
	local l_11_3 = nil
	local l_11_4 = 0
	local l_11_5 = l_11_0._gui_text:color():with_alpha(0.5 * l_11_3)
	local l_11_6 = l_11_0._gui_text:color():with_alpha(l_11_3)
	if tonumber(l_11_0._text) and tonumber(l_11_0._text) == 0 then
		l_11_4 = 3
	elseif tonumber(l_11_0._text) and tonumber(l_11_0._text) < 10 then
		l_11_4 = 2
	elseif tonumber(l_11_0._text) and tonumber(l_11_0._text) < 100 then
		l_11_4 = 1
	end
	l_11_0._gui_text:set_range_color(0, l_11_4, l_11_5)
	l_11_0._gui_text:set_range_color(l_11_4, 4, l_11_6)
end

Hud3DigitText.get_red_color = function(l_12_0)
	return l_12_0._current_color
end

Hud3DigitText.instant_hide = function(l_13_0)
	l_13_0._gui_text:set_range_color(0, 3, l_13_0._gui_text:color():with_alpha(0))
end


