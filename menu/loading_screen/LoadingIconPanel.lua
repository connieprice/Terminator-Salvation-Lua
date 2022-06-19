require("menu/loading_screen/LoadingScreenTweakData")
require("shared/Interpolator")
if not LoadingIconPanel then
	LoadingIconPanel = class()
end
LoadingIconPanel.init = function(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._width = loading_screen_tweak_data.ICON_WIDTH
	l_1_0._height = loading_screen_tweak_data.ICON_HEIGHT
	l_1_0._x = l_1_1:width()
	l_1_0._y = l_1_1:height()
	l_1_0._center_x = l_1_0._width / 2
	l_1_0._center_y = l_1_0._height / 2
	l_1_0._icon_offset = 8
	local l_1_2, l_1_3 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_4 = {}
	l_1_4.name = "io_icon_panel"
	l_1_4.width = l_1_0._width
	l_1_4.height = l_1_0._height
	l_1_4.valign = "bottom"
	l_1_4.halign = "right"
	l_1_4.layer = 90
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._io_icon_panel = l_1_2
	l_1_2 = l_1_0._io_icon_panel
	l_1_2, l_1_3 = l_1_2:set_rightbottom, l_1_2
	l_1_4 = l_1_0._x
	l_1_2(l_1_3, l_1_4, l_1_0._y)
	l_1_0._icons, l_1_2 = l_1_2, {}
	l_1_2 = l_1_0._icons
	l_1_3 = l_1_0._io_icon_panel
	l_1_3, l_1_4 = l_1_3:bitmap, l_1_3
	local l_1_5 = {}
	l_1_5.name = "icon_main"
	l_1_5.texture = "gui_disc_icon"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_2.main = l_1_3
	l_1_2 = l_1_0._icons
	l_1_2 = l_1_2.main
	l_1_2, l_1_3 = l_1_2:set_rightbottom, l_1_2
	l_1_4 = l_1_0._io_icon_panel
	l_1_4, l_1_5 = l_1_4:width, l_1_4
	l_1_4 = l_1_4(l_1_5)
	l_1_5 = l_1_0._icon_offset
	l_1_4 = l_1_4 + l_1_5
	l_1_5 = l_1_0._io_icon_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_3, l_1_4, l_1_5)
	l_1_2 = l_1_0._icons
	l_1_2 = l_1_2.main
	l_1_2, l_1_3 = l_1_2:set_render_template, l_1_2
	l_1_4 = "OverlayVertexColorTextured"
	l_1_2(l_1_3, l_1_4)
	l_1_0._current_angle = 0
	l_1_2, l_1_3 = l_1_0:set_alpha, l_1_0
	l_1_4 = 0
	l_1_2(l_1_3, l_1_4)
	l_1_0._showing = false
end

LoadingIconPanel.panel = function(l_2_0)
	return l_2_0._io_icon_panel
end

LoadingIconPanel.show = function(l_3_0)
	l_3_0:set_alpha(1)
	l_3_0._showing = true
end

LoadingIconPanel.hide = function(l_4_0)
	l_4_0:set_alpha(0)
	l_4_0._showing = false
end

LoadingIconPanel.visible = function(l_5_0)
	if l_5_0._alpha <= 0 then
		local l_5_1 = l_5_0._showing
		l_5_1 = l_5_1
		return l_5_1
	end
end

LoadingIconPanel.set_alpha = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10 = nil
	l_6_0._alpha = l_6_1
	for i_0,i_1 in pairs(l_6_0._icons) do
		i_1:set_color(i_1:color():with_alpha(l_6_0._alpha))
	end
end

LoadingIconPanel.update = function(l_7_0, l_7_1)
	l_7_0:_update_spin(l_7_1)
end

LoadingIconPanel._update_spin = function(l_8_0, l_8_1)
	local l_8_2 = 360 / loading_screen_tweak_data.ICON_SPIN_SPEED * l_8_1
	l_8_0._current_angle = l_8_0._current_angle + l_8_2
	if l_8_0._current_angle > 360 then
		l_8_0._current_angle = l_8_0._current_angle - 360
	end
	l_8_0._icons.main:set_rotation(l_8_0._current_angle)
end


