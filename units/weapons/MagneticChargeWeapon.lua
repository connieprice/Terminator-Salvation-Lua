if not MagneticChargeWeapon then
	MagneticChargeWeapon = class(PlayerBaseWeapon)
end
MagneticChargeWeapon.init = function(l_1_0, l_1_1)
	PlayerBaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._enabled = false
	l_1_0._obj_fire = l_1_0._unit:get_object("rp_charge_magnetic")
	l_1_0._wdata = l_1_0._unit:weapon_data()
	l_1_0._wdata._max_dispersion = l_1_0._max_dispersion
	l_1_0._wdata._min_dispersion = l_1_0._min_dispersion
	l_1_0._wdata._fire_enabled = true
	l_1_0._fire_sound_instance = nil
	l_1_0._fire_end_sound_instance = nil
	if l_1_0._projectile_spawner_class and l_1_0._projectile_spawner_class ~= "" then
		l_1_0._projectile_spawner = World:spawn_unit(l_1_0._projectile_spawner_class, l_1_0._unit:position(), l_1_0._unit:rotation())
		l_1_0._unit:link("fire", l_1_0._projectile_spawner, l_1_0._projectile_spawner:orientation_object():name())
	end
	if l_1_0._projectile_spawner_class_alt and l_1_0._projectile_spawner_class_alt ~= "" then
		l_1_0._projectile_spawner_alt = World:spawn_unit(l_1_0._projectile_spawner_class_alt, l_1_0._unit:position(), l_1_0._unit:rotation())
		l_1_0._unit:link("fire", l_1_0._projectile_spawner_alt, l_1_0._projectile_spawner_alt:orientation_object():name())
	end
	if not managers.sensory_events:is_defined("MAGNETIC_CHARGE_WEAPON_SHOOT") then
		managers.sensory_events:define_event("MAGNETIC_CHARGE_WEAPON_SHOOT", managers.sensory_events.source_types.HUMAN_WEAPON_ID, l_1_0._shoot_event_visible_range, l_1_0._shoot_event_sound_level, l_1_0._shoot_event_sound_level_reference_distance)
	end
	l_1_0._fire_sensory_event_handle = nil
end

MagneticChargeWeapon.destroy = function(l_2_0)
	managers.sensory_events:destroy_continuous_event_handle(l_2_0._fire_sensory_event_handle)
	l_2_0._unit = nil
	if alive(l_2_0._projectile_spawner) then
		l_2_0._projectile_spawner:set_slot(0)
	end
	l_2_0._projectile_spawner = nil
	if alive(l_2_0._projectile_spawner_alt) then
		l_2_0._projectile_spawner_alt:set_slot(0)
	end
	l_2_0._projectile_spawner_alt = nil
	if l_2_0._fire_sound_instance and l_2_0._fire_sound_instance:is_playing() then
		l_2_0._fire_sound_instance:stop()
	end
end

MagneticChargeWeapon.setup = function(l_3_0, l_3_1)
	PlayerBaseWeapon.setup(l_3_0, l_3_1)
end

MagneticChargeWeapon.enable = function(l_4_0)
	l_4_0:set_enabled(true)
end

MagneticChargeWeapon.disable = function(l_5_0)
	l_5_0:set_enabled(false)
end

MagneticChargeWeapon.set_enabled = function(l_6_0, l_6_1)
	l_6_0._enabled = l_6_1
	l_6_0._unit:set_extension_update_enabled("base", l_6_1)
end

MagneticChargeWeapon.on_zoom_aim = function(l_7_0, l_7_1)
	if l_7_1 then
		l_7_0._unit:play("aiming_on")
	else
		l_7_0._unit:play("aiming_off")
	end
end

MagneticChargeWeapon.fire_start = function(l_8_0, l_8_1)
	l_8_0._fire_sensory_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.MAGNETIC_CHARGE_WEAPON_SHOOT_ID, l_8_0._unit)
	if l_8_0._wdata._dispersion_modifier >= 1 then
		l_8_0._unit:play(l_8_0._sound_prefix .. "shot_ezsqz")
		l_8_0._fire_sound_instance = nil
		l_8_0._fire_end_sound_instance = nil
	else
		l_8_0._fire_sound_instance = l_8_0._unit:play(l_8_0._sound_prefix .. "shot")
	end
end

MagneticChargeWeapon.fire_end = function(l_9_0, l_9_1)
	managers.sensory_events:end_continuous_event(l_9_0._fire_sensory_event_handle)
	if l_9_0._fire_sound_instance and l_9_0._fire_sound_instance:is_playing() then
		l_9_0._fire_sound_instance:stop()
	end
	local l_9_2 = l_9_0._sound_prefix .. "shot_end"
	assert(l_9_0._unit:has_cue(l_9_2))
	l_9_0._fire_end_sound_instance = l_9_0._unit:play(l_9_2)
end

MagneticChargeWeapon.fire = function(l_10_0, l_10_1)
	l_10_0._unit:anim_set_time("fire", 0)
	l_10_0._unit:anim_play("fire")
	local l_10_2, l_10_3, l_10_4 = nil, nil, nil
	l_10_0._fire_time = l_10_1
	local l_10_5 = l_10_0._wdata.aim_target_position
	local l_10_6 = l_10_0._max_dispersion + (l_10_0._min_dispersion - l_10_0._max_dispersion) * l_10_0._wdata._dispersion_modifier
	l_10_3 = l_10_5 - l_10_0._obj_fire:position():normalized()
	l_10_4 = l_10_3:spread(l_10_6):normalized()
	local l_10_7 = l_10_0._obj_fire:position() + l_10_4 * 10
	if l_10_0._projectile_spawner then
		l_10_0._projectile_spawner:base():spawn_projectile(l_10_0._user_unit, l_10_7, Rotation(l_10_4, l_10_0._obj_fire:rotation():z()))
	end
end

MagneticChargeWeapon.drop = function(l_11_0)
	l_11_0:disable()
	l_11_0._unit:unlink()
	l_11_0._unit:body("main_body"):set_enabled(true)
end


