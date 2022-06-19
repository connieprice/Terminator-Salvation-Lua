require("units/beings/player/new_gui/IconStates")
if not WeaponSelectionIcon then
	WeaponSelectionIcon = class()
end
WeaponSelectionIcon.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0._parent_panel = l_1_1
	l_1_0._weapon_selection_index = l_1_3
	l_1_0._icon_texture_name = l_1_2 or "gui_inv_empty"
	l_1_0._weapon_selection_index = l_1_3
	l_1_0._x = l_1_0._parent_panel:center_x()
	l_1_0._y = l_1_0._parent_panel:center_y()
	local l_1_5 = l_1_0._parent_panel:panel
	do
		local l_1_6 = l_1_0._parent_panel
		l_1_5 = l_1_5(l_1_6, {name = "weapon_icon_panel", width = 512, height = 128})
		l_1_0._icon_panel = l_1_5
		l_1_5 = l_1_0._icon_panel
		l_1_5, l_1_6 = l_1_5:bitmap, l_1_5
		l_1_5 = l_1_5(l_1_6, {name = "background", texture = "gui_weaponselection_gradient"})
		l_1_0._background_texture = l_1_5
		l_1_5 = tweak_data
		l_1_5 = l_1_5.player
		l_1_5 = l_1_5.new_hud
		l_1_5 = l_1_5.weapon_selection_panel
		l_1_5 = l_1_5.SELECTED_ICON_PIXELS_TO_MOVE
		l_1_0._pixels_to_move = l_1_5
		if l_1_3 == 1 then
			l_1_5 = l_1_0._y
			l_1_6 = tweak_data
			l_1_6 = l_1_6.player
			l_1_6 = l_1_6.new_hud
			l_1_6 = l_1_6.weapon_selection_panel
			l_1_6 = l_1_6.Y_OFFSET
			l_1_5 = l_1_5 - l_1_6
			l_1_0._y = l_1_5
			l_1_5 = l_1_0._x
			l_1_6 = tweak_data
			l_1_6 = l_1_6.player
			l_1_6 = l_1_6.new_hud
			l_1_6 = l_1_6.weapon_selection_panel
			l_1_6 = l_1_6.X_OFFSET
			l_1_5 = l_1_5 + l_1_6
			l_1_0._x = l_1_5
			l_1_5 = l_1_0._icon_panel
			l_1_5, l_1_6 = l_1_5:set_leftbottom, l_1_5
			l_1_5(l_1_6, l_1_0._x, l_1_0._y)
			l_1_5 = l_1_0._icon_panel
			l_1_5, l_1_6 = l_1_5:x, l_1_5
			l_1_5 = l_1_5(l_1_6)
			l_1_6 = l_1_0._pixels_to_move
			l_1_5 = l_1_5 + l_1_6
			l_1_0._end_position = l_1_5
			l_1_5 = l_1_0._background_texture
			l_1_5, l_1_6 = l_1_5:set_texture_rect, l_1_5
			l_1_5(l_1_6, 512, 0, -512, 128)
		elseif l_1_3 == 2 then
			l_1_5 = l_1_0._y
			l_1_6 = tweak_data
			l_1_6 = l_1_6.player
			l_1_6 = l_1_6.new_hud
			l_1_6 = l_1_6.weapon_selection_panel
			l_1_6 = l_1_6.Y_OFFSET
			l_1_5 = l_1_5 + l_1_6
			l_1_0._y = l_1_5
			l_1_5 = l_1_0._x
			l_1_6 = tweak_data
			l_1_6 = l_1_6.player
			l_1_6 = l_1_6.new_hud
			l_1_6 = l_1_6.weapon_selection_panel
			l_1_6 = l_1_6.X_OFFSET
			l_1_5 = l_1_5 + l_1_6
			l_1_0._x = l_1_5
			l_1_5 = l_1_0._icon_panel
			l_1_5, l_1_6 = l_1_5:set_lefttop, l_1_5
			l_1_5(l_1_6, l_1_0._x, l_1_0._y)
			l_1_5 = l_1_0._icon_panel
			l_1_5, l_1_6 = l_1_5:x, l_1_5
			l_1_5 = l_1_5(l_1_6)
			l_1_6 = l_1_0._pixels_to_move
			l_1_5 = l_1_5 + l_1_6
			l_1_0._end_position = l_1_5
			l_1_5 = l_1_0._background_texture
			l_1_5, l_1_6 = l_1_5:rotate, l_1_5
			l_1_5(l_1_6, 180)
		elseif l_1_3 == 3 then
			l_1_5 = l_1_0._y
			l_1_6 = tweak_data
			l_1_6 = l_1_6.player
			l_1_6 = l_1_6.new_hud
			l_1_6 = l_1_6.weapon_selection_panel
			l_1_6 = l_1_6.Y_OFFSET
			l_1_5 = l_1_5 + l_1_6
			l_1_0._y = l_1_5
			l_1_5 = l_1_0._x
			l_1_6 = tweak_data
			l_1_6 = l_1_6.player
			l_1_6 = l_1_6.new_hud
			l_1_6 = l_1_6.weapon_selection_panel
			l_1_6 = l_1_6.X_OFFSET
			l_1_5 = l_1_5 - l_1_6
			l_1_0._x = l_1_5
			l_1_5 = l_1_0._icon_panel
			l_1_5, l_1_6 = l_1_5:set_righttop, l_1_5
			l_1_5(l_1_6, l_1_0._x, l_1_0._y)
			l_1_5 = l_1_0._icon_panel
			l_1_5, l_1_6 = l_1_5:x, l_1_5
			l_1_5 = l_1_5(l_1_6)
			l_1_6 = l_1_0._pixels_to_move
			l_1_5 = l_1_5 - l_1_6
			l_1_0._end_position = l_1_5
			l_1_5 = l_1_0._background_texture
			l_1_5, l_1_6 = l_1_5:set_texture_rect, l_1_5
			l_1_5(l_1_6, 512, 0, -512, 128)
			l_1_5 = l_1_0._background_texture
			l_1_5, l_1_6 = l_1_5:rotate, l_1_5
			l_1_5(l_1_6, 180)
		elseif l_1_3 == 4 then
			l_1_5 = l_1_0._y
			l_1_6 = tweak_data
			l_1_6 = l_1_6.player
			l_1_6 = l_1_6.new_hud
			l_1_6 = l_1_6.weapon_selection_panel
			l_1_6 = l_1_6.Y_OFFSET
			l_1_5 = l_1_5 - l_1_6
			l_1_0._y = l_1_5
			l_1_5 = l_1_0._x
			l_1_6 = tweak_data
			l_1_6 = l_1_6.player
			l_1_6 = l_1_6.new_hud
			l_1_6 = l_1_6.weapon_selection_panel
			l_1_6 = l_1_6.X_OFFSET
			l_1_5 = l_1_5 - l_1_6
			l_1_0._x = l_1_5
			l_1_5 = l_1_0._icon_panel
			l_1_5, l_1_6 = l_1_5:set_rightbottom, l_1_5
			l_1_5(l_1_6, l_1_0._x, l_1_0._y)
			l_1_5 = l_1_0._icon_panel
			l_1_5, l_1_6 = l_1_5:x, l_1_5
			l_1_5 = l_1_5(l_1_6)
			l_1_6 = l_1_0._pixels_to_move
			l_1_5 = l_1_5 - l_1_6
			l_1_0._end_position = l_1_5
		else
			l_1_5 = assert
			l_1_6 = false
			l_1_5(l_1_6)
		end
		l_1_5 = l_1_0._icon_panel
		l_1_5, l_1_6 = l_1_5:bitmap, l_1_5
		l_1_5 = l_1_5(l_1_6, {name = l_1_2, texture = l_1_2})
		l_1_0._icon_texture = l_1_5
		l_1_5 = l_1_0._icon_texture
		l_1_5, l_1_6 = l_1_5:set_center_x, l_1_5
		l_1_5(l_1_6, l_1_0._icon_panel:width() / 2)
		l_1_5 = l_1_0._icon_texture
		l_1_5, l_1_6 = l_1_5:set_center_y, l_1_5
		l_1_5(l_1_6, l_1_0._icon_panel:height() / 2)
		l_1_5 = l_1_0._icon_panel
		l_1_5, l_1_6 = l_1_5:x, l_1_5
		l_1_5 = l_1_5(l_1_6)
		l_1_0._x = l_1_5
		l_1_5 = l_1_0._icon_panel
		l_1_5, l_1_6 = l_1_5:y, l_1_5
		l_1_5 = l_1_5(l_1_6)
		l_1_0._y = l_1_5
		l_1_5, l_1_6 = l_1_0:set_alpha, l_1_0
		l_1_5(l_1_6, 0)
		l_1_5 = FiniteStateMachine
		l_1_5, l_1_6 = l_1_5:new, l_1_5
		l_1_5 = l_1_5(l_1_6, l_1_0, "_icon", IconIdleState)
		l_1_0._state = l_1_5
		l_1_5 = l_1_0._state
		l_1_5, l_1_6 = l_1_5:set_debug, l_1_5
		l_1_5(l_1_6, false)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WeaponSelectionIcon.set_weapon_icon = function(l_2_0, l_2_1)
	if l_2_1 ~= l_2_0._icon_texture_name then
		l_2_0._icon_texture:set_image(l_2_1)
		l_2_0._icon_texture_name = l_2_1
	end
end

WeaponSelectionIcon.reset_position = function(l_3_0)
	l_3_0:set_position(l_3_0:get_start_position())
end

WeaponSelectionIcon.get_end_position = function(l_4_0)
	return l_4_0._end_position
end

WeaponSelectionIcon.get_current_position = function(l_5_0)
	local l_5_1, l_5_2 = l_5_0._icon_panel:x, l_5_0._icon_panel
	return l_5_1(l_5_2)
end

WeaponSelectionIcon.get_start_position = function(l_6_0)
	return l_6_0._x
end

WeaponSelectionIcon.set_position = function(l_7_0, l_7_1)
	l_7_0._icon_panel:set_x(l_7_1)
end

WeaponSelectionIcon.get_alpha = function(l_8_0)
	return l_8_0._alpha
end

WeaponSelectionIcon.set_alpha = function(l_9_0, l_9_1)
	l_9_0._alpha = l_9_1
	l_9_0._background_texture:set_color(l_9_0._background_texture:color():with_alpha(l_9_0._alpha))
	l_9_0._icon_texture:set_color(l_9_0._icon_texture:color():with_alpha(l_9_0._alpha))
end

WeaponSelectionIcon.wants_to_move_out = function(l_10_0)
	return l_10_0._wants_to_move_out
end

WeaponSelectionIcon.wants_to_move_in = function(l_11_0)
	return l_11_0._wants_to_move_in
end

WeaponSelectionIcon.wants_to_idle = function(l_12_0)
	return l_12_0._wants_to_idle
end

WeaponSelectionIcon.wants_to_hide = function(l_13_0)
	return l_13_0._wants_to_hide
end

WeaponSelectionIcon.wants_to_blink = function(l_14_0)
	return l_14_0._wants_to_blink
end

WeaponSelectionIcon.default_select = function(l_15_0)
	l_15_0._default_selected = true
end

WeaponSelectionIcon.clear_default_select = function(l_16_0)
	l_16_0._default_selected = false
end

WeaponSelectionIcon.is_default_selected = function(l_17_0)
	return l_17_0._default_selected
end

WeaponSelectionIcon.select = function(l_18_0)
	l_18_0:_all_states_false()
	l_18_0._wants_to_move_out = true
end

WeaponSelectionIcon.unselect = function(l_19_0)
	l_19_0:_all_states_false()
	l_19_0._wants_to_move_in = true
end

WeaponSelectionIcon.idle = function(l_20_0)
	l_20_0:_all_states_false()
	l_20_0._wants_to_idle = true
end

WeaponSelectionIcon.hide = function(l_21_0)
	l_21_0:_all_states_false()
	l_21_0._wants_to_hide = true
end

WeaponSelectionIcon.blink = function(l_22_0)
	l_22_0:_all_states_false()
	l_22_0._wants_to_blink = true
end

WeaponSelectionIcon._all_states_false = function(l_23_0)
	l_23_0._wants_to_blink = false
	l_23_0._wants_to_hide = false
	l_23_0._wants_to_move_in = false
	l_23_0._wants_to_move_out = false
	l_23_0._wants_to_idle = false
end

WeaponSelectionIcon.get_selected_icon_fade_in_speed = function(l_24_0)
	return tweak_data.player.new_hud.weapon_selection_panel.SELECTED_ICON_FADE_IN_SPEED
end

WeaponSelectionIcon.get_selected_icon_fade_out_speed = function(l_25_0)
	return tweak_data.player.new_hud.weapon_selection_panel.SELECTED_ICON_FADE_OUT_SPEED
end

WeaponSelectionIcon.get_selected_icon_move_in_speed = function(l_26_0)
	return tweak_data.player.new_hud.weapon_selection_panel.SELECTED_ICON_MOVE_SPEED
end

WeaponSelectionIcon.get_selected_icon_move_out_speed = function(l_27_0)
	return tweak_data.player.new_hud.weapon_selection_panel.SELECTED_ICON_MOVE_SPEED
end

WeaponSelectionIcon.get_move_in_alpha_target = function(l_28_0)
	return tweak_data.player.new_hud.weapon_selection_panel.INACTIVE_ICON_ALPHA
end

WeaponSelectionIcon.get_move_out_alpha_target = function(l_29_0)
	return 1
end

WeaponSelectionIcon.get_selected_icon_blink_speed = function(l_30_0)
	return tweak_data.player.new_hud.weapon_selection_panel.SELECTED_ICON_BLINK_SPEED
end

WeaponSelectionIcon.get_selected_icon_blink_times = function(l_31_0)
	return tweak_data.player.new_hud.weapon_selection_panel.SELECTED_ICON_BLINK_TIMES
end

WeaponSelectionIcon.update = function(l_32_0, l_32_1)
	l_32_0._state:update(l_32_1)
end


