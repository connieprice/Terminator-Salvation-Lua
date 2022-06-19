if not RadarBlip then
	RadarBlip = class()
end
RadarBlip.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5)
	l_1_0._parent_panel = l_1_1
	l_1_0._shrink_fade_out = l_1_4
	l_1_0._size_modifier = l_1_5 or 1
	l_1_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	l_1_0._x = l_1_2
	l_1_0._y = l_1_3
	l_1_0._fade_out_x = l_1_0._x
	l_1_0._fade_out_y = l_1_0._y
	l_1_0._show_time = 0.3
	l_1_0._time_shown = 0
	l_1_0._is_done = false
	local l_1_7 = l_1_0._parent_panel:bitmap
	do
		local l_1_8 = l_1_0._parent_panel
		l_1_7 = l_1_7(l_1_8, {name = "gui_machine_radar_dot", texture = "gui_machine_radar_dot"})
		l_1_0._radar_blip_texture = l_1_7
		l_1_7 = l_1_0._radar_blip_texture
		l_1_7, l_1_8 = l_1_7:set_size, l_1_7
		l_1_7(l_1_8, 16 * l_1_0._size_modifier, 16 * l_1_0._size_modifier)
		l_1_7 = l_1_0._radar_blip_texture
		l_1_7, l_1_8 = l_1_7:set_center_x, l_1_7
		l_1_7(l_1_8, l_1_0._x)
		l_1_7 = l_1_0._radar_blip_texture
		l_1_7, l_1_8 = l_1_7:set_center_y, l_1_7
		l_1_7(l_1_8, l_1_0._y)
		l_1_7, l_1_8 = l_1_0:set_alpha, l_1_0
		l_1_7(l_1_8, 0)
		l_1_7 = l_1_0._radar_blip_texture
		l_1_7, l_1_8 = l_1_7:width, l_1_7
		l_1_7 = l_1_7(l_1_8)
		l_1_0._texture_width = l_1_7
		l_1_7 = l_1_0._radar_blip_texture
		l_1_7, l_1_8 = l_1_7:height, l_1_7
		l_1_7 = l_1_7(l_1_8)
		l_1_0._texture_height = l_1_7
		l_1_0._interpolator_fade_in_speed = 10
		l_1_0._interpolator_fade_out_speed = 1.2
		l_1_7 = Interpolator
		l_1_7, l_1_8 = l_1_7:new, l_1_7
		l_1_7 = l_1_7(l_1_8, 0, l_1_0._interpolator_fade_in_speed)
		l_1_0._interpolator = l_1_7
		l_1_7 = l_1_0._interpolator
		l_1_7, l_1_8 = l_1_7:set_target, l_1_7
		l_1_7(l_1_8, 1)
		l_1_0._show = false
		l_1_0._fade_out = false
		l_1_0._size_threshold = 0.4
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarBlip.show = function(l_2_0)
	l_2_0._show = true
	if not l_2_0._time_since_last_showed or l_2_0._time_since_last_showed > 2 then
		l_2_0._interpolator:set_target(1)
		l_2_0._interpolator:set_speed(l_2_0._interpolator_fade_in_speed)
		l_2_0._fade_out = false
		l_2_0._time_shown = 0
		l_2_0._time_since_last_showed = 0
		l_2_0._radar_blip_texture:set_size(l_2_0._texture_width, l_2_0._texture_height)
		l_2_0._radar_blip_texture:set_center_x(l_2_0._x)
		l_2_0._radar_blip_texture:set_center_y(l_2_0._y)
		l_2_0._fade_out_x = l_2_0._x
		l_2_0._fade_out_y = l_2_0._y
	end
end

RadarBlip.unhide = function(l_3_0)
	local l_3_1 = l_3_0._interpolator:value()
	if l_3_0._radar_blip_texture then
		l_3_0:set_alpha(l_3_1)
	end
end

RadarBlip.hide = function(l_4_0)
	if l_4_0._radar_blip_texture then
		l_4_0:set_alpha(0)
	end
end

RadarBlip.is_done = function(l_5_0)
	return l_5_0._is_done
end

RadarBlip.update = function(l_6_0, l_6_1)
	if not l_6_0._show then
		return 
	end
	l_6_0._time_shown = l_6_0._time_shown + l_6_1
	if l_6_0._time_since_last_showed then
		l_6_0._time_since_last_showed = l_6_0._time_since_last_showed + l_6_1
	end
	if l_6_0._show_time < l_6_0._time_shown and not l_6_0._fade_out then
		l_6_0._interpolator:set_target(0)
		l_6_0._fade_out = true
	end
	if l_6_0._fade_out then
		l_6_0._interpolator:set_speed(l_6_0._interpolator_fade_out_speed)
	end
	l_6_0._interpolator:update(l_6_1)
	if l_6_0._fade_out and l_6_0._interpolator:has_reached_target() then
		l_6_0:kill()
	elseif l_6_0._fade_out and l_6_0._shrink_fade_out then
		local l_6_2 = l_6_0._interpolator:value()
		if l_6_0._size_threshold < l_6_2 then
			local l_6_3 = l_6_0._texture_width * l_6_2
			local l_6_4 = l_6_0._texture_height * l_6_2
			l_6_0._radar_blip_texture:set_size(l_6_3, l_6_4)
			l_6_0._radar_blip_texture:set_center_x(l_6_0._fade_out_x)
			l_6_0._radar_blip_texture:set_center_y(l_6_0._fade_out_y)
		else
			l_6_0:set_alpha(0)
		end
	else
		local l_6_5 = l_6_0._interpolator:value()
		l_6_0:set_alpha(l_6_5)
	end
end

RadarBlip.set_alpha = function(l_7_0, l_7_1)
	l_7_0._alpha = l_7_1
	l_7_0._radar_blip_texture:set_color(l_7_0._color:with_alpha(l_7_1 * tweak_data.machine.hud.MAIN_ALPHA))
end

RadarBlip.update_position = function(l_8_0, l_8_1, l_8_2)
	l_8_0._x = l_8_1
	l_8_0._y = l_8_2
end

RadarBlip.hit_by_radar_line = function(l_9_0, l_9_1, l_9_2)
	local l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14, l_9_15, l_9_16, l_9_17, l_9_18, l_9_19, l_9_20, l_9_21, l_9_22, l_9_23 = nil
	local l_9_3 = {}
	local l_9_4 = {}
	for i_0,i_1 in pairs(l_9_1) do
		l_9_3.left = i_1.x - l_9_2 / 2
		l_9_3.right = i_1.x + l_9_2 / 2
		l_9_4.top = i_1.y - l_9_2 / 2
		l_9_4.bottom = i_1.y + l_9_2 / 2
		if l_9_3.left < l_9_0._x and l_9_0._x < l_9_3.right and l_9_4.top < l_9_0._y and l_9_0._y < l_9_4.bottom then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RadarBlip.kill = function(l_10_0)
	l_10_0._is_done = true
	if l_10_0._radar_blip_texture then
		l_10_0:set_alpha(0)
		l_10_0._radar_blip_texture = nil
	end
end

RadarBlip.visible = function(l_11_0)
	return l_11_0._alpha > 0
end


