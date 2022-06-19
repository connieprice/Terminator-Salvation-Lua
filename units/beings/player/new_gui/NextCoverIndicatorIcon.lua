if not NextCoverIndicatorIcon then
	NextCoverIndicatorIcon = class()
end
NextCoverIndicatorIcon.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._parent_panel = l_1_1
	l_1_0._width = l_1_0._parent_panel:width()
	l_1_0._height = l_1_0._parent_panel:height()
	l_1_0._centre_x = l_1_0._width / 2
	l_1_0._centre_y = l_1_0._height / 2
	l_1_0._radius = tweak_data.player.new_hud.next_cover_indicator_panel.RADIUS
	l_1_0:_set_up_icon(l_1_2)
end

NextCoverIndicatorIcon._set_up_icon = function(l_2_0, l_2_1)
	local l_2_2, l_2_3 = l_2_0._parent_panel:bitmap, l_2_0._parent_panel
	local l_2_4 = {}
	l_2_4.name = "gui_coverdirection_icon"
	l_2_4.texture = "gui_coverdirection_icon"
	l_2_2 = l_2_2(l_2_3, l_2_4)
	l_2_0._icon_texture = l_2_2
	l_2_2 = tweak_data
	l_2_2 = l_2_2.player
	l_2_2 = l_2_2.new_hud
	l_2_2 = l_2_2.next_cover_indicator_panel
	l_2_2 = l_2_2.ANGLE_BETWEEN_ICONS
	if l_2_1 == 1 then
		l_2_3, l_2_4 = l_2_0:_set_angle, l_2_0
		l_2_3(l_2_4, 360 - l_2_2 * 2)
	elseif l_2_1 == 2 then
		l_2_3, l_2_4 = l_2_0:_set_angle, l_2_0
		l_2_3(l_2_4, 360 - l_2_2)
	elseif l_2_1 == 3 then
		l_2_3, l_2_4 = l_2_0:_set_angle, l_2_0
		l_2_3(l_2_4, 0)
	elseif l_2_1 == 4 then
		l_2_3, l_2_4 = l_2_0:_set_angle, l_2_0
		l_2_3(l_2_4, 0 + l_2_2)
	elseif l_2_1 == 5 then
		l_2_3, l_2_4 = l_2_0:_set_angle, l_2_0
		l_2_3(l_2_4, 0 + l_2_2 * 2)
	else
		l_2_3 = assert
		l_2_4 = false
		l_2_3(l_2_4)
	end
	l_2_3 = l_2_0._icon_texture
	l_2_3, l_2_4 = l_2_3:color, l_2_3
	l_2_3 = l_2_3(l_2_4)
	l_2_0._normal_color = l_2_3
	l_2_3 = l_2_0._icon_texture
	l_2_3, l_2_4 = l_2_3:color, l_2_3
	l_2_3 = l_2_3(l_2_4)
	l_2_3 = l_2_3 / 3
	l_2_0._desaturated_color = l_2_3
end

NextCoverIndicatorIcon._set_angle = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._centre_x + l_3_0._radius * math.cos(l_3_1 - 90)
	local l_3_3 = l_3_0._centre_y + l_3_0._radius * math.sin(l_3_1 - 90)
	l_3_0._icon_texture:set_rotation(l_3_1)
	l_3_0._icon_texture:set_center(l_3_2, l_3_3)
end

NextCoverIndicatorIcon.set_alpha = function(l_4_0, l_4_1)
	if not l_4_0._selected_icon then
		l_4_1 = l_4_1 * tweak_data.player.new_hud.next_cover_indicator_panel.INACTIVE_ICON_ALPHA
	end
	l_4_0._alpha = l_4_1
	l_4_0._icon_texture:set_color(l_4_0._icon_texture:color():with_alpha(l_4_0._alpha))
end

NextCoverIndicatorIcon.select = function(l_5_0)
	l_5_0._selected_icon = true
	l_5_0._icon_texture:set_color(l_5_0._normal_color)
end

NextCoverIndicatorIcon.unselect = function(l_6_0)
	l_6_0._selected_icon = false
	l_6_0._icon_texture:set_color(l_6_0._normal_color)
end

NextCoverIndicatorIcon.unavailable = function(l_7_0)
	l_7_0._selected_icon = false
	l_7_0._icon_texture:set_color(l_7_0._desaturated_color)
end

NextCoverIndicatorIcon.blink = function(l_8_0)
	l_8_0.blinking = true
end

NextCoverIndicatorIcon.get_selected_icon_blink_speed = function(l_9_0)
	return tweak_data.player.new_hud.next_cover_indicator_panel.SELECTED_ICON_BLINK_SPEED
end

NextCoverIndicatorIcon.get_selected_icon_blink_times = function(l_10_0)
	return tweak_data.player.new_hud.next_cover_indicator_panel.SELECTED_ICON_BLINK_TIMES
end

NextCoverIndicatorIcon.update = function(l_11_0, l_11_1)
end


