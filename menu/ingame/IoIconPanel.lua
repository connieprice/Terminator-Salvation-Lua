if not IoIconPanel then
	IoIconPanel = class(HudPanel)
end
IoIconPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._width = tweak_data.player.new_hud.io_icon_panel.WIDTH
	l_1_0._height = tweak_data.player.new_hud.io_icon_panel.HEIGHT
	l_1_0._x = l_1_1:width()
	l_1_0._y = l_1_1:height()
	l_1_0._center_x = l_1_0._width / 2
	l_1_0._center_y = l_1_0._height / 2
	l_1_0._icon_offset = 8
	local l_1_4, l_1_5 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_6 = {}
	l_1_6.name = "io_icon_panel"
	l_1_6.width = l_1_0._width
	l_1_6.height = l_1_0._height
	l_1_6.valign = "bottom"
	l_1_6.halign = "right"
	l_1_6.layer = 200
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._panel = l_1_4
	l_1_4 = l_1_0._panel
	l_1_4, l_1_5 = l_1_4:set_rightbottom, l_1_4
	l_1_6 = l_1_0._x
	l_1_4(l_1_5, l_1_6, l_1_0._y)
	l_1_0._icons, l_1_4 = l_1_4, {}
	l_1_4 = l_1_0._icons
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:bitmap, l_1_5
	local l_1_7 = {}
	l_1_7.name = "icon_main"
	l_1_7.texture = l_1_2
	l_1_5 = l_1_5(l_1_6, l_1_7)
	l_1_4.main = l_1_5
	l_1_4 = l_1_0._icons
	l_1_4 = l_1_4.main
	l_1_4, l_1_5 = l_1_4:set_rightbottom, l_1_4
	l_1_6 = l_1_0._panel
	l_1_6, l_1_7 = l_1_6:width, l_1_6
	l_1_6 = l_1_6(l_1_7)
	l_1_7 = l_1_0._icon_offset
	l_1_6 = l_1_6 + l_1_7
	l_1_7 = l_1_0._panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_4 = l_1_0._icons
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:bitmap, l_1_5
	l_1_5, l_1_7 = l_1_5(l_1_6, l_1_7), {name = "icon_hilight", texture = "gui_saving_hilight", blend_mode = "add", layer = 201}
	l_1_4.hilight = l_1_5
	l_1_4 = l_1_0._icons
	l_1_4 = l_1_4.hilight
	l_1_4, l_1_5 = l_1_4:set_rightbottom, l_1_4
	l_1_6 = l_1_0._panel
	l_1_6, l_1_7 = l_1_6:width, l_1_6
	l_1_6 = l_1_6(l_1_7)
	l_1_7 = l_1_0._icon_offset
	l_1_6 = l_1_6 + l_1_7
	l_1_7 = l_1_0._panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_0._spin_speed = l_1_3
	l_1_0._fade_out_time = nil
	l_1_4 = Interpolator
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_6 = 0
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_4 = l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_0._alpha_interpolator = l_1_4
	l_1_4 = l_1_0._alpha_interpolator
	l_1_4, l_1_5 = l_1_4:set_target, l_1_4
	l_1_6 = 0
	l_1_4(l_1_5, l_1_6)
	l_1_0._current_angle = 0
	l_1_4, l_1_5 = l_1_0:set_alpha, l_1_0
	l_1_6 = 0
	l_1_4(l_1_5, l_1_6)
end

IoIconPanel.panel = function(l_2_0)
	return l_2_0._panel
end

IoIconPanel.show = function(l_3_0)
	if not l_3_0._fade_out_time then
		local l_3_1 = TimerManager:wall():time()
		l_3_0._fade_out_time = l_3_1 + tweak_data.player.new_hud.io_icon_panel.TIME_BEFORE_FADE_OUT
		l_3_0:use_high_frequency_update()
	if not l_3_0._panel:visible() then
		end
		l_3_0._panel:show()
	end
	l_3_0._alpha_interpolator:set_target(1)
	l_3_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.io_icon_panel.FADE_IN_SPEED)
	l_3_0._showing = true
end

IoIconPanel.hide = function(l_4_0)
	if l_4_0._fade_out_time then
		local l_4_1 = TimerManager:wall():time()
	if l_4_0._fade_out_time < l_4_1 then
		end
		l_4_0._alpha_interpolator:set_target(0)
		l_4_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.io_icon_panel.FADE_OUT_SPEED)
		l_4_0._fade_out_time = nil
		l_4_0._showing = false
	end
end

IoIconPanel.icon_width = function(l_5_0)
	local l_5_1, l_5_2 = l_5_0._panel:width, l_5_0._panel
	return l_5_1(l_5_2)
end

IoIconPanel.visible = function(l_6_0)
	if l_6_0._alpha <= 0 then
		local l_6_1 = l_6_0._showing
		l_6_1 = l_6_1
		return l_6_1
	end
end

IoIconPanel.set_alpha = function(l_7_0, l_7_1)
	local l_7_5, l_7_6, l_7_7, l_7_8, l_7_9, l_7_10 = nil
	HudPanel.set_alpha(l_7_0, l_7_1)
	for i_0,i_1 in pairs(l_7_0._icons) do
		i_1:set_color(i_1:color():with_alpha(l_7_0._alpha))
	end
	if l_7_1 == 0 then
		l_7_0:use_low_frequency_update()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

IoIconPanel.update = function(l_8_0, l_8_1)
	l_8_0:_update_alpha(l_8_1)
	l_8_0:_update_spin(l_8_1)
end

IoIconPanel._update_alpha = function(l_9_0, l_9_1)
	l_9_0._alpha_interpolator:update(l_9_1)
	local l_9_2 = nil
	if l_9_0._alpha_interpolator:has_reached_target() then
		l_9_2 = l_9_0._alpha_interpolator:target()
	else
		l_9_2 = l_9_0._alpha_interpolator:value()
	end
	l_9_0:set_alpha(l_9_2)
end

IoIconPanel._update_spin = function(l_10_0, l_10_1)
	local l_10_2 = 360 / l_10_0._spin_speed * l_10_1
	l_10_0._current_angle = l_10_0._current_angle + l_10_2
	if l_10_0._current_angle > 360 then
		l_10_0._current_angle = l_10_0._current_angle - 360
	end
	l_10_0._icons.main:set_rotation(l_10_0._current_angle)
end


