if not WeaponData then
	WeaponData = class()
end
WeaponData.init = function(l_1_0, l_1_1)
	l_1_0._clip_size = 0
	l_1_0._bullets_in_clip = 0
	l_1_0._max_ammo = 0
	l_1_0._ammo_pool = 0
	l_1_0._spread = 0
	l_1_0._dispersion_modifier = 0
	l_1_0._dispersion = 0
	l_1_0.miss_dispersion = 0
	l_1_0.fire_input = 0
	l_1_0.fire_trigger_threshold = 0.9
	l_1_0.fire_trigger_release_threshold = 0.89
	l_1_0.aim_target_position = Vector3(0, 0, 0)
	l_1_0.forced_semi_automatic_fire = false
	l_1_0._fire_start = false
	l_1_0._fire_end = false
	l_1_0._firing = false
	l_1_0._fire_enabled = false
	l_1_0._on_fire = false
	l_1_0._reload_ready = false
	l_1_0._reload_required = false
	l_1_0._reload_request = false
	l_1_0._range = 0
	l_1_0._can_aim = true
	l_1_0._overheat_anim = nil
	l_1_0._full_outline_weapon = false
end

WeaponData.bullets_in_clip = function(l_2_0)
	return l_2_0._bullets_in_clip
end

WeaponData.ammo_pool = function(l_3_0)
	return l_3_0._ammo_pool
end


