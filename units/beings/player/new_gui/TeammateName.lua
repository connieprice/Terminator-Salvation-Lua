if not TeammateName then
	TeammateName = class()
end
TeammateName.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._display_unit = l_1_3
	l_1_0._camera = l_1_4
	l_1_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.teammate_name_panel.FADE_IN_SPEED)
	l_1_0._alpha_interpolator:set_target(1)
	l_1_0:_show_name()
	l_1_0._t = 0
	l_1_0._next_scan_time = 0
end

TeammateName.panel = function(l_2_0)
	return l_2_0._teammate_name_panel
end

TeammateName._show_name = function(l_3_0)
	local l_3_1 = nil
	if not alive(l_3_0._display_unit) then
		return 
	end
	if l_3_0._display_unit:hud() and l_3_0._display_unit:hud().teammate_name then
		if managers.localization:exists(l_3_0._display_unit:hud().teammate_name) then
			l_3_1 = managers.localization:text(l_3_0._display_unit:hud().teammate_name)
		else
			l_3_1 = l_3_0._display_unit:hud().teammate_name
		end
	else
		l_3_1 = l_3_0._display_unit:name()
	end
	local l_3_2 = l_3_0._parent_panel:text
	local l_3_3 = l_3_0._parent_panel
	l_3_2 = l_3_2(l_3_3, {text = l_3_1, font = tweak_data.player.new_hud.teammate_name_panel.TEXT_FONT, font_size = tweak_data.player.new_hud.teammate_name_panel.TEXT_FONT_SIZE, valign = "center", color = tweak_data.player.new_hud.teammate_name_panel.TEXT_FONT_COLOR})
	l_3_0._teammate_name_text = l_3_2
	l_3_2, l_3_3 = l_3_0:_update_position, l_3_0
	l_3_2(l_3_3)
end

TeammateName._update_position = function(l_4_0)
	if alive(l_4_0._camera) then
		local l_4_1 = Vector3(0, 0, tweak_data.player.new_hud.teammate_name_panel.NAME_Z_OFFSET)
		local l_4_2 = l_4_0._camera:world_to_screen(l_4_0._display_unit:position() + l_4_1)
		local l_4_3, l_4_4 = l_4_0:_screen_to_resolution(l_4_2)
		l_4_0._teammate_name_text:set_center(l_4_3, l_4_4)
		l_4_0._teammate_name_text:set_vertical("center")
		l_4_0._teammate_name_text:set_align("center")
	if not l_4_0._wants_to_hide then
		end
		if l_4_0:_display_unit_is_infront() then
			l_4_0:show()
		end
	else
		l_4_0:instant_hide()
	end
end

TeammateName._display_unit_is_infront = function(l_5_0)
	local l_5_1 = l_5_0._player_unit:camera_data().camera_rotation
	local l_5_2 = l_5_0._display_unit:position()
	local l_5_3 = l_5_0._display_unit:position() - l_5_0._player_unit:camera_data().camera_position
	local l_5_4 = l_5_1:y():dot(l_5_3)
	return l_5_4 > 0
end

TeammateName.show = function(l_6_0)
	l_6_0._wants_to_hide = false
	l_6_0._alpha_interpolator:set_target(1)
	l_6_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.teammate_name_panel.FADE_IN_SPEED)
end

TeammateName.hide = function(l_7_0)
	l_7_0._wants_to_hide = true
	l_7_0._alpha_interpolator:set_target(0)
	l_7_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.teammate_name_panel.FADE_OUT_SPEED)
end

TeammateName.instant_hide = function(l_8_0)
	l_8_0._wants_to_hide = true
	l_8_0._alpha_interpolator:set_target(0)
	l_8_0._alpha_interpolator:set_value(0)
	l_8_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.teammate_name_panel.FADE_OUT_SPEED)
end

TeammateName.remove = function(l_9_0)
	l_9_0._parent_panel:remove(l_9_0._teammate_name_text)
	l_9_0._teammate_name_text = nil
end

TeammateName.visible = function(l_10_0)
	return l_10_0._alpha > 0 or l_10_0._alpha_interpolator:target() > 0
end

TeammateName._set_alpha = function(l_11_0, l_11_1)
	l_11_0._alpha = l_11_1
	if l_11_0._teammate_name_text then
		l_11_0._teammate_name_text:set_color(l_11_0._teammate_name_text:color():with_alpha(l_11_0._alpha))
	end
end

TeammateName.update = function(l_12_0, l_12_1)
	l_12_0._t = l_12_0._t + l_12_1
	if l_12_0._teammate_name_text and alive(l_12_0._display_unit) then
		l_12_0:_update_position()
	end
	if l_12_0._next_scan_time < l_12_0._t then
		local l_12_2 = nil
		l_12_0._alpha_interpolator:update(l_12_1)
		if l_12_0._alpha_interpolator:has_reached_target() then
			l_12_2 = l_12_0._alpha_interpolator:target()
		else
			l_12_2 = l_12_0._alpha_interpolator:value()
		end
		l_12_0:_set_alpha(l_12_2)
		if l_12_2 > 0 and l_12_2 < 1 then
			l_12_0._next_scan_time = l_12_0._t
		end
	else
		l_12_0._next_scan_time = l_12_0._t + tweak_data.player.new_hud.teammate_name_panel.UPDATE_FREQUENCY
	end
end

TeammateName._screen_to_resolution = function(l_13_0, l_13_1)
	local l_13_2 = l_13_0._parent_panel:width() / 2 + l_13_0._parent_panel:width() / 2 * l_13_1.x
	local l_13_3 = l_13_0._parent_panel:height() / 2 + l_13_0._parent_panel:height() / 2 * l_13_1.y
	return l_13_2, l_13_3
end


