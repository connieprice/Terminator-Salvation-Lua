require("shared/FiniteStateMachine")
ProjectileWeaponReticulePieceIdleState = ProjectileWeaponReticulePieceIdleState or class()
function ProjectileWeaponReticulePieceIdleState.transition(A0_0)
	if A0_0._reticule_piece:wants_to_move_in() then
		return ProjectileWeaponReticulePieceMoveInState
	elseif A0_0._reticule_piece:wants_to_move_out() then
		return ProjectileWeaponReticulePieceMoveOutState
	end
end
ProjectileWeaponReticulePieceMoveInState = ProjectileWeaponReticulePieceMoveInState or class()
function ProjectileWeaponReticulePieceMoveInState.init(A0_1)
	A0_1._x, A0_1._y = A0_1._reticule_piece:get_current_positions()
	A0_1._alpha = A0_1._reticule_piece:get_alpha()
	A0_1._x_interpolator = Interpolator:new(A0_1._x, tweak_data.player.hud.RETICULE_CONTROL_TRANSITION_SCALE_SPEED_IN)
	A0_1._y_interpolator = Interpolator:new(A0_1._y, tweak_data.player.hud.RETICULE_CONTROL_TRANSITION_SCALE_SPEED_IN)
	A0_1._alpha_interpolator = Interpolator:new(A0_1._alpha, tweak_data.player.hud.RETICULE_CONTROL_TRANSITION_FADE_SPEED_IN)
	A0_1._alpha_interpolator:set_target(tweak_data.player.hud.PROJECTILE_WEAPON_RETICULE_ALPHA)
end
function ProjectileWeaponReticulePieceMoveInState.update(A0_2, A1_3)
	local L2_4, L3_5, L4_6
	L2_4 = A0_2._reticule_piece
	L3_5 = L2_4
	L2_4 = L2_4.get_end_positions
	L3_5 = L2_4(L3_5)
	A0_2._end_y = L3_5
	A0_2._end_x = L2_4
	L2_4 = A0_2._x_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.set_target
	L4_6 = A0_2._end_x
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._y_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.set_target
	L4_6 = A0_2._end_y
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._x_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.update
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._y_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.update
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._alpha_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.update
	L4_6 = A1_3
	L2_4(L3_5, L4_6)
	L2_4 = A0_2._x_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.value
	L2_4 = L2_4(L3_5)
	L3_5 = A0_2._y_interpolator
	L4_6 = L3_5
	L3_5 = L3_5.value
	L3_5 = L3_5(L4_6)
	L4_6 = A0_2._alpha_interpolator
	L4_6 = L4_6.value
	L4_6 = L4_6(L4_6)
	A0_2._reticule_piece:set_position(L2_4, L3_5)
	A0_2._reticule_piece:set_alpha(L4_6)
end
function ProjectileWeaponReticulePieceMoveInState.transition(A0_7)
	if A0_7._reticule_piece:wants_to_move_out() then
		return ProjectileWeaponReticulePieceMoveOutState
	end
end
ProjectileWeaponReticulePieceMoveOutState = ProjectileWeaponReticulePieceMoveOutState or class()
function ProjectileWeaponReticulePieceMoveOutState.init(A0_8)
	A0_8._x, A0_8._y = A0_8._reticule_piece:get_current_positions()
	A0_8._alpha = A0_8._reticule_piece:get_alpha()
	A0_8._x_interpolator = Interpolator:new(A0_8._x, tweak_data.player.hud.RETICULE_CONTROL_TRANSITION_SCALE_SPEED_OUT)
	A0_8._y_interpolator = Interpolator:new(A0_8._y, tweak_data.player.hud.RETICULE_CONTROL_TRANSITION_SCALE_SPEED_OUT)
	A0_8._alpha_interpolator = Interpolator:new(A0_8._alpha, tweak_data.player.hud.RETICULE_CONTROL_TRANSITION_FADE_SPEED_OUT)
	A0_8._alpha_interpolator:set_target(0)
end
function ProjectileWeaponReticulePieceMoveOutState.update(A0_9, A1_10)
	local L2_11, L3_12, L4_13
	L2_11 = A0_9._reticule_piece
	L3_12 = L2_11
	L2_11 = L2_11.get_start_positions
	L3_12 = L2_11(L3_12)
	A0_9._end_y = L3_12
	A0_9._end_x = L2_11
	L2_11 = A0_9._x_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.set_target
	L4_13 = A0_9._end_x
	L2_11(L3_12, L4_13)
	L2_11 = A0_9._y_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.set_target
	L4_13 = A0_9._end_y
	L2_11(L3_12, L4_13)
	L2_11 = A0_9._x_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.update
	L4_13 = A1_10
	L2_11(L3_12, L4_13)
	L2_11 = A0_9._y_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.update
	L4_13 = A1_10
	L2_11(L3_12, L4_13)
	L2_11 = A0_9._alpha_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.update
	L4_13 = A1_10
	L2_11(L3_12, L4_13)
	L2_11 = A0_9._x_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.value
	L2_11 = L2_11(L3_12)
	L3_12 = A0_9._y_interpolator
	L4_13 = L3_12
	L3_12 = L3_12.value
	L3_12 = L3_12(L4_13)
	L4_13 = A0_9._alpha_interpolator
	L4_13 = L4_13.value
	L4_13 = L4_13(L4_13)
	A0_9._reticule_piece:set_position(L2_11, L3_12)
	A0_9._reticule_piece:set_alpha(L4_13)
end
function ProjectileWeaponReticulePieceMoveOutState.transition(A0_14)
	if A0_14._reticule_piece:wants_to_move_in() then
		return ProjectileWeaponReticulePieceMoveInState
	end
end
