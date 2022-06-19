require("shared/FiniteStateMachine")
if not ProjectileWeaponReticulePieceIdleState then
	ProjectileWeaponReticulePieceIdleState = class()
end
ProjectileWeaponReticulePieceIdleState.transition = function(l_1_0)
	if l_1_0._reticule_piece:wants_to_move_in() then
		return ProjectileWeaponReticulePieceMoveInState
	else
		if l_1_0._reticule_piece:wants_to_move_out() then
			return ProjectileWeaponReticulePieceMoveOutState
		end
	end
end

if not ProjectileWeaponReticulePieceMoveInState then
	ProjectileWeaponReticulePieceMoveInState = class()
end
ProjectileWeaponReticulePieceMoveInState.init = function(l_2_0)
	local l_2_1 = l_2_0._reticule_piece:get_current_positions()
	l_2_0._y = l_2_0._reticule_piece
	l_2_0._x = l_2_1
	l_2_1 = l_2_0._reticule_piece
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._alpha = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._x_interpolator = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._y_interpolator = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_0._alpha_interpolator = l_2_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_2_1(l_2_1, tweak_data.player.hud.PROJECTILE_WEAPON_RETICULE_ALPHA)
end

ProjectileWeaponReticulePieceMoveInState.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._reticule_piece:get_end_positions()
	l_3_0._end_y = l_3_0._reticule_piece
	l_3_0._end_x = l_3_2
	l_3_2 = l_3_0._x_interpolator
	l_3_2(l_3_2, l_3_0._end_x)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_2, l_3_0._end_y)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_2, l_3_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_2, l_3_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_2, l_3_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_3_3 = l_3_0._y_interpolator:value()
	local l_3_4 = l_3_0._alpha_interpolator:value()
	l_3_0._reticule_piece:set_position(l_3_2, l_3_3)
	l_3_0._reticule_piece:set_alpha(l_3_4)
end

ProjectileWeaponReticulePieceMoveInState.transition = function(l_4_0)
	if l_4_0._reticule_piece:wants_to_move_out() then
		return ProjectileWeaponReticulePieceMoveOutState
	end
end

if not ProjectileWeaponReticulePieceMoveOutState then
	ProjectileWeaponReticulePieceMoveOutState = class()
end
ProjectileWeaponReticulePieceMoveOutState.init = function(l_5_0)
	local l_5_1 = l_5_0._reticule_piece:get_current_positions()
	l_5_0._y = l_5_0._reticule_piece
	l_5_0._x = l_5_1
	l_5_1 = l_5_0._reticule_piece
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._alpha = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._x_interpolator = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._y_interpolator = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_0._alpha_interpolator = l_5_1
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_1(l_5_1, 0)
end

ProjectileWeaponReticulePieceMoveOutState.update = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0._reticule_piece:get_start_positions()
	l_6_0._end_y = l_6_0._reticule_piece
	l_6_0._end_x = l_6_2
	l_6_2 = l_6_0._x_interpolator
	l_6_2(l_6_2, l_6_0._end_x)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_2(l_6_2, l_6_0._end_y)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_2(l_6_2, l_6_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_2(l_6_2, l_6_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_2(l_6_2, l_6_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_6_3 = l_6_0._y_interpolator:value()
	local l_6_4 = l_6_0._alpha_interpolator:value()
	l_6_0._reticule_piece:set_position(l_6_2, l_6_3)
	l_6_0._reticule_piece:set_alpha(l_6_4)
end

ProjectileWeaponReticulePieceMoveOutState.transition = function(l_7_0)
	if l_7_0._reticule_piece:wants_to_move_in() then
		return ProjectileWeaponReticulePieceMoveInState
	end
end


