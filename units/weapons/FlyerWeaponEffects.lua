FlyerWeaponEffects = FlyerWeaponEffects or class()
function FlyerWeaponEffects.init(A0_0, A1_1)
	local L2_2
	A0_0._unit = A1_1
	L2_2 = A0_0._unit
	L2_2 = L2_2.orientation_object
	L2_2 = L2_2(L2_2)
	A0_0._obj_fire = L2_2
	A0_0._fire_started = false
	L2_2 = managers
	L2_2 = L2_2.sensory_events
	L2_2 = L2_2.is_defined
	L2_2 = L2_2(L2_2, "FLYERWEAPON_SHOOT")
	if not L2_2 then
		L2_2 = managers
		L2_2 = L2_2.sensory_events
		L2_2 = L2_2.define_event
		L2_2(L2_2, "FLYERWEAPON_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, tweak_data.sensory_events.weapons.DEFAULT_SHOOT_VISIBLE_RANGE, tweak_data.sensory_events.weapons.DEFAULT_SHOOT_SOUND_LEVEL, tweak_data.sensory_events.weapons.DEFAULT_SHOOT_SOUND_LEVEL_REFERENCE_DISTANCE)
	end
	A0_0._fire_sound_instance = nil
	L2_2 = "rp_empty"
	A0_0._fire_sound_instance = nil
	if A0_0._num_sound_variants and A0_0._num_sound_variants > 0 then
		A0_0._sound_variant = "_" .. math.random(A0_0._num_sound_variants)
	end
	A0_0._fire_sound_object, A0_0._fire_end_sound_object = WeaponUtilities.sound_objects(A0_0._unit, A0_0._sound_prefix, A0_0._sound_variant, A0_0._sound_bank, A0_0._is_once_sound, L2_2)
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
	A0_0._bullets_fired = 0
	A0_0._muzzleflash_rate = 2
end
function FlyerWeaponEffects.destroy(A0_3, A1_4)
	managers.action_event:unregister_listener(A0_3)
	if A0_3._fire_sound_object and A0_3._fire_sound_object:is_playing() then
		A0_3._fire_sound_object:stop()
	end
	managers.sensory_events:destroy_continuous_event_handle(A0_3._firing_event_handle)
end
function FlyerWeaponEffects.unit_weapon_fire_start(A0_5, A1_6, A2_7)
	assert(A2_7 == A0_5._unit)
	assert(A1_6._firing_event_handle == nil)
	assert(not A0_5._fire_started)
	A0_5._fire_started = true
	A0_5._firing_event_handle = managers.sensory_events:begin_continuous_event(managers.sensory_events.event_types.FLYERWEAPON_SHOOT_ID, A0_5._unit)
	A1_6._firing_event_handle = A0_5._firing_event_handle
	A0_5._fire_sound_instance = A0_5._fire_sound_object:play("offset", 0)
	A0_5._bullets_fired = 0
end
function FlyerWeaponEffects.unit_weapon_fire_change(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13)
	assert(A0_8._unit == A2_10)
	assert(A0_8._fire_started)
	if A0_8._bullets_fired % A0_8._muzzleflash_rate == 0 then
		World:effect_manager():spawn({
			effect = A0_8._fire_effect_name,
			parent = A5_13:orientation_object(),
			normal = Vector3(0, 0, 1),
			force_synch = true
		})
	end
	A0_8._bullets_fired = A0_8._bullets_fired + 1
end
function FlyerWeaponEffects.unit_weapon_fire_stop(A0_14, A1_15)
	assert(A1_15._firing_event_handle == A0_14._firing_event_handle)
	assert(A0_14._fire_started)
	A0_14._fire_started = false
	managers.sensory_events:end_continuous_event(A0_14._firing_event_handle)
	if A0_14._is_once_sound == false and A0_14._fire_end_sound_object and A0_14._fire_sound_instance then
		A0_14._fire_end_sound_object:play("crossfade_with", A0_14._fire_sound_instance, "crossfade_time", 0)
	end
end
