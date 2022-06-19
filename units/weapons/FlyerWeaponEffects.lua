if not FlyerWeaponEffects then
	FlyerWeaponEffects = class()
end
FlyerWeaponEffects.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._obj_fire = l_1_0._unit:orientation_object()
	l_1_0._fire_started = false
	if not managers.sensory_events:is_defined("FLYERWEAPON_SHOOT") then
		managers.sensory_events:define_event("FLYERWEAPON_SHOOT", managers.sensory_events.source_types.MACHINE_WEAPON_ID, tweak_data.sensory_events.weapons.DEFAULT_SHOOT_VISIBLE_RANGE, tweak_data.sensory_events.weapons.DEFAULT_SHOOT_SOUND_LEVEL, tweak_data.sensory_events.weapons.DEFAULT_SHOOT_SOUND_LEVEL_REFERENCE_DISTANCE)
	end
	l_1_0._fire_sound_instance = nil
	local l_1_2 = "rp_empty"
	l_1_0._fire_sound_instance = nil
	if l_1_0._num_sound_variants and l_1_0._num_sound_variants > 0 then
		l_1_0._sound_variant = "_" .. math.random(l_1_0._num_sound_variants)
	end
	local l_1_3 = WeaponUtilities.sound_objects(l_1_0._unit, l_1_0._sound_prefix, l_1_0._sound_variant, l_1_0._sound_bank, l_1_0._is_once_sound, l_1_2)
	l_1_0._fire_end_sound_object = l_1_0._unit
	l_1_0._fire_sound_object = l_1_3
	l_1_3 = managers
	l_1_3 = l_1_3.action_event
	l_1_3(l_1_3, l_1_0, l_1_1, l_1_1)
	l_1_0._bullets_fired = 0
	l_1_0._muzzleflash_rate = 2
end

FlyerWeaponEffects.destroy = function(l_2_0, l_2_1)
	managers.action_event:unregister_listener(l_2_0)
	if l_2_0._fire_sound_object and l_2_0._fire_sound_object:is_playing() then
		l_2_0._fire_sound_object:stop()
	end
	managers.sensory_events:destroy_continuous_event_handle(l_2_0._firing_event_handle)
end

FlyerWeaponEffects.unit_weapon_fire_start = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = assert
	l_3_3(l_3_2 == l_3_0._unit)
	l_3_3 = assert
	l_3_3(l_3_1._firing_event_handle == nil)
	l_3_3 = assert
	l_3_3(not l_3_0._fire_started)
	l_3_0._fire_started = true
	l_3_3 = managers
	l_3_3 = l_3_3.sensory_events
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_0._firing_event_handle = l_3_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_1._firing_event_handle = l_3_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_0._fire_sound_instance = l_3_3
	l_3_0._bullets_fired = 0
end

FlyerWeaponEffects.unit_weapon_fire_change = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5)
	local l_4_6 = assert
	l_4_6(l_4_0._unit == l_4_2)
	l_4_6 = assert
	l_4_6(l_4_0._fire_started)
	l_4_6 = l_4_0._bullets_fired
	l_4_6 = l_4_6 % l_4_0._muzzleflash_rate
	if l_4_6 == 0 then
		local l_4_9, l_4_10 = World:effect_manager():spawn, World:effect_manager()
		local l_4_11 = {}
		l_4_11.effect = l_4_0._fire_effect_name
		l_4_11.parent = l_4_5:orientation_object()
		l_4_11.normal = Vector3(0, 0, 1)
		l_4_11.force_synch = true
		l_4_9(l_4_10, l_4_11)
	end
	l_4_0._bullets_fired = l_4_0._bullets_fired + 1
end

FlyerWeaponEffects.unit_weapon_fire_stop = function(l_5_0, l_5_1)
	local l_5_2 = assert
	l_5_2(l_5_1._firing_event_handle == l_5_0._firing_event_handle)
	l_5_2 = assert
	l_5_2(l_5_0._fire_started)
	l_5_0._fire_started = false
	l_5_2 = managers
	l_5_2 = l_5_2.sensory_events
	l_5_2(l_5_2, l_5_0._firing_event_handle)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_5_2 == false and l_5_2 and l_5_2 then
		l_5_2(l_5_2, "crossfade_with", l_5_0._fire_sound_instance, "crossfade_time", 0)
	end
end


