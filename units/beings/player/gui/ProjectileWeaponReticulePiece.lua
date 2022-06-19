require("units/beings/player/gui/ProjectileWeaponReticulePieceStates")
if not ProjectileWeaponReticulePiece then
	ProjectileWeaponReticulePiece = class()
end
ProjectileWeaponReticulePiece.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5)
	l_1_0.parent_panel = l_1_1
	l_1_0._texture = l_1_2
	l_1_0._start_position_offset_x = l_1_3
	l_1_0._start_position_offset_y = l_1_4
	l_1_0._rotate_texture_angle = l_1_5
	l_1_0._alpha = 0
	local l_1_6, l_1_7 = l_1_0.parent_panel:bitmap, l_1_0.parent_panel
	local l_1_8 = {}
	l_1_8.name = l_1_2
	l_1_8.texture = l_1_2
	l_1_6 = l_1_6(l_1_7, l_1_8)
	l_1_0._reticule_piece_texture = l_1_6
	l_1_6 = l_1_0._reticule_piece_texture
	l_1_6, l_1_7 = l_1_6:set_color, l_1_6
	l_1_8 = l_1_0._reticule_piece_texture
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_7, l_1_8)
	l_1_6 = l_1_0._reticule_piece_texture
	l_1_6, l_1_7 = l_1_6:set_center_x, l_1_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_7, l_1_8)
	l_1_6 = l_1_0._reticule_piece_texture
	l_1_6, l_1_7 = l_1_6:set_center_y, l_1_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_7, l_1_8)
	l_1_6 = l_1_0._rotate_texture_angle
	if l_1_6 then
		l_1_6 = l_1_0._reticule_piece_texture
		l_1_6, l_1_7 = l_1_6:rotate, l_1_6
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_6(l_1_7, l_1_8)
	end
	l_1_6 = FiniteStateMachine
	l_1_6, l_1_7 = l_1_6:new, l_1_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6 = l_1_6(l_1_7, l_1_8, "_reticule_piece", ProjectileWeaponReticulePieceIdleState)
	l_1_0._state = l_1_6
	l_1_6 = l_1_0._state
	l_1_6, l_1_7 = l_1_6:set_debug, l_1_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_6(l_1_7, l_1_8)
end

ProjectileWeaponReticulePiece.set_end_positions = function(l_2_0, l_2_1, l_2_2)
	l_2_0._end_position = {}
	l_2_0._start_position = {}
	l_2_0._end_position.x = l_2_1
	l_2_0._end_position.y = l_2_2
	l_2_0._start_position.x = l_2_1 + l_2_0._start_position_offset_x
	l_2_0._start_position.y = l_2_2 + l_2_0._start_position_offset_y
end

ProjectileWeaponReticulePiece.get_end_positions = function(l_3_0)
	if not l_3_0._end_position then
		return nil, nil
	end
	return l_3_0._end_position.x, l_3_0._end_position.y
end

ProjectileWeaponReticulePiece.get_current_positions = function(l_4_0)
	return l_4_0._reticule_piece_texture:center_x(), l_4_0._reticule_piece_texture:center_y()
end

ProjectileWeaponReticulePiece.get_start_positions = function(l_5_0)
	if not l_5_0._start_position then
		return nil, nil
	end
	return l_5_0._start_position.x, l_5_0._start_position.y
end

ProjectileWeaponReticulePiece.get_alpha = function(l_6_0)
	return l_6_0._alpha
end

ProjectileWeaponReticulePiece.set_alpha = function(l_7_0, l_7_1)
	l_7_0._alpha = l_7_1
	l_7_0._reticule_piece_texture:set_color(l_7_0._reticule_piece_texture:color():with_alpha(l_7_1))
end

ProjectileWeaponReticulePiece.set_position = function(l_8_0, l_8_1, l_8_2)
	l_8_0._reticule_piece_texture:set_center_x(l_8_1)
	l_8_0._reticule_piece_texture:set_center_y(l_8_2)
end

ProjectileWeaponReticulePiece.wants_to_move_in = function(l_9_0)
	return l_9_0._wants_to_move_in
end

ProjectileWeaponReticulePiece.wants_to_move_out = function(l_10_0)
	return l_10_0._wants_to_move_out
end

ProjectileWeaponReticulePiece.move_in = function(l_11_0)
	l_11_0._wants_to_move_in = true
	l_11_0._wants_to_move_out = false
end

ProjectileWeaponReticulePiece.move_out = function(l_12_0)
	l_12_0._wants_to_move_in = false
	l_12_0._wants_to_move_out = true
end

ProjectileWeaponReticulePiece.update = function(l_13_0, l_13_1)
	if l_13_0._end_position then
		l_13_0._state:update(l_13_1)
	end
end


