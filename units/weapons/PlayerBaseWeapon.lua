if not PlayerBaseWeapon then
	PlayerBaseWeapon = class(BaseWeapon)
end
PlayerBaseWeapon.init = function(l_1_0, l_1_1)
	BaseWeapon.init(l_1_0, l_1_1)
	l_1_0._zoom_enabled = false
end

PlayerBaseWeapon.set_enabled = function(l_2_0, l_2_1)
	BaseWeapon.set_enabled(l_2_0, l_2_1)
	if l_2_0._zoom_enabled and not l_2_1 then
		l_2_0:set_zoom_enabled(false)
	end
end

PlayerBaseWeapon.set_equiped = function(l_3_0, l_3_1)
	BaseWeapon.set_equiped(l_3_0, l_3_1)
	if l_3_0._zoom_enabled and not l_3_1 then
		l_3_0:set_zoom_enabled(false)
	end
end

PlayerBaseWeapon.can_zoom = function(l_4_0)
	if l_4_0._unit:weapon_data()._zoom_enabled then
		return l_4_0._equiped
	end
end

PlayerBaseWeapon.set_zoom_enabled = function(l_5_0, l_5_1)
	l_5_0._zoom_enabled = l_5_1
	if l_5_1 then
		l_5_0._hint_distance = l_5_0._weapon_tweak_data.RETICLE_HINT_DIST_ZOOM
	else
		l_5_0._hint_distance = l_5_0._weapon_tweak_data.RETICLE_HINT_DIST_NORMAL
	end
	l_5_0._user_unit:hud():set_sniper_mode(l_5_1)
end

PlayerBaseWeapon.zoom_enabled = function(l_6_0)
	return l_6_0._zoom_enabled
end

PlayerBaseWeapon.hint_distance = function(l_7_0)
	return l_7_0._hint_distance
end

PlayerBaseWeapon.auto_aim_weapon = function(l_8_0)
	return true
end

PlayerBaseWeapon.show_crosshair = function(l_9_0)
	return true
end

PlayerBaseWeapon.set_body_enabled = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = l_10_1:body(0)
	if l_10_3 and l_10_3:is_body() and l_10_3:enabled() ~= l_10_2 then
		l_10_3:set_enabled(l_10_2)
		l_10_3:set_collisions_enabled(l_10_2)
		l_10_3:set_collides_with_mover(l_10_2)
		if l_10_2 then
			l_10_3:set_dynamic()
		end
	else
		l_10_3:set_keyframed()
	end
end

PlayerBaseWeapon.weapon_stocked = function(l_11_0, l_11_1)
	local l_11_2 = l_11_0._stock_anim
	if l_11_2 then
		local l_11_3 = 0
		local l_11_4 = -1
		if l_11_1 then
			l_11_3 = l_11_0._unit:anim_length(l_11_2)
			l_11_4 = 1
		end
		l_11_0._unit:anim_set_time(l_11_2, l_11_3)
		l_11_0._unit:anim_play(l_11_2, l_11_4)
	end
	l_11_0:set_enabled(not l_11_1)
end

PlayerBaseWeapon.setup = function(l_12_0, l_12_1)
	BaseWeapon.setup(l_12_0, l_12_1)
end


