WeaponData = WeaponData or class()
function WeaponData.init(A0_0, A1_1)
	A0_0._clip_size = 0
	A0_0._bullets_in_clip = 0
	A0_0._max_ammo = 0
	A0_0._ammo_pool = 0
	A0_0._spread = 0
	A0_0._dispersion_modifier = 0
	A0_0._dispersion = 0
	A0_0.miss_dispersion = 0
	A0_0.fire_input = 0
	A0_0.fire_trigger_threshold = 0.9
	A0_0.fire_trigger_release_threshold = 0.89
	A0_0.aim_target_position = Vector3(0, 0, 0)
	A0_0.forced_semi_automatic_fire = false
	A0_0._fire_start = false
	A0_0._fire_end = false
	A0_0._firing = false
	A0_0._fire_enabled = false
	A0_0._on_fire = false
	A0_0._reload_ready = false
	A0_0._reload_required = false
	A0_0._reload_request = false
	A0_0._range = 0
	A0_0._can_aim = true
	A0_0._overheat_anim = nil
	A0_0._full_outline_weapon = false
end
function WeaponData.bullets_in_clip(A0_2)
	local L1_3
	L1_3 = A0_2._bullets_in_clip
	return L1_3
end
function WeaponData.ammo_pool(A0_4)
	local L1_5
	L1_5 = A0_4._ammo_pool
	return L1_5
end
