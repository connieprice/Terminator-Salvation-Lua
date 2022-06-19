require("units/beings/player/new_gui/IconStates")
ReticulePiece = ReticulePiece or class()
function ReticulePiece.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	A0_0._parent_panel = A1_1
	A0_0._piece_index = A2_2
	A0_0._reticule_type = A3_3 or "circle_reticule"
	A0_0._on_rail = A4_4
	A0_0._width = A0_0._parent_panel:width()
	A0_0._height = A0_0._parent_panel:height()
	A0_0._centre_x = A0_0._width / 2
	A0_0._centre_y = A0_0._height / 2
	if A0_0._on_rail then
		A0_0:_set_up_on_rail_variables()
	else
		A0_0:_set_up_on_foot_variables()
	end
	if A0_0._reticule_type == "circle_reticule" then
		A0_0:_set_up_circle_reticule_piece()
	elseif A0_0._reticule_type == "trajectory_reticule" then
		A0_0:_set_up_trajectory_reticule_piece()
	elseif A0_0._reticule_type == "circular_trajectory_reticule" then
		A0_0:_set_up_circular_trajectory_reticule_piece()
	else
		assert(false)
	end
	A0_0._state = FiniteStateMachine:new(A0_0, "_icon", IconIdleState)
	A0_0._state:set_debug(true)
	A0_0:set_alpha(0)
end
function ReticulePiece._set_up_on_foot_variables(A0_5)
	local L1_6
	L1_6 = A0_5._reticule_type
	if L1_6 == "circle_reticule" then
		L1_6 = tweak_data
		L1_6 = L1_6.player
		L1_6 = L1_6.new_hud
		L1_6 = L1_6.reticule_panel
		L1_6 = L1_6.circle_reticule
		L1_6 = L1_6.PIXELS_TO_MOVE
		A0_5._pixels_to_move = L1_6
		L1_6 = tweak_data
		L1_6 = L1_6.player
		L1_6 = L1_6.new_hud
		L1_6 = L1_6.reticule_panel
		L1_6 = L1_6.circle_reticule
		L1_6 = L1_6.RADIUS
		A0_5._radius = L1_6
	else
		L1_6 = A0_5._reticule_type
		if L1_6 == "trajectory_reticule" then
			L1_6 = tweak_data
			L1_6 = L1_6.player
			L1_6 = L1_6.new_hud
			L1_6 = L1_6.reticule_panel
			L1_6 = L1_6.trajectory_reticule
			L1_6 = L1_6.PIXELS_TO_MOVE
			A0_5._pixels_to_move = L1_6
			L1_6 = tweak_data
			L1_6 = L1_6.player
			L1_6 = L1_6.new_hud
			L1_6 = L1_6.reticule_panel
			L1_6 = L1_6.trajectory_reticule
			L1_6 = L1_6.RADIUS
			A0_5._radius = L1_6
		else
			L1_6 = A0_5._reticule_type
			if L1_6 == "circular_trajectory_reticule" then
				L1_6 = tweak_data
				L1_6 = L1_6.player
				L1_6 = L1_6.new_hud
				L1_6 = L1_6.reticule_panel
				L1_6 = L1_6.circular_trajectory_reticule
				L1_6 = L1_6.PIXELS_TO_MOVE
				A0_5._pixels_to_move = L1_6
				L1_6 = tweak_data
				L1_6 = L1_6.player
				L1_6 = L1_6.new_hud
				L1_6 = L1_6.reticule_panel
				L1_6 = L1_6.circular_trajectory_reticule
				L1_6 = L1_6.RADIUS
				A0_5._radius = L1_6
			end
		end
	end
	L1_6 = tweak_data
	L1_6 = L1_6.player
	L1_6 = L1_6.new_hud
	L1_6 = L1_6.reticule_panel
	L1_6 = L1_6.on_foot
	L1_6 = L1_6.FADE_IN_SPEED
	A0_5._fade_in_speed = L1_6
	L1_6 = tweak_data
	L1_6 = L1_6.player
	L1_6 = L1_6.new_hud
	L1_6 = L1_6.reticule_panel
	L1_6 = L1_6.on_foot
	L1_6 = L1_6.FADE_OUT_SPEED
	A0_5._fade_out_speed = L1_6
	L1_6 = tweak_data
	L1_6 = L1_6.player
	L1_6 = L1_6.new_hud
	L1_6 = L1_6.reticule_panel
	L1_6 = L1_6.on_foot
	L1_6 = L1_6.MOVE_IN_SPEED
	A0_5._move_in_speed = L1_6
	L1_6 = tweak_data
	L1_6 = L1_6.player
	L1_6 = L1_6.new_hud
	L1_6 = L1_6.reticule_panel
	L1_6 = L1_6.on_foot
	L1_6 = L1_6.MOVE_OUT_SPEED
	A0_5._move_out_speed = L1_6
end
function ReticulePiece._set_up_on_rail_variables(A0_7)
	local L1_8, L2_9
	L1_8 = A0_7._reticule_type
	if L1_8 == "circle_reticule" then
		L1_8 = tweak_data
		L1_8 = L1_8.player
		L1_8 = L1_8.new_hud
		L1_8 = L1_8.reticule_panel
		L1_8 = L1_8.circle_reticule
		L1_8 = L1_8.PIXELS_TO_MOVE
		L2_9 = tweak_data
		L2_9 = L2_9.player
		L2_9 = L2_9.new_hud
		L2_9 = L2_9.reticule_panel
		L2_9 = L2_9.on_rail
		L2_9 = L2_9.RADIUS_OFFSET
		L1_8 = L1_8 + L2_9
		A0_7._pixels_to_move = L1_8
		L1_8 = tweak_data
		L1_8 = L1_8.player
		L1_8 = L1_8.new_hud
		L1_8 = L1_8.reticule_panel
		L1_8 = L1_8.circle_reticule
		L1_8 = L1_8.RADIUS
		L2_9 = tweak_data
		L2_9 = L2_9.player
		L2_9 = L2_9.new_hud
		L2_9 = L2_9.reticule_panel
		L2_9 = L2_9.on_rail
		L2_9 = L2_9.RADIUS_OFFSET
		L1_8 = L1_8 + L2_9
		A0_7._radius = L1_8
	else
		L1_8 = A0_7._reticule_type
		if L1_8 == "trajectory_reticule" then
			L1_8 = tweak_data
			L1_8 = L1_8.player
			L1_8 = L1_8.new_hud
			L1_8 = L1_8.reticule_panel
			L1_8 = L1_8.trajectory_reticule
			L1_8 = L1_8.PIXELS_TO_MOVE
			L2_9 = tweak_data
			L2_9 = L2_9.player
			L2_9 = L2_9.new_hud
			L2_9 = L2_9.reticule_panel
			L2_9 = L2_9.on_rail
			L2_9 = L2_9.RADIUS_OFFSET
			L1_8 = L1_8 + L2_9
			A0_7._pixels_to_move = L1_8
			L1_8 = tweak_data
			L1_8 = L1_8.player
			L1_8 = L1_8.new_hud
			L1_8 = L1_8.reticule_panel
			L1_8 = L1_8.trajectory_reticule
			L1_8 = L1_8.RADIUS
			L2_9 = tweak_data
			L2_9 = L2_9.player
			L2_9 = L2_9.new_hud
			L2_9 = L2_9.reticule_panel
			L2_9 = L2_9.on_rail
			L2_9 = L2_9.RADIUS_OFFSET
			L1_8 = L1_8 + L2_9
			A0_7._radius = L1_8
		else
			L1_8 = A0_7._reticule_type
			if L1_8 == "circular_trajectory_reticule" then
				L1_8 = tweak_data
				L1_8 = L1_8.player
				L1_8 = L1_8.new_hud
				L1_8 = L1_8.reticule_panel
				L1_8 = L1_8.circular_trajectory_reticule
				L1_8 = L1_8.PIXELS_TO_MOVE
				L2_9 = tweak_data
				L2_9 = L2_9.player
				L2_9 = L2_9.new_hud
				L2_9 = L2_9.reticule_panel
				L2_9 = L2_9.on_rail
				L2_9 = L2_9.RADIUS_OFFSET
				L1_8 = L1_8 + L2_9
				A0_7._pixels_to_move = L1_8
				L1_8 = tweak_data
				L1_8 = L1_8.player
				L1_8 = L1_8.new_hud
				L1_8 = L1_8.reticule_panel
				L1_8 = L1_8.circular_trajectory_reticule
				L1_8 = L1_8.RADIUS
				L2_9 = tweak_data
				L2_9 = L2_9.player
				L2_9 = L2_9.new_hud
				L2_9 = L2_9.reticule_panel
				L2_9 = L2_9.on_rail
				L2_9 = L2_9.RADIUS_OFFSET
				L1_8 = L1_8 + L2_9
				A0_7._radius = L1_8
			end
		end
	end
	L1_8 = tweak_data
	L1_8 = L1_8.player
	L1_8 = L1_8.new_hud
	L1_8 = L1_8.reticule_panel
	L1_8 = L1_8.on_rail
	L1_8 = L1_8.FADE_IN_SPEED
	A0_7._fade_in_speed = L1_8
	L1_8 = tweak_data
	L1_8 = L1_8.player
	L1_8 = L1_8.new_hud
	L1_8 = L1_8.reticule_panel
	L1_8 = L1_8.on_rail
	L1_8 = L1_8.FADE_OUT_SPEED
	A0_7._fade_out_speed = L1_8
	L1_8 = tweak_data
	L1_8 = L1_8.player
	L1_8 = L1_8.new_hud
	L1_8 = L1_8.reticule_panel
	L1_8 = L1_8.on_rail
	L1_8 = L1_8.MOVE_IN_SPEED
	A0_7._move_in_speed = L1_8
	L1_8 = tweak_data
	L1_8 = L1_8.player
	L1_8 = L1_8.new_hud
	L1_8 = L1_8.reticule_panel
	L1_8 = L1_8.on_rail
	L1_8 = L1_8.MOVE_OUT_SPEED
	A0_7._move_out_speed = L1_8
end
function ReticulePiece._set_up_circle_reticule_piece(A0_10)
	A0_10._reticule_piece_texture = A0_10._parent_panel:bitmap({
		name = "reticule_top_normal",
		texture = "gui_reticule_top_normal"
	})
	if A0_10._piece_index == "top" then
		A0_10:_set_angle(0)
	elseif A0_10._piece_index == "right" then
		A0_10:_set_angle(90)
	elseif A0_10._piece_index == "bottom" then
		A0_10:_set_angle(180)
	elseif A0_10._piece_index == "left" then
		A0_10:_set_angle(270)
	else
		assert(false)
	end
end
function ReticulePiece._set_up_trajectory_reticule_piece(A0_11)
	if A0_11._piece_index == "right" then
		A0_11._reticule_piece_texture = A0_11._parent_panel:bitmap({
			name = "reticule_right",
			texture = "gui_granade_short_thin"
		})
		A0_11._reticule_piece_texture:rotate(90)
		A0_11:_set_angle(90)
	elseif A0_11._piece_index == "bottom" then
		A0_11._reticule_piece_texture = A0_11._parent_panel:bitmap({
			name = "reticule_bottom",
			texture = "gui_granade_long_full"
		})
		A0_11._reticule_piece_texture:rotate(180)
		A0_11._radius = A0_11._radius + 25
		A0_11:_set_angle(180)
	elseif A0_11._piece_index == "left" then
		A0_11._reticule_piece_texture = A0_11._parent_panel:bitmap({
			name = "reticule_left",
			texture = "gui_granade_short_thin"
		})
		A0_11._reticule_piece_texture:rotate(90)
		A0_11:_set_angle(270)
	else
		assert(false)
	end
end
function ReticulePiece._set_up_circular_trajectory_reticule_piece(A0_12)
	if A0_12._piece_index == "bottom" then
		A0_12._reticule_piece_texture = A0_12._parent_panel:bitmap({
			name = "reticule_bottom",
			texture = "gui_crosshair_grenadelauncher"
		})
		A0_12._reticule_piece_texture:rotate(180)
		A0_12._radius = A0_12._radius
		A0_12:_set_angle(180)
	else
		assert(false)
	end
end
function ReticulePiece.use_red_reticule(A0_13)
	if A0_13._reticule_type == "circle_reticule" and not A0_13._red_reticule then
		A0_13._reticule_piece_texture:set_image("gui_reticule_top_enemy")
		A0_13._red_reticule = true
	end
end
function ReticulePiece.use_normal_reticule(A0_14)
	if A0_14._reticule_type == "circle_reticule" and A0_14._red_reticule then
		A0_14._reticule_piece_texture:set_image("gui_reticule_top_normal")
		A0_14._red_reticule = false
	end
end
function ReticulePiece._set_angle(A0_15, A1_16)
	local L2_17, L3_18
	L2_17 = A0_15._centre_x
	L3_18 = A0_15._radius
	L3_18 = L3_18 * math.cos(A1_16 - 90)
	L2_17 = L2_17 + L3_18
	L3_18 = A0_15._centre_y
	L3_18 = L3_18 + A0_15._radius * math.sin(A1_16 - 90)
	A0_15._current_angle = A1_16
	A0_15._current_radius = A0_15._radius
	A0_15._reticule_piece_texture:rotate(A1_16)
	A0_15._reticule_piece_texture:set_center(L2_17, L3_18)
end
function ReticulePiece.reset_position(A0_19)
	A0_19:set_position(A0_19._radius - A0_19._pixels_to_move)
end
function ReticulePiece.get_end_position(A0_20)
	local L1_21
	L1_21 = A0_20._radius
	return L1_21
end
function ReticulePiece.get_current_position(A0_22)
	local L1_23
	L1_23 = A0_22._current_radius
	return L1_23
end
function ReticulePiece.get_start_position(A0_24)
	return A0_24._radius - A0_24._pixels_to_move
end
function ReticulePiece.set_position(A0_25, A1_26)
	local L2_27, L3_28
	A0_25._current_radius = A1_26
	L2_27 = A0_25._centre_x
	L3_28 = A0_25._current_radius
	L3_28 = L3_28 * math.cos(A0_25._current_angle - 90)
	L2_27 = L2_27 + L3_28
	L3_28 = A0_25._centre_y
	L3_28 = L3_28 + A0_25._current_radius * math.sin(A0_25._current_angle - 90)
	A0_25._reticule_piece_texture:set_center(L2_27, L3_28)
end
function ReticulePiece.get_alpha(A0_29)
	local L1_30
	L1_30 = A0_29._alpha
	return L1_30
end
function ReticulePiece.set_alpha(A0_31, A1_32)
	local L3_33
	A0_31._alpha = A1_32
	L3_33 = A0_31._reticule_piece_texture
	L3_33 = L3_33.set_color
	L3_33(L3_33, A0_31._reticule_piece_texture:color():with_alpha(A0_31._alpha))
end
function ReticulePiece.set_instant_hide(A0_34)
	local L1_35
	A0_34.instant_hide = true
end
function ReticulePiece.wants_to_move_out(A0_36)
	local L1_37
	L1_37 = A0_36._wants_to_move_out
	return L1_37
end
function ReticulePiece.wants_to_move_in(A0_38)
	local L1_39
	L1_39 = A0_38._wants_to_move_in
	return L1_39
end
function ReticulePiece.wants_to_idle(A0_40)
	local L1_41
	L1_41 = A0_40._wants_to_idle
	return L1_41
end
function ReticulePiece.wants_to_hide(A0_42)
	local L1_43
	L1_43 = A0_42._wants_to_hide
	return L1_43
end
function ReticulePiece.wants_to_blink(A0_44)
	local L1_45
	L1_45 = A0_44._wants_to_blink
	return L1_45
end
function ReticulePiece.is_default_selected(A0_46)
	local L1_47
	L1_47 = false
	return L1_47
end
function ReticulePiece.move_out(A0_48)
	A0_48:_all_states_false()
	A0_48._wants_to_move_out = true
end
function ReticulePiece.move_in(A0_49)
	A0_49:_all_states_false()
	A0_49._wants_to_move_in = true
	A0_49.instant_hide = false
end
function ReticulePiece.idle(A0_50)
	A0_50:_all_states_false()
	A0_50._wants_to_idle = true
end
function ReticulePiece.hide(A0_51)
	A0_51:_all_states_false()
	A0_51._wants_to_hide = true
	A0_51.instant_hide = false
end
function ReticulePiece._all_states_false(A0_52)
	local L1_53
	A0_52._wants_to_blink = false
	A0_52._wants_to_hide = false
	A0_52._wants_to_move_in = false
	A0_52._wants_to_move_out = false
	A0_52._wants_to_idle = false
end
function ReticulePiece.get_selected_icon_fade_in_speed(A0_54)
	local L1_55
	L1_55 = A0_54._fade_in_speed
	return L1_55
end
function ReticulePiece.get_selected_icon_fade_out_speed(A0_56)
	local L1_57
	L1_57 = A0_56._fade_out_speed
	return L1_57
end
function ReticulePiece.get_selected_icon_move_in_speed(A0_58)
	local L1_59
	L1_59 = A0_58._move_in_speed
	return L1_59
end
function ReticulePiece.get_selected_icon_move_out_speed(A0_60)
	local L1_61
	L1_61 = A0_60._move_out_speed
	return L1_61
end
function ReticulePiece.get_move_in_alpha_target(A0_62)
	local L1_63
	L1_63 = 1
	return L1_63
end
function ReticulePiece.get_move_out_alpha_target(A0_64)
	local L1_65
	L1_65 = 0
	return L1_65
end
function ReticulePiece.update(A0_66, A1_67, A2_68)
	if A2_68 then
		A0_66:use_red_reticule()
	else
		A0_66:use_normal_reticule()
	end
	A0_66._state:update(A1_67)
end
