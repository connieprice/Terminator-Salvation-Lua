if not PowerUpBar then
	PowerUpBar = class()
end
PowerUpBar.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_0._panel = l_1_1
	local l_1_7, l_1_8 = l_1_0._panel:bitmap, l_1_0._panel
	local l_1_9 = {}
	l_1_9.name = l_1_2
	l_1_9.texture = l_1_2
	l_1_7 = l_1_7(l_1_8, l_1_9)
	l_1_0._image = l_1_7
	l_1_7 = l_1_0._image
	l_1_7, l_1_8 = l_1_7:set_size, l_1_7
	l_1_9 = l_1_5
	l_1_7(l_1_8, l_1_9, l_1_6)
	l_1_7 = l_1_0._image
	l_1_7, l_1_8 = l_1_7:set_lefttop, l_1_7
	l_1_9 = l_1_3
	l_1_7(l_1_8, l_1_9, l_1_4)
	l_1_7 = tweak_data
	l_1_7 = l_1_7.machine
	l_1_7 = l_1_7.hud
	l_1_7 = l_1_7.HIGHLIGHT_COLOR_TWEAK
	l_1_0._color = l_1_7
	l_1_7 = Interpolator
	l_1_7, l_1_8 = l_1_7:new, l_1_7
	l_1_9 = 0
	l_1_7 = l_1_7(l_1_8, l_1_9, tweak_data.machine.hud.POWER_UP_FADE_IN_SPEED)
	l_1_0._alpha_interpolator = l_1_7
end

PowerUpBar.destroy = function(l_2_0)
	l_2_0._panel:remove(l_2_0._image)
end

PowerUpBar.full_activate = function(l_3_0)
	l_3_0._alpha_interpolator:set_target(tweak_data.machine.hud.HIGH_ALPHA)
	l_3_0._alpha_interpolator:set_speed(tweak_data.machine.hud.POWER_UP_FADE_IN_SPEED)
	l_3_0.need_update = true
end

PowerUpBar.activate = function(l_4_0)
	l_4_0._alpha_interpolator:set_target(tweak_data.machine.hud.MAIN_ALPHA)
	l_4_0._alpha_interpolator:set_speed(tweak_data.machine.hud.POWER_UP_FADE_IN_SPEED)
	l_4_0.need_update = true
end

PowerUpBar.inactivate = function(l_5_0)
	l_5_0._alpha_interpolator:set_target(0.1)
	l_5_0._alpha_interpolator:set_speed(tweak_data.machine.hud.POWER_UP_FADE_OUT_SPEED)
	l_5_0.need_update = true
end

PowerUpBar.set_alpha = function(l_6_0, l_6_1)
	l_6_0._alpha = l_6_1
	l_6_0._image:set_color(l_6_0._color:with_alpha(l_6_1))
end

PowerUpBar.resize = function(l_7_0, l_7_1, l_7_2)
	l_7_0._image:set_size(l_7_1, l_7_2)
end

PowerUpBar.update = function(l_8_0, l_8_1)
	if l_8_0._alpha_interpolator:has_reached_target() then
		l_8_0.need_update = false
	else
		l_8_0._alpha_interpolator:update(l_8_1)
		local l_8_2 = l_8_0._alpha_interpolator:value()
		l_8_0:set_alpha(l_8_2)
		l_8_0.need_update = true
	end
end

PowerUpBar.show = function(l_9_0)
	l_9_0:set_alpha(l_9_0._alpha)
end


