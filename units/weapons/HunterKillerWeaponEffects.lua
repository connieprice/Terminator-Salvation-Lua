HunterKillerWeaponEffects = HunterKillerWeaponEffects or class()
function HunterKillerWeaponEffects.init(A0_0, A1_1)
	local L2_2
	A0_0._unit = A1_1
	L2_2 = A0_0._unit
	L2_2 = L2_2.orientation_object
	L2_2 = L2_2(L2_2)
	A0_0._obj_fire = L2_2
	A0_0._fire_started = false
	L2_2 = "rp_empty"
	A0_0._fire_sound_instance = nil
	A0_0._fire_sound_object, A0_0._fire_end_sound_object = WeaponUtilities.sound_objects(A0_0._unit, A0_0._sound_prefix, A0_0._sound_variant, A0_0._sound_bank, A0_0._is_once_sound, L2_2)
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
	A0_0._listener_registered = true
end
function HunterKillerWeaponEffects.destroy(A0_3, A1_4)
	if A0_3._fire_sound_object and A0_3._fire_sound_object:is_playing() then
		A0_3._fire_sound_object:stop()
	end
	if A0_3._listener_registered then
		A0_3:_unregister_listener()
	end
end
function HunterKillerWeaponEffects.unit_weapon_fire_start(A0_5, A1_6)
	local L2_7
	L2_7 = assert
	L2_7(not A0_5._fire_started)
	A0_5._fire_started = true
	L2_7 = A0_5._unit
	L2_7 = L2_7.base
	L2_7 = L2_7(L2_7)
	assert(L2_7)
	A1_6.base = L2_7
	A0_5._fire_sound_instance = A0_5._fire_sound_object:play("offset", 0)
end
function HunterKillerWeaponEffects.unit_weapon_fire_change(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13)
	assert(A0_8._fire_started)
	A0_8._fire_sound_instance = A0_8._fire_sound_object:play("offset", 0)
	World:effect_manager():spawn({
		effect = A0_8._fire_effect_name,
		parent = A5_13:orientation_object(),
		normal = Vector3(0, 0, 1),
		force_synch = false
	})
end
function HunterKillerWeaponEffects.unit_weapon_fire_stop(A0_14, A1_15)
	local L2_16
	L2_16 = assert
	L2_16(A0_14._fire_started)
	A0_14._fire_started = false
	L2_16 = A0_14._listener_registered
	if L2_16 then
		L2_16 = A1_15.base
		assert(L2_16)
		if #L2_16._projectile_spawners == #L2_16._disabled_projectile_spawners then
			A0_14:_unregister_listener()
		end
	end
end
function HunterKillerWeaponEffects._unregister_listener(A0_17)
	assert(A0_17._listener_registered)
	A0_17._listener_registered = false
	managers.action_event:unregister_listener(A0_17)
end
