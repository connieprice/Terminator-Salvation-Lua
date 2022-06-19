require("projectile/InstantBulletSpawner")
require("units/weapons/GenericWeapon")
if not Mk19GrenadeLauncher then
	Mk19GrenadeLauncher = class(GenericWeapon)
end
Mk19GrenadeLauncher.init = function(l_1_0, l_1_1)
	GenericWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._firing = false
	l_1_0._enabled = false
	l_1_0._wdata = l_1_0._unit:weapon_data()
	l_1_0._wdata._max_dispersion = l_1_0._max_dispersion
	l_1_0._wdata._min_dispersion = l_1_0._min_dispersion
	if not managers.sensory_events:is_defined("T100WEAPON_SHOOT") then
		managers.sensory_events:define_event("T100WEAPON_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, l_1_0._shoot_event_visible_range, l_1_0._shoot_event_sound_level, l_1_0._shoot_event_sound_level_reference_distance)
	end
	l_1_0._is_rotating = false
	l_1_0:_init_sounds()
	l_1_0:_init_chute_offset()
end

Mk19GrenadeLauncher._init_chute_offset = function(l_2_0)
	l_2_0._chute_material = l_2_0._unit:material("mk19_grenadelauncher_chute_uvanim")
	l_2_0._max_chute_offset_v = 0.042
	local l_2_1 = 0.25
	local l_2_2 = l_2_0._max_chute_offset_v / l_2_1
	l_2_0._chute_offset_velocity = Vector3(0, l_2_2, 0)
end

Mk19GrenadeLauncher._init_sounds = function(l_3_0)
	l_3_0._sounds = {}
	l_3_0._sounds.rotation = Sound:make_bank("weapon_m2_sound", "turret_slide_loop")
	l_3_0._sounds.rotation:set_output(l_3_0._unit:get_object("rp_mk19_grenadelauncher_ring"))
end

Mk19GrenadeLauncher._start_sounds = function(l_4_0)
	if not l_4_0._sounds.rotation:is_playing() then
		l_4_0._sounds.rotation:set_control("gain_abs", 0)
		l_4_0._sounds.rotation:play()
	end
end

Mk19GrenadeLauncher.start_rotation = function(l_5_0)
	if not l_5_0._is_rotating then
		l_5_0._sounds.rotation:set_control_ramp("gain_abs", 0, 1, tweak_data.rail.vehicle.sound.turret.fade_in_time)
		l_5_0._is_rotating = true
	end
end

Mk19GrenadeLauncher.end_rotation = function(l_6_0)
	if l_6_0._is_rotating then
		l_6_0._sounds.rotation:set_control_ramp("gain_abs", 1, 0, tweak_data.rail.vehicle.sound.turret.fade_out_time)
		l_6_0._is_rotating = false
	end
end

Mk19GrenadeLauncher.report_damage = function(l_7_0, l_7_1, l_7_2)
	local l_7_3 = l_7_0._unit:turret():get_vehicle()
	if alive(l_7_3) then
		l_7_3:damage():damage_from_part(l_7_1, l_7_2)
	end
end

Mk19GrenadeLauncher.destroy = function(l_8_0)
	GenericWeapon.destroy(l_8_0)
end

Mk19GrenadeLauncher.update = function(l_9_0, l_9_1, l_9_2, l_9_3)
	l_9_0:_update_chute_uv_offset(l_9_3)
end

Mk19GrenadeLauncher._update_chute_uv_offset = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0._chute_material:get_variable("uv_offset")
	local l_10_3 = l_10_2 + l_10_1 * l_10_0._chute_offset_velocity
	if l_10_3.y <= l_10_0._max_chute_offset_v then
		l_10_0._chute_material:set_variable("uv_offset", l_10_3)
	end
end

Mk19GrenadeLauncher.fire = function(l_11_0, l_11_1)
	l_11_0._unit:anim_set_time("fire", 0)
	l_11_0._unit:anim_play("fire")
	if l_11_0._fire_effect then
		local l_11_2, l_11_3 = World:effect_manager():spawn, World:effect_manager()
		local l_11_4 = {}
		l_11_4.effect = l_11_0._fire_effect
		l_11_4.parent = l_11_0._unit:get_object("sound")
		l_11_4.normal = Vector3(0, 1, 0)
		l_11_4.force_synch = true
		l_11_2(l_11_3, l_11_4)
	end
	local l_11_5, l_11_6 = nil, nil
	l_11_0.target_dir = nil
	l_11_0._fire_time = l_11_1
	local l_11_7 = l_11_0._wdata.aim_target_position
	l_11_0.source_pos = l_11_0._obj_fire:position()
	l_11_6 = l_11_7 - l_11_0.source_pos:normalized()
	l_11_6 = VectorUtilities.angle_constraint_direction(l_11_6, l_11_0._obj_fire:rotation():y(), l_11_0._max_fire_object_and_aim_angle_diff)
	local l_11_8 = l_11_0._wdata
	l_11_0.target_dir = l_11_0:get_target_dir(l_11_0.source_pos, l_11_6, l_11_8)
	l_11_0.source_pos = l_11_0.source_pos + l_11_0.target_dir * 10
	local l_11_9 = Rotation(l_11_0.target_dir, l_11_0._obj_fire:rotation():z())
	l_11_0._event_emitter:unit_weapon_fire_change(l_11_0._unit, l_11_0.source_pos, l_11_9, l_11_0._projectile_spawner)
	if l_11_0._projectile_spawner then
		l_11_0._projectile_spawner:base():spawn_projectile(l_11_0._user_unit, l_11_0.source_pos, l_11_9)
	end
	l_11_0._chute_material:set_variable("uv_offset", Vector3(0, 0, 0))
end


