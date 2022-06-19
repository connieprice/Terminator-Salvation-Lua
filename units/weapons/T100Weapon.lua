require("units/weapons/WeaponUtilities")
require("projectile/InstantBulletSpawner")
require("units/weapons/WeaponUtilities")
require("shared/VectorUtilities")
if not T100Weapon then
	T100Weapon = class(PlayerBaseWeapon)
end
T100Weapon.init = function(l_1_0, l_1_1)
	PlayerBaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._enabled = false
	l_1_0._last_fire_input = 0
	l_1_0._obj_fire = l_1_0._unit:orientation_object()
	l_1_0._fire_sound_instance = nil
	local l_1_2 = "rp_empty"
	l_1_0._fire_sound_instance = nil
	local l_1_3 = WeaponUtilities.sound_objects(l_1_0._unit, l_1_0._sound_prefix, l_1_0._sound_variant, l_1_0._sound_bank, l_1_0._is_once_sound, l_1_2)
	l_1_0._fire_end_sound_object = l_1_0._unit
	l_1_0._fire_sound_object = l_1_3
	l_1_3 = l_1_0._unit
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._wdata = l_1_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3._fire_enabled = true
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._projectile_spawner = l_1_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_3, l_1_0._obj_fire:name(), l_1_0._projectile_spawner, l_1_0._projectile_spawner:orientation_object():name())
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_1_3 then
		l_1_3(l_1_3, "T100WEAPON_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, l_1_0._shoot_event_visible_range, l_1_0._shoot_event_sound_level, l_1_0._shoot_event_sound_level_reference_distance)
	end
	l_1_0._firing_event_handle = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._muzzle_rotation = l_1_3
	l_1_0._sound_enabled = true
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._event_emitter = l_1_3
	l_1_0._sync_muzzle_flash_effect = false
	l_1_0._bullets_fired = 0
	l_1_0._muzzleflash_rate = 2
end

T100Weapon.destroy = function(l_2_0)
	l_2_0._unit = nil
	if alive(l_2_0._projectile_spawner) then
		l_2_0._projectile_spawner:set_slot(0)
	end
	l_2_0._projectile_spawner = nil
	managers.sensory_events:destroy_continuous_event_handle(l_2_0._firing_event_handle)
	if l_2_0._fire_sound_object and l_2_0._fire_sound_object:is_playing() then
		l_2_0._fire_sound_object:stop()
	end
end

T100Weapon.setup = function(l_3_0, l_3_1)
	PlayerBaseWeapon.setup(l_3_0, l_3_1)
end

T100Weapon.enable = function(l_4_0)
	l_4_0:set_enabled(true)
end

T100Weapon.disable = function(l_5_0)
	l_5_0:set_enabled(false)
end

T100Weapon.set_enabled = function(l_6_0, l_6_1)
	l_6_0._enabled = l_6_1
	l_6_0._unit:set_extension_update_enabled("base", l_6_1)
end

T100Weapon.fire_start = function(l_7_0, l_7_1)
	l_7_0._firing_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.T100WEAPON_SHOOT_ID, l_7_0._projectile_spawner)
	if l_7_0._fire_sound_object and l_7_0._sound_enabled then
		l_7_0._fire_sound_instance = l_7_0._fire_sound_object:play("offset", 0)
	end
	l_7_0._event_emitter:unit_weapon_fire_start(l_7_0._unit)
	l_7_0._bullets_fired = 0
end

T100Weapon.fire_end = function(l_8_0, l_8_1)
	managers.sensory_events:end_continuous_event(l_8_0._firing_event_handle)
	if l_8_0._is_once_sound == false and l_8_0._fire_end_sound_object and l_8_0._fire_sound_instance then
		l_8_0._fire_end_sound_object:play("crossfade_with", l_8_0._fire_sound_instance, "crossfade_time", 0)
	end
	l_8_0._event_emitter:unit_weapon_fire_stop(l_8_0._unit)
end

T100Weapon.fire = function(l_9_0, l_9_1)
	local l_9_2 = l_9_0._obj_fire:rotation() * l_9_0._muzzle_rotation
	local l_9_3 = l_9_0._bullets_fired % l_9_0._muzzleflash_rate
	if l_9_3 == 0 then
		local l_9_4, l_9_5 = World:effect_manager():spawn, World:effect_manager()
		local l_9_6 = {}
		l_9_6.effect = "weapon_t100"
		l_9_6.position = l_9_0._obj_fire:position()
		l_9_6.rotation = l_9_2
		l_9_6.force_synch = l_9_0._sync_muzzle_flash_effect
		l_9_4(l_9_5, l_9_6)
	end
	l_9_0._bullets_fired = l_9_0._bullets_fired + 1
	local l_9_7 = l_9_0._obj_fire
	local l_9_8 = l_9_7:position()
	local l_9_9 = (l_9_7:rotation())
	local l_9_10, l_9_11, l_9_12 = nil, nil, nil
	local l_9_13 = l_9_0._wdata
	local l_9_14 = l_9_13.aim_target_position
	l_9_11 = l_9_14 - l_9_8:normalized()
	l_9_11 = VectorUtilities.angle_constraint_direction(l_9_11, l_9_9:y(), l_9_0._max_fire_object_and_aim_angle_diff)
	l_9_12 = WeaponUtilities.elliptical_dispersion(l_9_11, l_9_13.miss_dispersion, l_9_13._dispersion, 2)
	local l_9_15 = Rotation(l_9_12, l_9_9:z())
	l_9_0._projectile_spawner:base():spawn_projectile(l_9_0._user_unit, l_9_8, l_9_15)
	l_9_0._event_emitter:unit_weapon_fire_change(l_9_0._unit, l_9_8, l_9_15, l_9_0._projectile_spawner)
end

T100Weapon.set_sound_enabled = function(l_10_0, l_10_1)
	l_10_0._sound_enabled = l_10_1
end


