PlayerBaseWeapon = PlayerBaseWeapon or class(BaseWeapon)
function PlayerBaseWeapon.init(A0_0, A1_1)
	BaseWeapon.init(A0_0, A1_1)
	A0_0._zoom_enabled = false
end
function PlayerBaseWeapon.set_enabled(A0_2, A1_3)
	BaseWeapon.set_enabled(A0_2, A1_3)
	if A0_2._zoom_enabled and not A1_3 then
		A0_2:set_zoom_enabled(false)
	end
end
function PlayerBaseWeapon.set_equiped(A0_4, A1_5)
	BaseWeapon.set_equiped(A0_4, A1_5)
	if A0_4._zoom_enabled and not A1_5 then
		A0_4:set_zoom_enabled(false)
	end
end
function PlayerBaseWeapon.can_zoom(A0_6)
	return A0_6._unit:weapon_data()._zoom_enabled and A0_6._equiped
end
function PlayerBaseWeapon.set_zoom_enabled(A0_7, A1_8)
	A0_7._zoom_enabled = A1_8
	if A1_8 then
		A0_7._hint_distance = A0_7._weapon_tweak_data.RETICLE_HINT_DIST_ZOOM
	else
		A0_7._hint_distance = A0_7._weapon_tweak_data.RETICLE_HINT_DIST_NORMAL
	end
	A0_7._user_unit:hud():set_sniper_mode(A1_8)
end
function PlayerBaseWeapon.zoom_enabled(A0_9)
	local L1_10
	L1_10 = A0_9._zoom_enabled
	return L1_10
end
function PlayerBaseWeapon.hint_distance(A0_11)
	local L1_12
	L1_12 = A0_11._hint_distance
	return L1_12
end
function PlayerBaseWeapon.auto_aim_weapon(A0_13)
	local L1_14
	L1_14 = true
	return L1_14
end
function PlayerBaseWeapon.show_crosshair(A0_15)
	local L1_16
	L1_16 = true
	return L1_16
end
function PlayerBaseWeapon.set_body_enabled(A0_17, A1_18, A2_19)
	if A1_18:body(0) and A1_18:body(0):is_body() and A1_18:body(0):enabled() ~= A2_19 then
		A1_18:body(0):set_enabled(A2_19)
		A1_18:body(0):set_collisions_enabled(A2_19)
		A1_18:body(0):set_collides_with_mover(A2_19)
		if A2_19 then
			A1_18:body(0):set_dynamic()
		else
			A1_18:body(0):set_keyframed()
		end
	end
end
function PlayerBaseWeapon.weapon_stocked(A0_20, A1_21)
	local L2_22, L3_23, L4_24
	L2_22 = A0_20._stock_anim
	if L2_22 then
		L3_23 = 0
		L4_24 = -1
		if A1_21 then
			L3_23 = A0_20._unit:anim_length(L2_22)
			L4_24 = 1
		end
		A0_20._unit:anim_set_time(L2_22, L3_23)
		A0_20._unit:anim_play(L2_22, L4_24)
	end
	L4_24 = A0_20
	L3_23 = A0_20.set_enabled
	L3_23(L4_24, not A1_21)
end
function PlayerBaseWeapon.setup(A0_25, A1_26)
	BaseWeapon.setup(A0_25, A1_26)
end
