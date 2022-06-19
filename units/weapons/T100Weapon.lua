require("units/weapons/WeaponUtilities")
require("projectile/InstantBulletSpawner")
require("units/weapons/WeaponUtilities")
require("shared/VectorUtilities")
T100Weapon = T100Weapon or class(PlayerBaseWeapon)
function T100Weapon.init(A0_0, A1_1)
	local L2_2
	L2_2 = PlayerBaseWeapon
	L2_2 = L2_2.init
	L2_2(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._enabled = false
	A0_0._last_fire_input = 0
	L2_2 = A0_0._unit
	L2_2 = L2_2.orientation_object
	L2_2 = L2_2(L2_2)
	A0_0._obj_fire = L2_2
	A0_0._fire_sound_instance = nil
	L2_2 = "rp_empty"
	A0_0._fire_sound_instance = nil
	A0_0._fire_sound_object, A0_0._fire_end_sound_object = WeaponUtilities.sound_objects(A0_0._unit, A0_0._sound_prefix, A0_0._sound_variant, A0_0._sound_bank, A0_0._is_once_sound, L2_2)
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._fire_enabled = true
	A0_0._projectile_spawner = World:spawn_unit(A0_0._projectile_spawner_class, A0_0._unit:position(), A0_0._unit:rotation())
	A0_0._unit:link(A0_0._obj_fire:name(), A0_0._projectile_spawner, A0_0._projectile_spawner:orientation_object():name())
	if not managers.sensory_events:is_defined("T100WEAPON_SHOOT") then
		managers.sensory_events:define_event("T100WEAPON_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, A0_0._shoot_event_visible_range, A0_0._shoot_event_sound_level, A0_0._shoot_event_sound_level_reference_distance)
	end
	A0_0._firing_event_handle = nil
	A0_0._muzzle_rotation = Rotation(90, 0, 180)
	A0_0._sound_enabled = true
	A0_0._event_emitter = managers.action_event:create_emitter(A1_1)
	A0_0._sync_muzzle_flash_effect = false
	A0_0._bullets_fired = 0
	A0_0._muzzleflash_rate = 2
end
function T100Weapon.destroy(A0_3)
	A0_3._unit = nil
	if alive(A0_3._projectile_spawner) then
		A0_3._projectile_spawner:set_slot(0)
	end
	A0_3._projectile_spawner = nil
	managers.sensory_events:destroy_continuous_event_handle(A0_3._firing_event_handle)
	if A0_3._fire_sound_object and A0_3._fire_sound_object:is_playing() then
		A0_3._fire_sound_object:stop()
	end
end
function T100Weapon.setup(A0_4, A1_5)
	PlayerBaseWeapon.setup(A0_4, A1_5)
end
function T100Weapon.enable(A0_6)
	A0_6:set_enabled(true)
end
function T100Weapon.disable(A0_7)
	A0_7:set_enabled(false)
end
function T100Weapon.set_enabled(A0_8, A1_9)
	A0_8._enabled = A1_9
	A0_8._unit:set_extension_update_enabled("base", A1_9)
end
function T100Weapon.fire_start(A0_10, A1_11)
	A0_10._firing_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.T100WEAPON_SHOOT_ID, A0_10._projectile_spawner)
	if A0_10._fire_sound_object and A0_10._sound_enabled then
		A0_10._fire_sound_instance = A0_10._fire_sound_object:play("offset", 0)
	end
	A0_10._event_emitter:unit_weapon_fire_start(A0_10._unit)
	A0_10._bullets_fired = 0
end
function T100Weapon.fire_end(A0_12, A1_13)
	managers.sensory_events:end_continuous_event(A0_12._firing_event_handle)
	if A0_12._is_once_sound == false and A0_12._fire_end_sound_object and A0_12._fire_sound_instance then
		A0_12._fire_end_sound_object:play("crossfade_with", A0_12._fire_sound_instance, "crossfade_time", 0)
	end
	A0_12._event_emitter:unit_weapon_fire_stop(A0_12._unit)
end
function T100Weapon.fire(A0_14, A1_15)
	local L2_16, L3_17, L4_18, L5_19, L6_20, L7_21, L8_22, L9_23, L10_24, L11_25, L12_26
	L2_16 = A0_14._obj_fire
	L3_17 = L2_16
	L2_16 = L2_16.rotation
	L2_16 = L2_16(L3_17)
	L3_17 = A0_14._muzzle_rotation
	L2_16 = L2_16 * L3_17
	L3_17 = A0_14._bullets_fired
	L4_18 = A0_14._muzzleflash_rate
	L3_17 = L3_17 % L4_18
	if L3_17 == 0 then
		L4_18 = World
		L5_19 = L4_18
		L4_18 = L4_18.effect_manager
		L4_18 = L4_18(L5_19)
		L5_19 = L4_18
		L4_18 = L4_18.spawn
		L6_20 = {}
		L6_20.effect = "weapon_t100"
		L7_21 = A0_14._obj_fire
		L8_22 = L7_21
		L7_21 = L7_21.position
		L7_21 = L7_21(L8_22)
		L6_20.position = L7_21
		L6_20.rotation = L2_16
		L7_21 = A0_14._sync_muzzle_flash_effect
		L6_20.force_synch = L7_21
		L4_18(L5_19, L6_20)
	end
	L4_18 = A0_14._bullets_fired
	L4_18 = L4_18 + 1
	A0_14._bullets_fired = L4_18
	L4_18 = A0_14._obj_fire
	L6_20 = L4_18
	L5_19 = L4_18.position
	L5_19 = L5_19(L6_20)
	L7_21 = L4_18
	L6_20 = L4_18.rotation
	L6_20 = L6_20(L7_21)
	L7_21, L8_22, L9_23 = nil, nil, nil
	L10_24 = A0_14._wdata
	L11_25 = L10_24.aim_target_position
	L12_26 = L11_25 - L5_19
	L12_26 = L12_26.normalized
	L12_26 = L12_26(L12_26)
	L8_22 = L12_26
	L12_26 = VectorUtilities
	L12_26 = L12_26.angle_constraint_direction
	L12_26 = L12_26(L8_22, L6_20:y(), A0_14._max_fire_object_and_aim_angle_diff)
	L8_22 = L12_26
	L12_26 = WeaponUtilities
	L12_26 = L12_26.elliptical_dispersion
	L12_26 = L12_26(L8_22, L10_24.miss_dispersion, L10_24._dispersion, 2)
	L9_23 = L12_26
	L12_26 = Rotation
	L12_26 = L12_26(L9_23, L6_20:z())
	A0_14._projectile_spawner:base():spawn_projectile(A0_14._user_unit, L5_19, L12_26)
	A0_14._event_emitter:unit_weapon_fire_change(A0_14._unit, L5_19, L12_26, A0_14._projectile_spawner)
end
function T100Weapon.set_sound_enabled(A0_27, A1_28)
	A0_27._sound_enabled = A1_28
end
