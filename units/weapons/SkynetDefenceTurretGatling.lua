require("projectile/InstantBulletSpawner")
if not SkynetDefenceTurretGatling then
	SkynetDefenceTurretGatling = class(BikerGatling)
end
SkynetDefenceTurretGatling.init = function(l_1_0, l_1_1)
	PlayerBaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._enabled = false
	l_1_0._fire_sound_instance = nil
	local l_1_2 = "rp_empty"
	local l_1_3 = WeaponUtilities.sound_objects(l_1_0._unit, l_1_0._sound_prefix, l_1_0._sound_variant, l_1_0._sound_bank, l_1_0._is_once_sound, l_1_2)
	l_1_0._fire_end_sound_object = l_1_0._unit
	l_1_0._fire_sound_object = l_1_3
	l_1_3 = l_1_0._unit
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._wdata = l_1_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3._max_dispersion = l_1_0._max_dispersion
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3._min_dispersion = l_1_0._min_dispersion
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_1_3 then
		l_1_3(l_1_3, "MINIGUN_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, l_1_0._shoot_event_visible_range, l_1_0._shoot_event_sound_level, l_1_0._shoot_event_sound_level_reference_distance)
	end
	l_1_0._fire_sensory_event_handle = nil
	l_1_0._rpm = 0
	l_1_0._rpm_increase = 0
	l_1_0._rpm_decrease = 0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_0)
	l_1_0._bullet_tracers, l_1_3 = l_1_3, {}
	l_1_0._bullets_fired = 0
	l_1_3 = managers
	l_1_3 = l_1_3.action_event
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._event_emitter = l_1_3
end

SkynetDefenceTurretGatling.set_fire_object = function(l_2_0, l_2_1, l_2_2)
	l_2_0._obj_fire = l_2_1:get_object(l_2_2)
	assert(l_2_0._obj_fire)
	if l_2_0._projectile_spawner_class and l_2_0._projectile_spawner_class ~= "" then
		l_2_0._projectile_spawner = World:spawn_unit(l_2_0._projectile_spawner_class, l_2_0._unit:position(), l_2_0._unit:rotation())
		l_2_0._unit:link(l_2_0._obj_fire, l_2_0._projectile_spawner, l_2_0._projectile_spawner:orientation_object():name())
	end
	if l_2_0._projectile_spawner_class_alt and l_2_0._projectile_spawner_class_alt ~= "" then
		l_2_0._projectile_spawner_alt = World:spawn_unit(l_2_0._projectile_spawner_class_alt, l_2_0._unit:position(), l_2_0._unit:rotation())
		l_2_0._unit:link(l_2_0._obj_fire, l_2_0._projectile_spawner_alt, l_2_0._projectile_spawner_alt:orientation_object():name())
	end
	local l_2_3 = l_2_0._projectile_spawner:base()
	l_2_0._range = l_2_3._range
	l_2_0._slot_mask = managers.slot:get_mask(l_2_3._slot_mask)
end

SkynetDefenceTurretGatling.set_rotation_object = function(l_3_0, l_3_1)
	l_3_0._rotation_object = l_3_1
	assert(l_3_0._rotation_object)
	l_3_0._rotation_object_initial_local_rotation = l_3_0._rotation_object:new_local_rotation()
	l_3_0._rotation_object_angle = 0
end

SkynetDefenceTurretGatling._update_weapon_rotation = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._rpm / 60 * 360 * l_4_1
	l_4_0._rotation_object_angle = angle_constrain(l_4_0._rotation_object_angle + l_4_2)
	local l_4_3 = l_4_0._rotation_object
	local l_4_4 = l_4_3:rotation()
	l_4_3:new_set_local_rotation(l_4_0._rotation_object_initial_local_rotation + Rotation(Vector3(0, 1, 0), l_4_0._rotation_object_angle))
end

SkynetDefenceTurretGatling.destroy = function(l_5_0)
	BikerGatling.destroy(l_5_0)
end


