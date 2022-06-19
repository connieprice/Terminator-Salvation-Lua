require("projectile/InstantBulletSpawner")
SkynetDefenceTurretGatling = SkynetDefenceTurretGatling or class(BikerGatling)
function SkynetDefenceTurretGatling.init(A0_0, A1_1)
	local L2_2
	L2_2 = PlayerBaseWeapon
	L2_2 = L2_2.init
	L2_2(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._enabled = false
	A0_0._fire_sound_instance = nil
	L2_2 = "rp_empty"
	A0_0._fire_sound_object, A0_0._fire_end_sound_object = WeaponUtilities.sound_objects(A0_0._unit, A0_0._sound_prefix, A0_0._sound_variant, A0_0._sound_bank, A0_0._is_once_sound, L2_2)
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._max_dispersion = A0_0._max_dispersion
	A0_0._wdata._min_dispersion = A0_0._min_dispersion
	if not managers.sensory_events:is_defined("MINIGUN_SHOOT") then
		managers.sensory_events:define_event("MINIGUN_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, A0_0._shoot_event_visible_range, A0_0._shoot_event_sound_level, A0_0._shoot_event_sound_level_reference_distance)
	end
	A0_0._fire_sensory_event_handle = nil
	A0_0._rpm = 0
	A0_0._rpm_increase = 0
	A0_0._rpm_decrease = 0
	A0_0:_setup_sounds()
	A0_0._bullet_tracers = {}
	A0_0._bullets_fired = 0
	A0_0._event_emitter = managers.action_event:create_emitter(A1_1)
end
function SkynetDefenceTurretGatling.set_fire_object(A0_3, A1_4, A2_5)
	A0_3._obj_fire = A1_4:get_object(A2_5)
	assert(A0_3._obj_fire)
	if A0_3._projectile_spawner_class and A0_3._projectile_spawner_class ~= "" then
		A0_3._projectile_spawner = World:spawn_unit(A0_3._projectile_spawner_class, A0_3._unit:position(), A0_3._unit:rotation())
		A0_3._unit:link(A0_3._obj_fire, A0_3._projectile_spawner, A0_3._projectile_spawner:orientation_object():name())
	end
	if A0_3._projectile_spawner_class_alt and A0_3._projectile_spawner_class_alt ~= "" then
		A0_3._projectile_spawner_alt = World:spawn_unit(A0_3._projectile_spawner_class_alt, A0_3._unit:position(), A0_3._unit:rotation())
		A0_3._unit:link(A0_3._obj_fire, A0_3._projectile_spawner_alt, A0_3._projectile_spawner_alt:orientation_object():name())
	end
	A0_3._range = A0_3._projectile_spawner:base()._range
	A0_3._slot_mask = managers.slot:get_mask(A0_3._projectile_spawner:base()._slot_mask)
end
function SkynetDefenceTurretGatling.set_rotation_object(A0_6, A1_7)
	A0_6._rotation_object = A1_7
	assert(A0_6._rotation_object)
	A0_6._rotation_object_initial_local_rotation = A0_6._rotation_object:new_local_rotation()
	A0_6._rotation_object_angle = 0
end
function SkynetDefenceTurretGatling._update_weapon_rotation(A0_8, A1_9)
	local L2_10
	L2_10 = A0_8._rpm
	L2_10 = L2_10 / 60
	L2_10 = L2_10 * 360
	L2_10 = L2_10 * A1_9
	A0_8._rotation_object_angle = angle_constrain(A0_8._rotation_object_angle + L2_10)
	A0_8._rotation_object:new_set_local_rotation(A0_8._rotation_object_initial_local_rotation + Rotation(Vector3(0, 1, 0), A0_8._rotation_object_angle))
end
function SkynetDefenceTurretGatling.destroy(A0_11)
	BikerGatling.destroy(A0_11)
end
