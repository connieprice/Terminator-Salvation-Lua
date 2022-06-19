require("units/beings/player/new_gui/IconStates")
if not ReticulePiece then
	ReticulePiece = class()
end
ReticulePiece.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	l_1_0._parent_panel = l_1_1
	l_1_0._piece_index = l_1_2
	do
		l_1_0._reticule_type = l_1_3 or "circle_reticule"
		l_1_0._on_rail = l_1_4
		l_1_0._width = l_1_0._parent_panel:width()
		l_1_0._height = l_1_0._parent_panel:height()
		l_1_0._centre_x = l_1_0._width / 2
		l_1_0._centre_y = l_1_0._height / 2
		if l_1_0._on_rail then
			l_1_0:_set_up_on_rail_variables()
		else
			l_1_0:_set_up_on_foot_variables()
		end
		if l_1_0._reticule_type == "circle_reticule" then
			l_1_0:_set_up_circle_reticule_piece()
		elseif l_1_0._reticule_type == "trajectory_reticule" then
			l_1_0:_set_up_trajectory_reticule_piece()
		elseif l_1_0._reticule_type == "circular_trajectory_reticule" then
			l_1_0:_set_up_circular_trajectory_reticule_piece()
		else
			assert(false)
		end
		l_1_0._state = FiniteStateMachine:new(l_1_0, "_icon", IconIdleState)
		l_1_0._state:set_debug(true)
		l_1_0:set_alpha(0)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ReticulePiece._set_up_on_foot_variables = function(l_2_0)
	if l_2_0._reticule_type == "circle_reticule" then
		l_2_0._pixels_to_move = tweak_data.player.new_hud.reticule_panel.circle_reticule.PIXELS_TO_MOVE
		l_2_0._radius = tweak_data.player.new_hud.reticule_panel.circle_reticule.RADIUS
	elseif l_2_0._reticule_type == "trajectory_reticule" then
		l_2_0._pixels_to_move = tweak_data.player.new_hud.reticule_panel.trajectory_reticule.PIXELS_TO_MOVE
		l_2_0._radius = tweak_data.player.new_hud.reticule_panel.trajectory_reticule.RADIUS
	elseif l_2_0._reticule_type == "circular_trajectory_reticule" then
		l_2_0._pixels_to_move = tweak_data.player.new_hud.reticule_panel.circular_trajectory_reticule.PIXELS_TO_MOVE
		l_2_0._radius = tweak_data.player.new_hud.reticule_panel.circular_trajectory_reticule.RADIUS
	end
	l_2_0._fade_in_speed = tweak_data.player.new_hud.reticule_panel.on_foot.FADE_IN_SPEED
	l_2_0._fade_out_speed = tweak_data.player.new_hud.reticule_panel.on_foot.FADE_OUT_SPEED
	l_2_0._move_in_speed = tweak_data.player.new_hud.reticule_panel.on_foot.MOVE_IN_SPEED
	l_2_0._move_out_speed = tweak_data.player.new_hud.reticule_panel.on_foot.MOVE_OUT_SPEED
end

ReticulePiece._set_up_on_rail_variables = function(l_3_0)
	if l_3_0._reticule_type == "circle_reticule" then
		l_3_0._pixels_to_move = tweak_data.player.new_hud.reticule_panel.circle_reticule.PIXELS_TO_MOVE + tweak_data.player.new_hud.reticule_panel.on_rail.RADIUS_OFFSET
		l_3_0._radius = tweak_data.player.new_hud.reticule_panel.circle_reticule.RADIUS + tweak_data.player.new_hud.reticule_panel.on_rail.RADIUS_OFFSET
	elseif l_3_0._reticule_type == "trajectory_reticule" then
		l_3_0._pixels_to_move = tweak_data.player.new_hud.reticule_panel.trajectory_reticule.PIXELS_TO_MOVE + tweak_data.player.new_hud.reticule_panel.on_rail.RADIUS_OFFSET
		l_3_0._radius = tweak_data.player.new_hud.reticule_panel.trajectory_reticule.RADIUS + tweak_data.player.new_hud.reticule_panel.on_rail.RADIUS_OFFSET
	elseif l_3_0._reticule_type == "circular_trajectory_reticule" then
		l_3_0._pixels_to_move = tweak_data.player.new_hud.reticule_panel.circular_trajectory_reticule.PIXELS_TO_MOVE + tweak_data.player.new_hud.reticule_panel.on_rail.RADIUS_OFFSET
		l_3_0._radius = tweak_data.player.new_hud.reticule_panel.circular_trajectory_reticule.RADIUS + tweak_data.player.new_hud.reticule_panel.on_rail.RADIUS_OFFSET
	end
	l_3_0._fade_in_speed = tweak_data.player.new_hud.reticule_panel.on_rail.FADE_IN_SPEED
	l_3_0._fade_out_speed = tweak_data.player.new_hud.reticule_panel.on_rail.FADE_OUT_SPEED
	l_3_0._move_in_speed = tweak_data.player.new_hud.reticule_panel.on_rail.MOVE_IN_SPEED
	l_3_0._move_out_speed = tweak_data.player.new_hud.reticule_panel.on_rail.MOVE_OUT_SPEED
end

ReticulePiece._set_up_circle_reticule_piece = function(l_4_0)
	local l_4_1, l_4_2 = l_4_0._parent_panel:bitmap, l_4_0._parent_panel
	local l_4_3 = {}
	l_4_3.name = "reticule_top_normal"
	l_4_3.texture = "gui_reticule_top_normal"
	l_4_1 = l_4_1(l_4_2, l_4_3)
	l_4_0._reticule_piece_texture = l_4_1
	l_4_1 = l_4_0._piece_index
	if l_4_1 == "top" then
		l_4_1, l_4_2 = l_4_0:_set_angle, l_4_0
		l_4_3 = 0
		l_4_1(l_4_2, l_4_3)
	else
		l_4_1 = l_4_0._piece_index
		if l_4_1 == "right" then
			l_4_1, l_4_2 = l_4_0:_set_angle, l_4_0
			l_4_3 = 90
			l_4_1(l_4_2, l_4_3)
		end
	else
		l_4_1 = l_4_0._piece_index
		if l_4_1 == "bottom" then
			l_4_1, l_4_2 = l_4_0:_set_angle, l_4_0
			l_4_3 = 180
			l_4_1(l_4_2, l_4_3)
		end
	else
		l_4_1 = l_4_0._piece_index
		if l_4_1 == "left" then
			l_4_1, l_4_2 = l_4_0:_set_angle, l_4_0
			l_4_3 = 270
			l_4_1(l_4_2, l_4_3)
		end
	else
		l_4_1 = assert
		l_4_2 = false
		l_4_1(l_4_2)
	end
end

ReticulePiece._set_up_trajectory_reticule_piece = function(l_5_0)
	if l_5_0._piece_index == "right" then
		local l_5_1, l_5_2 = l_5_0._parent_panel:bitmap, l_5_0._parent_panel
		local l_5_3 = {}
		l_5_3.name = "reticule_right"
		l_5_3.texture = "gui_granade_short_thin"
		l_5_1 = l_5_1(l_5_2, l_5_3)
		l_5_0._reticule_piece_texture = l_5_1
		l_5_1 = l_5_0._reticule_piece_texture
		l_5_1, l_5_2 = l_5_1:rotate, l_5_1
		l_5_3 = 90
		l_5_1(l_5_2, l_5_3)
		l_5_1, l_5_2 = l_5_0:_set_angle, l_5_0
		l_5_3 = 90
		l_5_1(l_5_2, l_5_3)
	elseif l_5_0._piece_index == "bottom" then
		local l_5_4, l_5_5 = l_5_0._parent_panel:bitmap, l_5_0._parent_panel
		local l_5_6 = {}
		l_5_6.name = "reticule_bottom"
		l_5_6.texture = "gui_granade_long_full"
		l_5_4 = l_5_4(l_5_5, l_5_6)
		l_5_0._reticule_piece_texture = l_5_4
		l_5_4 = l_5_0._reticule_piece_texture
		l_5_4, l_5_5 = l_5_4:rotate, l_5_4
		l_5_6 = 180
		l_5_4(l_5_5, l_5_6)
		l_5_4 = l_5_0._radius
		l_5_4 = l_5_4 + 25
		l_5_0._radius = l_5_4
		l_5_4, l_5_5 = l_5_0:_set_angle, l_5_0
		l_5_6 = 180
		l_5_4(l_5_5, l_5_6)
	elseif l_5_0._piece_index == "left" then
		local l_5_7, l_5_8 = l_5_0._parent_panel:bitmap, l_5_0._parent_panel
		local l_5_9 = {}
		l_5_9.name = "reticule_left"
		l_5_9.texture = "gui_granade_short_thin"
		l_5_7 = l_5_7(l_5_8, l_5_9)
		l_5_0._reticule_piece_texture = l_5_7
		l_5_7 = l_5_0._reticule_piece_texture
		l_5_7, l_5_8 = l_5_7:rotate, l_5_7
		l_5_9 = 90
		l_5_7(l_5_8, l_5_9)
		l_5_7, l_5_8 = l_5_0:_set_angle, l_5_0
		l_5_9 = 270
		l_5_7(l_5_8, l_5_9)
	else
		assert(false)
	end
end

ReticulePiece._set_up_circular_trajectory_reticule_piece = function(l_6_0)
	if l_6_0._piece_index == "bottom" then
		local l_6_1, l_6_2 = l_6_0._parent_panel:bitmap, l_6_0._parent_panel
		local l_6_3 = {}
		l_6_3.name = "reticule_bottom"
		l_6_3.texture = "gui_crosshair_grenadelauncher"
		l_6_1 = l_6_1(l_6_2, l_6_3)
		l_6_0._reticule_piece_texture = l_6_1
		l_6_1 = l_6_0._reticule_piece_texture
		l_6_1, l_6_2 = l_6_1:rotate, l_6_1
		l_6_3 = 180
		l_6_1(l_6_2, l_6_3)
		l_6_1 = l_6_0._radius
		l_6_0._radius = l_6_1
		l_6_1, l_6_2 = l_6_0:_set_angle, l_6_0
		l_6_3 = 180
		l_6_1(l_6_2, l_6_3)
	else
		assert(false)
	end
end

ReticulePiece.use_red_reticule = function(l_7_0)
	if l_7_0._reticule_type == "circle_reticule" and not l_7_0._red_reticule then
		l_7_0._reticule_piece_texture:set_image("gui_reticule_top_enemy")
		l_7_0._red_reticule = true
	end
end

ReticulePiece.use_normal_reticule = function(l_8_0)
	if l_8_0._reticule_type == "circle_reticule" and l_8_0._red_reticule then
		l_8_0._reticule_piece_texture:set_image("gui_reticule_top_normal")
		l_8_0._red_reticule = false
	end
end

ReticulePiece._set_angle = function(l_9_0, l_9_1)
	local l_9_2 = l_9_0._centre_x + l_9_0._radius * math.cos(l_9_1 - 90)
	local l_9_3 = l_9_0._centre_y + l_9_0._radius * math.sin(l_9_1 - 90)
	l_9_0._current_angle = l_9_1
	l_9_0._current_radius = l_9_0._radius
	l_9_0._reticule_piece_texture:rotate(l_9_1)
	l_9_0._reticule_piece_texture:set_center(l_9_2, l_9_3)
end

ReticulePiece.reset_position = function(l_10_0)
	l_10_0:set_position(l_10_0._radius - l_10_0._pixels_to_move)
end

ReticulePiece.get_end_position = function(l_11_0)
	return l_11_0._radius
end

ReticulePiece.get_current_position = function(l_12_0)
	return l_12_0._current_radius
end

ReticulePiece.get_start_position = function(l_13_0)
	return l_13_0._radius - l_13_0._pixels_to_move
end

ReticulePiece.set_position = function(l_14_0, l_14_1)
	l_14_0._current_radius = l_14_1
	local l_14_2 = l_14_0._centre_x + l_14_0._current_radius * math.cos(l_14_0._current_angle - 90)
	local l_14_3 = l_14_0._centre_y + l_14_0._current_radius * math.sin(l_14_0._current_angle - 90)
	l_14_0._reticule_piece_texture:set_center(l_14_2, l_14_3)
end

ReticulePiece.get_alpha = function(l_15_0)
	return l_15_0._alpha
end

ReticulePiece.set_alpha = function(l_16_0, l_16_1)
	l_16_0._alpha = l_16_1
	l_16_0._reticule_piece_texture:set_color(l_16_0._reticule_piece_texture:color():with_alpha(l_16_0._alpha))
end

ReticulePiece.set_instant_hide = function(l_17_0)
	l_17_0.instant_hide = true
end

ReticulePiece.wants_to_move_out = function(l_18_0)
	return l_18_0._wants_to_move_out
end

ReticulePiece.wants_to_move_in = function(l_19_0)
	return l_19_0._wants_to_move_in
end

ReticulePiece.wants_to_idle = function(l_20_0)
	return l_20_0._wants_to_idle
end

ReticulePiece.wants_to_hide = function(l_21_0)
	return l_21_0._wants_to_hide
end

ReticulePiece.wants_to_blink = function(l_22_0)
	return l_22_0._wants_to_blink
end

ReticulePiece.is_default_selected = function(l_23_0)
	return false
end

ReticulePiece.move_out = function(l_24_0)
	l_24_0:_all_states_false()
	l_24_0._wants_to_move_out = true
end

ReticulePiece.move_in = function(l_25_0)
	l_25_0:_all_states_false()
	l_25_0._wants_to_move_in = true
	l_25_0.instant_hide = false
end

ReticulePiece.idle = function(l_26_0)
	l_26_0:_all_states_false()
	l_26_0._wants_to_idle = true
end

ReticulePiece.hide = function(l_27_0)
	l_27_0:_all_states_false()
	l_27_0._wants_to_hide = true
	l_27_0.instant_hide = false
end

ReticulePiece._all_states_false = function(l_28_0)
	l_28_0._wants_to_blink = false
	l_28_0._wants_to_hide = false
	l_28_0._wants_to_move_in = false
	l_28_0._wants_to_move_out = false
	l_28_0._wants_to_idle = false
end

ReticulePiece.get_selected_icon_fade_in_speed = function(l_29_0)
	return l_29_0._fade_in_speed
end

ReticulePiece.get_selected_icon_fade_out_speed = function(l_30_0)
	return l_30_0._fade_out_speed
end

ReticulePiece.get_selected_icon_move_in_speed = function(l_31_0)
	return l_31_0._move_in_speed
end

ReticulePiece.get_selected_icon_move_out_speed = function(l_32_0)
	return l_32_0._move_out_speed
end

ReticulePiece.get_move_in_alpha_target = function(l_33_0)
	return 1
end

ReticulePiece.get_move_out_alpha_target = function(l_34_0)
	return 0
end

ReticulePiece.update = function(l_35_0, l_35_1, l_35_2)
	if l_35_2 then
		l_35_0:use_red_reticule()
	else
		l_35_0:use_normal_reticule()
	end
	l_35_0._state:update(l_35_1)
end


