require("units/beings/player/new_gui/HudPanel")
require("units/beings/player/new_gui/NextCoverIndicatorIcon")
if not NextCoverIndicatorPanel then
	NextCoverIndicatorPanel = class(HudPanel)
end
NextCoverIndicatorPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	HudPanel.init(l_1_0, false)
	l_1_0._safe_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._width = l_1_0._safe_panel:width()
	l_1_0._height = l_1_0._safe_panel:height()
	local l_1_4, l_1_5 = l_1_0._safe_panel:panel, l_1_0._safe_panel
	local l_1_6 = {}
	l_1_6.name = "next_cover_indicator_panel"
	l_1_6.width = l_1_0._width
	l_1_6.height = l_1_0._height
	l_1_6.valign = "center"
	l_1_6.halign = "center"
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._panel = l_1_4
	l_1_0._next_cover_indicator_icons, l_1_4 = l_1_4, {}
	l_1_4 = 1
	l_1_5 = 5
	l_1_6 = 1
	for i = l_1_4, l_1_5, l_1_6 do
		l_1_0._next_cover_indicator_icons[l_1_7] = NextCoverIndicatorIcon:new(l_1_0._panel, l_1_7)
	end
	l_1_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.next_cover_indicator_panel.FADE_SPEED)
	l_1_0._alpha_interpolator:set_target(0)
	l_1_0:set_alpha(0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

NextCoverIndicatorPanel.panel = function(l_2_0)
	return l_2_0._panel
end

NextCoverIndicatorPanel.show = function(l_3_0)
	l_3_0._alpha_interpolator:set_target(1)
end

NextCoverIndicatorPanel.hide = function(l_4_0)
	local l_4_4, l_4_5, l_4_6, l_4_7 = nil
	l_4_0._alpha_interpolator:set_target(0)
	if not l_4_0._blinking then
		for i_0,i_1 in pairs(l_4_0._next_cover_indicator_icons) do
			if l_4_0._player_data.quick_moving and i_0 == l_4_0._selected_next_cover then
				l_4_0:blink(i_0)
			end
		end
	end
end

NextCoverIndicatorPanel.set_alpha = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7, l_5_8, l_5_9, l_5_10, l_5_11, l_5_12, l_5_13 = nil
	if not l_5_0._blinking then
		HudPanel.set_alpha(l_5_0, l_5_1)
	end
	for i_0,i_1 in pairs(l_5_0._next_cover_indicator_icons) do
		if l_5_0._blinking and i_0 == l_5_0._blink_icon then
			i_1:set_alpha(l_5_0._blink_alpha_modifier)
		else
			i_1:set_alpha(l_5_1)
		end
	end
end

NextCoverIndicatorPanel.visible = function(l_6_0)
	if l_6_0._alpha <= 0 then
		local l_6_1 = l_6_0._blinking
		l_6_1 = l_6_1
		return l_6_1
	end
end

NextCoverIndicatorPanel.update = function(l_7_0, l_7_1)
	local l_7_2 = false
	if l_7_0:quick_move_info_changed() and not l_7_0._blinking then
		l_7_2 = true
		l_7_0:update_icon_status()
	end
	if l_7_0._blinking and l_7_0:update_blink(l_7_1) then
		l_7_0._blinking = false
	end
	l_7_0._alpha_interpolator:update(l_7_1)
	local l_7_3 = l_7_0._alpha_interpolator:value()
	l_7_0:set_alpha(l_7_3)
	if not l_7_0._alpha_interpolator:has_reached_target() or l_7_0._blink_icon then
		l_7_2 = true
	end
	if l_7_2 then
		l_7_0:use_high_frequency_update()
	else
		l_7_0:use_low_frequency_update()
	end
end

NextCoverIndicatorPanel.quick_move_info_changed = function(l_8_0)
	if l_8_0._quick_move_infos and l_8_0._quick_move_infos == l_8_0._player_data.quick_move_infos and l_8_0._quick_move_info_index and l_8_0._quick_move_info_index == l_8_0._player_data.quick_move_info_index then
		return false
	end
	return true
end

NextCoverIndicatorPanel.update_icon_status = function(l_9_0)
	l_9_0._quick_move_infos = l_9_0._player_data.quick_move_infos
	l_9_0._quick_move_info_index = l_9_0._player_data.quick_move_info_index
	local l_9_1 = nil
	local l_9_2 = {}
	if l_9_0._quick_move_info_index and l_9_0._quick_move_infos[l_9_0._quick_move_info_index] then
		local l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_13, l_9_14, l_9_15, l_9_16, l_9_17 = l_9_0:_quick_move_type_to_next_cover_icon_index, l_9_0, l_9_0._quick_move_infos[l_9_0._quick_move_info_index]:quick_move_type(), .end
		l_9_6 = l_9_6(l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_13, l_9_14, l_9_15, l_9_16, l_9_17)
		l_9_1 = l_9_6
	end
	for i_0,i_1 in pairs(l_9_0._quick_move_infos) do
		if l_9_0:quick_move_available(i_1) and l_9_0:_quick_move_type_to_next_cover_icon_index(i_1:quick_move_type()) then
			if l_9_1 and l_9_0:_quick_move_type_to_next_cover_icon_index(i_1:quick_move_type()) == l_9_1 then
				l_9_0._next_cover_indicator_icons[l_9_0:_quick_move_type_to_next_cover_icon_index(i_1:quick_move_type())]:select()
				l_9_0._selected_next_cover = l_9_0:_quick_move_type_to_next_cover_icon_index(i_1:quick_move_type())
			else
				l_9_0._next_cover_indicator_icons[l_9_0:_quick_move_type_to_next_cover_icon_index(i_1:quick_move_type())]:unselect()
				l_9_2[l_9_0:_quick_move_type_to_next_cover_icon_index(i_1:quick_move_type())] = true
			end
		end
		for i_0,i_1 in pairs(l_9_0._next_cover_indicator_icons) do
			if not l_9_2[i_0] then
				i_1:unavailable()
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

NextCoverIndicatorPanel.quick_move_available = function(l_10_0, l_10_1)
	local l_10_2 = not l_10_0._player_data.facing_right_in_cover
	local l_10_3 = l_10_0._player_data.cover_point
	if l_10_1:possible_from_cover_point(l_10_2, l_10_3) then
		return true
	end
	return false
end

NextCoverIndicatorPanel._quick_move_type_to_next_cover_icon_index = function(l_11_0, l_11_1)
	if l_11_1 == 0 then
		return 1
	elseif l_11_1 == 1 then
		return 5
	elseif l_11_1 == 2 then
		return 3
	elseif l_11_1 == 3 then
		return 3
	elseif l_11_1 == 4 then
		return 2
	elseif l_11_1 == 5 then
		return 4
	elseif l_11_1 == 6 then
		return 3
	else
		return nil
	end
end

NextCoverIndicatorPanel.blink = function(l_12_0, l_12_1)
	l_12_0._blink_icon = l_12_1
	l_12_0._blinking = true
	l_12_0._blink_time = 0
	l_12_0._next_blink_time = 0
	l_12_0._blinked_times = 0
end

NextCoverIndicatorPanel.update_blink = function(l_13_0, l_13_1)
	l_13_0._blink_time = l_13_0._blink_time + l_13_1
	if l_13_0._next_blink_time < l_13_0._blink_time then
		if l_13_0._blink_alpha_modifier == 0 then
			l_13_0._blink_alpha_modifier = 1
		else
			l_13_0._blink_alpha_modifier = 0
			l_13_0._blinked_times = l_13_0._blinked_times + 1
		end
		l_13_0._next_blink_time = l_13_0._blink_time + tweak_data.player.new_hud.next_cover_indicator_panel.SELECTED_ICON_BLINK_SPEED
	end
	return tweak_data.player.new_hud.next_cover_indicator_panel.SELECTED_ICON_BLINK_TIMES < l_13_0._blinked_times
end


