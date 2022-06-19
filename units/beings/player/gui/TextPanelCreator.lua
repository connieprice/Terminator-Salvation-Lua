if not TextPanelCreator then
	TextPanelCreator = class()
end
TextPanelCreator.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5)
	l_1_0._font = tweak_data.player.new_hud.TEXTPANEL_CREATOR_FONT
	l_1_0._x = 0
	l_1_0._y = 0
	l_1_0._max_height = 0
	l_1_0._use_small_font = l_1_4
	if not l_1_3 then
		l_1_3 = Color(1, 1, 1, 1)
	end
	l_1_0._pulse_target = tweak_data.player.new_hud.mission_objectives.ICON_PULSE_TARGET
	l_1_0._pulse_interpolator = Interpolator:new(1, tweak_data.player.new_hud.mission_objectives.ICON_PULSE_SPEED_NOT_COMPLETE)
	l_1_0._pulse_interpolator:set_target(l_1_0._pulse_target)
	l_1_0._panel = l_1_1:create_hud_panel()
	assert(l_1_2)
	repeat
		local l_1_6 = l_1_2:find("[[]")
		if l_1_6 then
			local l_1_7 = l_1_2:sub(1, l_1_6 - 1)
			l_1_2 = l_1_2:sub(l_1_6 + 1)
			local l_1_8 = l_1_2:find("[]]")
			local l_1_9 = l_1_2:sub(1, l_1_8 - 1)
			l_1_2 = l_1_2:sub(l_1_8 + 1)
			assert(l_1_8)
			l_1_0:add_text(l_1_7, l_1_3)
			l_1_0:add_icon(l_1_9)
		end
	until l_1_6 == nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_1_6 > 0 then
		l_1_6(l_1_0, l_1_2, l_1_3)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_6, l_1_0._x, l_1_0._max_height)
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_12, l_1_13 = l_1_0._panel:children(), .end
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_1_6 do
		local l_1_14 = l_1_11:height()
		local l_1_15 = (l_1_0._max_height - l_1_14) / 2
		l_1_11:set_y(l_1_15)
	end
	l_1_0._move_to_position = l_1_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_1_6 then
		l_1_0._target_position = l_1_0._panel:parent():world_center_x()
		l_1_0._move_interpolator = Interpolator:new(0, tweak_data.player.new_hud.mission_objectives.ICON_PULSE_SPEED_NOT_COMPLETE)
		l_1_0._move_interpolator:set_target(l_1_0._target_position)
	else
		l_1_0._panel:set_world_center_x(l_1_0._panel:parent():world_center_x())
	end
	l_1_1:hud_panel_done()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

TextPanelCreator.add_text = function(l_2_0, l_2_1, l_2_2)
	local l_2_3, l_2_4 = l_2_0._panel:text, l_2_0._panel
	local l_2_5 = {}
	l_2_5.valign = "center"
	l_2_5.x = l_2_0._x
	l_2_5.font = l_2_0._font
	l_2_5.font_size = 25
	l_2_5.color = l_2_2
	l_2_5.text = l_2_1
	l_2_5.layer = 100
	l_2_3 = l_2_3(l_2_4, l_2_5)
	l_2_4 = l_2_0._use_small_font
	if l_2_4 then
		l_2_4, l_2_5 = l_2_3:set_font_scale, l_2_3
		l_2_4(l_2_5, tweak_data.player.new_hud.TEXTPANEL_SMALL_FONT_FACTOR)
	end
	l_2_4, l_2_5 = l_2_3:set_height, l_2_3
	l_2_4(l_2_5, l_2_3:line_height())
	l_2_4, l_2_5 = l_2_3:text_rect, l_2_3
	l_2_4 = l_2_4(l_2_5)
	local l_2_6, l_2_7 = nil
	l_2_0._x = l_2_0._x + l_2_6
	if l_2_0._max_height < l_2_7 then
		l_2_0._max_height = l_2_7
	end
end

TextPanelCreator.add_icon = function(l_3_0, l_3_1)
	local l_3_2 = nil
	if l_3_1:sub(1, 7) == "action:" then
		l_3_1 = l_3_1:sub(8)
		l_3_2 = "gui_button_" .. ({revive = "y", cover = "a", pick_up = "y", look_at = "y"})[l_3_1]
	else
		l_3_2 = "gui_" .. l_3_1
	end
	local l_3_3 = l_3_0._panel:bitmap
	local l_3_4 = l_3_0._panel
	l_3_3 = l_3_3(l_3_4, {valign = "center", texture = l_3_2})
	l_3_4(l_3_3, l_3_0._x)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_0._x = l_3_4
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_0._max_height < l_3_4 then
		l_3_0._max_height = l_3_4
	end
	if l_3_2 == "gui_mission_objectivebox_completed" then
		l_3_0._pulse_icon = l_3_3
		l_3_0._pulse_interpolator:set_speed(tweak_data.player.new_hud.mission_objectives.ICON_PULSE_SPEED_COMPLETE)
	elseif l_3_2 == "gui_mission_objectivebox_not_completed" then
		l_3_0._pulse_icon = l_3_3
		l_3_0._pulse_interpolator:set_speed(tweak_data.player.new_hud.mission_objectives.ICON_PULSE_SPEED_NOT_COMPLETE)
	else
		l_3_0._pulse_icon = nil
	end
end

TextPanelCreator.panel = function(l_4_0)
	return l_4_0._panel
end

TextPanelCreator.update_icon_pulse = function(l_5_0, l_5_1)
	if not l_5_0._pulse_icon then
		return 
	end
	l_5_0._pulse_interpolator:update(l_5_1)
	local l_5_2 = l_5_0._pulse_interpolator:value()
	if l_5_0._pulse_interpolator:has_reached_target() then
		l_5_2 = l_5_0._pulse_interpolator:target()
	end
	if l_5_2 == l_5_0._pulse_target then
		l_5_0._pulse_interpolator:set_target(1)
	elseif l_5_2 == 1 then
		l_5_0._pulse_interpolator:set_target(l_5_0._pulse_target)
	end
	local l_5_3 = l_5_0._pulse_icon:center_x()
	local l_5_4 = l_5_0._pulse_icon:center_y()
	l_5_0._pulse_icon:set_size(64 * l_5_2, 64 * l_5_2)
	l_5_0._pulse_icon:set_center(l_5_3, l_5_4)
end

TextPanelCreator.update_mover = function(l_6_0, l_6_1)
	if not l_6_0._move_to_position then
		return 
	end
	l_6_0._move_interpolator:update(l_6_1)
	local l_6_2 = l_6_0._move_interpolator:value()
	if l_6_0._move_interpolator:has_reached_target() then
		l_6_2 = l_6_0._move_interpolator:target()
	end
	l_6_0._panel:set_world_center_x(l_6_2)
end


