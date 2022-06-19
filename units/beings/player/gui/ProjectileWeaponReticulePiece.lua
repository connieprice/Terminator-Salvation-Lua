require("units/beings/player/gui/ProjectileWeaponReticulePieceStates")
ProjectileWeaponReticulePiece = ProjectileWeaponReticulePiece or class()
function ProjectileWeaponReticulePiece.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5)
	A0_0.parent_panel = A1_1
	A0_0._texture = A2_2
	A0_0._start_position_offset_x = A3_3
	A0_0._start_position_offset_y = A4_4
	A0_0._rotate_texture_angle = A5_5
	A0_0._alpha = 0
	A0_0._reticule_piece_texture = A0_0.parent_panel:bitmap({name = A2_2, texture = A2_2})
	A0_0._reticule_piece_texture:set_color(A0_0._reticule_piece_texture:color():with_alpha(A0_0._alpha))
	A0_0._reticule_piece_texture:set_center_x(A0_0.parent_panel:width() / 2 + A3_3)
	A0_0._reticule_piece_texture:set_center_y(A0_0.parent_panel:height() / 2 + A4_4)
	if A0_0._rotate_texture_angle then
		A0_0._reticule_piece_texture:rotate(A0_0._rotate_texture_angle)
	end
	A0_0._state = FiniteStateMachine:new(A0_0, "_reticule_piece", ProjectileWeaponReticulePieceIdleState)
	A0_0._state:set_debug(true)
end
function ProjectileWeaponReticulePiece.set_end_positions(A0_6, A1_7, A2_8)
	local L3_9, L4_10
	L3_9 = {}
	A0_6._end_position = L3_9
	L3_9 = {}
	A0_6._start_position = L3_9
	L3_9 = A0_6._end_position
	L3_9.x = A1_7
	L3_9 = A0_6._end_position
	L3_9.y = A2_8
	L3_9 = A0_6._start_position
	L4_10 = A0_6._start_position_offset_x
	L4_10 = A1_7 + L4_10
	L3_9.x = L4_10
	L3_9 = A0_6._start_position
	L4_10 = A0_6._start_position_offset_y
	L4_10 = A2_8 + L4_10
	L3_9.y = L4_10
end
function ProjectileWeaponReticulePiece.get_end_positions(A0_11)
	local L1_12
	L1_12 = A0_11._end_position
	if not L1_12 then
		L1_12 = nil
		return L1_12, nil
	end
	L1_12 = A0_11._end_position
	L1_12 = L1_12.x
	return L1_12, A0_11._end_position.y
end
function ProjectileWeaponReticulePiece.get_current_positions(A0_13)
	return A0_13._reticule_piece_texture:center_x(), A0_13._reticule_piece_texture:center_y()
end
function ProjectileWeaponReticulePiece.get_start_positions(A0_14)
	local L1_15
	L1_15 = A0_14._start_position
	if not L1_15 then
		L1_15 = nil
		return L1_15, nil
	end
	L1_15 = A0_14._start_position
	L1_15 = L1_15.x
	return L1_15, A0_14._start_position.y
end
function ProjectileWeaponReticulePiece.get_alpha(A0_16)
	local L1_17
	L1_17 = A0_16._alpha
	return L1_17
end
function ProjectileWeaponReticulePiece.set_alpha(A0_18, A1_19)
	local L3_20
	A0_18._alpha = A1_19
	L3_20 = A0_18._reticule_piece_texture
	L3_20 = L3_20.set_color
	L3_20(L3_20, A0_18._reticule_piece_texture:color():with_alpha(A1_19))
end
function ProjectileWeaponReticulePiece.set_position(A0_21, A1_22, A2_23)
	A0_21._reticule_piece_texture:set_center_x(A1_22)
	A0_21._reticule_piece_texture:set_center_y(A2_23)
end
function ProjectileWeaponReticulePiece.wants_to_move_in(A0_24)
	local L1_25
	L1_25 = A0_24._wants_to_move_in
	return L1_25
end
function ProjectileWeaponReticulePiece.wants_to_move_out(A0_26)
	local L1_27
	L1_27 = A0_26._wants_to_move_out
	return L1_27
end
function ProjectileWeaponReticulePiece.move_in(A0_28)
	local L1_29
	A0_28._wants_to_move_in = true
	A0_28._wants_to_move_out = false
end
function ProjectileWeaponReticulePiece.move_out(A0_30)
	local L1_31
	A0_30._wants_to_move_in = false
	A0_30._wants_to_move_out = true
end
function ProjectileWeaponReticulePiece.update(A0_32, A1_33)
	if A0_32._end_position then
		A0_32._state:update(A1_33)
	end
end
